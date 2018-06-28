Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F2A71F516
	for <e@80x24.org>; Thu, 28 Jun 2018 22:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966629AbeF1W14 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 18:27:56 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:39309 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935019AbeF1W1z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 18:27:55 -0400
Received: by mail-wm0-f41.google.com with SMTP id p11-v6so114622wmc.4
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 15:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yl0L3XwL3QrPKNe6TrAgfk/SeIZObzDrX+LMnyrsAZs=;
        b=KQe2Joj16N4GUOTW228YDs5wU5Wh2k33vT9pNF73ofOUTgy5/NKYlg8UGdqSnUSSVN
         1yr7igqMn8+KBGB/kRzSaDo0SFJ3IggLrFusi8zubOHDx7Np/Q+cS9PkgxJQkuD7Qigd
         8AUZh+Z/JIf9Z8Gkk8lbd1d0M1a6G3JEXQXkoisVB4W8mSbXSLhn6ThI+mpVgRxc4Tz6
         LnWCv0rvdVCZ897i5uotKdy9OtxvWiGSBVoIw6+OYH+mp51UkLHip/vja0LxdC0b+AJW
         KI1wy3joK8xpIh9yhmGyhULfNjGO3HDsu6bgG99Jiy/8QqZHnhvP6xo0OYv1MfXMiMLm
         WZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yl0L3XwL3QrPKNe6TrAgfk/SeIZObzDrX+LMnyrsAZs=;
        b=pZeOOiip+cidoQwzCnTfpgXTm6QEEPQAT+rDYmxxIJDMAxEjSk1s1LTC145y4DQOB6
         Quv+1bNKDsDcgcrk+yy7FcqU6sf+WFJd5fAj/DEl4sSET/jvh8LhIJz2WJ4yzGJ18m/Y
         ZPQLNwfrnfJ4HZ3m5rHHCWCj+9pa15yPIHsB3ldUNb2hACmSel2qEh/CJh+JIgCf/rKj
         XHpjbZJ7cLZdxlJzrES2ymWEItj75MqjwtaPApQWshEzy+Y9dtimJcd687khNTR/Et8v
         FA8jAFC6jpq0wKGoAhHtfVcsJg4zgkbbHSG72vJ2W3lvImcjokZc1OdHEWdCqJ76dUES
         vyyQ==
X-Gm-Message-State: APt69E0qGH4P4ozpM+L/ZvOVh7iXblNDi5ZV/HN+095p/11T63VtC59R
        Pn4enpaP+yDn9fz/vOFmUYk=
X-Google-Smtp-Source: AAOMgpcY0RTLXqapFobmSo2QOi9LfMvdnVsK6Q23f0Qo3kwOoNhfXMPlbjPPzZh2eS+V4hbHkRCVFA==
X-Received: by 2002:a1c:d602:: with SMTP id n2-v6mr9274355wmg.150.1530224873924;
        Thu, 28 Jun 2018 15:27:53 -0700 (PDT)
Received: from localhost.localdomain (x4db1165b.dyn.telefonica.de. [77.177.22.91])
        by smtp.gmail.com with ESMTPSA id l15-v6sm10245525wrs.95.2018.06.28.15.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jun 2018 15:27:52 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Jameson Miller <jamill@microsoft.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>
Subject: Re: [PATCH v5 2/8] read-cache: make_cache_entry should take object_id struct
Date:   Fri, 29 Jun 2018 00:27:44 +0200
Message-Id: <20180628222744.10496-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.273.g57f1ecce9c
In-Reply-To: <20180628135932.225288-3-jamill@microsoft.com>
References: <20180620201557.77155-1-jamill@microsoft.com> <20180628135932.225288-1-jamill@microsoft.com> <20180628135932.225288-3-jamill@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The make_cache_entry function should take an object_id struct instead
> of sha.


> diff --git a/read-cache.c b/read-cache.c
> index fa8366ecab..9624ce1784 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -746,8 +746,10 @@ int add_file_to_index(struct index_state *istate, const char *path, int flags)
>  }
> 
>  struct cache_entry *make_cache_entry(unsigned int mode,
> -		const unsigned char *sha1, const char *path, int stage,
> -		unsigned int refresh_options)
> +				     const struct object_id *oid,
> +				     const char *path,
> +				     int stage,
> +				     unsigned int refresh_options)
>  {
>  	int size, len;
>  	struct cache_entry *ce, *ret;
> @@ -761,7 +763,7 @@ struct cache_entry *make_cache_entry(unsigned int mode,
>  	size = cache_entry_size(len);
>  	ce = xcalloc(1, size);
> 
> -	hashcpy(ce->oid.hash, sha1);
> +	hashcpy(ce->oid.hash, oid->hash);

Speaking of using struct object_id instead of sha, please use oidcpy()
here.

