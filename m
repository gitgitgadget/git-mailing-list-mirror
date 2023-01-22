Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBE2C25B4E
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 18:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjAVSAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 13:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAVSAu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 13:00:50 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC5716AC3
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 10:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1674410444; bh=6n7vv3iW7YmL2wRyWQYnlzpbW/D9FEwhTFdeel1nI/M=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Wvn9C23e3nZKMGM6nmxqWzdJVRZbQ2IiLH/T65PAu3gA+H6n4vm1qHDO0i/7Mq9eV
         LeE57DHiLjbgPcdlLYgTX5d05d648Kgnh9+9s8QOQguppWLs4XBZHjjpXNO6WtMNHi
         47RxyYDZZcKeiBAlKwF4jQWHR0oQ59u1YKqApTNmubHBfDU70ZNzUpBb2GDw6e+U2i
         e1jES/iMLbr8f8H1dGbxXcHEuz4NMXUGrBhqE+MBXrBPEf6eS6km/Aab6WBjyQlFeR
         PlZ5TfYKChL3Ot2nM6wlYj6LUmQrzxUch2P7vFW3DYqv40ScZgUMfcOJNLeRnIrOsH
         T11Ik6d0NKlHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MvKbd-1oSeLq3i0f-00r0xT; Sun, 22
 Jan 2023 19:00:43 +0100
Date:   Sun, 22 Jan 2023 19:00:43 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] t0003: Call dd with portable blocksize
Message-ID: <20230122180043.jfexuzsdiwqraqma@tb-raspi4>
References: <20230122062839.14542-1-tboegi@web.de>
 <xmqqtu0isfom.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqtu0isfom.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:hGJDDv9RtdtVYhL8olsUv+DG7wKRmJPrjgHGOFdN2WMhu2bu0uz
 5WryBG5aCcIyuusF7XpbQaPsMLDXX8JnSZoSEpACTfbnX4Nzk00iuq4fR4xxw4pofnIEjCH
 LeTWUY9ECivAOsL91E/ss6/pZeYXpgJs3eSrepl79YmY9iTzN2tAQDgv1fI5boRC0nHHE53
 rQfdBeo5V/gAA/E+v8mwA==
UI-OutboundReport: notjunk:1;M01:P0:oW9kSnxsx5I=;xTJXzPpsu02s17P0TOs+8JPK75F
 9ZXFZljjkjX1So0k+yFW/ptykhj8rXQD3sKnol/jFEQ7s+apg8mkgrfNKwj9lrnv3PYeqEHhg
 Nlb9dzWjWAIMb/Npgv9VdU5APZ/NzqZL+o/v1v2YqyvVEb17PYxVGepa1+GR7fPePQabgkTWv
 V3PTvvkxXorMKyAZKzhvmJOd4DsdPO09XZ1N8whOS9CiAy16GuMpqalkgXRRi4T4Eb6jbD5Cp
 VeEGbA+oHIm61B/DR9iTO6KdTywP2d5zqadQqL7KG0KI2oQmNWiudPGxX5SmRuErVAkHUxWk8
 FND+7K6hECI75vP6px7qqcL12nwkpQdtfCuWSWT3nlBBho7RYHU3jaH3jF/+3YtecJNVWeAyt
 GjP5HMtZ0RRZRmiUJ9fHEKWipvENGEG097FaYlUVLJ3zHaqO2hRfnt5mkxJ6S8sBs9h5gurFc
 mioQri25BdX0tvT+CwF+RsswvOUDMNRYmBC700UF91Lz3jC68ilEUfitfTgqw45+VjraWbxtq
 7GCs6FR4YS8q8Hc4Tuf04afVZJG7noPsJ10CLABGA3hms63P3czlEmHicPWb8oOZ/sOqn8BWO
 tUcCJLPQ9ZJtEpU/93QDRQmDp9ArZIb4uJSCTbg6GRhwvAifqzE9TbGnVNFC38I7Te/2WtkxQ
 85T9nJYnHJipdzC4GO1f4Fvjaqcyr4HO7WUNPG+uRXnnTxF/szB4lnD6wFiVrXdrclzkXNwMF
 q4KNroS580RKACdMW1vpFj+P5gIN1y8CxxkIbd0QNHP+xQCBuJ66dmOmVUMCSMyR7Xle6T/SA
 PimY1d0zpjZquRd+8UhKW/kFaUh7O1mZuaB0qKMrFgFbuIeCnuD71BAjJyyEIdx8+iPk2hiJA
 BX3iLngkRZklnOnBP1Kl4LyLAuGyvuwS9juiiGwppcYIM8XMCbrHFc7Wv8Ne6xW7K7XN96ulS
 yrUz25Z1GxlJ64g2KHUWn8H0xjQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 22, 2023 at 08:21:45AM -0800, Junio C Hamano wrote:
> tboegi@web.de writes:
>
> > From: Torsten B=F6gershausen <tboegi@web.de>
> >
> > The command `dd bs=3D101M count=3D1` is not portable,
> > e.g. dd shipped with MacOs does not understand the 'M'.
>
> Very good piece of information to have here.
>
> > Use `bs=3D1048576 count=3D101`, which achives the same, instead.
>
> I'd locally tweak (read: no need to resend) it to
>
>     Use `dd bs=3D1048576 count=3D101`, which ...
>
> and downcase "Call" on the title line.
>
> A tangent.  I wonder how portable
>
>     dd bs=3D1024x1024 count=3D101
This works all Unix-ish system I have: both on MacOs and FreeBSD.

>     dd bs=3D1kx1k count=3D101
Works on FreeBSD.
Does not work under MacOS: "dd: bs: illegal numeric value"


> In any case, thanks for the update.

Thanks for the review and the tweaking.
