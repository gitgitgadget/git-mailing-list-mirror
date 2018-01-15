Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B751F1F406
	for <e@80x24.org>; Mon, 15 Jan 2018 23:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750752AbeAOX51 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 18:57:27 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41705 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeAOX50 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 18:57:26 -0500
Received: by mail-wr0-f196.google.com with SMTP id o7so13440976wro.8
        for <git@vger.kernel.org>; Mon, 15 Jan 2018 15:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BJyAMhUIziad/Yel5FkVDuSungjbYdlnyJN/gr+RHkU=;
        b=OG4zmmukiu5hw3e3TPztiFXRe01JrvGp/so51+voRE3dW2mO8VQdlUbwIvonyFfLcD
         D/lyYdV/3pJGBcfnBkTq3rJ33d/rR8rVbcr/mJ1RXJukDLNlZR7CCpU72OguaphqwvJC
         5MWMkrV03+Wt78MCruDMrn6enMPkwpHRYZqrceAh9/huhh64zf4uOms22BHaqxQnNL59
         RYgUpfN5wnSQYmIL3f3NiTYI0WZS7dBPK8XnN78C4oUOxjvZoB10wr3EJEQvw5gndMEx
         1/v3CajiO0BxY4S3xI/W/lkw0LLz4hreg8bK9Vmko5ILX1ZuGIFKs4njrt5bjalnqkEM
         zjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BJyAMhUIziad/Yel5FkVDuSungjbYdlnyJN/gr+RHkU=;
        b=tK5rmwnEaTBOO04B5y32YBd/YO9tIf20uu0tfhJmxjY1sxcrC1QLB1Ulm93i+HMu3h
         AfoyUqVkPleaDV3wI/Sj4+iR77sTbvLMsh+ttCTNpPRpHTrJxjXvEm/72UsVCQAsZ11/
         hy1/89Z3WfnGpMt+TbyVLHGnzHgam65j3k1i01BblxIkwjsUqSgRAMIxZlx3kfZ+4vWl
         w/CMBHoJvgkNDNP45hlgjrQR4CBfhIk4D4fqSjnXCForK3ZEWwwe6cPtwbDRMw/Cfnb9
         +JCfVtwnntpmPWmInt9vOarPWf7bo6rFhZ1tDSJxZR7kGIFrHUG9/AAYYJZbCZRC+NiN
         D/0w==
X-Gm-Message-State: AKwxytfhDcO/P9zkROfuzukZ5M8IXVrAS6zG9lnpn0BeOFnj8jddFohQ
        17AjCtE/fO93kEflV8/mVSMbpVSL
X-Google-Smtp-Source: ACJfBosZwtqWH6NQjVsWSGOobN4F3b7Re4ATKgqdMnEwNnTNlRI0CzLm48KYQY7b8A/ZX/gxPF4krw==
X-Received: by 10.223.133.136 with SMTP id 8mr6089818wrt.99.1516060644956;
        Mon, 15 Jan 2018 15:57:24 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id a41sm1209042wra.72.2018.01.15.15.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jan 2018 15:57:24 -0800 (PST)
Date:   Mon, 15 Jan 2018 23:59:43 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Removed unnecessary void* from hashmap.h that caused
 compile warnings
Message-ID: <20180115235943.GM2641@hank>
References: <20180114180748.14584-1-randall.s.becker@rogers.com>
 <20180115204301.GL2641@hank>
 <007801d38e42$6b6df3b0$4249db10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007801d38e42$6b6df3b0$4249db10$@nexbridge.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/15, Randall S. Becker wrote:
> On January 15, 2018 3:43 PM, Thomas Gummerer wrote:
> > Thanks for your patch!  A few nitpicks below:
> > 
> > > Subject: [PATCH] Removed unnecessary void* from hashmap.h that caused
> > > compile warnings
> > 
> > From Documentation/SubmittingPatches:
> > 
> >     Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
> >     instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> >     to do frotz", as if you are giving orders to the codebase to change
> >     its behavior.
> > 
> > I liked the subject Philip suggested in the other thread: "hashmap.h:
> > remove unnecessary void*", or maybe "hashmap.h: remove unnecessary
> > variable".
> > 
> > On 01/14, randall.s.becker@rogers.com wrote:
> > > From: "Randall S. Becker" <rsbecker@nexbridge.com>
> > >
> > > * hashmap.h: Revised the while loop in the
> > hashmap_enable_item_counting
> > > 	to remove unneeded void* item.
> > 
> > As above, this should be described in an imperative mood, and describe why
> > this is a good change and should be merged.  Maybe something along the
> > lines of the below?
> > 
> >     In 'hashmap_enable_item_counting()', item is assigned but never
> >     used.  This causes a warning on HP NonStop.  As the variable is
> >     never used, fix this by just removing it.
> > 
> > > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > >
> > > [..snip..]
> > >
> I like it. Do you need this resubmitted? Or should I just learn for next
> time?

I think it would be good if you resubmit the patch.  These rules tend
to be applied quite strictly, as you can also see when looking at the
git commit history.  So with the updated commit message Junio should
just be able to pick it up (unless there's something I missed here as
well :))

As a side note, I just noticed the two submissions both had [PATCH] in
the title, whereas new submissions should be marked as such using
[PATCH v2] etc. as prefix, so it's easier for reviewers to know which
version is the newer one.

> Cheers,
> Randall
> 
