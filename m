Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9856CC433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D9822B42
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fXx5X2QX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHEUdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:33:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63948 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgHEUd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 16:33:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6CF72E624C;
        Wed,  5 Aug 2020 16:33:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ztyb9x9kJDRi3uWZKGhAShgs1NI=; b=fXx5X2
        QXO+A8TxAbKq0DmPgJAKbJXojDTl+GwxM2kd2mG7CL5zf2mEzxDWh6J2yyLsfU+1
        DI4kPecDxq+YCBBCvH6TGfY+Zh2TILyY+rYDiouKj/E4VPc9W35GN4SNWmnCbfU8
        Xw8n4l4xje0nvOTWbP25+jt6vrjJYDbcX3n54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k4J+Q8h2lQw2uq1LFliZckkd/vKDBcrp
        CW2wUWWf93zjGGrvrkLlug7wQGcfWDjpHk0XpZ0gosE31X6ks1MJWxvPAGmOyBpW
        3KqhcbDrR3nrXapfHABwC6DPQrnsMtQDdRZXCidQrCH1d8votNM+eiNHx64InRXL
        ZRdRnD50Edw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F3A2E624B;
        Wed,  5 Aug 2020 16:33:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4C65FE624A;
        Wed,  5 Aug 2020 16:33:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC PATCH 4/7] fetch: --stdin
References: <20200724223844.2723397-1-jonathantanmy@google.com>
        <cover.1596590295.git.jonathantanmy@google.com>
        <9ebcc5808a21e1f87370b6c18ea28168e63d4e3a.1596590295.git.jonathantanmy@google.com>
Date:   Wed, 05 Aug 2020 13:33:19 -0700
In-Reply-To: <9ebcc5808a21e1f87370b6c18ea28168e63d4e3a.1596590295.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 4 Aug 2020 18:20:47 -0700")
Message-ID: <xmqqft90omsw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7254A30-D75A-11EA-8D8C-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/fetch.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 3ccf69753f..a5498646bf 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -80,6 +80,7 @@ static struct list_objects_filter_options filter_options;
>  static struct string_list server_options = STRING_LIST_INIT_DUP;
>  static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
>  static int fetch_write_commit_graph = -1;
> +static int stdin_refspecs = 0;

Don't initialize statics to 0 (leave that to BSS).

> @@ -209,6 +210,8 @@ static struct option builtin_fetch_options[] = {
>  		 N_("check for forced-updates on all updated branches")),
>  	OPT_BOOL(0, "write-commit-graph", &fetch_write_commit_graph,
>  		 N_("write the commit-graph after fetching")),
> +	OPT_BOOL(0, "stdin", &stdin_refspecs,
> +		 N_("accept refspecs from stdin")),
>  	OPT_END()
>  };
>  
> @@ -1684,7 +1687,8 @@ static inline void fetch_one_setup_partial(struct remote *remote)
>  	return;
>  }
>  
> -static int fetch_one(struct remote *remote, int argc, const char **argv, int prune_tags_ok)
> +static int fetch_one(struct remote *remote, int argc, const char **argv,
> +		     int prune_tags_ok, int use_stdin_refspecs)
>  {
>  	struct refspec rs = REFSPEC_INIT_FETCH;
>  	int i;
> @@ -1741,6 +1745,13 @@ static int fetch_one(struct remote *remote, int argc, const char **argv, int pru
>  		}
>  	}
>  
> +	if (use_stdin_refspecs) {
> +		struct strbuf line = STRBUF_INIT;
> +		while (strbuf_getline_lf(&line, stdin) != EOF)
> +			refspec_append(&rs, line.buf);
> +		strbuf_release(&line);
> +	}

This will use refspecs both from the command line and the standard
input by appending?  IOW, these refspecs that came from the standard
input are treated otherwise identically to those that came from the
command line?

I do not particularly care whether it is "append to command line" or
"replace command line", as I do not think it makes much difference
in usability.  Just wanted to be sure you coded the behaviour you
wanted.

> @@ -1849,6 +1860,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  			die(_("--filter can only be used with the remote "
>  			      "configured in extensions.partialclone"));
>  
> +		if (stdin_refspecs)
> +			die(_("--stdin can only be used when fetching "
> +			      "from one remote"));

Is that only because you happened to have implemented the reading in
fetch_one() that is designed to be called once per remote?  

You could read them here to a refspec for everybody, and then pass a
pointer to that refspec as the extra parameter to fetch_one(), and
fetch_one() can use that by duplicating and appending to its "rs",
if we wanted to, no?  I do not know how important to support such a
use case, though.  It just feels a bit of shame if this restriction
is purely imposed by the implementation, when lifting the refstiction
does not seem too involved.

Thanks.


>  		if (max_children < 0)
>  			max_children = fetch_parallel_config;
