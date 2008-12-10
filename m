From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make sure packs to be replaced are closed beforehand
Date: Wed, 10 Dec 2008 00:27:14 -0800
Message-ID: <7vabb43065.fsf@gitster.siamese.dyndns.org>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com>
 <4923FE58.3090503@viscovery.net>
 <alpine.LFD.2.00.0811190753420.27509@xanadu.home>
 <81b0412b0811190534r4f71f981s53de415f79e56e25@mail.gmail.com>
 <49241AEF.1080808@viscovery.net>
 <alpine.LFD.2.00.0811190940480.27509@xanadu.home>
 <81b0412b0811260518o52adb107tbddafb324e7fd97b@mail.gmail.com>
 <alpine.LFD.2.00.0811260931030.14328@xanadu.home>
 <alpine.LFD.2.00.0812091414030.14328@xanadu.home>
 <493F71B7.60804@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Dec 10 09:28:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAKRD-0000jL-4Q
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 09:28:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421AbYLJI11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 03:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754410AbYLJI10
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 03:27:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58588 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272AbYLJI10 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 03:27:26 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D6AA859C2;
	Wed, 10 Dec 2008 03:27:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0B4FB859C0; Wed,
 10 Dec 2008 03:27:17 -0500 (EST)
In-Reply-To: <493F71B7.60804@viscovery.net> (Johannes Sixt's message of "Wed,
 10 Dec 2008 08:37:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5E55222C-C694-11DD-8680-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102671>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Nicolas Pitre schrieb:
>> Especially on Windows where an opened file cannot be replaced, make
>> sure pack-objects always close packs it is about to replace. Even on
>> non Windows systems, this could save potential bad results if ever
>> objects were to be read from the new pack file using offset from the old
>> index.
>> 
>> This should fix t5303 on Windows.
> ...
>> OK, here it is at last.  Please confirm it works on Windows before Junio 
>> merges it.
>
> I can confirm that this patch fixes t5303 on Windows (MinGW).

Thanks; it is a bit too late for tonight, but it will appear in tomorrow's
'master'.
