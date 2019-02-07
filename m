Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D83F31F453
	for <e@80x24.org>; Thu,  7 Feb 2019 23:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBGXtF (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 18:49:05 -0500
Received: from mail-vs1-f48.google.com ([209.85.217.48]:37706 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGXtF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 18:49:05 -0500
Received: by mail-vs1-f48.google.com with SMTP id s16so1096684vsk.4
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 15:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hbp1ZU57RJCr3buWrNJ5nnvOSIjTgQ1JIYAjVAEU3wY=;
        b=X2UQ7ytALTnFcPKtqRML0yR6A6zhADBb9UtphpPworZwDsRkizQ4DZeXyaFmYf3YF4
         woECadhyVTO0iDWu4MMCiQHrfytAOb94aybH6MBP8c/pUjjIoW8x0F0xZV1rzgdHh3Dw
         xD5Iv7FIZrjVlD0RF+KxMFt645aYi7LmXbPY+swx+d1losa9KjuXWcnQpJ1tgg0KUxok
         tZFTkRlbX9W83DKG93Y5FPAnxiwCFRTBWynaLtRx9QYDi1YCGU5YJ9f0SuCuYU+cLuoc
         jqOB9/TECDe+GVD3P9pxU+Wv4ewzEjY+Vh8lvuml6j94Rf2xXkJyoqE8XhOkqeRHobRf
         v5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hbp1ZU57RJCr3buWrNJ5nnvOSIjTgQ1JIYAjVAEU3wY=;
        b=oMs97H0Ske5t8l4bZfv2VTg3kjwSI4FEkbLpO53Rn1bwJBnXimG5WqOkuj4GMHymsO
         VQZHspQmP5AIVpVxYRSQsyo7Tnu4U7ogjqOTT+Nv0qcpBopOCvdnT8aSFJwnobkl7BNE
         hs56bb2MEoluQ9mhgwdb3eYBbjZgES80TKgWNvNnrN783Cs501FQvXr0uyfx+hfel3JE
         r0eAPb8jjUaVPI71vvrpPAgexx1QwzzKYan7cW7FYqMmu7CTJ+dblumLdxdYK+KMdcO+
         xmxG1mZiMcAcvnsC51GfaV6nW8iNKTKqohhMbs4ZckK5eRCSENHtwR7SfYEjvEs2jQqa
         o8oA==
X-Gm-Message-State: AHQUAuaCplbakNJCSAjiXAETrMwJ7saXBpg4wPz9SY3JvLLyxwD7Frt2
        wSaQ8zKBttHcKjF8OooavGdJmy8KCTmOVmQwV/0=
X-Google-Smtp-Source: AHgI3IaoWO9n6oClUYzAxMTbr1nu2QSNqSYI+AOlKeUX++hTkCdO6MGP5o3F+SET+DebvKhMYfO9Q3j70m8ZTrYksnU=
X-Received: by 2002:a05:6102:398:: with SMTP id m24mr2167644vsq.116.1549583343583;
 Thu, 07 Feb 2019 15:49:03 -0800 (PST)
MIME-Version: 1.0
References: <20190126221811.20241-1-newren@gmail.com> <20190204200754.16413-1-newren@gmail.com>
 <xmqqtvhfmdxf.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvhfmdxf.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 7 Feb 2019 15:48:51 -0800
Message-ID: <CABPp-BHN+RF+jF8ATpRY715f-YxBoaN42r1J0HxM0BwZFgc7Tw@mail.gmail.com>
Subject: Re: [PATCH v4] log,diff-tree: add --combined-all-names option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 7, 2019 at 2:28 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
> > index 231105cff4..69cb3b0349 100644
> > --- a/Documentation/diff-generate-patch.txt
> > +++ b/Documentation/diff-generate-patch.txt
> > @@ -144,6 +144,19 @@ Similar to two-line header for traditional 'unified' diff
> >  format, `/dev/null` is used to signal created or deleted
> >  files.
> >
> > +However, if the --combined-all-paths option is provided, instead of a
> > +two-line from-file/to-file you get a N+1 line from-file/to-file header,
> > +where N is the number of parents in the merge commit
> > +
> > +       --- a/file
> > +       --- a/file
> > +       --- a/file
> > +       +++ b/file
> > ++
> > +This extended format can be useful if rename or copy detection is
> > +active, to allow you to see the original name of the file in different
> > +parents.
> > +
> >  4.   Chunk header format is modified to prevent people from
> >       accidentally feeding it to `patch -p1`. Combined diff format
> >       was created for review of merge commit changes, and was not
>
> You need to replace the blank line before the new paragraph that
> begins with "However" with a line with a single "+" on it, to tell
> the formatter that the new text is still part of the third item in
> the list.

Sorry about that; including that in my fixes now.
