Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44AD11F42D
	for <e@80x24.org>; Tue, 29 May 2018 22:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967727AbeE2WAV (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 18:00:21 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40474 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967460AbeE2V7K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 17:59:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id x2-v6so36639078wmh.5
        for <git@vger.kernel.org>; Tue, 29 May 2018 14:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=AeD/J2Qp5bxg33Gx62xJLML8UBtOoxzCCpN2GM1SmTI=;
        b=Sslfiw5NUVCEc6aeOs8YCDDUb9XTqCXs3sbghJTY5uIKl+2NSJaBTe1MbcOcUxy46b
         XdbkrhgGLCNyPbpVbhlhu+aNMQa0zL89qR7WLAkQadst6l4Mv/HJmnRaWcHV8igTcOBw
         9a8L1PdDPC8g3dITp6y75tYyE5r/7RLDpJFx/fNA2i+inQvuckt/rSxgCbwNbir6ckZS
         T3nJOh9aXAZPo4mAkRBMbQxidlMPapFIHULfnP+4sefCVrZBmwnKj5mgPIrwnnsGWWjt
         u2Y6EXMMq3TAbwLSvEZ6RdSzox8gJd5aGYQnMbl5SmZmF/ejmPa/R14sM5hrdNuXtzbD
         5LYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=AeD/J2Qp5bxg33Gx62xJLML8UBtOoxzCCpN2GM1SmTI=;
        b=YNg7pc/XbsHCdhRHsY4S1Qw8ikdKG4EKbn6D8iTtEteZ9zyWfqf5t+07cah785oOgt
         j0VdE5jnLZLIvTPEhuZoOuw/CxSOSTeILdMjkY7HD9RhV86N5JzoYxBgcID5eD4kh2XC
         vzOGUXofuvKqY4kyGdlQ90OIwz9DBhYwZwA4Pi8uUj1kmPKL7FmeHPzo/7dBI1YKVBt5
         QrmOY5rhJrj4FECajll3RhAX6v5GpgKD3E4zfGFSax6ZCqPrlaI7xkOdCVwUb52BlkAq
         B+AafO1N+ggzJe7bGH4Y+6PGwl+vHX+V6zHlDKjdl1ekhr1yB4xlDs6CNqCqk1rBEb1R
         zGsw==
X-Gm-Message-State: ALKqPwe1WuA0UPuMzTJ8iVb/LAb5Kx3PO5a9j/No4i+g5DPfqcrw+ckP
        /Aljl2utmFVJr7hADHMq6y4=
X-Google-Smtp-Source: ADUXVKKpywNTAa3wYHKwK2Jxw8LIzHlP7Fs/1n3KpciYyJIUqhbjTJUd/BvaBMcIHa4et08A+O4Rgg==
X-Received: by 2002:a50:9248:: with SMTP id j8-v6mr571148eda.134.1527631149578;
        Tue, 29 May 2018 14:59:09 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id c11-v6sm7794732eda.64.2018.05.29.14.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 14:59:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsckObjects tests: show how v2.17.1 can exploit downstream
References: <20180529211950.26896-1-avarab@gmail.com> <20180529212458.GC7964@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180529212458.GC7964@sigill.intra.peff.net>
Date:   Tue, 29 May 2018 23:59:07 +0200
Message-ID: <87a7sif7is.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 29 2018, Jeff King wrote:

> On Tue, May 29, 2018 at 09:19:50PM +0000, Ævar Arnfjörð Bjarmason wrote:
>
>> Something that's known but not explicitly discussed in the v2.17.1
>> release notes, or tested for, is that v2.17.1 will still happily pass
>> on evil .gitmodules objects by default to vulnerable downstream
>> clients.
>>
>> This could happen e.g. if an in-house git hosting site is mirroring a
>> remote repository that doesn't have transfer.fsckObjects turned on.
>> Someone can remotely push evil data to that remote hosting site
>> knowing that it's mirrored downstream, and the in-house mirror without
>> transfer.fsckObjects will happily pass those evil objects along, even
>> though it's been updated to v2.17.1.
>
> Sure, I agree with all of the above, but...
>
>> It's worth testing for this explicitly. So let's amend the tests added
>> in 73c3f0f704 ("index-pack: check .gitmodules files with --strict",
>> 2018-05-04) to show how this can result in a v2.17.1 client passing
>> along the evil objects.
>
> I'm not sure what testing this buys us. [...]

Half of what I'm trying to do here is clarifying the v2.17.1 release
notes. The initial version Junio had & my proposed amendment on
git-security was:

      * In addition to the above fix that also appears in maintenance
    -   releases v2.13.7, v2.14.4, v2.15.2 and v2.16.4, this has support on
    -   the server side to reject pushes to repositories that attempt to
    -   create such problematic .gitmodules file etc. as tracked contents,
    -   to help hosting sites protect their customers by preventing
    -   malicious contents from spreading.
    +   releases v2.13.7, v2.14.4, v2.15.2 and v2.16.4, this release
    +   extends transfer.fsckObjects (off by default) to reject fetches or
    +   pushes to repositories that attempt to create such problematic
    +   .gitmodules file etc. as tracked contents, to help hosting sites
    +   protect their customers by preventing malicious contents from
    +   spreading, or to protect clients that fetch from passing on a bad
    +   repository to their downstream fetchers.

But Junio's final version of that in
https://public-inbox.org/git/xmqqy3g2flb6.fsf@gitster-ct.c.googlers.com/
rewrote that suggestion of transfer.fsckObjects to receive.fsckObjects.

That means that for someone who doesn't know how this stuff works in
detail and is just following along with our release notes (and say
enabling just receive.fsckObjects globally on their site) they might not
be covered at all.

The receive.fsckObjects variable only kicks in when someone pushes to
you, not when you fetch something malicious and someone then fetches
from you.

So with this and my https://news.ycombinator.com/item?id=17183044 (in
reply to your comment) I'm trying to do my small bit to inform people
about this angle of it being exploitable, since this issue of git mirror
chains seems to have not been noticed so far, and lots of sites run this
sort of setup to mirror & re-serve arbitrary public Git repos in-house.

The other half, which is why I think this patch is needed, is making
this aspect of it clearer to future maintainers. Before I started
hacking on my recent fsck series[1] I didn't realize the intricacies of
how *.fsckObjects worked in various situations, and I think explicitly
calling this case out in code helps.

Unlike documentation, when we change something in the code we're forced
to take notice that the test suite changes, and are thus more likely to
notice this important but apparently forgotten use-case. If the security
issue of promiscuously re-serving bad objects you've fetched was
forgotten this time around, this will help us remember it if say we ever
turn on *.fsckObjects by default in the future.

1. https://public-inbox.org/git/20180525192811.25680-6-avarab@gmail.com/
