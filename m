Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B15F41F42D
	for <e@80x24.org>; Wed, 21 Mar 2018 11:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751691AbeCULEi (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 07:04:38 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:39608 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeCULEh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 07:04:37 -0400
Received: by mail-wm0-f47.google.com with SMTP id f125so8958125wme.4
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 04:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E1z/L32NP5zLlLqkVueZO9gsvJJYh7mPww+dN9wYqdQ=;
        b=OSGVYHXo9AlPwZC1AHtCY2diONsX+uc/V1wavhrrzKhb/99PNxnyU/rvbHXrNfcCaZ
         R6x282gCf1IVxEdekFYAUg/vug1eV4AYCiCjqxiirQDjVird4tH+hKlrVVVtOPguEF24
         C20a5HXBng0s5xxGydJTYkf6WctfXL0aY9D/qbPYGkZuzWaf8+70Omv4eT9UbXYF8Sc3
         HmOp6auoJzY/eMXeZPIBKiP4WM0nmnTqSMckTbCPrlsEeCI856Y/7r1rGtXdMWU9bwFB
         L424h+VfLysBXfbr9vS4VMVbT7dwHvCgr1ZyUhO4N2eKIXSKc3V8gLJIqASMuD5OqhlQ
         6NpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E1z/L32NP5zLlLqkVueZO9gsvJJYh7mPww+dN9wYqdQ=;
        b=mwAuUnDgCWUyY8X6N2aH7Xz51EiWedYuldT3vpS3hL7SBHGi59gnx6lJ6BFnozla76
         ejK5gPltCcRtcb09M+V+arBmmey9pOUdYj0EpML2+owpXZqCagJ38vfTC7DJH2VAWpOK
         pvIIzTw85ftEocEn/aw6l4VOuAhj7c5DHW6kEdxdjd8ut3uvALMJy1O3otVu93K5EJM2
         Jwy/fXnQxGHN1R0UpgBtNzfN82p2ZIwg9vNjNZ3LhO8PvdWAGB59YEQ3q0+1R4kWe+Lu
         2tEx1X+o6rLU36dqiN7nA3UhtVPLT8kHrvUkHBpW5zoVOfXUopXEdJJXwGl7i4vskPcG
         bmEQ==
X-Gm-Message-State: AElRT7G6bY9Br8Io6jToWCSmGQTFXILfuDDgADMoe1ZQZXbIb+RzPFW3
        z3Gy5CgLV2RAU5WBP3ZnFY659aIh
X-Google-Smtp-Source: AG47ELtz6Bd0AnIToFIyIKjSppmTbw5edqVmVaVT8rTF1RQFlwXwEGtPR2oJeZcMqEdCBNFCBlhouA==
X-Received: by 10.28.63.66 with SMTP id m63mr2479730wma.102.1521630275786;
        Wed, 21 Mar 2018 04:04:35 -0700 (PDT)
Received: from andromeda.localnet (wifi-eduroam-trans.univ-tlse3.fr. [195.220.58.237])
        by smtp.gmail.com with ESMTPSA id l41sm8896783wrl.2.2018.03.21.04.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 04:04:34 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC][GSoC] Project proposal: convert interactive rebase to C
Date:   Wed, 21 Mar 2018 12:04:28 +0100
Message-ID: <46112353.MVnaADNoVi@andromeda>
In-Reply-To: <nycvar.QRO.7.76.6.1803201720090.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <2564070.6kGkNsz7Qa@andromeda> <nycvar.QRO.7.76.6.1803201720090.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Le mardi 20 mars 2018 17:29:28 CET, vous avez =C3=A9crit :
> > Weeks 1 & 2 =E2=80=94 May 14, 2018 =E2=80=93 May 28, 2018
> > First, I would refactor --preserve-merges in its own shell script, as
> > described in Dscho=E2=80=99s email.
>=20
> Could you go into detail a bit here? Like, describe what parts of the
> git-rebase--interactive.sh script would need to be duplicated, which ones
> would be truly moved, etc
>=20

It would lead to duplicate a good chunk of git_rebase__interactive(),=20
apparently. The moved parts would be everything in `if test t =3D=20
"$preserve_merges"; then =E2=80=A6; fi` statements. That is, about 50 lines=
 of shell=20
code.

Judging by that, beginning by that is probably not the right thing to do.=20
Also, somebody is already working on that[1].=20

> > Weeks 3 & 4 =E2=80=94 May 18, 2018 =E2=80=93 June 11, 2018
> > Then, I would start to rewrite git-rebase--interactive, and get rid of
> > git-
> > rebase--helper.
>=20
> I think this is a bit premature, as the rebase--helper would not only
> serve the --interactive part, but in later conversions also --am and
> --merge, and only in the very end, when git-rebase.sh gets converted,
> would we be able to simply rename the rebase--helper to rebase.
>=20

Yes, Christian Couder told me that it would not be a good methodology too.

> Also, I have a hunch that there is actually almost nothing left to rewrite
> after my sequencer improvements that made it into Git v2.13.0, together
> with the upcoming changes (which are on top of the --recreate-merges patch
> series, hence I did not send them to the mailing list yet) in
> https://github.com/dscho/git/commit/c261f17a4a3e

One year ago, you said[2] that converting this script "will fill up 3 month=
,=20
very easily". Is this not accurate anymore?

>=20
> So I would like to see more details here... ;-)

Yep, I=E2=80=99m working on that.=20

> > Weeks 5 to 9 =E2=80=94 June 11, 2018 =E2=80=93 July 15, 2018
> > During this period, I would continue to rewrite git-rebase--interactive.
>=20
> It would be good if the proposal said what parts of the conversion are
> tricky, to merit spending a month on them.
>=20
> > Weeks 10 & 11 =E2=80=94 July 16, 2018 =E2=80=93 July 29, 2018
> > In the second half of July, I would look for bugs in the new code, test
> > it,
> > and improve its coverage.
>=20
> As I mentioned in a related mail, the test suite coverage would be most
> sensibly extended *before* starting to rewrite code in C, as it helps
> catching bugs early and avoids having to merge buggy code that needs to be
> fixed immediately.

Makes sense.

>=20
> > Weeks 12 =E2=80=94 July 30, 2018 =E2=80=93 August 5, 2018
> > In the last week, I would polish the code where needed, in order to
> > improve for performance or to make the code more readable.
>=20
> Thank you for sharing this draft with us!
> Johannes

I=E2=80=99ll send a new draft as soon as possible (hopefully this afternoon=
).

Thank you for your enthousiasm :)
Alban

[1] https://public-inbox.org/git/20180320204507.12623-1-wink@saville.com/
[2] https://public-inbox.org/git/alpine.DEB.
2.20.1703231827060.3767@virtualbox/


