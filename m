Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0967C1F45F
	for <e@80x24.org>; Fri, 10 May 2019 12:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfEJMT7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 08:19:59 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36484 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfEJMT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 08:19:59 -0400
Received: by mail-yw1-f68.google.com with SMTP id q185so4577697ywe.3
        for <git@vger.kernel.org>; Fri, 10 May 2019 05:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=BKWtSgMc33v5axEm7FritOkdPgzXgNusPTq+6xqE6mE=;
        b=ZKtYLXzORBSmwrWjL/d9iiu6wMa1sguJNqyrsF5qshuQAu4ApZ/iqvzAAlKfXpzAvc
         3fTFY3Xy/KaaGusoDq9crWDNb8r07hERqTdcXPQ/yMj8l7K9EfPps81WoAknUUk+HB3u
         tmvG0lxb1NjsVPm315kvQfyX48079r7Vq9BoNIRsB+db2A+zlRB59Qi/UiK1BkOD17fq
         5CuSYd4K2FlCkPwyNEeCfoU7M3b2g+QE48Ai4Zc5zz9VIMKIegssxd0lyQE8wULaB6t1
         KiEDT4XSyRXbHi3gWwcTZ/mS+12hLjblMXPjAZVJb7aeWlSbdg26VRBq5TBFLWZj38AL
         kTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BKWtSgMc33v5axEm7FritOkdPgzXgNusPTq+6xqE6mE=;
        b=EIVQo7Wu4eee0zzpWa6OYVgel+nt6vN+FZToluQPmzoODwOuGF05eEUnqWAs9nVlaT
         gvdSczGyqD4tFZLxrU6wiRy18FVvwV6SlT5+lbFVp9c0Rge+BkUtWFUuFrWKZjt/D968
         hOJiV2I6mn5nCKW+uoc9lk5naAKf3YunD+B2fOoDgaGHMxlK/0ZsHuLpc5ndwB4LuNHe
         bXQ1hqIhtIlR6J9UWdHDdhuzDPWl6ZKsFKqrlbSFQEy2f4rxXmGTS+IdBiZzwvxEiyrx
         Gv3VNShJ5Fv6vMoY/q7k1PByrTS6ze3RPsJX0cTBAff/IkBupy5XvQoJVX5tgGGxRihz
         9PNg==
X-Gm-Message-State: APjAAAVasTv/mxAVbSNt7Q/r7pTthnjWQlObPAgIiD91ZPXnMggt4zlk
        5WmLhctsn6H1PGNCs6FRmE33ZaOKePs=
X-Google-Smtp-Source: APXvYqw/LE95+MuH3GjemI19lZNZxPB0HQ981EBfzrKFwiH5wfw0cdN3lk/tuQx53AmChul/MuNQAg==
X-Received: by 2002:a0d:ec10:: with SMTP id v16mr5522631ywe.15.1557490798465;
        Fri, 10 May 2019 05:19:58 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id t206sm1433113ywt.109.2019.05.10.05.19.57
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 05:19:57 -0700 (PDT)
Subject: Re: [PATCH 14/14] verify-commit: simplify parameters to
 run_gpg_verify()
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20190509212558.GA15438@sigill.intra.peff.net>
 <20190509213229.GN15837@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f0d06858-038b-793e-b1fe-faedff7963ef@gmail.com>
Date:   Fri, 10 May 2019 08:19:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190509213229.GN15837@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/9/2019 5:32 PM, Jeff King wrote:
> Instead, let's do our type check by loading the object via
> parse_object(). That will attach the buffer to the struct so it can be
> used later by check_commit_signature(). And it ensures that
> lookup_commit() will return something sane.

This is a good idea.
  
> -static int run_gpg_verify(const struct object_id *oid, const char *buf, unsigned long size, unsigned flags)
> +static int run_gpg_verify(struct commit *commit, unsigned flags)
>  {
>  	struct signature_check signature_check;
>  	int ret;
>  
>  	memset(&signature_check, 0, sizeof(signature_check));
>  
> -	ret = check_commit_signature(lookup_commit(the_repository, oid),
> -				     &signature_check);
> +	ret = check_commit_signature(commit, &signature_check);
>  	print_signature_buffer(&signature_check, flags);

Bonus drop of the_repository.

>  
>  	signature_check_clear(&signature_check);
> @@ -38,26 +37,20 @@ static int run_gpg_verify(const struct object_id *oid, const char *buf, unsigned
>  
>  static int verify_commit(const char *name, unsigned flags)
>  {
> -	enum object_type type;
>  	struct object_id oid;
> -	char *buf;
> -	unsigned long size;
> -	int ret;
> +	struct object *obj;
>  
>  	if (get_oid(name, &oid))
>  		return error("commit '%s' not found.", name);
>  
> -	buf = read_object_file(&oid, &type, &size);
> -	if (!buf)
> +	obj = parse_object(the_repository, &oid);

...and it is back, but "higher" up. That's fine.

> +	if (!obj)
>  		return error("%s: unable to read file.", name);
> -	if (type != OBJ_COMMIT)
> +	if (obj->type != OBJ_COMMIT)
>  		return error("%s: cannot verify a non-commit object of type %s.",
> -				name, type_name(type));
> -
> -	ret = run_gpg_verify(&oid, buf, size, flags);
> +				name, type_name(obj->type));
>  
> -	free(buf);
> -	return ret;
> +	return run_gpg_verify((struct commit *)obj, flags);
>  }

You pointed out that you thought this patch was subtle. I agree that
there is a slightly changed functionality, but it seems to be
improving a possibly wrong behavior.

Thanks,
-Stolee
