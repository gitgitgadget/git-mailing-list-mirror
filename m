Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31B0A1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 19:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeCMT7a (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 15:59:30 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:60392
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751955AbeCMT73 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Mar 2018 15:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1520971168;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=Oo2AXMyfbudqpsVAr/jnKfMn/sgANhCpPko5OyUZLX8=;
        b=kI4yK3HYtpISkHuewgaUxpXfI8kTQx6qSeP+0xfKBSLOhSnJtrcurVd9iiKXNyOY
        B5e9bt6VP4e2/VGS0k5kGfsRhFiarupbPsy1G6clpQVSpAIr3ilIlb0EXItlwdJYRpK
        qgphyWWj6qi++gBECu0EHGrKqEE3rtYDqUOoa5Sw=
From:   Magne Land <magne.land@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016220f23987-d4661c81-cf6e-4c96-8487-acce6bb365c8-000000@eu-west-1.amazonses.com>
Subject: [PATCH] Documentation/githooks: Clarify the behavior of
 post-checkout hook
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 13 Mar 2018 19:59:28 +0000
X-SES-Outgoing: 2018.03.13-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Magne Land <magne.land@appfolio.com>

This can happen when using 'git rebase -i=E2=80=99:
could not detach HEAD

Based on discovering this Stack Overflow discussion:
https://stackoverflow.com/questions/25561485/git-rebase-i-with-squash-canno=
t-detach-head
---
 Documentation/githooks.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index f877f7b7cd19c..3a4e027d0d175 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -166,7 +166,9 @@ worktree.  The hook is given three parameters: the ref =
of the previous HEAD,
 the ref of the new HEAD (which may or may not have changed), and a flag
 indicating whether the checkout was a branch checkout (changing branches,
 flag=3D1) or a file checkout (retrieving a file from the index, flag=3D0).
-This hook cannot affect the outcome of 'git checkout'.
+
+If this hook exits with a non-zero status, 'git checkout' will exit with t=
he
+same status.
=20
 It is also run after 'git clone', unless the --no-checkout (-n) option is
 used. The first parameter given to the hook is the null-ref, the second th=
e

--
https://github.com/git/git/pull/470
