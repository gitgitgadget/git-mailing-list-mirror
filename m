Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E25A220357
	for <e@80x24.org>; Mon, 10 Jul 2017 22:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754864AbdGJWli (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 18:41:38 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:32936 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754420AbdGJWlh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 18:41:37 -0400
Received: by mail-pf0-f171.google.com with SMTP id e7so56822990pfk.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 15:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WB+7hn9kqAAyLrSNhrXWmdoIIlJFOYSJmpNeiE2dJSk=;
        b=PfYL26d3qWjHDtQUShZFgB48NwdyoqMoBDrE+QxaLvwD+BqntkgjMYuH+2LIhWRAab
         dpFzwwjoZ7P4groVIAIJVjh77EH5DaY4dW5Y1641c74LeVsXv8BQnn1WpAcDwccKZmOt
         IEd8U6dZd2LwqRiB+6WGIzvvxGHC1ZGFrw5Sa4uTP+hg+7MOM5Zq1QRkeW3Zk5ClX/AY
         ysZ+8RhQT/85BBBtSots706UAFBPZzZQ49RzIxv/fXycz3rvUC1dRf+xUdIi6qndNl+5
         6BoWgbAP0k1OgByv23PCzoCcNVHWmUbPUKJFNMtqhEFVy2vBCnCleCS4LyXx4lDz1D7R
         +Vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WB+7hn9kqAAyLrSNhrXWmdoIIlJFOYSJmpNeiE2dJSk=;
        b=VN0lUjvlWtTLqN6l7bOx2HJLIoEpcogtVSTqX+eHYOz4ERLXzv+bf0vZEh/edETwQz
         1Z0R7yhvc8Vs9K73TCY/EetfIsL6nn/2DITdPQKnTskztjdp6t4qHKnfAkLCGWBG6XOM
         fOgKPAUowNUYj2yktT3yvsqr5ZFGBQ6wu0GStYqmlwPuRxNd4WaALCv3uSPaQ2r8TyOB
         zdr4WfTwXp92xsiTmuMtx6hvRNm+qlsU9sSbBF/fqBdE6Hmu090LuMX7VScpUl4MoQZx
         43pIV5DHDT+Dw7NvLohqWNjPacGuMsvnDPIVdbWx9tpOF6BwNg3eseaPftoQeX/08MuR
         7/cA==
X-Gm-Message-State: AIVw111Dds+A9L2aVwa/OhaPFX44/WVweYfcZHQETxBn0TwwyMGvDYqt
        jL3BTHevvMZs2xdw+IJITg==
X-Received: by 10.98.85.131 with SMTP id j125mr24442861pfb.48.1499726497050;
        Mon, 10 Jul 2017 15:41:37 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c8d3:611:f474:c770])
        by smtp.gmail.com with ESMTPSA id h184sm23063541pge.66.2017.07.10.15.41.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 15:41:35 -0700 (PDT)
Date:   Mon, 10 Jul 2017 15:41:34 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
Message-ID: <20170710224134.GA161700@google.com>
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/10, Jeff King wrote:
> On Sun, Jul 09, 2017 at 10:05:49AM -0700, Junio C Hamano wrote:
> 
> > René Scharfe <l.s.r@web.de> writes:
> > 
> > > I wonder when we can begin to target C99 in git's source, though. :)
> > 
> > Let's get the ball rolling by starting to use some of the useful
> > features like designated initializers, perhaps, in a small, critical
> > and reasonably stable part of the system that anybody must compile,
> > leave it in one full release cycle or two, and when we hear nobody
> > complains, introduce it en masse for the remainder of the system?
> > 
> > That way, we will see if there are people who need pre-C99 soon
> > enough, and we won't have to scramble reverting too many changes
> > when it happens.
> 
> Neat idea. Something like this?
> 
> -- >8 --
> Subject: [PATCH] strbuf: use designated initializers in STRBUF_INIT
> 
> There are certain C99 features that might be nice to use in
> our code base, but we've hesitated to do so in order to
> avoid breaking compatibility with older compilers. But we
> don't actually know if people are even using pre-C99
> compilers these days.
> 
> One way to figure that out is to introduce a very small use
> of a feature, and see if anybody complains. The strbuf code
> is a good place to do this for a few reasons:
> 
>   - it always gets compiled, no matter which Makefile knobs
>     have been tweaked.
> 
>   - it's very stable; this definition hasn't changed in a
>     long time and is not likely to (so if we have to revert,
>     it's unlikely to cause headaches)
> 
> If this patch can survive a few releases without complaint,
> then we can feel more confident that designated initializers
> are widely supported by our user base.  It also is an
> indication that other C99 features may be supported, but not
> a guarantee (e.g., gcc had designated initializers before
> C99 existed).
> 
> And if we do get complaints, then we'll have gained some
> data and we can easily revert this patch.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I suspected we could also do something with __STDC_VERSION__, though I
> wonder what compilers set it to when not in standards-compliant mode.
> gcc-6 claims C11 when no specific -std flag is given.
> 
> And obviously before releasing this or anything similar, it would be
> nice to see results from people building pu. I'm especially curious
> whether MSVC would work with this (or if people even still use it, since
> Git for Windows is pretty mature?).
> 
>  strbuf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/strbuf.h b/strbuf.h
> index 2075384e0..e705b94db 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -68,7 +68,7 @@ struct strbuf {
>  };
>  
>  extern char strbuf_slopbuf[];
> -#define STRBUF_INIT  { 0, 0, strbuf_slopbuf }
> +#define STRBUF_INIT  { .alloc = 0, .len = 0, .buf = strbuf_slopbuf }

I love that this is happening!  And maybe someday soon we can do:

  for (int i = 0; i < n; i++)

So that we can scope loop variables to the loops themselves.

-- 
Brandon Williams
