Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 302EC1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 17:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeI1XjI (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 19:39:08 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43767 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1XjH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 19:39:07 -0400
Received: by mail-yw1-f65.google.com with SMTP id k66-v6so2916561ywa.10
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 10:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6sIuQTbOFDtPBT37K0fIxsajEwlryy3j6/X/rnf8pQ=;
        b=rrkJ1D1D5f5YUWA2gUwyjVGe0Ir4x6R1pULGy+1zpeGjLB7ZgY9JLK+2PI/2OlZfIv
         xgR/u337uplQpP4EXXkM1MSNcQenOGi6j3I45vukyMIO02kfO8lc24OcUC3pIYzRZu8m
         ncDyrJxOJSIJrkwgH9uzXxbA9uiFqcsjePwKqI44p3S6kfCtpF7BbCNu68ruPM6GeYjx
         umk6O0A14sY1eMMCHA3b1v18NS/JbjcSgFpxqEaYNpM8dxlRB6ZyS2UwjJUi4vBJaT+e
         FhuGETuSmiGk/YcIF+2BhS3ek4qRucSijqw+LKf93E3qPxTQvvg92618v+dtLDIASufv
         YHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6sIuQTbOFDtPBT37K0fIxsajEwlryy3j6/X/rnf8pQ=;
        b=Z/pY5PE2NVw6/syaMyckUlX/hWib1dP7Ea7q+77IvBd+f/Bmj2SS0qDTFnmRKH2L4M
         1N8mB6XIj2slqULcbIjMV6cItTf54RfHw/KJh0wVj2/5xd1dO0EJqeef42YyvngJkHaC
         KUp3SCLY0nLO8MJqlsSodbTwcYb3k8OsxrdABBSHe7njNTNnUaCry1v9D2C6mo2bH768
         qhiVNjFVlDFjRdVyn6FrL1rc5IgcEA0pGwy/Egnnwc7q4SPrPJFWQxCwx4J9Nzu8/zg+
         Wug3I5Q23PLtdVyaOlZLMngpObjcoyFnlz2NQOwTvtCi8i/28q6ICjCJtIWuk+o8Yevl
         UrDw==
X-Gm-Message-State: ABuFfogEAb/G4DD1ks1R/MEzqiJ5o9AXqqNExUH2TN4ic6ZcIyCOYs9G
        dZAa13QJnO+V6YrjlisMEwqEjVlkeWXsf2wr8v0iew==
X-Google-Smtp-Source: ACcGV62ZEZPbx72NW71yEunIkFzHeQyzEa2gaWnMgtb8oM+UZwvfqYCvN9s1E2sMtj9u+2V/AzpQlXTZDPhEn3TvbC0=
X-Received: by 2002:a81:b64c:: with SMTP id h12-v6mr9292629ywk.119.1538154863973;
 Fri, 28 Sep 2018 10:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqwor6hmgk.fsf@gitster-ct.c.googlers.com> <20180927212727.128214-1-sbeller@google.com>
 <20180927232732.GA216193@aiede.svl.corp.google.com> <20180928011129.GD11281@sigill.intra.peff.net>
In-Reply-To: <20180928011129.GD11281@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 28 Sep 2018 10:14:12 -0700
Message-ID: <CAGZ79kZzR+n+8ODs3SBhOEXFbOmccugOampzkpFKGoEXjggEwQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/CodingGuidelines: How to document new APIs
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 6:11 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Sep 27, 2018 at 04:27:32PM -0700, Jonathan Nieder wrote:
>
> > > There are different opinions on how to document an API properly.
> > > Discussion turns out nobody disagrees with documenting new APIs on the
> > > function level in the header file and high level concepts in
> > > Documentation/technical, so let's state that in the guidelines.
> >
> > I disagree with this.  I think we should put all the API docs in the
> > header file, like we're already doing in e.g. strbuf.h.
>
> Me too.
>
> I think other high-level concepts that are _not_ APIs (e.g., file
> formats, protocol, etc) could go into technical/.

That is what I meant with high level concepts. Anything that talks
about or implies the existence of a function is clearly header level.

> (Though actually, those are the thing that I would not mind at all if
> they get formatted into real manpages and shipped to end users. We do
> not expect most users to dissect our file-formats, but they could at
> least be useful to somebody poking around).

Formats are sensible thing to present to the end user. I was also thinking
about partial-clone, which is a concept rather than a format.

>
> > Do you have a link to where in the discussion this split-docs strategy
> > was decided?
>
> I think the purpose of this patch is to spur people towards a decision.
> :)

For me it might end up in an exercise of writing clear and concise English.
Though after reading Junios patch below, I would hope that may find
consensus.

Stefan
