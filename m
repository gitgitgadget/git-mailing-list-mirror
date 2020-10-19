Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189B5C433DF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D54223C6
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sfconservancy.org header.i=@sfconservancy.org header.b="AdQkOiyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733053AbgJSVag (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 17:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733039AbgJSVaf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 17:30:35 -0400
Received: from pine.sfconservancy.org (pine.sfconservancy.org [IPv6:2001:4801:7822:103:be76:4eff:fe10:7c55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38616C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 14:30:35 -0700 (PDT)
Received: from localhost (unknown [216.161.86.18])
        (Authenticated sender: bkuhn)
        by pine.sfconservancy.org (Postfix) with ESMTPSA id 9DA3CE384;
        Mon, 19 Oct 2020 21:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sfconservancy.org;
        s=pine; t=1603143033;
        bh=o5D+zRNOr4MLvPWE4o0DKuDKHrHJXPXhOSjNp6DpH1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AdQkOiyvpQjLJPihvbSwiqQ6OB9aNWDdf2BcxlPJLzmbJISBIofm43lrAyWwnFLv9
         BiRBtGygEvZ8dQChDO2x1fVrnOaW1fKfeeEyuu79m0zm8KfuSPz5ll2v5ppAhoFO+c
         WbCEskrz/QyIbRct54pK4HPR//FW2v/6KUFXUlRvCG/okXDq7JxOoOs/rWmHfkSaF3
         D7w/5iIlRctbhodAAj1lGKL4wGLtPaokFIo74a5NYM85CK37EbAxNQzqgsBJcg/eRF
         QcO8QuzwV04RyJc4hKrMFMG2yFSr4XDb13HUrYTV5mrsUf9hiaA4ZIX9IYnmw++Lor
         +4uiUWekbVc7g==
From:   "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] SubmittingPatches: clarify DCO is our --signoff rule
Date:   Mon, 19 Oct 2020 14:25:44 -0700
Message-Id: <15c1a3a0c98691450599ccdbe27e73b8bfe906f8.1603142543.git.bkuhn@sfconservancy.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1603142543.git.bkuhn@sfconservancy.org>
References: <xmqqmu0it6ls.fsf@gitster.c.googlers.com> <cover.1603142543.git.bkuhn@sfconservancy.org>
MIME-Version: 1.0
Organization: Software Freedom Conservancy, Inc.
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

The description on sign-off and DCO was written back in the days
where there was only a choice between "use sign-off and it means the
contributor agrees to the Linux-kernel style DCO" and "not using
sign-off at all will make your patch unusable".  These days, we are
trying to clarify that the exact meaning of a sign-off varies
project to project.

Let's be more explicit when presenting what _our_ rules are.  It is
of secondary importance that it originally came from the kernel
project, so move the description as a historical note at the end,
while cautioning that what a sign-off means to us may be different from
what it means to other projects contributors may have been used to.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Bradley M. Kuhn <bkuhn@sfconservancy.org>
---
 Documentation/SubmittingPatches | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index d520eb23b1..b798aef844 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -300,15 +300,12 @@ patch.
 [[sign-off]]
 === Certify your work by adding your `Signed-off-by:` line
 
-To improve tracking of who did what, we've borrowed the
-"sign-off" procedure from the Linux kernel project on patches
-that are being emailed around.  Although core Git is a lot
-smaller project it is a good discipline to follow it.
+To improve tracking of who did what, we ask you to certify that you
+wrote the patch or have the right to pass it on under the same license
+as ours, by "signing off" your patch.  Without sign-off, we cannot
+accept your patches.
 
-The sign-off is a simple line at the end of the explanation for
-the patch, which certifies that you wrote it or otherwise have
-the right to pass it on as an open-source patch.  The rules are
-pretty simple: if you can certify the below D-C-O:
+If you can certify the below D-C-O:
 
 [[dco]]
 .Developer's Certificate of Origin 1.1
@@ -338,14 +335,15 @@ d. I understand and agree that this project and the contribution
    this project or the open source license(s) involved.
 ____
 
-then you just add a line saying
+you add a "Signed-off-by" trailer to your commit, that looks like
+this:
 
 ....
 	Signed-off-by: Random J Developer <random@developer.example.org>
 ....
 
-This line can be automatically added by Git if you run the git-commit
-command with the -s option.
+This line can be added by Git if you run the git-commit command with
+the -s option.
 
 Notice that you can place your own `Signed-off-by:` line when
 forwarding somebody else's patch with the above rules for
@@ -353,6 +351,11 @@ D-C-O.  Indeed you are encouraged to do so.  Do not forget to
 place an in-body "From: " line at the beginning to properly attribute
 the change to its true author (see (2) above).
 
+This procedure originally came from the Linux kernel project, so our
+rule is quite similar to theirs, but what exactly it means to sign-off
+your patch differs from project to project, so it may be different
+from that of the project you are accustomed to.
+
 [[real-name]]
 Also notice that a real name is used in the `Signed-off-by:` line. Please
 don't hide your real name.
-- 
Bradley M. Kuhn - he/him
Policy Fellow & Hacker-in-Residence at Software Freedom Conservancy
========================================================================
Become a Conservancy Supporter today: https://sfconservancy.org/supporter

