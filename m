Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43CF51F404
	for <e@80x24.org>; Tue, 28 Aug 2018 09:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeH1Nnc (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 09:43:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37968 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbeH1Nnb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 09:43:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id t25-v6so1316529wmi.3
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 02:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7tp7CY6k/KoAWbngKLJKrhORJC6nzmK/lqrEKqx+Nd0=;
        b=S3FJM9XfRtY8BjYIWhWWm61FtmtiNSq207sauPX4nR9bf9CyWSmmc7M5SHeHMy+KFm
         naQUHvlBD6gjqBoUEs7WPocA2x6IGUM9i/wMAjCZM23UdqVNOYvHy4AWQTCIu5nTcNVu
         8HPZhMVvhXx6tS5RkHrpHZ4NUXts+cjm48q6o+ipv4PfyFZDLmgICJIJQ7WtUJVpU/Of
         FJhDKMZmz/exQX8RvXuEZNUTmPgRzctJ7cn7CgsfhXzCTUYiAlmTniDpreJax6OojLdP
         C8dkpQgLQlR232g2K4z2gtncGpAnjkFExkKXyfO6yAoJYlIzBJjFQTit965uE0eoeVOG
         dfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7tp7CY6k/KoAWbngKLJKrhORJC6nzmK/lqrEKqx+Nd0=;
        b=oi3f1+olhENkM71mbzr1G6a6leJdTkejzRZwqIX36CWj18lylV9Z4b4stoJ9s9apD1
         NyHL3ORMYK9ZtXU5c+wmPAk112V8R8aBoXQ/FXAK8QDb5Fg22NwOzcUFHg+DLmLIqONP
         XM0KkYiplaBJKxbNsU6vxMXOwXhYakBOd/DfaeIeoBoT8cpy+Cw4b+WC1BZhrRjGDkJn
         frFuJcjGDYEeItHTC7DG2wkPDfRonXvO4vu8CmElOUrrv7BoFuqfkKz9D5nmtzlBJAoO
         EsvnartKJBDjjvodVR2Me4vmRpNhhQoZKlh9pBTHxEh5/Do7hyqDTgY/aqd4+AxX5WRN
         oWtQ==
X-Gm-Message-State: APzg51D9/J6yJQZcLeY1RpwYzCpOewy78N9WVdPyd4THMiXPpWL3BSV1
        YAa9K1oSmTKd7cCI00VIF3UeMHX/sWU=
X-Google-Smtp-Source: ANB0VdbpfZkaIuWDZi2+QfOvkGTKwqga8HQZMec32/oRpthK27jO64itfXaRPGcu1yHpj1Zs4g6BaA==
X-Received: by 2002:a1c:3a92:: with SMTP id h140-v6mr897369wma.41.1535449959021;
        Tue, 28 Aug 2018 02:52:39 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a37-v6sm1572238wrc.21.2018.08.28.02.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 02:52:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 5/8] fsck: add a performance test for skipList
Date:   Tue, 28 Aug 2018 09:52:16 +0000
Message-Id: <20180828095219.23296-6-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <87lg8refcr.fsf@evledraar.gmail.com>
References: <87lg8refcr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: René Scharfe <l.s.r@web.de>

Create a performance test to see how the skipList implementation
performs. First we setup N bad commits, then we see how progressively
working our way up to 0..N in increments of 10x does. I.e. the
needle(s) in the haystack get progressively more numerous.

Signed-off-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/p1450-fsck-skip-list.sh | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 t/perf/p1450-fsck-skip-list.sh

diff --git a/t/perf/p1450-fsck-skip-list.sh b/t/perf/p1450-fsck-skip-list.sh
new file mode 100755
index 0000000000..c2b97d2487
--- /dev/null
+++ b/t/perf/p1450-fsck-skip-list.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description='Test fsck skipList performance'
+
+. ./perf-lib.sh
+
+test_perf_fresh_repo
+
+n=1000000
+
+test_expect_success "setup $n bad commits" '
+	for i in $(test_seq 1 $n)
+	do
+		echo "commit refs/heads/master" &&
+		echo "committer C <c@example.com> 1234567890 +0000" &&
+		echo "data <<EOF" &&
+		echo "$i.Q." &&
+		echo "EOF"
+	done | q_to_nul | git fast-import
+'
+
+skip=0
+while test $skip -le $n
+do
+	test_expect_success "create skipList for $skip bad commits" '
+		git log --format=%H --max-count=$skip |
+		sort >skiplist
+	'
+
+	test_perf "fsck with $skip skipped bad commits" '
+		git -c fsck.skipList=skiplist fsck
+	'
+
+	case $skip in
+	0) skip=1 ;;
+	*) skip=${skip}0 ;;
+	esac
+done
+
+test_done
-- 
2.19.0.rc0.228.g281dcd1b4d0

