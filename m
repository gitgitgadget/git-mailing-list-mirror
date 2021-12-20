Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21595C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 22:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhLTWVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 17:21:41 -0500
Received: from mout.gmx.net ([212.227.17.20]:37809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230444AbhLTWVl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 17:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640038890;
        bh=Iy76dogsxfcqag2YQuiGFgszduq/S4XsKZcX4joAX7Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CR3fgsEJeRgl2KCvy1StS7DIufJXGTwUXSygcXzMh8v9yeqJaKNoh9MBJja7YPfdq
         s4P+/LasHFYIEkNztoZux2WukgCe5wNbTMljVaJ0aUcCcOfnX8M4vzj+Ri317p9V+G
         Q1nDPAq6V8aa/XzBPCPVPJC7EfqU6gBa3TdmH3Ok=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.215.174]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33Ib-1mKiL12fDp-013Mk3; Mon, 20
 Dec 2021 23:21:30 +0100
Date:   Mon, 20 Dec 2021 23:21:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Florian Mickler <florian@mickler.org>, git@vger.kernel.org,
        jqassar@gmail.com
Subject: Re: passing CURLOPT_CERTTYPE to libcurl
In-Reply-To: <xmqq7dc2zplg.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2112202223300.347@tvgsbejvaqbjf.bet>
References: <20211218010621.2fdc2b3c@monster.mickler.org> <xmqq7dc2zplg.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:G5r6zHoNfAMCHbOA5sa4jfY8ZEr06viNjISy1YkAd3DVqIKu2gs
 WwxenosMgHJ8NGBI72Ui9EN88WvQPYJFhej7uJKamiEbb3BiKXxafIMQDfluxsSUtNaRtOJ
 IjPeZg5a8By6IOkecP8Xzz1n0/hJg32czvzUefW4yUa2xgwdX0NLNSC6CDUc5nDFP3RYSHo
 U71+LVaYZ7rXuldFSHa0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IzvM+VOCydk=:NNucPCSscjPfpnfVAZGJ7R
 7LO5Tgk4VyvGbn1htCb3bgQhxH4tUBkmSVJVSjz/ZySgsvjgWrp9zxq/uURL+tKUrqyURjllf
 7PVRELcEIoJj+sG8Uz8KdfWMOuD4Gg5MAVMAGzkJH0VhI94BXeBYvavXwFXFml/xZTUwVXDkm
 hGX5ArDagNlFDgVGGowZq5qQHgaDUgp8fEY1MSXKVph63Dl9J76gDmnYhxthTjyD6ct0QY8KV
 AZuW3euf/7jNsLIFZmfKiIAou8QIu2keTmcZs9LePW9c78g1zf/BzhGz8em3zas/dlVYifq/n
 yaIL1L+SlGWK2IBF4Xeh1BcZxDsJ1RWMs2pNdko5kgEb+phwDrjNX6Mh2kDIndGFfgfyGD32+
 p05GO++gxKuFijFf/7GCI+g7Me1SWCRewYgaV8k/RIyFwqquJNEQcBOtcx6Yzqgh4o+bifixl
 po5gMqC45AtbKDVroVTkGMuPbA4IV480MfcGoCciAdxCzdI5FxUAVXDqMfox6fl22AnT8Fpef
 besk4ORn08TcFssbcTPHNjZlQNYD9rLWr7sT8rGyL1gJBmb52GRTH+5awB7v9ZmCZGBiLs6E3
 5tcK2mayJ58XY0iYwK6V8zGzQoK+c+GkuEgCukS0p0Ujzzpq3ZYEn02I+NkZ9vijop9XIvLaC
 obuMS1WBnvmxXPfv7Xrc6PAofvfz0BQ60fd//GbdRyqzINh6pTfeyHGSJMW4dvXkxrNhz9RW5
 Yt00X2Hc37b2ydr9IxIoagfri97UHz9Gs6oGbu0p90J3p9LomO5x3PwZTs1VjxCMh0YPpTlKp
 KeHbGENI7JCkJNrbv9YllyVhDSS5jucZiAHtosh6zvG13v0XXjWo+lhQGxuzHEfEksrWjSY29
 7/pekSYa7XxF1Tth5WM9y0YoECtOV5X46ogrXSqQPiv3lTtapWjHvsqKk0qKMZ+b9qyCAxzQG
 ikNRa+4EVbRI1VFfADj949LRXemfvONa6MjEzEJq3ncjvOhT+gt+yStw82bDHhMkpcD/qUsse
 synr620XTNftYAul8GA5FQTdH1Rwd40UEuN5dhCiJw0Bod0+4UjkHmSBgRg/Y+eUQBkX+PBL7
 l3XV5HDhitzczA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Florian,

On Fri, 17 Dec 2021, Junio C Hamano wrote:

> Florian Mickler <florian@mickler.org> writes:
>
> > Is there a specific reason, that patch wasn't merged? It would allow
> > for non-pem ssl certificates to be loaded also (without pkcs11 at all)=
.
> >
> > I realize, that the underlying systems could and should set up
> > everything automagically as soon as i point them to the certificate th=
at
> > i want to use. But not opening up these CURL Settings from git seems
> > kind of silly given that today's systems still seem kinda borked and d=
o
> > not do that.  What harm comes from these two tuning knobs being expose=
d?
> >
> > Best regards,
> > Flo
> >
> >
> > [1] https://marc.info/?l=3Dgit&m=3D136675822032549&w=3D2

This corresponds to
https://lore.kernel.org/git/1366758207-7724-1-git-send-email-jqassar@gmail=
.com/
(for those who prefer lore.kernel.org over marc.info, and for those who
want to look for the Message-ID directly).

My summary of that thread:

- The patch implements something Git wants to support.

- A couple of improvements need to be made, such as:

  * Error-checking needed to be improved

  * Adding a hint to the documentation of `http.sslKeyType` being set to
    `ENG` causing `http.sslKey` being interpreted differently.

  * Adding regression tests, if possible

  * Maybe a more complete commit message?

- Testing the smart card support was considered hard, especially given
  that the contributor still wanted to contribute patches to cURL without
  which it wouldn't work.

  The patch seems to have been contributed via
  https://curl.se/mail/lib-2013-04/0340.html, been reviewed and changes
  were requested, but there was no other patch submission that I could
  find.

  However, over five years later, what looks like an equivalent fix to me
  was applied:
  https://github.com/curl/curl/commit/4939f3652473c1519d2b604068efb87ef753=
1874

- The contributor, Jerry Qassar, gave all the signs of working on a
  next iteration ("reroll", as Junio likes to call it). But that never
  materialized, either:

  https://lore.kernel.org/git/?q=3Df%3Ajqassar

  Based on this, the lack of a cURL contribution, and a quick web search
  for the name "Jerry Qassar" I somehow doubt that Cc:ing them might
  raise their attention.

> Almost always, when some patch aims to achieve a worthy goal, and in
> the initial discussion on the thread more experienced project
> members agree it is a worthwhile thing to do, the only reason why
> the feature proposed does not materialize in later versions of Git
> is because the developer with the original itch did not follow it
> through after getting review comments and saying something that
> makes reviewers to expect an updated version of the patch.
>
> I didn't follow your marc.info URL, but I am reasonably sure, if I
> were involved in the discussion, that would be the likely reason.

Yes, you were involved in the discussion, and indeed, there was no
follow-up.

After more than 8 years, I do believe that the patch is fair game to be
picked up by any other interested contributor who might want to contribute
v2 (hint, hint, Florian... all it would take is to study the mail thread
from way back when and adapt the patch accordingly, of course after
rebasing it to a recent Git revision).

Ciao,
Dscho
