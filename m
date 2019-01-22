Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31C21F453
	for <e@80x24.org>; Tue, 22 Jan 2019 09:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfAVJrA (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 04:47:00 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46876 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfAVJrA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 04:47:00 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so18718834edt.13
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 01:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=HQf/EKh+yqos+txvq/vihNE9ASIpO6piJne9VmyM9NM=;
        b=hXiDWymszRrA1JfLZaWY7ppWctM2gwLdDsN34Oy4cfNJsiuu9sP3YBZisjm+W2/Bf/
         ajdWgSJEW7FCTS21Ao6gRM50kAF1vLtObgAQ/aOphkmsOpm8zj8oQpNUAyFXuJUgjv97
         3KlGMPmjbO3dryF/JgW1Rc8cM87nzcFztm/8VP+HaYuWqsqVgqn+fL6Ri3yy7s5YC7yD
         LQkIzgOAvds02P3N4g2DNqQto1RHnAUw37kDW3iszBCThs0rxnF5yDJuJCk6SjLxr1Tl
         XCA1/3Wy6t0ZTTjUYQy7m+hh7lg1Z45bpTZQrP3wuUodhY6FeyFDwXgeVAvccWiH+w+S
         HLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=HQf/EKh+yqos+txvq/vihNE9ASIpO6piJne9VmyM9NM=;
        b=TysaIo2mv0P1+qxyc+O9dlK7iJEqAyc0M0EuoMMjRR4+GTjwYcHiTOQF3PPVpt+vGW
         WYwAuFcEnQvpClB4QzV2O/GC/DTs//roPmHfC5zrYKKz2b9/ySM0GZNDhnj8EgWlmHqg
         YyS21UD6XR3IbV7zdV2wK9kXX3Foro7u1Jns8ct4nbLHfYEtDZrIBbL4SGI9zUcH91f1
         GSWvhuTHtXdfwVopAZibZLlQMIWvh8JbNLDbArc/JDHBWMiSfWAlZDX4TuDK2msyZNPT
         +CPdxw/vyLQsSO+3LSgv0Ditn9zPXuGnvDMWqIXE2bIodulv4IPWH7yiGJ4ZawDENzyR
         8/rg==
X-Gm-Message-State: AJcUukeG+uYQPA65JLQkgP6awm0fN0MOfuuKaYBNhHzvBtdGfbbHmDYc
        QrzkIqOVyZIX8E8vc65Rf/o=
X-Google-Smtp-Source: ALg8bN7ni91P0+Hrs9LlPFft4l45cI0kvb1mZrj2xp8VB4uPJ2A8PjZk5Bv8otVBPU9FdQuo5dTzeg==
X-Received: by 2002:a50:8eea:: with SMTP id x39mr29418020edx.177.1548150418131;
        Tue, 22 Jan 2019 01:46:58 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id f35sm9935075edd.80.2019.01.22.01.46.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 01:46:57 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Barret Rhoden <brho@google.com>, git@vger.kernel.org,
        David Kastrup <dak@gnu.org>, Jeff Smith <whydoubt@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 1/3] Move init_skiplist() outside of fsck
References: <20190107213013.231514-1-brho@google.com> <20190117202919.157326-1-brho@google.com> <20190117202919.157326-2-brho@google.com> <87k1j247ui.fsf@evledraar.gmail.com> <xmqqzhrxlvfj.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1901182155020.41@tvgsbejvaqbjf.bet> <20190118213018.GA28808@sigill.intra.peff.net> <87h8e54n6y.fsf@evledraar.gmail.com> <20190122071251.GB28555@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190122071251.GB28555@sigill.intra.peff.net>
Date:   Tue, 22 Jan 2019 10:46:56 +0100
Message-ID: <87ef953tyn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 22 2019, Jeff King wrote:

> On Fri, Jan 18, 2019 at 11:26:29PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> I stand corrected, I thought these still needed to be updated to parse
>> anything that wasn't 40 chars, since I hadn't seen anything about these
>> formats in the hash transition document.
>>
>> So fair enough, let's change that while we're at it, but this seems like
>> something that needs to be planned for in more detail / documented in
>> the hash transition doc.
>>
>> I.e. many (e.g. me) maintain some system-wide skiplist for strict fsck
>> cloning of legacy repos. So I can see there being some need for a
>> SHA1<->SHA256 map in this case, but since these files might stretch
>> across repo boundaries and not be checked into the repo itself this is a
>> new use-case that needs thinking about.
>
> My assumption had been that changing your local repository would be a
> (local) flag day, and you'd update any ancillary files like skiplists,
> mailmap.blob, etc at the same time. I'm not opposed to making those
> features more clever, though.
>
>> But now that I think about it this sort of thing would be a good
>> use-case for just fixing these various historical fsck issues while
>> we're at it when possible, e.g. "missing space before email" (probably
>> not all could be unambiguously fixed). So instead of sha256<->sha1
>> fn(sha256)<->fn(sha1)[1]?
>
> That is a very tempting thing to do, but I think it comes with its own
> complications. We do not want to do fn(sha1), I don't think; the reason
> we care about sha1 at all is that those hashes are already set in stone.
>
> There could be a "clean up the data as we convert to sha256" operation,
> but:
>
>   - it needs to be set in stone from day 1, I'd think. The last thing we
>     want is to modify it after conversions are in the wild
>
>   - I think we need to be bi-directional. So it must be a mapping that
>     can be undone to retrieve the original bytes, so we can compute
>     their "real" sha1.

It needing to be bidirectional is a very good point, and I think that
makes my suggestion a non-starter. Thanks.

> At which point, I think it might be simpler to just make git more
> permissive with respect to those minor data errors (and in fact, we are
> already pretty permissive for the most part in non-fsck operations).

Yeah it's probably better to make some of these "errors" softer
warnings.

The X-Y issue I have is that I turned on transfer.fsckObjects, so then I
can't clone repos with various minor historical issues in commit headers
etc., so I maintain a big skip list. But what I was actually after was
fsck checks like the .gitmodules security check.

Of course I could chase them all down and turn them into
warn/error/ignore individually, but it would be better if we e.g. had
some way to say "serious things error, minor things warn", maybe with
the option of only having the looser version on fetch but not recieve
with the principle that we should be loose in what we accept from
existing data but strict with new data #leftoverbits
