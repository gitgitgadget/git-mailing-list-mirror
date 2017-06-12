Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7FBA20D0C
	for <e@80x24.org>; Mon, 12 Jun 2017 17:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbdFLR2U (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 13:28:20 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33377 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752875AbdFLR2C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 13:28:02 -0400
Received: by mail-pg0-f41.google.com with SMTP id f185so47768791pgc.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 10:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5JbdVnn5kWhaX1g9JaAVqmHoKNvjj/Alst6St+tDkWc=;
        b=VZtvq6D0JGrRF/i+jDKR5/j4ZK3rcXJaGlIyXhPySh4JuFlBOZQx69VhHE1xasz0XO
         qTkzsL0WcBeMot9CR74OU4NgnMNA7bS6N6h3yc9O8GH/PAf+AWrozPnWx5wRh0/mSFig
         j/JDp7TRI/YU8ldImsLO3OFwsW/lvL0d3hr9LR+hZTZLSbKYHO3D4MNEGiJMGsWs0jfC
         m5NkUnM1BE3HsHPYmCGqGM6JmwWaP5o7M5OmW8gyTj/oIHzTopYpLAVSL2uL5bi6Ku8m
         jR3Oi8ekXBEs+4wMcfIvHCqX0/HGS+mF/PEG/PabN/RVNObVknB5oG9fSGc7iVweVCR2
         8YWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5JbdVnn5kWhaX1g9JaAVqmHoKNvjj/Alst6St+tDkWc=;
        b=ABt9JCy74j2OPn264bELU2B4ULOWi+5b+7sepS2BKa6ofC5RkWd155+8ITY/fKAh2R
         exiP35sIrW9XAWJK1HXG15r1zBUU+3AF7sQVlkjfAXLSKkoz8LifuqC7XwpqqKCD/JDm
         xaeVGql2tchlbYDBgCXYqHjZ2VoZI0MDvWXcV3x4MF6srVxGr7grRfH3F8WepA/aqdeb
         k+R901kID1ygxYHNSt0v6+TZ5InLwMTyOxC2kfnHlHHJjBkdtiVVcPQ/wiDC5tAURePR
         VxCr25euv9CKItkO5YvgBbo1+YuWpj+bDJpDK0e3Qb6Fxmzck+MLkxHT4lxURXa+2R+R
         kJ+g==
X-Gm-Message-State: AODbwcApSjW143io3lzaUVdpOE2M8vEVcpa4VVhGyN/r+6ApZE44gkvM
        dA/mw9z+LcfpNTCy6vJp+f4MAL9ST14R
X-Received: by 10.84.224.205 with SMTP id k13mr58462919pln.279.1497288476892;
 Mon, 12 Jun 2017 10:27:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 12 Jun 2017 10:27:56 -0700 (PDT)
In-Reply-To: <CAE5=+KUJr2=w3W=ZDTbd=L+8=KtwsV95Q7bcJassjzFncrnBKQ@mail.gmail.com>
References: <CAE5=+KX57KM+6n9NpePw9KYPXFy7UH-WRgSwaJDnvRofYFXm7Q@mail.gmail.com>
 <20170530181051.GA81679@aiede.mtv.corp.google.com> <CAE5=+KXPzY0QX+T26oUAHcV8HUYOCTrpuYN_Tb5cXxF71twmZQ@mail.gmail.com>
 <CAE5=+KUJr2=w3W=ZDTbd=L+8=KtwsV95Q7bcJassjzFncrnBKQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 12 Jun 2017 10:27:56 -0700
Message-ID: <CAGZ79ka=icZDS-6q2dGSxyeLxYw+Zd1M_DSWzmhmHYtbTQTvZw@mail.gmail.com>
Subject: Re: git push recurse.submodules behavior changed in 2.13
To:     John Shahid <jvshahid@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 10, 2017 at 6:28 AM, John Shahid <jvshahid@gmail.com> wrote:
> bump. it's been a while and I'm still not clear what the next steps
> are. I'm happy to send a patch but I would like to get a consensus
> first.

What do you want a consensus on?
(Is the change in 2.13 a bug or feature? I considered it enough
of a feature to not pursue an urgent bug fix. Maybe I misunderstood
the discussion)

This thread has diverged into lots of things that could be done. Jonathan
pointed out 3 possible ways forward. (1) and (3) are being worked on,
(2) is a new thing that nobody (not Brandon nor me) have on our radar
for what to work on next.  So maybe that is a good idea to get started
when you want to get into sending a patch?

Also I have the impression that there may be one corner case, in which
the handling of refspecs is missed, i.e. maybe we'd need a list (in the
man page eventually) on what currently happens when recursing in
combination with remote/refspecs or other options.
