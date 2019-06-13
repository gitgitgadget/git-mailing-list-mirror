Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 548651F462
	for <e@80x24.org>; Thu, 13 Jun 2019 21:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfFMVwG (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 17:52:06 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:42202 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfFMVwG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 17:52:06 -0400
Received: by mail-pg1-f202.google.com with SMTP id d3so278796pgc.9
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 14:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gOBCM0b/gdKvpOjQEZuZJZscDkYOWi69GKHebbse/3o=;
        b=gzPx3dlIvtvJaR03OkX1uNssnM+jPRCInDLV7SCXwiiXA7XYwvdL5/NaYUiZtmV1Kx
         53CteqdpwePmR0rShbk4D02XrLBSC6UacgvRKZaZJPJzs04vzTIWzl4TM6IRSnwYnrCq
         ORPDcbUGuNDgD3h5JYi8CRYohsSbP1bKy2t6W2twTx2rCBhPGuLwtl/ndiPudYuqe28s
         5ZlAhOix5FlTjOqthZ2pMgFGUfcLkdPLcsrzLt+bFqCa1ZOOsIfEojii7ry+FaPMrnk/
         4TJE+awqpQFWV2BLXWQsVa3FuHJXxz00Hu2ss3USipFQ4Rh7JjWvDtktRdbHFlRDtIr0
         kOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gOBCM0b/gdKvpOjQEZuZJZscDkYOWi69GKHebbse/3o=;
        b=C36GXAlTYY9SYMfSoe5eHAMUt1J5cXfPQ2R/F84x+Pfnvmooa2GPxiJnSmMg4MWgH2
         3QxglgrEQYTIWG65IMB4ICLHVBiI4U4WRg4dZIByfAZ0wRHYleXf78R4Frv+KldqgJgA
         NOCPkXisC0o7XS2wq7n73Sm9v0N/3INYC01jkCxaiQcMfCvoi+29JZvFUzNfTAGkwcVx
         MvWed7YIn5bSoQq47RMHVuV9CVPnxPpq7XuEZFajYARX709yfb7PZw9oz09+nJBZ9fcY
         tmU4v7B+cQAHgVQO7XSDZDiVIyfJ3btZOmPcoF7PwRPMZN8psH8xjFcZi3OzsPmD4pg8
         mmFQ==
X-Gm-Message-State: APjAAAX1q9GDI3WjwyywWBnAIXvy4q+KiM4xLDadrqHc6QAQM1IPSd7R
        cwzh/8IazO1FGG99dET0YO7vz5ptSnd0K4ZaUP9zd2x2VaVzSt8gDQlKtXxfXD3CuAJ9XEzOUc4
        WMxzpxkYg3r3uyBvLHbq8/Lv/DG8Y+FW56hRtGI1f3hgjK8vwhiQsLq+WqyM=
X-Google-Smtp-Source: APXvYqxs0qBnFuCBFteFwo79GDNSBmZn6OdaJPg+XDYfkJFDLEqmktjljIgBhkFSGVDZHvF9HARWxQ5tBRQv
X-Received: by 2002:a65:4307:: with SMTP id j7mr32594702pgq.91.1560462724923;
 Thu, 13 Jun 2019 14:52:04 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:51:33 -0700
In-Reply-To: <cover.1560462201.git.matvore@google.com>
Message-Id: <e2d87f8cb6a0079811386e701c7b9f90da163618.1560462201.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com> <cover.1560462201.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v3 10/10] list-objects-filter-options: make parser void
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function always returns 0, so make it return void instead.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter-options.c | 12 +++++-------
 list-objects-filter-options.h |  2 +-
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 9f08390628..a4ebf21a5b 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -222,21 +222,21 @@ static void transform_to_combine_type(
 	string_list_clear(&filter_options->sub[0].filter_spec, /*free_util=*/0);
 }
 
 void list_objects_filter_die_if_populated(
 	struct list_objects_filter_options *filter_options)
 {
 	if (filter_options->choice)
 		die(_("multiple filter-specs cannot be combined"));
 }
 
-int parse_list_objects_filter(
+void parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg)
 {
 	struct strbuf errbuf = STRBUF_INIT;
 	int parse_error;
 
 	if (!filter_options->choice) {
 		string_list_append(&filter_options->filter_spec, xstrdup(arg));
 
 		parse_error = gently_parse_list_objects_filter(
@@ -252,34 +252,32 @@ int parse_list_objects_filter(
 		filter_spec_append_urlencode(filter_options, arg);
 		ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
 			      filter_options->sub_alloc);
 
 		parse_error = gently_parse_list_objects_filter(
 			&filter_options->sub[filter_options->sub_nr - 1], arg,
 			&errbuf);
 	}
 	if (parse_error)
 		die("%s", errbuf.buf);
-	return 0;
 }
 
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset)
 {
 	struct list_objects_filter_options *filter_options = opt->value;
 
-	if (unset || !arg) {
+	if (unset || !arg)
 		list_objects_filter_set_no_filter(filter_options);
-		return 0;
-	}
-
-	return parse_list_objects_filter(filter_options, arg);
+	else
+		parse_list_objects_filter(filter_options, arg);
+	return 0;
 }
 
 const char *list_objects_filter_spec(struct list_objects_filter_options *filter)
 {
 	if (!filter->filter_spec.nr)
 		BUG("no filter_spec available for this filter");
 	if (filter->filter_spec.nr != 1) {
 		struct strbuf concatted = STRBUF_INIT;
 		strbuf_add_separated_string_list(
 			&concatted, "", &filter->filter_spec);
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index fe2e4d5649..0a48f541d2 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -69,21 +69,21 @@ void list_objects_filter_die_if_populated(
 	struct list_objects_filter_options *filter_options);
 
 /*
  * Parses the filter spec string given by arg and either (1) simply places the
  * result in filter_options if it is not yet populated or (2) combines it with
  * the filter already in filter_options if it is already populated. In the case
  * of (2), the filter specs are combined as if specified with 'combine:'.
  *
  * Dies and prints a user-facing message if an error occurs.
  */
-int parse_list_objects_filter(
+void parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg);
 
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset);
 
 #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
 	{ OPTION_CALLBACK, 0, CL_ARG__FILTER, fo, N_("args"), \
 	  N_("object filtering"), 0, \
 	  opt_parse_list_objects_filter }
-- 
2.21.0

