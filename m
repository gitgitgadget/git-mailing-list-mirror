Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AAAF1F406
	for <e@80x24.org>; Tue, 15 May 2018 17:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbeEOR5v (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 13:57:51 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40223 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeEOR5u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 13:57:50 -0400
Received: by mail-pf0-f196.google.com with SMTP id f189-v6so419924pfa.7
        for <git@vger.kernel.org>; Tue, 15 May 2018 10:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jmnjybmBVCneKf+EN2KAVfBMcyUFh/K687fijYvdGD0=;
        b=Y1hNQYQT93arc5AkKqDuGCO2xbSPUsrWqJisGNzThIiQaTXmpq4J3mPW1PuvYSN0Gr
         dAbKrMysAwqbF462RGBn4//L19DyzYFsoU9lEFdBQdc43aqPhR+aYRX88R84ipeuEfB5
         HkbhjvKul3D9NRV8k8QwDPLngjGZNyMR4XWYkOA4VNLTYbjaILCxrbkAohKCwK7F6Rsi
         PPjevv9/css2bltX1W7SOsm/03lrMmfVLStJwbBFWqBRf8+I4ggnO7eIqNE0l4Ppl7Ox
         cwDMBXShg5YhLIbke18/HoWYJUllRNjkveMx5dabnsYyXCmhp2SFO1utTuhR8oIw6U0l
         cHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jmnjybmBVCneKf+EN2KAVfBMcyUFh/K687fijYvdGD0=;
        b=R/ogR8oZlfHttvpkfBqOTfJMiHPtiWU+v2OEzFZFiDQX45ZXPsFX0s3reVskWtpH1N
         3Yejk7gDE6oRi6xKG9tD3+Y3icZksBrgxgULXwyLueqMKQpuhdz9brRlsc/HIv0VSh82
         MuyfvQYkw4WzhTbSOIwu8ZBCm+9TpFLiz4uCt3gXtU/rG2JB8ZMRQBn5gVIBM9iYqAnK
         3GFNODE65r+r1ZJbHQTQLv/FlTRrhI9XP+2n5PX2jS4TKDecyFanNL7BMCWCGYm9ex6W
         BKXEu6pJyP4kUgx1B9oGrOEI2fcU3WorFNjmnvgM4riirC475gHwUD9tQ1rsIkBS+ev6
         3LGQ==
X-Gm-Message-State: ALKqPwfkrk0TABmadgPUp+dZXBUN2jOTdsQa/M+QK/cq809qn85I04EK
        RwUkrYWRsmsMeJSL6gtBrQZ+VA==
X-Google-Smtp-Source: AB8JxZp9mbPJCY8iIMXn4DEXm236Eo2n3shAVjbU8YUXJs6ScQB6Z6eH1P8GY+NRwSVcMtl6qT6QgQ==
X-Received: by 2002:a62:4916:: with SMTP id w22-v6mr16136423pfa.63.1526407069354;
        Tue, 15 May 2018 10:57:49 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id n83-v6sm792260pfi.183.2018.05.15.10.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 10:57:48 -0700 (PDT)
Date:   Tue, 15 May 2018 10:57:47 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 14/35] remote: convert fetch refspecs to struct refspec
Message-ID: <20180515175747.GD72551@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
 <20180514215626.164960-15-bmwill@google.com>
 <87in7p2ucb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87in7p2ucb.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/15, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, May 14 2018, Brandon Williams wrote:
> 
> >  void add_prune_tags_to_fetch_refspec(struct remote *remote)
> >  {
> > -	int nr = remote->fetch_refspec_nr;
> > -	int bufsize = nr  + 1;
> > -	int size = sizeof(struct refspec_item);
> > -
> > -	remote->fetch = xrealloc(remote->fetch, size  * bufsize);
> > -	memcpy(&remote->fetch[nr], tag_refspec, size);
> > -	add_fetch_refspec(remote, xstrdup(TAG_REFSPEC));
> > +	refspec_append(&remote->fetch, TAG_REFSPEC);
> >  }
> 
> Thanks for fixing the hack I needed to put in place in 97716d217c
> ("fetch: add a --prune-tags option and fetch.pruneTags config",
> 2018-02-09).
> 
> I'm not sure where it belongs in this series, but I think this makes
> sense on top of the whole thing:

This actually would work well immediately after this patch, so I'll add
it here :)

Thanks!

> 
>     diff --git a/builtin/fetch.c b/builtin/fetch.c
>     index af7064dce3..9a523249f5 100644
>     --- a/builtin/fetch.c
>     +++ b/builtin/fetch.c
>     @@ -1383,7 +1383,8 @@ static int fetch_one(struct remote *remote, int argc, const char **argv, int pru
> 
>             maybe_prune_tags = prune_tags_ok && prune_tags;
>             if (maybe_prune_tags && remote_via_config)
>     -               add_prune_tags_to_fetch_refspec(remote);
>     +               refspec_append(&remote->fetch, TAG_REFSPEC);
>     +
> 
>             if (maybe_prune_tags && (argc || !remote_via_config))
>                     refspec_append(&rs, TAG_REFSPEC);
>     diff --git a/remote.c b/remote.c
>     index 8e6522f4d0..946b95d18d 100644
>     --- a/remote.c
>     +++ b/remote.c
>     @@ -87,11 +87,6 @@ static void add_fetch_refspec(struct remote *remote, const char *ref)
>             refspec_append(&remote->fetch, ref);
>      }
> 
>     -void add_prune_tags_to_fetch_refspec(struct remote *remote)
>     -{
>     -       refspec_append(&remote->fetch, TAG_REFSPEC);
>     -}
>     -
>      static void add_url(struct remote *remote, const char *url)
>      {
>             ALLOC_GROW(remote->url, remote->url_nr + 1, remote->url_alloc);
>     diff --git a/remote.h b/remote.h
>     index 9014f707f0..62a6566594 100644
>     --- a/remote.h
>     +++ b/remote.h
>     @@ -289,6 +289,4 @@ extern int parseopt_push_cas_option(const struct option *, const char *arg, int
>      extern int is_empty_cas(const struct push_cas_option *);
>      void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
> 
>     -void add_prune_tags_to_fetch_refspec(struct remote *remote);
>     -
>      #endif
> 
> I.e. the whole reason we have this function is because of my above
> commit where I had to very carefully hack around the fact that we didn't
> have something which could ALLOW_GROW() the structure after it had been
> created.
> 
> So I added the add_prune_tags_to_fetch_refspec() function to very
> carefully do *only* that so others wouldn't be tempted to use this hack
> more generally.
> 
> But now we have a nice API for it, so we can just throw away the
> wrapper, and use the same API everywhere. You already did the other half
> of that in your e69b54f53a ("fetch: convert fetch_one to use struct
> refspec", 2018-05-11).

-- 
Brandon Williams
