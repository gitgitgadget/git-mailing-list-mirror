Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4266C2BA19
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8597120724
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="kbDFgkX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgDXAjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:39:47 -0400
Received: from avasout07.plus.net ([84.93.230.235]:34441 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgDXAjr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 20:39:47 -0400
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id RmNcjRvEpsCJiRmNdjx4fg; Fri, 24 Apr 2020 01:39:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1587688785; bh=QetxJGjrHwODIJ8Saaq4itUstYI7zLKcycP05Y6GZNo=;
        h=Subject:To:References:From:Cc:Date:In-Reply-To;
        b=kbDFgkX2w9s6mEJu5pCkRKaRA9Z2oBsEbr4GThfGIaYMpSv/3DP3uElhRmAVVaFpE
         AW15a5TCrNRnjYRUDwh+7+iRcgT3xT9bsOQXl7qy0pOGmdRUPCOXDTZw2EsmbEYUiL
         pueHRg9A2c2GXx2ppiu4wqX035j3CiFnLcR4RasxdAYkKLGn1pkmKJMGayIns9D33e
         ZuEZDxD13Ni4BNFEsynUvj3prDtb679xRUbVq0ezUKc9r+rtyiOUGbG6Kip+0fLrJO
         KqMSgHLD+zlMW4Rk/8VUy9tXn/hoJfJqhc3QTu17RWeV9TRFSgK17m/fOi8K7BwQqb
         skmiQ1GqSd1ng==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=BPIoUGYG c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8 a=EBOSESyhAAAA:8 a=pGLkceISAAAA:8
 a=IlnIKXKsE3_y_3QO39QA:9 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/4] C: s/0/NULL/ for pointer type
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <c4fac2ae9d10bc426cb26e4a102b808549696763.1587648870.git.congdanhqx@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Message-ID: <1df91aa4-dda5-64da-6ae3-5d65e50a55c5@ramsayjones.plus.com>
Date:   Fri, 24 Apr 2020 01:39:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c4fac2ae9d10bc426cb26e4a102b808549696763.1587648870.git.congdanhqx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAZPJYG6p9I0+A6KdKEUFJ7NzgucHDryuzViMrqAbztMQjGyYNMDFzbfTZ7eSXGD66ot2MMEqR3KWlBk4ch1qQVycRovvcuG+MH4A2vRsrL/jLoM8CGz
 Udi56JGBn10Njo2/iOVh3BzMAKqCLbyYBCqt2tgVfq9/HDKwXsrw+ylvqgH8eljpLBsJLcznJmZtlg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 23/04/2020 14:47, Đoàn Trần Công Danh wrote:
> Fix warning from  `make sparse`.

You may want to split the changes to 't/helper/test-parse-pathspec-file.c'
into its own patch, since those changes are not potentially controversial.

The remainder of this patch follows a pattern that I used in a patch that
was rejected; see https://public-inbox.org/git/e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com/, et seq.

Actually, I have a patch somewhere which suppressed the sparse warning
for the '= { 0 }' token sequence used in these initializations. However,
I don't seem to be able to find them at the moment! :(

[Luc, this topic came up on the sparse and kernel mailing-lists at one
point, but I didn't get around to posting my patch to the list - something
came up. Hopefully, I will find some time to find it and post it soon.]

ATB,
Ramsay Jones

> 
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
>  add-interactive.c                   | 2 +-
>  builtin/fmt-merge-msg.c             | 2 +-
>  log-tree.c                          | 4 ++--
>  range-diff.c                        | 2 +-
>  t/helper/test-parse-pathspec-file.c | 6 +++---
>  5 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/add-interactive.c b/add-interactive.c
> index 29cd2fe020..b8983838b9 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -526,7 +526,7 @@ static int get_modified_files(struct repository *r,
>  
>  	for (i = 0; i < 2; i++) {
>  		struct rev_info rev;
> -		struct setup_revision_opt opt = { 0 };
> +		struct setup_revision_opt opt = { NULL };
>  
>  		if (filter == INDEX_ONLY)
>  			s.mode = (i == 0) ? FROM_INDEX : FROM_WORKTREE;
> diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
> index 172dfbd852..f4376bccef 100644
> --- a/builtin/fmt-merge-msg.c
> +++ b/builtin/fmt-merge-msg.c
> @@ -494,7 +494,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
>  		enum object_type type;
>  		unsigned long size, len;
>  		char *buf = read_object_file(oid, &type, &size);
> -		struct signature_check sigc = { 0 };
> +		struct signature_check sigc = { NULL };
>  		struct strbuf sig = STRBUF_INIT;
>  
>  		if (!buf || type != OBJ_TAG)
> diff --git a/log-tree.c b/log-tree.c
> index 0064788b25..ca721150d4 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -449,7 +449,7 @@ static void show_signature(struct rev_info *opt, struct commit *commit)
>  {
>  	struct strbuf payload = STRBUF_INIT;
>  	struct strbuf signature = STRBUF_INIT;
> -	struct signature_check sigc = { 0 };
> +	struct signature_check sigc = { NULL };
>  	int status;
>  
>  	if (parse_signed_commit(commit, &payload, &signature) <= 0)
> @@ -496,7 +496,7 @@ static int show_one_mergetag(struct commit *commit,
>  	struct object_id oid;
>  	struct tag *tag;
>  	struct strbuf verify_message;
> -	struct signature_check sigc = { 0 };
> +	struct signature_check sigc = { NULL };
>  	int status, nth;
>  	size_t payload_size;
>  
> diff --git a/range-diff.c b/range-diff.c
> index f745567cf6..71dcd947c5 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -107,7 +107,7 @@ static int read_patches(const char *range, struct string_list *list,
>  		}
>  
>  		if (starts_with(line, "diff --git")) {
> -			struct patch patch = { 0 };
> +			struct patch patch = { NULL };
>  			struct strbuf root = STRBUF_INIT;
>  			int linenr = 0;
>  
> diff --git a/t/helper/test-parse-pathspec-file.c b/t/helper/test-parse-pathspec-file.c
> index 02f4ccfd2a..b3e08cef4b 100644
> --- a/t/helper/test-parse-pathspec-file.c
> +++ b/t/helper/test-parse-pathspec-file.c
> @@ -6,7 +6,7 @@
>  int cmd__parse_pathspec_file(int argc, const char **argv)
>  {
>  	struct pathspec pathspec;
> -	const char *pathspec_from_file = 0;
> +	const char *pathspec_from_file = NULL;
>  	int pathspec_file_nul = 0, i;
>  
>  	static const char *const usage[] = {
> @@ -20,9 +20,9 @@ int cmd__parse_pathspec_file(int argc, const char **argv)
>  		OPT_END()
>  	};
>  
> -	parse_options(argc, argv, 0, options, usage, 0);
> +	parse_options(argc, argv, NULL, options, usage, 0);
>  
> -	parse_pathspec_file(&pathspec, 0, 0, 0, pathspec_from_file,
> +	parse_pathspec_file(&pathspec, 0, 0, NULL, pathspec_from_file,
>  			    pathspec_file_nul);
>  
>  	for (i = 0; i < pathspec.nr; i++)
> 
