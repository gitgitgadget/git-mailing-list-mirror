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
	by dcvr.yhbt.net (Postfix) with ESMTP id ADA2B1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 22:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfF0Wyt (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 18:54:49 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:48589 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfF0Wyt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 18:54:49 -0400
Received: by mail-ua1-f74.google.com with SMTP id s14so613708uap.15
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 15:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e3qcG3oNQpxCOKE5EH7WjZS4k/Idsi7oJfpaycVLTxc=;
        b=LnORr4f+Jy+nfosQ7tIYaMeqJwhlsbzGuREUk4HaA94N7nTgOAwYVOELuco0lGsTs6
         JX9BlZy4YHuEouGiqi4VD2NL++ZrzXEc5ix52hRqKGmyBBS/OMdQb0T4j9K4sAhppXC2
         R+B68mJPqNbBPZLn3BCflI+V3OH5ZaU/FPsrRYLEz4V84qUtxUlXQTXpL8WA8xs4pqLE
         NOsKg6yFb4rFQbZG0uHlPI41bnUR71UTSsIKix6PwDMTzbs5X4r2wGkNwosN9X4AuhU4
         /qWqHF9oVqaMmgPYSDee34Cz7icRhxxQIQHY5cd33W9Gi7fY82Gz0pk0akg7ygvhIt+9
         7mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e3qcG3oNQpxCOKE5EH7WjZS4k/Idsi7oJfpaycVLTxc=;
        b=bz4Ymv4X0CjFkir4FxupBKQNY6flHutxfUYImzxMDpD/04/OEWUoUJ0dzecYgMsNYq
         J1CAghuh0w9F5+SA8iwU9fxtLfK7ih5A7xDkcgCUie6j0qNC+UIAsnRmIpDBffE/CrYJ
         LQSEeMG7oHjiQug96m/8YF3OQrErmF7JUod8dxbIwsxwjr4XniL8wKor7TzFkKBIhj8f
         o+XUQQwlCdaT75pnwZkQK0or46/xiFoWrRrufY9TaTZHcBnKlx5441TRNAh1KVh9mwH1
         s6HOFdocJ4WwzXHOaZcxu6cIrOt+gdKL5BFgKrngoaBvWtTMypTT660RVor7ih1r5GeU
         jg9g==
X-Gm-Message-State: APjAAAXkZiitWl2lpHsiwSS9SkCWzbsNz0MbGOK7NJqO9LNxHdizLpps
        hALhn426pNQ64UBiRs2qCLy1iO7pXmToYRQP2tPcqZBiaIordQuOah9QGtUzKccENo5Chj4HYuJ
        v8K+7EVDjl6yzizByBKzRgDJOWmX9BF5Oo5gHUL3d1UUbSPjyeekuv2+nbjQ=
X-Google-Smtp-Source: APXvYqz8ybpFH295rhV5ax0xF6flDm2k9Bs/3yzRvgpa+wptG7Gov3sfQDUhMbbp1YuNkMHDoxrikL7cil8z
X-Received: by 2002:a1f:2909:: with SMTP id p9mr2554669vkp.23.1561676088288;
 Thu, 27 Jun 2019 15:54:48 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:54:14 -0700
In-Reply-To: <cover.1561675151.git.matvore@google.com>
Message-Id: <c0b9243ab488633245153782da9820027790c533.1561675151.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com> <cover.1561675151.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 10/10] list-objects-filter-options: make parser void
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net,
        Johannes.Schindelin@gmx.de
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
index 44bc1153d1..ba1425cb4a 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -225,21 +225,21 @@ static void transform_to_combine_type(
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
@@ -255,34 +255,32 @@ int parse_list_objects_filter(
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
index d8bc7e946e..db37dfb34a 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -67,21 +67,21 @@ void list_objects_filter_die_if_populated(
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

