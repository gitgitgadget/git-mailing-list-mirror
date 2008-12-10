From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] make sure packs to be replaced are closed beforehand
Date: Wed, 10 Dec 2008 08:37:27 +0100
Message-ID: <493F71B7.60804@viscovery.net>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com> <4923FE58.3090503@viscovery.net> <alpine.LFD.2.00.0811190753420.27509@xanadu.home> <81b0412b0811190534r4f71f981s53de415f79e56e25@mail.gmail.com> <49241AEF.1080808@viscovery.net> <alpine.LFD.2.00.0811190940480.27509@xanadu.home> <81b0412b0811260518o52adb107tbddafb324e7fd97b@mail.gmail.com> <alpine.LFD.2.00.0811260931030.14328@xanadu.home> <alpine.LFD.2.00.0812091414030.14328@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Dec 10 08:38:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAJen-0005PG-6q
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 08:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562AbYLJHhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 02:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754410AbYLJHhg
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 02:37:36 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:22526 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbYLJHhf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 02:37:35 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LAJdQ-0006nz-2m; Wed, 10 Dec 2008 08:37:28 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id BFACF4FB; Wed, 10 Dec 2008 08:37:27 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <alpine.LFD.2.00.0812091414030.14328@xanadu.home>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "lilzmailsa03.liwest.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Nicolas Pitre schrieb: > Especially on Windows where an opened
	file cannot be replaced, make > sure pack-objects always close packs it is
	about to replace. Even on > non Windows systems, this could save potential
	bad results if ever > objects were to be read from the new pack file using
	offset from the old > index. > > This should fix t5303 on Windows. ... >
	OK, here it is at last. Please confirm it works on Windows before Junio >
	merges it. [...] 
	Content analysis details:   (-1.4 points, 7.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102669>

Nicolas Pitre schrieb:
> Especially on Windows where an opened file cannot be replaced, make
> sure pack-objects always close packs it is about to replace. Even on
> non Windows systems, this could save potential bad results if ever
> objects were to be read from the new pack file using offset from the old
> index.
> 
> This should fix t5303 on Windows.
...
> OK, here it is at last.  Please confirm it works on Windows before Junio 
> merges it.

I can confirm that this patch fixes t5303 on Windows (MinGW).

-- Hannes
