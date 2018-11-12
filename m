Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DC351F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 13:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbeKLXUD (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 18:20:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38568 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbeKLXUD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 18:20:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id f2-v6so8101671wme.3
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 05:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S9964/CSASE7PzfeD3Obqi98pNN8fTXCQN881Q/nAKs=;
        b=UPtSJT5Gw3+PFwmx24dl9TZ2SrSmMS3ueaYfcIqzS3Xyvn27p5/0LKzh93ugHfOwCV
         lkq7lcRYUMgjaOPzaWk/uPgj0SEY9vAgSivAXANYZE0MwYn9zvWYN3q94n4zx2jREgam
         2HO/DIgaMEuC9hMRfWMUkShaN15mwVBbcFMNAjghw45QZrj7t1DMnyfIBZJ8BYpyYMrj
         HjzVq4PGP9oYGJnZghiZgZmLBEb9qA9B7KrbxMJIHgQ9IHYT6xPpH6zfvmVgr1aupJln
         RKerqkq3RqRVvbb9rrnd7t0tYtG7BX5GghNE9lh3mrAAkkFSqoGnC4KGXE2kvF5c91dP
         V9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S9964/CSASE7PzfeD3Obqi98pNN8fTXCQN881Q/nAKs=;
        b=IOKeHyR7pAkmqrLGOA8l6JOXXw2ozKLO1i9WzRBOl2ysoCefQHJHiw8bHNInKfVoC6
         Fn8r7vwMo8eHg3mt5q5+5vImwDCJacP1yNIH3E1pDS85/x7vlwCHjpIoCpZaO099vEJO
         Z86akCmUzyhAb5u8ApZoPWMX/b/rqVI933AfDdlCGLnpb9yU270zYOTmdj4/rmckrA/g
         GYQ9zp75NjH615weEsD8XQYyxJoXKqbbebmyNGj8INPFfNwtM7x44Ipf3uHhcU/wwVT5
         FEgPuzld4ROLKhuvdom3EZR35wmt0eUw+m7sIZHfvSE7JidFzJX065SyFFwyk/5VtWGv
         V2Kg==
X-Gm-Message-State: AGRZ1gKBZRwSM3NClVuPnfvbQfc/r1U8b6Hy48/mvZ4lZyGNM7sOoEWp
        Emo+4j9j3yTPpJGrmiUTYU7LJONk8zA=
X-Google-Smtp-Source: AJdET5erfXI7/o0266GGPE2Cz9x6imEjpi5khMt/XBiNOWB7xtXSq48VCc8HnIhWhGYRBALTja9tfQ==
X-Received: by 2002:a1c:880e:: with SMTP id k14-v6mr8029957wmd.88.1542029204725;
        Mon, 12 Nov 2018 05:26:44 -0800 (PST)
Received: from localhost.localdomain (236.209.54.77.rev.vodafone.pt. [77.54.209.236])
        by smtp.gmail.com with ESMTPSA id 74-v6sm12405818wmn.42.2018.11.12.05.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 05:26:44 -0800 (PST)
From:   =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/2] refs: fix some exclude patterns being ignored
Date:   Mon, 12 Nov 2018 13:25:44 +0000
Message-Id: <20181112132545.31092-3-rafa.almas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112132545.31092-1-rafa.almas@gmail.com>
References: <20181112132545.31092-1-rafa.almas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`--exclude` from rev-list and rev-parse fails to exclude references if
the next `--branches`, `--tags` or `--remotes` use the optional
inclusive glob because those options are implemented as particular cases
of `--glob=`, which itself requires that exclude patterns begin with
'refs/'.

But it makes sense for `--branches=glob` and friends to be aware that
exclusions patterns for them shouldn't be 'refs/<type>/' prefixed, the
same way exclude patterns for `--branches` and friends (without the
optional glob) already are.

Let's record in 'refs.c:struct ref_filter' which context the exclude
pattern is tied to, so refs.c:filter_refs() can decide if it should
ignore the prefix when trying to match.

Signed-off-by: Rafael Ascensão <rafa.almas@gmail.com>
---
 refs.c                   |  4 ++++
 t/t6018-rev-list-glob.sh | 24 ++++++++++++------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index de81c7be7c..539f385f61 100644
--- a/refs.c
+++ b/refs.c
@@ -217,6 +217,7 @@ char *resolve_refdup(const char *refname, int resolve_flags,
 /* The argument to filter_refs */
 struct ref_filter {
 	const char *pattern;
+	const char *prefix;
 	each_ref_fn *fn;
 	void *cb_data;
 };
@@ -296,6 +297,8 @@ static int filter_refs(const char *refname, const struct object_id *oid,
 
 	if (wildmatch(filter->pattern, refname, 0))
 		return 0;
+	if (filter->prefix)
+		skip_prefix(refname, filter->prefix, &refname);
 	return filter->fn(refname, oid, flags, filter->cb_data);
 }
 
@@ -458,6 +461,7 @@ int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 	}
 
 	filter.pattern = real_pattern.buf;
+	filter.prefix = prefix;
 	filter.fn = fn;
 	filter.cb_data = cb_data;
 	ret = for_each_ref(filter_refs, &filter);
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index 8e2b136356..7dc6cbdc42 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -147,51 +147,51 @@ test_expect_success 'rev-parse accumulates multiple --exclude' '
 	compare rev-parse "--exclude=refs/remotes/* --exclude=refs/tags/* --all" --branches
 '
 
-test_expect_failure 'rev-parse --exclude=glob with --branches=glob' '
+test_expect_success 'rev-parse --exclude=glob with --branches=glob' '
 	compare rev-parse "--exclude=subspace-* --branches=sub*" "subspace/one subspace/two"
 '
 
-test_expect_failure 'rev-parse --exclude=glob with --tags=glob' '
+test_expect_success 'rev-parse --exclude=glob with --tags=glob' '
 	compare rev-parse "--exclude=qux/? --tags=qux/*" "qux/one qux/two"
 '
 
-test_expect_failure 'rev-parse --exclude=glob with --remotes=glob' '
+test_expect_success 'rev-parse --exclude=glob with --remotes=glob' '
 	compare rev-parse "--exclude=upstream/? --remotes=upstream/*" "upstream/one upstream/two"
 '
 
-test_expect_failure 'rev-parse --exclude=ref with --branches=glob' '
+test_expect_success 'rev-parse --exclude=ref with --branches=glob' '
 	compare rev-parse "--exclude=subspace-x --branches=sub*" "subspace/one subspace/two"
 '
 
-test_expect_failure 'rev-parse --exclude=ref with --tags=glob' '
+test_expect_success 'rev-parse --exclude=ref with --tags=glob' '
 	compare rev-parse "--exclude=qux/x --tags=qux/*" "qux/one qux/two"
 '
 
-test_expect_failure 'rev-parse --exclude=ref with --remotes=glob' '
+test_expect_success 'rev-parse --exclude=ref with --remotes=glob' '
 	compare rev-parse "--exclude=upstream/x --remotes=upstream/*" "upstream/one upstream/two"
 '
 
-test_expect_failure 'rev-list --exclude=glob with --branches=glob' '
+test_expect_success 'rev-list --exclude=glob with --branches=glob' '
 	compare rev-list "--exclude=subspace-* --branches=sub*" "subspace/one subspace/two"
 '
 
-test_expect_failure 'rev-list --exclude=glob with --tags=glob' '
+test_expect_success 'rev-list --exclude=glob with --tags=glob' '
 	compare rev-list "--exclude=qux/? --tags=qux/*" "qux/one qux/two"
 '
 
-test_expect_failure 'rev-list --exclude=glob with --remotes=glob' '
+test_expect_success 'rev-list --exclude=glob with --remotes=glob' '
 	compare rev-list "--exclude=upstream/? --remotes=upstream/*" "upstream/one upstream/two"
 '
 
-test_expect_failure 'rev-list --exclude=ref with --branches=glob' '
+test_expect_success 'rev-list --exclude=ref with --branches=glob' '
 	compare rev-list "--exclude=subspace-x --branches=sub*" "subspace/one subspace/two"
 '
 
-test_expect_failure 'rev-list --exclude=ref with --tags=glob' '
+test_expect_success 'rev-list --exclude=ref with --tags=glob' '
 	compare rev-list "--exclude=qux/x --tags=qux/*" "qux/one qux/two"
 '
 
-test_expect_failure 'rev-list --exclude=ref with --remotes=glob' '
+test_expect_success 'rev-list --exclude=ref with --remotes=glob' '
 	compare rev-list "--exclude=upstream/x --remotes=upstream/*" "upstream/one upstream/two"
 '
 
-- 
2.19.1

