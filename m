Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D76F4202AF
	for <e@80x24.org>; Thu, 16 Nov 2017 07:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932411AbdKPHrU (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 02:47:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53301 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758992AbdKPHqq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 02:46:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EAD4FA7B29;
        Thu, 16 Nov 2017 02:46:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=mmZ5gHdwU5Zs7WLouWCLDZG3L+o
        =; b=UnYnys0OOOAGJWh19Ih670Jqqh8ul+87hWnLnd65E5fSABa4hPtuNzyqQFo
        VvcY+s37F2maPKSWSvC1/K3O/wkbvFiRTdAVkskaj9ggUNbay35JspT8+CkL1lqb
        XxvOoXGGVTUDoQRIIFXRIj65yD0SpSus7YCAiBq28oqxhpOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id; q=dns; s=sasl; b=S0X4qkvyvIXhgFScduubh
        V8L4GnfOTvzao+KztyugtGjun149TOEAZKp4b9qx0r3z7A/Izsulh4CbY+p+aJHp
        4WhPxaDvxk+A2o+saHfxQp47WrjfVDRPwcWfAouQw6wuTGvGRhUcpapO6GMGgy3h
        wEleyIHWZvn2mp4zb920+4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E3257A7B27;
        Thu, 16 Nov 2017 02:46:44 -0500 (EST)
Received: from morphine.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6FD69A7B24;
        Thu, 16 Nov 2017 02:46:44 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH] branch doc: remove --set-upstream from synopsis
Date:   Thu, 16 Nov 2017 02:46:43 -0500
Message-Id: <20171116074643.19614-1-tmz@pobox.com>
X-Mailer: git-send-email 2.15.0
X-Pobox-Relay-ID: 4AB795BC-CAA2-11E7-A3ED-8EF31968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Support for the --set-upstream option was removed in 52668846ea
(builtin/branch: stop supporting the "--set-upstream" option,
2017-08-17), after a long deprecation period.

Remove the option from the command synopsis for consistency.  Replace
another reference to it in the description of `--delete` with
`--set-upstream-to`.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

I noticed that --set-upstream was still in the synopsis for git branch.  I
don't think it was left there intentionally.  I looked through the thread where
support for the option was removed and didn't notice any comments suggesting
otherwise[1].  With luck, I didn't miss the obvious while reading the thread.

[1] https://public-inbox.org/git/20170807143938.5127-1-kaarticsivaraam91196@gmail.com/

 Documentation/git-branch.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index d6587c5e96..159ca388f1 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	[(--merged | --no-merged) [<commit>]]
 	[--contains [<commit]] [--no-contains [<commit>]]
 	[--points-at <object>] [--format=<format>] [<pattern>...]
-'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
+'git branch' [--track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
@@ -86,7 +86,7 @@ OPTIONS
 --delete::
 	Delete a branch. The branch must be fully merged in its
 	upstream branch, or in `HEAD` if no upstream was set with
-	`--track` or `--set-upstream`.
+	`--track` or `--set-upstream-to`.
 
 -D::
 	Shortcut for `--delete --force`.
-- 
2.15.0

