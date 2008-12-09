From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] make sure packs to be replaced are closed beforehand
Date: Tue, 9 Dec 2008 20:33:30 +0100
Message-ID: <20081209193330.GA8877@blimp.localdomain>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com> <4923FE58.3090503@viscovery.net> <alpine.LFD.2.00.0811190753420.27509@xanadu.home> <81b0412b0811190534r4f71f981s53de415f79e56e25@mail.gmail.com> <49241AEF.1080808@viscovery.net> <alpine.LFD.2.00.0811190940480.27509@xanadu.home> <81b0412b0811260518o52adb107tbddafb324e7fd97b@mail.gmail.com> <alpine.LFD.2.00.0811260931030.14328@xanadu.home> <alpine.LFD.2.00.0812091414030.14328@xanadu.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Dec 09 20:35:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA8MN-0001qI-1m
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 20:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777AbYLITdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 14:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbYLITdt
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 14:33:49 -0500
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:64782 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569AbYLITds (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 14:33:48 -0500
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8AE81rRo=
Received: from tigra.home (Fab12.f.strato-dslnet.de [195.4.171.18])
	by post.strato.de (mrclete mo53) (RZmta 17.20)
	with ESMTP id 20538bkB9JVYb3 ; Tue, 9 Dec 2008 20:33:31 +0100 (MET)
Received: from blimp.localdomain (unknown [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id C81A6277C8;
	Tue,  9 Dec 2008 20:33:30 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 9B85936D27; Tue,  9 Dec 2008 20:33:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0812091414030.14328@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102650>

Nicolas Pitre, Tue, Dec 09, 2008 20:26:52 +0100:
> Especially on Windows where an opened file cannot be replaced, make
> sure pack-objects always close packs it is about to replace. Even on
> non Windows systems, this could save potential bad results if ever
> objects were to be read from the new pack file using offset from the old
> index.
> 
> This should fix t5303 on Windows.
> 
> Signed-off-by: Nicolas Pitre <nico@cam.org>
> ---
...
> OK, here it is at last.  Please confirm it works on Windows before Junio 
> merges it.
> 

Will do in about 16 hours.
