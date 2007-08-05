From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Sun, 05 Aug 2007 21:42:50 +0200
Message-ID: <vpqr6mhahtx.fsf@bauges.imag.fr>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021050500.14781@racer.site>
	<vpqbqdq45ua.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021147110.14781@racer.site>
	<AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca>
	<Pine.LNX.4.64.0708021541520.14781@racer.site>
	<46B1F3F4.5030504@midwinter.com>
	<Pine.LNX.4.64.0708021614420.14781@racer.site>
	<20070803053717.GA16379@midwinter.com>
	<7v3az1qgdg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0708031121000.14781@racer.site>
	<7vir7wmk84.fsf@assigned-by-dhcp.cox.net>
	<vpqps24i9sx.fsf@bauges.imag.fr>
	<7v1wekmgo8.fsf@assigned-by-dhcp.cox.net>
	<vpqir7wi5oc.fsf@bauges.imag.fr>
	<7vlkcskx5z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Jean-Francois Veillette <jean_francois_veillette@yahoo.ca>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 21:43:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHm0R-0005Z8-FB
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 21:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395AbXHETnN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 15:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753803AbXHETnM
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 15:43:12 -0400
Received: from imag.imag.fr ([129.88.30.1]:45226 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755206AbXHETnL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 15:43:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l75JgoUJ012541
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 5 Aug 2007 21:42:50 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IHm02-0000hx-FR; Sun, 05 Aug 2007 21:42:50 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IHm02-0007jw-BC; Sun, 05 Aug 2007 21:42:50 +0200
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, Steven Grimm <koreth@midwinter.com>, Jean-Francois Veillette <jean_francois_veillette@yahoo.ca>, git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <7vlkcskx5z.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Fri\, 03 Aug 2007 16\:36\:56 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 05 Aug 2007 21:42:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55061>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>>> "git-status $args" on the other hand is a preview of "what would
>>> happen if I say 'git-commit $args'", and in order to compute
>>> that, you would fundamentally need to be able to write into the
>>> object store.  In a special case of giving empty $args it can be
>>> read-only.
>>
>> Can you give an example where it _could_ not be read-only?
>
> Think of what "git commit -a" would have to do.

I don't know whether it was a typo, but we're not talking about
"commit", but "status".

> It needs to hash and deposit a new object for blobs that have been
> modified. Where do those new blob object go?

git-status _does_ hash and deposit new objects, but it doesn't _need_
to. It can very well show you what "commit -a" would do without
actually doing it.

A trivial (and very stupid, yes) way to do this would be

cp -r . /tmp/git/
cd /tmp/git
git-status -a

There's no visible side-effects for the user.

IIRC, git-status -a does actually "git-add" the modified objects, but
does so in a temporary index, so I believe the objects you leave in
the objects database are not pointed to by anyone (indeed, I just
checked, git-fsck --unreachable shows the dangling blob), and are not
really useful (but will probably be used later when you run commit or
add).

> Maybe in a theoretical ideal world, you might prefer to
> reverting back to the stat-dirty original index to make
> git-status appear a read-only operation, with continued degraded
> performance.  You are welcome to reimplement it that way, and
> the patch should be trivial (while git-commit.sh is still a
> script, at least) but that is not what we did.

You still didn't understand my point about the difference between
user-specification and internal behavior. I'm very happy with
git-status updating the stat information in the index, since it is not
suppose to have user-visible side effects (it has with the current
empty-diff-for-touched-files behavior of git-diff).

Now, at that point, if I still didn't manage to show you the
difference between user-visible behavior and implementation, I believe
I have no better thing to do than giving up.

-- 
Matthieu
