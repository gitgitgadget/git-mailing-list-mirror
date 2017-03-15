Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04EC020951
	for <e@80x24.org>; Wed, 15 Mar 2017 00:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750899AbdCOAKL (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 20:10:11 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33141 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbdCOAKK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 20:10:10 -0400
Received: by mail-pg0-f43.google.com with SMTP id n190so966796pga.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 17:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GLkkk6y68xkbPSR/eE/wLvC53XG4mfZm4V8pRHAtrqM=;
        b=mtIHsZDgrAQ6Damq7MREWE63O2uiR8utm6KI4EK0x/hlOamQaWIq+lTW1CKk8wChZT
         tt8X8PFuVO9K4ddynqYSYgCKC7VD+Cy1Xh6qys9kVG2/+wGVznSkeb2SM6P/v1ohKCit
         jYYFBXs3XsqZnadiNw7H+L93dK5V7KUkrZWNLIzOVUO280l7oxBKDrE31i9lv8KwlnXd
         pFCHHxIFr0bcqJf/GAe+CJLW8V4ZHKzzCMin+l6pdP5EwfwPA6rlhPXEq81wvaph6YCP
         Pk/ZECE/MuWEUArBrxxvIpUYDQZ4cDHDfnFs0FVyUreYCihUmnG/YTOd3WRdTWL6k8H1
         Sk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GLkkk6y68xkbPSR/eE/wLvC53XG4mfZm4V8pRHAtrqM=;
        b=bBXB/HmBLvUwmoEPEF/DXxLXThWcZT54EPXzFnQiH75ecqBuBTDdzf72/wsfhqmB65
         OsS1tLNrraxUC06DsnnjW0wvv90MJWZ05jBSjFHUp86UirXltrIco5Sk3JmmWJXq4RZK
         B0LsxPeiWstP3rZZZl8tuyUB05xQEO816A1HWGxZ3WYKhMcwwM23DmN3y9jka73p9qDy
         a9Px7fYXfxJG04DSVCtv1wnKn5g2/CBWwUAyNHqRisxQI3rzyImGwX+grm5FBu8pbLrn
         hI0gS0p9PGzgm72/jzkNkH84PDDa7FHlyTk0o22GO+xX69/+zR6dt9yYYvGQnMmyBDMK
         1hCg==
X-Gm-Message-State: AFeK/H0MEap4ZI4wuRV4i23aqMCItBWDXiZ63k+B7DS0lcCV4JijZcnN+jnMwLuzWfNGUmvc
X-Received: by 10.84.129.3 with SMTP id 3mr569490plb.150.1489536608682;
        Tue, 14 Mar 2017 17:10:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:491b:baa8:63f0:3cf1])
        by smtp.gmail.com with ESMTPSA id y9sm191378pfi.39.2017.03.14.17.10.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 17:10:07 -0700 (PDT)
Date:   Tue, 14 Mar 2017 17:10:06 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v3 04/10] submodule--helper clone: check for configured
 submodules using helper
Message-ID: <20170315001006.GG168037@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
 <20170313214341.172676-5-bmwill@google.com>
 <xmqq4lyvka1i.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZ20Jy_A8SPJte7U0iZZB97P0Sn_PqAMfwp40sAj6Y=RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ20Jy_A8SPJte7U0iZZB97P0Sn_PqAMfwp40sAj6Y=RA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/14, Stefan Beller wrote:
> On Tue, Mar 14, 2017 at 11:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Brandon Williams <bmwill@google.com> writes:
> >
> >> -     /*
> >> -      * Looking up the url in .git/config.
> >> -      * We must not fall back to .gitmodules as we only want
> >> -      * to process configured submodules.
> >> -      */
> >> -     strbuf_reset(&sb);
> >> -     strbuf_addf(&sb, "submodule.%s.url", sub->name);
> >> -     git_config_get_string(sb.buf, &url);
> >> -     if (!url) {
> >> +     /* Check if the submodule has been initialized. */
> >> +     if (!is_submodule_initialized(ce->name)) {
> >>               next_submodule_warn_missing(suc, out, displaypath);
> >>               goto cleanup;
> >>       }
> >> @@ -835,7 +827,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
> >>               argv_array_push(&child->args, "--depth=1");
> >>       argv_array_pushl(&child->args, "--path", sub->path, NULL);
> >>       argv_array_pushl(&child->args, "--name", sub->name, NULL);
> >> -     argv_array_pushl(&child->args, "--url", url, NULL);
> >> +     argv_array_pushl(&child->args, "--url", sub->url, NULL);
> >
> > Even without this patch, we already had an instance of struct submodule
> > available in this function, so the query to .git/config this patch removed
> > was unnecessary?
> >
> > I am wondering what was meant by the comment "We must not fall back to..."
> > that is being removed---is that because sub->url can come from .gitmodules
> > that is in-tree, not from .git/config?
> 
> Yes. We want to check for the submodule being "initialized", i.e.
> having a url in .git/config. (and the struct submodule reads in both .git/config
> and .gitmodules and overlays them with a given precedence order)
> 
> >  If that is the case, doesn't the
> > change in this hunk change behaviour from using the URL the user prefers
> > to using the URL the upstream suggests, overriding user's configuration?
> 
> The mentioned precedence makes sure to have the right order:
> 
>     /* Overlay the parsed .gitmodules file with .git/config */
>     gitmodules_config();
>     git_config(submodule_config, NULL);
> 
> such that the sub->url is correct as a URL, but not correct as a boolean
> indicator if the submodule is "initialized".

Thanks for clarifying this.

-- 
Brandon Williams
