Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F165B208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 14:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751007AbdHROvc (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 10:51:32 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:50511 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdHROvb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 10:51:31 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue101
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MAdid-1dtOn300oF-00BrRY; Fri, 18
 Aug 2017 16:51:30 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] Documentation: use proper wording for ref format strings
Date:   Fri, 18 Aug 2017 16:51:22 +0200
Message-Id: <35df94bc16d9b1436d2110f5d5c54732e5d9a619.1503067851.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.224.g15ee91971c
X-Provags-ID: V03:K0:ev+WWwdzqYgGQGRzhMNaL+h6beQFFyKUwwxaN1DDrL80tCJNzFo
 tYfW99PTKbQtSFkY1NXqJOmZfE5GwGrzhIxhij5nfDiBtFnfPn+cY+g/lZcSJH96//TkAQS
 mvThtpylB+u0ifXMQK1peNq00sa0DKrXGHw/mEzwRg7Kg1SNzJwysRe09OxQ8lgLklLCPJb
 6uAtoLV3Ho+Oc8kLMiVRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A7h3noyagy4=:SCdJjp037DpsM0gGTLbfOt
 FvjirbCL1Y3UT/yR8lsT1pHMFOkpTjm9dgshNdkKE+/fWuKikFwwI+CgCSWLjZh9OS2iwmSTL
 +BH/Kt0YQEPNDa+BAIgXcb3nQl05NXuyYF+y+9h8TMrmKE/QLun52imu6/zf0pskiZr15k579
 mDg/2vsnD/bpWBOizhwBGwVVFayvvnd2ji+pOzgwQqhyjLTTcbeUb3/FlIA2KpVTpcMnbFaH1
 +vaSjo8lIug3c29dSkrskldcZk49GNNaE9A31o9VVautfeQA0vSLTq1F8GLKbixb2t1Zmc1Ax
 J6ljjnH0vzTlGcsO+SkRlojqzeyLVsd1VAV3PIbu0jxYQs4tdLG6EFooHKcXa/zk25IllAB5h
 RqqUQRqY6ovHEodp2sx+Bot36aY8hsEWTZTJnQOfrIitHkY3Y7mdG7Bt945DjQh1O9FCKayZO
 ruHXiBS8WSzeJ7W1+6tfon1rjV4etYcX4EAwdmYFG4bJkyS7/5oi9ZdbzPJqrXzBNf1JJFjLx
 5ugMKw18w04lGNq2bwLkJ/YbOPbx+AwwADqTQ1F2m5GLppZSmx8+bbdanXfZmHuWPWvn1hMSQ
 pquXHJw0HQp6o2n2JOR6Maromn2F5Wjeqp9iK79DAklmSL866gYqDHea4T9B2Hz5NbMcehIQO
 Xwq2iHAof3XtIkFNJ+u9WkIExJu1yqJw2Kq0p0l8G6fcyhariQdLQAtUJ5P5z9wA3YvzfcMck
 69SfYf+nmoJkDtsCggys469hVo2B3eHWR4WOSg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Various commands list refs and allow to use a format string for the
output that interpolates from the ref as well as the object it points
at (for-each-ref; branch and tag in list mode).

Currently, the documentation talks about interpolating from the object.
This is confusing because a ref points to an object but not vice versa,
so the object cannot possible know %(refname), for example. Thus, this is
wrong independent of refs being objects (one day, maybe) or not.

Change the wording to make this clearer (and distinguish it from formats
for the log family).

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 Documentation/git-branch.txt       | 4 ++--
 Documentation/git-for-each-ref.txt | 4 ++--
 Documentation/git-tag.txt          | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 81bd0a7b77..d0b3358771 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -267,8 +267,8 @@ start-point is either a local or remote-tracking branch.
 	Only list branches of the given object.
 
 --format <format>::
-	A string that interpolates `%(fieldname)` from the object
-	pointed at by a ref being shown.  The format is the same as
+	A string that interpolates `%(fieldname)` from a branch ref being shown
+	and the object it points at.  The format is the same as
 	that of linkgit:git-for-each-ref[1].
 
 Examples
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index cc42c12832..dac9138fab 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -38,8 +38,8 @@ OPTIONS
 	key.
 
 <format>::
-	A string that interpolates `%(fieldname)` from the
-	object pointed at by a ref being shown.  If `fieldname`
+	A string that interpolates `%(fieldname)` from a ref being shown
+	and the object it points at.  If `fieldname`
 	is prefixed with an asterisk (`*`) and the ref points
 	at a tag object, the value for the field in the object
 	tag refers is used.  When unspecified, defaults to
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index d97aad3439..543fb425ee 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -188,8 +188,8 @@ This option is only applicable when listing tags without annotation lines.
 	Defaults to HEAD.
 
 <format>::
-	A string that interpolates `%(fieldname)` from the object
-	pointed at by a ref being shown.  The format is the same as
+	A string that interpolates `%(fieldname)` from a tag ref being shown
+	and the object it points at.  The format is the same as
 	that of linkgit:git-for-each-ref[1].  When unspecified,
 	defaults to `%(refname:strip=2)`.
 
-- 
2.14.1.224.g15ee91971c

