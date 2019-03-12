Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 565A320248
	for <e@80x24.org>; Tue, 12 Mar 2019 09:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfCLJId (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 05:08:33 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:55929 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfCLJIc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 05:08:32 -0400
Received: by mail-wm1-f54.google.com with SMTP id 4so1724993wmf.5
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 02:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=h/VOm/phqmS84ROmQw4G97mVKh81s6lEzXj120qmDX8=;
        b=skFfVQfAH6yEYd05u8Ws0FHP9MpuYsHnGTHo4oV0y1tfrE7GZ4vLteRWuw3gmsOmg2
         kNkLz5MPoZ5b0nhr5Onf0Y/lx7LPYYTNSSyoTovcdtqZp8HkQ5RIELqBbzk8rb1VyKPR
         ESyNz4INKKUB+jlfrsf/900mN8B8W4BEhPmNimtQlWKlW417xoN1Zb/C6rscD2CUGHP6
         Bo6kdDMUpcspGjTnuQcyzYy+L42QXWrghoSEmABQHHkBNKV8/0bdm1oJkZ5TtupB6G8B
         pR1w1VDcSbFO3WE6ZXSqwvt3oSQu3FtmMkrGMO6G3VqWUgzkZo5Gbv/J81O7KHfWUYvt
         XKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=h/VOm/phqmS84ROmQw4G97mVKh81s6lEzXj120qmDX8=;
        b=EAqnS8dz5G8dNtonF4UZa9ut+e33j9Urtc1CI/8Ud/qyr4fMOk2bX2cwqF74IoDf8h
         ahrZQ4rYCUjLzsOApO9rC3JptThLTs+1Pjiz240aUIh+4lRzBLT/X33UCqUF0Vlu7dm4
         BeU5lb0n2kfy+qsTzxGBBtK6y1/TCZt+jSoiLLlcTpgJeOm9DyIKkxW/AftKMFmaps/6
         mJ5/hLJHg6twR+kyXeXV7O20CWXgHBv3iCUS8CJcIY/RhUInXBvBT+t7cGA1HctFS4Bj
         PJziAhHPULonAyOcBkkwRTkaedNy3u38nmVmK9uSyFSExAuqTKl1o2nZi6N6gDBehkAw
         KzBg==
X-Gm-Message-State: APjAAAXEcnN06r8FRT9DnRBypvwxKQsErphpr5yMX6fKJnzdgjqWh8+u
        2OBDIH25Lpbpf5c9/NaGnbvgKRy2
X-Google-Smtp-Source: APXvYqxyIUY/voSZ2bNiFQS+Z0vv5ZUHp61qnTQWZyE9MbW8wlLZV54sMfm1rxxwn2GCxFzwJT0KfQ==
X-Received: by 2002:a1c:f20e:: with SMTP id s14mr1626551wmc.69.1552381710792;
        Tue, 12 Mar 2019 02:08:30 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id o5sm1399016wmh.12.2019.03.12.02.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 02:08:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeffrey Walton <noloader@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: Solaris and sed: Too many commands, last: s/\n//
References: <CAH8yC8nnFYt0raL+twrG_v8XZn_FDJWyM=tH=QL13Z70_bHRiQ@mail.gmail.com> <CAPig+cTCOfDCv=L3EWUqgVZx1VCdqt5ZjmSQMwHLX=R4C4hgTA@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAPig+cTCOfDCv=L3EWUqgVZx1VCdqt5ZjmSQMwHLX=R4C4hgTA@mail.gmail.com>
Date:   Tue, 12 Mar 2019 10:08:29 +0100
Message-ID: <87zhq0bgtu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 11 2019, Eric Sunshine wrote:

> [cc:+=C3=86var]
>
> On Mon, Mar 11, 2019 at 4:32 PM Jeffrey Walton <noloader@gmail.com> wrote:
>> I enabled self tests for Solaris. Solaris has some anemic utilities so
>> I put /usr/gnu/bin first on-path.
>
> The first question is if you are really running GNU 'sed'? My guess is
> "no, it's still picking up Solaris's 'sed'".
>
>> gmake -C templates  SHELL_PATH=3D'/bin/bash' PERL_PATH=3D'/usr/bin/perl'
>> sed: Too many commands, last: s/\n//
>> --- chainlint/arithmetic-expansion.expect       2019-02-24
>
> =C3=86var had taken a stab at getting this to work on Solaris back in
> September 2018. He did fix one or two issues, but the one you report
> here was not addressed. He ultimately abandoned the attempt, I think,
> after Junio's reminder that the project had long ago declared
> Solaris's tools as a lost cause. See the relevant messages:
>
> http://public-inbox.org/git/87bm9cs5y6.fsf@evledraar.gmail.com/
> http://public-inbox.org/git/CAPig+cRrwW662Hzp8V1sH51x8qYxPyqG=3DVHpOkfd-=
=3DRwUSSZbw@mail.gmail.com
> http://public-inbox.org/git/877ek0rymz.fsf@evledraar.gmail.com
> http://public-inbox.org/git/xmqqzhwv51wy.fsf@gitster-ct.c.googlers.com
>
>> Solaris in a VM sucks. I can provide SSH access to the hardware if
>> anyone is interested. It is just an Solaris i86pc on an older Ivy
>> Bridge.
>
> I wouldn't mind taking a look at it, though I don't promise anything,
> and I suspect the only way forward is by ensuring that the GNU or XPG
> tools are used instead of the Solaris ones.

FWIW I gave up on Solaris sed after trying to fix it the last time
around.

If you need another box to test it on you can apply for a GCC Farm
account: https://cfarm.tetaneutral.net/machines/list/
