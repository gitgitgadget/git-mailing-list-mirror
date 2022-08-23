Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4915EC32789
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 16:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244390AbiHWQOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244294AbiHWQOe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 12:14:34 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFAF11F2D4
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 05:35:27 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso7647924wmr.3
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 05:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=GWLbblDe2yD/GjhJarZqOgOAU6lprxKjrNIeb0qvK+s=;
        b=eMVx1ioJD7OPwIdkLdwY/aU4EL8cXjzYFlOpqKMvmgJ3EDcUxtJNiOj8o+INB0UzuM
         +eQ+5IpVNgDhK4SUnYAFGVtagl5IPTLodHWg3Vjr1wv15s0PU6dsUeSkykI26wzgQ8Js
         5T9CnMkkgo6TD3PvM7LWWY6dfuPFLHphkzh+RAHq4Jf15amVbdQsPp1tcJbDGD7VJzd+
         Km6kyTekVQ6fonQE+cyHi+U4prJ15IEVJ6d03VYvcyNx8i0kN1OS3m7jrQZ1VOYBwTST
         lTitTEktnKhN0Uhn9+hS3MTA58Sxegf0RSv2z+tGu7U+omAMguzz2zKJNX0dj/dkk2vv
         q9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=GWLbblDe2yD/GjhJarZqOgOAU6lprxKjrNIeb0qvK+s=;
        b=0hYJs4pnChmuIHRzBuPisYJxbvrwfm6cAH6AsPbQVcFQ20gnuvfZ5+mLY2rpkjRlM1
         Rb+1VdqbI0yR3aesUB27dEDeBa0HsBG7SjjeefYyOvAqwgn0pkAxjbr1Okc8Szl7qdhr
         Zq3BrDcico/jRXfnnYIZxrNOtqyma7c043hlV/1AWmkbJCV9piZT44Rg7bOdkg4ZP/zw
         Zy0FNQez15zr0DqJznooCZFAoJGpjcj3Q35u3B4iE4MF8v2bZyTc2OyPQKkoy3hExrwY
         4M4IDGsWCTug0EEsT6ecFnvf7+aHBwdIRsQ6bf8FY2k+IYJ9Lg5ApPjfYN8qhIAFlIe2
         aDZA==
X-Gm-Message-State: ACgBeo3PsPTNFVKgN3mXRtOfrVi3R9D+DA7rUYuMApxTKfqtjTOqdC49
        H8UyFo89nrRttqKh8fhbZzDS4sUzxeg=
X-Google-Smtp-Source: AA6agR4r60QrWaKY/9hWXeT6M3PA9oO35C+72g00HmNZwR27MzxJSa10hmkwMZCalDH2csO1hRqvDw==
X-Received: by 2002:a05:600c:1f0c:b0:3a5:d744:f837 with SMTP id bd12-20020a05600c1f0c00b003a5d744f837mr2157839wmb.40.1661258124205;
        Tue, 23 Aug 2022 05:35:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u1-20020a7bcb01000000b003a502c23f2asm21438932wmj.16.2022.08.23.05.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 05:35:23 -0700 (PDT)
Message-Id: <7fe4f228ae0a88b99b489018c076a7008642610e.1661258122.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1335.git.1661258122.gitgitgadget@gmail.com>
References: <pull.1335.git.1661258122.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 12:35:21 +0000
Subject: [PATCH 1/2] range-diff: reorder argument handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In d9c66f0b5bf (range-diff: first rudimentary implementation,
2018-08-13), we introduced the argument handling of the `range-diff`
command, special-casing three different stanzas based on the argument
count.

The somewhat unorthodox order (first handling the case of 2 arguments,
then 3, then 1) was chosen for clarity: the natural argument number is 2
because that is how many revision ranges are used internally. The code
to handle three arguments is relatively trivial, so it was added next.
And finally, the code to ungarble a single symmetric range into two
separate ones was added, because it was the most complicated (the most
inelegant part being about interpreting empty sides of the symmetric
range as `HEAD`).

In preparation for allowing pathspecs in `git range-diff` invocations,
where we no longer have the luxury of using the number of arguments to
disambiguate between these three different ways to specify the commit
ranges, we need to order these cases by argument count, in ascending
order.

This patch is best viewed with `--color-moved`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/range-diff.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 50318849d65..c8ffcd35aea 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -55,18 +55,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	if (!simple_color)
 		diffopt.use_color = 1;
 
-	if (argc == 2) {
-		if (!is_range_diff_range(argv[0]))
-			die(_("not a commit range: '%s'"), argv[0]);
-		strbuf_addstr(&range1, argv[0]);
-
-		if (!is_range_diff_range(argv[1]))
-			die(_("not a commit range: '%s'"), argv[1]);
-		strbuf_addstr(&range2, argv[1]);
-	} else if (argc == 3) {
-		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
-		strbuf_addf(&range2, "%s..%s", argv[0], argv[2]);
-	} else if (argc == 1) {
+	if (argc == 1) {
 		const char *b = strstr(argv[0], "..."), *a = argv[0];
 		int a_len;
 
@@ -85,6 +74,17 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 			b = "HEAD";
 		strbuf_addf(&range1, "%s..%.*s", b, a_len, a);
 		strbuf_addf(&range2, "%.*s..%s", a_len, a, b);
+	} else if (argc == 2) {
+		if (!is_range_diff_range(argv[0]))
+			die(_("not a commit range: '%s'"), argv[0]);
+		strbuf_addstr(&range1, argv[0]);
+
+		if (!is_range_diff_range(argv[1]))
+			die(_("not a commit range: '%s'"), argv[1]);
+		strbuf_addstr(&range2, argv[1]);
+	} else if (argc == 3) {
+		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
+		strbuf_addf(&range2, "%s..%s", argv[0], argv[2]);
 	} else {
 		error(_("need two commit ranges"));
 		usage_with_options(builtin_range_diff_usage, options);
-- 
gitgitgadget

