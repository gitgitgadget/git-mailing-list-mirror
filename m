From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] status: respect advice.statusHints for ahead/behind advice
Date: Tue, 04 Dec 2012 10:17:03 +0100
Message-ID: <vpqy5hei3cg.fsf@grenoble-inp.fr>
References: <20121203061656.GA20164@sigill.intra.peff.net>
	<7vr4n7rrgb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 10:18:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfodY-0003z2-BF
	for gcvg-git-2@plane.gmane.org; Tue, 04 Dec 2012 10:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314Ab2LDJRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2012 04:17:37 -0500
Received: from mx1.imag.fr ([129.88.30.5]:47188 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751807Ab2LDJRV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2012 04:17:21 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id qB498Ulu018058
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 4 Dec 2012 10:08:30 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Tfoch-0004Kt-W3; Tue, 04 Dec 2012 10:17:04 +0100
In-Reply-To: <7vr4n7rrgb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 03 Dec 2012 09:11:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 04 Dec 2012 10:08:31 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qB498Ulu018058
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1355216916.03512@Qca7Nc8cnqdexv/U6Fi2dQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211077>

Junio C Hamano <gitster@pobox.com> writes:

> So let's do a lot simpler patch instead.
>
> -- >8 --
> From: Jeff King <peff@peff.net>
> Date: Mon, 3 Dec 2012 01:16:57 -0500
>
> If the user has unset advice.statusHints, we already
> suppress the "use git reset to..." hints in each stanza. The
> new "use git push to publish..." hint is the same type of
> hint. Let's respect statusHints for it, rather than making
> the user set yet another advice flag.

You may want to squash this on top:

-- >8 --

>From 87a438bd06dd689bd37949e762690ab5dbfc5ff8 Mon Sep 17 00:00:00 2001
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Tue, 4 Dec 2012 10:15:03 +0100
Subject: [PATCH] document that statusHints affects git checkout

---
 Documentation/config.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e70216d..bf8f911 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -160,9 +160,10 @@ advice.*::
                it resulted in a non-fast-forward error.
        statusHints::
                Show directions on how to proceed from the current
-               state in the output of linkgit:git-status[1] and in
+               state in the output of linkgit:git-status[1], in
                the template shown when writing commit messages in
-               linkgit:git-commit[1].
+               linkgit:git-commit[1], and in the help message shown
+               by linkgit:git-checkout[1] when switching branch.
        commitBeforeMerge::
                Advice shown when linkgit:git-merge[1] refuses to
                merge to avoid overwriting local changes.
-- 
1.8.0.319.g8abfee4



-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
