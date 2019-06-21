Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 350C61F461
	for <e@80x24.org>; Fri, 21 Jun 2019 21:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfFUVeK (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 17:34:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41103 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUVeK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 17:34:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id p15so11972967eds.8
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 14:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lpSrcmHHFGbG01uxJzANwVKFgL/U9PIK+SAl6K8uTEk=;
        b=o6I/VgcMcbVEgr5pnRYUhnRILfGrzMVcOsS0VO2PpdKUkpnFAHwfBnvnyAyGQAoIkU
         AUIWkU3bBFNy5yh+KbpAqBzfTIG1Pt+OSiGRrj184ZYZ72wfRI42UsjZJgGB4JoPGi4D
         klY2f8fil+CAW7hxGgS/8NlSC7xJ/KtxKuk9/tyNdKnx4P6wAJjYqWqLhtEZQxzu+toW
         ceTAhmwJytcxj1IRb6t+MPbPtdZKy8xJeUJBQv6XhYs/pFuIvQ91uFgOgcRq8yZH1EvY
         sF2nROo2ogOeQp6JtmljzuIEvvDlswbR5AYJK9LejYUsmFxMpvfX2jY94wnQd1D/RCRM
         QAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=lpSrcmHHFGbG01uxJzANwVKFgL/U9PIK+SAl6K8uTEk=;
        b=JN4+PMMhc6CZ5b1iN7O5gsqVhEM4Kde4fbv3U+L6gXfH2jxQR18XR8B9qjMrpBXxGf
         EZAPKkPzGMUwRT0NEdObIS5EmmpPzjVYaOHDgaAZfKc6HkqXyQjsCgE+2wvHZVl2MibW
         yBT7B47k+QlrsQaoQ67k6+zwnqj+9gibM2nw6v49mz3VzUiQrmih59lVCougQNu8ottu
         vIl46dXhd7lIyy1famrUelhT50e72Wdq2qTDwDJZMzNs2bnQhIAUHmCLyDMFllc/r0yl
         BoERsQgVvNoPqIbj/sOcg1uxFXWcuYp17+i0o9ANIRKh89T78mGYKVCC6WaOPiCzY1hJ
         GWdw==
X-Gm-Message-State: APjAAAXZ/g7eHuJWv2sZxTKkDARrlsGsLhIGT2wRHRzXuNlEZJcPXPvA
        2aD27EwTF/sysNiIcy1K23XLcM3Dqy8=
X-Google-Smtp-Source: APXvYqxkwRS3aumM/flQ2Of4v7tnoRB3Q+HE/DhWelG0U7v7RM0EccXKd+3NdqFz9kT13MPP7aKJQg==
X-Received: by 2002:a50:b962:: with SMTP id m89mr85790894ede.104.1561152848345;
        Fri, 21 Jun 2019 14:34:08 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id e10sm593139ejx.89.2019.06.21.14.34.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 14:34:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git <git@vger.kernel.org>, CB Bailey <cb@hashpling.org>
Subject: Re: Deadname rewriting
References: <CABURp0poUjSBTTFUXP8dAmJ=37qvpe64=o+t_+mHOiK9Cv+=kg@mail.gmail.com> <87sgsb8dmx.fsf@evledraar.gmail.com> <CABURp0p2Z=qD2gF59AHBLaRn9iiTOeJyNXYsQDNk-_KEC4uSGg@mail.gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <CABURp0p2Z=qD2gF59AHBLaRn9iiTOeJyNXYsQDNk-_KEC4uSGg@mail.gmail.com>
Date:   Fri, 21 Jun 2019 23:34:06 +0200
Message-ID: <877e9e8vxt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 21 2019, Phil Hord wrote:

> On Sat, Jun 15, 2019 at 1:19 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Sat, Jun 15 2019, Phil Hord wrote:
>>
>> > At $work we have a long time employee who has changed their name from
>> > Alice to Bob.  Bob doesn't want anyone to call him "Alice" anymore and
>> > is prone to be offended if they do.  This is called "deadnaming".
> ...
>> What should be done is to extend the .mailmap support to other
>> cases. I.e. make tools like blame, shortlog etc. show the equivalent of
>> %aN and %aE by default.
>
> It seems that shortlog and blame do use %aE and %aN by default.  Even
> log does.  It is only because I didn't know about %aN 10 years ago
> that my custom log format does not.
>
> It's a pity the format author has the option to ignore the mailmap. I
> think it's a choice commonly made by mistake rather than intention.  I
> wonder if anyone would mind a forced-override config.  Maybe a force
> flag in the .mailmap file itself.
>
>            <cto@company.xx>                       <cto@coompany.xx>
>            Other Author <other@author.xx>   nick2 <bugs@company.xx>
>            Alice Doe <alice.doe@myco.com>         <bob.doe@myco.co>  --fo=
rce

Yeah I'm sure a lot of people who do %an really mean %aN, but blanket
forcing it seems a recipe for breakage since "log" and friends are also
used as plumbing where you really mean "what does it say in this commit
object".

E.g. I use %an intentionally for a company-internal tool to map an Alice
to Bob for reporting purposes, which presumably you'd also want.

But yeah, there'll be other uses that didn't intend it. I think probably
the best way forward is to just make git use %aN by default in
porcelain, and outside users presumably would get reports about such
issues eventually in cases like this where someone cared.

>> This topic was discussed at the last git contributor summit (brought up
>> by CB Bailey) resulting in this patch, which I see didn't make it in &
>> needs to be resurrected again:
>> https://public-inbox.org/git/20181212171052.13415-1-cb@hashpling.org/
>
> Thanks for the link.
>
> I didn't know about config options for mailmap.file and log.mailmap
> before. These do make this option much more useful, especially when we
> can insert default settings for them into /etc/gitconfig across the
> company.

Right, and to the extent that we don't --use-mailmap by default I think
that's mainly because nobody's cared enough to advocate for it. I think
it would be a sensible default.
