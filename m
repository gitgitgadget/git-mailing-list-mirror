From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: push.default: current vs upstream
Date: Thu, 12 Apr 2012 10:59:06 +0200
Message-ID: <vpqfwc9wckl.fsf@bauges.imag.fr>
References: <vpqwr5uceis.fsf@bauges.imag.fr>
	<20120406071520.GD25301@sigill.intra.peff.net>
	<vpqr4w12tjj.fsf@bauges.imag.fr>
	<20120406080004.GA27940@sigill.intra.peff.net>
	<4F7FF19B.1060407@alum.mit.edu>
	<20120407075150.GA18168@sigill.intra.peff.net>
	<7viphaygsg.fsf@alter.siamese.dyndns.org>
	<vpq62d6dyzr.fsf@bauges.imag.fr>
	<20120412075535.GC31122@sigill.intra.peff.net>
	<vpqhawp2wxs.fsf@bauges.imag.fr>
	<20120412081407.GE31122@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 10:59:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIFsL-0004Rw-Bd
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 10:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762192Ab2DLI71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 04:59:27 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35438 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754125Ab2DLI7X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 04:59:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3C8rQBY021493
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 12 Apr 2012 10:53:26 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SIFrv-0003Ck-Ho; Thu, 12 Apr 2012 10:59:07 +0200
In-Reply-To: <20120412081407.GE31122@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 12 Apr 2012 04:14:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 12 Apr 2012 10:53:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3C8rQBY021493
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1334825611.29266@D9wgyi6olImujc0U5ylNjw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195316>

Jeff King <peff@peff.net> writes:

> Then the rule is not really "act only if upstream and current would do
> the same thing".

Right. That would be closer to "fail with explicit error when where to
push is not clear enough".

> On the one hand, I think what you are suggesting is reasonable in most
> cases. On the other hand, what if the lack of upstream is because the
> user failed to configure it properly? Then it could be surprising.
>
> I don't have a strong opinion either way.

No strong opinion either, but I wanted to raise the point to make sure
we agree.

With your patch, "git push" fails with

  fatal: The current branch branch-name has no upstream branch.
  To push the current branch and set the remote as upstream, use
  
      git push --set-upstream origin branch-name

so it's not really bad: the suggestion guides the user to a situation
where the next "git push" will succeed unambiguously. As a side effect,
the next "git pull" will fetch from the same branch, which is probably
what the user wants if he hasn't explicitely configured an upstream
branch yet.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
