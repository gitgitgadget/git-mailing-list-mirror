From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/5] t3400 (rebase): whitespace cleanup
Date: Fri, 23 Jul 2010 12:05:24 -0500
Message-ID: <20100723170524.GE2507@burratino>
References: <7vwsfb2k3u.fsf@gitster.siamese.dyndns.org>
 <1279742303-29817-1-git-send-email-ddkilzer@kilzer.net>
 <20100722075133.GA9292@burratino>
 <681325.9577.qm@web30002.mail.mud.yahoo.com>
 <20100723170103.GA2507@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Fri Jul 23 19:06:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcLhl-0007Nn-L7
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 19:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756764Ab0GWRGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 13:06:33 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50175 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192Ab0GWRGc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 13:06:32 -0400
Received: by pzk26 with SMTP id 26so155125pzk.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 10:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=n3aJm/2DDx/1p5dGCTskBBhPt1Sn2a6K2/tfS3hAFZ8=;
        b=TINY1i2YEoVJ3RCpuOeGyVuxYfXlPxGIEbr/WbK7+zI7f25xanyZnr1tZHwRB274Kz
         M/iAei+9Gok4t1NooOjbtYwrrY6c5nxKf9ClMXHSwHy/XL9zwYRyXWx2HXMtX0hU3OPH
         LUg06zSoMs2QSrgV4el+i96WTRS/82hPCunc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nI6XfqB3e7x5IC/uc7J+MfZK/enl5cP8sdks1seZlVW0Ow7pm2SjAuRCLu0klQ6V/J
         Sm2ipiWLyFJS6BSgbo0d1H6CM3zxByJBlzvwEotV/Wbi2LTDeoKkHM9DEUU1xR1qSU7h
         J/tJ5vqHl0o1PZkn36r9JWpYer2JnyzYSRJYE=
Received: by 10.115.15.18 with SMTP id s18mr5575444wai.5.1279904784734;
        Fri, 23 Jul 2010 10:06:24 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id js14sm460727qcb.30.2010.07.23.10.06.22
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 10:06:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100723170103.GA2507@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151552>

This test used 5-space indents since it was added in 2005, but
recently the temptation to use tabs to indent has been too
strong, resulting in uneven whitespace.  Switch over completely
to tabs.

While at it, use a more modern style for consistency with other
tests:

 - names of tests go on the same line as test_expect_success;
 - extra whitespace after > redirection operators is removed.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t3400-rebase.sh |  182 +++++++++++++++++++++++++++--------------------------
 1 files changed, 92 insertions(+), 90 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index d98c7b5..083d768 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -14,140 +14,142 @@ GIT_AUTHOR_NAME=author@name
 GIT_AUTHOR_EMAIL=bogus@email@address
 export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
 
-test_expect_success \
-    'prepare repository with topic branches' \
-    'git config core.logAllRefUpdates true &&
-     echo First > A &&
-     git update-index --add A &&
-     git commit -m "Add A." &&
-     git checkout -b my-topic-branch &&
-     echo Second > B &&
-     git update-index --add B &&
-     git commit -m "Add B." &&
-     git checkout -f master &&
-     echo Third >> A &&
-     git update-index A &&
-     git commit -m "Modify A." &&
-     git checkout -b side my-topic-branch &&
-     echo Side >> C &&
-     git add C &&
-     git commit -m "Add C" &&
-     git checkout -b nonlinear my-topic-branch &&
-     echo Edit >> B &&
-     git add B &&
-     git commit -m "Modify B" &&
-     git merge side &&
-     git checkout -b upstream-merged-nonlinear &&
-     git merge master &&
-     git checkout -f my-topic-branch &&
-     git tag topic
+test_expect_success 'prepare repository with topic branches' '
+	git config core.logAllRefUpdates true &&
+	echo First >A &&
+	git update-index --add A &&
+	git commit -m "Add A." &&
+	git checkout -b my-topic-branch &&
+	echo Second >B &&
+	git update-index --add B &&
+	git commit -m "Add B." &&
+	git checkout -f master &&
+	echo Third >>A &&
+	git update-index A &&
+	git commit -m "Modify A." &&
+	git checkout -b side my-topic-branch &&
+	echo Side >>C &&
+	git add C &&
+	git commit -m "Add C" &&
+	git checkout -b nonlinear my-topic-branch &&
+	echo Edit >>B &&
+	git add B &&
+	git commit -m "Modify B" &&
+	git merge side &&
+	git checkout -b upstream-merged-nonlinear &&
+	git merge master &&
+	git checkout -f my-topic-branch &&
+	git tag topic
 '
 
 test_expect_success 'rebase on dirty worktree' '
-     echo dirty >> A &&
-     test_must_fail git rebase master'
+	echo dirty >>A &&
+	test_must_fail git rebase master
+'
 
 test_expect_success 'rebase on dirty cache' '
-     git add A &&
-     test_must_fail git rebase master'
+	git add A &&
+	test_must_fail git rebase master
+'
 
 test_expect_success 'rebase against master' '
-     git reset --hard HEAD &&
-     git rebase master'
+	git reset --hard HEAD &&
+	git rebase master
+'
 
 test_expect_success 'rebase against master twice' '
-     git rebase master >out &&
-     grep "Current branch my-topic-branch is up to date" out
+	git rebase master >out &&
+	grep "Current branch my-topic-branch is up to date" out
 '
 
 test_expect_success 'rebase against master twice with --force' '
-     git rebase --force-rebase master >out &&
-     grep "Current branch my-topic-branch is up to date, rebase forced" out
+	git rebase --force-rebase master >out &&
+	grep "Current branch my-topic-branch is up to date, rebase forced" out
 '
 
 test_expect_success 'rebase against master twice from another branch' '
-     git checkout my-topic-branch^ &&
-     git rebase master my-topic-branch >out &&
-     grep "Current branch my-topic-branch is up to date" out
+	git checkout my-topic-branch^ &&
+	git rebase master my-topic-branch >out &&
+	grep "Current branch my-topic-branch is up to date" out
 '
 
 test_expect_success 'rebase fast-forward to master' '
-     git checkout my-topic-branch^ &&
-     git rebase my-topic-branch >out &&
-     grep "Fast-forwarded HEAD to my-topic-branch" out
+	git checkout my-topic-branch^ &&
+	git rebase my-topic-branch >out &&
+	grep "Fast-forwarded HEAD to my-topic-branch" out
 '
 
-test_expect_success \
-    'the rebase operation should not have destroyed author information' \
-    '! (git log | grep "Author:" | grep "<>")'
+test_expect_success 'the rebase operation should not have destroyed author information' '
+	! (git log | grep "Author:" | grep "<>")
+'
 
-test_expect_success \
-    'the rebase operation should not have destroyed author information (2)' \
-    "git log -1 | grep 'Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>'"
+test_expect_success 'the rebase operation should not have destroyed author information (2)' "
+	git log -1 |
+	grep 'Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>'
+"
 
 test_expect_success 'HEAD was detached during rebase' '
-     test $(git rev-parse HEAD@{1}) != $(git rev-parse my-topic-branch@{1})
+	test $(git rev-parse HEAD@{1}) != $(git rev-parse my-topic-branch@{1})
 '
 
 test_expect_success 'rebase after merge master' '
-     git reset --hard topic &&
-     git merge master &&
-     git rebase master &&
-     ! (git show | grep "^Merge:")
+	git reset --hard topic &&
+	git merge master &&
+	git rebase master &&
+	! (git show | grep "^Merge:")
 '
 
 test_expect_success 'rebase of history with merges is linearized' '
-     git checkout nonlinear &&
-     test 4 = $(git rev-list master.. | wc -l) &&
-     git rebase master &&
-     test 3 = $(git rev-list master.. | wc -l)
+	git checkout nonlinear &&
+	test 4 = $(git rev-list master.. | wc -l) &&
+	git rebase master &&
+	test 3 = $(git rev-list master.. | wc -l)
 '
 
-test_expect_success \
-    'rebase of history with merges after upstream merge is linearized' '
-     git checkout upstream-merged-nonlinear &&
-     test 5 = $(git rev-list master.. | wc -l) &&
-     git rebase master &&
-     test 3 = $(git rev-list master.. | wc -l)
+test_expect_success 'rebase of history with merges after upstream merge is linearized' '
+	git checkout upstream-merged-nonlinear &&
+	test 5 = $(git rev-list master.. | wc -l) &&
+	git rebase master &&
+	test 3 = $(git rev-list master.. | wc -l)
 '
 
 test_expect_success 'rebase a single mode change' '
-     git checkout master &&
-     echo 1 > X &&
-     git add X &&
-     test_tick &&
-     git commit -m prepare &&
-     git checkout -b modechange HEAD^ &&
-     echo 1 > X &&
-     git add X &&
-     test_chmod +x A &&
-     test_tick &&
-     git commit -m modechange &&
-     GIT_TRACE=1 git rebase master
+	git checkout master &&
+	echo 1 >X &&
+	git add X &&
+	test_tick &&
+	git commit -m prepare &&
+	git checkout -b modechange HEAD^ &&
+	echo 1 >X &&
+	git add X &&
+	test_chmod +x A &&
+	test_tick &&
+	git commit -m modechange &&
+	GIT_TRACE=1 git rebase master
 '
 
 test_expect_success 'Show verbose error when HEAD could not be detached' '
-     : > B &&
-     test_must_fail git rebase topic 2> output.err > output.out &&
-     grep "Untracked working tree file .B. would be overwritten" output.err
+	>B &&
+	test_must_fail git rebase topic 2>output.err >output.out &&
+	grep "Untracked working tree file .B. would be overwritten" output.err
 '
 rm -f B
 
 test_expect_success 'dump usage when upstream arg is missing' '
-     git checkout -b usage topic &&
-     test_must_fail git rebase 2>error1 &&
-     grep "[Uu]sage" error1 &&
-     test_must_fail git rebase --abort 2>error2 &&
-     grep "No rebase in progress" error2 &&
-     test_must_fail git rebase --onto master 2>error3 &&
-     grep "[Uu]sage" error3 &&
-     ! grep "can.t shift" error3
+	git checkout -b usage topic &&
+	test_must_fail git rebase 2>error1 &&
+	grep "[Uu]sage" error1 &&
+	test_must_fail git rebase --abort 2>error2 &&
+	grep "No rebase in progress" error2 &&
+	test_must_fail git rebase --onto master 2>error3 &&
+	grep "[Uu]sage" error3 &&
+	! grep "can.t shift" error3
 '
 
 test_expect_success 'rebase -q is quiet' '
-     git checkout -b quiet topic &&
-     git rebase -q master > output.out 2>&1 &&
-     test ! -s output.out
+	git checkout -b quiet topic &&
+	git rebase -q master >output.out 2>&1 &&
+	test ! -s output.out
 '
 
 test_expect_success 'Rebase a commit that sprinkles CRs in' '
-- 
1.7.2.rc3
