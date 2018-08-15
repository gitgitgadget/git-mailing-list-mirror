Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1725C1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 06:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbeHOJmZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 05:42:25 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44323 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728529AbeHOJmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 05:42:25 -0400
Received: by mail-ua1-f65.google.com with SMTP id k25-v6so257139uao.11
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 23:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NzE0dN2hnV/cKyZyyKGmdsMYOcHDIYhNPdQ1FInZ3Q=;
        b=q2XzT9f7B+yYfFHttNqlHC5PVrQ7ImTnVq9vWKTmW6L7OuWqXyXhAyaPSj4McUtWcP
         2LS98V7WdD1PRBcqQayft1+SzixgaDO2WNwoO4c/o0vAgj/ijI+haoigRqG70kkkFkKE
         U/62hlUC89F2AQpxNi/h30uchUbka0E/RroMSDaH+tADuUo0hthhyhbw8PHXuQTBTbuo
         oJ828tO2eH411oErHO0+bch55XzpYUmO5YEn2GNCMWrTyR4N3lwZdJFkWhfw/sECXvnx
         m9lJtQYer+7oMJ82zSVz+NGiahhAzQra0oCRXN0EA+3TMb2ld/3BYOUW4LEvsfhWHL14
         OfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NzE0dN2hnV/cKyZyyKGmdsMYOcHDIYhNPdQ1FInZ3Q=;
        b=hMlxvzaaTxLDCtc+Mm1shi4NvK35up2S/Ugf5gVHvLTbjr7lxszUpCn0shIM+rmQSb
         19VYR5Snt0asUrL2UpORgPwDQPHIzkvexgu9PmE1Or4mvQv4BuzwkaFcqoyLVvLExWfY
         TEssNbYdCGSbD1VvgqGeN1lg9julTyK7lyFI3AhxgGeBjs+rWRkfU3OdpaVK/nmfNHV8
         oVahFhaLEoyq4GCVL3ouJT9jaOJBT+MzGqIIvOsqDfbVxdbacbSF/POmOj8Do8+vg+30
         PW/wyD5fjT6u/+lif0AXXUN+VkeslmFvVagaqnT/BMrh/ykscVuPZGJLTcSMHktPEUqL
         VLzw==
X-Gm-Message-State: AOUpUlF0raQh/938htwGGP3Z4d6vcYWZ1sj6n9NHZnoBl3mhOXyruaFx
        7y+La0Oz4RLDMuFuusfkhqTNzNzTYBy8j9eSh+Q=
X-Google-Smtp-Source: AA+uWPyXSToM24j4EQCt6n9dXLOrHKfpPasyCe4OH4bc+T5Q89lt1jXe5GmjD8G9JAFGrvJxkxlsG87WLlevnxeXSfc=
X-Received: by 2002:ab0:66d4:: with SMTP id d20-v6mr16335897uaq.112.1534315889804;
 Tue, 14 Aug 2018 23:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180811205024.11291-1-newren@gmail.com> <20180813171749.10481-1-newren@gmail.com>
 <20180813171749.10481-2-newren@gmail.com> <20180815051011.GC32543@aiede.svl.corp.google.com>
 <CABPp-BFk2X5TApYzs3QtdokBs3Hqz9uX737M6RGMtaU+wYUikw@mail.gmail.com> <20180815061346.GJ32543@aiede.svl.corp.google.com>
In-Reply-To: <20180815061346.GJ32543@aiede.svl.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 14 Aug 2018 23:51:18 -0700
Message-ID: <CABPp-BGVVXcbZX44er6TO-PUsfEN_6GNYJ1U5cuoN9deaA48OQ@mail.gmail.com>
Subject: Re: [PATCHv3 1/6] Add missing includes and forward declares
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 11:13 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Elijah Newren wrote:
>
> > I didn't want to repeat that description in all 6 patches, since all
> > six came from that, so I put it in the cover letter.  Since patch #1
> > has most that changes though, I guess it makes sense to include it at
> > least in that one?
>
> Yes, that sounds sensible to me.

Will do.

> [...]
> >> enums are of unknown size, so forward declarations don't work for
> >> them.  See bb/pedantic for some examples.
> >
> > structs are also of unknown size; the size is irrelevant when the
> > function signature merely uses a pointer to the struct or enum.  The
> > enum forward declaration fixes a compilation bug.
>
> My rationale may miss the point but the standard and some real compilers
> don't like this, unfortunately.
>
> For structs, having an incomplete type is fine, but for enums we need
> the full definition.  E.g. C99 sayeth (in section 6.7.2.3 "tags")
>
>         A type specifier of the form
>
>                 enum identifier
>
>         without an enumerator list shall only appear after the type it
>         specifies is complete.

What about a type specifier of the form
  enum identifier *
?  Can that kind of type specifier appear before the full definition
of the enum?  (Or, alternatively, if the standard doesn't say, are
there any compilers that have a problem with that?)

If so, we can include cache.h instead.  We'll probably also have to
fix up packfile.h for the exact same issue (even the same enum name)
if that's the case.

> [...]
> >>> --- a/commit-graph.h
> >>> +++ b/commit-graph.h
> >>> @@ -4,6 +4,7 @@
> >>>  #include "git-compat-util.h"
> >>>  #include "repository.h"
> >>>  #include "string-list.h"
> >>> +#include "cache.h"
> >>
> >> We can skip the #include of git-compat-util.h since all .c files
> >> include it.
> >
> > Good point.  Should I go through and remove all the inclusions of
> > git-compat-util.h in header files?
>
> It's orthogonal to this series but might be a good change.

I think I'll leave it as #leftoverbits for someone else interested.  :-)

> [...]
> >>> --- a/pathspec.h
> >>> +++ b/pathspec.h
> >>> @@ -1,6 +1,11 @@
> >>>  #ifndef PATHSPEC_H
> >>>  #define PATHSPEC_H
> >>>
> >>> +#include "string.h"
> >>> +#include "strings.h"
> >>
> >> What are these headers?
> >
> > The original patch[1] had explanations of why I added them:
> >
> > +#include "string.h"   /* For str[n]cmp */
> > +#include "strings.h"  /* For str[n]casecmp */
>
> Ah.  Please remove these #includes: they're part of the standard
> library that we get implicitly via git-compat-util.h.
>
> I was tripped up because they were in quotes instead of angle
> brackets.

Indeed; will do.
