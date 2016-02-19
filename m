From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Fri, 19 Feb 2016 08:34:05 +0100
Message-ID: <vpqr3g96tn6.fsf@anie.imag.fr>
References: <vpqoabox66p.fsf@anie.imag.fr> <20160217172407.GD1831@hank>
	<448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com>
	<vpqh9h7f9kz.fsf@anie.imag.fr>
	<1CE3F5E2-DDCC-4F1B-93CF-1A4A194650BF@gmail.com>
	<CAGZ79kbGyCTdq4P02fNb7tEuvkvqcZviWJp40Ob1ed6=JCh9Xg@mail.gmail.com>
	<xmqq7fi1hlw6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 08:34:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWfa4-0002mK-RU
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 08:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757296AbcBSHeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 02:34:20 -0500
Received: from mx2.imag.fr ([129.88.30.17]:55133 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757189AbcBSHeT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 02:34:19 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1J7Y5Gd020601
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 19 Feb 2016 08:34:05 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1J7Y5JB031238;
	Fri, 19 Feb 2016 08:34:05 +0100
In-Reply-To: <xmqq7fi1hlw6.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 18 Feb 2016 11:13:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 19 Feb 2016 08:34:05 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1J7Y5Gd020601
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456472046.64648@kziLqtpYPSBYqvY91BzAZg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286663>

Junio C Hamano <gitster@pobox.com> writes:

> Deciding what the 'safe' subset is must be done with a lot of
> thinking by people who intimately know what implications it has to
> ban each feature.  I do not think it would be a good fit for a
> project to give to a relatively new participant to the Git project.

I have to agree with this: this would actually be very hard to get a
nice proposal from a student. Students can be good technically, but we
can't expect them to be experienced and giving sound advices to
beginners is hard in this situation.

> We have these "powerful" tools for a reason.  After making a mess
> experimenting with your working tree files, "reset --hard" is the
> best tool to go back to the known-good state,

I disagree with that. This reminds me a discussion I had with a student
a few years ago:

  student: how do a clear all changes from my worktree?
  me: git reset --hard

the next day:

  student: OK, now, how do I get my changes back?
  me: ...!

There's almost no situation where reset --hard is the best tool. If you
just want to discard local changes, then "stash" is much safer (it'll
eat a bit of your disk space, but in 99% cases it's not an issue). If
you messed up a merge then "merge --abort" is safer. If the goal is to
move HEAD, then "reset --keep" is safer.

One thing I like about Git is: when a beginner messes up his tree or
repo, his Git guru friend can almost always repair it easily (at least,
much easier than it was with svn). But there are still a few ways for
beginners to shoot themselves in the foot in a way that the guru cannot
repair.


Now, another issue with the proposed core.isbeginner is compatibility
with scripts. Dangerous commands are often plumbing, and a beginner may
still want to use scripts or other porcelain on top of it. Typically, I
think this rules out "git reset --hard" which is legitimate in scripts.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
