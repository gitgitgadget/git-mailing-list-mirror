Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380FBC4363A
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 14:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C7E21927
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 14:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BbjMMaSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbgJHO0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 10:26:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:60613 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729992AbgJHO0J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 10:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602167162;
        bh=q9FmGdJcHmJd8lcnitGLtAxHyajrqxV4mxTwPQmt7gs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BbjMMaSntnqfjuS8IAY7LMLGwFqWCf/oQZpB9ktM3pimpf0ssUn7RZ+XVb+IgiLeJ
         I29SPDNaH7xYZ0MRdGiEDehYFv7Vp9+fk3PVFyQwthDOjftVm4k1zz/dclCy6Ic4e+
         bM0T0x7T6girFLZwBnTUIOoUButxk3t2GQBBQvuI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.213.205]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mel81-1kyUdr2nFl-00ampA; Thu, 08
 Oct 2020 16:26:02 +0200
Date:   Thu, 8 Oct 2020 16:26:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Makefile: create externcheck target
In-Reply-To: <20201008095233.GA2611970@generichostname>
Message-ID: <nycvar.QRO.7.76.6.2010081625450.50@tvgsbejvaqbjf.bet>
References: <9e5a8625cab217bd6aaba68da081bc801354b903.1602059508.git.liu.denton@gmail.com> <1c2ee1c40ccde18a008262aeaf23a17da2064eae.1602142232.git.liu.denton@gmail.com> <nycvar.QRO.7.76.6.2010081125390.50@tvgsbejvaqbjf.bet>
 <20201008095233.GA2611970@generichostname>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sBGpnP0sb78T7ezbyEN3c5yd430btHAg2VFEYkfW72PXI/zM2Ft
 0QTXnT/mDWUBcoKyU3TAeZhPZr/9UBYRKxBuoxbKtghB9t6wmyZe8WOIV/eXkTkqir6tEUy
 NsqC8+/sIGZtoElUZ0WWklaWEu2nzwI+ZCIW3RgmSuhI7GKR08WKK5VzORztdXCEWlB5FMb
 53bKfT4gRG5AJZ54SuZLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2dlbjE5dDsI=:GKRMYM3s2gQ3R2Or+q9TfJ
 t3xkqp63VEZMSCuT4RhqFJmkocF5qJ/quCM7WygyH25Y4AP8sTkFB/XAvuiHUKQLQn974JUqi
 +WWnU8rwmf7PHKLO7wIL91NDYpG8fSRrbUIaWKeMJqEUC9kp7M3Zr7kDWE/oFV1Y72sMl5hrS
 M5iE0QndoQX6GHQZd5/JaMQ6v2zH2LWNUXrEkwXy51ki1gUUSuZuUnd0j0W4ipCOn+oy4S90l
 qrgYWafJTNb8AJ51HFWKz4b976Kusff86AlFXTBqlGeTynVKiaGP4UTVxfhd++cKEOYFMKubR
 qO40eb8pMwvP8hHXk1OA/ZLFsyhGy+Qc1tZxyJS+g9iaPTDhHygXTgfnC4+yHRomuKUMaCxDR
 Fj4tknkSRb/dAmwFGMcTMhNcXrsKuTgAOJv0ns74m11X4+7aqBJfnXho0jS8JPEnboQKoG+8p
 9Zp+ac+JOSdIe1f0yzpJxU9Db+BbFxLx9twc3d/g3bNwbZAwjavhHVfk0OoLt1crafuFGF3JC
 JIoSgbmXrcuOYZ/Eb4LexXJyKsCDmhDjH3TadvNmpZnQBW0o/ECtrycKI3DbRm4fwWPv6H8fZ
 8TOO1WL7/PO6bC27o49OJxw8plCBQYYM/VONqxMUDe1NL+SXE+jt/Ma2ebfoFpTR0PUQhMJ7j
 /4x9tgq7BsGBUEAjBPLRGbvBdP7ynRxoksq2MeOJriXXA70hltmKBDbtktxlBS2G9iblHZYCK
 ISSy+n/cZW4K5s0MrdVkMsaufz/2pKkAShA9UdY3kLFS4LYUs2YE8JGksyB1p/Aptq4JvUPHg
 49dy+XhAyvl5vZJYKq6qSirPSiwc5dMcM6xo1Tk+0aMvAH7qHECVWFqBg0OqEKgyDU9Gu0t16
 xAUojdJ1gILkAVF505tLwHJrobKj38Uo9lQNnontPvS+W1fhFOrLY0w2gSvHDsWjsi94tBh+c
 uc1VogsuN0C4+3s53KffpzP/uiYps37Qs1PX8eOaoU4WCiaM2P1/lNBjBLPdHLz1fFR0nRWTr
 db05F3Gqw0f+n7wyFwfpSpTyT5c/Isor4h3/voLHxdm7cG4wSsXo0KKIcWbdoFKZMing8HaSE
 1pNWjdLMFrfR9B6h4HBMItL4rGJQlW0flZGZxBx6qUUUzQE/2mtV9eCMSGp3i8uZgqmP39om+
 CXXBvadOX9sYT5gP5WLYH8ASFG9Jm8UGSnoqX8KAYaTm7V3MC/+h1Vqte2wjPwvesbxbsMF4c
 zLfflG2T+p+h9hbOZ2c6+Ch0bzKA2oFpmaseFjA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Thu, 8 Oct 2020, Denton Liu wrote:

> On Thu, Oct 08, 2020 at 11:32:03AM +0200, Johannes Schindelin wrote:
> > P.S.: I am not really certain that the `\s` is portable, I do not see =
any
> > mention of it in
> > https://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap09.ht=
ml#tag_09_03
> > and would therefore expect BSD sed not to handle this correctly.
>
> I've run a varation of this on MacOS's sed before and it works.
> Unfortunately, I don't have access to a MacOS machine anymore so I can't
> 100% confirm it.
>
> > In any
> > case, the `-i` is _not_ portable, as BSD sed takes a mandatory argumen=
t
> > (see
> > https://stackoverflow.com/questions/5694228/sed-in-place-flag-that-wor=
ks-both-on-mac-bsd-and-linux
> > for more details).
>
> This was the main reason why I sent it out as an RFC (although I forgot
> to mention it in the commit message, whoops). Perhaps we could write
> this as
>
> 	externcheck: $(filter-out $(THIRD_PARTY_SOURCES),$(filter %.c %.h,$(she=
ll $(FIND_SOURCE_FILES))))
> 		sed -i.bak 's/^\(\s*\)extern \([^(]*([^*]\)/\1\2/' $^
> 		$(RM) $(addsuffix .bak,$^)
>
> instead? I think that since this is a developer target, we can probably
> call this portable enough.

Yep, I agree.

Thanks,
Dscho
