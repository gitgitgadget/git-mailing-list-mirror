Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D191F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 16:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbdCBQhU (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 11:37:20 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:33541 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdCBQhT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 11:37:19 -0500
Received: by mail-io0-f193.google.com with SMTP id f84so8569040ioj.0
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 08:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=219kTDOSJ2A47P3O9MNNAz3y4QBg6IQqNui2PZGjSoo=;
        b=OUHFk+JZVDf6+9mzVdqGC7rEN2ujnuNTTe6EBapiua9OO+974qmowtKFtqkGSOYNuA
         lx8isdh+vEd7G6YMYOYUeMYEly4+1nOxPZ+UNaAJm0czWV4hzL7VBFxfo0F6rG9Pn4UY
         uAHlDLztXn9SPUJUsKdch7ZYH7pjWnNPsL2QUKs/YWKeKartRo4H8GO2qTnEYa0yeZ7l
         v73JNX0MtJcY4JfV+JLTf/47xD6xu8U74i8TYc6hwxR75WnD4DeDE5OK0HGiIpf25Pps
         +Y1HjSqFsaHeVY0e9V/7qZlm7vfs/EEdyQP5iIhDhq7TS6P7BCjHjfl/9GzldczZM32/
         wFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=219kTDOSJ2A47P3O9MNNAz3y4QBg6IQqNui2PZGjSoo=;
        b=cjJ3hpHuxOSYLmLEGfdcL9zq5PxpvHvSnoTiOT6fSO4ab372JtPSxkTf9UZdM6/a8u
         OkYowQupkV8YcFGn9q8iMkv7UK2KKg75UyLePDObCHAIgBwET2pGvQATSou49gpvqCtl
         aLqDd8IAdyIooUiZ5D7TK0kVsBHhNqk1/jV/GC7/jccQVOng+hvdd/ko5dutp5V/NKzx
         O9nVtX7xnjLSCETrTL5KCkjymIL9Ptp++0bvdJWfjOJ9FcCbtg4uKUbe1gcp6S6J0DSD
         vOtoz+OiwbrvrKygPgWp+sCRI9lLoO2EU3N9Dl3jxkbabvY51IkZF67aS8kwpswX/233
         bdjg==
X-Gm-Message-State: AMke39mlvlX/gm6H6eYf7SRP1GkRH6IFogPVWFQJjHmlge5c1WunRsSSPDNZYZvAopi01qTosHbOQ6D+BZg09w==
X-Received: by 10.107.178.3 with SMTP id b3mr13914403iof.50.1488472536665;
 Thu, 02 Mar 2017 08:35:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Thu, 2 Mar 2017 08:35:36 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1703021539330.3767@virtualbox>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan> <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com>
 <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com>
 <xmqq37ewhji1.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1703012227010.3767@virtualbox>
 <CA+55aFys5oQ0RySQ+Xv0ZDussr-xZNh4_b3+Upx_d9VPWmpM8Q@mail.gmail.com>
 <alpine.DEB.2.20.1703012334400.3767@virtualbox> <CA+55aFy9=jBJT36FC2HiAeabJBssY=jE=zLxwrXWzhpiFkMUXg@mail.gmail.com>
 <20170301231921.2puf7o7jkrujscwn@sigill.intra.peff.net> <CACsJy8D3h1KAaKi_Esc98za3LqXaB=YeW0Yu+VAV9UnX5vmttg@mail.gmail.com>
 <alpine.DEB.2.20.1703021539330.3767@virtualbox>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Mar 2017 08:35:36 -0800
X-Google-Sender-Auth: 4L-l83UqU_K1Y38gDiNNf8-_Knw
Message-ID: <CA+55aFzscLaviJac-SB65WFYViY=wyAF3EWOnhHSuzSuFLdPTA@mail.gmail.com>
Subject: Re: [PATCH] Put sha1dc on a diet
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Stevens <marc.stevens@cwi.nl>,
        Dan Shumow <danshu@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 2, 2017 at 6:45 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> It would probably make sense to switch the index integrity check away from
> SHA-1 because we really only care about detecting bit flips there, and we
> have no need for the computational overhead of using a full-blown
> cryptographic hash for that purpose.

Which index do you actually see as being a problem, btw? The main file
index (.git/index) or the pack-file indexes?

We definitely don't need the checking version of sha1 for either of
those, but as Jeff already did the math, at least the pack-file index
is almost negligible, because the pack-file operations that update it
end up doing SHA1 over the objects - and the object SHA1 calculations
are much bigger.

And I don't think we even check the pack-file index hashes except on fsck.

Now, if your _file_ index is 300-400MB (and I do think we check the
SHA fingerprint on that even on just reading it - verify_hdr() in
do_read_index()), then that's going to be a somewhat noticeable hit on
every normal "git diff" etc.

But I'd have expected the stat() calls of all the files listed by that
index to be the _much_ bigger problem in that case. Or do you just
turn those off with assume-unchanged?

Yeah, those stat calls are threaded when preloading, but even so..

Anyway, the file index SHA1 checking could probably just be disabled
entirely (with a config flag). It's a corruption check that simply
isn't that important. So if that's your main SHA1 issue, that would be
easy to fix.

Everything else - like pack-file generation etc for a big clone() may
end up using a ton of SHA1 too, but the SHA1 costs all scale with the
other costs that drown them out (ie zlib, network, etc).

I'd love to see a profile if you have one.

                      Linus
