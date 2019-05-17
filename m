Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 254A11F461
	for <e@80x24.org>; Fri, 17 May 2019 12:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfEQMUL (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 08:20:11 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39059 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbfEQMUL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 08:20:11 -0400
Received: by mail-yw1-f67.google.com with SMTP id w21so2668145ywd.6
        for <git@vger.kernel.org>; Fri, 17 May 2019 05:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IVHJHpvwQTEscZocR5TNDmgyQHBs0bcxM7ej6gxhhvc=;
        b=awMqGBayoEIKDUc0RCPkQjGqnfnUMiZr63IdksXtb/51ySe98yxFzIAE3A7G2stZaz
         3prm4wLeLvVnBDjd59p5tZGaEoOF8Vt8EedtKiag1wWb19HHJItL8/w2/YB6lnpUyCos
         xJW4p9gTVIbBDZNkqDgN93C3G1KU64A5auzvQKpkAUkkkCNAqW3EF4KdymkfRHgAyTGk
         K7iXwNisA4T2mvr4kJfAE+1odeJnjok4x5YdppEbn2jFgvTYAG6jLN5BFrvivDH5PoQn
         mNpkpcseIBJbAB4ivDFSvKvfl9pE8C/ZpslkrneGjPB7vTZ7H6lHTc0fwOqiOsInz1d9
         j0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVHJHpvwQTEscZocR5TNDmgyQHBs0bcxM7ej6gxhhvc=;
        b=WR1qtMa1zvyE6qOoWOt//J7G7uDR5JfywK9iNoPTYINv2Uu3EVC/Qv1+4ENboBF0fC
         GLsS3gNiTcyGwKonhMkLac7zSdqr1iKLgIZnJGYQeINd2ri0SfVD/QFs0/UhlynKKRXI
         MkUr2BVMcKu4aW1QgT/bCt0PEIPLLIdvmSdAVEyP6Ug+fAAooMIDctbIAxddQBZi26jk
         DQJmRGo206azbYySg2D0eEI4vtEyZ696M5b1U3Dw97mWdsumc0ik8oXv1OTYT9Mp+bE2
         unxnBmLrv28PFMq/nw9gEj8Gd4+d27n55mgyAeIfXmUhDnccogzwnTQF7+nlE+EBexkO
         rSSw==
X-Gm-Message-State: APjAAAX5U59hDoK5r+d5UFLEqrMVUvSrlPcLHYNeIRFFYSNYBYJKP68W
        8puojmR+z5CPtazIXADJgRTFGPLDP67lk1pJsAKUtw==
X-Google-Smtp-Source: APXvYqxBpaN5VzDYyVTCqo/rC9ltcpORRlCXNL/o8ybngQPzpI6DMOcE09H2U6pDpCT1eGsN/K+6semoUdxcZVUCP+s=
X-Received: by 2002:a81:d82:: with SMTP id 124mr1013924ywn.5.1558095610426;
 Fri, 17 May 2019 05:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <CALM0=-mTLakSBW67vqHNX84p=uw990QDbpeUfh1HKq9N0CiiLA@mail.gmail.com>
 <20190511041331.51642-1-liboxuan@connect.hku.hk> <aa86f483-9c73-eb6d-1a73-80fd4894c093@kdbg.org>
 <CALM0=-n_=8K4RWE9MvwPFT26UwN-rAA09ryqdTfEF4GJ57YBjg@mail.gmail.com>
 <a2455214-9ce5-71e3-74bc-114af6fcfca7@kdbg.org> <xmqqlfz64uzw.fsf@gitster-ct.c.googlers.com>
 <262eb1d4-a898-c6d0-8e04-ce6c58eaa4e6@kdbg.org> <xmqq8sv63rfc.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8sv63rfc.fsf@gitster-ct.c.googlers.com>
From:   "LI, BO XUAN" <liboxuan@connect.hku.hk>
Date:   Fri, 17 May 2019 20:19:34 +0800
Message-ID: <CALM0=-=2PBLm6+pQxUq5L2=8hEUh3nFFheFN=HhN5CUGj6Kfeg@mail.gmail.com>
Subject: Re: [PATCH v3] userdiff.c & doc/gitattributes.txt: add Octave
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        philipoakley@iee.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 17, 2019 at 7:34 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Sixt <j6t@kdbg.org> writes:
>
> > I'd prefer to keep this list at the minimum necessary as long as it is
> > hard-coded in C.
>
> Yeah, I know that feeling.
>

So do we reach a consensus? Should I merge the Octave rules into Matlab rules?

Best regards,
Boxuan

> > I would take a different stance if this were some
> > configuration file that we ship.
>
> Hmm, now you reminded me of my ancient wish.
>
> Perhaps it is not too bad to ship $(sharedir)/git-core/userdiff that
> can be read using git_config_from_file() interface, using a very
> narrow callback function that understands only diff.*.xfuncname and
> diff.*.wordregex and discards everything else, without even
> following the include/includeIf stuff?  As long as that can be done
> safely and without too much overhead, we could get rid of the
> hardcoded patterns in userdiff.c::builtin_drivers[] and that would
> be wonderful ;-)
>
