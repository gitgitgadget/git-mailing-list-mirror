Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2A501F453
	for <e@80x24.org>; Fri, 25 Jan 2019 11:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfAYLWJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 06:22:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41443 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfAYLWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 06:22:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so9866563wrs.8
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 03:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PPMuOCrsdR06GjYQ5Nvv0rOFQtmQAZQIU9etL0sfhEE=;
        b=BZNl1uShhm40Fu+BoTpQeddzKARZC63jvZhe6XJDeDYoLQmTcYxmm7weqw1bTyjIU6
         pxQGuIXGo8k2c2q4hpPksXgqdp+UgKkgeqYAPkLHSbZ1ONGZF5tibR6hSCGcVXaEbTKQ
         6hxci3DegK9GLnPtHlkpnw5rLguET7PwnNTOnST3SX2vfzih96/wA0yZvrUfk/gD4OR0
         tC7soOYk7k/BFVS2mYs2mfO4qRYRaiSGR94nW2aV5xAHLAVk6tCl09SBeOXQlL/aFril
         vDESss0hGy45+0+/GbJLNmup2BXO8ddzfibCcfUvms//hznxU+MtiJyLqaWX24SMzf+0
         tzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PPMuOCrsdR06GjYQ5Nvv0rOFQtmQAZQIU9etL0sfhEE=;
        b=ryFriBVzfIu/Ohl4XRRbJPNGHoxmNFBL/m0CZPL55g2yUQyOCoQr3Yh8rfVFrKBZYC
         iMfTaIOvR9z639GSLrsvxhUmWL4/UeuESqJWeFfiwxWZb84jzJJnwQYQamKH0SDXCT4H
         cjKinJTcxrx6E61IJ00X0frlWHtHc0spygrtGLSrBebzxc50pAXEAuZrs94eyHosolIT
         IYo4CfI0A4hd0sSDYjo8yRBf8OdbBfiYj8gKUb9tbXv7S9tAmCF7SJJcogcatSi+z/BY
         upuMIB/QReBDkiYfb1THeUiUxYU56GVDLoFNTsIEEy6ph7lnDO355G777lNz2Jk8yn1c
         U5qg==
X-Gm-Message-State: AJcUukcTzoGWrgBOJARaaLBibw7zXSeh/0ZM0I3QYk+FQcnl+MQXn6Es
        CPHWe3pe9NSjtagW4UaM56E=
X-Google-Smtp-Source: ALg8bN5iZ5Tg3AjuTNbfX3SbW5ha2eJKHwixobIguP/ik/zeK3maOOWMEddXm7INFQNylGDe+7GOlg==
X-Received: by 2002:a5d:4303:: with SMTP id h3mr11173552wrq.273.1548415327125;
        Fri, 25 Jan 2019 03:22:07 -0800 (PST)
Received: from szeder.dev (x4db9b7c2.dyn.telefonica.de. [77.185.183.194])
        by smtp.gmail.com with ESMTPSA id p139sm126641484wmd.31.2019.01.25.03.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 03:22:06 -0800 (PST)
Date:   Fri, 25 Jan 2019 12:22:03 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/14] trace2: create new combined trace facility
Message-ID: <20190125112203.GB6702@szeder.dev>
References: <pull.108.git.gitgitgadget@gmail.com>
 <4aaf4834bfa9f2169e2c00f7cdc6c75281567c15.1548192131.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4aaf4834bfa9f2169e2c00f7cdc6c75281567c15.1548192131.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 22, 2019 at 01:22:14PM -0800, Jeff Hostetler via GitGitGadget wrote:
> diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
> new file mode 100644
> index 0000000000..035855d883
> --- /dev/null
> +++ b/trace2/tr2_tgt_perf.c
> @@ -0,0 +1,573 @@

> +static struct strbuf dots = STRBUF_INIT;

> +static void perf_fmt_prepare(
> +	const char *event_name, struct tr2tls_thread_ctx *ctx,
> +	const char *file, int line, const struct repository *repo,
> +	uint64_t *p_us_elapsed_absolute, uint64_t *p_us_elapsed_relative,
> +	const char *category, struct strbuf *buf)
> +{
> +	int len;
> +
> +	strbuf_setlen(buf,0);
> +
> +	if (!tr2env_perf_brief) {
> +
> +		struct tr2_tbuf tb_now;
> +
> +		tr2_tbuf_local_time(&tb_now);
> +		strbuf_addstr(buf, tb_now.buf);
> +		strbuf_addch(buf, ' ');
> +
> +		if (file && *file)
> +			strbuf_addf(buf, "%s:%d ", file, line);
> +		while (buf->len < TR2FMT_PERF_FL_WIDTH)
> +			strbuf_addch(buf, ' ');
> +
> +		strbuf_addstr(buf, "| ");
> +	}
> +
> +	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
> +	strbuf_addf(buf, "%-*s | %-*s | ",
> +		    TR2_MAX_THREAD_NAME, ctx->thread_name.buf,
> +		    TR2FMT_PERF_MAX_EVENT_NAME, event_name);
> +
> +	len = buf->len + TR2FMT_PERF_REPO_WIDTH;
> +	if (repo)
> +		strbuf_addf(buf, "r%d ", repo->trace2_repo_id);
> +	while (buf->len < len)
> +		strbuf_addch(buf, ' ' );
> +	strbuf_addstr(buf, "| ");
> +
> +	if (p_us_elapsed_absolute)
> +		strbuf_addf(buf, "%9.6f | ",
> +			    ((double)(*p_us_elapsed_absolute)) / 1000000.0);
> +	else
> +		strbuf_addf(buf, "%9s | ", " ");
> +
> +	if (p_us_elapsed_relative)
> +		strbuf_addf(buf, "%9.6f | ",
> +			    ((double)(*p_us_elapsed_relative)) / 1000000.0);
> +	else
> +		strbuf_addf(buf, "%9s | ", " ");
> +		
> +	strbuf_addf(buf, "%-*s | ", TR2FMT_PERF_CATEGORY_WIDTH,
> +		    (category ? category : ""));
> +
> +	if (ctx->nr_open_regions > 0) {
> +		int len_indent = TR2_INDENT_LENGTH(ctx);
> +		while (len_indent > dots.len) {
> +			strbuf_addf(buf, "%s", dots.buf);

Please use the much simpler are more idiomatic strbuf_addbuf()
function instead.

> +			len_indent -= dots.len;
> +		}
> +		strbuf_addf(buf, "%.*s", len_indent, dots.buf);
> +	}
> +}

> +static void fn_version_fl(const char *file, int line)
> +{
> +	const char *event_name = "version";
> +	struct strbuf buf_payload = STRBUF_INIT;
> +
> +	strbuf_addf(&buf_payload, "%s", git_version_string);

strbuf_addstr()

> +
> +	perf_io_write_fl(file, line, event_name, NULL,
> +			 NULL, NULL, NULL,
> +			 &buf_payload);
> +	strbuf_release(&buf_payload);
> +}
