Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C2C1F403
	for <e@80x24.org>; Sat,  9 Jun 2018 07:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753156AbeFIHcZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 03:32:25 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:38356 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753113AbeFIHcY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 03:32:24 -0400
Received: by mail-ot0-f193.google.com with SMTP id n3-v6so18301525ota.5
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 00:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PA9z/Wn9XFljHoTzTeWx3WWpMs/tIGzeflgwuKL5gAI=;
        b=RH5XDMtBHCyCpcrZdxtB13aTxSAm6eJxjvVc/vFo6yBumNrIaSlZq9EzomP6eITrgW
         zZU9fRCA2Z2theogRFYI6rDmf5kvN4Ji+mociz/V0RnAlbWL6AA63ce1bFYAfMs/fggt
         P0f5n7xBqNDbVvl1eyvQwiJwN0Vw2K835Y1RoNXpuAT8q59G/5yFdCv+EZI5228B1t/2
         C1TTPow2OmyVuw3Ti35RaO5LDlB/KpZAv7zE/NeaAYBOa33DBW/Mg+Ys24seuAyY44eF
         idEOIJtP8SBvZ326c/NFAozAUtuK4vv/ttEe4wZEAh4NxpjGIE4rfNWIAhUKUhnfz8Ok
         lT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PA9z/Wn9XFljHoTzTeWx3WWpMs/tIGzeflgwuKL5gAI=;
        b=ddk5wXPkvxeRb5sfY0/wKGccOM5luxGKuAU2IkvD/+nXbeDMidnFxGrZQXuA+0HrcO
         hJFLWIx68U09yl7fb+B+gSSJ85QMR3SNJ6TpBMqXoS1H6Z71Ly9QLqGrk2zjowoekkLn
         wwAF9LWft2Zh9q8ygqTDkMNYoKnSX7QORtAn9SoALWmCNVW3JboKm90CbPomIKGfkMAU
         EFr/qYAXdz9rC2y7t56EjRG2MS1kDM95s/UTmg+76/+N51miSOpl13gv0QXtM8BT3ypf
         py+6ldFhpywYUm7Qh3MDdUSE46FBH5hkMrkkMzIiGMCCJzR1ODp0WnRSnqO0zL9QYyJD
         GQDA==
X-Gm-Message-State: APt69E3584IxrebrW1SO2oIHsQz6zQTiAqB/Sx6wHnsROhoOGQxyc3hB
        ERnwDnPm8H1zVJkAbzgNeLaN1heh9V/TdSY1qSs=
X-Google-Smtp-Source: ADUXVKIXp+xVIaB8s27a6cBYNc6p9IAi5dBATfzx2T4fEXWdUohw+hyWZACZBqt+4eev8Ghm55YvXlRIKX+y1jFmBcI=
X-Received: by 2002:a9d:2989:: with SMTP id n9-v6mr5829021otb.152.1528529543547;
 Sat, 09 Jun 2018 00:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180607145313.25015-1-git@jeffhostetler.com> <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
 <20180608090758.GA15112@sigill.intra.peff.net> <688240ef-34a1-ee9a-215a-b4f9628e7c72@virtuell-zuhause.de>
 <9ab3eec1-40c1-8543-e122-ed4ccfd367b4@kdbg.org> <87fu1w53af.fsf@evledraar.gmail.com>
 <CACsJy8BPhzs5M4peHN2HczmDxGmAuKZ0corzT66i+rJ2UQRTHQ@mail.gmail.com> <87bmck4gip.fsf@evledraar.gmail.com>
In-Reply-To: <87bmck4gip.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Jun 2018 09:31:57 +0200
Message-ID: <CACsJy8DrtAdwH0dOjptJ0JDQ_gOeiTVbRknui4gM5P85Y5JZow@mail.gmail.com>
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 9, 2018 at 8:32 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> Let's say you're in a corporate environment with Linux, OSX and Windows
> boxes, but all of whom have some shared mounts provisioned & ability to
> ship an /etc/gitconfig (wherever that lives on Windows).
>
> It's much easier to just do that than figure out how to build a custom
> Git on all three platforms.

Let's say I don't care about making it easier on corporate
environment. You have resources to do that.

> > Not making it a compile-time option could force [1] linux distro
> > to carry this function to everybody even if they don't use it (and
> > it's kinda dangerous to misuse if you don't anonymize the data
> > properly). I also prefer this a compile time option.
>
> Setting GIT_TRACE to a filename that you published is also similarly
> dangerous, so would setting up a trivial 4-line shell alias to wrap
> "git" and log what it's doing.
>
> > [1] Of course many distros can choose to patch it out. But it's the
> > same argument as bringing this option in in the first place: you guys
> > already have that code in private and now want to put it in stock git
> > to reduce maintenance cost, why add extra cost on linux distro
> > maintenance?
>
> Because:
>
> 1) I really don't see the basis for this argument that they'd need to
>    patch it out, they're not patching out e.g. GIT_TRACE now, which has
>    all the same sort of concerns, it's just a format that's more of a
>    hassle to parse than this proposed format.
>
> 2) I think you and Johannes are just seeing the "telemetry" part of
>    this, but if you look past that all this *really* is is "GIT_TRACE
>    facility that doesn't suck to parse".

If it's simply an improvement over GIT_TRACE, then I have no problem
with that. That is:

- there is no new, permanent way to turn this one like config keys

- there's no plugin support or whatever for keeping output. Keep it to
either a file or a file descriptor like we do with GIT_TRACE.

>    There's a lot of use-cases for that which have nothing to do with
>    what this facility is originally written for, for example, a novice
>    git user could turn it on and have it log in ~ somewhere, and then
>    run some contrib script which analyzes his git usage and spews out
>    suggestions ("you use this command/option, but not this related
>    useful command/option").
>
>    Users asking for help on the #git IRC channel or on this mailing list
>    could turn this on if they have a problem, and paste it into some
>    tool they could show to others to see exactly what they're doing /
>    where it went wrong.

And they can use GIT_TRACE now. If GIT_TRACE does not give enough info
(e.g. too few trace points), add them. This new proposal is more about
automation. With GIT_TRACE, which is more human friendly, I could skim
over the output and remove sensitive info before I send it out for
help. Machine-friendly format (even json) tends to be a lot more
complex and harder to read/filter this way.
--=20
Duy
