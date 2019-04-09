Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3ADA20248
	for <e@80x24.org>; Tue,  9 Apr 2019 20:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfDIUpa (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 16:45:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32948 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfDIUp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 16:45:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id h5so5827849pfo.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 13:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sJphvRYyyCt0zexZ7gmH0QnnJXS5WOL8mJImCVOfn2g=;
        b=gsuQR3AR0yaHtQB9PkS2WMtQ9q+8GuuSMvQwO+Dd31tfX5eM3zQ6YdLU7mtSJrsSEL
         HBD9kY6kWuDqsC3JpsIS/yGitrxHUd9Os2rOlHpUbzjjSl4Ta5kDdG52qm/z1cA/gP3B
         rVphUnkafs5jKkotWD7+SAjBcR6rPA79E19xmbW4hkJOOB0kVKnCKxnoxSlOuZjeKFmr
         kZBO6k0cGgCT/Qsj9yFw3u0oBEcMaOVdzPnh4OE0HBzpdct67/ReSrH4Q1OyrRu3GiWz
         lxXnbnA/sLe2p0EXXg0eP7hKDcRJJLZuWmLFAPFn4skwI+I3d5Q1yK0GX8eIUtPEGawQ
         m8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sJphvRYyyCt0zexZ7gmH0QnnJXS5WOL8mJImCVOfn2g=;
        b=mskFXvjOqxeRXC4gYFu1pHcx5lffRt/WHcNwiE5fXbAnV85Pukrwtt4AxGRKvU+qv9
         gIinPIPlLkhANtjP1ji+Ja+wbZDj7BPjG0cwpKmJYGPIR5GhuSyVXjmxxQGTEYchxx+Q
         ZhfrftUk+nJE41IFkJtkA+bdAH+20G/QBVZ3ZwRyHigkKsah7fpFKhtUrgfNUHwuFgu1
         Pdlbu/EV1YLPXPx79ClLWwXTv6jW47exTnA0XZDWXddHWMaEuEZ5iUyELBGw9IBZLFQ/
         hUfGc2rG4oom5Hu4CLqQT1JpSpPCpBr/yMX7A60OElt0wnnEi8buNrPYXO1algEA7rs6
         wG8Q==
X-Gm-Message-State: APjAAAVL8SEiiLnfhtavrXLXUdvQxgGH1iOPwyJxqrvJvTl5L2lQpXpj
        BJHNPiUa16ddDOm0uBmtodQ=
X-Google-Smtp-Source: APXvYqyeA/e5Qvl/WBfN0EFC9BjePPpbgboWPdA0Z2mheXGYuJkmEHqWHdV2KtOHJ2t5a3TEeX8jNw==
X-Received: by 2002:a63:78b:: with SMTP id 133mr6021605pgh.307.1554842727933;
        Tue, 09 Apr 2019 13:45:27 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id w23sm39182440pgj.72.2019.04.09.13.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 13:45:27 -0700 (PDT)
Date:   Tue, 9 Apr 2019 13:45:25 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 1/2] transport: warn if server options are unsupported
Message-ID: <20190409204525.GA92879@google.com>
References: <20190405204413.93900-1-jonathantanmy@google.com>
 <cover.1554841624.git.jonathantanmy@google.com>
 <af3cc05324f53316eedb2f437789eacb24c11489.1554841624.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af3cc05324f53316eedb2f437789eacb24c11489.1554841624.git.jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> Server options were added in commit 5e3548ef16 ("fetch: send server
> options when using protocol v2", 2018-04-24), supported only for
> protocol version 2. Add a warning if server options are specified for
> the user if a legacy protocol is used instead.
>
> An effort is made to avoid printing the same warning more than once by
> clearing transport->server_options after the warning, but this does not
> fully avoid double-printing (for example, when backfulling tags using
> another fetch with a non-reusable transport).
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  t/t5702-protocol-v2.sh | 17 +++++++++++++++++
>  transport.c            |  8 ++++++++
>  2 files changed, 25 insertions(+)

Thanks for writing this.  I'd be in favor of making this die().
Compare what we already do in push:

	if (args->push_options && !push_options_supported)
		die(_("the receiving end does not support push options"));

What happens in the case of push with protocol v0, where server options
are supported?

[...]
> --- a/transport.c
> +++ b/transport.c
> @@ -252,6 +252,12 @@ static int connect_setup(struct transport *transport, int for_push)
>  	return 0;
>  }
>  
> +static void warn_server_options_unsupported(struct transport *transport)
> +{
> +	warning(_("Ignoring server options because protocol version does not support it"));

nits:
- error and warning messages tend to use lowercase
- the user running into this may want to know how to switch to a better
  protocol version.  Is there e.g. a manpage we can point them to?

For example:

	fatal: server options require protocol version 2 or later
	hint: see protocol.version in "git help config" for more details

> +	transport->server_options = NULL;

Should this use a static to also warn only once in the tag-catchup case
you mentioned?

> +}
> +
>  /*
>   * Obtains the protocol version from the transport and writes it to
>   * transport->data->version, first connecting if not already connected.
> @@ -286,6 +292,7 @@ static struct ref *handshake(struct transport *transport, int for_push,
>  		break;
>  	case protocol_v1:
>  	case protocol_v0:
> +		warn_server_options_unsupported(transport);
>  		get_remote_heads(&reader, &refs,
>  				 for_push ? REF_NORMAL : 0,
>  				 &data->extra_have,
> @@ -363,6 +370,7 @@ static int fetch_refs_via_pack(struct transport *transport,
>  		break;
>  	case protocol_v1:
>  	case protocol_v0:
> +		warn_server_options_unsupported(transport);
>  		refs = fetch_pack(&args, data->fd, data->conn,

Looks like this only affects fetch, so the question above about push
is only about the commit message.

With whatever subset of the suggested changes makes sense,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
