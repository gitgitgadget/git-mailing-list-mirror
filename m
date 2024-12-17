Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEB41E8823
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734441774; cv=none; b=krHjYAStoMRY0QDZ6j/iTvXgmOWCgB+pEqacg/2e3EyY1uISLhdi/cQXR8NWPfhbtDEkceEah71SAHB71RwgnYYT45fKl83iMReIduEjtqgYn04IMSv7uvngh1P3Z4vY3A0MviEd0AMpcLA1o2sRcPRxz6MPfc1AzwNgCg0UvUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734441774; c=relaxed/simple;
	bh=Y12+ynYrH/FB0OydLJKGwky4EvHZf9NpfRDfsAWYUqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWRwJQ9K8/cM5ThvrwI40aBOCKU/tOw0OzVGFjgxmnRyQwWVDoouicbq5fRYHCMRsCsMW63AOm5dIUNjJ3ecTXta+tpUtTk/BE08XxlVNIMkemidddEG3Nn4t9Bkkxn75keGPJn6A4vK2a0i90H+7mQoCE8BSCjAl+O3X7I2TTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=By74qeJt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By74qeJt"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2163bd70069so53750075ad.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 05:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734441773; x=1735046573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=22oA8EaAA1MTWePJbbYXLkpFqqSIxarPIgNKAzFy1lE=;
        b=By74qeJtJLeGvEcGuN3bIpcu/M6bG1o1p0tci+cZQDcyV0+l0ZsxGJWQ8Dk7iS/Jav
         uT4khkfAlHTqnj6v/bRQ7THGQXJIAe0N2sINDYCk/9xyLhguKDS22BinNFtyx9ewnAxi
         6+a/a5EIGY7sMXy9bDVluM6fSoEd9PBceWiuTU24ap6QmGrSg3IlRlFda+A5gvdSb0rW
         0pfK6hcjmSGpYyijfHtt2Y/PQgYzhPH+2bdiIEJCT8R0S0fGQs7ZTrS0HG9DZPhyQnVK
         ggfy/L7QAErvggsKs7aeI+8fzrTQ+VgJP05K5KjVPP3iB7p8Ganwhyeq2KSvWy5l/RMq
         P/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734441773; x=1735046573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22oA8EaAA1MTWePJbbYXLkpFqqSIxarPIgNKAzFy1lE=;
        b=GupfzUx5nSis4NLPvf/7+JICWUjBbQIwp7b1o3C31Q0gQJ5+Bm/T6+x3Pvut6n/xy+
         az3GXc0MQmMY1JipNpA9HL4cNlxH4vk1A0KptziwVQYiohngPpwOCWMt95Q4zkHqNp8Z
         cXSxZnYP/anEONNiDFEr482sP5nf+yrX/rrWZ4Lh8uarGNgc3WsCUGg4oNrTqhGfbJi3
         XVXr/NwmpVlF94FcEzpgixhCw71jEeheEvBrG5LvEoz6G7wpauWlUkxih1Ej1X1oK5wQ
         uB1fsR2R+UAOiZJHh2vhcz1Yd7hB/IMib2nKmmK0BxG5dNRcfqe+85XGtPRvb/TRyWF1
         AJOQ==
X-Gm-Message-State: AOJu0YwZ4Qv09wkoni+EKH7baAqqWmZPYtL0YnnRm9OgqFIHZ6QFEvs0
	l4/5/1Ifwxwozw2PY7mi9JRDrUphG0Cv+D2j0b8AhbOeP5m15V5f
X-Gm-Gg: ASbGncuCy68Pc1lQcPhS/yyYr9ma4tLZBTazOY2ofkZnQIPtXnn6ejMac0J9ASIzstV
	xGRdZIHuE15jEZNYAGhvOLFJ399cVuXPvcQioSrTK++9xm4Xi4SBURPN7l29sjX7JTHAGTl1LZ0
	6ukxVAqLdkehodddql0bzNRMTZaj72w7ZFNd0nJzDnGwDliUvfDx/ETz1HY18yzPsgDNQGG6j8e
	RqbMcVpagRIa0FkKiF5fAO58fcVESdC5xs08Xbn+2v1TV77JV3o
X-Google-Smtp-Source: AGHT+IHirfoZirBcBx22rTPdZf0PehFKnJ5oqp8VddtdYNGaWaH3YuTgF6syZAj2/l1oeyRB5megFA==
X-Received: by 2002:a17:902:db07:b0:216:7cde:51a with SMTP id d9443c01a7336-218929d82bbmr276863405ad.28.1734441772608;
        Tue, 17 Dec 2024 05:22:52 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e63751sm58891175ad.217.2024.12.17.05.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 05:22:52 -0800 (PST)
Date: Tue, 17 Dec 2024 21:23:32 +0800
From: shejialuo <shejialuo@gmail.com>
To: Wang Bing-hua via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Wang Bing-hua <louiswpf@gmail.com>
Subject: Re: [PATCH] remote: align --verbose output with spaces
Message-ID: <Z2F7VAsTjfBCVCrG@ArchLinux>
References: <pull.1837.git.1734439176360.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1837.git.1734439176360.gitgitgadget@gmail.com>

On Tue, Dec 17, 2024 at 12:39:36PM +0000, Wang Bing-hua via GitGitGadget wrote:
> From: Wang Bing-hua <louiswpf@gmail.com>
> 
> Remote names exceeding a tab width could cause misalignment.
> Align --verbose output with spaces instead of a tab.
> 

Good enhancement.

> Signed-off-by: Wang Bing-hua <louiswpf@gmail.com>
> ---
>     remote: align --verbose output with spaces
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1837%2Flouiswpf%2Fremote-align-verbose-output-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1837/louiswpf/remote-align-verbose-output-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1837
> 
>  builtin/remote.c  | 30 ++++++++++++++++++++++++++----
>  t/t5505-remote.sh |  4 ++--
>  2 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 1ad3e70a6b4..876274d9dca 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -16,6 +16,7 @@
>  #include "strvec.h"
>  #include "commit-reach.h"
>  #include "progress.h"
> +#include "utf8.h"
>  
>  static const char * const builtin_remote_usage[] = {
>  	"git remote [-v | --verbose]",
> @@ -1279,6 +1280,20 @@ static int get_one_entry(struct remote *remote, void *priv)
>  	return 0;
>  }
>  
> +static int calc_maxwidth(struct string_list *list)
> +{
> +	int max = 0;
> +
> +	for (int i = 0; i < list->nr; i++) {

Nit: we should use "size_t" to declare/define loop variable `i`
because the type of `list-nr` is `size_t`.

Recently, Patrick has provided a patch to start warn unsigned value
compared with signed value in [1] which has not been merged into the
master.

[1] https://lore.kernel.org/git/20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im

> +		struct string_list_item *item = list->items + i;
> +		int w = utf8_strwidth(item->string);
> +
> +		if (w > max)
> +			max = w;
> +	}
> +	return max;
> +}
> +

So, here we traverse the list to find the max "utf8_strwidth". However,
we should not EXPLICITLY traverse the string list. There are two ways
you could do:

1. Use the helper macro "for_each_string_list_item" in "string-list.h"
to do above.
2. Use the helper function "for_each_string_list" in "string-list.c" to
do above.

>  static int show_all(void)
>  {
>  	struct string_list list = STRING_LIST_INIT_DUP;
> @@ -1292,10 +1307,17 @@ static int show_all(void)
>  		string_list_sort(&list);
>  		for (i = 0; i < list.nr; i++) {
>  			struct string_list_item *item = list.items + i;
> -			if (verbose)
> -				printf("%s\t%s\n", item->string,
> -					item->util ? (const char *)item->util : "");
> -			else {
> +			if (verbose) {
> +				struct strbuf s = STRBUF_INIT;
> +
> +				strbuf_utf8_align(&s, ALIGN_LEFT,
> +						  calc_maxwidth(&list) + 1,
> +						  item->string);

So, here we call `calc_maxwidth` in the loop. That does not make sense.
We should not call this function when we are traversing the string list.
I think we should firstly calculate the max width outside of the loop.

Thanks,
Jialuo
