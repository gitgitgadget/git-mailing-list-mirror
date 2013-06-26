From: "Eduardo R. D'Avila" <erdavila@gmail.com>
Subject: [PATCH v2 3/5] t9903: remove redundant tests
Date: Wed, 26 Jun 2013 00:05:15 -0300
Message-ID: <5f56853a746189ccb03b929d472b5a5e721f8fb7.1372211661.git.erdavila@gmail.com>
References: <cover.1372211661.git.erdavila@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	gitster@pobox.com, "Eduardo R. D'Avila" <erdavila@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 26 05:08:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urg5j-0005hj-K8
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 05:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018Ab3FZDIQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jun 2013 23:08:16 -0400
Received: from mail-gh0-f180.google.com ([209.85.160.180]:41174 "EHLO
	mail-gh0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab3FZDIP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 23:08:15 -0400
Received: by mail-gh0-f180.google.com with SMTP id f18so4272527ghb.25
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 20:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=2Jdfk5v3L3qXoH8lYyHX+6BDtnv7WfM4puZzrMRH+bU=;
        b=IwPmnkyYk/y9bstqvEt8fBMWJOd5q+rorLtJ8qcQ7jou+k4Ysgq4hUbqt7jrdDL1O0
         OcjAzrsfQqcjlYCDrt7uKF12TuKG5PoTU7iinsK78tki0h/E88EmvvaFEW/HTa5oLNQr
         L0O41g6wNqc49J4nnIQq4sbNM4cBSNzUt6F6x/Wqrq/5eytjIWX5khni9JMpAyhOvM6h
         3H2WQz0gAgemMf8HBsU6yUaRtKL8a0Ai1JwkIw3xwpiQaZTffMoxOiPyTJzAH8cB4aLU
         6C00yOzYaEDAZr4PFfu8J5Ford1Tr0WohsKzBpuD4/cYLnz8OPoNqjufsFM3wZPRVQjj
         W9iw==
X-Received: by 10.236.155.105 with SMTP id i69mr999137yhk.159.1372216094691;
        Tue, 25 Jun 2013 20:08:14 -0700 (PDT)
Received: from localhost.localdomain (200.175.80.235.dynamic.adsl.gvt.net.br. [200.175.80.235])
        by mx.google.com with ESMTPSA id y70sm42415518yhe.15.2013.06.25.20.08.12
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 20:08:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.590.g42a98dd
In-Reply-To: <cover.1372211661.git.erdavila@gmail.com>
In-Reply-To: <cover.1372211661.git.erdavila@gmail.com>
References: <cover.1372211661.git.erdavila@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229024>

After refactoring __git_ps1_colorize_gitstring, codepaths for bash and =
zsh
became mostly common and tests for bash and zsh became redundant.

Remove tests for zsh. Keep one minimal test that stress the difference
in codepaths for bash and zsh.

Suggested-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Signed-off-by: Eduardo R. D'Avila <erdavila@gmail.com>
---
1	114	t/t9903-bash-prompt.sh
 t/t9903-bash-prompt.sh | 115 +----------------------------------------=
--------
 1 file changed, 1 insertion(+), 114 deletions(-)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 6a88778..f250dfc 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -665,7 +665,7 @@ test_expect_success 'prompt - bash color pc mode - =
untracked files status indica
 	test_cmp expected "$actual"
 '
=20
-test_expect_success 'prompt - zsh color pc mode - branch name' '
+test_expect_success 'prompt - zsh color pc mode' '
 	printf "BEFORE: (%%F{green}master%%f%%f):AFTER" >expected &&
 	(
 		ZSH_VERSION=3D5.0.0 &&
@@ -676,117 +676,4 @@ test_expect_success 'prompt - zsh color pc mode -=
 branch name' '
 	test_cmp expected "$actual"
 '
=20
-test_expect_success 'prompt - zsh color pc mode - detached head' '
-	printf "BEFORE: (%%F{red}(%s...)%%f%%f):AFTER" $(git log -1 --format=3D=
"%h" b1^) >expected &&
-	git checkout b1^ &&
-	test_when_finished "git checkout master" &&
-	(
-		ZSH_VERSION=3D5.0.0 &&
-		GIT_PS1_SHOWCOLORHINTS=3Dy &&
-		__git_ps1 "BEFORE:" ":AFTER" &&
-		printf "%s" "$PS1" >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success 'prompt - zsh color pc mode - dirty status indicat=
or - dirty worktree' '
-	printf "BEFORE: (%%F{green}master%%f %%F{red}*%%f):AFTER" >expected &=
&
-	echo "dirty" >file &&
-	test_when_finished "git reset --hard" &&
-	(
-		ZSH_VERSION=3D5.0.0 &&
-		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-		GIT_PS1_SHOWCOLORHINTS=3Dy &&
-		__git_ps1 "BEFORE:" ":AFTER" &&
-		printf "%s" "$PS1" >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success 'prompt - zsh color pc mode - dirty status indicat=
or - dirty index' '
-	printf "BEFORE: (%%F{green}master%%f %%F{green}+%%f):AFTER" >expected=
 &&
-	echo "dirty" >file &&
-	test_when_finished "git reset --hard" &&
-	git add -u &&
-	(
-		ZSH_VERSION=3D5.0.0 &&
-		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-		GIT_PS1_SHOWCOLORHINTS=3Dy &&
-		__git_ps1 "BEFORE:" ":AFTER" &&
-		printf "%s" "$PS1" >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success 'prompt - zsh color pc mode - dirty status indicat=
or - dirty index and worktree' '
-	printf "BEFORE: (%%F{green}master%%f %%F{red}*%%F{green}+%%f):AFTER" =
>expected &&
-	echo "dirty index" >file &&
-	test_when_finished "git reset --hard" &&
-	git add -u &&
-	echo "dirty worktree" >file &&
-	(
-		ZSH_VERSION=3D5.0.0 &&
-		GIT_PS1_SHOWCOLORHINTS=3Dy &&
-		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-		__git_ps1 "BEFORE:" ":AFTER" &&
-		printf "%s" "$PS1" >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success 'prompt - zsh color pc mode - dirty status indicat=
or - before root commit' '
-	printf "BEFORE: (%%F{green}master%%f %%F{green}#%%f):AFTER" >expected=
 &&
-	(
-		ZSH_VERSION=3D5.0.0 &&
-		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-		GIT_PS1_SHOWCOLORHINTS=3Dy &&
-		cd otherrepo &&
-		__git_ps1 "BEFORE:" ":AFTER" &&
-		printf "%s" "$PS1" >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success 'prompt - zsh color pc mode - inside .git director=
y' '
-	printf "BEFORE: (%%F{green}GIT_DIR!%%f%%f):AFTER" >expected &&
-	echo "dirty" >file &&
-	test_when_finished "git reset --hard" &&
-	(
-		ZSH_VERSION=3D5.0.0 &&
-		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-		GIT_PS1_SHOWCOLORHINTS=3Dy &&
-		cd .git &&
-		__git_ps1 "BEFORE:" ":AFTER" &&
-		printf "%s" "$PS1" >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success 'prompt - zsh color pc mode - stash status indicat=
or' '
-	printf "BEFORE: (%%F{green}master%%f %%F{blue}$%%f):AFTER" >expected =
&&
-	echo 2 >file &&
-	git stash &&
-	test_when_finished "git stash drop" &&
-	(
-		ZSH_VERSION=3D5.0.0 &&
-		GIT_PS1_SHOWSTASHSTATE=3Dy &&
-		GIT_PS1_SHOWCOLORHINTS=3Dy &&
-		__git_ps1 "BEFORE:" ":AFTER" &&
-		printf "%s" "$PS1" >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success 'prompt - zsh color pc mode - untracked files stat=
us indicator' '
-	printf "BEFORE: (%%F{green}master%%f %%F{red}%%%%%%f):AFTER" >expecte=
d &&
-	(
-		ZSH_VERSION=3D5.0.0 &&
-		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
-		GIT_PS1_SHOWCOLORHINTS=3Dy &&
-		__git_ps1 "BEFORE:" ":AFTER" &&
-		printf "%s" "$PS1" >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
 test_done
--=20
1.8.3.1.590.g42a98dd
