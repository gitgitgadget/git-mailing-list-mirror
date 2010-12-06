From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Mon, 06 Dec 2010 12:37:07 +0100
Message-ID: <vpqpqtf5dzw.fsf@bauges.imag.fr>
References: <7v62v8ufyl.fsf@alter.siamese.dyndns.org>
	<20101206082948.1403cc5a@chalon.bertin.fr>
	<buopqtfmi85.fsf@dhlpc061.dev.necel.com>
	<20101206092122.21c19011@chalon.bertin.fr>
	<AANLkTimPC3-x1XFJ+t9uiFFXV6fg812ugF5vz9p=4GWB@mail.gmail.com>
	<20101206094806.10ae1ff2@chalon.bertin.fr>
	<AANLkTinJu0KzXZ2Rjbs2+XH7T=Gq5MOajxo51DHtqoGZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <dirson@bertin.fr>, gitster@pobox.com,
	git list <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Dec 06 12:37:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPZNn-0005lt-JY
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 12:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476Ab0LFLhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 06:37:21 -0500
Received: from mx1.imag.fr ([129.88.30.5]:34054 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254Ab0LFLhV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 06:37:21 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id oB6BKTSI013632
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 6 Dec 2010 12:20:29 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PPZNU-0001uD-44; Mon, 06 Dec 2010 12:37:08 +0100
In-Reply-To: <AANLkTinJu0KzXZ2Rjbs2+XH7T=Gq5MOajxo51DHtqoGZ@mail.gmail.com> (Miles Bader's message of "Mon\, 6 Dec 2010 18\:13\:06 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 06 Dec 2010 12:20:29 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oB6BKTSI013632
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1292239232.9218@vDlk9/r0/PeiyhOtI4UTnQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162992>

Miles Bader <miles@gnu.org> writes:

> it's is normal and good that option names are sometimes revisited and
> improved -- nothing is perfect on the first try.  By keeping the old
> option around as a deprecated alias, we avoid compatibility issues.

The problem is that the old name isn't kept as a _deprecated_ alias,
but just as an alias:

--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -251,6 +251,7 @@ endif::git-log[]
        If `n` is specified, it has the same meaning as for `-M<n>`.
 
 --find-copies-harder::
+--detect-copies-harder::
        For performance reasons, by default, `-C` option finds copies only
        if the original file of the copy was modified in the same
        changeset.  This flag makes the command

I'd rather have stg like

---find-copies-harder::
+--detect-copies-harder::
...
+--find-copies-harder::
+	Deprecated alias for --detect-copies-harder.
+

even if the old alias is kept forever. It's good to let old-timers use
the old name, but we shouldn't confuse new users with two names
without a hint on which one they're supposed to use. Otherwise, the
addition of an alias doesn't really have any benefit for anyone.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
