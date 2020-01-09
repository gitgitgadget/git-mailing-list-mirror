Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB01C282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 19:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05C92067D
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 19:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RS+RP4RP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbgAITHl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:07:41 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65107 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730193AbgAITHk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 14:07:40 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C476AA2EB2;
        Thu,  9 Jan 2020 14:07:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iQ52Bq60Y/DX3BJbiWBVWkCzA+U=; b=RS+RP4
        RPvPFQIxZkY+EJJthKnRZSKCwo+KoRK7xshoJqZPSdRtPIh103BK67Fm08K67220
        iZBSoNKHW3X8tHOeaA+EoQ/lQCXWYYUVQmt9ASVbb/3bVkGzPCXCHD2YthpSsLXe
        zLwy/xxOYDfqsZC4IJW40SCj1VHXs82tbGC9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MzBQ9lQIzchfG8bbnBleteI1RYCj+eiJ
        nJTFpHZxYP9eBrEj9Vn1AG6roVNz0QYEKJLBPoq0Xrb1hakKERNAahcHqghKxUGv
        H5rL5IhAqWOHr77YkbLUbn01dmPVDxB959lzx8KojdQS1des+H+KznsWZ+8DsMlY
        qDNrxblG01g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BAFB7A2EB1;
        Thu,  9 Jan 2020 14:07:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DE3B6A2EA3;
        Thu,  9 Jan 2020 14:07:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v2 1/4] config: fix typo in variable name
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
        <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
        <b40480f03a5643761bd06d4b9c495a99b98a1ac8.1578565001.git.gitgitgadget@gmail.com>
Date:   Thu, 09 Jan 2020 11:07:34 -0800
In-Reply-To: <b40480f03a5643761bd06d4b9c495a99b98a1ac8.1578565001.git.gitgitgadget@gmail.com>
        (Matthew Rogers via GitGitGadget's message of "Thu, 09 Jan 2020
        10:16:38 +0000")
Message-ID: <xmqqlfqgzbwp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C82AA04-3313-11EA-92D9-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Matthew Rogers <mattr94@gmail.com>
>
> In git config use of the end_null variable to determine if we should be
> null terminating our output.  While it is correct to say a string is
> "null terminated" the character is actually the "nul" character, so this
> malapropism is being fixed.
>
> Signed-off-by: Matthew Rogers <mattr94@gmail.com>
> ---
>  builtin/config.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Obviously correct.

Malapropism is a new word in "git log" output in our history ;-)

> diff --git a/builtin/config.c b/builtin/config.c
> index 98d65bc0ad..52a904cfb1 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -29,7 +29,7 @@ static int use_worktree_config;
>  static struct git_config_source given_config_source;
>  static int actions, type;
>  static char *default_value;
> -static int end_null;
> +static int end_nul;
>  static int respect_includes_opt = -1;
>  static struct config_options config_options;
>  static int show_origin;
> @@ -151,7 +151,7 @@ static struct option builtin_config_options[] = {
>  	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
>  	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
>  	OPT_GROUP(N_("Other")),
> -	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
> +	OPT_BOOL('z', "null", &end_nul, N_("terminate values with NUL byte")),
>  	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
>  	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
>  	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
> @@ -178,11 +178,11 @@ static void check_argc(int argc, int min, int max)
>  
>  static void show_config_origin(struct strbuf *buf)
>  {
> -	const char term = end_null ? '\0' : '\t';
> +	const char term = end_nul ? '\0' : '\t';
>  
>  	strbuf_addstr(buf, current_config_origin_type());
>  	strbuf_addch(buf, ':');
> -	if (end_null)
> +	if (end_nul)
>  		strbuf_addstr(buf, current_config_name());
>  	else
>  		quote_c_style(current_config_name(), buf, NULL, 0);
> @@ -678,7 +678,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		config_options.git_dir = get_git_dir();
>  	}
>  
> -	if (end_null) {
> +	if (end_nul) {
>  		term = '\0';
>  		delim = '\n';
>  		key_delim = '\n';
