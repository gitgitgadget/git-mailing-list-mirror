From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: [PATCH/RFC v2 1/1] bug fix, diff whitespace ignore options
Date: Mon, 19 Jan 2009 10:03:04 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0901191000520.25883@kiwi.cs.ucla.edu>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com>  <1232275999-14852-2-git-send-email-hjemli@gmail.com>  <1232275999-14852-3-git-send-email-hjemli@gmail.com>  <alpine.DEB.1.00.0901181635290.3586@pacific.mpi-cbg.de> 
 <8c5c35580901180945u17a69140vff2736765ee6073@mail.gmail.com>  <alpine.DEB.1.00.0901181929220.3586@pacific.mpi-cbg.de>  <8c5c35580901181145x2e14fe0fq4ab0e94c13bad38a@mail.gmail.com>  <alpine.DEB.1.00.0901182201140.3586@pacific.mpi-cbg.de> 
 <8c5c35580901181331v5e54f82fxc6a042962ff1cd06@mail.gmail.com>  <alpine.DEB.1.00.0901182244310.3586@pacific.mpi-cbg.de> <8c5c35580901181446n3c36a345m5d8e78764a85c123@mail.gmail.com> <alpine.DEB.1.00.0901190218470.3586@pacific.mpi-cbg.de>
 <alpine.GSO.2.00.0901181754190.9333@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0901190446480.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 19 19:04:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOyUH-000785-CQ
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 19:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbZASSDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 13:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbZASSDM
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 13:03:12 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:49079 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716AbZASSDL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 13:03:11 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n0JI35Tb026988;
	Mon, 19 Jan 2009 10:03:05 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n0JI350L026985;
	Mon, 19 Jan 2009 10:03:05 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0901190446480.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106378>

  Fixed bug in diff whitespace ignore options.  It is now
  OK to specify more than one whitespace ignore option
  on the command line.

Signed-off-by: Keith Cascio <keith@cs.ucla.edu>
---
Dscho,
You are right.  The code and the patch are more readable this way.
                                         -- Keith

  t/t4015-diff-whitespace.sh |    8 ++++----
  xdiff/xutils.c             |    6 ++++--
  2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index dbb608c..6d13da3 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -99,11 +99,11 @@ EOF
  git diff -w > out
  test_expect_success 'another test, with -w' 'test_cmp expect out'
  git diff -w -b > out
-test_expect_failure 'another test, with -w -b' 'test_cmp expect out'
+test_expect_success 'another test, with -w -b' 'test_cmp expect out'
  git diff -w --ignore-space-at-eol > out
-test_expect_failure 'another test, with -w --ignore-space-at-eol' 'test_cmp expect out'
+test_expect_success 'another test, with -w --ignore-space-at-eol' 'test_cmp expect out'
  git diff -w -b --ignore-space-at-eol > out
-test_expect_failure 'another test, with -w -b --ignore-space-at-eol' 'test_cmp expect out'
+test_expect_success 'another test, with -w -b --ignore-space-at-eol' 'test_cmp expect out'

  tr 'Q' '\015' << EOF > expect
  diff --git a/x b/x
@@ -123,7 +123,7 @@ EOF
  git diff -b > out
  test_expect_success 'another test, with -b' 'test_cmp expect out'
  git diff -b --ignore-space-at-eol > out
-test_expect_failure 'another test, with -b --ignore-space-at-eol' 'test_cmp expect out'
+test_expect_success 'another test, with -b --ignore-space-at-eol' 'test_cmp expect out'

  tr 'Q' '\015' << EOF > expect
  diff --git a/x b/x
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index d7974d1..04ad468 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -245,12 +245,14 @@ static unsigned long xdl_hash_record_with_whitespace(char const **data,
  			while (ptr + 1 < top && isspace(ptr[1])
  					&& ptr[1] != '\n')
  				ptr++;
-			if (flags & XDF_IGNORE_WHITESPACE_CHANGE
+			if (flags & XDF_IGNORE_WHITESPACE)
+				; /* already handled */
+			else if (flags & XDF_IGNORE_WHITESPACE_CHANGE
  					&& ptr[1] != '\n') {
  				ha += (ha << 5);
  				ha ^= (unsigned long) ' ';
  			}
-			if (flags & XDF_IGNORE_WHITESPACE_AT_EOL
+			else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL
  					&& ptr[1] != '\n') {
  				while (ptr2 != ptr + 1) {
  					ha += (ha << 5);
-- 
1.6.1.213.g28da8.dirty
