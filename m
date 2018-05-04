Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62A9C200B9
	for <e@80x24.org>; Fri,  4 May 2018 14:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbeEDO7P (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 10:59:15 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:39274 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeEDO7O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 10:59:14 -0400
Received: by mail-oi0-f47.google.com with SMTP id n65-v6so19386128oig.6
        for <git@vger.kernel.org>; Fri, 04 May 2018 07:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ehftMhYEuDAmpNwhEGITXylYdZ01AUVYp6ZCwnYr7fU=;
        b=LjchL/bH/FCNObkunHBHGmJvU+TANTdPyA3IrElfpK4I8y9WZhWvPLbmD5jvrleJH6
         dcDs8Lf0sVaRDp20JKczgi13y814eI1fDgKcwlgwscC+4mRBJxHqzHiMnPlFZaiZ+ynr
         8qN+mtzmgetkskaXtot/Rpv/3dfCxP+k3kA/zBjp6owXj3zc5/4VK042AJWteqx+cXsc
         Mu/M9nquOZEe16O5jClRVjnlO0M5V7Kpxb3eOpvkEKIuJW8b1MqjLPVjTjTz4xITaycT
         ibgVOyE9kWfGgAzOKIWh3kSJb8FB3d4duAHZ0dd1sUiJEawvwwVIaCsfuELc67lEKcg+
         uCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ehftMhYEuDAmpNwhEGITXylYdZ01AUVYp6ZCwnYr7fU=;
        b=aApvZwWfExZzB5aEuRBmctLRQqyrRfP8aVwUjJe02BpSAfvKzW6d3IIA0HOisiWPTl
         JIrMntqAFzJKApzEvDAIg7mHS69YA2h8iwj2+SqDpvpn0T/KyNJquX6f6neeBsljAprp
         X6h3n9Oy0lslJon6fJmSNO6Zb5aGtjvWfO32C/YTVRovMBQYbDRLNvTknaxsvA5HWAOM
         DdPPAFSD3cEUmOwabg1Ux/Hr2z6gh0jUCbUR15SmX3vgbDhgqEKbAa50UWYIgHa2szQ0
         cGasxHnVQ1NDV+5vFTF4pwiMgsb1nxZt/fdD0UcZCakZoYGQDxFaMtS/8ljh3QR8/rhh
         qDOQ==
X-Gm-Message-State: ALQs6tCi6hH9SMbx6q7plJZ++K4+BB0yd/W7R4RDHi1ztyWJx1wSGb+b
        gYL9hu5y2xx5BMgHkPcKtXkzABkZLsaIYusgXOA=
X-Google-Smtp-Source: AB8JxZr0vRlIHYyHs18ftMVtrEtmrg3MKcFSNfMrG153+AiRl+C0D2U8cGdNWCpnXbzPLgST0rfHvpvV6LP5OyHZdS0=
X-Received: by 2002:aca:1904:: with SMTP id l4-v6mr17751534oii.216.1525445953693;
 Fri, 04 May 2018 07:59:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Fri, 4 May 2018 07:58:43 -0700 (PDT)
In-Reply-To: <87muxfyhy9.fsf@evledraar.gmail.com>
References: <87y3h1ykwn.fsf@evledraar.gmail.com> <20180503131840.27956-1-avarab@gmail.com>
 <CACsJy8CYp3zVSRtS5ozHCitnWU81AamqEGR8RZdDkwujShEatw@mail.gmail.com> <87muxfyhy9.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 4 May 2018 16:58:43 +0200
Message-ID: <CACsJy8D+k+9SNBq7SNFpUhhdZDH7QaZ3+_rXMrge+b5KF_j9xA@mail.gmail.com>
Subject: Re: [PATCH v2] checkout & worktree: introduce checkout.implicitRemote
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 4, 2018 at 9:54 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Realistically the way we do hooks now would make the UI of this suck,
> i.e. you couldn't configure it globally or system-wide easily. Something
> like what I noted in
> https://public-inbox.org/git/871sf3el01.fsf@evledraar.gmail.com/ would
> make it suck less, but that's a much bigger task.

I thought you would bring this up :) I've given some more thoughts on
this topic and am willing to implement something like below, in a week
or two. Would that help change your mind?

I proposed hooks.* config space in that same thread. Here is the
extension to make it cover both of your points.

hooks.* can have multiple values. So you can specify
hooks.post-checkout multiple times and all those scripts will run (in
the same order you specified). Since we already have a search path for
config (/etc/gitconfig -> $HOME/.gitconfig -> $REPO/config) this helps
hooks management as well. Execution order is still the same: if you
specify hooks.post-checkout in both /etc/gitconfig and .git/config,
then the one in /etc/gitconfig is executed first, the one in .git
second.

And here's something extra to make it possible to override the search
order: if you specify hooks.post-checkout =3D reset (reset is a random
keyword) then _all_ post-checkout hooks before this point are ignored.
So you can put this in .git/config

[hooks]
    post-checkout =3D reset
    post-checkout =3D ~/some-hook

and can be sure that post-checkout specified in $HOME and /etc will
not affect you, only ~/some-hook will run. If you drop the second line
then you have no post-checkout hooks. This is a workaround for a
bigger problem (not being able to unset a config entry) but I think
it's sufficient for this use case.
--=20
Duy
