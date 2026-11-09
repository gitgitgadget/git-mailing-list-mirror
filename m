Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231921;
	b=kMcy2Iz6T6uBBl1/cVlz13Ghye8NmfeJL/WD8UDwdYkup7AE7bEgEFhwrR8jfFPNVA4s
	 Y0ohOqJDjTb04WE2WpYS61nC4x+UsFlP56bpjm2ivieWGsTCyFd4rgEUw92/7gASmwiYR
	 2CRA0Qy/KnMRUP0+gnzfu57U5WOI2KiYNbdSRRZvsG7DcktXpUUJt4L/dkzjA71DzoXl/
	 cpVAAZ5+c92Hp5NJuP4hbf2IGy5ysT3gwzluZ6LxdA7JbbYUjLNuOG8nUT2r7BEVHP9aP
	 Uz/dCXkFkgi1tS9lAI/NbjO1Q4w0r6hwduLujuAL7bEV7tptzNFDY1K+gxZW/c0inoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=YhtUaDld4uJp2++VSlK5eD3pRAdQ+oigC5aJ/UcMPc8=;
	b=xaJuebumfVJJdhuy9vtLP7C3VWuSAv6jShsnbb6eRaHq0Y9RNXYi0dx+0BK46ktIkUSJ
	 3XnhVd0bocumjzODrMa1JQSGw1ON653WZ2w3PWYs4UFkpPJ//87+VUcwY4EXdiQmvqAbm
	 xW1c+hEpuN0HsfatI0QyqAtG68xyst5g7lRWWPzrIhh+aP8qoE+gx5wLh+87h8n9qzjfV
	 EhnlR91CXt2ohOC45NmiO/zJ1H9OQsLew2kxUbd9oF1jLeOxPJAo6InkyDvwyk/5+srpd
	 f8gPxtOXcjZSk9R8Kfr5hioAAL/w6uH/2P/luOek/j3M/UEGagmselKh8xZp9TdwP0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pCAYKS1A;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F40B606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 13:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F40B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pCAYKS1A
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-536c8f958d7so6536921cf.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 05:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794231920; x=1794836720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YhtUaDld4uJp2++VSlK5eD3pRAdQ+oigC5aJ/UcMPc8=;
        b=pCAYKS1APIVnHm+gTLSFZ2XdqOyBgrNwkhWqz3hWUfElWNmtabE6F5cSyxStq/xPDI
         8nGxlndjJ1Q8eiqH/zOhtqcDsWrCEdHEJd+7n4KXfUYtgwJcmQAzkOQ3A7YtOMCakFOf
         Xb2ki2D8aKoYWVVgjBz126HbkIl//KCvfpY4GU8tYGPjYS/4yUiBX06AJe9s1HXh0a+9
         uGyBviyhlvX8b6opQumrXDqzllCfrV83mCAxoGXuZq4PQordIVUXJYsu86Bn8yUBmaOF
         evLr9cAtxcg66z6NqSg2e91oJf1nJHb3h27y4rUDaqAUAM4oahna/u1dHwR9PyCQyBvN
         3WWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794231920; x=1794836720;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YhtUaDld4uJp2++VSlK5eD3pRAdQ+oigC5aJ/UcMPc8=;
        b=k1zl9PcX4fcntjnVbRODNktpSNwCBNsJiKpSIsgU7JqO7Lu+wiEYReRV7bo3my5XcO
         EaP8HYPX8LEHqrIF1RdMM8hVsjBjztZknsexoHWy+zvQWCH9W6eUTZO/7N6SXpIyvc2I
         Jgz2mvOLNCg2x23m7dP/EdfVZu9H2uTjXX12b7yIm32w0EOOaKio76CAaGMCcpG3Ho9q
         pKSycWcDeJmXshwso+lKHrKtdUotHoIKNKnGzv3o6DhWmVPq3stflPDkuIfa/G98n3K1
         ONIdtn0vRHMexIsqgkNwJxS2gR7hwMsG/hPBp6QVcPwCH/eyLo/d9WWr7Ijv6H8PZrA/
         Qn/w==
X-Gm-Message-State: APuU4Z8//vaKAK9EdiStGgAzANV4zHHfyBX6i5O4dW+4EH/XPsNMyIhq
	2MIEoTua/MdhejJ7TvuCXOMsE1kXPr0GoYVt6ajqEraR9rs4udVSPwX9bqFuFw==
X-Gm-Gg: AYBFou2m7/j/FaNawJDeQoBRdqONVhqGSlQZmJguzbOD8RFh+Yf2lSaCWM+JSV9eMlH
	5/rkMlWlRhQpT9K1CiRFq0iTvugUCLTKcGD0yx/hIMkTt/M0CwnTf7P9/jrHeOnFXi/N7IT1UgI
	Ry3XaAF6tXxOY1T8lPbIaPAj+Y9XUA0mCWqGP8tvqgUz1hDPfaLjrV2lfPP7wq557qSosePe+XY
	tzAq/NGfro94kvT7DLWiBP1xaQEtXl4mGXCicB4vAS+9KXM6CMhAx1CzHPUdgVf0wj+v46rwYef
	WKx5uC/UtH0LaX1HXW1HSLKbIuP9/ZNoTX3xxYoh0b2fS7uOWdyFcpSqdsp69LQ4pzmtp6yVCH/
	i/5xJugiV7RKUk8FtUJjIWCjjZwOZxHIyO0E0neHaoP5phMc4snlK/M1VLvSQX838OrT3UJxTBE
	arxs72P9PWoPm5k8rPlAHknPGaI0KRI8T32/dTdo387d8mTh5VR2kaFiFZwK19FZw/hb0dAKhYs
	4KDStjkWu/7p5SO/mpWtfBz9K8qNoqugViaMgG9BfRU59i/jjSFAQDMVlr7GgMCIYic77NQ04rw
	52geoFdypIREcE8kJ9JqfSa/MbVw8t4I+9OHlILOzH6VQ9Q/dARVLNl7n3YMYy0OLlgheP1CjYL
	JxAEAZSlJQrNq3CeUn8ZwJL3FMLQUc7uPWG7UROaQX4WW6OosnZuOjTP/ViACRyO8WhZrPmRGo/
	REAEOXAXl5H6wRRSngpTaPs6E+bfW5BXhinjzj5GglUCQFgPM7XOfc8sMJwlteGY5yNXrm0LEwb
	jwF
X-Received: by 2002:a05:622a:a6d4:b0:537:a19e:5561 with SMTP id d75a77b69052e-552a5b71444mr46346451cf.43.1794231920249;
        Mon, 09 Nov 2026 05:45:20 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55264341ad0sm41124111cf.16.2026.11.09.05.45.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 05:45:19 -0800 (PST)
Message-ID: <784778b3-173d-4226-ae9e-4efcd4f556af@gmail.com>
Date: Mon, 9 Nov 2026 08:45:19 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] unpack-trees: lose USE_THE_REPOSITORY
To: git@vger.kernel.org
References: <xmqqtsltbfdv.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqtsltbfdv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/2026 8:26 PM, Junio C Hamano wrote:
> This file defines a set of fairly low level functions to implement
> merge and checkout behaviour, many of which depended on and can only
> work with the_repository.
> 
> Two key data structures passed around in the code paths, "struct
> unpack_trees_options" and "struct index_state", both have a pointer
> to the repository instance, and we can use it to make it work on an
> arbitrary repository, not just the_repository.
> 
> In any correctly written clients of this library file, the
> repository instance that is pointed at by these two structs MUST be
> the same one.  For now, make sure that is the case (and otherwise
> BUG out) by introducing a unpack_repo() helper function that takes
> these two structures (when available) and returns the repository.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * I wrote this change when I ranted in
> 
>    https://lore.kernel.org/git/xmqq33tdcuub.fsf@gitster.g/
> 
>    on 'seen', and "git checkout -m --detach master" was sufficient
>    to build and start a new branch based on 'master' and there
>    wasn't any need for adjustment.  All tests seem to pass.
> 
>  unpack-trees.c | 94 ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 76 insertions(+), 18 deletions(-)
> 
> diff --git a/unpack-trees.c b/unpack-trees.c
> index d6a859420f..79341d7fa6 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1,4 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE
>  #define DISABLE_SIGN_COMPARE_WARNINGS
>  
>  #include "git-compat-util.h"
> @@ -82,6 +81,56 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
>  	  ? ((o)->internal.msgs[(type)])      \
>  	  : (unpack_plumbing_errors[(type)]) )
>  
> +
> +/*
> + * Some functions in these code paths get unpack_trees_options, which
> + * has up to two istates, and some get an istate.  These istates can
> + * be used to find the repository to be used for this operation.
> + *
> + * As these are all working on the same repository, they must match.
> + * For now, with a super paranoid check, make sure all potential
> + * sources of the information match before using it.
> + *
> + * Once this proves working well, we could just use the first one we
> + * find in a production setting.
> + */
> +static struct repository *unpack_repo(struct index_state *istate,
> +				      struct unpack_trees_options *o)
> +{
> +	struct repository *repo = NULL;
> +	const char *camefrom = NULL;
Overall, this is a good helper implementation.

> +	if (!repo)
> +		BUG("no repository for unpack_trees()?");
> +	return repo;
> +
> +}

nit: extra empty line.

>  static const char *super_prefixed(const char *path, const char *super_prefix)
>  {
>  	/*
> @@ -345,15 +394,16 @@ static void load_gitmodules_file(struct index_state *index,
>  				 struct checkout *state)
>  {
>  	int pos = index_name_pos(index, GITMODULES_FILE, strlen(GITMODULES_FILE));
> +	struct repository *repo = unpack_repo(index, NULL);
>  
>  	if (pos >= 0) {
>  		struct cache_entry *ce = index->cache[pos];
>  		if (!state && ce->ce_flags & CE_WT_REMOVE) {
> -			repo_read_gitmodules(the_repository, 0);
> +			repo_read_gitmodules(repo, 0);
>  		} else if (state && (ce->ce_flags & CE_UPDATE)) {
> -			submodule_free(the_repository);
> +			submodule_free(repo);
>  			checkout_entry(ce, state, NULL, NULL);
> -			repo_read_gitmodules(the_repository, 0);
> +			repo_read_gitmodules(repo, 0);
>  		}
>  	}

This sample of how it is used makes it clear how this is a
valuable abstraction.

Thanks,
-Stolee


