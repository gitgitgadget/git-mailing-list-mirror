Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA83B20248
	for <e@80x24.org>; Tue, 12 Mar 2019 00:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfCLAS6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 20:18:58 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:36937 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfCLAS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 20:18:58 -0400
Received: by mail-io1-f50.google.com with SMTP id x7so525827ioh.4
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 17:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=MUUpe0tXrb87CCxchDirM/TR8ltfXXy8B5EjpEp/BkE=;
        b=WdQ+L6q+HnRQMtrSPVaBth/Brm5WFOnelmvKOS2PYtdGcP5vUhBvxRXRApyR1uZ8gx
         dXt8t+KuBRDm7RKC8rXq7BPlGqbuFYYWT2ZlFWPq6t2ZmIZxi9rZAVQ/tqj+71EhVPR/
         Qb2I3xK1Q7Fn69es70r1lFPmqCYwIgyMaIq2D5pxhhp1ioxOttAzE44Uvw3OKahUg/q8
         LS8g+si+lnk63cdWnkTI7O6psu7E5GnMnQp7iYUr7mbesi2yjelJopEX2V09u7INpl7z
         tOJ0geOrBycFM4Dw6mx15IpQ+94rnOL70EBFoIPTAMBt/1PlTR82Qh7pDjqFktMucCCP
         sl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=MUUpe0tXrb87CCxchDirM/TR8ltfXXy8B5EjpEp/BkE=;
        b=gg9u0fx9FcS03dvdfmhYDmC189Q+TNgT0uX96ckUT1166vXA7i10cvD3UMkTGmBZu3
         3GwObZHg6bdOXBQmmc8helsjhED2vPylFI7CB4uAeJ8bZBD1LFvjWrIRDAJBIZPbBKM6
         q9bIqE06O/9/E7c+xwdvwIGeYNgoCaCqnTWma19O77b67gGTFIiokEHGdAz0sjw39uRa
         i91rY1sJ3SIQP2xvwXcD33A+oFGT5n5H06VEGiurHLTtOvvXOtPp/Kc/Xb3BIpxcTUMc
         djoMbDq6VR3Eno2DnN2YEGKpqyOZJW2ZPKmH3+CXIYNk7MKuVbu5ur7oJTU8yNVnpY+C
         PWZA==
X-Gm-Message-State: APjAAAWeFzfAHm3FMjP+Rk1iqcm+k9XVZQ7EjebHTs19iN2hwhzG7B9g
        uaBi7+GXIPmC16ayo8KvjK5YDVbbeeliASOnVtA0aQ==
X-Google-Smtp-Source: APXvYqxyhHYUe4b/fEiU3Aucz0T8h5HnkF0278ozob9JuxEbSZY1ijGfV3i7KOAjuy6e0JZ0mlT1RG5wRjud2lSvv4w=
X-Received: by 2002:a5e:8f03:: with SMTP id c3mr4903751iok.21.1552349937637;
 Mon, 11 Mar 2019 17:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8nnFYt0raL+twrG_v8XZn_FDJWyM=tH=QL13Z70_bHRiQ@mail.gmail.com>
 <CAPig+cTCOfDCv=L3EWUqgVZx1VCdqt5ZjmSQMwHLX=R4C4hgTA@mail.gmail.com> <CAH8yC8=YrZR=j9R8Ae+O2UzfxB_Hc1Osu68T-M1mczHiEasfJQ@mail.gmail.com>
In-Reply-To: <CAH8yC8=YrZR=j9R8Ae+O2UzfxB_Hc1Osu68T-M1mczHiEasfJQ@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 11 Mar 2019 20:18:26 -0400
Message-ID: <CAH8yC8kkzOwCqN_qruQgAWbTMKzZ_CenrD_etFwZNm=JgJZ7oA@mail.gmail.com>
Subject: Re: Solaris and sed: Too many commands, last: s/\n//
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 7:52 PM Jeffrey Walton <noloader@gmail.com> wrote:
>
> On Mon, Mar 11, 2019 at 5:15 PM Eric Sunshine <sunshine@sunshineco.com> w=
rote:
> >
> > [cc:+=C3=86var]
> >
> > On Mon, Mar 11, 2019 at 4:32 PM Jeffrey Walton <noloader@gmail.com> wro=
te:
> > > I enabled self tests for Solaris. Solaris has some anemic utilities s=
o
> > > I put /usr/gnu/bin first on-path.
> >
> > The first question is if you are really running GNU 'sed'? My guess is
> > "no, it's still picking up Solaris's 'sed'".
>
> Yeah, you're right:
>
> $ make test V=3D1
> ...
>
> gmake -C t/ all
> gmake[1]: Entering directory `/export/home/jwalton/Build-Scripts/git-2.21=
.0/t'
> rm -f -r 'test-results'
> SED VERSION: sed: illegal option -- version
>
> I wonder why ... Let me check if I am exporting PATH.

I was not exporting PATH, so that was my mistake.

However, PATH is now exported but I get the same result.

Is the build system clearing the environment?

Jeff
