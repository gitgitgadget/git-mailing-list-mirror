Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D33B1FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 00:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752341AbdFHAH6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 20:07:58 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:35968 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbdFHAHk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 20:07:40 -0400
Received: by mail-io0-f177.google.com with SMTP id y77so13817427ioe.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 17:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zBtnwoh9aMB7GpD5OBGJDc7ZsPyz0NlT2xcUzZ/Zp2s=;
        b=SnFlSXMY4umNnrr5hXJT9numRZGdqOwON+d8BNuaTr0RPs1b126inKg2DAoIGeL1Br
         K+gDVmSDUuvgXAHSkSbUHJfut2MCiUrpfhN+DnYa1jtcRGHKPHkTx3mBXgj6+nvY7fHl
         WDVezt+AlEBdcGoJC1nYdDj/XqVXEICEGohmBA5T4A4pimmW12bkVOxLAU9Coq9hKtoQ
         0UfkBg3oghvN61SRBh97dKiSERWg2LatlYkOUmgh0OqCoTlpPhX62CLNfPPRqNxkGx39
         6lp0ChubPk4v6V8oOUf/PyRxhXREZcn8HoBaAf+GeiZBfmnh50S47CYrmigzsPBJfKHe
         11aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zBtnwoh9aMB7GpD5OBGJDc7ZsPyz0NlT2xcUzZ/Zp2s=;
        b=T61l1TZ+RVeC0Z/7zbqVr7CGzwDcNPjgVZpemUxJixjFybZERjMrKmsYGqyOq3+SMP
         PlUzMg8YBs2y2CcwKvtSzldFxt9kK23ovNxQwqzfG93q8iOb5yhGHsVVjqyN9RCi13Oz
         /snFJDFVf1VFgVpe352XX3SRv8d4gLmScFM3cOuDC17ojEaX9tWGLUPvEknxHZ22pCLH
         wqZ9C0e5v3PFBP5tHBOqOBZnYh2/hUXhDOlI1ghs1JddplK6lH2RB/hIrKF4Pd0v4Cad
         pwMAkF2nrSJufXiEdKvoE9WBpSRvtlxYY3MlTZxSleuqVZ0JI7+n/Jt1s2UcX7MvHSgw
         ou/Q==
X-Gm-Message-State: AKS2vOz/qdq3/5dqHiaLnyPXEHYQCq7BcKnYOYzQMYkN7le+kJlr4aE/
        RIRoQb9491Ar7XJoepEgjHED0FZIWw==
X-Received: by 10.107.195.75 with SMTP id t72mr10432412iof.17.1496880459606;
 Wed, 07 Jun 2017 17:07:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.72.66 with HTTP; Wed, 7 Jun 2017 17:06:59 -0700 (PDT)
In-Reply-To: <CACBZZX5Zdn5XpjsWchww+LxyqN+Y=BqrGJ6wrXUW3PnRcsw-fQ@mail.gmail.com>
References: <CAKvHMgTBmdKrz-i9-uBFtx08pegjuY2=jKQE21pi=MabTuicrw@mail.gmail.com>
 <CAKvHMgSgOyDhffPm=-QEQNzoCoPtmWbV_R7JDtBFTHQ-sL3Wug@mail.gmail.com>
 <CACBZZX6AKYA5PmE6Le4cxCTCOOix1ErHyT21C=L83CQBYaN=RQ@mail.gmail.com>
 <CAKvHMgRpS3AgRAm1ukH18kX5jNF6PEU8YTsq7mQ36myQgRe=Pw@mail.gmail.com>
 <CACBZZX5dwUq58nghuMqnuGfe9sPm1VBxVwZGZcTCYgeO5OdyTg@mail.gmail.com>
 <CAKvHMgQB7fR+2O4AUYNn0JF13fxf3m-gJ70yPUEdqRkyfC-q+w@mail.gmail.com> <CACBZZX5Zdn5XpjsWchww+LxyqN+Y=BqrGJ6wrXUW3PnRcsw-fQ@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Wed, 7 Jun 2017 20:06:59 -0400
Message-ID: <CAJZjrdUSVeZ-zHpeyuN4p29Hg8eGk6ip2Tikkrh-wE-KaxWbEw@mail.gmail.com>
Subject: Re: send-email: Net::SMTP::SSL failure
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Liam Breck <liam@networkimprov.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 7, 2017 at 4:43 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Ah, so you installed Net::SSLeay via CPAN, and then upgraded your Arch
> openssl, breaking the CPAN-built *.so object?
>
>> Agreed that send-email should be report errors properly. It's a rather
>> essential tool.
>
> Indeed, do you get a meaningful error if you apply my patch?

FWIW I'm on Arch as well and am getting what I assume is a related error:

SSLeay.c: loadable library and perl binaries are mismatched (got
handshake key 0xdb80080, needed 0xde00080)

The last patch I sent out was on 5/23, and I just ran a system upgrade
today (only one I've done since then), which presumably is what
"broke" send-email. I used CPAN to install Net::SMTP::SSL,
Mime::Base64, and Authen::SASL; I assume that Net::SSLeay is installed
as a dependency of one of the three (presumably the first)?

I know Net::SSLeay isn't controlled by Arch's package manager:

$ perldoc -l Net::SSLeay
/usr/lib/perl5/site_perl/Net/SSLeay.pod
$ pacman -Qo /usr/lib/perl5/site_perl/Net/SSLeay.pod
error: No package owns /usr/lib/perl5/site_perl/Net/SSLeay.pod

=C3=86var's patch unfortunately does not fix or change anything for me.

Liam: when you say "uninstall" /usr/{lib,share}/perl5/site_perl/*, do
you just mean rm -rf?
