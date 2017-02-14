Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EC4D2013B
	for <e@80x24.org>; Tue, 14 Feb 2017 21:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755691AbdBNVaI (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 16:30:08 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35468 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755683AbdBNVaF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 16:30:05 -0500
Received: by mail-wm0-f65.google.com with SMTP id u63so5481622wmu.2
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 13:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3cqvUR1SIygkIVi5j74tI44qi64JCQsmy7L26Fw+F/k=;
        b=jwbApujMfFsfh87QAWI5B/3t5+UT23Tt8eWCbbBRlhTqO5dc0ipY0eiaPUlLtYrL24
         clRlMuBJXk5vmn2z1mKIqz/7dRcGDh4vkuYQn4YRR/WwTrOogoiWMsGOZC29yDAC2M7O
         Wos23tvmkH2TA1Q7Fkfv+o/r4aNhdloytKhZuAKZXrFjobMnXBfjihcsOkSXK79STKq0
         mO5KWgqRGXBXKVxYf5Tr/GWFBc/pbdbtW2NfhZY+2IhFx9GfNALvl9PHLmcy7cVNbNhq
         6fZzZvsI9OGR4cIVjPH6/xVNYSNXurTwtAe9DicyMizGVWGKhrfgu+w79bskiUPdItR5
         15OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3cqvUR1SIygkIVi5j74tI44qi64JCQsmy7L26Fw+F/k=;
        b=Fm+YbkcenO4KKjm7P3UWuqG/XNIcuVZLFLkzUBAnto4ERslhGPX8k90kL6f5Iic2ad
         wQ3PoT53CXJAWvJjE4DIx355jv8m3WoS3VulyQNpYTzEf7Fcn2peCFPmEVXOCXyyo6YF
         /zLsrEagNj64ku4Uz0IxjQ/vvDmAtq1czzWkC5rrgIlROtrDp7eeoYuC72bKCpmcDgqj
         BHr5BqSEtWGHrAaSCVxg8PchgyuLsxmn+v6J3p5Ai1PeDT/MnbcpEwn4wmiO0gdQxixa
         Q6Gf0haTvzfA9ro127Y6iudDbJ2V7o+v+1d/QmQt/tbZAKf/qjWZF2MJpuqGFwX5Vv2r
         YJxA==
X-Gm-Message-State: AMke39l4FAWkkSYqzJTnQvctyguMrHtojuwGFsO31EfgtW8sJdxYzsyTFDgOPqs0asFh7w==
X-Received: by 10.28.31.130 with SMTP id f124mr4915317wmf.130.1487107803696;
        Tue, 14 Feb 2017 13:30:03 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id r19sm2262879wrr.44.2017.02.14.13.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Feb 2017 13:30:02 -0800 (PST)
Date:   Tue, 14 Feb 2017 21:30:38 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=D8yvind_A_=2E?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 4/5] stash: introduce new format create
Message-ID: <20170214213038.GE652@hank>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
 <20170205202642.14216-5-t.gummerer@gmail.com>
 <20170206155606.xgkmhg656vuc6uki@sigill.intra.peff.net>
 <20170211145127.GA23081@hank>
 <20170213215734.puoung6hhdifbgai@sigill.intra.peff.net>
 <20170213230532.sr7lpl26mcfa4gfc@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170213230532.sr7lpl26mcfa4gfc@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/13, Jeff King wrote:
> On Mon, Feb 13, 2017 at 04:57:34PM -0500, Jeff King wrote:
> 
> > Yeah, I think your patch is actually fixing that case. But your search
> > is only part of the story. You found somebody using "-m" explicitly, but
> > what about somebody blindly calling:
> > 
> >   git stash create $*
> > 
> > That's now surprising to somebody who puts "-m" in their message.
> > 
> > > I *think* this regression is acceptable, but I'm happy to introduce
> > > another verb if people think otherwise.
> > 
> > Despite what I wrote above, I'm still inclined to say that this isn't an
> > important regression. I'd be surprised if "stash create" is used
> > independently much at all.
> 
> Just thinking on this more...do we really care about "fixing" the
> interface of "stash create"? This is really just about refactoring what
> underlies the new "push", right?
>
> So we could just do:
> 
> diff --git a/git-stash.sh b/git-stash.sh
> index 6d629fc43..ee37db135 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -711,7 +711,7 @@ clear)
>  	;;
>  create)
>  	shift
> -	create_stash "$@" && echo "$w_commit"
> +	create_stash -m "$*" && echo "$w_commit"
>  	;;
>  store)
>  	shift
> 
> on top of your patch and keep the external interface the same.
> 
> It might be nice to clean up the interface for "create" to match other
> ones, but from this discussion I think it is mostly a historical wart
> for scripting, and we are OK to just leave its slightly-broken interface
> in place forever.

Yeah tbh I don't personally care too much about modernizing the
interface to git stash create.  What you have above makes a lot of
sense to me.

I also just noticed that git stash create -m message is not the worst
regression I introduced when trying to modernize this.  In that case
only the -m would go missing, but that's probably not the end of the
world.  The worse thing to do would be something like
git stash create -u untracked, where the intended message was "-u
untracked", but instead there is no message, but all untracked files
are now included in the stash as well.

In that light what you have above makes even more sense to me.
Thanks!

> I could go either way.
> 
> -Peff

-- 
Thomas
