From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix handle leak in builtin-pack-objects
Date: Wed, 19 Nov 2008 13:26:07 +0100
Message-ID: <492405DF.5060600@viscovery.net>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com>	 <4923FE58.3090503@viscovery.net> <81b0412b0811190413s29644092y86d1c8840e10c28b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 13:27:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2m9k-0000Ow-Ll
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 13:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbYKSM0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 07:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752771AbYKSM0M
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 07:26:12 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:35421 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbYKSM0L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 07:26:11 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L2m8F-0002Eo-Nk; Wed, 19 Nov 2008 13:26:08 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7E45D69F; Wed, 19 Nov 2008 13:26:07 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <81b0412b0811190413s29644092y86d1c8840e10c28b@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101332>

Alex Riesen schrieb:
> 2008/11/19 Johannes Sixt <j.sixt@viscovery.net>:
>> Alex Riesen schrieb:
>>> The opened packs seem to stay open forever.
>> In my MinGW port I have the patch below that avoids that t5303 fails
>> because of a pack file that remains open. (Open files cannot be replaced
>> on Windows.) I had hoped that your patch would help, but it does not.
>> Something else still keeps the pack file open. Can anything be done about
>> that?
>>
> 
> Do this _and_ the other handle-leak-patch together help?
> (I think the second should)

No, that doesn't help, either. :-(

-- Hannes
