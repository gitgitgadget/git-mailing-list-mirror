From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] Add branch --set-upstream
Date: Tue, 19 Jan 2010 08:22:26 +0100
Message-ID: <vpqy6juy2x9.fsf@bauges.imag.fr>
References: <1263847452-29634-1-git-send-email-ilari.liusvaara@elisanet.fi>
	<1263847452-29634-2-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Jan 19 08:22:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX8QD-0006dI-Jg
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 08:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707Ab0ASHWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 02:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754619Ab0ASHWh
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 02:22:37 -0500
Received: from mx1.imag.fr ([129.88.30.5]:48139 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753709Ab0ASHWh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 02:22:37 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o0J7LmF1027086
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 19 Jan 2010 08:21:48 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NX8Py-0006UT-LL; Tue, 19 Jan 2010 08:22:26 +0100
In-Reply-To: <1263847452-29634-2-git-send-email-ilari.liusvaara@elisanet.fi> (Ilari Liusvaara's message of "Mon\, 18 Jan 2010 22\:44\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 19 Jan 2010 08:21:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o0J7LmF1027086
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1264490509.44093@z8cLbTN1QdJ0fOh01aLHbA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137439>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> Add --set-upstream option to branch that works like --track, except that
> when branch exists already, its upstream info is changed without changing
> the ref value.
>
> Based-on-patch-from: Matthieu Moy <Matthieu.Moy@imag.fr>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

I'm short on Git time budget, so I happily let you take over on this
patch.

I'm a bit worried about the vocabulary: my understanding is that
"--track" is considered confusing, and should have been called
"--set-upstream" since the beginning.

With your patch, we have both --set-upstream and --track, with
different meanings. Should we consider --track as semi-deprecated, and
--set-upstream as "--track done right"? If so, you can consider
squashing this to promote your option instead of --track, and perhaps
reword git-branch.txt so that --track says it does like
--set-upstream, and not the other way around.

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index b169836..4c66f19 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2114,12 +2114,12 @@ linkgit:git-fetch[1] to keep them up-to-date; see
 
 Now create the branches in which you are going to work; these start out
 at the current tip of origin/master branch, and should be set up (using
-the --track option to linkgit:git-branch[1]) to merge changes in from
+the --set-upstream option to linkgit:git-branch[1]) to merge changes in from
 Linus by default.
 
 -------------------------------------------------
-$ git branch --track test origin/master
-$ git branch --track release origin/master
+$ git branch --set-upstream test origin/master
+$ git branch --set-upstream release origin/master
 -------------------------------------------------
 
 These can be easily kept up to date using linkgit:git-pull[1].


-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
