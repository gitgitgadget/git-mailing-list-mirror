Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 496481F463
	for <e@80x24.org>; Thu, 26 Sep 2019 23:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfIZX56 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 19:57:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32996 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbfIZX56 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 19:57:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id i30so2458628pgl.0
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 16:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cJfD/ABz4G1t0lSJx1X22WrJzsq8Hk3QKt23sn8S9kw=;
        b=fmdksj0zyNzaR7HnqZKAK1qNHq3yCx+KvzOQwQ2b2237KzqP6TIz00mwEJuU/sNzM9
         qZPup57KxqAo/TFW4f5RZ+0EiTAZYIlJhFIxIPD6YSC4dD5L1Dami/WFdG8cpwb1lmsr
         cWetrQN/GMKiwG7s8YWM7lYIwkC85LOY2b3m/oX2TXS2+xIHla7vVLoAwvzsE611ykU1
         sRmfb92pDukjcEpzex3ICl5mRdvo6fpJ9SGqoJF9MoDW/pr8dImcyzLBd9vNk51PjJCi
         HifSdUhZYUNgGpBpALlJSv6f5Q/M6NzxfMIAbRyhQXba2Eb4VJVGECO4uVwRlNMYE/KR
         Dbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cJfD/ABz4G1t0lSJx1X22WrJzsq8Hk3QKt23sn8S9kw=;
        b=e5SaAyE6to4W1hlC2Gf+NXOwTOF/4Hw8kX6ZrC0GdkIXDWEr52DA0JUqFRMFUnBnDx
         1gMzt0kzR9a83K2RtNaGlFAQeTPFWFkDNSSwRVoHwpRqNZ67e1yWozrmQlZ3CDcRBhl1
         278zGP9ZR7KG1bLn5fTA+RNCWZe7mKLvvugBkOwT+s45pKAd2jbhbpvnLM5ZmsKlI1nG
         gfn5Ewt3JAcSTxaa6C0WaJ4xQqtoJKzjXnndA0UxwC6A8+zQxaZUn9/hqLnvI4hT/F09
         uRb+m4HTFQnWba1ChfQzdrmjwc/FeiMlkvTD9PgnYrgyhIk1Jsz0/YbwpU4jlo7yp/y6
         YDXg==
X-Gm-Message-State: APjAAAWvtu416sPxl2kmwoGcGFwqsPU3Y4arzHPMKKE6UgzUgCUZGWNy
        krSkEPNXC/qrU6Vm5bqD4Zw=
X-Google-Smtp-Source: APXvYqwI6PIt4KDROpMC32fGoi8f1RQMGZMJ82oM1lKaLB7yGhCLV0WasoOP/2QoIODxsrHNqImUvw==
X-Received: by 2002:a65:6799:: with SMTP id e25mr6414612pgr.271.1569542276677;
        Thu, 26 Sep 2019 16:57:56 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id w10sm360151pfi.137.2019.09.26.16.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 16:57:55 -0700 (PDT)
Date:   Thu, 26 Sep 2019 16:57:53 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/13] msvc: avoid using minus operator on unsigned types
Message-ID: <20190926235753.GA94990@generichostname>
References: <pull.288.git.gitgitgadget@gmail.com>
 <2abe1e1fb0bf3025489c2e543b9a9c648a164827.1569486607.git.gitgitgadget@gmail.com>
 <20190926172022.GA41037@generichostname>
 <nycvar.QRO.7.76.6.1909262236550.15067@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1909262236550.15067@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Sep 26, 2019 at 11:01:32PM +0200, Johannes Schindelin wrote:
> Hi Denton,
> 
> On Thu, 26 Sep 2019, Denton Liu wrote:
> 
> > Hi Dscho,
> >
> > On Thu, Sep 26, 2019 at 01:30:10AM -0700, Johannes Schindelin via GitGitGadget wrote:
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >
> > > MSVC complains about this with `-Wall`, which can be taken as a sign
> > > that this is indeed a real bug. The symptom is:
> > >
> > > 	C4146: unary minus operator applied to unsigned type, result
> > > 	still unsigned
> > >
> > > Let's avoid this warning in the minimal way, e.g. writing `-1 -
> > > <unsigned value>` instead of `-<unsigned value> - 1`.
> >
> > [...]
> >
> > > ---
> > >  read-cache.c  | 4 ++--
> > >  sha1-lookup.c | 2 +-
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/read-cache.c b/read-cache.c
> > > index c701f7f8b8..11f3357216 100644
> > > --- a/read-cache.c
> > > +++ b/read-cache.c
> > > @@ -1276,7 +1276,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
> > >  	 */
> > >  	if (istate->cache_nr > 0 &&
> > >  		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0)
> > > -		pos = -istate->cache_nr - 1;
> > > +		pos = -1 - istate->cache_nr;
> >
> > I've been thinking about this and I'm still not certain that this 100%
> > correct from a language-lawyer perspective.
> >
> > If we do `-1 - istate->cache_nr`, then the unsignedness of
> > istate->cache_nr takes over and the whole expression is a very large
> > unsigned number.
> >
> > Then, when we assign to `int pos`, we are converting an unsigned number
> > which is out of the range of the signed number. According to a
> > StackOverflow post citing the C99 standard[1]:
> >
> > 	Otherwise, the new type is signed and the value cannot be
> > 	represented in it; either the result is implementation-defined
> > 	or an implementation-defined signal is raised.
> >
> > I'm sure that most platforms that we support will handle it sanely but
> > could we write this as
> >
> > 	pos = -1 - (int) istate->cache_nr;
> >
> > to be doubly sure that no funny business will happen?
> 
> I guess we should use `signed_add_overflows()` to make extra certain
> that it does what we want it to do, kind of like `st_add()`. Or just do
> the check explicitly, like so:
> 
> 	if (istate->cache_nr > INT_MAX)
> 		die("overflow: -1 - %u", istate->cache_nr);
> 	pos = -1 - istate->cache_nr;

Could we change this to 

 	pos = -1 - (int) istate->cache_nr;

so that we alleviate the problem I was talking about above?

Other than that, it looks good. Well, it might break on one's complement
systems but I don't think we support UNIVACs anyway. ;)

> }
> >
> > >  	else
> > >  		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
> > >
> > > @@ -1894,7 +1894,7 @@ static size_t estimate_cache_size(size_t ondisk_size, unsigned int entries)
> > >  	/*
> > >  	 * Account for potential alignment differences.
> > >  	 */
> > > -	per_entry += align_padding_size(sizeof(struct cache_entry), -sizeof(struct ondisk_cache_entry));
> > > +	per_entry += align_padding_size(per_entry, 0);
> > >  	return ondisk_size + entries * per_entry;
> > >  }
> > >
> > > diff --git a/sha1-lookup.c b/sha1-lookup.c
> > > index 796ab68da8..c819687730 100644
> > > --- a/sha1-lookup.c
> > > +++ b/sha1-lookup.c
> > > @@ -97,7 +97,7 @@ int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
> > >  			lo = mi + 1;
> > >  		mi = lo + (hi - lo) / 2;
> > >  	} while (lo < hi);
> > > -	return -lo-1;
> > > +	return -1 - lo;
> >
> > Same thing here.
> 
> This is even more critical, as `lo` has the type `size_t`:
> 
> 	if (lo > INT_MAX)
> 		die("overflow: -1 - %"PRIuMAX, (uintmax_t)lo);
> 	return -1 - lo;

Also, could we change this to

 	return -1 - (int) lo;

Thanks,

Denton

> >
> What do you think?
> Dscho
> 
> > [1]: https://stackoverflow.com/questions/50605/signed-to-unsigned-conversion-in-c-is-it-always-safe
> >
> > >  }
> > >
> > >  int bsearch_hash(const unsigned char *sha1, const uint32_t *fanout_nbo,
> > > --
> > > gitgitgadget
> > >
> >
