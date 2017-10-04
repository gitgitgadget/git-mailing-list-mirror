Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8C6A20365
	for <e@80x24.org>; Wed,  4 Oct 2017 18:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbdJDSDv (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 14:03:51 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:49068 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdJDSDu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 14:03:50 -0400
Received: by mail-qt0-f180.google.com with SMTP id d13so20140657qta.5
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 11:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=z0xbiY7ZXUbo7VWon6w84MaLwdNW6RhIKFG4FZ3UkHA=;
        b=F0+qFQWzw6H5mqtsGTMnKvxw4yt0x1iYsxoXZ9ZFMOAyzxJQatmtoVHBiwY+muz9rB
         VEvQ5f0xMPrSuinnG6ef6D9N8/dwHaKfRpOJMTERX3hHiqmFVv6roKD1QuZmqqoT06Xd
         nVjwjkb6R8pejcHLkSINEVjbEe6r2pQ/hMeiHrjZYHwQp3zXF3WwvBCWKHcXxLKt3vuK
         Gt7ZYAOsstgsUaownoP9N+Ep3mCCYT6eLXDACXtNJr0aV32S2rriOfD5Y0DsJqFmhlWh
         fHNtzLCChqb6+mieLUS/s1rI37qSfs8M5nadO7LzZfd5Hv8oT+zMRX4ZudDWopu0mcJL
         bKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=z0xbiY7ZXUbo7VWon6w84MaLwdNW6RhIKFG4FZ3UkHA=;
        b=TW4Hs3CGSkN4Yk1yLS4gG7DqZd57naUs/D/yUgL7TXS6CTaVfLSQ6KI6K46qVNVpUw
         yCtApPk+0REOLOomBfpy0Q9XUhzB2K9PiZBSv3zYZAg9o0eYZ7jdv6aJqubu0jyLrnw0
         MpZRO+BKV20x7ZJrYbr0ceIQFc3tjtfEM/p/3uGDWBv2IuFSrVaUGJZwoVQe3E0RSNdj
         0gtnbWRijm61NdT2W0ZNvc2/qN96njSch26sJckfYYl0K9xDcLPUVxNyvkXWwXqbtmry
         YikhK+Gi0sh1x6U2NnkgaiEohncXJI5pyQ10hBUtbnzrrtGf7Q1d8hgdFXCbf+DDwTw7
         FyzQ==
X-Gm-Message-State: AHPjjUjzZ8pToMVcjd3piDZzRXRfzXTaTPVVlUC7JPl6L7WRL4OD5uDL
        bU0fzdE8Mj0i9ps/nxu5SNn4SdP/1E9PbckINDo=
X-Google-Smtp-Source: AOwi7QAnQDqNW80TYioMTxXen0Fi5SWUn30tqoKlj3RDSIGA4vOnjMPvXO+JCW9/ubmHYXLInbsTRlZ1K9EVlf2P6KA=
X-Received: by 10.129.32.4 with SMTP id g4mr18209803ywg.273.1507140229445;
 Wed, 04 Oct 2017 11:03:49 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.129.40.214 with HTTP; Wed, 4 Oct 2017 11:03:48 -0700 (PDT)
In-Reply-To: <20171004165947.GN19555@aiede.mtv.corp.google.com>
References: <CAHd499B5hM9ixnsnwWwB2uyDT10dRQpN473m5QjxH9raHtFXiw@mail.gmail.com>
 <958c9b03-062c-0bea-3b25-939a36659f32@web.de> <CAHd499AD5Kgbp-vxXTnEPkb-Mb5oEeXhaRO5kGniDdqmXwd2QQ@mail.gmail.com>
 <88c57b88-ef2c-d7db-15e2-12791d4cb201@web.de> <xmqq8tgrhdt0.fsf@gitster.mtv.corp.google.com>
 <CAHd499BCMOcur6NRbKfwd81zpnyzoiVCY54d=UmGpAhbD7AVTA@mail.gmail.com> <20171004165947.GN19555@aiede.mtv.corp.google.com>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 4 Oct 2017 13:03:48 -0500
X-Google-Sender-Auth: 6rrSkQlYV3IVntGLaaGrndHuTu0
Message-ID: <CAHd499DWbwBFxPUB6KFQ7+PbFQjdaRc6MwZRTj6dx+Wz9WHC6A@mail.gmail.com>
Subject: Re: Line ending normalization doesn't work as expected
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 4, 2017 at 11:59 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Robert,
>
> Robert Dailey wrote:
>
>> You guys are obviously worlds ahead of me on the internals of things,
>> but from my perspective I like to avoid the "plumbing" commands as
>> much as I can.
>
> I suspect what we are dancing around is the need for some command like
>
>         git checkout --renormalize .
>
> which would shorten the sequence to
>
>         git checkout --renormalize .
>         git status; # Show files that will be normalized
>         git commit; # Commit the result
>
> What do you think?  Would you be interested in writing a patch for it?
> ("No" is as always an acceptable answer.)

I wish I could, but ultimately I'd probably not be able to do it. I
rarely have time to do recreational coding outside of work these days.

That aside, for now I want to know the proper & recommended method to
renormalize line endings using existing commands. Additionally I also
am interested in knowing why only 1 of the 3 solutions I tried (In my
OP) worked but the others didn't. My short term goal is just to get
educated a bit. There's so much conflicting and variable information
on this topic on Google. It makes it difficult to find the one true
path, especially since Git evolves and improves over time and
information usually becomes stale.
