Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6112F200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbeEDPfY (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:35:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:53939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751447AbeEDPfV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:35:21 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LbMmA-1eV4Zf437C-00kwdY; Fri, 04 May 2018 17:35:14 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 18/18] completion: support branch-diff
Date:   Fri,  4 May 2018 17:35:11 +0200
Message-Id: <71698f11835311c103aae565a2a761d10f4676b9.1525448066.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g71698f11835
In-Reply-To: <cover.1525448066.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EFKu//UYx7BU5VE4flyD4u3nB1Bs2n9SYW1Db1Q1b6h41vpB9gJ
 qrqGQCtO8nOXEzM6Cvesu90W3KaakFVl0Sr/Pxr5HStOENde+kLPQH5bqiFygBrSo0HGNZM
 IQdiFoIMZlDr4A9Cdj2Mdci00t84Wj70Psy0t5/UQcLKSR/Dw3+qPmAD9mmWNIcGivmZPr0
 41L652lkxgl0HQ52TmiiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TQUT3ZEa3u0=:aXEjqoY5hHFFoEz4NZ5zDi
 u8SOAhe9y0mngkiU63mb++XDa8Hq6RfsPFPkyZV3G98XO6PdgzajI4M+J0fRJBftTDiaeqyfw
 ztw/V5gvhZ5d7DO57CvdieHcWa66mxKQGEVB/C4AogZkXPlfs7tMAAvrLWHq3LChAJbyp0840
 nvxnHAno13hTLvvBFpU9XeFWODsCYIJNIGcpXOmZBiMMaLqMy+Ds2bTqzPJpkRm/2khN82pGD
 16WYmjHUgjKyljc1C6M8V4oosQNhixxSIsGnhTL0f2S/p995aeIrRYZpkl8ydybV6MareBUhd
 LWKBu8f4LDLb6cqQ/lXa/V8qbASt8ZcBJwTZ12GEi1s5E1mn+VyexpqNJ8ROhje1PcfVU59bG
 WNZZYWtEMX/350H1mOOuAr1MlCxAQfQM9YRLmtP3wbzZuFkiBwa3Bik+2/b6X8PPDxwVVXa8u
 I2FYC7/+apRHioxpkDB59Ga4JD8GPrfDHcrSfD6iGh1XOqctNmWwjte0vpKD29sCfhZQ1GpKM
 h9SJ2/mM2ioWi7Jff1Qju1v/lwESR+HeU/hhJiI1s2+AHTu2As/fPLDW6yYLalp3hzfSiXIzz
 n2wj3BX1Y/SxmS3FZ4v4LlMiIPzQDaPoOpi047a6bs+NVptT8D2Y2bI8QyAYDK8EXubVjXOG4
 BmzFKEY5ja1L0zks218Ew+eiuTKKbyNPzkL1Bx8XBj80qxETQVxAvJj6L9YII8yOwpG99PtHc
 EFoGPhzp1yc19ZjqsRPzoBGe8D+0QbVHiA5sjpL6flwJq3VD7osGeRpUyK3wPRNZ2F02bcYJi
 POsASAd
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
2.17.0.409.g71698f11835
