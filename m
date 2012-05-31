From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] improve no-op push output
Date: Thu, 31 May 2012 08:10:47 +0200
Message-ID: <vpqtxywswwo.fsf@bauges.imag.fr>
References: <20120530120804.GA3501@sigill.intra.peff.net>
	<7vr4u1zhcz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 31 08:11:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZybE-0002wl-9O
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 08:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441Ab2EaGLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 02:11:03 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52986 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752556Ab2EaGLB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 02:11:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4V62SOp016352
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 31 May 2012 08:02:28 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SZyau-00021a-0e; Thu, 31 May 2012 08:10:48 +0200
In-Reply-To: <7vr4u1zhcz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 30 May 2012 10:52:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 31 May 2012 08:02:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4V62SOp016352
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339048953.0854@/uoXo7M1lwwQFGTruTj4eg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198859>

Junio C Hamano <gitster@pobox.com> writes:

>> would just print:
>>
>>   Everything up-to-date
>>
>> and now you get:
>>
>>   To /tmp/push-message/parent
>>    = [up to date]      master -> master
> [...]
>
> 	Everything up-to-date (the current branch not pushed)

I like both. They don't really take more screen space (1 more line for
Jeff, which is acceptable IMHO), and do add information.

I'd add the number of branches pushed in case it's not one, so it could
say one of:

  To /tmp/push-message/parent
   = [up to date]      master -> master

or

  Everything up-to-date (X branches pushed, including the current)

or

  Everything up-to-date (X branches pushed, not including the current)

It would give a clue to a user having created many local branches that
his local branches were not pushed, and vice-versa, may help people who
did not understand that "push.default=matching" was pushing multiple
branches.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
