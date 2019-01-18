Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAF1D1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 00:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfARAUS (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 19:20:18 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36290 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfARAUS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 19:20:18 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so3678469itj.1
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 16:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4iQCFzOK+ACG8X5+Cmz68aNr5HrIVHWvAh8+T8z/HU8=;
        b=FMelt1qFiF6ljwSkOTZtFMwr8wV4K7Blq7ftc8Yyv1IBkLfJsQriCbUTpHQumONdO0
         kmlkUgbmkzJImgxfAb5LL3BxPHOjHDeGSmzK75DVylnakooxTF9S7emGiXn3Wy7jHdkD
         oz7VykDXtbxc0DaoB2sWetH9hxwtNgmQgvLMDKao7gvt5iaq4cNoFfU0E8q3OqcvdM92
         gsMOmyLfBUEieXq4lOQ45MG/Dli5WtKAhJGD4pX9gOJKIO0muYZYxOO4M7nxtDsrhJTa
         i/4y/wvGXRV3PpfZ1dcHKxVrCh6uNE+qWtVGp8dLgRL2ZZXu9GUe4FTSeOBe++alE6TK
         sTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4iQCFzOK+ACG8X5+Cmz68aNr5HrIVHWvAh8+T8z/HU8=;
        b=pjhiIE1bHaDt9KEwctwRh1xD9jcPACYlkRg9ty0Jdu8oO8KGypd3vCWORuPZ/PkJKJ
         /YY0JddHOuvUzwMJOJ7ecx+lvJPL5UJKelQ6+upivrDwZRtADoXwlIUCd7azAeBpl8Or
         VNKxt3pkNNWjk9CEBis3cJ8qnprq2dEfHOThnmdrjnqFrznqkSriyYJ8cr05KKcCFq5h
         zWPMenooXl/NIkxMhKIVy0ccy5V5iTUp7OgevYVpRh9dEfOqaKctrE6bwSXNBkk7Tdba
         hTLih4KC2yD7+Z0UWOBK6U93+lzJisIJ8XPxsVzqBJWuShIw2r0VRE4dZZfeNQWWff7r
         D2SQ==
X-Gm-Message-State: AJcUukcEufW3nbi1mmeXvLilSyxBuN8zVlYTNzGZE5HkDs8FWGfmYThv
        eMxfDbOPf5RuX9I+X4Z3MjRQSCS1J8w99X1ybOg=
X-Google-Smtp-Source: ALg8bN7RW27WBzrSA95Ep8Oowwsyolh2tEfobl+FyboGpvcBomdPuWbS+uQA+tFZ7iJSxmWpe6tPkEBLTa75jVP8jBQ=
X-Received: by 2002:a05:660c:81a:: with SMTP id j26mr9893965itk.70.1547770817189;
 Thu, 17 Jan 2019 16:20:17 -0800 (PST)
MIME-Version: 1.0
References: <20190117130615.18732-1-pclouds@gmail.com> <20190117130615.18732-77-pclouds@gmail.com>
 <nycvar.QRO.7.76.6.1901172104380.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1901172104380.41@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 18 Jan 2019 07:19:50 +0700
Message-ID: <CACsJy8Cd0ZU-s7-=5isyt3QTs+bnznC5ZGq_Tb0K2ajWrY=BbQ@mail.gmail.com>
Subject: Re: [PATCH 76/76] am: avoid diff_opt_parse()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 3:10 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Duy,
>
> the change itself looks good, but...
>
> On Thu, 17 Jan 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
> > diff_opt_parse() is a heavy hammer to just set diff filter. But it's
> > the only way because of the diff_status_letters[] mapping. Add a new
> > API to set diff filter and use it in git-am. diff_opt_parse()'s only
> > remaining call site in revision.c will be gone soon and having it here
>
> ... "will be gone soon"? Does that mean that you mail-bomb another mega
> patch series iteration once you did that, now sending 77 or 78 patches?

That's another 75 patches.

> I don't know about others, but I can only afford to spend a fraction of m=
y
> waking hours on reviews, and even back when Christian sent the built-in a=
m
> as a loooong patch series it was *already* a big problem. Thankfully he
> seems to have decided to never do that again.
>
> It would probably make sense to break your 76-strong patch series down
> into at least four separate patch series, they would still be as long as
> my Azure Pipelines one (which is longer than I am actually comfortable
> with, but in my case, it was necessary, while your patch series consists
> of many, mostly independent patches that could even be wrapped into
> individual patch series of 1 or 2). It's just way too much to review if
> you present it in the current manner.

Sorry somehow I forgot about breaking down the series. Part of the
reason though was I wanted to show that we got somewhere in the end,
it's not just random restructuring patches that may end up getting
reverted.

If there are lots of changes in this series, I'll resend in smaller
series. For the revision.c conversion I'll make sure to send in small
series.

> Ciao,
> Johannes
>


--=20
Duy
