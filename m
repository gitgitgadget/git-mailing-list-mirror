Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B534C4167B
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 08:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiLQIed (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 03:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLQIeb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 03:34:31 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0443E0AA
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 00:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1671266068; bh=8cQQZZVEtv39+tFOuXywlb9NOWSPxyt/kb6/ivCCLJE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=tX244BTKnjh3oPB2zkERh+1R04X+htBwnJ5zIQvfnPO5nQQsj1EAIkHG3LmlSX1mN
         DPjtGxWt64LcR1eNw83UvFyrR7pidixXDaRf1h1I9ZjOwpt0O2B6BlWHQaD0qYpsZO
         226vaFVyQpeFbWtAJC4mjclOYs7Vtc6/zOWIrDYblnA0KM82xnUfvYWDpgNnrQLX/u
         mz+OEi+xCQQsKtFJObiDqoZsHo/AQjKs1ntCFCzIcjkqAiWI78rpigZHcqfBqWnOEB
         0DeApIabSI17irVshwmgFd8ruyMVphSaMzIDOAvUhrECunR0LRsISzc7vw0R7VBz0J
         CWVnzGVuusLOQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbCDq-1oVC1b3Zs0-00bnPL; Sat, 17
 Dec 2022 09:34:27 +0100
Message-ID: <18ad9fae-2afd-4315-c65f-d9bb92fa30fe@web.de>
Date:   Sat, 17 Dec 2022 09:34:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: Issue with git > 2.36.1 and pre-commit hook on macOS M1
Content-Language: en-US
To:     Piotrek <piotrekkr@o2.pl>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <51d5993f-a1e0-519e-ffa9-ec5205c5e96d@o2.pl>
 <30f80aa4-d5c1-4fce-f1c9-710eabeaa022@web.de>
 <c07a5ac4-3da6-6fb4-4586-a83373bc05d4@o2.pl>
 <7054faf0-0f5b-e4a8-3166-bf715ed45a32@web.de>
 <a1fb9d92-5161-5ba0-54f2-a03cbc45f399@o2.pl>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <a1fb9d92-5161-5ba0-54f2-a03cbc45f399@o2.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rwLcecty2EZ8H5hFrTOCAvQ9Zi3n5TG5Fi/sk6WABfjXOKWAYkq
 86idWaoVp+0Ubgbbbps71Qe6kzM1LhsGvmMP22Nmb5yiFZwaR8TrkZU2A4XouTL9LiNIwlV
 w8uT3Stbrb93YmbGGaXCkS57EGY1jtlXmGl15qGXJEjRfgGJ4Lw3gRZ3D2i/1xTrzi/hXnP
 IOljbpYnymp4HrNKp7diw==
UI-OutboundReport: notjunk:1;M01:P0:0WRPXSWt1es=;q2iH+ahCEMpu42faVp7yQRSikjC
 ovTEAJ185+i3hJh3Ay9L/+G6c2W+IdvRPhsW0aAbeuJPK9+e41yDVV2Y0YY5Pq1TIfj92VeSC
 hzYhUYQvhISOap9tFCKcwGk9zqP6pDWPe3EoAbQW0GJjaoFklIakv9kTFOqyCXr7hACFkX63z
 LTGw9dPaUjNnyVBleparA8aodB9nUc46sVmgEhKwxU2P1ncBdopH5uZQo1+g+88tkZkxCf7qG
 qSJXKwZhPXLKcTudHJVDyT3RlWkr+aCvNLVQwn3r2OLv0SImnZRMLUSBAunAtKllORf/TivYr
 Qt3jjPnYg7RkMtwi/k2LbatYJRnh2Q4aXEnBcqNaGELgqwpV4kZ4p8byvH6Cq8JzcG60jcdJn
 FT5/Eu8rtoQvhrFwhbRm76vS+Kak5MMBGeGiXYkp4kzZE4CAVMNL6bfB2Vy7OIIdaMQWwSurJ
 NibHy4IMJSdd+BFGGySUOSdcBeY3a444W4/NnHYpiYv86h8br9IfzSZe0WIJnXyp3o0+/vjzd
 ozMJ7WgvPrbsck18jiKjv8VJWN0KpYjRL13rc1tJPrAxGICS9UryYUSRbDTOChsr0Vv9eX7vG
 eWhL603DxSaqFG/o/uMq+Ywofs0q5PBLdHiSZJJXfErCCq4NIMyz8Abyr5UDT5AqtgAvL5gde
 56t8ZBk9fZRN+N0MC3YfWe9OhYDST/r5YUjhLnFzuK1LETniCZib8oZCUpUcC2GNTaBrqXWFF
 K6ljRZKBNstsR1OSvmmOwG/9bGO+fuxXHmjQxJs2k3Zqw/Ib6zXfbTAD6TV+3RJ1jFoNIWQoD
 T5KHBQ5RIG7XGuqTubspSfZL13I+RapIdCe7DBs6kZI/KWp+x+lltre6GcK1SDWkIJ8ljIhCN
 ZUDW0PGhwG+joPAlx9m5oIoSbrW2JidG8r/XloF7dvF6F4Rze1NrE1TnbYdlfqVHZxv0I5+xq
 YOBjyg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.12.22 um 08:50 schrieb Piotrek:
> On 14.12.2022 23:23, Ren=C3=A9 Scharfe wrote:
>
>> Curious that only macOS should be affected.=C2=A0 Is stdin of a hook sc=
ript a
>> TTY on that platform?=C2=A0 Or can "docker compose" handle stdin not be=
ing a
>> TTY and stdout being one there?

> Well, seems like I somehow tested this wrong. Tried it again from
> scratch and on linux I also get this error.

Ah, OK.

> Docker compose CLI options page is a little confusing because of
> these:
>
>>--interactive , -i=C2=A0 true=C2=A0 Keep STDIN open even if not attached=
.
>>--no-TTY , -T=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 true=
=C2=A0 Disable pseudo-TTY allocation (default: auto-detected).
>>--tty , -t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 true=C2=
=A0 Allocate a pseudo-TTY.
>
> Second column with `true` values is titled `Default`, whatever it means.
> So `--tty` and `--no-TTY` is set by default? Anyway, seems like it is
> checking if at least one of stdout, stding, stderr is a tty and then
> tries to allocate a tty to all.
>
> You can check docs here
> https://docs.docker.com/engine/reference/commandline/compose_run/#option=
s
Yeah, having the last two both on by default seems impossible.  Perhaps
the text in the parenthesis means that "default" is actually to detect
TTYs automatically?  In any case the help text could be clearer.

> As a final solution I used makefile "magic" with `ifeq` and shell comman=
d like this:
>
> =C2=A0=C2=A0=C2=A0 $(shell test -t 0)
> =C2=A0=C2=A0=C2=A0 ifeq ($(.SHELLSTATUS), 1)
> =C2=A0=C2=A0=C2=A0 ALLOCATE_TTY =3D --no-TTY
> =C2=A0=C2=A0=C2=A0 endif
>
> =C2=A0=C2=A0=C2=A0 docker compose run $(ALLOCATE_TTY) --rm --entrypoint =
"" app /code/test.sh

OK.  Would be nice if "docker compose" could handle that case
automatically, though, wouldn't it? :)

> Maybe I'll just write to to them to clarify documentation on how
> those TTY options actually works by default.
Good idea.

Ren=C3=A9
