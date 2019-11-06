Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 848BF1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 19:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbfKFTjP (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 14:39:15 -0500
Received: from mout.gmx.net ([212.227.17.20]:42769 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbfKFTjP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 14:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573069147;
        bh=RwEL75u8N8lnxvn+6HiQyPfl1Q4TUoRlpVAAn3WGNH0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=E4yWxd76KRfEMhfUTWf/TSaEskuk+Nf+/WYJqPgQb96tkJu63J3cOBjxziVgn/Ofb
         X4PwWD6UrWiPg0deWnT2DGC9+4i6AHPDoh/Bfg2sn+nC27dR2qAu6grPVF9ljGb3Qd
         bJfcYj0dTKf6Z5RtR+iHSK0QOB94HY4UpZ3TSF/o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWigq-1iQIT42Ts0-00X10Q; Wed, 06
 Nov 2019 20:39:07 +0100
Date:   Wed, 6 Nov 2019 20:38:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Subject: Re: [PATCH 1/1] remote-curl: unbreak http.extraHeader with custom
 allocators
In-Reply-To: <xmqqsgn1tjup.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911062029230.46@tvgsbejvaqbjf.bet>
References: <pull.453.git.1572991158.gitgitgadget@gmail.com> <d47a2aa5949a5dd3a10b89d9a77ebb89af6ba57e.1572991158.git.gitgitgadget@gmail.com> <20191106041644.GE4307@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1911061009230.46@tvgsbejvaqbjf.bet>
 <xmqqsgn1tjup.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:u8fg3tste6XOFKaWIuOhA5NYTJqxl3h4gUkS2UNn4eNje9fKTir
 SFWklKl1+74RgJvF21I/BQwGQbWU0OcjVaaWaCU15wCdXwIRIabJVFEaGZwx3EuXIddsgT3
 KOHCYetvq5Xu5adY5SQ9f35/jVVzYT175l0+QJxLh8Uxg1CX7aYVGl6Kh2SSdKS+sqYj6Do
 kz8B3vmZFQSy/cRKei0NQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mau3h6gkb24=:/PbjS+G4xhRZnDsJLBElUN
 iozuqzm34a8QoezkoEMT6lYFanvVAiQ9QGD5f7+NfoEenPuHfhZy0kySSlos5mOhp+HegCYI5
 /V52HaVX4zYFGsIVtVAljrYM7YJ7Ifn5vv61qo3mBhPOHlfB6Jz2hU77ShoiNH+Y031CM6CH2
 wLkI3er3ItCllElqMHaT+oJRPg/o8nAMxj6acyLSo2sa22g9nmj1nyyuP210N5ljDehKzwv0L
 /RzkYtq8IBo/wljI3GzxC9wr1n55ANnaJujepJ/OU/gdBv7RtwPsMmlvJc55METTLXdg7ub+m
 YFY9YtVd10mYztiOm0wNwUWevs2evcAEvCZQGo4NfZNUgjI45dfa+xrLfS4Qwby9bZFRa4gYV
 nWXXWt7Kgk+z/LcplIw4/2Szwi3+ltq/eN1B5XRNbrgsb6KryTpY/6ru2j+46twSIeRGC3hOd
 IVynJUUOG87EVb4SdYrnIconev0NH9/znCOvfQcBG5BI2Uq18PFsiO8Ha4FmlTxdRlmbFuMCm
 ELRLAzKoCfALgs/jTtbTsTj33biFl2OxfJ2Mc6h0qM7hCCq6hE1ye7sE4j8wMTfpIjAJYofox
 Hv4/eVo76i4bt76IliR47kZVlDwT3JjsaBqTQFyhw3QdMibUYcFFKND8+bjpFUS9F/xwb7IVw
 IctJvoIjAU3HthKDLKoIKhydWdFE8XfzUD3wFttGKkOuDMA7njcrG9r2B+woZvfe6GVzbTYhY
 Wt7lyR0Mr1zaXoWks3xHmFvo1qj0szI1SvWzuFqtjAAbqprT+p9zUiqzBp5lUpndjd/0GKZ7B
 XB733RgQ5w/4feojTDg2x//ThMYzTWZ82+o+ktb/9aKeF76z+FVR7uTX40MIwzW01Eai2G5D/
 jatmcjVrUw+zAiJ48C4yx6+uoXSrkHSuR1IlR7q7vMH3ilvbMnrNpBg2K42x6BvWbRTw3Q4qG
 KDZWFXK0uGholeBVoRrYZiOJeOhiCm6SzW0F0BicICU4LpckV1QNT5qPmL4+fE8s0I9Frkanh
 klwOAibjyND/+o8GwrfbRk+F6tOO6K5XT14hDe7v7xko8l+VDM//GO1Z4GqAK6VIxG9dyYC09
 tNCZnOQD9BTMcRmem9OeF4HEibZyf9iw+Dc/SlwWdVGI1oX7GQWJwyGlBApybaqGAR4EPNas9
 gPXRYgP7eTSRthhqBfb3t09Jv+6kE18evv9Nyxnh3wIlXsNKetVbsb/yg6/caVupfEr44aROD
 S+YLh5uKP1v2YbFWAx1bWWNrgi9bSNc0qTREs/zIySzMbbqg0IZsufM99AHA=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 6 Nov 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Tue, 5 Nov 2019, Jeff King wrote:
> >
> >> ... transforming it later into a curl_slist. I don't think that reall=
y buys
> >> us much, though.
> >
> > Alas, it _does_ buy us a lot, as I *just* found out (can you imagine h=
ow
> > glad I am not to have rushed out another Git for Windows release?).
>
> Thanks both, and especially thanks Dscho for both for a fix and for
> restraining yourself from the urge to pull trigger too soon ;-)

Well, I _will_ trigger the pipeline publishing Git for Windows
v2.24.0(2) in a moment, with this fix, but more importantly with a fix
for the installer that tries to install some Cygwin-style symlinks,
which was broken in non-US locales (most notably in a Japanese setup;
apparently there _still_ are developers who did not yet move away from a
Japanese locale... at least on Windows).

Ciao,
Dscho

>
> > I will change the patch to avoid using `slist` early and send another
> > iteration.
>
> Will look forward to seeing it.
>
> Thanks.
>
