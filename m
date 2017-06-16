Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBA8F20401
	for <e@80x24.org>; Fri, 16 Jun 2017 06:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbdFPGZ4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 02:25:56 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34916 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbdFPGZy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 02:25:54 -0400
Received: by mail-wm0-f52.google.com with SMTP id x70so16821405wme.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 23:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QUvtDS79nIF29Ja8H7OFfb1EpjZd0guP8RmVX1+R1oQ=;
        b=dTfYE8OxC+Yvb/+vPZeTzlBX8CtORgDf6pfMPSxcx933IhDP5oDIg74Pmadu2PzS7N
         DLpZNpvQZ6tXLy26wq7AlGF9Fy14odSi1qWQTNxK9AiYjquGBmO/VrvELQvUiXhlPbFN
         By6PWIBs7GDoaPvchXEhIUYmhHYGPeU3WfpN7LJhQwqV3+3rA8rPV8OhGGBdauv0ZUhJ
         AZRyBcBTufIknzO4Bn27jg/aCurY+IK+0zt/h1dUQMGGd0kAyD501BAR6Yi+7ksOEyS+
         m95ibyd+yC6ueSgl1XJfNcl2o9vlwQHDDOaGvoV3DfpUXo7CkxWlIsS3254ed3hdPCqQ
         E8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=QUvtDS79nIF29Ja8H7OFfb1EpjZd0guP8RmVX1+R1oQ=;
        b=eZMLXpea96tqUKxFVof/Y2nzvF3ykt2VYeAuDpMRDNKxgbmFF6m5Hm1J7EoeKGUom3
         L7z8GQk6zeHzZy+vfjX4Z/NfsFoSupmY+Wm5ZzQhT6YvBp6fP16DUkb8wyWfmesWyOba
         dvwTvO9Ztqmst45XgfXOgLWqmC/KU70TIpbB8hqD+uT6jZpWlaKQoOi4cZCFqzaY7tTy
         oZSty32xzdtEeu04nUnxYBdXYi1/3SlptLP9xQzbZREpzq08hkPG7PGmlYSWXuNQuSnJ
         YkKcnyWvs+UkBsvAvZPsFrtP21d9Tm17PT+96LsOjsDNUbH4xJ8xY8DC0hOSC8Oe4sZT
         dYRg==
X-Gm-Message-State: AKS2vOwRZB2v7BqpwV5O1rJvSWJLDer/nCwvdtrwa4azFC3/e/qX9JCG
        9MmmNnlPG704dw==
X-Received: by 10.28.63.144 with SMTP id m138mr6196409wma.10.1497594352776;
        Thu, 15 Jun 2017 23:25:52 -0700 (PDT)
Received: from snth ([92.109.130.42])
        by smtp.gmail.com with ESMTPSA id e131sm1076253wmd.28.2017.06.15.23.25.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 23:25:51 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dLkha-0006bW-GY; Fri, 16 Jun 2017 08:25:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Adam Langley <agl@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio Hamano <gitster@pobox.com>
Subject: Re: Which hash function to use, was Re: RFC: Another proposed hash function transition plan
References: <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net> <20170306182423.GB183239@google.com> <alpine.DEB.2.21.1.1706151122180.4200@virtualbox> <20170615110518.ordr43idf2jluips@glandium.org> <20170615130145.stwbtict7q6oel7e@sigill.intra.peff.net> <87shj1ciy8.fsf@gmail.com> <alpine.DEB.2.21.1.1706152123060.4200@virtualbox> <CAL9PXLzhPyE+geUdcLmd=pidT5P8eFEBbSgX_dS88knz2q_LSw@mail.gmail.com> <20170615224110.kvrjs3lmwxcoqfaw@genre.crustytoothpaste.net> <CACBZZX5Z3kQHe_5TgOeuJSgzuvpQdaLo6RrgX_EvuZfdz856sA@mail.gmail.com> <20170616001738.affg4qby7y7yahos@genre.crustytoothpaste.net>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20170616001738.affg4qby7y7yahos@genre.crustytoothpaste.net>
Date:   Fri, 16 Jun 2017 08:25:50 +0200
Message-ID: <87y3ss8n4h.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 16 2017, brian m. carlson jotted:

> On Fri, Jun 16, 2017 at 01:36:13AM +0200, Ævar Arnfjörð Bjarmason wrote:
>> On Fri, Jun 16, 2017 at 12:41 AM, brian m. carlson
>> <sandals@crustytoothpaste.net> wrote:
>> > SHA-256 acceleration exists for some existing Intel platforms already.
>> > However, they're not practically present on anything but servers at the
>> > moment, and so I don't think the acceleration of SHA-256 is a
>> > something we should consider.
>>
>> Whatever next-gen hash Git ends up with is going to be in use for
>> decades, so what hardware acceleration exists in consumer products
>> right now is practically irrelevant, but what acceleration is likely
>> to exist for the lifetime of the hash existing *is* relevant.
>
> The life of MD5 was about 23 years (introduction to first document
> collision).  SHA-1 had about 22.  Decades, yes, but just barely.  SHA-2
> was introduced in 2001, and by the same estimate, we're a little over
> halfway through its life.

I'm talking about the lifetime of SHA-1 or $newhash's use in Git. As our
continued use of SHA-1 demonstrates the window of practical hash
function use extends well beyond the window from introduction to
published breakage.

It's also telling that SHA-1, which any cryptographer would have waived
you off from since around 2011, is just getting widely deployed HW
acceleration now in 2017. The practical use of hash functions far
exceeds their recommended use in new projects.

>> So I don't follow the argument that we shouldn't weigh future HW
>> acceleration highly just because you can't easily buy a laptop today
>> with these features.
>>
>> Aside from that I think you've got this backwards, it's AMD that's
>> adding SHA acceleration to their high-end Ryzen chips[1] but Intel is
>> starting at the lower end this year with Goldmont which'll be in
>> lower-end consumer devices[2]. If you read the github issue I linked
>> to upthread[3] you can see that the cryptopp devs already tested their
>> SHA accelerated code on a consumer Celeron[4] recently.
>>
>> I don't think Intel has announced the SHA extensions for future Xeon
>> releases, but it seems given that they're going to have it there as
>> well. Have there every been x86 extensions that aren't eventually
>> portable across the entire line, or that they've ended up removing
>> from x86 once introduced?
>>
>> In any case, I think by the time we're ready to follow-up the current
>> hash refactoring efforts with actually changing the hash
>> implementation many of us are likely to have laptops with these
>> extensions, making this easy to test.
>
> I think you underestimate the life of hardware and software.  I have
> servers running KVM development instances that have been running since
> at least 2012.  Those machines are not scheduled for replacement anytime
> soon.
>
> Whatever we deploy within the next year is going to run on existing
> hardware for probably a decade, whether we want it to or not.  Most of
> those machines don't have acceleration.

To clarify, I'm not dismissing the need to consider existing hardware
without these acceleration functions or future processors without
them. I don't think that makes any sense, we need to keep those in mind.

I was replying to a bit in your comment where you (it seems to me) were
making the claim that we shouldn't consider the HW acceleration of
certain hash functions either.

Clearly both need to be considered.

> Furthermore, you need a reasonably modern crypto library to get hardware
> acceleration.  OpenSSL has only recently gained support for it.  RHEL 7
> does not currently support it, and probably never will.  That OS is
> going to be around for the next 6 years.
>
> If we're optimizing for performance, I don't want to optimize for the
> latest, greatest machines.  Those machines are going to outperform
> everything else either way.  I'd rather optimize for something which
> performs well on the whole everywhere.  There are a lot of developers
> who have older machines, for cost reasons or otherwise.

We have real data showing that the intersection between people who care
about the hash slowing down and those who can't afford the latest
hardware is pretty much nil.

I.e. in 2.13.0 SHA-1 got slower, and pretty much nobody noticed or cared
except Johannes Schindelin, myself & Christian Couder. This is because
in practice hashing only becomes a bottleneck on huge monorepos that
need to e.g. re-hash the contents of a huge index.

> Here are some stats (cycles/byte for long messages):
>
>                    SHA-256    BLAKE2b
> Ryzen                 1.89       3.06
> Knight's Landing     19.00       5.65
> Cortex-A72            1.99       5.48
> Cortex-A57           11.81       5.47
> Cortex-A7            28.19      15.16
>
> In other words, BLAKE2b performs well uniformly across a wide variety of
> architectures even without acceleration.  I'd rather tell people that
> upgrading to a new hash algorithm is a performance win either way, not
> just if they have the latest hardware.

Yup, all of those need to be considered, although given my comment above
about big repos a 40% improvement on Ryzen (a processor likely to be
used for big repos) stands out, where are those numbers from, and is
that with or without HW accel for SHA-256 on Ryzen?
