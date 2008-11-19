From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix handle leak in builtin-pack-objects
Date: Wed, 19 Nov 2008 14:06:53 +0100
Message-ID: <49240F6D.3030203@viscovery.net>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com> <4923FE58.3090503@viscovery.net> <alpine.LFD.2.00.0811190753420.27509@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Nov 19 14:08:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2mn1-0005cj-7z
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 14:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861AbYKSNHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 08:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752832AbYKSNHA
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 08:07:00 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:55713 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbYKSNG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 08:06:59 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L2mlh-0003jT-Hl; Wed, 19 Nov 2008 14:06:55 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 50FE769F; Wed, 19 Nov 2008 14:06:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.LFD.2.00.0811190753420.27509@xanadu.home>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101338>

Nicolas Pitre schrieb:
> On Wed, 19 Nov 2008, Johannes Sixt wrote:
> 
>> Alex Riesen schrieb:
>>> The opened packs seem to stay open forever.
>> In my MinGW port I have the patch below that avoids that t5303 fails
>> because of a pack file that remains open. (Open files cannot be replaced
>> on Windows.) I had hoped that your patch would help, but it does not.
>> Something else still keeps the pack file open. Can anything be done about
>> that?
>>
>> -- Hannes
>>
>> From: Johannes Sixt <j6t@kdbg.org>
>> Date: Mon, 17 Nov 2008 09:25:19 +0100
>> Subject: [PATCH] t5303: Do not overwrite an existing pack
>>
...
> Acked-by: Nicolas Pitre <nico@cam.org>

Thanks, but I should have mentioned that at this time this patch was just
meant for exposition, not inclusion. [It's just one of many, many patches
needed to make the test suite pass on MinGW.]

I'd prefer a solution to the problem that the pack file remains open. Do
you have an idea where git-pack-objects keeps the pack file open, even
with Alex's two patches applied?

-- Hannes
