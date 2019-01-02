Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 505451F770
	for <e@80x24.org>; Wed,  2 Jan 2019 04:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfABEhd (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Jan 2019 23:37:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38388 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbfABEhd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jan 2019 23:37:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so14029163plb.5
        for <git@vger.kernel.org>; Tue, 01 Jan 2019 20:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kI0l/8Ye2iyV9ZCf9gyiXUBXsZaFP0x8pmAjvmnaHCI=;
        b=JjtQl3zwVMlxccZ2xFTaCrf0gK0WpWcYJznLZrzDiePzV5nXhY1iidDej8NKkrPrOk
         E0+UTpw/GWPTqkXB3WvyoGV8xhx0DC40rMFc9nyb2uwbXop7TSO3rVMY3AyRFeyN54G/
         x81gvAyCPnplm6Sq63GWAMHC4iUiOxX79LLiXEUYzL1uaIT+OySZSkPeEnMVY3oMY3Nq
         uP/dr0nCbJt8O3JTpzXyIPrHVq9bQwvd8q+LyQiJ9Hsz77NLTNoVxlOR758xlrGaxfzO
         JJbIuoK0ZloTD5hf94o0bRA7uT9955PEHhiKTIuinKYZehqa/dZl45u+L3KSN4yTfwaJ
         tNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kI0l/8Ye2iyV9ZCf9gyiXUBXsZaFP0x8pmAjvmnaHCI=;
        b=Kmv1NtARyaIYJrqddB566Dga1y+h7VecI++rs3Ld3MTi75qDpIvQsmCnWF21Jk1RHF
         6CWx3MmjJfqwX9UJIkts1P6OkWWV198S9P0ahZB22axEFsq/8t0WXde6dexxX/SMZMKX
         qevhH+oGelWSB+GrrVQ4Uej9QKfGNistaDpxQyTJNJG8gBcYNuOF3lF7LzqHWGUQ8MJ2
         ZCinbNBJdYycUeB21KKpTIMB2QUc5l5SPXA3AS3GGk6RQbkuKk9/zorMCU5FLayK25cJ
         zWJGfIJK+lVxcGTMCgUA+xpCqHX/6b/puhOZuCa+CgtIoenuIUmjWqfr0JJlGLrL5QQ3
         zTZg==
X-Gm-Message-State: AJcUukdbBKAEbO/q5y1Nz9WBF3r0/QJ+VIxyRlOUc0Nf92QQaCQrA/Gx
        mcmEa57teQ+reNdGj0MEe1o=
X-Google-Smtp-Source: ALg8bN5mFdCQlsdtgBFKgMGxB5oAzwSJA7OEHUzd1DZkQfXTfyM2QyUUmMBrMTYgrubueck1qkj9Rw==
X-Received: by 2002:a17:902:c5:: with SMTP id a63mr42838014pla.267.1546403852587;
        Tue, 01 Jan 2019 20:37:32 -0800 (PST)
Received: from GotGit.hz.ali.com ([106.11.34.207])
        by smtp.gmail.com with ESMTPSA id b27sm75904397pfh.113.2019.01.01.20.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 20:37:32 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Sun Chao <sunchao9@huawei.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 1/3] t5323: test cases for git-pack-redundant
Date:   Wed,  2 Jan 2019 12:34:54 +0800
Message-Id: <20190102043456.15652-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.0.3.gc45e608566
In-Reply-To: <20181219121451.21697-1-worldhello.net@gmail.com>
References: <20181219121451.21697-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Add test cases for git pack-redundant to validate new algorithm for git
pack-redundant.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5323-pack-redundant.sh | 84 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100755 t/t5323-pack-redundant.sh

diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
new file mode 100755
index 0000000000..ef6076f065
--- /dev/null
+++ b/t/t5323-pack-redundant.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+#
+# Copyright (c) 2018 Jiang Xin
+#
+
+test_description='git redundant test'
+
+. ./test-lib.sh
+
+create_commits()
+{
+	set -e
+	parent=
+	for name in A B C D E F G H I J K L M
+	do
+		test_tick
+		T=$(git write-tree)
+		if test -z "$parent"
+		then
+			sha1=$(echo $name | git commit-tree $T)
+		else
+			sha1=$(echo $name | git commit-tree -p $parent $T)
+		fi
+		eval $name=$sha1
+		parent=$sha1
+	done
+	git update-ref refs/heads/master $M
+}
+
+create_redundant_packs()
+{
+	set -e
+	cd .git/objects/pack
+	P1=$(printf "$T\n$A\n" | git pack-objects pack 2>/dev/null)
+	P2=$(printf "$T\n$A\n$B\n$C\n$D\n$E\n" | git pack-objects pack 2>/dev/null)
+	P3=$(printf "$C\n$D\n$F\n$G\n$I\n$J\n" | git pack-objects pack 2>/dev/null)
+	P4=$(printf "$D\n$E\n$G\n$H\n$J\n$K\n" | git pack-objects pack 2>/dev/null)
+	P5=$(printf "$F\n$G\n$H\n" | git pack-objects pack 2>/dev/null)
+	P6=$(printf "$F\n$I\n$L\n" | git pack-objects pack 2>/dev/null)
+	P7=$(printf "$H\n$K\n$M\n" | git pack-objects pack 2>/dev/null)
+	P8=$(printf "$L\n$M\n" | git pack-objects pack 2>/dev/null)
+	cd -
+	eval P$P1=P1:$P1
+	eval P$P2=P2:$P2
+	eval P$P3=P3:$P3
+	eval P$P4=P4:$P4
+	eval P$P5=P5:$P5
+	eval P$P6=P6:$P6
+	eval P$P7=P7:$P7
+	eval P$P8=P8:$P8
+}
+
+# Create commits and packs
+create_commits
+create_redundant_packs
+
+test_expect_success 'clear loose objects' '
+	git prune-packed &&
+	test $(find .git/objects -type f | grep -v pack | wc -l) -eq 0
+'
+
+cat >expected <<EOF
+P1:$P1
+P4:$P4
+P5:$P5
+P6:$P6
+EOF
+
+test_expect_success 'git pack-redundant --all' '
+	git pack-redundant --all | \
+		sed -e "s#^.*/pack-\(.*\)\.\(idx\|pack\)#\1#g" | \
+		sort -u | \
+		while read p; do eval echo "\${P$p}"; done | \
+		sort > actual && \
+	test_cmp expected actual
+'
+
+test_expect_success 'remove redundant packs' '
+	git pack-redundant --all | xargs rm &&
+	git fsck &&
+	test $(git pack-redundant --all | wc -l) -eq 0
+'
+
+test_done
-- 
2.14.5.agit.2

