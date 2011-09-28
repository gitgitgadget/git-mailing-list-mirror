From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Docs: git checkout --orphan: `root commit' and `branch head'
Date: Wed, 28 Sep 2011 16:45:17 +0200
Message-ID: <vpq39fglo8y.fsf@bauges.imag.fr>
References: <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
	<1317073309.5579.9.camel@centaur.lab.cmartin.tk>
	<e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com>
	<4E81F080.7010905@drmicha.warpmail.net>
	<CAMOZ1BsvnZ7PyfjOJURX+B7vCZcYheLS4pissGvPNjEivbYXtw@mail.gmail.com>
	<7v39fhyk21.fsf@alter.siamese.dyndns.org>
	<4E823359.7080602@nextest.com>
	<DBCBE20265964ECCA5B9724DAC74D83B@PhilipOakley>
	<20110927214213.GC5176@sigill.intra.peff.net>
	<CAMOZ1BvzWDPQ_e3Y5H8CX4wQwL5xf3xVvZvRL3gQPcB_kCGBbw@mail.gmail.com>
	<20110927233549.GA10434@sigill.intra.peff.net>
	<7vpqiltsky.fsf@alter.siamese.dyndns.org>
	<CAMOZ1BvL85xsQpZdez4VJ+dH4NoQ9RkthHY9OsmdnnaZ_tFnFg@mail.gmail.com>
	<vpqty7wok5a.fsf@bauges.imag.fr>
	<CAMOZ1Bu8UiV+Z0+0CLjxSv5Zic8i4=aGxnzmLc+H7c2T-P4avw@mail.gmail.com>
	<vpq4nzwoj1o.fsf@bauges.imag.fr>
	<CAMOZ1Btw7Bf3_ejZef_SdRojyVeM94knyz9Gw+SEqFtrrpBVsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>,
	Eric Raible <raible@nextest.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 16:46:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8vOh-0007Ya-Vk
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 16:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653Ab1I1Opt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 10:45:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57637 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754630Ab1I1Ops (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 10:45:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p8SEhFJ8002743
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Sep 2011 16:43:15 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R8vNt-0002VV-Qr; Wed, 28 Sep 2011 16:45:17 +0200
In-Reply-To: <CAMOZ1Btw7Bf3_ejZef_SdRojyVeM94knyz9Gw+SEqFtrrpBVsA@mail.gmail.com>
	(Michael Witten's message of "Wed, 28 Sep 2011 14:35:46 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 28 Sep 2011 16:43:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p8SEhFJ8002743
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1317825797.11633@hjQqVSYgttmLuLYKpNoBIQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182328>

Michael Witten <mfwitten@gmail.com> writes:

>> Even if you use it normally:
>>
>> # I want to create a new root commit with a different tree
>> git checkout -b new-project
>> # hack for a while
>> git status
>> # ?!? why are files shown as 'deleted', 'moved', 'modified', I said I
>> # was creating a new project!
>>
>> Also, with your proposal, we would need to add two flags to "commit"
>> (--no-parent and --force), which is one of the first command beginners
>> learn, while in the current state we have just one for "checkout" to do
>> the trick, and newbies do not use or read the doc for checkout, so it's
>> not scary for them.
>
> Well, those are mildly interesting scenarios. I can only say that I don't
> think we should cater to people who either have amnesia or work casually
> on a repository for short bursts every few months or so.

How is the "git status" issue above linked to any kind of amnesia?

When hacking to create a rootless commit, it seems legitimate to me to
run "git status", and it seems _very_ confusing that "git status" still
refers to the commit you don't want as parent.

(I don't get the relation between your reply and the paragraph right
above it either)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
