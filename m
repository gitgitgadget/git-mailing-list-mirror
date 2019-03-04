Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A56B220248
	for <e@80x24.org>; Mon,  4 Mar 2019 08:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfCDIqz (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 03:46:55 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45532 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfCDIY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 03:24:58 -0500
Received: by mail-ed1-f68.google.com with SMTP id f19so3475819eds.12
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 00:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IFhFpoJ60TpcoxKdX6GwzguUysnfS6QF4R9GruKx078=;
        b=B5t6y5B7B2Im/cIV0X9k7yTQsr6M8d5lBXr32peN6VuWOMikLwxsUZXHeewNtRcgR0
         +VPK1J2+6Zzj8GTnYbahRlGszXj3U8ZyjFqT1JdqabAD6wVYO8pcbdgOq7BtuvKhmvb9
         JwJy+TYfy0I5lmDWzA/SMPsjSZWumm9zPfih97j4x9n2MOS7Z96fBkJrPlPAtk3Z5f5A
         PARMqB2E8HTrzOeaf6jIOqiHkmf6FgroizAjhWFMfx5Uh8mxS9Ycf54mFOx4R3/bi7uf
         uIsRIfkET0UY03GECljdl+Vo4C0DY5CXPOJ3vkQT5Gi62LPvA3t4bAFzo/CoPJ9BkkkG
         KS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IFhFpoJ60TpcoxKdX6GwzguUysnfS6QF4R9GruKx078=;
        b=fclK48MCuEpIlKB/AVtAq6XWZM+1YdBTdYBqmkEL8Whu/Cr2im5kFPSejs0aWN0Znx
         z07u+tnI7/CaOZmLbD9SATdRm85rpFPchLbjKzYcT7iC37D9So+dF41FUA/wj33qeWE/
         aF6MWbgKBfVdgeegMsuCvXg045t4f0oKYRWHL2Rxw3dEHLeICkC9viAwWb+r4CoVzKBT
         R5uHFdpgbRGRxwh171n8oRchYnC7n7+0R4KQSYdyGR+ioBCMiqqtT21ubLpKaYn0B9xd
         PIndp2IHFUa18/xDvSLw64bQEEpmroLoPWVJyJtXtTvLjublEgIB6a1t0wycQLZn38Jm
         G01Q==
X-Gm-Message-State: APjAAAUGk5P8XuTNy92zgwndbHb3+1scYtTgJVZUGPDVzpUZ/D6VROhk
        te7D2PIhTOyFTFHvxg9b0ydV9Vhcdqs3wy13v7M=
X-Google-Smtp-Source: APXvYqwJz9FlxUDJpfhqI4h8enRZUGfFs8fTAO3ZuXoZ1+hlEoN3Tfn35V/gqdRDDt998fmsvRTP4LeykovV1lHGm80=
X-Received: by 2002:a17:906:a402:: with SMTP id l2mr5171020ejz.158.1551687896453;
 Mon, 04 Mar 2019 00:24:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550963965.git.jonathantanmy@google.com>
 <CAP8UFD19521P=-R1XEdRK++HPatt3BJaxWPvpPRo8LHr3eisjA@mail.gmail.com>
 <20190225234528.GD16965@google.com> <CAP8UFD1tKNFO9wU8CbgNnSnQyvHYPsZMk1Bit2y1jxH4vk62qQ@mail.gmail.com>
 <87zhqivrpu.fsf@evledraar.gmail.com>
In-Reply-To: <87zhqivrpu.fsf@evledraar.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 4 Mar 2019 09:24:44 +0100
Message-ID: <CAP8UFD0wFxecHfYRqSm7RKO66swfsACfMQNx=rFgJ-w4EGTuzg@mail.gmail.com>
Subject: Re: [WIP 0/7] CDN offloading of fetch response
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 10:12 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Feb 26 2019, Christian Couder wrote:
>
> > On Tue, Feb 26, 2019 at 12:45 AM Jonathan Nieder <jrnieder@gmail.com> w=
rote:

> >> But the same thing can happen with redirects, with embedded assets in
> >> web pages, and so on.
> >
> > I don't think it's the same situation, because the CDN offloading is
> > likely to be used for large objects that some hosting sites like
> > GitHub, GitLab and BitBucket might not be ok to have them store for
> > free on their machines. (I think the current limitations are around
> > 10GB or 20GB, everything included, for each user.)
> >
> > So it's likely that users will want a way to host on such sites
> > incomplete repos using CDN offloading to a CDN on another site. And
> > then if the CDN is not accessible for some reason, things will
> > completely break when users will clone.
> >
> > You could say that it's the same issue as when a video is not
> > available on a web page, but the web browser can still render the page
> > when a video is not available. So I don't think it's the same kind of
> > issue.
> >
> > And by the way that's a reason why I think it's important to think
> > about this in relation to promisor/partial clone remotes. Because with
> > them it's less of a big deal if the CDN is unavailable, temporarily or
> > not, for some reason.
>
> I think all of that's correct. E.g. you can imagine a CDN where the CDN
> serves literally one blob (not a pack), and the server the rest of the
> trees/commits/blobs.
>
> But for the purposes of reviewing this I think it's better to say that
> we're going to have a limited initial introduction of CDN where those
> more complex cases don't need to be handled.
>
> That can always be added later, as far as I can tell from the protocol
> alteration in the RFC nothing's closing the door on that, we could
> always add another capability / protocol extension.

Yeah, it doesn't close the door on further improvements. The issue
though is that it doesn't seem to have many benefits over implementing
things in many promisor remotes. The main benefit seems to be that the
secondary server locations are automatically configured. But when
looking at what can happen in the real world, this benefit seems more
like a drawback to me as it potentially creates a lot of problems.

A solution, many promisor remotes, where:

- first secondary server URLs are manually specified on the client
side, and then
- some kind of negotiation, so that they can be automatically
selected, is implemented

seems better to me than a solution, CDN offloading, where:

- first the main server decides the secondary server URLs, and then
- we work around the cases where this creates problems

In the case of CDN offloading it is likely that early client and
server implementations will create problems for many people as long as
most of the workarounds aren't implemented. While in the case of many
promisor remotes there is always the manual solution as long as the
automated selection doesn't work well enough.
