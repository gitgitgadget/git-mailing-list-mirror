Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22BEF20248
	for <e@80x24.org>; Fri,  1 Mar 2019 06:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfCAGQd (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 01:16:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39121 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfCAGQd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 01:16:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id z84so11078965wmg.4
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 22:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fjx2lqKK4fvYkBp7/Ere7FcQsKjij3GKVKIxOryfkIg=;
        b=eiocSD+9qiYkzjpkyL1ztO4ygeHECQo8b83ZMBGTDpSp0KtqYjQUSx5j78fYOnQiyM
         WG7cFhnuX8/lbrtjmfTmxl2KMGYi2SnkqWVTS+sErr2dDWE+a4Pl+FAvlvMW6qWXedIL
         4yspfCIj+UXG00hl/TKWtISbFpC4knFYldBM5DXqXBVIzZ5VmzBiRlKi6WuakhJfl33h
         6nsO8AyZqPBZBwXUZB11apYKuCmBE7zOGGKrepXJ8ir2nX+7xiSYbeMJ5Ka2mK057n8z
         MwV6vEOQ1fgGB1U85jrJS5z3T8udJV4VulbTK9kPjegAw1Y0MFGaX0fFInUXA6cag4M3
         HnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fjx2lqKK4fvYkBp7/Ere7FcQsKjij3GKVKIxOryfkIg=;
        b=KPx+ECnXvTfM/Ept7B0AD9Z2zByun/V4eFGfiML/Trrx5vml6BjJxv+/0eOvuybSX1
         TebBprFwqJUKVImwFTTCdxZk2RKtdrCqPxTTOsp70qvnWRf7xLySfP5bLRgCGLuS30DF
         YYR2Ywrlrc8k07df9y7MazLYxbl7EhKn2sB2bIgBme5235+FEwdAbe4UhMBfeaMYpqh1
         jLqsGK8ZYbVe7v6YcgHgJ0kmN3zZXAine+LqyWNHoD09i4l9HaUGwv7eqW5TYrsZo44p
         CfdpyNn6bMVSkBk1hw3ZBmLgGIsEt7VQg2gOib8lLpWokXF/R1DGxru+NjfllVMtAq6U
         BX4A==
X-Gm-Message-State: AHQUAuYCBW/pMrJjuTfkG2P9WSboorxmG4nQdBX62v4tf0YHpZXFlMlK
        ZT4PhrTTB0lsZY7kFMGmO7Zig/NmSFwEDt60/C0=
X-Google-Smtp-Source: AHgI3IY1b/ucDEbVlLi3bb5jhxjeVveMtBUu8nO2AF4ff3yYJGBysYl7XcdYD1LhIxqICdR1knh3dWhMxquG7zboUaI=
X-Received: by 2002:a1c:1fca:: with SMTP id f193mr1873743wmf.65.1551420991778;
 Thu, 28 Feb 2019 22:16:31 -0800 (PST)
MIME-Version: 1.0
References: <CAL21BmnVkKtYWa1cRL1EJAwtchGcVUzhu0136AuV8uXAi5Kuew@mail.gmail.com>
 <20190228214112.GK12723@sigill.intra.peff.net>
In-Reply-To: <20190228214112.GK12723@sigill.intra.peff.net>
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
Date:   Fri, 1 Mar 2019 09:16:20 +0300
Message-ID: <CAL21BmkPL1RDiz6v+=etJhFn3kmTMJKpnQa-qFFR224wFo8ubw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/20] cat-file: start using formatting logic from ref-filter
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=D0=BF=D1=82, 1 =D0=BC=D0=B0=D1=80. 2019 =D0=B3. =D0=B2 00:41, Jeff King <p=
eff@peff.net>:
>
> On Fri, Feb 22, 2019 at 06:50:06PM +0300, Olga Telezhnaya wrote:
>
> > It was a long way for me, I got older (by 1 year) and smarter
> > (hopefully), and maybe I will finish my Outreachy Internship task for
> > now. (I am doing it just for one year and a half, that's OK)
>
> Welcome back!
>
> Sorry to be a bit slow on the review. I've read through and commented on
> patch 10. Some of my comments were "I'll have to see how this plays out
> later in the series", so you may want to hold off on responding until I
> read the rest. :)
>
> > If serious:
> > In this patch we remove cat-file formatting logic and reuse ref-filter
> > logic there. As a positive side effect, cat-file now has many new
> > formatting tokens (all from ref-filter formatting), including deref
> > (like %(*objectsize:disk)). I have already tried to do this task one
> > year ago, and it was bad attempt. I feel that today's patch is much
> > better.
>
> I'm still concerned that this is going to regress the performance of
> cat-file noticeably without some big cleanups in ref-filter. Here are
> timings on linux.git before and after your patches:
>
>   [before]
>   $ time git cat-file --unordered --batch-all-objects --batch-check >/dev=
/null
>   real  0m16.602s
>   user  0m15.545s
>   sys   0m0.495s
>
>   [after]
>   $ time git cat-file --unordered --batch-all-objects --batch-check >/dev=
/null
>   real  0m27.301s
>   user  0m24.549s
>   sys   0m2.752s
>
> I don't think that's anything particularly wrong with your patches. It's
> the existing strategy of ref-filter (in particular how it is very eager
> to allocate lots of separate strings). And it may be too early to switch
> cat-file over to it.

I have a guess that we need to add batch printing argument to our
general printing functions, that could make my version faster.

>
> > I also have a question about site https://git-scm.com/docs/
> > I thought it is updated automatically based on Documentation folder in
> > the project, but it is not true. I edited docs for for-each-ref in
> > December, I still see my patch in master, but for-each-ref docs in
> > git-csm is outdated. Is it OK?
>
> Yeah, as Eric noted, we only build docs for the tagged releases. In
> theory it would be easy to just build the tip of master nightly, but the
> data model for the site would need quite a bit of adjustment.
>
> -Peff
