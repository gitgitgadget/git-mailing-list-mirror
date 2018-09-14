Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4847D1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 05:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbeINLJ6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 07:09:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38348 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbeINLJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 07:09:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id x17-v6so3778447pfh.5
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 22:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Iuz80nAIpLkQRdy4Sh5hfLkoRWdtROSfITtEMvTMtvw=;
        b=jWKECxN8K92A6qTdlGs0nrhxpFi3DKG/EEVOsIFpRKbsmcHinSyU7FflUGItFBHINk
         9dxgNLn/hXIjCwj65kz/uvE5LCLhNQ7Z5WD1aMihGgTpi+R8Yfws35w8tm7pCVwIC0yb
         iZu/F7Y7DdJqZbVLwPQuM1UOHp+Jb0INL/PUXJcFjZ6jdpsP5GCPwx5fVNWzbDAAMs6T
         UwPNoHYURxJzhX6DtpzFC9NuKo3pAFtpA68yFk5/QFYHlmtNuyh54YDc+13rVsiuzTUG
         veWOVU07ade7qh70hl8och/QGas1Nt9xMyT8kSE/ARklB6tl+FkJXAHRhwTmvmxdxMyX
         uAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Iuz80nAIpLkQRdy4Sh5hfLkoRWdtROSfITtEMvTMtvw=;
        b=IW/8JJcbPiOp9stBAj47/U1GKxERSOuUM2UO4vgW9gwT39/uj4SLkzjxh6DAJlRH7n
         1rdiQj1LIhMq2XrihUbii9uWaLvldeVPt12y1Batb4HwHOsLA0+oYeslqFK5SgRWTADK
         zwUNeOrJGKHJ41XdmOdZx+0cbKGmAi2Uqx98sZ1OcXKsCH7H+SkNrJb+boWBZyxkeMGz
         16dpoUHRaR0bAMsMwaxmSTl0sKzv5yCC05vleWAmSsanOkmqYP/2J1dyW+z4ih63AjCU
         8csEpWWCuDRVVRtr01iXBWNNue/yc+PmSOJ2R9C2MjRxsw2MKjHc6aYoL4CSR40kXBYc
         I1ew==
X-Gm-Message-State: APzg51B9GkqQVxbbxh90TXDD6rv+qcUrdm/w4WByzy/lZDtEyihfRTyr
        wOrknMOgY8eqO46UiLt2Ld8=
X-Google-Smtp-Source: ANB0VdaCaPEenRT8WlrurlIOOhrbRrdxW4JmBVCwBfItw4+z4Ld2056UxQEK2lkCVm47rHS2r/4F8Q==
X-Received: by 2002:a63:170b:: with SMTP id x11-v6mr9816793pgl.364.1536904625581;
        Thu, 13 Sep 2018 22:57:05 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id u195-v6sm16928434pgb.21.2018.09.13.22.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 22:57:05 -0700 (PDT)
Date:   Thu, 13 Sep 2018 22:57:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 3/3] archive: allow archive over HTTP(S) with proto v2
Message-ID: <20180914055703.GC219147@aiede.svl.corp.google.com>
References: <20180912053519.31085-1-steadmon@google.com>
 <20180912053519.31085-4-steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912053519.31085-4-steadmon@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Josh Steadmon wrote:

> Subject: archive: allow archive over HTTP(S) with proto v2

It's interesting how little this has to touch the client.

> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  builtin/archive.c  |  8 +++++++-
>  http-backend.c     | 10 +++++++++-
>  transport-helper.c |  5 +++--
>  3 files changed, 19 insertions(+), 4 deletions(-)
[....]
> --- a/builtin/archive.c
> +++ b/builtin/archive.c
> @@ -87,7 +87,13 @@ static int run_remote_archiver(int argc, const char **argv,
>  		status = packet_reader_read(&reader);
>  		if (status != PACKET_READ_FLUSH)
>  			die(_("git archive: expected a flush"));
> -	}
> +	} else if (version == protocol_v2 &&
> +		   starts_with(transport->url, "http"))

As Stefan noticed, this starts_with test seems a bit too loose.  For
example, what happens if I try an scp-style SSH URL like
http.example.com:path/to/repo, a local path like http/foo/bar, or a
custom protocol like httplikebutbetter://path/to/repo (honest
question: I haven't tried)?

> +		/*
> +		 * Commands over HTTP require two requests, so there's an
> +		 * additional server response to parse.
> +		 */
> +		discover_version(&reader);

Can this be made consistent with the non-http case?  The original
capabilities (/info/refs) response told us what protocol version the
server wants to use, which means that a hypothetical protocol v3 could
use a completely different request format for the followup commands:
so could the server omit the protocol version in the v2
/git-upload-archive response?  Alternatively, if we want to include
the protocol version again, could we do that in stateful protocols as
well?

Related question: what should happen if the two responses declare
different protocol versions?  Should we diagnose that as a protocol
error?

[...]
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -32,6 +32,7 @@ struct rpc_service {
>  static struct rpc_service rpc_service[] = {
>  	{ "upload-pack", "uploadpack", 1, 1 },
>  	{ "receive-pack", "receivepack", 0, -1 },
> +	{ "upload-archive", "uploadarchive", 1, 1 },

shell.c orders these in almost-alphabetical order (receive-pack,
upload-pack, upload-archive).  I guess they should both use actual
alphabetical order?  (If you agree, then please feel free to do that
in a separate patch.)

[...]
> @@ -637,6 +638,12 @@ static void service_rpc(struct strbuf *hdr, char *service_name)
>  	struct rpc_service *svc = select_service(hdr, service_name);
>  	struct strbuf buf = STRBUF_INIT;
>  
> +	if (!strcmp(service_name, "git-upload-archive")) {
> +		/* git-upload-archive doesn't need --stateless-rpc */

This comment doesn't seem actionable.  Can it say why?  E.g. "[...]
because an upload-archive command always involves a single
round-trip".  Or alternatively, I think it's fine to omit the comment.

> +		argv[1] = ".";
> +		argv[2] = NULL;
> +	}
[...]
> @@ -713,7 +720,8 @@ static struct service_cmd {
>  	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.idx$", get_idx_file},
>  
>  	{"POST", "/git-upload-pack$", service_rpc},
> -	{"POST", "/git-receive-pack$", service_rpc}
> +	{"POST", "/git-receive-pack$", service_rpc},
> +	{"POST", "/git-upload-archive$", service_rpc},

Same comment about services seeming to be in a randomish order.

[...]
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -605,7 +605,8 @@ static int process_connect_service(struct transport *transport,
>  		ret = run_connect(transport, &cmdbuf);
>  	} else if (data->stateless_connect &&
>  		   (get_protocol_version_config() == protocol_v2) &&

(not about this patch) These parens don't help --- they make it harder
for me to read, especially with the new parens to try to match them up
with.

> -		   !strcmp("git-upload-pack", name)) {
> +		   (!strcmp("git-upload-pack", name) ||
> +		    !strcmp("git-upload-archive", name))) {

A part of me wonders about the wasted cycles comparing to
"git-upload-" twice, but (1) it is tiny relative to actually serving
the request and (2) if we're lucky, the compiler (or a compiler of the
future) inlines the strcmp call and could optimize it out.

[...]
> @@ -639,7 +640,7 @@ static int connect_helper(struct transport *transport, const char *name,
>  
>  	/* Get_helper so connect is inited. */
>  	get_helper(transport);
> -	if (!data->connect)
> +	if (!data->connect && !data->stateless_connect)
>  		die(_("operation not supported by protocol"));

I don't understand this part.  Can you explain it further (possibly by
putting it in its own patch)?

Thanks for a pleasant read,
Jonathan
