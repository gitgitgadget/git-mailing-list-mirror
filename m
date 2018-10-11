Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 202DF1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 07:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeJKPQy (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 11:16:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40567 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbeJKPQx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 11:16:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id d2-v6so8501759wro.7
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 00:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Vg41tpYWThPWV3MVSGJry7si9K5o/GYry3EyBOYHUV4=;
        b=QtOL1LZJ5rgZeD+8IUh1KJTej8TugL13RpXgKDVzfdUfwK7oDeyntbS5nv4uPsSWb0
         3LNhHW8CHZEiQgxbOPspYB3rf+g9h+WNp1uVYuBbeC7t7POILi0KnQlRYe/JTBrn9th1
         MpjxOmMg/BbfSukHTSxAsdG5NmLuXgZ/avGmjMGdWzj8bHWSu6BGQE08fbWe8zSMjrT+
         Eoi52uO0neApYjmT+ipcqrzvJnLYpySdPXmQgYX/UcToOqcrBfWoHWz6M1VLjti6ZSkQ
         UYDP1A2/ySFb5om1A2qqI/2/IKqOy8FvmZipB4+ynUQ/YqBrVLWEwZ27N6GxGcxD/Fhx
         9d1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Vg41tpYWThPWV3MVSGJry7si9K5o/GYry3EyBOYHUV4=;
        b=JeMPmyj2N4mF6ZEkRVAG2pO2KfxqUYMCgz9Fni43W8tYZWJKVHjXZ6PcKxp73WXRk5
         eLzTfUFpGEJfldhdbGwetqiYAezx3RO+FIFD58pqJdDMuTugJ0eU5AWohENDn71gaisH
         FfwYHioz2aJOmoOIWsWyQXNzB1lisVWHCQPWWY4wgc+Vckw6DGvTDnx/W7Ly7+MsDg9X
         guPFOAJo/s3geVdIEei0cUAGPjnJiKOVTnIutvQC1mg6Y1Snpv8noVv+bO0uNYa+r5Wh
         9rLn9WSxRckx+r/ecoNnzlrxf8vss2IfQpCcFwjVgZPjoWdlLYa9yVpxo7PK6Hsr0Sku
         QLpg==
X-Gm-Message-State: ABuFfojL5qSpokzxWsfApy5LkhWM5DakZRlkTzjzeezTyOEMHwJ5R7pL
        MhlDzWeQ2oYHLg8KuLlemTq2WXhD8ZOhj5hY8lo=
X-Google-Smtp-Source: ACcGV63dgTMVx7eJL50kORR3Z325N/7rzZHlBjLsbE4Y4/QbPKcaQ5veflZvQa4FI6sYIZRik4MsCuaJQcI4en4XHV4=
X-Received: by 2002:adf:a447:: with SMTP id e7-v6mr500219wra.190.1539244248058;
 Thu, 11 Oct 2018 00:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20181010150916.4295-1-lucas.demarchi@intel.com> <20181011000233.GX432229@genre.crustytoothpaste.net>
In-Reply-To: <20181011000233.GX432229@genre.crustytoothpaste.net>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Thu, 11 Oct 2018 00:50:36 -0700
Message-ID: <CAKi4VALL5nnLfo4ZxtifKE1JmcmUQ6F-9GSAQEMxXLjKsCtSmg@mail.gmail.com>
Subject: Re: [PATCH] range-diff: allow to diff files regardless submodule
To:     sandals@crustytoothpaste.net,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de,
        t.gummerer@gmail.com, sunshine@sunshineco.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 5:02 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On Wed, Oct 10, 2018 at 08:09:16AM -0700, Lucas De Marchi wrote:
> > Do like it's done in grep so mode doesn't end up as
> > 0160000, which means range-diff doesn't work if one has
> > "submodule.diff = log" in the configuration. Without this
> > while using range-diff I only get a
> >
> >     Submodule a 0000000...0000000 (new submodule)
> >
> > instead of the diff between the revisions.
> >
> > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> > ---
> >  range-diff.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/range-diff.c b/range-diff.c
> > index 60edb2f518..bd8083f2d1 100644
> > --- a/range-diff.c
> > +++ b/range-diff.c
> > @@ -354,7 +354,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
> >  {
> >       struct diff_filespec *spec = alloc_filespec(name);
> >
> > -     fill_filespec(spec, &null_oid, 0, 0644);
> > +     fill_filespec(spec, &null_oid, 0, 0100644);
>
> If we have a system that has different mode values from the common Unix
> ones, is this still correct or does it need to change?

From what I can see this would still be correct, or at least git-grep
implementation would be broken.

Lucas De Marchi
> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204



-- 
Lucas De Marchi
