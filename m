Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCD4C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 12:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245702AbiAJMuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 07:50:15 -0500
Received: from mout.gmx.net ([212.227.17.21]:41043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245698AbiAJMti (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 07:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641818955;
        bh=CalKF+FyWClaR/sQOt7+53lTyWGteExqy7vJpa/tayo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dQUSpZAeG3wL7DMls7cSjRv9y2rlzuUrw0iDHxmnIJx3BMpyWLnrSXDZBpG3COjCq
         VEdeskgyhQNIXKixPjrylexk8rq5zmzsbcGbxByoOozFvLgoVbu73uZnVV82dUvLwE
         PKT/KBgO0jgZ3HypMnvXIYLL7ahNDhJzAxjHQUF0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.133.218] ([89.1.215.56]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD6g-1mU0ev1t7C-00eKc1; Mon, 10
 Jan 2022 13:49:15 +0100
Date:   Mon, 10 Jan 2022 13:49:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Teng Long <dyroneteng@gmail.com>
cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 9/9] cocci: allow padding with `strbuf_addf()`
In-Reply-To: <20220110082254.54400-1-dyroneteng@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201101346090.339@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2201071401240.339@tvgsbejvaqbjf.bet> <20220110082254.54400-1-dyroneteng@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:U+z05lxUIZp9ASikHxC/OrmI5HG+3BfOuzSL7dBGCXrBKe0g9vi
 SA8G1k/HM4Wdu8khoPgNJAS5CYTSXNxh3WboG+0U5ihKf+5ZZshLnMED92awuNWCfhXmkLx
 sVWLrrdHtUiLMmznGsFwuHNuc4DXV5YhyZEqKDrRfMtrJHChw3HfRXeQr8U42xH8wMnPH8m
 uw/81gwwkqotlGfDHAKSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CWAbLMze/M4=:NA/Kh3rYKmZetMzVRsmllM
 pvQCYtWlWFsSHxxXNM5Iibnw6VntkXYqWonkLgKLuDLehtP0LcAK2Y9Rks7USYRqfRXlI5EC5
 4Ey5q5gdFHwSIk3dfIRljujPdLBYVdgDXjtTvjXqy4q8xmTvlDTBTYfj2ueMLnyzLTVSy99J5
 Gb/nm/BzutPaN8L5eorIbMxp8bQYMO5zLtXL9iFdG9h54DVm7uQI3EDh5JsZQclm8A4OpZT26
 1oMHLA75g+kPOlpDj7OA5scOd/6saJgTwtxc+ySANDx0lw2kIXAeGH6aPTyisehdM8bhFd/Gj
 UrNaHOFo4pAGBWqYuG2QEavGY7H8MXSEI6gSEvVhwcxwxos3dBfT+wNEVaDxnzV2rtNXFAcd1
 wrIkLFdhugxJx7UiGIHTuNeVU04boN96M3+3PNfzEfLYWwoqv5nPkFTQTTKabqvLbReqEKSBC
 4d/hdTPPskwKD9px0Zxxrb4JPWZdG/BnTdOFx94J3SM7kyHyx+IVeVQap26Mq2uHrhO5dr9j8
 fZeaA8sNWNhveX7x38BAVJtL0tQsrwXAeGN3Hd2ds3VsgjyCmrDjhtPJBfDdeY11SYkHQvwG6
 2yfNhOmT3diCzr5H8vG1y7Ajony9tgzbEcHaMMIodwEQttL6RkRBJaabD4kIO2nf6ydKkgvFC
 xpTnJoHdrsIp9I/10+cirREWaR/GGqpgLf/UZ4FBNyPTAR14lv/00yw60n/NAQYMD18LAQnBq
 cFDmykAeH/fXekrWBwaBvDJkl6ihJbrvaJK4O232DwwAX35eB6N9tGzY/vI2TH1YtB4Y6YvUx
 sICwQ/l5kNDd1h+1DPMW44NxkH30tQF1XiRSPJSU7Vp0hhej1gIlFl+WpP/jTBufdQ2ptj1Cv
 7D5fUpZtmb8Ofhmo1twGPjRTz8Jip+r5UxiNej74ZZ+d3W2hOBh37BGpV9fUK+g+B6S4HPqPV
 kwaAxHbFNvQ3UVDLJO/BpA7i/GgSvvKpc4HXK1wKiURlqBkPoTKTy5yM3KvxR+wV9zQG5FCdx
 zMkDy5nU4fJjN42egOHyeGkyDUuWA11HccJ48EAXISqjWUkb0dy6ldo5uq9//65dUjROhSaGz
 ACB55igCCqh06Y=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Teng,

On Mon, 10 Jan 2022, Teng Long wrote:

> [...] about the using "strbuf_addf(line, "%7s" , "-");" or
> "strbuf_addstr(line, "      -");". [...]
>
> Why I prefer more of the former that is because, for the single line,
> it's more readable I think.

I strongly disagree. Using a format requires the reader to interpret a
`printf()` format, to remember (if they ever knew) the rules about padding
with `%<number>s` formats, and then to satisfy themselves that the result
is correct.

That's quite the cognitive load you put on the reader for something as
trivial as "      -".

Not a fan,
Johannes
