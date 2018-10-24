Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F8191F453
	for <e@80x24.org>; Wed, 24 Oct 2018 15:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbeJYAIW (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 20:08:22 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40859 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbeJYAIW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 20:08:22 -0400
Received: by mail-oi1-f195.google.com with SMTP id j68-v6so4444621oib.7
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trux-info.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ggIR+E5ovM1C8P+ka9NwzeG4A8U9BaoN310mkq00AKQ=;
        b=Uo+BWd49HseIvpd3cRu1Cuip9gw1WkYDskOht83LL88VUlyYY4SFQdySJMM7Ecj/U8
         7uhEMdfWm7UD1FmZ6vTpzS3UUscNrJPtaN1oK5xE8lKoBpZ5xJDBWSRs49XNI8OHsnQd
         FpQjqbFL/wkU53mqKasoG74x7jJhVjdy25OvdvTan48osFI0KCYQG4rm1uEkdyvsVTiP
         CdpK4l4cTSnW1H8haHtWfy7senoHKjTjTEESd0zrvxkv8NNxg9gH0Fc5ZM6t1tFoEToo
         hpLvwgG5kriD7Kgi1bTCoNzBP6F6kxvCZlSx3vnW0oEQLkAEEYvveHJ1nohmN+gqwuH5
         8syA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ggIR+E5ovM1C8P+ka9NwzeG4A8U9BaoN310mkq00AKQ=;
        b=bq845HwdHINtJ5fu7rBfgi5ME3CytBehau41YS9+CttPIaqFaBY7zm2nM+lyuvXT0s
         Z8dimGhU4hL+9dEr82VfLCTSelq510jIuGl9HTlXMQWTBMJ+d7p6X/iKLGJKQuwTn3fh
         RECm5A/VkVebpj1jv0qZuJ6AKlu16lo2k306nj+Lr+sI8DzDW2Fng1LXA+CTcooBGwIt
         ++xhqwPwUztp2239hf1vmT4PFFbZzT5TQrMVp3kIocYMQVujVDqAz2kgB5lo4XYXYPZe
         LdmJcomVqcXlzcEJ/wwhKg+1k0X/KdrV2XntmxrNAd1hj/Xi21IlxFSKI8C59qsi4/wc
         iQKg==
X-Gm-Message-State: AGRZ1gKi+sp0lnfeOza0ANUWFElGJ7QIip2G9fhg+jzlbIXl3TWynwvp
        TVrrhbsG9lTCOFfC3qVHWQfhh18YHAWEA5Y/wL782g==
X-Google-Smtp-Source: AJdET5eFkEAaQ8iHXl3d7CTJwC2bjEX1qN5eQEhIbqgJ3YiNbFu4QflvHKtDqTEucc8a6i8DjHLpWjt8NCssYnFYkq4=
X-Received: by 2002:aca:4509:: with SMTP id s9-v6mr1771598oia.234.1540395586976;
 Wed, 24 Oct 2018 08:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAGOLd-7Hi+tssj4ozKPd04squ-PuFwtt6f2nhbZp-zKwy62pVQ@mail.gmail.com>
 <CAGOLd-5Gbt6fQTvm+7018uX+8WF7NUWpa1sFWAg3-5bxtmOt-Q@mail.gmail.com> <CACsJy8C7pArdayQu9Kh5z6dczCqV_=XJP4wzR_dcm_W3MgG+Jg@mail.gmail.com>
In-Reply-To: <CACsJy8C7pArdayQu9Kh5z6dczCqV_=XJP4wzR_dcm_W3MgG+Jg@mail.gmail.com>
From:   Christophe Bliard <christophe.bliard@trux.info>
Date:   Wed, 24 Oct 2018 17:39:35 +0200
Message-ID: <CAGOLd-5J7+idqoREg0CHNcC0t6Mx3_bC_qbQaLgRLcssO+kxjQ@mail.gmail.com>
Subject: Re: bug?: git grep HEAD with exclude in pathspec not taken into account
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In fact, per https://github.com/git/git/commit/859b7f1d0e742493d2a9396794cd=
9040213ad846,
having only a negative pattern is like having a catch-all positive
pattern and the negative pattern (since git 2.13.0).

Thus, adding the positive pattern yields the same results:

> git --no-pager grep foo HEAD -- ':!fileA' .
HEAD:fileB:foo is false+
> git --no-pager grep foo HEAD -- ':!fileB' .
HEAD:fileA:foo
HEAD:fileB:foo is false+

Le mer. 24 oct. 2018 =C3=A0 17:14, Duy Nguyen <pclouds@gmail.com> a =C3=A9c=
rit :
>
> On Wed, Oct 24, 2018 at 4:55 PM Christophe Bliard
> <christophe.bliard@trux.info> wrote:
> >
> > Hi,
> >
> > I observed an unexpected behavior while using git grep with both git
> > 2.19.1 and 2.14.3. Here is how to reproduce it:
> >
> > > git init
> > Initialized empty Git repository in /private/tmp/hello/.git/
> > > echo foo > fileA
> > > echo 'foo is false+' > fileB
> > > git add fileA
> > > git commit -m fileA
> > [master (root-commit) f2c83e7] fileA
> >  1 file changed, 1 insertion(+)
> >  create mode 100644 fileA
> > > git add fileB
> > > git commit -m fileB
> > [master e35df26] fileB
> >  1 file changed, 1 insertion(+)
> >  create mode 100644 fileB
> > > git --no-pager grep foo HEAD -- ':!fileA'
> > HEAD:fileB:foo is false+
> > > git --no-pager grep foo HEAD -- ':!fileB'
> > HEAD:fileA:foo
> > HEAD:fileB:foo is false+
> >
> > In the last command, fileB appears in grep results but it should have
> > been excluded.
> >
> > If the HEAD parameter is removed, it works as expected:
>
> It's probably a bug. We have different code paths for matching things
> with or without HEAD, roughly speaking. I'll look into to this more on
> the weekend, unless somebody (is welcome to) beats me first.
>
> Another thing that might also be a problem is, negative patterns are
> supposed to exclude stuff from "something" but you don't specify that
> "something" (i.e. positive patterns) in your grep commands above. If
> "grep foo HEAD -- :/ ':!fileB'" works, then you probably just run into
> some undefined corner case.
> --
> Duy
