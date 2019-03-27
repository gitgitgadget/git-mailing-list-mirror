Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 328BF20248
	for <e@80x24.org>; Wed, 27 Mar 2019 17:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfC0RBk (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 13:01:40 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:42626 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbfC0RBj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 13:01:39 -0400
Received: by mail-ot1-f48.google.com with SMTP id 103so15559876otd.9
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k/+buEBVVnSeLDd4/z8te86fWloWeVeFCKenE7N2z1M=;
        b=pmCTuc4tkZuWdY/5xwQZXISigFfRtkQ+zeT+BKBtGVt3wp4dh7wz/0xl3+scIiiGaj
         faFMdBjknvEmhPngY+US8mEYMllQWxSNSP99pAtciiKdZ//j4bKbm0x9Q1yg5ZAeV829
         u2SsebbAOTYbIwwM4pO96trxl6yl4ZF9eERmAxdGFJke1LJ0w1jkZHnHSuMY5YiSEMcM
         DU3+UoLPF334XOT+QkWb6cl4clcJhz23zxlnb7PgVS3t+hCiZes/tYoqWJXgns9mlIfM
         vyCt376ojaYOgOpslC9YUz/IJMPPSErIQBCTzAmf9FFKNGPDtfE2eje0H2FYHkb/RBH+
         gySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/+buEBVVnSeLDd4/z8te86fWloWeVeFCKenE7N2z1M=;
        b=HuAOVtggdjpZlHGdwfvedM5Kwnvf/zBkoBvXUthffJda+q8HusS6W8IZCA/1wFcL2D
         jOtfziJBgDMluv2MHEKvd1Z/zEIx624kjDdJaxdc7L2KJ9PO+b8IfQsIYLPxs3LmsWQ+
         kg8qQKbQElWH3QY69TGeWmxJ870XM5y6gFL6R/CEfaVvi7Fm4v1/wPZajZX0yAjG9aYD
         fpParzEASpIxUKIi0ggVri/L4Az2f5nI5u3zeV3wegeHNyRWKtGl2nRRKA64/hoRAs4N
         oqp49gR5sgwlRi1vb/1Xr9oC9G9B0PstIAT50z0uuCYUoQejJqFHdyth7o00seb+xreT
         FFCA==
X-Gm-Message-State: APjAAAWr9ogpw4/0PrugrBDGwLlHujT5S5qlqNlOkncR+RG2VR3qn1tn
        RyGKvVH8+kvI+3psvq8wh9t/K+tQp1I5LQnrvaY=
X-Google-Smtp-Source: APXvYqzZ0QlZUgMdPGQBxcQyczFey15AR+W6cyLS5ASvTiuUYQrv3uZ6CGA6sLVyw24j4Pt+XXIwxXdtCmX0dEoMhao=
X-Received: by 2002:a9d:5c89:: with SMTP id a9mr19292734oti.12.1553706098007;
 Wed, 27 Mar 2019 10:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAMknYEPrrpxESK0onwTHRbVwcZE2YQpT=RVzjb9JfEBEXt4NRA@mail.gmail.com>
 <CAL21Bmn0BQirS=vyTRHBx_kfuEp1JY4uw2wkjm5w_pgwgjA5iA@mail.gmail.com>
In-Reply-To: <CAL21Bmn0BQirS=vyTRHBx_kfuEp1JY4uw2wkjm5w_pgwgjA5iA@mail.gmail.com>
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Wed, 27 Mar 2019 22:31:26 +0530
Message-ID: <CAMknYENndiGBkC75aaYwWQZ0rkR5Nn=2L8f-PTzBNOXmhhHWZA@mail.gmail.com>
Subject: Re: [GSoC] Unify ref-filter formats with other --pretty formats
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Mar 26, 2019 at 2:48 AM Olga Telezhnaya <olyatelezhnaya@gmail.com> wrote:
>> Kapil Jain <jkapil.cs@gmail.com> wrote:
> > Now, the verify_ref_format function can be used inside
> > get_commit_format function, hence reusing logic.
> > Is this a correct example to work on, for this project ?
>
> Hi! Yes, in my opinion your example looks like good starting point.

I read through the code of both functions, and I think they are different.
Please point out if I missed to see the similarity.

or may be it seemed that way, because they both deal with different formats.
So, first should a translating function (pretty to ref-filter) be written ?


> > Other than this I can't find any other example, for this project in
> > pretty.* and ref-filter.*
> > Perhaps some examples could be found in command specific files, right ?
>
> Other parts of the project are about reusing other ref-filter logic.

So, the project is not limited to reusing ref-filter logics in pretty,
it is about reusing ref-filter logic wherever possible, right ?

> For example, we could try to reuse format_ref_array_item() from
> ref-filter.h.

where can format_ref_array_item() be reused ?

> I haven't dig into pretty.c logic much, but I guess it
> is possible to translate "pretty" formatting commands to ref-filter
> ones. That will allow us to remove similar logic from pretty.c. Our
> final goal is to minimise code duplication and to have one unified
> interface to extract all needed data from object and to print it
> properly.

I looked, and yes some, but not all pretty formats are translatable.
For example: %GP, %p, %P. are not translatable to ref-filter. or is
there a workaround to translate them ?

It looks like to reuse ref-filter logic, a translator from pretty to
ref-filter needs to be built.
So, building a translator would be a starting point ?
and then second step would be to recognise places where ref-filter can
be reused, right ?

> > what is atom ? is it a piece of a whole document ? and what is meant
> > by used atoms ?
>
> I had the same question in my beginning. Please have a look at [1].
> Another good question - what is object. You could ensure that you
> understand this by reading [2].
>
> [1] https://git-scm.com/docs/git-for-each-ref#_field_names
> [2] https://git-scm.com/book/en/v2/Git-Internals-Git-Objects

Thanks, this helped.
