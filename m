Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 228431F597
	for <e@80x24.org>; Sat,  4 Aug 2018 21:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbeHDXuv (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 19:50:51 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:41165 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbeHDXuv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 19:50:51 -0400
Received: by mail-lj1-f177.google.com with SMTP id y17-v6so7644242ljy.8
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 14:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=idZj/sJmZl7lfLiQ4Lz31GC4t4t6UuAxXxp75rIhCdc=;
        b=ai9L1eVIRdBpiz/LviUAPGVlRRSkJbzzWmFT9nM6bRoPwsh+Up14c0D3wDohJ5c6Fr
         OzOEt/zA4zqc7cgTsi/BM1T4FsSBfCv7hDU/UuFU5Ky3M2oGPY7hmvufbg56cv08yJF7
         SDS1fDOeFcPV5Pq7s8LG1HJ388G6QHWfPBfvOMuqOry/BPx0RmT7h1Z0AE3QphjxJ6Pg
         9X2YUPOI8SxA/QMHMOHpedBRiyxMvgnptwPGKLH2pFe6PO4fCKSaN8Po1/T8Sd45otho
         YZ2/QAeDIp/BVi7czeUsBHID2eVmjwme0m0SZJzQPn+pSZ0QZR+PRcwjcUKHXEQbIKGO
         pe1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=idZj/sJmZl7lfLiQ4Lz31GC4t4t6UuAxXxp75rIhCdc=;
        b=B2E9xrgTpHrajiYoMMWM31VzrPjOFq3z0i35SvQRISVCYVpc5tCvtVT/g97bTTv2lZ
         VtoWbyQ9B9czpKMyWgEMn7ozCvrIYLlLeHM5+BTvB0FlVP2kNCbncxAf7zfX/kSf/1eO
         y1iw04v/4DAuVqROeYhOYayX1Ny9U/y1UnJOmG5NV5YL1zv4NcjSDEGqJmY46p5Bv7gU
         i0g5DE+9SMnY8fSyCG4NcpOTGq5DBXp2BwZG3FS1jH4fJthZgxqZfrfz+XX+7YTA5JlE
         SSctlTEqFZM91fqKdrIW9hPOQ3XPZ5paNnEkqpkDt3rwy1LgsCTO+eWx1OUbnLaP61/S
         wV5Q==
X-Gm-Message-State: AOUpUlEfXLUmRX/vVXapQPX3JtBXEBzhOBiCxGXplIwQ+z5Cq1Pors0r
        4i5kanzH3aC6MPQcyIHcyTl/YfQi4tXbO1J6Vj+sga6g
X-Google-Smtp-Source: AAOMgpfgrSkbVVFnYUnjZhxMfkhAr0y5iWtJbv7o/4QKC2dmQaCpxgSEt0h4AErqpvQd0HoqJKPTBpRl8HPP+b9M7kE=
X-Received: by 2002:a2e:610a:: with SMTP id v10-v6mr8522040ljb.39.1533419325619;
 Sat, 04 Aug 2018 14:48:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:4057:0:0:0:0:0 with HTTP; Sat, 4 Aug 2018 14:48:45 -0700 (PDT)
In-Reply-To: <CA+KyZp4fxRfnPNozEtwgLPuFAnEsXCBPPubzNjv0wUMnBV_eww@mail.gmail.com>
References: <CA+KyZp4fxRfnPNozEtwgLPuFAnEsXCBPPubzNjv0wUMnBV_eww@mail.gmail.com>
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Sat, 4 Aug 2018 14:48:45 -0700
Message-ID: <CA+KyZp43YGf1qLDHOtrfjJxREcaVQNN12iMLDL5qX=RXhmMCYQ@mail.gmail.com>
Subject: Re: concurrent access to multiple local git repos is error prone
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note, in my first paragraph, I should have said "If I have multiple
local git repos, and I run `git status -v` on them *concurrently*"...

-alex

On Sat, Aug 4, 2018 at 2:47 PM, Alexander Mills
<alexander.d.mills@gmail.com> wrote:
> If I have multiple local git repos, and I run `git status -v` on them,
> sometimes I don't get any stdout for the command. This is highly
> reproducible.
>
> I assume that access more than 1 git repo concurrently on a local
> machine is not without errors. However this seems like a huge
> limitation or design flaw.
>
> Is my observation correct? Are there any plans to remove this limitation?
>
> My use case - I create a lot of developer tools and more than once I
> have hit this limitation...I have to create a queue with concurrency
> of 1 to run commands on git repos. It's very strange and
> counterintuitive to have to do this.
>
>
> --
> Alexander D. Mills
> =C2=A1=C2=A1=C2=A1 New cell phone number: (415)730-1805 !!!
> alexander.d.mills@gmail.com
>
> www.linkedin.com/pub/alexander-mills/b/7a5/418/



--=20
Alexander D. Mills
=C2=A1=C2=A1=C2=A1 New cell phone number: (415)730-1805 !!!
alexander.d.mills@gmail.com

www.linkedin.com/pub/alexander-mills/b/7a5/418/
