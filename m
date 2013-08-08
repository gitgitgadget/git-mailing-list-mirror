From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Remove old forgotten command: whatchanged
Date: Thu, 08 Aug 2013 20:06:09 +0200
Message-ID: <vpqk3jwcb1q.fsf@anie.imag.fr>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
	<vpqfvukdy39.fsf@anie.imag.fr> <ku0lqj$qvs$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Damien Robert <damien.olivier.robert+gmane@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 20:06:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7UbJ-00059P-VB
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 20:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678Ab3HHSGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 14:06:14 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50513 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752489Ab3HHSGN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 14:06:13 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r78I67xu009165
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 8 Aug 2013 20:06:07 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V7UbB-0008AW-Fe; Thu, 08 Aug 2013 20:06:09 +0200
In-Reply-To: <ku0lqj$qvs$1@ger.gmane.org> (Damien Robert's message of "Thu, 8
	Aug 2013 17:51:15 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 08 Aug 2013 20:06:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r78I67xu009165
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1376589968.64444@OvmVbF8rwfh/6iVzTxDTCQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231914>

Damien Robert <damien.olivier.robert+gmane@gmail.com> writes:

> Matthieu Moy  wrote in message <vpqfvukdy39.fsf@anie.imag.fr>:
>>> that confuses users.
>> 
>> ... but I do agree that the doc is really confusing. It would be much
>> better if the doc could be reduced to:
>> 
>> "This is a synonym for linkgit:git-log[1] --raw --some --other ---options.
>> Please refer to the documentation of that command."
>
> If I may chime in as a user: what really confused me about git whatchanged
> is this part of man gitcore-tutorial:

Indeed.

How about applying this, to reduce the number of references to
whatchanged in the docs?

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3bdd56e..486a58b 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -818,7 +818,7 @@ for further details.
 'GIT_FLUSH'::
        If this environment variable is set to "1", then commands such
        as 'git blame' (in incremental mode), 'git rev-list', 'git log',
-       'git check-attr', 'git check-ignore', and 'git whatchanged' will
+       'git check-attr', and 'git check-ignore' will
        force a flush of the output stream after each record have been
        flushed. If this
        variable is set to "0", the output of these commands will be done
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index f538a87..c6a1677 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -532,12 +532,7 @@ commit, and you can tell it to show a whole series of diffs.
 Alternatively, you can tell it to be "silent", and not show the diffs at
 all, but just show the actual commit message.
 
-In fact, together with the 'git rev-list' program (which generates a
-list of revisions), 'git diff-tree' ends up being a veritable fount of
-changes. A trivial (but very useful) script called 'git whatchanged' is
-included with Git which does exactly this, and shows a log of recent
-activities.
-
+'git log' can also be used to display changes introduced by some commits.
 To see the whole history of our pitiful little git-tutorial project, you
 can do
 
@@ -550,7 +545,7 @@ with the associated patches use the more complex (and much more
 powerful)
 
 ----------------
-$ git whatchanged -p
+$ git log --raw -p
 ----------------
 
 and you will see exactly what has changed in the repository over its


-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
