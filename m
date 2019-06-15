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
	by dcvr.yhbt.net (Postfix) with ESMTP id B3E621F462
	for <e@80x24.org>; Sat, 15 Jun 2019 00:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfFOAm3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 20:42:29 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:36546 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFOAm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 20:42:28 -0400
Received: by mail-pl1-f202.google.com with SMTP id a5so2550437pla.3
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 17:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LJqTahfQp1GHPA0hdXpwIHROxCyOAyQjFVii8mbK+Uo=;
        b=DMJ74HxmUmRYyn88yRsXhfoXqQXe7CfFm7sQs9WgBpAoAuZbVExqQG8nTwX2Jpb53n
         b2z08slnBMAKZFK3dxw6MFig1HRIVMhzfdV9rrcsH6rlnvBg//eQhPcz+N4w5hlUNXse
         dmS11EFNDtHPRYNuQHCqQxUhSkeNOOHsotHWD9gUqvXzXgEr14y5sMtuLpIRCxFv1Gqb
         ZHMPYctCNIe4HDhhI5MWRyzKMG67As+PO8a8NPKKxuOQeRFPj6k38Tih+8ADjfO7dQRn
         sK/AC39wGgoFflkj9QrH8d91HU025JTVUalWJi/eegqxQ96tASAnMNrfDoTY4P4h8Jok
         DnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LJqTahfQp1GHPA0hdXpwIHROxCyOAyQjFVii8mbK+Uo=;
        b=RupEaINAPpsET4zmtzJcVDx9HHC+JfAsX66JL8eDeSTS1AZWFqm2QaUrfLSDwfzylR
         4Yz40+iHfFLKGbK2xUZ4ruemLO0Rle8zmEMANw6+Po6xke1kI/RuyCYJQTAdo6wYRISS
         fHnMBhD60ZKr/8/XtIwrqJKR3JeoD93g0wgp9dZ2oVYMNEYSBlf/kPfOB2GHRkGEodEQ
         TRurZXgXjggZ20Quuvnl0OxMZMASIeD4J7Me+7xy4VIIyKdMy0dra3cDv45Sqp75/94p
         E/6dhu/7/7WlkLiUWYX+6PoS+2IprsZTjfx+Qmw4o9oDzf9itC6Li++Eq+X+vbPNBGsR
         Omkw==
X-Gm-Message-State: APjAAAUnHhcFx3092VpLYqzw0Wlivi+BWQLNvOADgxjB36+UmdbZBsZd
        q9lvbFYH+uF9ERADLFT7k75FdHmhzkiQo3mzjkMQ9n0TNanNtRTTxNwwGHySabPzwauTV8BkWF6
        kPH+yw1b2DuluADmvo4FR0QIA0+GIJLjIeH1K93TBoujm/4mN6inV9+Yp06U=
X-Google-Smtp-Source: APXvYqwmC7s6Zn0FYxLRZtfnVKrsT0D2TAfvUCbFVGjPXPBGC4TD2clE8DVQb9oxlX3ao24un8ZUHZlWMgdz
X-Received: by 2002:a65:638a:: with SMTP id h10mr7713751pgv.64.1560559347604;
 Fri, 14 Jun 2019 17:42:27 -0700 (PDT)
Date:   Fri, 14 Jun 2019 17:40:16 -0700
In-Reply-To: <cover.1560558910.git.matvore@google.com>
Message-Id: <2f7566f697be759614a04c1277194f974bdcd662.1560558910.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com> <cover.1560558910.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v4 10/10] list-objects-filter-options: make parser void
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
index f07928ea21..e19ecdcafa 100644
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

