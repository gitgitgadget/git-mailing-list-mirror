Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03E62200B9
	for <e@80x24.org>; Thu,  3 May 2018 15:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbeECPbU (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 11:31:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:58655 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751465AbeECPbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 11:31:16 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MNqcR-1fFdmd2jpT-007U8f; Thu, 03 May 2018 17:31:12 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 18/18] completion: support branch-diff
Date:   Thu,  3 May 2018 17:31:08 +0200
Message-Id: <5d047a830f12d29e7bc631fe166bbce7d5904a7b.1525361419.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g0f525fc0ba7
In-Reply-To: <cover.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:u6Rd7nL9bqw/rqvtYu1yYs1046P9dPViYDpMCEPrIMzcc0pEpUR
 A5yHiLrG+5IOtSl0BctB4Ct7H/DpSB/KEHgCSFV5oo2XrePSQz+VbmHGHfUdtMeY8tlb6oB
 k2HCw1woY3iFi+h0WVoEGiG5VSenwVv0pW8dYA8hdESWmBKYJ6j3MiYsJmtmjA0COL1Jq0q
 nTvyz4GlM0RWSaGRg5n9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yamGch1T3SM=:FNMZUMSjLLR/8ovbYr1QEi
 h2sMHQU0C109J/SXpkTYtgJ+wY/OZGqlLIkJISsTrzFRKgldQevva1u6L0vUsTgZKh2FgUPCT
 /z1pFTG86lSkKMgjqed5ZgOXUEBtYvC581xkVqy/E8QxdgHuX8XXzB6abLSc3O7gtzi1aioSM
 /aUz+5ncVXIVx8UOYMFFL9Rtn/XC7E/asxUND4hJGL7EypB+fdhQkvOingsLFXYXH2r/s53sg
 iEIVZS5eLAXPVvXntKdsQiawbl0ed1vmHtGjTVXuorQbauEJi5eGVbOob4ckH1eYq6Z0d0zce
 znBIzsWrV7g/Lyrrgb/0Z/mMYkl4tATFWCs3kADXPmD+mNc/w9I0q9nOVQjnHBk/JXvTOz+Jt
 CgwP1sieANyc2N+rtfhksB7aDFWmuVhsizNhDBLSAA12urmMx61EUdTro5RrclWxUMnsDZ6SQ
 YnaUcNDJVL44raIcrVFPHWOLSvuYIavUgCYvEg8CQsGqW0Ax0dt/xNH/TGviX0vAGScmu1wkH
 JERI3qLQ1xGDxyLnuzUoazkkXogD2x8Gz3A/ODgEMaK1WSb9/B6aUecH8V0Id8uO5ImPc8vxE
 8LdMaaaKvqy/xAqR0k8Yp2434zDnxmoNZppt6x2oG8BmiUSNHjPxmSzEARyHF6kws8igD9J+m
 t4bAKBTRjBtCYI1BLLzxKz1kc2dyZ0LfQTs2uObyrrVKKG/cqvEJ5M9/wyM7HHlcSV3Ma/j5Y
 VLX5arfH/ZyU6t4/m1uahtHx3n5Ea3wrrOi9C+OhWJkslPVUX11PeOpvp7S4vwiWOF807Fb/Z
 eTPLIoh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tab completion of `branch-diff` is very convenient, especially given
that the revision arguments that need to be passed to `git branch-diff`
are typically more complex than, say, your grandfather's `git log`
arguments.

Without this patch, we would only complete the `branch-diff` part but
not the options and other arguments.

This of itself may already be slightly disruptive for well-trained
fingers that assume that `git bra<TAB>ori<TAB>mas<TAB>` would expand to
`git branch origin/master`, as we now no longer automatically append a
space after completing `git branch`: this is now ambiguous.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/completion/git-completion.bash | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 01dd9ff07a2..45addd525ac 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1496,6 +1496,24 @@ _git_format_patch ()
 	__git_complete_revlist
 }
 
+__git_branch_diff_options="
+	--no-patches --creation-weight= --dual-color
+"
+
+_git_branch_diff ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp "
+			$__git_branch_diff_options
+			$__git_diff_common_options
+			"
+		return
+		;;
+	esac
+	__git_complete_revlist
+}
+
 _git_fsck ()
 {
 	case "$cur" in
-- 
2.17.0.395.g6a618d6010f.dirty
