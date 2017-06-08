Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAB051FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 00:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbdFHA01 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 20:26:27 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:36356 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751481AbdFHA0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 20:26:25 -0400
Received: by mail-io0-f177.google.com with SMTP id y77so13935821ioe.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 17:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=204nZLZSv94l4T3dGmggsadtnYQWfdTM7ZQ16+CXwOI=;
        b=XQavUSa4EdXfEoiDSS0MQVdzd5EgWUmqqSmZBngaKV6WGaWUebxs8ql1wnoKHwLi6F
         h5s7/ZSFZR1AMFZekjajM+HEHtkHMLEmBrrAv16VVuT9jDr/QbfhZqmkIqo6s55zN0tC
         AmrUM0+/JTuYoIUlTTklyx1J8pNSWZir15L+wE1eKcr4slblP7WJ0JgD0JSg5ibhfTEV
         lMxuVnLOMYpiU4MhNbxxnqFKkg9PIGt/VCD1/xqXNCUCnJNnNmJ3QE3T/V32ejfnCuRC
         7M6HAcsrOMlz28TSFAFTpdNdgn6S5oO3zz1JOEN8vo5kuGBnV8Lmu4XtN8ocIgc2SfDc
         8ElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=204nZLZSv94l4T3dGmggsadtnYQWfdTM7ZQ16+CXwOI=;
        b=gNR+JD1wGuqZUzWcOh70YK2EZIyLnEo4Px0ugiOAkmV9Jd/3I5qljFloRsR+Thixvi
         1TxzSZFqofKLtqYIXaEALr0cMF2XcXQH5B5tT6bFuSjhC10+EutOYpKuQVJYvtttJkWa
         CPQdANNTyHHLdO0HLMhYk3xfnHmdQ7W52mhyjdLa6icHGe8Il7/2jpZuHCy5kNCjs+ot
         s/9VtKgx9uDu4xnJ/Ha1oZVmvpp65X3jwEuyo1mUe4YiFme+SEiyoUYZnBPri0m+F4+z
         4+J35A0Q3opzr9yTYO/mm55g80M6iy6NC78KheuxwMSiyO/oe9iS17nqvF9Vlo0FvzHA
         V5Hg==
X-Gm-Message-State: AODbwcCLkuA3jgQA5lBGb6/BK8y9joOzC6LzLLvUQj2GP+Ya33dpcpJ/
        pT2cXRSKZnkKi0yl3JbyoLwz2uSnoHLzJeIe/w==
X-Received: by 10.107.160.143 with SMTP id j137mr40059085ioe.20.1496881584741;
 Wed, 07 Jun 2017 17:26:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.135.7 with HTTP; Wed, 7 Jun 2017 17:26:24 -0700 (PDT)
In-Reply-To: <CAJZjrdUSVeZ-zHpeyuN4p29Hg8eGk6ip2Tikkrh-wE-KaxWbEw@mail.gmail.com>
References: <CAKvHMgTBmdKrz-i9-uBFtx08pegjuY2=jKQE21pi=MabTuicrw@mail.gmail.com>
 <CAKvHMgSgOyDhffPm=-QEQNzoCoPtmWbV_R7JDtBFTHQ-sL3Wug@mail.gmail.com>
 <CACBZZX6AKYA5PmE6Le4cxCTCOOix1ErHyT21C=L83CQBYaN=RQ@mail.gmail.com>
 <CAKvHMgRpS3AgRAm1ukH18kX5jNF6PEU8YTsq7mQ36myQgRe=Pw@mail.gmail.com>
 <CACBZZX5dwUq58nghuMqnuGfe9sPm1VBxVwZGZcTCYgeO5OdyTg@mail.gmail.com>
 <CAKvHMgQB7fR+2O4AUYNn0JF13fxf3m-gJ70yPUEdqRkyfC-q+w@mail.gmail.com>
 <CACBZZX5Zdn5XpjsWchww+LxyqN+Y=BqrGJ6wrXUW3PnRcsw-fQ@mail.gmail.com> <CAJZjrdUSVeZ-zHpeyuN4p29Hg8eGk6ip2Tikkrh-wE-KaxWbEw@mail.gmail.com>
From:   Liam Breck <liam@networkimprov.net>
Date:   Wed, 7 Jun 2017 17:26:24 -0700
X-Google-Sender-Auth: OwwMb5GrEHU27ri7m8qrKecvuno
Message-ID: <CAKvHMgRcpEt1a-nZMw_Z7iZ8Bc2ChQNbUo3yQgtT8+stQLD11Q@mail.gmail.com>
Subject: Re: send-email: Net::SMTP::SSL failure
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 7, 2017 at 5:06 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
> On Wed, Jun 7, 2017 at 4:43 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> Ah, so you installed Net::SSLeay via CPAN, and then upgraded your Arch
>> openssl, breaking the CPAN-built *.so object?
>>
>>> Agreed that send-email should be report errors properly. It's a rather
>>> essential tool.
>>
>> Indeed, do you get a meaningful error if you apply my patch?
>
> FWIW I'm on Arch as well and am getting what I assume is a related error:
>
> SSLeay.c: loadable library and perl binaries are mismatched (got
> handshake key 0xdb80080, needed 0xde00080)
>
> The last patch I sent out was on 5/23, and I just ran a system upgrade
> today (only one I've done since then), which presumably is what
> "broke" send-email. I used CPAN to install Net::SMTP::SSL,
> Mime::Base64, and Authen::SASL; I assume that Net::SSLeay is installed
> as a dependency of one of the three (presumably the first)?
>
> I know Net::SSLeay isn't controlled by Arch's package manager:
>
> $ perldoc -l Net::SSLeay
> /usr/lib/perl5/site_perl/Net/SSLeay.pod
> $ pacman -Qo /usr/lib/perl5/site_perl/Net/SSLeay.pod
> error: No package owns /usr/lib/perl5/site_perl/Net/SSLeay.pod
>
> =C3=86var's patch unfortunately does not fix or change anything for me.

Right because it attempts to log a diff issue.

> Liam: when you say "uninstall" /usr/{lib,share}/perl5/site_perl/*, do
> you just mean rm -rf?

You need these new arch packages:
perl-mime-tools perl-net-smtp-ssl perl-authen-sasl

To uninstall the cpan stuff I did this in case I need to put anything back

mkdir -p siteperl_uninstall/{lib,share}
sudo mv /usr/share/perl5/site_perl/*  siteperl_uninstall/share/
sudo mv /usr/lib/perl5/site_perl/*  siteperl_uninstall/lib/

You could comment on this issue here
https://bugs.archlinux.org/task/54334

.
