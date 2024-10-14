Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE1414B96E
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899370; cv=none; b=Vn3aATxoNSGzEc1Ubjr7MPTqSiESCXIISGfQ+pUV9OrTBZyVSEUTTsAM/8squ9e9LK7vQmRAcTNqmRKGtlBOHjCEqdznNK1kxJcxgP75ZKLIpqDkGnUbXU0vXReNFWwgPiLNcduYh6LFULsAXgpzGcy1QVBsrx685NsmVuOvLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899370; c=relaxed/simple;
	bh=FIggrQ7T6xtPTqzp926LQ2I0zZCzCPS1NsXgvtqdslM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mE8Xk4ItZeozjNNhIymo/yfIaq3rHWwX0cbk0sxr+1viWQxrcsffEz7mSyYN4QfHTlfUlMumTRZc+pMLpGoTfcUMkfcIiRcxh+AyMucEAeBaWAq7hEMf4PWfpAs0hvhw33Vtpy5CTEt31C35Og9BL4G0sg0f1Sq+KEAhfYd26RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P98j006y; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P98j006y"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d5038c653so2475757f8f.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 02:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728899366; x=1729504166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D2r3YBYLe92CEVfKsKdOucVWiRFz+siyjamsGpYBzTQ=;
        b=P98j006y11MVtYlRv/v6hN3cCxSG3O6VeeCUm7uWoAv7as0gYL510N95xs9pa34qHQ
         vMAag6DUF5T9pCw+fN8NvUveymjSS+m2b/Y0x7kbm30zF0n3HefyaQwkUa+wbO2hRclu
         mbzcg/HhSq3exrCeknRvxOxpC7MoUDCpH1bmd5H/Nue9UcFA2lG2XHlUwuqmiHmUHpe9
         m0pD5aeXJixvaEAFdhZYVWXjNHogyOdzsIVGkDojP2SK0RwzX0maIKhlKkz+3PnUbxgB
         nvpSs/0fBsPhbxx13JhPkYfAwtqxlBbBaviOYcJTQ0qecyEfGbncKgcZ0POgk1I0FCtx
         4h6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728899366; x=1729504166;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2r3YBYLe92CEVfKsKdOucVWiRFz+siyjamsGpYBzTQ=;
        b=BIuTzeEbR0H/s3RaMvi6VLPOkOZ6FZp6/Gue5k+OlZ0kY3RFPXof4CR+d4n18deQUI
         OD12jOSD42eLThyu6ILtw5Rzfdu1Pvfz2SLz7lu358judHStltBU8pKq0fak325Dxfnu
         qmGdb1cCG3VZbtw/J0v5tOh37RiA4ix3xLZ4vPjMcMZLtyw98MrCSgnVy2U775aWv95a
         4TOn1LzJaB/WECob4/c3Ws52WS/Ad+QsJNdVH1wFPAHF2/rIOX++0h6tSAd0ND4uz2u0
         2PhhnlDaK6A6KPVn6smFEF8AyYK82hRKMZQCmRd8luf9tThUFrdyjaG8LAaNUQn0Kf36
         7q3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXa30cHJbpQdKa3yMZ7qzMqpiz4w/9xIzEw6QOxGfChiORqIjeNCJDYiQmCohTOb2umeYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOoAZJIUpfCgdQ7n8qrTs31fOCr/I+CjUdyQ5vpve7uOWoyNyf
	UNJr7zVWFeiPVqU/uLXXRlXjFpd5V5STT18+DUScc5SRXL3UAcFH8vgmFQ==
X-Google-Smtp-Source: AGHT+IF0lVGBT0CYuimUUqSr/XXJKzdW8w1c5edd7Hbkv1twq/23/xdIiqwszpoHCZxMleyYhlj76A==
X-Received: by 2002:a05:6000:4598:b0:37d:4e74:67c with SMTP id ffacd0b85a97d-37d5529ade4mr7453287f8f.39.1728899366069;
        Mon, 14 Oct 2024 02:49:26 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ef213sm10908640f8f.99.2024.10.14.02.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 02:49:25 -0700 (PDT)
Message-ID: <6875cb49-becc-4562-ace8-9f07848a345c@gmail.com>
Date: Mon, 14 Oct 2024 10:49:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and
 strtol_i()
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Usman

On 13/10/2024 00:09, Usman Akinyemi via GitGitGadget wrote:
> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> 
> Replace unsafe uses of atoi() with strtoul_ui() for unsigned integers
> and strtol_i() for signed integers across multiple files. This change
> improves error handling and prevents potential integer overflow issues.

This paragraph is good as it explains why you are making this change

> The following files were updated:
> - daemon.c: Update parsing of --timeout, --init-timeout, and
>    --max-connections
> - imap-send.c: Improve parsing of UIDVALIDITY, UIDNEXT, APPENDUID, and
>    tags
> - merge-ll.c: Enhance parsing of marker size in ll_merge and
>    ll_merge_marker_size

This information is not really needed in the commit message as it is 
shown in the diff.

> This change allows for better error detection when parsing integer
> values from command-line arguments and IMAP responses, making the code
> more robust and secure.

Great

> This is a #leftoverbit discussed here:
>   https://public-inbox.org/git/CAC4O8c-nuOTS=a0sVp1603KaM2bZjs+yNZzdAaa5CGTNGFE7hQ@mail.gmail.com/
> 
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> 
> Cc: gitster@pobox.com
> Cc: Patrick Steinhardt <ps@pks.im>
> Cc: phillip.wood123@gmail.com
> Cc: Christian Couder <christian.couder@gmail.com>
> Cc: Eric Sunshine <sunshine@sunshineco.com>
> Cc: Taylor Blau <me@ttaylorr.com>

We do not tend to use Cc: footers on this list. Also note that as there 
is a blank line between the Signed-off-by: line and this paragraph the 
Signed-off-by: will be ignored by git-interpret-trailers.

> ---
>   daemon.c    | 14 +++++++++-----
>   imap-send.c | 13 ++++++++-----
>   merge-ll.c  |  6 ++----
>   3 files changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/daemon.c b/daemon.c
> index cb946e3c95f..3fdb6e83c40 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1308,17 +1308,21 @@ int cmd_main(int argc, const char **argv)
>   			continue;
>   		}
>   		if (skip_prefix(arg, "--timeout=", &v)) {
> -			timeout = atoi(v);
> +			if (strtoul_ui(v, 10, &timeout) < 0) {

For functions that return 0 or -1 to indicate success or error 
respectively we use "if (func(args))" to check for errors.

> +				die("'%s': not a valid integer for --timeout", v);

"-1" is a valid integer but it is not a valid timeout, maybe we could 
say something like "invalid timeout '%s', expecting a non-negative integer".

> +			}
>   			continue;
>   		}
>   		if (skip_prefix(arg, "--init-timeout=", &v)) {
> -			init_timeout = atoi(v);
> +			if (strtoul_ui(v, 10, &init_timeout) < 0) {
> +				die("'%s': not a valid integer for --init-timeout", v);

The comments for --timeout apply here as well

> +			}
>   			continue;
>   		}
>   		if (skip_prefix(arg, "--max-connections=", &v)) {
> -			max_connections = atoi(v);
> -			if (max_connections < 0)
> -				max_connections = 0;	        /* unlimited */
> +			if (strtol_i(v, 10, &max_connections) != 0 || max_connections < 0) {

This is a faithful translation but if the aim of this series is to 
detect errors then I think we want to do something like

	if (strtol_i(v, 10, &max_connections))
		die(...)
	if (max_connections < 0)
		max_connections = 0; /* unlimited */

> +				max_connections = 0;  /* unlimited */
> +			}
>   			continue;
>   		}
>   		if (!strcmp(arg, "--strict-paths")) {
> diff --git a/imap-send.c b/imap-send.c
> index ec68a066877..33b74dfded7 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -668,12 +668,12 @@ static int parse_response_code(struct imap_store *ctx, struct imap_cmd_cb *cb,
>   		return RESP_BAD;
>   	}
>   	if (!strcmp("UIDVALIDITY", arg)) {
> -		if (!(arg = next_arg(&s)) || !(ctx->uidvalidity = atoi(arg))) {
> +		if (!(arg = next_arg(&s)) || strtol_i(arg, 10, &ctx->uidvalidity) != 0) {

The original is checking for a zero return from atoi() which indicates 
an error or that the parsed value was zero. To do that with strtol_i() 
we need to do

	|| (strtol_i(arg, 10, &ctx->uidvalidity) || !ctx->uidvalidity)

The IMAP RFC[1] specifies that UIDVALIDITY should be a non-zero, 
non-negative 32bit integer but I'm not sure we want to start change it's 
type and using strtoul_ui here.

[1] https://www.rfc-editor.org/rfc/rfc3501#section-2.3.1.1

>   			fprintf(stderr, "IMAP error: malformed UIDVALIDITY status\n");
>   			return RESP_BAD;
>   		}
>   	} else if (!strcmp("UIDNEXT", arg)) {
> -		if (!(arg = next_arg(&s)) || !(imap->uidnext = atoi(arg))) {
> +		if (!(arg = next_arg(&s)) || strtol_i(arg, 10, &imap->uidnext) != 0) {

The comments above apply here

>   			fprintf(stderr, "IMAP error: malformed NEXTUID status\n");
>   			return RESP_BAD;
>   		}
> @@ -686,8 +686,8 @@ static int parse_response_code(struct imap_store *ctx, struct imap_cmd_cb *cb,
>   		for (; isspace((unsigned char)*p); p++);
>   		fprintf(stderr, "*** IMAP ALERT *** %s\n", p);
>   	} else if (cb && cb->ctx && !strcmp("APPENDUID", arg)) {
> -		if (!(arg = next_arg(&s)) || !(ctx->uidvalidity = atoi(arg)) ||
> -		    !(arg = next_arg(&s)) || !(*(int *)cb->ctx = atoi(arg))) {
> +		if (!(arg = next_arg(&s)) || (strtol_i(arg, 10, &ctx->uidvalidity) != 0) ||
> +			!(arg = next_arg(&s)) || (strtol_i(arg, 10, (int *)cb->ctx) != 0)) {

And here

>   			fprintf(stderr, "IMAP error: malformed APPENDUID status\n");
>   			return RESP_BAD;
>   		}
> @@ -773,7 +773,10 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
>   			if (!tcmd)
>   				return DRV_OK;
>   		} else {
> -			tag = atoi(arg);
> +			if (strtol_i(arg, 10, &tag) != 0) {

To check for an error just use (strtol_i(arg, 10, &tag))

> +				fprintf(stderr, "IMAP error: malformed tag %s\n", arg);
> +				return RESP_BAD;

This matches the error below so I assume it's good.

> +			}
>   			for (pcmdp = &imap->in_progress; (cmdp = *pcmdp); pcmdp = &cmdp->next)
>   				if (cmdp->tag == tag)
>   					goto gottag;
> diff --git a/merge-ll.c b/merge-ll.c
> index 8e63071922b..2bfee0f2c6b 100644
> --- a/merge-ll.c
> +++ b/merge-ll.c
> @@ -427,8 +427,7 @@ enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
>   	git_check_attr(istate, path, check);
>   	ll_driver_name = check->items[0].value;
>   	if (check->items[1].value) {
> -		marker_size = atoi(check->items[1].value);
> -		if (marker_size <= 0)
> +		if (strtol_i(check->items[1].value, 10, &marker_size) != 0 || marker_size <= 0)

Here I think we want to return an error if we cannot parse the marker 
size and then set the default if the marker size is <= 0 like we do for 
the max_connections code in daemon.c above.

>   			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
>   	}
>   	driver = find_ll_merge_driver(ll_driver_name);
> @@ -454,8 +453,7 @@ int ll_merge_marker_size(struct index_state *istate, const char *path)
>   		check = attr_check_initl("conflict-marker-size", NULL);
>   	git_check_attr(istate, path, check);
>   	if (check->items[0].value) {
> -		marker_size = atoi(check->items[0].value);
> -		if (marker_size <= 0)
> +		if (strtol_i(check->items[0].value, 10, &marker_size) != 0 || marker_size <= 0)

And the same here

Thanks for working on this, it will be a useful improvement to our 
integer parsing. I think you've got the basic idea, it just needs a bit 
of polish

Phillip

