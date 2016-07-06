Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BC502070C
	for <e@80x24.org>; Wed,  6 Jul 2016 20:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474AbcGFU0l (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 16:26:41 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32824 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbcGFU0k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 16:26:40 -0400
Received: by mail-pf0-f196.google.com with SMTP id c74so22683334pfb.0
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 13:26:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=os4CN39vRHuSBD0WZrb9P3q6+ieSmnqTbY/mOYLAI64=;
        b=k6CUALMemvP/1o8fSWqO9PXNoclVBuAHj/ivBu81nDjHXP6hh4sBrDLog5LjPkd62V
         zJTNLDbJ5WpxXZpd+NMvZ13h84DGjfUXze/dRTl8eHhWLwREDNFE22I/m2eNYjf1+Pzt
         UIwrQ6VyODLm68fc1v2Y3jppH/roPMlSgHxvs+VEIGGIa9CJxPVHR5PfLK8YgJ//S1XO
         +t7MOqymPSK/SgrauHVhSz2Cna2e6zzEw4bFJL205G+XOVLp1FThle0xO5lVrvDa11Gi
         mcatnh7aEedCPmLZO0nhaMRAQeRPkvhoYT+YOr/qsDBsSRLWgGFpSLvVA9Wt33K5oBSc
         vlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=os4CN39vRHuSBD0WZrb9P3q6+ieSmnqTbY/mOYLAI64=;
        b=hNGpJhz5ormxVVj5E2wIxvtn/Ktr+IeZ/zsL6a81/S3+EKIyWtcdNhJU9q27TUZjS5
         lXA5MLycC9LoKe/nR8qAaQ47yE0Cd7+oaOuNZw0yQXRQt1dHIcArqj2fDS6GZMXa8N4N
         gRGGfs7ooaMm/l8nFNRJdHsMC3Hthfs380SIRNhmYk2Ie3jSh9JKvaVA4FIvy/Alew5C
         oK00t15VZv+7ay2gS3fWX+mUwtAemBD+IKbsONNpfwdgWzbwqBVcfN9X863yBmRFmsPg
         ZKho6+W+htBRo7umme2pzxCuEiVte8FuEiFC5G+aB8ScEbvvKVwJ3Cb0wlMHIjZtmqXj
         nZCg==
X-Gm-Message-State: ALyK8tJzm08rYc8H/y+xLne66LQ7kmvxN3ldxU+GwsL8cvDD9QYii0SrMv9KMpetVxUHGA==
X-Received: by 10.98.97.193 with SMTP id v184mr45287449pfb.138.1467836799559;
        Wed, 06 Jul 2016 13:26:39 -0700 (PDT)
Received: from localhost.localdomain ([27.106.54.176])
        by smtp.gmail.com with ESMTPSA id a87sm6272459pfc.63.2016.07.06.13.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Jul 2016 13:26:38 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	sunshine@sunshineco.com
Subject: [PATCH v4 0/6] convert various shell functions in git-bisect to C
Date:	Thu,  7 Jul 2016 01:55:17 +0530
Message-Id: <20160706202523.9850-1-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160626122356.28999-1-pranit.bauva@gmail.com>
References: <20160626122356.28999-1-pranit.bauva@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Some minor nits. Previous version can be found here[1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/298263

The inter-diff is :

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index e946ba9..c2f3cee 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -31,18 +31,16 @@ struct bisect_terms {
 	struct strbuf term_bad;
 };
 
-static int bisect_terms_init(struct bisect_terms *term)
+static void bisect_terms_init(struct bisect_terms *terms)
 {
-	strbuf_init(&term->term_good, 0);
-	strbuf_init(&term->term_bad, 0);
-	return 0;
+	strbuf_init(&terms->term_good, 0);
+	strbuf_init(&terms->term_bad, 0);
 }
 
-static int bisect_terms_release(struct bisect_terms *term)
+static void bisect_terms_release(struct bisect_terms *terms)
 {
-	strbuf_release(&term->term_good);
-	strbuf_release(&term->term_good);
-	return 0;
+	strbuf_release(&terms->term_good);
+	strbuf_release(&terms->term_bad);
 }
 
 /*
@@ -209,7 +207,7 @@ static int check_expected_revs(const char **revs, int rev_nr)
 }
 
 static int bisect_write(const char *state, const char *rev,
-			const struct bisect_terms *term, int nolog)
+			const struct bisect_terms *terms, int nolog)
 {
 	struct strbuf tag = STRBUF_INIT;
 	struct strbuf commit_name = STRBUF_INIT;
@@ -218,9 +216,9 @@ static int bisect_write(const char *state, const char *rev,
 	struct pretty_print_context pp = {0};
 	FILE *fp;
 
-	if (!strcmp(state, term->term_bad.buf))
+	if (!strcmp(state, terms->term_bad.buf))
 		strbuf_addf(&tag, "refs/bisect/%s", state);
-	else if(one_of(state, term->term_good.buf, "skip", NULL))
+	else if(one_of(state, terms->term_good.buf, "skip", NULL))
 		strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
 	else
 		return error(_("Bad bisect_write argument: %s"), state);
@@ -282,8 +280,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
 	};
-	struct bisect_terms state;
-	bisect_terms_init(&state);
+	struct bisect_terms terms;
+	bisect_terms_init(&terms);
 
 	argc = parse_options(argc, argv, prefix, options,
 			     git_bisect_helper_usage, 0);
@@ -317,13 +315,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc != 4 && argc != 5)
 			die(_("--bisect-write requires either 4 or 5 arguments"));
 		nolog = (argc == 5) && !strcmp(argv[4], "nolog");
-		strbuf_addstr(&state.term_good, argv[2]);
-		strbuf_addstr(&state.term_bad, argv[3]);
-		res = bisect_write(argv[0], argv[1], &state, nolog);
+		strbuf_addstr(&terms.term_good, argv[2]);
+		strbuf_addstr(&terms.term_bad, argv[3]);
+		res = bisect_write(argv[0], argv[1], &terms, nolog);
 		break;
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
-	bisect_terms_release(&state);
+	bisect_terms_release(&terms);
 	return res;
 }


Pranit Bauva (6):
  bisect--helper: `bisect_clean_state` shell function in C
  t6030: explicitly test for bisection cleanup
  wrapper: move is_empty_file() and rename it as
    is_empty_or_missing_file()
  bisect--helper: `bisect_reset` shell function in C
  bisect--helper: `is_expected_rev` & `check_expected_revs` shell
    function in C
  bisect--helper: `bisect_write` shell function in C

 builtin/am.c                |  20 +---
 builtin/bisect--helper.c    | 220 +++++++++++++++++++++++++++++++++++++++++++-
 cache.h                     |   3 +
 git-bisect.sh               |  97 ++-----------------
 t/t6030-bisect-porcelain.sh |  17 ++++
 wrapper.c                   |  13 +++
 6 files changed, 261 insertions(+), 109 deletions(-)

-- 
2.9.0

