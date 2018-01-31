Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFE9D1F404
	for <e@80x24.org>; Wed, 31 Jan 2018 14:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753184AbeAaOyo (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 09:54:44 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44641 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752643AbeAaOyn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 09:54:43 -0500
Received: by mail-qt0-f194.google.com with SMTP id l20so22093942qtj.11
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 06:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2xxpgYtvW1Sbqa+uQSWkWcAj1VKz9Un2AYJunR0mDxI=;
        b=A2xomTZYNfh3QGfbhVCBv8sMAd2Byt62AtRZuS4sKeoH9C/PEC91sZvonbnSVjQHSG
         lSDDOpM8ntvriV7Tp5LT94NPHIjyU7w0Osw5Ybu0NaGTkaqlv9tR3IVbmy6rLV2qK4s9
         1b2bUWHwbVwVfo3PEV42RzAnhO1dw3nNzkPm6YmwX9/XYERowHT4066aXactF/pHhd4p
         pqURgRTf9K1FsTvjW5hMxXIjEa3qUV5ICQ+uq67yu1h0TWD/x2PJePNZQrMucixkoV8j
         cweivPl4Kbxzl42ScTvrsZQlVzoum/VSX1+CiSi6RkoNZwcvLc621v+R+tJhcmmV8+N/
         qOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2xxpgYtvW1Sbqa+uQSWkWcAj1VKz9Un2AYJunR0mDxI=;
        b=rLekUlEjbX5TN+PXDtr8hXKqaZ79ZlVts7SRoKlv53QQYuqb3vy191y9ZOLOzxOe0y
         iEHcNumnqcJ9EkdPGDbd76bX1kvkMchd5Wn1JXV+4P80J4nx7lSqr/WePAxE8BYIhepU
         DS2XUJpiWfdIzhvarC97AdOYaghUyR33XL2h5xJgSy+CYbK+BhHotE5omMwI2641DHYf
         V4FoOingdT3hEiksgw7jaZ2bGvcwbb3sPUp3A4Try5oj0Jykqa/8KB0hypGRcrV+P50r
         1NBN5T0Rj1fMZdX5svpkzJzwqRj1cWHIPI1rA5VLLvJQdwuUFGCqbQNzFs1LbceX9Bf6
         AfwQ==
X-Gm-Message-State: AKwxytdJ0JhJEb8pTWqByTYZNDXoJ8LGh4sfPaeYbxicyR4izA0ejC63
        IYgkQn6VveljH8Kofa1Hcw8=
X-Google-Smtp-Source: AH8x224/2snrn6AW2vMn/mL1Bv7a23M62ZaPnm1uNDhnvV3VAxbZJyHQJA1X7cS+fYyVHh7nTGjfSg==
X-Received: by 10.200.53.209 with SMTP id l17mr46813258qtb.273.1517410482600;
        Wed, 31 Jan 2018 06:54:42 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id v190sm10869855qkb.90.2018.01.31.06.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 06:54:42 -0800 (PST)
Subject: Re: [PATCH v2 10/27] protocol: introduce enum protocol_version value
 protocol_v2
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, jrnieder@gmail.com
References: <20180103001828.205012-1-bmwill@google.com>
 <20180125235838.138135-1-bmwill@google.com>
 <20180125235838.138135-11-bmwill@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <815183f7-f449-1286-6dee-7cf6064bc5a1@gmail.com>
Date:   Wed, 31 Jan 2018 09:54:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180125235838.138135-11-bmwill@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/25/2018 6:58 PM, Brandon Williams wrote:
> Introduce protocol_v2, a new value for 'enum protocol_version'.
> Subsequent patches will fill in the implementation of protocol_v2.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>   builtin/fetch-pack.c   | 3 +++
>   builtin/receive-pack.c | 6 ++++++
>   builtin/send-pack.c    | 3 +++
>   builtin/upload-pack.c  | 7 +++++++
>   connect.c              | 3 +++
>   protocol.c             | 2 ++
>   protocol.h             | 1 +
>   remote-curl.c          | 3 +++
>   transport.c            | 9 +++++++++
>   9 files changed, 37 insertions(+)
>
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index 85d4faf76..f492e8abd 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -201,6 +201,9 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>   			   PACKET_READ_GENTLE_ON_EOF);
>   
>   	switch (discover_version(&reader)) {
> +	case protocol_v2:
> +		die("support for protocol v2 not implemented yet");
> +		break;
>   	case protocol_v1:
>   	case protocol_v0:
>   		get_remote_heads(&reader, &ref, 0, NULL, &shallow);
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index b7ce7c7f5..3656e94fd 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1963,6 +1963,12 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>   		unpack_limit = receive_unpack_limit;
>   
>   	switch (determine_protocol_version_server()) {
> +	case protocol_v2:
> +		/*
> +		 * push support for protocol v2 has not been implemented yet,
> +		 * so ignore the request to use v2 and fallback to using v0.
> +		 */
> +		break;
>   	case protocol_v1:
>   		/*
>   		 * v1 is just the original protocol with a version string,
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 83cb125a6..b5427f75e 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -263,6 +263,9 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>   			   PACKET_READ_GENTLE_ON_EOF);
>   
>   	switch (discover_version(&reader)) {
> +	case protocol_v2:
> +		die("support for protocol v2 not implemented yet");
> +		break;
>   	case protocol_v1:
>   	case protocol_v0:
>   		get_remote_heads(&reader, &remote_refs, REF_NORMAL,
> diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
> index 2cb5cb35b..8d53e9794 100644
> --- a/builtin/upload-pack.c
> +++ b/builtin/upload-pack.c
> @@ -47,6 +47,13 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
>   		die("'%s' does not appear to be a git repository", dir);
>   
>   	switch (determine_protocol_version_server()) {
> +	case protocol_v2:
> +		/*
> +		 * fetch support for protocol v2 has not been implemented yet,
> +		 * so ignore the request to use v2 and fallback to using v0.
> +		 */
> +		upload_pack(&opts);
> +		break;
>   	case protocol_v1:
>   		/*
>   		 * v1 is just the original protocol with a version string,
> diff --git a/connect.c b/connect.c
> index db3c9d24c..f2157a821 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -84,6 +84,9 @@ enum protocol_version discover_version(struct packet_reader *reader)
>   
>   	/* Maybe process capabilities here, at least for v2 */
>   	switch (version) {
> +	case protocol_v2:
> +		die("support for protocol v2 not implemented yet");
> +		break;
>   	case protocol_v1:
>   		/* Read the peeked version line */
>   		packet_reader_read(reader);
> diff --git a/protocol.c b/protocol.c
> index 43012b7eb..5e636785d 100644
> --- a/protocol.c
> +++ b/protocol.c
> @@ -8,6 +8,8 @@ static enum protocol_version parse_protocol_version(const char *value)
>   		return protocol_v0;
>   	else if (!strcmp(value, "1"))
>   		return protocol_v1;
> +	else if (!strcmp(value, "2"))
> +		return protocol_v2;
>   	else
>   		return protocol_unknown_version;
>   }
> diff --git a/protocol.h b/protocol.h
> index 1b2bc94a8..2ad35e433 100644
> --- a/protocol.h
> +++ b/protocol.h
> @@ -5,6 +5,7 @@ enum protocol_version {
>   	protocol_unknown_version = -1,
>   	protocol_v0 = 0,
>   	protocol_v1 = 1,
> +	protocol_v2 = 2,
>   };
>   
>   /*
> diff --git a/remote-curl.c b/remote-curl.c
> index 9f6d07683..dae8a4a48 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -185,6 +185,9 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
>   			   PACKET_READ_GENTLE_ON_EOF);
>   
>   	switch (discover_version(&reader)) {
> +	case protocol_v2:
> +		die("support for protocol v2 not implemented yet");
> +		break;
>   	case protocol_v1:
>   	case protocol_v0:
>   		get_remote_heads(&reader, &list, for_push ? REF_NORMAL : 0,
> diff --git a/transport.c b/transport.c
> index 2378dcb38..83d9dd1df 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -203,6 +203,9 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
>   
>   	data->version = discover_version(&reader);
>   	switch (data->version) {
> +	case protocol_v2:
> +		die("support for protocol v2 not implemented yet");
> +		break;
>   	case protocol_v1:
>   	case protocol_v0:
>   		get_remote_heads(&reader, &refs,
> @@ -250,6 +253,9 @@ static int fetch_refs_via_pack(struct transport *transport,
>   		refs_tmp = get_refs_via_connect(transport, 0);
>   
>   	switch (data->version) {
> +	case protocol_v2:
> +		die("support for protocol v2 not implemented yet");
> +		break;
>   	case protocol_v1:
>   	case protocol_v0:
>   		refs = fetch_pack(&args, data->fd, data->conn,
> @@ -585,6 +591,9 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
>   		args.push_cert = SEND_PACK_PUSH_CERT_NEVER;
>   
>   	switch (data->version) {
> +	case protocol_v2:
> +		die("support for protocol v2 not implemented yet");
> +		break;
>   	case protocol_v1:
>   	case protocol_v0:
>   		ret = send_pack(&args, data->fd, data->conn, remote_refs,

With a macro approach to version selection, this change becomes simpler 
in some ways and harder in others.

It is simpler in that we can have the macro from the previous commits 
just fall back to version 0 behavior.

It is harder in that this commit would need one of two options:

1. A macro that performs an arbitrary statement when given v2, which 
would be the die() for these actions not in v2.
2. A macro that clearly states v2 is not supported and calls die() on v2.

Here is my simple, untested attempt at a union of these options:

#define ON_PROTOCOL_VERSION(version,v0,v2) switch(version) {\
case protocol_v2:\
     (v2);\
     break;\
case protocol_v1:\
case protocol_v0:\
     (v0);\
     break;\
case protocol_unknown_version:\
     BUG("unknown protocol version");\
}
#define ON_PROTOCOL_VERSION_V0_FALLBACK(version,v0) switch(version) {\
case protocol_v2:\
case protocol_v1:\
case protocol_v0:\
     (v0);\
     break;\
case protocol_unknown_version:\
     BUG("unknown protocol version");\
}
#define ON_PROTOCOL_VERSION_V0_ONLY(version,v0) \
     ON_PROTOCOL_VERSION(version,v0,\
                 BUG("support for protocol v2 not implemented yet"))
