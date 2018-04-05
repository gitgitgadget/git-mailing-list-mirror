Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF32A1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 01:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeDEBsC (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 21:48:02 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34583 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbeDEBsB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 21:48:01 -0400
Received: by mail-pl0-f68.google.com with SMTP id u11-v6so16909877plq.1
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 18:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/NllZZaN7/ADDvy33uIKnr/3Y5AvqU/zFqyjALM9Rg8=;
        b=jm++dbyroPmX5YWtqehxta7z/rMvNyyQBtspWBHBmNdETLpEgBjDpkLxhps78manc9
         TrGYvgbzUrpvdXT95ASwCRYS454cavrSsY9FiTx3JzFzw9T2wEAePDMUZqYdJrt99rug
         IMOqc0c1gKBzGMox4aJEKjBtgEJKnJGOlcjG41uUNeEPReP4Qes4wvPbOYAO2NTLktFE
         L+211J5ipFocEvgAQWqkLDFGUy8iPaRsb4xTCyM02ZHeKf3zcsO4LGmFeb8WkuIqEp3n
         MMemCFdIHd3OVPmpPlvFfv+W1JnVtcJmzBWqV/z1AC2wouHMSSzE4Gh01BWQWN/kg2+k
         ySBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/NllZZaN7/ADDvy33uIKnr/3Y5AvqU/zFqyjALM9Rg8=;
        b=odvR6Y0UKHAaEjoi0lHgZkHEvQWRdpIouT0dIZcWIZWw16cmEOZPy+y/FwwvAP5v6l
         yVo19aL49DuU6ZptqgEBS4q7ASPVYJz01aCe+Pm/3J4lciuMOvZFxtvkA440ztb8UUv3
         1CO2I65iqRTJR4q/pM/byaf8gQw7XD5YaIcDL8dnsl41+qoS8Zsyzfjm3F2E5ZIMFkXo
         FIdyaQ83ynriU6YX0HuT03stx/ufA+WZn0DgmcS004BVpsKRefY+SRTceAQ8wAnBwmn6
         ExxXYrjzvvJQgLFD50xpL412N7rc4sn4l7orxbIiDoWPNzobFBOOtUv3PNVS9B04ABm2
         p8+Q==
X-Gm-Message-State: ALQs6tAloIR1AONo3lefAOV+zjJt2C5ORFUYiRUqRLVTZWdvgWYS7AVP
        GEXW2aezVg6m/WCisDGTImdk3GnEz1HZZw==
X-Google-Smtp-Source: AIpwx4+uaLgtLTogE2wRSjh8d991a45efiffsgmfBI5ignUgrQgdgYIVcxQN/xx5dN9YKObdFqdaJg==
X-Received: by 10.101.102.197 with SMTP id c5mr3255096pgw.93.1522892881083;
        Wed, 04 Apr 2018 18:48:01 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:dc75:c2ae:e99:b3d1])
        by smtp.gmail.com with ESMTPSA id p1sm11416251pgr.67.2018.04.04.18.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 18:47:59 -0700 (PDT)
Date:   Wed, 4 Apr 2018 18:47:58 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        --@vger.kernel.org
Subject: Re: [PATCH v3 2/2] builtin/config.c: prefer `--type=bool` over
 `--bool`, etc.
Message-ID: <20180405014758.GA4671@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
 <20180404060743.39278-1-me@ttaylorr.com>
 <20180404060743.39278-3-me@ttaylorr.com>
 <CAPig+cR4uFiC_gFsb2e9JR6SdP-wUQVz-E0MjRHR=vNHd+hvhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cR4uFiC_gFsb2e9JR6SdP-wUQVz-E0MjRHR=vNHd+hvhA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 04, 2018 at 03:27:48AM -0400, Eric Sunshine wrote:
> On Wed, Apr 4, 2018 at 2:07 AM, Taylor Blau <me@ttaylorr.com> wrote:
> > In this patch, we prefer `--type=[int|bool|bool-or-int|...]` over
> > `--int`, `--bool`, and etc. This allows the aforementioned other patch
> > to add `--color` (in the non-traditional sense) via `--type=color`,
> > instead of `--color`.
>
> I always find this last sentence confusing since it's not clear to
> which ilk of "--color" option you refer. Perhaps say instead something
> like:
>
>     This normalization will allow the aforementioned upcoming patch to
>     support querying a color value with a default via "--type=color
>     --default=...".

I agree that this is much clearer. I have amended this patch to include
your wording here.

> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> > diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> > @@ -160,30 +158,34 @@ See also <<FILES>>.
> > +--type [type]::
> > +  'git config' will ensure that any input output is valid under the given type
> > +  constraint(s), and will canonicalize outgoing values in `[type]`'s canonical
> > +  form.
>
> Do the brackets in "[type]" mean that the argument is optional? If so,
> what does 'type' default to when not specified? The documentation
> should discuss this.

This is my mistake; I was unaware of the semantic difference between '[]'
and '<>'. If my understanding is correct that '<>' means "required" and
'[]' means "optional", than this is a misspelling of "<type>".

I have addressed this during the re-roll.

> > diff --git a/builtin/config.c b/builtin/config.c
> > @@ -61,6 +61,33 @@ static int show_origin;
> > +static int option_parse_type(const struct option *opt, const char *arg,
> > +                            int unset)
> > +{
> > +       [...]
> > +       if (!strcmp(arg, "bool"))
> > +               *type = TYPE_BOOL;
> > +       else if (!strcmp(arg, "int"))
> > +               *type = TYPE_INT;
> > +       else if (!strcmp(arg, "bool-or-int"))
> > +               *type = TYPE_BOOL_OR_INT;
> > +       else if (!strcmp(arg, "path"))
> > +               *type = TYPE_PATH;
> > +       else if (!strcmp(arg, "expiry-date"))
> > +               *type = TYPE_EXPIRY_DATE;
> > +       else {
> > +               die(_("unexpected --type argument, %s"), arg);
>
> "unexpected" doesn't seem like the best word choice since an argument
> to --type _is_ expected. Perhaps you mean "unrecognized"?

Sure; I think "unrecognized" is a much better fit. I have updated this
in the re-roll.

Thanks,
Taylor
