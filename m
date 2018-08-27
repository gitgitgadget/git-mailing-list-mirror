Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A6601F404
	for <e@80x24.org>; Mon, 27 Aug 2018 19:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeH0Xbr (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 19:31:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39869 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbeH0Xbr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 19:31:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id o37-v6so116843wrf.6
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 12:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GMz+lmnvqI7UQpjoZA3LupqFjfPCZ16t26V1M3fnrUw=;
        b=j/nP5nUCxQX8gUlCy2V6CgvBHoZdUPDB5B9i+jHS8FYW160KndPeNKy15wUsKNhtcm
         1dIPTQgahwstkU/bojfirhG5I9BYdUp1yr5KboVukwPYPRzNYZldgqDzQ7KirBYw7so/
         dPGfWbiuljjjAoPrV6SLqv1mMryO7xOCZxMPhag+RASxws/PJeYZL4qkS2A3n7QKI1aL
         R8rLCJu8YB84cRefPs6VxapwOSReWr7KhgApeOfVD1L+tsWicJgiop/TAvZ4nh3cjqyD
         JkEKtOvWkQ6RnR5djd8j96QIUazVaWCcreXkQmSfzIAak7Sr8pAo+aeL4moJSQJIl1ds
         T6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GMz+lmnvqI7UQpjoZA3LupqFjfPCZ16t26V1M3fnrUw=;
        b=r0tjAD/pz5ocHb6M2m+j8DP2TeC5Ya1cfYbm97Mpn432jepjdyIMWdSyfopKpYLiZJ
         1QkkpbTvzQtkFBxWOK9Ar038i2n/PExejbMMGmjqNEgYM3zM35DbiwaqTkn49q07bRuv
         seBqOiYnk/ig7o30XcgMoBUfQo3ags3nU4MLLfebIWGy0sN63sGl40oOOBKSn9GeW64A
         Ek1OSyfr7dPDHB1j3H0nTnSCHdsZTOVaFRan/+qo4Q5kUDmK9qT8nwpKCd2fDSbT0lsv
         qF6Gkob5c3HKJlk30pIhf1kyRbzuIWZj5tPdu7ShnSsUFEg5TPw683yKB+KRXjcjZNaB
         P2Wg==
X-Gm-Message-State: APzg51CFSwRxjsj88f2IzPM1dUVLKBalv6drgeqaqJt4bkB27mIAqyMy
        aBHx1o7ZQ1/urULfgZHALgtae86M0Co=
X-Google-Smtp-Source: ANB0VdYd+9Y/nFt5tlZwVPUfjpvPzyZw7fogL1pWPJ9FJ/J7H366i0bo574awh4TEHedAuaf58Kt8g==
X-Received: by 2002:adf:e505:: with SMTP id j5-v6mr9231013wrm.111.1535399025875;
        Mon, 27 Aug 2018 12:43:45 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q135-v6sm121958wmd.4.2018.08.27.12.43.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 12:43:45 -0700 (PDT)
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
Subject: [PATCH v3 7/7] fsck: support comments & empty lines in skipList
Date:   Mon, 27 Aug 2018 19:43:23 +0000
Message-Id: <20180827194323.17055-8-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <20180827194323.17055-1-avarab@gmail.com>
References: <20180827194323.17055-1-avarab@gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt        | 4 ++--
 fsck.c                          | 2 ++
 t/t5504-fetch-receive-strict.sh | 6 +++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3d0556e85d..e6f95a7fb2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1710,8 +1710,8 @@ will only cause git to warn.
 fsck.skipList::
 	The path to a list of object names (i.e. one SHA-1 per
 	line) that are known to be broken in a non-fatal way and should
-	be ignored. Comments ('#') and empty lines are not supported, and
-	will error out.
+	be ignored. On versions of Git 2.20 and later comments ('#') and empty
+	lines are ignored, but will error out on older versions.
 +
 This feature is useful when an established project should be accepted
 despite early commits containing errors that can be safely ignored
diff --git a/fsck.c b/fsck.c
index 4c643f1d40..589548308a 100644
--- a/fsck.c
+++ b/fsck.c
@@ -190,6 +190,8 @@ static void init_skiplist(struct fsck_options *options, const char *path)
 		die("Could not open skip list: %s", path);
 	while (!strbuf_getline(&sb, fp)) {
 		const char *p;
+		if (!strcmp(sb.buf, "") || starts_with(sb.buf, "#"))
+			continue;
 		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
 			die("Invalid SHA-1: %s", sb.buf);
 		oidset_insert(&options->skiplist, &oid);
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index c7224db3bb..a1bac164d1 100755
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
-- 
2.19.0.rc0.228.g281dcd1b4d0

