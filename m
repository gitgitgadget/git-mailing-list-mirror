Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B4F71F404
	for <e@80x24.org>; Mon, 19 Mar 2018 19:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969528AbeCSTrj (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 15:47:39 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:34142 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969954AbeCSTrd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 15:47:33 -0400
Received: by mail-ot0-f180.google.com with SMTP id m7-v6so318783otd.1
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 12:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uuEx8U+FPk5/Fya+lMWGCEw+Z7cc44IqYpVTkKLhwDU=;
        b=S85rlMY9pd37GG1424UYPmaXjaiDLCEv4JaMfTj3OJfPOC6v8qim2Ayus7VySgolm4
         i7lJvjo4hfKmU4+1eMeiSN1e24/evmFQgX4KXI2t+iBIKzQJjyYlfC2I5YR5EEDunxHv
         AXD9dy16h7ux9Dut5NTdxuKYlv3Bk1GgN66p3/QtIjpWCp2Ga7a7+o51yDicVFWR2VV4
         DzGX2nOUQP6pMSG/FxlkknIlNqsTiqHLU/oVHK2iISNMWEoAmp0ISuj65B96UO7ghqR9
         G4LkXCSu8iAwLbiwR1BBhyqQgnhkqNV66kqCL7KTWEBIYhv845v6yQC5KfHmffHt+4Eg
         DF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uuEx8U+FPk5/Fya+lMWGCEw+Z7cc44IqYpVTkKLhwDU=;
        b=SPhdlls+jpCbzY01V1U867163vvSnKvFP9dNdDipL6veR59x5AZk0Ca8sQeu9qpgRI
         YpyITnDQexg6/1n55Wmx75zItDku5KxcrBe5s0AitYI2paDXyjrgfHyMv/9p9fna73dT
         JWP2KjHAvcj/WYFQe49jRzo97Di/mJotBQAsjht8OdKVVMFauEXbiznhXSW3FNEPPqA9
         oevGjH1rFAyO59KVVOoREX+G1LJnlBFmuQ0Q1u86Mk6uEN6TaUTjpESP8ezx1BSw12to
         Lm1OceSHApj3FNiJc/lyf8HC2ucKXZMIIG7aaxL27nXQ8LnBDWQyGWHXf+RA5u9dRnL1
         5bHg==
X-Gm-Message-State: AElRT7EkXfjvPMK0GE6T5n6PO4eMiYbJaH96Cminuw5veW8cce9kldOj
        Yww170rw/kA+cvPyHACU6xhi1QSC1U1jF4RjPOWiy31A
X-Google-Smtp-Source: AG47ELtU9iLruDGEA4q0zhCcDX+dfYD9CuzU/NMGmhX7qbjirgejKwIhpwnnxghTgD+DYgJpnTJY8/DeH9B1aFGWgmg=
X-Received: by 2002:a9d:b68:: with SMTP id p37-v6mr6780121otd.27.1521488852347;
 Mon, 19 Mar 2018 12:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180319025046.58052-1-dnj@google.com> <20180319025046.58052-3-dnj@google.com>
 <87y3inc1my.fsf@evledraar.gmail.com>
In-Reply-To: <87y3inc1my.fsf@evledraar.gmail.com>
From:   Daniel Jacques <dnj@google.com>
Date:   Mon, 19 Mar 2018 19:47:21 +0000
Message-ID: <CAD1RUU-3Q_SYvJorU+vEY2-0CPMZ1eL-41Z6eL7Sq4USiJ0U+w@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] Makefile: add Perl runtime prefix support
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 3:21 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <ava=
rab@gmail.com>
wrote:

> I think it would be more idiomatic and more paranoid (we'll catch bugs)
> to do:

>       my $exec_path;
>       if (exists $ENV{GIT_EXEC_PATH}) {
>           $exec_path =3D $ENV{GIT_EXEC_PATH};
>       } else {
>           [...]
>       }

> I.e. we're interested if we got passed GIT_EXEC_PATH, so let's see if it
> exists in the env hash, and then use it as-is. If we have some bug where
> it's an empty string we'd like to know, presumably...

Good idea, done.

> > +
> > +     # Trim off the relative gitexecdir path to get the system path.
> > +     (my $prefix =3D $exec_path) =3D~ s=3D${gitexecdir_relative}$=3D=
=3D;

> The path could contain regex metacharacters, so let's quote those via:

>       (my $prefix =3D $exec_path) =3D~ s/\Q$gitexecdir_relative\E$//;

> This also nicely gets us rid of the more verbose ${} form, which makes
> esnse when we're doing ${foo}$ instead of the arguably less readbale
> $foo$, but when it's \Q$foo\E$ it's clear what's going on.

Ah cool - makes sense. I'm not strong with Perl, so I wasn't aware that
this was an option, but I agree it's cleaner. Done.
