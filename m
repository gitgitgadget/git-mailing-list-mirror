From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Problems with  ./t9902-completion.sh
Date: Sat, 20 Oct 2012 14:02:36 +0200
Message-ID: <508292DC.8030700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 20 14:02:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPXlZ-0004l4-7M
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 14:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343Ab2JTMCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2012 08:02:39 -0400
Received: from mout.web.de ([212.227.17.12]:62942 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755333Ab2JTMCj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2012 08:02:39 -0400
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0Lto05-1TI5bE0xnR-0118dM; Sat, 20 Oct 2012 14:02:37 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
X-Provags-ID: V02:K0:ZQhn9HuAQaUC7kDH6HHuqasyOe4KiAkIhsk2h/Ryvt6
 kFYtrrGnqvVfoBBBZgn/c7A1yiRPDaPBypzibEZrzmTMya8Fss
 XOJyHs4t0tZNMXKIBL60M5QZZCYi67FGt/2EXXzvnUdnbHbaIP
 kGhHBKq42Z5/0IT9apOaDYMyFsoF19VITIw7yRqWjf6YSKA3Je
 diTksx0IBg2m3tRwN6gVA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208085>

t9902  does not work on my Mac OS box,
but only in one working directory.

Any idea where the "check-ignore" comea from ?
/Torsten


[snip]
--- expected    2012-10-20 11:54:35.000000000 +0000
+++ out    2012-10-20 11:54:35.000000000 +0000
@@ -1 +1,2 @@
+check-ignore
 checkout

This patch corrects the problem:
(s/check"/checko"/)


diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index cbd0fb6..0df751b 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -222,19 +222,19 @@ test_expect_success 'general options' '
 '
 
 test_expect_success 'general options plus command' '
-       test_completion "git --version check" "checkout " &&
-       test_completion "git --paginate check" "checkout " &&
-       test_completion "git --git-dir=foo check" "checkout " &&
-       test_completion "git --bare check" "checkout " &&
+       test_completion "git --version checko" "checkout " &&
+       test_completion "git --paginate checko" "checkout " &&
+       test_completion "git --git-dir=foo checko" "checkout " &&
+       test_completion "git --bare checko" "checkout " &&
        test_completion "git --help des" "describe " &&
-       test_completion "git --exec-path=foo check" "checkout " &&
-       test_completion "git --html-path check" "checkout " &&
-       test_completion "git --no-pager check" "checkout " &&
-       test_completion "git --work-tree=foo check" "checkout " &&
-       test_completion "git --namespace=foo check" "checkout " &&
-       test_completion "git --paginate check" "checkout " &&
-       test_completion "git --info-path check" "checkout " &&
-       test_completion "git --no-replace-objects check" "checkout "
+       test_completion "git --exec-path=foo checko" "checkout " &&
+       test_completion "git --html-path checko" "checkout " &&
+       test_completion "git --no-pager checko" "checkout " &&
+       test_completion "git --work-tree=foo checko" "checkout " &&
+       test_completion "git --namespace=foo checko" "checkout " &&
+       test_completion "git --paginate checko" "checkout " &&
+       test_completion "git --info-path checko" "checkout " &&
+       test_completion "git --no-replace-objects checko" "checkout "
 '
