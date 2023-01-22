Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8505AC54E94
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 07:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjAVHMG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 02:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVHMF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 02:12:05 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8248901A
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 23:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1674371517; bh=Qz//dZGe71FT8X7f/tStIej9/tJszrt1lQ3PJ2r2K/8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=eBFr2mYv52hPfK9XvJE3aFXmLY8G5EEk/Xv9C/Pes+Dht6Q3exqe/x0MY9fUUQZew
         ihCZF7dWdizvvadf8dpvDrbe1UDhN42gBcWiXtPpsULEa27L0X8LSO/lTcv6IhQrZ/
         8XGXPCbBTvZSj2VBaR9OHBMKW8qZY2D9kiCeNXdQnQBgSL0O+jqmgtq+Td7Ugd/OOb
         tU0PTCyISRoJhKUjYUbFbh35Y+VDfcH9qQ/JPLCRB3lxx0xHaEZa9S+q4532bp/ufG
         ZCn0zvNTruGTdaI59k/VPqjfret05pIGOGA338+Lk9/1pGkdgGYaCjHr3GjoRoc2TW
         tO8lw3SO5NmgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mr7ek-1ownGt31z4-00oFHu; Sun, 22
 Jan 2023 08:11:57 +0100
Date:   Sun, 22 Jan 2023 08:11:57 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] MyFirstContribution: refrain from self-iterating too much
Message-ID: <20230122071156.367jwwt3d5txvkl4@tb-raspi4>
References: <xmqq3583uyk0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq3583uyk0.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:GkFMK8HrsA811ZaSppHosEmokwLu2lbu4imcQzXiJSPFV54EgYl
 yoNrrRxU0JWn3FV8jfI5m0SbsKKuLC/ocH7/kvsQMFTqiztvfrWqLvf5c5k2F0DkrGCAc/k
 TqRyN7ZJbKT3UrFIM7y/qtOO4b2BELfLhWqOEPFl4IOS5gU6N3n2IVqx/xjiWXk1alcl2QC
 6HWB3UEQQbk2cmd/uj3gg==
UI-OutboundReport: notjunk:1;M01:P0:AMFhDF+s+hE=;vFwNbQJoiQuWi3h7wXfwx6L5khP
 ioG6J0POKvABrLEtRZ59k/YakBa1S3Gy9YSw1DrRi1Ux5ejwhV/pH0Kxso1UYtTZPK/p2Cpkx
 GpzD+vZEQ81Hm0rdTD5tjU+woxsm6gXBuJVO2410LWd6kIzeMF8BRP6PuSip5kW6n/r5fdp2V
 zTiqFq0PU7LYTTnG+R3vdPXbMZLb1G/1gjEY/e7geXa5dBHqBGeO5Sqe3S8AT4KXdV7QoSvlH
 jHb70FKhrrxnQdIceAzogYspm59ewMcRgrPEkz0StXJw/J2MsOqk1ZPWE41ACXRUNbXJ2v6ai
 9oJtBFBVWEP+JqbRrbbopr1wImqJa0LjEGLuVf7at42XRGv68gSOhUav1DgJoGyxihbHI2fXP
 aPkKHNzz5gdmCoqeTPjeA7fwKNy+ZWl9wcOAby8y123dwHRNccR/BzpBulTFo9LFIIVHzyZ2l
 wxZlB1UdcG8QpYRmTtHsIIoz16rLr/URkVYLBW3FctN/JcTYnJXGoAoHpc4QKzoxek6MHPw48
 Tb4t76kmpjmdQCYUgLvxWnXGgofbwOJfrxdAhqQv6ge3AeLyTVJ1KVfuAkYN+pqg0CVGZFMEB
 GnfxSclrXO7PmVdbAD8WcXCdiR2yXsp1TfZrivpt7ZdSsu5Xnlym9tfs0LM1uJjn4hDEEMVaX
 YurVYkvMJZX6DQZcCEN+dr90Gr+fD1vDdlshdr7RO9Oh2bR/TLHWqkyhlIcYnUkus0BYHH1j3
 kkIVucA50Kjrp+yVJqPor9Q/yM6IU5pRhvf0w64EBj+gMa1Gf5gKNp7zZZCxq0PSx9/Dlcxra
 +8L/BvG9deNJwZHYindwDlCfku5+mx2M3h6H6O5G2jRVPsXFYRzpeuV9ocSn/JSfqb+FmlcSA
 ZPcQ75W8TGmnRt8vqec/gJTJDknz21DiCm5RMbO2ItNI9D883pt+BaFmGgDoVV/QBkLBCHTwz
 TG0ijzKyJv6T8uH8QA1457c4k+g=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 21, 2023 at 05:51:11PM -0800, Junio C Hamano wrote:
> Finding mistakes in and improving your own patches is a good idea,
> but doing so too quickly is being inconsiderate to reviewers who
> have just seen the initial iteration and taking their time to review
> it.  Encourage new developers to perform such a self review before
> they send out their patches, not after.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/MyFirstContribution.txt | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git c/Documentation/MyFirstContribution.txt w/Documentation/MyFir=
stContribution.txt
> index 7c9a037cc2..81dcaedf0c 100644
> --- c/Documentation/MyFirstContribution.txt
> +++ w/Documentation/MyFirstContribution.txt
> @@ -1136,6 +1136,26 @@ index 88f126184c..38da593a60 100644
>  [[now-what]]
>  =3D=3D My Patch Got Emailed - Now What?
>
> +You should wait for your patch to be reviewed by other people in the
> +development community.  While you are waiting, you may want to
> +re-read what you wrote in the patch you already have sent, as if you
> +are a reviewer who is helping you to improve your patch.  But resist
> +the temptation to update the patch and send a new one, until other
> +people had enough time to digest your original patch and give you
> +their reviews.  They may be taking time to give you a carefully
> +written review responses and haven't finished it yet.  Bombarding
> +them with new versions before they have a chance to react to the
> +first iteration is being rude to them.
> +
> +Of course, you still may spot mistakes and rooms for improvements
> +after you sent your initial patch.

I can't resist the question: After outlining what not to do and why,
could there be a hint what to do ?
It may be, that the author justs spots a simple typo, or there may
be more heavier changes to be done.

Should the author just respond to her/his patch as a reviewer does ?
Like:
Ops, there is a "typax", I should have written "typo".
Or:
Re-reading my own stuff, I think that things could have been done
in a way like this....
Lets wait for more comments before I send out a new version.

>+ Learn from that experience to
> +make sure that you will do such a self-review _before_ sending your
> +patches next time.  You do not have to send your patches immediately
> +once you finished writing them.  It is not a race.  Take your time
> +to self-review them, sleep on them, improve them before sending them
> +out, and do not allow you to send them before you are reasonably
> +sure that you won't find more mistakes in them yourself.
> +
>  [[reviewing]]
>  =3D=3D=3D Responding to Reviews
>
