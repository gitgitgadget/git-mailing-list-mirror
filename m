Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57A3E1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 22:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeBBWo7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 17:44:59 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43607 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBBWo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 17:44:57 -0500
Received: by mail-pg0-f66.google.com with SMTP id f6so3521705pga.10
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 14:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=E+kcZJdphPrrVAJ/BQONUE4eUE3Sn2nrOQDjsT0qADY=;
        b=o8743OitALflHvJpjjAzrxUUz9G2ufvnuodfGbQXZOnGzMYLO2SWdSFj0AToaB0FEE
         hUWARMNkllRYoZHglL1k27FHszubMNul+HQ/lM+Rp5AGcaMKCxEFSdhmxJDNOqsnjCZQ
         wV31J0+pzr4rzFffqEbzjAeJ3EklQZtnmQim1cTekbLNM59R2eFyDmZPqmpnbyilRT95
         tCs+WCel3o3sDl1C9f7Kg8whMKxJTctMV0eBj2UGqObY2dOJB1KDSYRdDo/INC5LjzB4
         JyfNlPbY/hysNQN15VY5lYDebGPcHuUfKjBVjCtLPLnvQfiVLdInSXNrLYttwcsNk3D2
         QsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E+kcZJdphPrrVAJ/BQONUE4eUE3Sn2nrOQDjsT0qADY=;
        b=kVpyMeLwX6Wh/njgG1SpOksLcVDqGb5TAZFZXFq3ZS0OIVttwdx9VTsNbqUNimRSzY
         sga3OoWqO/sipOlZylCbU2/eoU6xEsfDEnLWXnAk2hzkqFoFKOchQ2wTTRTH/OLXYwth
         3jnNWc7OtYxRUKNbOEOZxQPoVqQlYh779tpTevdXumpJJK1W+b3SZcqyGsnwuLZ20VrR
         OKY9D8y+wveuqhnWCMVbFMCSj6B1ZOjfMscOpb5fiSDPLSvbdAh8i4kTCe6ZkD+un/oI
         qpofTSBGPpNJAXw1jd3rbVedoWrOY1cFZcR/mETt/6qGUnMO+MQpghDvnL0zXVK6In54
         FoPQ==
X-Gm-Message-State: AKwxyteKaQnXoGmPGxRwqk88aCbtSGhiOOnEXJSdMUkyreMcWU/2Pn8t
        TAvW10pLvBSrqmrVTBgbUAQGSg==
X-Google-Smtp-Source: AH8x226e/m0tVRWbb1c2miW8wVT0vOXAj5H0u6puOPTrNzBnoaUmpyzxVmtuo4K51UTOL0+gexXZ3g==
X-Received: by 10.101.73.12 with SMTP id p12mr17548992pgs.286.1517611496657;
        Fri, 02 Feb 2018 14:44:56 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id k195sm4167186pgc.61.2018.02.02.14.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Feb 2018 14:44:55 -0800 (PST)
Date:   Fri, 2 Feb 2018 14:44:54 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, jrnieder@gmail.com
Subject: Re: [PATCH v2 10/27] protocol: introduce enum protocol_version value
 protocol_v2
Message-ID: <20180202224454.GB187827@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180125235838.138135-1-bmwill@google.com>
 <20180125235838.138135-11-bmwill@google.com>
 <815183f7-f449-1286-6dee-7cf6064bc5a1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <815183f7-f449-1286-6dee-7cf6064bc5a1@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/31, Derrick Stolee wrote:
> On 1/25/2018 6:58 PM, Brandon Williams wrote:
> > Introduce protocol_v2, a new value for 'enum protocol_version'.
> > Subsequent patches will fill in the implementation of protocol_v2.
> > 
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >   builtin/fetch-pack.c   | 3 +++
> >   builtin/receive-pack.c | 6 ++++++
> >   builtin/send-pack.c    | 3 +++
> >   builtin/upload-pack.c  | 7 +++++++
> >   connect.c              | 3 +++
> >   protocol.c             | 2 ++
> >   protocol.h             | 1 +
> >   remote-curl.c          | 3 +++
> >   transport.c            | 9 +++++++++
> >   9 files changed, 37 insertions(+)
> > 
> > diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> > index 85d4faf76..f492e8abd 100644
> > --- a/builtin/fetch-pack.c
> > +++ b/builtin/fetch-pack.c
> > @@ -201,6 +201,9 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
> >   			   PACKET_READ_GENTLE_ON_EOF);
> >   	switch (discover_version(&reader)) {
> > +	case protocol_v2:
> > +		die("support for protocol v2 not implemented yet");
> > +		break;
> >   	case protocol_v1:
> >   	case protocol_v0:
> >   		get_remote_heads(&reader, &ref, 0, NULL, &shallow);
> > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > index b7ce7c7f5..3656e94fd 100644
> > --- a/builtin/receive-pack.c
> > +++ b/builtin/receive-pack.c
> > @@ -1963,6 +1963,12 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
> >   		unpack_limit = receive_unpack_limit;
> >   	switch (determine_protocol_version_server()) {
> > +	case protocol_v2:
> > +		/*
> > +		 * push support for protocol v2 has not been implemented yet,
> > +		 * so ignore the request to use v2 and fallback to using v0.
> > +		 */
> > +		break;
> >   	case protocol_v1:
> >   		/*
> >   		 * v1 is just the original protocol with a version string,
> > diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> > index 83cb125a6..b5427f75e 100644
> > --- a/builtin/send-pack.c
> > +++ b/builtin/send-pack.c
> > @@ -263,6 +263,9 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
> >   			   PACKET_READ_GENTLE_ON_EOF);
> >   	switch (discover_version(&reader)) {
> > +	case protocol_v2:
> > +		die("support for protocol v2 not implemented yet");
> > +		break;
> >   	case protocol_v1:
> >   	case protocol_v0:
> >   		get_remote_heads(&reader, &remote_refs, REF_NORMAL,
> > diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
> > index 2cb5cb35b..8d53e9794 100644
> > --- a/builtin/upload-pack.c
> > +++ b/builtin/upload-pack.c
> > @@ -47,6 +47,13 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
> >   		die("'%s' does not appear to be a git repository", dir);
> >   	switch (determine_protocol_version_server()) {
> > +	case protocol_v2:
> > +		/*
> > +		 * fetch support for protocol v2 has not been implemented yet,
> > +		 * so ignore the request to use v2 and fallback to using v0.
> > +		 */
> > +		upload_pack(&opts);
> > +		break;
> >   	case protocol_v1:
> >   		/*
> >   		 * v1 is just the original protocol with a version string,
> > diff --git a/connect.c b/connect.c
> > index db3c9d24c..f2157a821 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -84,6 +84,9 @@ enum protocol_version discover_version(struct packet_reader *reader)
> >   	/* Maybe process capabilities here, at least for v2 */
> >   	switch (version) {
> > +	case protocol_v2:
> > +		die("support for protocol v2 not implemented yet");
> > +		break;
> >   	case protocol_v1:
> >   		/* Read the peeked version line */
> >   		packet_reader_read(reader);
> > diff --git a/protocol.c b/protocol.c
> > index 43012b7eb..5e636785d 100644
> > --- a/protocol.c
> > +++ b/protocol.c
> > @@ -8,6 +8,8 @@ static enum protocol_version parse_protocol_version(const char *value)
> >   		return protocol_v0;
> >   	else if (!strcmp(value, "1"))
> >   		return protocol_v1;
> > +	else if (!strcmp(value, "2"))
> > +		return protocol_v2;
> >   	else
> >   		return protocol_unknown_version;
> >   }
> > diff --git a/protocol.h b/protocol.h
> > index 1b2bc94a8..2ad35e433 100644
> > --- a/protocol.h
> > +++ b/protocol.h
> > @@ -5,6 +5,7 @@ enum protocol_version {
> >   	protocol_unknown_version = -1,
> >   	protocol_v0 = 0,
> >   	protocol_v1 = 1,
> > +	protocol_v2 = 2,
> >   };
> >   /*
> > diff --git a/remote-curl.c b/remote-curl.c
> > index 9f6d07683..dae8a4a48 100644
> > --- a/remote-curl.c
> > +++ b/remote-curl.c
> > @@ -185,6 +185,9 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
> >   			   PACKET_READ_GENTLE_ON_EOF);
> >   	switch (discover_version(&reader)) {
> > +	case protocol_v2:
> > +		die("support for protocol v2 not implemented yet");
> > +		break;
> >   	case protocol_v1:
> >   	case protocol_v0:
> >   		get_remote_heads(&reader, &list, for_push ? REF_NORMAL : 0,
> > diff --git a/transport.c b/transport.c
> > index 2378dcb38..83d9dd1df 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -203,6 +203,9 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
> >   	data->version = discover_version(&reader);
> >   	switch (data->version) {
> > +	case protocol_v2:
> > +		die("support for protocol v2 not implemented yet");
> > +		break;
> >   	case protocol_v1:
> >   	case protocol_v0:
> >   		get_remote_heads(&reader, &refs,
> > @@ -250,6 +253,9 @@ static int fetch_refs_via_pack(struct transport *transport,
> >   		refs_tmp = get_refs_via_connect(transport, 0);
> >   	switch (data->version) {
> > +	case protocol_v2:
> > +		die("support for protocol v2 not implemented yet");
> > +		break;
> >   	case protocol_v1:
> >   	case protocol_v0:
> >   		refs = fetch_pack(&args, data->fd, data->conn,
> > @@ -585,6 +591,9 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
> >   		args.push_cert = SEND_PACK_PUSH_CERT_NEVER;
> >   	switch (data->version) {
> > +	case protocol_v2:
> > +		die("support for protocol v2 not implemented yet");
> > +		break;
> >   	case protocol_v1:
> >   	case protocol_v0:
> >   		ret = send_pack(&args, data->fd, data->conn, remote_refs,
> 
> With a macro approach to version selection, this change becomes simpler in
> some ways and harder in others.
> 
> It is simpler in that we can have the macro from the previous commits just
> fall back to version 0 behavior.
> 
> It is harder in that this commit would need one of two options:
> 
> 1. A macro that performs an arbitrary statement when given v2, which would
> be the die() for these actions not in v2.
> 2. A macro that clearly states v2 is not supported and calls die() on v2.
> 
> Here is my simple, untested attempt at a union of these options:
> 
> #define ON_PROTOCOL_VERSION(version,v0,v2) switch(version) {\
> case protocol_v2:\
>     (v2);\
>     break;\
> case protocol_v1:\
> case protocol_v0:\
>     (v0);\
>     break;\
> case protocol_unknown_version:\
>     BUG("unknown protocol version");\
> }
> #define ON_PROTOCOL_VERSION_V0_FALLBACK(version,v0) switch(version) {\
> case protocol_v2:\
> case protocol_v1:\
> case protocol_v0:\
>     (v0);\
>     break;\
> case protocol_unknown_version:\
>     BUG("unknown protocol version");\
> }
> #define ON_PROTOCOL_VERSION_V0_ONLY(version,v0) \
>     ON_PROTOCOL_VERSION(version,v0,\
>                 BUG("support for protocol v2 not implemented yet"))


While I understand wanting to isolate the switch statement code, I think
that creating such a macro would make reading the code much more
difficult (and a pain to get right).  Really I don't want to try my hand
at crafting such a macro :D

-- 
Brandon Williams
