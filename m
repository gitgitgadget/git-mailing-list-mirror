Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CAF3205C9
	for <e@80x24.org>; Tue, 10 Jan 2017 11:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964833AbdAJL2B (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 06:28:01 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33017 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935155AbdAJL17 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 06:27:59 -0500
Received: by mail-pf0-f194.google.com with SMTP id 127so28624177pfg.0
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 03:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hy8oX4QTHhNeWZgDM4mAPndjCqKc5JZlXwU4kAasMJQ=;
        b=P8Y//Rh4AfoNe3kNrgR8/A5BT+a+JPYjCTwrANZBEcyOgwPQUkOtLVMHQvf0ZBYg1x
         dToUCr6gFnH+xib6CBuhRRpAWIym9WseB3/Ed/rtXY4QoTykZiLCRjv9+UOBBemlR+st
         cmpkrj+di+vExFz1pu59YfwXt2Rp2CMx8GGL+3SxnjTlXlCmloeMvCjdLAikrbW7GP2W
         0zHupBEpdO7oIbBVkh/pT/jM3uwMV7g/y8l/RZlSwjSp/f4eNXeJvFti6CFadT6lhMIr
         O2tbgqBMi5ZJAzcw9qSfXDbXYv7ofd9EdEnjjM/+OR5m3pm7g/tPhQ9lYhG7lq/EKC6u
         /IFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hy8oX4QTHhNeWZgDM4mAPndjCqKc5JZlXwU4kAasMJQ=;
        b=BzrhOWD5YJVZLbBhsPL2EmHG44pPdrIAIl2Mqbw37QFmWsA5xBSuvO5rW8C3inXEw3
         1QKrxvwbZXChE2TBhbeaW4xpWTjmUo3iYVqyE4flc3zlK7nBL94jbBaz6Wn021gRS6v6
         FkzA09V1WF34J5jq53AE+/T5FvW6ZMhWIfJOc9bipISFzWbXBSDuxxKcVwqNheWW/HCx
         GWB/qHBhGxjZaI0M3GIsM1LptSDSMvS5QgR71VeSAugGQtUg3U7BjHptdm0dGdMcl6Xe
         IjU2degg5WCcU04jjQilo8522QIImZA17ct5FXoTZJ1cla+5bOuaRNufGWdVbcoX1LRK
         MGZg==
X-Gm-Message-State: AIkVDXLE91JtUnF3zatXdiBlX+sj4VnmoCvl0GQV197MRgkY2ORq0Mpuy4hgNCbeU1sqiQ==
X-Received: by 10.98.204.83 with SMTP id a80mr3197012pfg.114.1484047679167;
        Tue, 10 Jan 2017 03:27:59 -0800 (PST)
Received: from ash ([115.73.174.142])
        by smtp.gmail.com with ESMTPSA id q19sm4808169pfl.21.2017.01.10.03.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 03:27:58 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 10 Jan 2017 18:27:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
        Jens.Lehmann@web.de, larsxschneider@gmail.com, sbeller@google.com,
        mhagger@alum.mit.edu, max@max630.net,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 4/4] t2029: add tests for per-worktree config
Date:   Tue, 10 Jan 2017 18:25:24 +0700
Message-Id: <20170110112524.12870-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20170110112524.12870-1-pclouds@gmail.com>
References: <20170110112524.12870-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t2029-worktree-config.sh (new +x) | 82 +++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100755 t/t2029-worktree-config.sh

diff --git a/t/t2029-worktree-config.sh b/t/t2029-worktree-config.sh
new file mode 100755
index 0000000..4ebdf13
--- /dev/null
+++ b/t/t2029-worktree-config.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+
+test_description="config file in multi worktree"
+
+. ./test-lib.sh
+
+cmp_config() {
+	if [ "$1" = "-C" ]; then
+		shift &&
+		GD="-C $1" &&
+		shift
+	else
+		GD=
+	fi &&
+	echo "$1" >expected &&
+	shift &&
+	git $GD config "$@" >actual &&
+	test_cmp expected actual
+}
+
+test_expect_success 'setup' '
+	test_commit start &&
+	git config --worktree per.worktree is-ok &&
+	git worktree add wt1 &&
+	git worktree add wt2 &&
+	git config --worktree per.worktree is-ok &&
+	cmp_config true extensions.worktreeConfig
+'
+
+test_expect_success 'config is shared as before' '
+	git config this.is shared &&
+	cmp_config shared this.is &&
+	cmp_config -C wt1 shared this.is &&
+	cmp_config -C wt2 shared this.is
+'
+
+test_expect_success 'config is shared (set from another worktree)' '
+	git -C wt1 config that.is also-shared &&
+	cmp_config also-shared that.is &&
+	cmp_config -C wt1 also-shared that.is &&
+	cmp_config -C wt2 also-shared that.is
+'
+
+test_expect_success 'config private to main worktree' '
+	git config --worktree this.is for-main &&
+	cmp_config for-main this.is &&
+	cmp_config -C wt1 shared this.is &&
+	cmp_config -C wt2 shared this.is
+'
+
+test_expect_success 'config private to linked worktree' '
+	git -C wt1 config --worktree this.is for-wt1 &&
+	cmp_config for-main this.is &&
+	cmp_config -C wt1 for-wt1 this.is &&
+	cmp_config -C wt2 shared this.is
+'
+
+test_expect_success 'core.bare no longer for main only' '
+	git config core.bare true &&
+	cmp_config true core.bare &&
+	cmp_config -C wt1 true core.bare &&
+	cmp_config -C wt2 true core.bare &&
+	git config --unset core.bare
+'
+
+test_expect_success 'config.worktree no longer read without extension' '
+	git config --unset extensions.worktreeConfig &&
+	cmp_config shared this.is &&
+	cmp_config -C wt1 shared this.is &&
+	cmp_config -C wt2 shared this.is
+'
+
+test_expect_success 'config --worktree migrate core.bare and core.worktree' '
+	git config core.bare true &&
+	git config --worktree foo.bar true &&
+	cmp_config true extensions.worktreeConfig &&
+	cmp_config true foo.bar &&
+	cmp_config true core.bare &&
+	! git -C wt1 config core.bare
+'
+
+test_done
-- 
2.8.2.524.g6ff3d78

