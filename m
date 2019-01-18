Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B11F31F453
	for <e@80x24.org>; Fri, 18 Jan 2019 09:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfARJlR (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 04:41:17 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:45717 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfARJlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 04:41:16 -0500
Received: by mail-io1-f53.google.com with SMTP id c2so10164620iom.12
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 01:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cRLWPwU4p3Px3egT6ixaVWfnhh8QcQJsSPMOyrlSir8=;
        b=LoMzL6wY4beyNqkB1VxyMVa92rsHcSEHms4VzDIldRGpaa/hWvXEjjUYyYpODNjGOV
         VbsQNCsBBNMBc6kj6SQKCKe3ir74KlJPk7iCFWH4e7/wEhdtfwu/WWhv/eXCzHNVefFY
         VsuPN/vMl++ejh9nQZnP4ri+pGXh0bOSr1BMR/FhxfjohzXu218Q6ybp4qbLzuHVV+AY
         G9SYuq8x7/LGN9ezmOlNJhv+O7ZT3QpetAZe0qrLk2WN/sPJ1Y0igYNqTxlJs0kE1WJq
         qO81JOb3YBg87NJ25uVePMNkPNnILIV6bBeu6s87dBQV1+tAZVoLPrhUV2zNkTZn2iHF
         9rKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cRLWPwU4p3Px3egT6ixaVWfnhh8QcQJsSPMOyrlSir8=;
        b=YCsuJQA1kOb33k4HQ9cHfJlV9u2/n4A+cKbkTAdu185mcpFJHjC16l4ogfYuCcBAJ8
         ZZUnuy5i+mvk3GQw/d2O9nWAPweJwCIFLTD62MKOyTo8V/DRSrh+QGeQ6A+ppdcYXr2q
         1KW5t/+zEM1HLqD3jfwwtkkqOuRM5ndI+IIsXcHK7+GLozohmxGHajY9UssL92Hhbk+g
         43KUNLhKV+ytA660kijT/+5rMUoMlE9G5eKWfkGkC/kZnaIqQcwt61lv3TcRd8eErktv
         Px8vP0U9qWgWa6rQg2PYDTTv1b3aAOInsuy2eq9RuYzzzQIWlpqsCp4xmT+FF6f/a1Es
         b4XQ==
X-Gm-Message-State: AJcUukeXsOKRvIxS1+Ptawgdl1ahvCS7iMc2Wh+CgpWECSRo29HHyApq
        Idkp4ZiK/enbGjnKCB+xE87jG6cQfbKYzlnel22Tc4BI
X-Google-Smtp-Source: ALg8bN7nO7JddnJ9TdCw0saXzwQnXKBoThuonZtDg5b/TZZ3V7OwXIsFM6+0YsHX3Fc6/osBe1Y1h7ExYVoijyc/5RQ=
X-Received: by 2002:a6b:3b4f:: with SMTP id i76mr10450068ioa.266.1547804475937;
 Fri, 18 Jan 2019 01:41:15 -0800 (PST)
MIME-Version: 1.0
References: <CAK3b1G+88a=xfO=6wfRi1SMy3xtca2NcFyxuBLKwSifb_L9xwA@mail.gmail.com>
 <20190117160752.GA29375@sigill.intra.peff.net>
In-Reply-To: <20190117160752.GA29375@sigill.intra.peff.net>
From:   =?UTF-8?Q?S=C3=A9rgio_Peixoto?= <sergio.peixoto@gmail.com>
Date:   Fri, 18 Jan 2019 09:41:03 +0000
Message-ID: <CAK3b1GJPZ5X3uEP1a-NF9PZkE0tTKVLda5hM32jExVz_OD2E=g@mail.gmail.com>
Subject: Re: Change on check-attr behavior
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a file  .git/info/attributes with contents

If the contents are:
[attr]allowed-ext
*.py allowed-ext=3D100

then the problem occurs.

If contents are:
#[attr]allowed-ext
*.py allowed-ext=3D100

the problem is gone

On Thu, Jan 17, 2019 at 4:07 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Jan 17, 2019 at 03:47:09PM +0000, S=C3=A9rgio Peixoto wrote:
>
> > I think there is a bug on the check-attr behavior of git when asking
> > for the "allowed-ext" attribute.  Check the logs below to see that
> > with version  2.20.1.windows.1 we get unspecified even the attribute
> > is there as you can see when asking for all the attributes.
> >
> > =3D=3D=3D OLD VERSION =3D=3D=3D
> > > git version
> > git version 2.8.1.windows.1
> >
> > > git check-attr -a test.py
> > test.py: text: set
> > test.py: allowed-ext: 100
> >
> > > git check-attr allowed-ext test.py
> > test.py: allowed-ext: 100
> >
> > =3D=3D=3D NEW VERSION =3D=3D=3D
> > > git --version
> > git version 2.20.1.windows.1
> >
> > > git check-attr -a test.py
> > test.py: text: set
> > test.py: allowed-ext: 100
> >
> > > git check-attr allowed-ext test.py
> > test.py: allowed-ext: unspecified
>
> I can't reproduce here (on Linux, but I don't think the attr code is
> particularly Windows-specific).  Can you show us what's in your
> .gitattributes file(s)?
>
> -Peff
