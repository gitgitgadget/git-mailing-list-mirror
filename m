Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FB2820953
	for <e@80x24.org>; Wed, 15 Mar 2017 22:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754252AbdCOWqt (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 18:46:49 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35445 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754189AbdCOWqI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 18:46:08 -0400
Received: by mail-pg0-f48.google.com with SMTP id b129so15446217pgc.2
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 15:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DTJW1SvTs7kjoGkn4w/hjfcr1xfM22OwblbZtfw09n4=;
        b=Gs3rY/bnJMx+tI9Rd5ZyhKYv5ivlzr5C90C8jqYwlZ2jrJa2Q5CXckxMgXaKVm2lL1
         lFFu9y184AbCCmA7xug9sAvH1DoiHTnGO3wAgWGL06nBGuJT8AE5hd9lMlNgby3qLur1
         pRyMEjbYmUdPrrUXG0mm+7zhBaXfmAUzWUVaEh+g5XMZftVddEYWtUxooA72d0/TCuu9
         iAKxkjkZYkccHj8SofctrpLOVRH8/u22BwuvnW/m5VkxacEyuGihroFeT/Ux0yxEeOW4
         sQlgYiQWO10mmvW/h0l8vaqEXIO/ohzXoF/guhSfj2ZCie5gqAPX+eKqbJF1GUgLgorx
         zInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DTJW1SvTs7kjoGkn4w/hjfcr1xfM22OwblbZtfw09n4=;
        b=ujnIqR9LYafgREbg/frepmt6dB8f3oF3DbjLEDC68Hyzt79E2FxBXPfkY0RN1Ym+s4
         XyP9xEnQbDJyDDipdNUPdnX4emmkgplKmzLWW4ijr982V3rTaG9tHF6lfoH2yCIuY3v5
         bU740l6QbJALeuoVLFZFP5OiK1gX2t2oRBFI1WfGQhvQX4FfBCUfBqkX/ptuw6FZArcQ
         0Fm2htIici5/OhO+Yrul/IPK48avoRMj4h97SzcJ6D1Iur82pSiJwLn6xyHz7Cmwb59m
         y0rOnyxf8dESE7Y3JHHykKTw8WlfmYiyXqQk1evC43DWpyc/FtlX/91gC42u8v2sQbIZ
         e/2A==
X-Gm-Message-State: AFeK/H27Hij5Jd+i7A9aV/muniMdAznTJ8dGQ+DLYnoeqM5T98iNDcHU2DgvArOyZTr8zhiI
X-Received: by 10.84.236.9 with SMTP id q9mr7705235plk.96.1489617966811;
        Wed, 15 Mar 2017 15:46:06 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:e5fd:c660:1f84:47a3])
        by smtp.gmail.com with ESMTPSA id s87sm6194037pfa.29.2017.03.15.15.46.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Mar 2017 15:46:05 -0700 (PDT)
Date:   Wed, 15 Mar 2017 15:46:04 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 09/10] submodule--helper init: set
 submodule.<name>.active
Message-ID: <20170315224604.GG159137@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
 <20170313214341.172676-10-bmwill@google.com>
 <xmqqinnbiqzs.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqinnbiqzs.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/14, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > When initializing a submodule set the submodule.<name>.active config to
> > true to indicate that the submodule is active.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> 
> Hmph.  When you do
> 
> 	git clone --submodule-spec=lib/
> 
> and resulting repository says "submodule.active = lib/", you are
> saying that you are interested in anything in "lib/", now or in the
> future--that is the point of 08/10.
> 
> It is unclear what your desire would be for a submodule that was
> bound to somewhere in "lib/" in the superproject when you cloned
> when it later gets moved outside "lib/".  With changes up to 08/10,
> that submodule will no longer be interesting, but with this 09/10,
> when recursing clone will activate it upon the initial clone, the
> submodule is explicitly marked as active by its name, so no matter
> where it gets moved later, it will remain to be interesting.
> 
> I am not sure if that is a desired behaviour.

I'm going to blame my poor commit msg for this.

Essentially it would be nice if when a user explicitly says "I want to
init submodule b" that we obey and do just that.  What this patch does
is allow for a user to do that and the "submodule.<name>.active" config
option will only be set to 'true' in the event that that the submodule
isn't already marked as being active/interesting by some other means.
So if we did

  git clone --submodule-spec=lib/

then each module under 'lib/' won't have their submodule.<name>.active
config set since submodule.active=lib/ already encompasses them.


But if no submodule-spec was given then it would default to all
submodules and set every submodule's submodule.<name>.active config to
true.

I'll add a few tests to illustrate this.

> 
> >  builtin/submodule--helper.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index a3acc9e4c..b669ed031 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -361,6 +361,13 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
> >  		die(_("No url found for submodule path '%s' in .gitmodules"),
> >  			displaypath);
> >  
> > +	/* Set active flag for the submodule being initialized */
> > +	if (!is_submodule_initialized(path)) {
> > +		strbuf_reset(&sb);
> > +		strbuf_addf(&sb, "submodule.%s.active", sub->name);
> > +		git_config_set_gently(sb.buf, "true");
> > +	}
> > +
> >  	/*
> >  	 * Copy url setting when it is not set yet.
> >  	 * To look up the url in .git/config, we must not fall back to

-- 
Brandon Williams
