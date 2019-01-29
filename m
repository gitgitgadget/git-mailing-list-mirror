Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A18C2211B5
	for <e@80x24.org>; Tue, 29 Jan 2019 10:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfA2Kvn (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 05:51:43 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:43498 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfA2Kvn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 05:51:43 -0500
Received: by mail-ed1-f41.google.com with SMTP id f9so15559547eds.10
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 02:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mOel0DINcINFD69eeDGcwwVMb2MPAVjK70DxFAqipVE=;
        b=HVoTGfafjuZq209dlqzKB6RdMxv8fztlCVrcGmIrOqeT5U7VbCciiRSRtYZ+wnc0Co
         Jou4ByGnGmUMuGkNwHej62jeid7e2Fu3nra4pz09389sDrrUibFoEvsMP5ngsBkvXZEP
         kqAB+0viWbjwbZZco5OcWal+/TLFq4nqie64+cfYd87Q7PwlRs2e4xp9VnU+zfqYauEb
         4XNLDr03uVpQcedJ1Ve83qaxnPZ4IXt4NJtWhvkxWoczLztkiz6925Q8rAkJUSSlwQ9z
         4dSsO6jjbrtkmVMoOFJZUyhbLzaMvRY+LZWRL+dkit/iCmTmTunGPFWJwMxwSIaKBGe6
         ralg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mOel0DINcINFD69eeDGcwwVMb2MPAVjK70DxFAqipVE=;
        b=hJLbLuyL4oslxbY/QrAHk+dIFujLOKTbEHHIMCczu+prJqGUXXGnwz2J5ewHLyLm+c
         yISLsRqe9ag0lfYec/cafAHKMTvvIR35le7XArZZD1V4wctuaafnMgUVoB/NRBaLOirf
         kWCDb0NYQNLXymLpAAcoZiWf2Qs07yX4YStcMEZtvearlOPkpg3ihd9yPE9ra2pm+T6r
         Atb41Sg+k7pdyNbjiYKODHB7D5brITHs2r1L6X7IjcWf0hhsLxs928ZNeEpp+8s5ETqv
         otkCBHzsd75MHhJX1gwGau8yG0OyVQL1TP7tn4fkMGJckUcZufCgCMNa2RQ1Y/cRMpc3
         e+Kg==
X-Gm-Message-State: AJcUukedQGVoAAEhtngkG0e7v9/Rly6+Vwja3vHhEXfE/b6RvFO+3tdB
        gU4agf0yFBQfzNLYcLT20MZ5Qt2pqVfx8I7N+OJfQ+V2
X-Google-Smtp-Source: ALg8bN6dxDCbBHBa66wTfSKeeGpExBeeCdBOK3XEmyNDdZXwwtD9Yp8gNVWE6qAjIad3IV7D7Pv+Aeu8oKIe4dvDz7c=
X-Received: by 2002:a50:b0e5:: with SMTP id j92mr23660624edd.188.1548759101288;
 Tue, 29 Jan 2019 02:51:41 -0800 (PST)
MIME-Version: 1.0
References: <CAHMHMxWpqTDyCQPXPY6WPeMBHFzYGE=Z0Q8pSL=9TecwuP9fwg@mail.gmail.com>
In-Reply-To: <CAHMHMxWpqTDyCQPXPY6WPeMBHFzYGE=Z0Q8pSL=9TecwuP9fwg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 29 Jan 2019 11:51:29 +0100
Message-ID: <CAP8UFD0eQ0hPkd-wsNR8e0hQSJC+dUQatvV1xgdJOUxtXYqC_g@mail.gmail.com>
Subject: Re: No clear API/Error message to validate a "revision object" using
 git rev-parse
To:     =?UTF-8?B?zp3PhM6tzr3PhM6/z4IgzqPPhM6xz43Pgc6/z4I=?= 
        <stdedos@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Jan 29, 2019 at 10:30 AM =CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82=
 =CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82 <stdedos@gmail.com> wrote:

> So, I follow the recommendation to add '--', since I know that I won't
> be adding any paths:
>
> $ git rev-parse version.3 --
> fatal: bad revision 'version.3'
>
> However, what happens with the correct tags is, I get the trailing
> double dash in:
> $  git rev-parse version-0.false --
> d43292476ea9ab8c3d32940352b680549b64e8d8
> --
> $

Yeah, it looks like a bug to me.

> A further leading argument, e.g. '' makes the situation worse:
> $ git rev-parse version-0.false -- ''
> d43292476ea9ab8c3d32940352b680549b64e8d8
> --
>
> $

This also.

> `--verify`s error message is even more cryptic:
> $ git rev-parse --verify version.3
> fatal: Needed a single revision

Yeah, but it works.

The error message could perhaps be improved. On the other hand it has
been the same for a very very long time and very few people complained
about it.

As you are writing a script, you can at least easily redirect it to
/dev/null and output something else.

In fact as `git rev-parse` is a "plumbing command" it's supposed to be
used mostly by scripts and power user who can easily deal with such an
error message, which explains why there has not been much incentive to
change this error message.

> $ git rev-parse --verify version-0.false
> 80f20b100cca5166b22cbcc1f4a6ac1eae64a0d0

This also works correctly.

And:

$ git rev-parse --verify v2.2.0 --
74d2a8cf12bf102a8cedaf66736503bb3fe88dfb
$

also works correctly.

Best,
Christian.
