Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E62F61F404
	for <e@80x24.org>; Fri, 16 Mar 2018 12:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbeCPMnd (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 08:43:33 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:40831 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbeCPMnc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 08:43:32 -0400
Received: by mail-wm0-f54.google.com with SMTP id t6so2803166wmt.5
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 05:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=jpa1rWriD2Bgtp74ZlDGOMGRY2v/Gs0Erhw2kKi4D+c=;
        b=BZ/bfzKwzofc2zsbgo5orIbIHSrufsC4gCC+xv/ET3Wd5M1Z7CkiEq13QSDssnHBpc
         2MRqjsy02WIEbMKRb4WkLRxjKLd2Brmt7DZOxeYaVqnPPyx1A9TaFJvty3GdaStrvTih
         4HucQLtSXSc/ie7wVdz/THoIsI/oSnFqFcGoS1PKpw/af2bUyXB2WNoVrCEL6YMtgn/0
         rGDseOIkvxwE2gsWan3MfyInDt/B/E6Wj1j9mJy+tFzDMQIL7n0knjkfmNemiI0NICSS
         IipUZajBZw2tZeLyytK280E7FSpxXVgaRNxBRLLhCjQC7GkNomQL+Rw7JZ5LzI7Gjpj3
         j71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=jpa1rWriD2Bgtp74ZlDGOMGRY2v/Gs0Erhw2kKi4D+c=;
        b=OQlFQQ8Q6bJFUN/03W81/oTuDRIqQvzSSLjND83ZrOTL6JrSnW2OgG1IVr2NPW0mVR
         OwN+9nqVaAUhp/HNZGITmC1uhdmVkHurGHb3CiBlEsjptunNxQJtd+pP1RlkaNOmR5aO
         p7uwqZyWLQEPyvoCJ5hyBifpeEaRBdLQ1YYnZMAz0fgCofa25hXUSW2EDXtraELmmuK/
         fy1UD3GLuy3c09rwiQXYeXQva3NenV1+PDp/w+Mi+e92YxBnoL5jRfttQQLqLres/36/
         shXivfaHkspvZPrg2/+hV5K+qyTN44/roWtnMPx4JzyypK7b+jHRRtD7RoAmOPKk/IV2
         VqDg==
X-Gm-Message-State: AElRT7ERkZojNpjDzNz18VrBkoD7HYlQmn2FwKAxiKcN/YzR4AZPqbsl
        6mXjbLLbSuZ1Pi5vh6IMTFuUtigu
X-Google-Smtp-Source: AG47ELt7eL2eluyTNb+QgQ1A8VspSy5/WDgM3W2XIUMIiYaiI+ZOoDTm5E3nP86JPfPT3a+jiuk9Tw==
X-Received: by 10.80.142.221 with SMTP id x29mr2435962edx.128.1521204211504;
        Fri, 16 Mar 2018 05:43:31 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id s8sm3971924edk.28.2018.03.16.05.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 05:43:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>
Subject: Re: [PATCH 3/3] Makefile: optionally symlink libexec/git-core binaries to bin/git
References: <20180313203935.5084-1-avarab@gmail.com>
        <20180313203935.5084-4-avarab@gmail.com>
        <1cabf9c0-674e-c2b3-9977-9c74b929a86d@kdbg.org>
        <87y3ivdkvp.fsf@evledraar.gmail.com>
        <CA+55aFwU5fwWx2+DdBp=XCpG2Orx+rA8KxPVtGHxpgHAZs=h2Q@mail.gmail.com>
        <nycvar.QRO.7.76.6.1803151804390.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CA+55aFz6J2j_o0b1JfPSPUX0t3703oFtrpcot29_cgbKi7EnOg@mail.gmail.com>
        <nycvar.QRO.7.76.6.1803161248040.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1803161248040.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Fri, 16 Mar 2018 13:43:28 +0100
Message-ID: <87efkkdwcv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 16 2018, Johannes Schindelin jotted:

> Hi Linus.
>
> On Thu, 15 Mar 2018, Linus Torvalds wrote:
>
>> We do end up still using the dashed form for certain things, but they
>> are already special-cased (ie things like "git-receive-pack" and
>> "git-shell" that very much get executed directly, and for fundamental
>> reasons).
>
> Please do elaborate.

If you were to set set "/bin/git shell" in /etc/password it would not do
the right thing as far as I know. Is that a shell name with a space in
it, or the "shell" argument to /bin/git?

There's also the fully dashed forms of stuff like git-receive-pack is
part of the over-ssh convention, i.e.:

    ssh <host> git-upload-pack ...

That being said I think Linus is conflating two things here. If we still
had just the dashed forms on *nix we'd still have the issue of what it
does to shell completion, which is one thing that got brought up in the
discussion to create the "git" wrapper at the time. There were also
other reasons IIRC.

That's an entirely separate discussion from how we go about either hard-
or symlinking some stuff git is using, whether or not that's ever
directly exposed to the user.

Having said that I have a WIP re-roll which where I'm aiming to:

 * Add a NO_INSTALL_CP_FALLBACK flag, so we won't implicitly fall back
   to cp silently (unless told so)

 * Remove the 2>/dev/null we're doing on everything. That pre-dates the
   NO_*_*HARDLINKS flags and we shouldn't be doing that anymore.

 * Add an option where we optionally won't install the majority of these
   dashed forms, regardless of whether we choose hardlinks or
   symlinks. We'll still need some linking as some dashed forms we can't
   remove, as noted above.

I didn't expect Junio to merge this down to `next` so fast, so I'll wait
until INSTALL_SYMLINKS lands. As far as I know the code as-is in next
isn't buggy, I'd just like to improve it a bit more, so I'll need to
rebase what I have on top of that (which is fine).
