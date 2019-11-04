Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A770C1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 20:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfKDUjH (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 15:39:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46102 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfKDUjH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 15:39:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id b3so12918020wrs.13
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 12:39:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RccjHbLXf5HZ9nz+TavtGH1r6fHA4Ty9S/Urm2ntJeI=;
        b=XCBoOIm8ejjVM0tm04/A5HIgrCQnFPoPq77Go2Olu2OA5J1+GYNSgb0SEuWM1ZIKkG
         OQR8MHghQHGLkKw2Vi7HaSvCshjLX1GAIBpfRtVVSEIyIHpj0yGUnf2Odl5fzN/tbW4q
         n21Lt0L1t9N6/f7uqnRQJPujyBCY2UPt9DI/sJumgs7LOFaTMzGor71x2zPoIzXyNFCh
         tMYV3LxdElrD8GWLca5kpFhK9/LHXfEmbbsp97tYKZLLsJPq/AxujQYpXGQOucSsdWjw
         AwM6pE88jd4UvCaGOPCnDtFFqPUeSDV8fuYVstU+NDUlHB/ZG5JVzgBRS5RiBVngvMgn
         0vYQ==
X-Gm-Message-State: APjAAAUeH5gTc2UKIY9726YA76Yq3+LagmIekEg8l8xmfmfij3yyVAEd
        OHeuJoGEy/ehtg2aoCHErOHGUUoRsMqA1M5F9aIJAQ==
X-Google-Smtp-Source: APXvYqw11gZVnNj/dMWOwP3zLKBz4Y7CPfK6s+RM4DysfFqhV3329clHdW9ulygKyNQS5FLk8AKpD1+JvgtDLmZeeUA=
X-Received: by 2002:adf:d18b:: with SMTP id v11mr26225396wrc.308.1572899944942;
 Mon, 04 Nov 2019 12:39:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572897736.git.liu.denton@gmail.com> <64b6f7c9d7434ba39929220c1aebcd9a1fd0ad6e.1572897736.git.liu.denton@gmail.com>
 <CAPig+cRVgf3q6-mHeMgOThCrhseTGtYt+S6x1ikUSEKGbUTz4g@mail.gmail.com> <20191104203558.GA8004@generichostname>
In-Reply-To: <20191104203558.GA8004@generichostname>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 4 Nov 2019 15:38:54 -0500
Message-ID: <CAPig+cRqYhUACkUKKzy2bCY7pZn=mZFVdxepKuiKuvwBEBJ5xA@mail.gmail.com>
Subject: Re: [PATCH 7/8] pretty: implement 'summary' format
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 4, 2019 at 3:36 PM Denton Liu <liu.denton@gmail.com> wrote:
> On Mon, Nov 04, 2019 at 03:16:56PM -0500, Eric Sunshine wrote:
> > On Mon, Nov 4, 2019 at 3:04 PM Denton Liu <liu.denton@gmail.com> wrote:
> > > diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> > > @@ -63,6 +63,15 @@ This is designed to be as compact as possible.
> > > +* 'summary'
> > > +
> > > +         <abbrev hash> ("<title line>", <short author date>)
> > > ++
> > > +This format is useful for referring to other commits when writing a new
> > > +commit message. Although by default, '<abbrev sha1>' is used, this can
> >
> > Why does this talk about "sha1" when patch 1/8 removed references to
> > SHA-1 in favor of generic "hashes"?
>
> Good catch. 1/8 modified pretty-formats.txt but this message references
> the content in SubmittingPatches.

I'm not sure what you mean. This change is touching
pretty-formats.txt, not SubmittingPatches.
