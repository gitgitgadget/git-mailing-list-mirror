Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDB0420899
	for <e@80x24.org>; Tue, 15 Aug 2017 00:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbdHOAFh (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 20:05:37 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36582 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752740AbdHOAFg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 20:05:36 -0400
Received: by mail-pg0-f52.google.com with SMTP id i12so6007861pgr.3
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 17:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fH78rGvNPvPo8RMqtmUX4lhszYOim4GxL3jPtbm/vNs=;
        b=F43D045p5lik4leyC2IZjyH4N99ErOm/8O3d8Bs7Qfa/haC/y9lq2AhoPvKtQQgQLU
         ARMkS7PruPjz2waYKO4Nu1CQXUtuj2mCiWiuiycS1trd5TMwQJe1tAXMBKidDhM1otRb
         AOF0pwQQpYQEZiAb755hheAuf37Oe8/DBj/4nUmbD1RK0Z6qSa07AcDKt9Jm5EyW2H+8
         HIiaslwRuX8Y+WBn+7Da1OXScCdIViMoTxVeNpfMhf6TPRsdQgM7l+nuU2LOdR0VPzpn
         I+EVvEsd3NMQvKpoSF7+DJTsPm0DPGAL6h950DThSWhp01dWAaU+hYqfoyhw2utzz3pC
         psPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fH78rGvNPvPo8RMqtmUX4lhszYOim4GxL3jPtbm/vNs=;
        b=OyhyQw6P/kJWZ7KMr0BsTHCaBP54CXDCMAU7Q5GTb08zHl3UaNv/BH1VQW5VkTMVdb
         6vHcNzvtbEYZvIKOMZZYnjkGOcAUkDt1DL+ibcNILxW3rOIK40rJ/SQ8hWnYKb1FyavX
         Mi86qsF4PF2YxwqPSry6asCfefBc888x+K5Tl/Jdx7XRPDspBcR/ioNNaW1rnXbVVHuR
         Few5yBgmeSJh96meSxqitFeBOIPNprtJ80shzeSVL/oAUe/sWy1mwB0Eb4NHZi+Cvyth
         1qsyJwsnEbMFlCOQoDgBDAiPOmZfpT9MFOc3k/tZCVeCW2nlLnTkk1zTgR38IXaMqERo
         4yUw==
X-Gm-Message-State: AHYfb5i9/rlRFfGBQrH/NBaHJoiAqIJWeHzVD2qm3h9hYUY3yWWhBf9L
        a5soOymln585mx8Nxz3pSg==
X-Received: by 10.98.110.65 with SMTP id j62mr26513739pfc.115.1502755536020;
        Mon, 14 Aug 2017 17:05:36 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:593a:8ead:b053:9e22])
        by smtp.gmail.com with ESMTPSA id u186sm15641572pfu.82.2017.08.14.17.05.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Aug 2017 17:05:34 -0700 (PDT)
Date:   Mon, 14 Aug 2017 17:05:33 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Ben Peart <peartben@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 2/2] Makefile: add style build rule
Message-ID: <20170815000533.GC95777@google.com>
References: <20170808012554.186051-1-bmwill@google.com>
 <20170814213046.107576-1-bmwill@google.com>
 <20170814213046.107576-3-bmwill@google.com>
 <xmqqd17xu6qg.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbAp0p8-y-UpamU0J65A2P0B9r7KEWM0ZCBv=x4E77sGw@mail.gmail.com>
 <20170814225716.p5airw6j5o6dszbn@sigill.intra.peff.net>
 <xmqqzib1sp6z.fsf@gitster.mtv.corp.google.com>
 <xmqqvalpsoda.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqvalpsoda.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/14, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > By the way, I do not know which vintage of /usr/bin/git-clang-format
> > I happen to have on my box, but I needed a crude workaround patch
> > (attached at the end) ...
> 
> I guess you hit the same thing while our messages crossing ;-)
> 
> 
> > As to what it does, the first example I tried may not have been a
> > great one.  I got this:
> >
> >         git clang-format --style file --diff --extensions c,h
> >         diff --git a/cache.h b/cache.h
> >         index 73e0085186..6462fe25bc 100644
> >         --- a/cache.h
> >         +++ b/cache.h
> >         @@ -1498,11 +1498,8 @@ struct checkout {
> >                 const char *base_dir;
> >                 int base_dir_len;
> >                 struct delayed_checkout *delayed_checkout;
> >         -	unsigned force:1,
> >         -		 quiet:1,
> >         -		 not_new:1,
> >         -		a_new_field:1,
> >         -		 refresh_cache:1;
> >         +	unsigned force : 1, quiet : 1, not_new : 1, a_new_field : 1,
> >         +		refresh_cache : 1;
> >          };
> >          #define CHECKOUT_INIT { NULL, "" }
> >  
> > which is not wrong per-se, but I have a mixed feelings.  I do not
> > want it to complain if the original tried to fit many items on a
> > single line, but if the original wanted to have one item per line,
> > I'd rather see it kept as-is.
> 
> To clarify, the above is after I added a_new_field that is one-bit
> wide without doing anything else.  I do not mind the checker
> complaining the existing force, quiet, etc. whose widths are all
> spelled without SP around ':', because they appear near-by, as a
> collateral damage.  My only gripe is that the result got squished
> into a single line.

Yeah the result doesn't look too good and I'm not sure which option to
tweak for that.  I'm sure that the problem would fix itself if all the
bit fields where defined on their own lines:

  unsigned force : 1;
  unsigned not_new : 1; 
  ... etc ...

I'm sure there are a bunch of other things that we'd need to tweak
before this is ready to be used by all contributors.  Specifically the
penalties to help determine when to break a line.

> 
> > Anyway, we cannot have perfect checker from the day one, and
> > considering this is an initial attempt, I'd say it is a good start.

-- 
Brandon Williams
