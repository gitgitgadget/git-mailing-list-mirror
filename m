Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A71CB1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 14:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeICTK1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 15:10:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45021 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbeICTK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 15:10:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16-v6so911505wro.11
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 07:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=34XnaojA5QxmMSgyLfmc6Qxz/QlScFuYJGl6zEfhOm0=;
        b=ZEPd1ByWocIt6O0FMaL4Go7nIuhyQGeznbH3ToBiV9Pr0EoXEXDlcbLeXc8J2MDCnQ
         SxP/dakEYfwWg15m+idwC5XyJqrugzqkZAYshehj8ma7q/L8sCbcivbBElmVF9PBhNeP
         5ZDDMvVvNURdQDYnkPiEU6tLGBTESwFcjl/7NKYH3NCwBwyQAaMnhfrkUC4BA0FR3yZm
         H31I6wmkYZf7fFgERoaDikLcJ4T5V83F1A+O4L+E8dpbFq6DL/07ULXKjyWEX6FRW8SZ
         8GVtVPeykRCAIzJ99NnkD489w1ClzLs4G+Vqu64nco2kfgGyQE1rc14Z/fGaLks5kJBi
         +3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=34XnaojA5QxmMSgyLfmc6Qxz/QlScFuYJGl6zEfhOm0=;
        b=KaSAebjldvjCzy+PCUayG9egg9dRgIDr/FyuFF0sevwqW0JpRph8MfEEOu1AV4/3dP
         Yk7fj6H+gcw/nL/iPNOLJzV7egyxSyZHS7IG7el8PvMCa9+mKPim0ZMMhIdbX12EbByq
         Iw5Hq1IKugelEx9Ry5OVDt/GLs53+t1K3Ho3RQiY6ZVq9O+qh5u75j7ncX6Ae82nhais
         DXslpAYcAPWQCzrEkJC0N/eh6dsg4LeYHy+MiCvUXIkklJM1c1hmVR2MX8IlFiv/i35y
         n2DQyVtX2wzHh2D25ZdUH4cHHwUv1b1kBpqXOGLRo6xJGIU4MrvFXYYLBePbSBcd1Moo
         IF3w==
X-Gm-Message-State: APzg51A19IW32y93+oZJl45zlDhByOug7FaW6ED10B3by2lV78JlpBDi
        J1tvEQJQdHk6fL/CpC9Sa19FFkHlkZY=
X-Google-Smtp-Source: ANB0VdbS9AqQirGEorYhirV9m92YqL/IUi8ARAb/59Z/QQICLtZWk6x4JYj+9Q98mAO1gJOS5m4mHg==
X-Received: by 2002:a5d:608b:: with SMTP id w11-v6mr9899073wrt.193.1535986194805;
        Mon, 03 Sep 2018 07:49:54 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e133-v6sm23841649wma.33.2018.09.03.07.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 07:49:54 -0700 (PDT)
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
Subject: [PATCH v5 10/10] fsck: support comments & empty lines in skipList
Date:   Mon,  3 Sep 2018 14:49:28 +0000
Message-Id: <20180903144928.30691-11-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <2b31e12e-20e9-3d08-58bd-977f8b83e0a7@web.de>
References: <2b31e12e-20e9-3d08-58bd-977f8b83e0a7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's annoying not to be able to put comments and empty lines in the
skipList, when e.g. keeping a big central list of commits to skip in
/etc/gitconfig, which was my motivation for 1362df0d41 ("fetch:
implement fetch.fsck.*", 2018-07-27).

Implement that, and document what version of Git this was changed in,
since this on-disk format can be expected to be used by multiple
versions of git.

There is no notable performance impact from this change, using the
test setup described a couple of commits back:

    Test                                             HEAD~             HEAD
    ----------------------------------------------------------------------------------------
    1450.3: fsck with 0 skipped bad commits          7.69(7.27+0.42)   7.86(7.48+0.37) +2.2%
    1450.5: fsck with 1 skipped bad commits          7.69(7.30+0.38)   7.83(7.47+0.36) +1.8%
    1450.7: fsck with 10 skipped bad commits         7.76(7.38+0.38)   7.79(7.38+0.41) +0.4%
    1450.9: fsck with 100 skipped bad commits        7.76(7.38+0.38)   7.74(7.36+0.38) -0.3%
    1450.11: fsck with 1000 skipped bad commits      7.71(7.30+0.41)   7.72(7.34+0.38) +0.1%
    1450.13: fsck with 10000 skipped bad commits     7.74(7.34+0.40)   7.72(7.34+0.38) -0.3%
    1450.15: fsck with 100000 skipped bad commits    7.75(7.40+0.35)   7.70(7.29+0.40) -0.6%
    1450.17: fsck with 1000000 skipped bad commits   7.12(6.86+0.26)   7.13(6.87+0.26) +0.1%

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt        |  5 +++--
 fsck.c                          | 14 ++++++++++++++
 t/t5504-fetch-receive-strict.sh | 19 ++++++++++++++++---
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 161ffe259e..0906db3a99 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1712,8 +1712,9 @@ will only cause git to warn.
 fsck.skipList::
 	The path to a list of object names (i.e. one unabbreviated SHA-1 per
 	line) that are known to be broken in a non-fatal way and should
-	be ignored. Comments ('#') and empty lines are not supported, and
-	will error out.
+	be ignored. On versions of Git 2.20 and later comments ('#'), empty
+	lines, and any leading and trailing whitespace is ignored. Everything
+	but a SHA-1 per line will error out on older versions.
 +
 This feature is useful when an established project should be accepted
 despite early commits containing errors that can be safely ignored
diff --git a/fsck.c b/fsck.c
index 4c643f1d40..859b050b05 100644
--- a/fsck.c
+++ b/fsck.c
@@ -190,6 +190,20 @@ static void init_skiplist(struct fsck_options *options, const char *path)
 		die("Could not open skip list: %s", path);
 	while (!strbuf_getline(&sb, fp)) {
 		const char *p;
+		const char *hash;
+
+		/*
+		 * Allow trailing comments, leading whitespace
+		 * (including before commits), and empty or whitespace
+		 * only lines.
+		 */
+		hash = strchr(sb.buf, '#');
+		if (hash)
+			strbuf_setlen(&sb, hash - sb.buf);
+		strbuf_trim(&sb);
+		if (!sb.len)
+			continue;
+
 		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
 			die("Invalid SHA-1: %s", sb.buf);
 		oidset_insert(&options->skiplist, &oid);
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index d67ab37321..7bc706873c 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -169,20 +169,20 @@ test_expect_success 'fsck with invalid or bogus skipList input' '
 	test_i18ngrep "Invalid SHA-1: \[core\]" err
 '
 
-test_expect_success 'fsck with invalid or bogus skipList input (comments & empty lines)' '
+test_expect_success 'fsck with other accepted skipList input (comments & empty lines)' '
 	cat >SKIP.with-comment <<-EOF &&
 	# Some bad commit
 	0000000000000000000000000000000000000001
 	EOF
 	test_must_fail git -c fsck.skipList=SKIP.with-comment fsck 2>err-with-comment &&
-	test_i18ngrep "^fatal: Invalid SHA-1: # Some bad commit$" err-with-comment &&
+	test_i18ngrep "missingEmail" err-with-comment &&
 	cat >SKIP.with-empty-line <<-EOF &&
 	0000000000000000000000000000000000000001
 
 	0000000000000000000000000000000000000002
 	EOF
 	test_must_fail git -c fsck.skipList=SKIP.with-empty-line fsck 2>err-with-empty-line &&
-	test_i18ngrep "^fatal: Invalid SHA-1: " err-with-empty-line
+	test_i18ngrep "missingEmail" err-with-empty-line
 '
 
 test_expect_success 'fsck no garbage output from comments & empty lines errors' '
@@ -196,6 +196,19 @@ test_expect_success 'fsck with invalid abbreviated skipList input' '
 	test_i18ngrep "^fatal: Invalid SHA-1: " err-abbreviated
 '
 
+test_expect_success 'fsck with exhaustive accepted skipList input (various types of comments etc.)' '
+	>SKIP.exhaustive &&
+	echo "# A commented line" >>SKIP.exhaustive &&
+	echo "" >>SKIP.exhaustive &&
+	echo " " >>SKIP.exhaustive &&
+	echo " # Comment after whitespace" >>SKIP.exhaustive &&
+	echo "$commit # Our bad commit (with leading whitespace and trailing comment)" >>SKIP.exhaustive &&
+	echo "# Some bad commit (leading whitespace)" >>SKIP.exhaustive &&
+	echo "  0000000000000000000000000000000000000001" >>SKIP.exhaustive &&
+	git -c fsck.skipList=SKIP.exhaustive fsck 2>err &&
+	test_must_be_empty err
+'
+
 test_expect_success 'push with receive.fsck.skipList' '
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
-- 
2.19.0.rc1.350.ge57e33dbd1

