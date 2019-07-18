Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC35F1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 08:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfGRIuE (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 04:50:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:56561 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbfGRIuD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 04:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563439795;
        bh=Av+ZqEKJ/VjZrq3EExhtRQnSxs7DZ8jx85yD+3ts8L8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bv3FfsSc2FmWlaFF2+rUo4iHPr+fJgVdG7hpjg7RJYdPUFJ1yOh+YnUZUamX9Y1aV
         LVgxp1uLXKKsQzA9WwO43JiqfgJZKqNZIb2nxOeP/AXSVDm/hXBSD/twN+4fDEV+e9
         81w9ptePEBI7U8q1yFI5vhk+7M4xK0qp166llBwg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lrviw-1ia3v32xfa-013c7m; Thu, 18
 Jul 2019 10:49:55 +0200
Date:   Thu, 18 Jul 2019 10:49:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 1/1] clean: show an error message when the path is too
 long
In-Reply-To: <xmqqsgr4zea9.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907181048280.47@tvgsbejvaqbjf.bet>
References: <pull.219.git.gitgitgadget@gmail.com> <36677556a26cca9eafd859c88aa9b2c5a6cde309.1563285862.git.gitgitgadget@gmail.com> <a7fee3c7-8fd5-11ef-8b0d-ff8053987b0c@web.de> <xmqqftn53g8z.fsf@gitster-ct.c.googlers.com>
 <xmqqsgr4zea9.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1277090141-1563439796=:47"
X-Provags-ID: V03:K1:4BGAxaP4B+RwidqME2OW+EiK2CWSHl/8oXYS1zOM+dmrIup33gW
 +v8SloyvbcWyFhhXn/46qk1iaSwjGwwPqZzj9HJZjaruI4kVesSpgV0RRSWRgNvW2HXRBXS
 h0xQbG84na6SRczdq9tnK7VUcq7TTRWJfn8V9WGioL5rcgE8Pz59FaGGDOexcxKNiTHAXs3
 6yrnK5fMRb6k2VpdhytLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ICtBzmREao0=:otwsNPZYpV62cRkDSdztHj
 Kh/DdrZmc+4K4Drn+oMOls15MnUR2BUdK5OTVIgc2bPuzCFy1EQhUIwC86Xr21/2X2ptJ3vdq
 TRbwNM1F2LlfklTPHEDsB3xYUHMVjAKwgjURoYOkkrkEHHYsaDgatd7XZ63GQNYoPAgNLbmDq
 +rx9Z2NK2RCafHEpPWmYMuVy6Sx14V6uvEQJLdnake4hSmn0yJsGdvOqTMggx0shqFeFq1dFt
 eAVy19eosEm/W6O3cgT37/kqA7/w3g9QOpKdbkhyyjkzGdUvNOP0MeXhrzQszblUxPPiU7qIW
 zzd8/Mj3OCypVVHf2RK0TktFkJpyivr21mzfej6sNriQiMa12iVbnLwHXwv81MZJPm02WrRXt
 G91n9NwoIWk2xMRuWvM38+9D3LIeOOX2iv8yvuC0Awp3eJjVVzhTI3wHj3Bvgwov4cA95qDCC
 W0aEuXrGbtp84lZveJblCdjBKGr0UcbY5VukmmP4W7ZPwDpJ6/sx05lV8Yv+allPnViLaX+g5
 EcrZTDNej4hUR3Rs0vdv8md21hu2D35a3SUP/1K+qNe7y+qQdLoVCz3YWSLlHLZ3kAxf97ybq
 tqDYMktC/4ISs1UZ4DvK7fz/tnIgL5GMUXEySW+HURJYtt+f7/TCsZ/WCnd+odp8212eZ8SYM
 uJazRLzUPjhLS2PujEVpGG0tDC4V1Kz3blMfmyHci6c5zqJtsdvPmd3T/i0yG1YSaZ4GcbbCb
 xACRl01cIkIaSVs9xtDpb3U9ZMJgcmyeb2ciw3piECiKfZH7HVWouuGUfMTOLu/QaUqinKTZe
 ZFFCv0gqMtmMGUWphBZZPxspFiMA/KqkGTQAKaSFze6tUxxsnmobufslxzI+691j/IQES1pX1
 o8hHDFtR0r8Yq+Lc08m8pYZ+qzf8iHmc69MZlUg5d1vmhB3nUa4eSzs6CgSbkr4N6nUO+9q5i
 OmE/ZQkBv8PizumwTnk5jPERwpDUdteMPZwyxKq8RPzgn5QZdQvwjiClNELCYNzDp71C7dcCD
 bOgFCCW38orgph1VCizzb8n6HqiRoVUPH9XrnBgGw3WrOMM3h7IYElk+5ST9aqM407p8izNFr
 2FP+rxXF+PuehjeBofxgFSFw+I3XZRuftFM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1277090141-1563439796=:47
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 17 Jul 2019, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> >> The other warnings in that function are issued using
> >> warning_errno() (shorter code, consistency is enforced) and
> >> messages are marked for translation.  That would be nice to have
> >> here as well, no?
> >
> > Absolutely.  Also, downcase "Could" and perhaps use _() around.
>
>
> This one is easy enough (not just in the technical sense, but in the
> sense that it has little room wasting our time bikeshedding), so let's
> tie the loose ends and move on.
>
> I was tempted to fix the proposed log message to excise exaggeration
> (I prefer not to see "very", "important", etc.---other things that is
> said in the message should be enough to convince readers about the
> importance), but didn't.
>
> What I did do was to not just rephrasing the warning message, but to
> give it its own constant and to feed it to warning_errno(), to match
> the other warning message.
>
> I also saved one (or perhaps two) fork(s) from the test script ;-) and
> added a portability note there.

Thanks!

On top, I integrated Gab=C3=B3r's suggestion to use `test_config` and thre=
w
in a paragraph in the commit message to explain why the `core.longpaths`
variable is touched at all.

v2 incoming,
Dscho

--8323328-1277090141-1563439796=:47--
