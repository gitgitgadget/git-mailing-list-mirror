Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB768C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CCF960724
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhKASj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 14:39:57 -0400
Received: from mout.web.de ([217.72.192.78]:35681 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232179AbhKASjh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 14:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1635791806;
        bh=YhNcz1eU59a9OY1/lkUlyIxthtrOuAtADvDDd6BuU98=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=j1JB4oXsOLsS+ZaEXLHJwpbDDuH8AQ/ijmxQIhoU0i97bYBqdHBGG6G64wZrzKJee
         Ro4Fk+OBsLEpr8vzaS45mdbtmwpowIdDLG52L329PCIFpSqrONZeCFq8SkaqblPmgm
         yDRP0fUaF6COywI2CRKjMLkLFELuYhaHiynzW568=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MbTL1-1mB2JD3JcX-00bVwv; Mon, 01 Nov 2021 19:36:46 +0100
Subject: Re: [PATCH 1/2] gpg-interface: handle missing " with " gracefully in
 parse_ssh_output()
To:     Fabian Stelzer <fs@gigacodes.de>, Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <f6fca7c0-079c-4337-23d9-cd970c79b8ad@web.de>
 <dedf3971-adb1-c355-0b05-4e94ad92e1f7@gigacodes.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <abc4c174-f848-a0f4-3f1d-486ee8f275b2@web.de>
Date:   Mon, 1 Nov 2021 19:36:45 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <dedf3971-adb1-c355-0b05-4e94ad92e1f7@gigacodes.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a20TiNdlX+X/wxL3pESfaxk+vj9gDEqnSHt3X2reGRPu8W46qy2
 cwEuNHvuly883nV4WGje/KopalKovf41cJfh0k2+2xbmbROT+ZFhVLcxO9r84H2whP94YXU
 wx79JL1psUV4iuB9PsN39RdDbHAxnNb5mIGUOXvXbtsnrlMLk/dIWGAx5BVHPKpFGBZ+Qva
 xpbig2vn4sTAGSie3qMUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:huEWPstuqUY=:mP/MiYqiGHfN4GTREOTzDB
 +IkyjEZY9zVEg2CxGRz/XODR7oYImBMQGME2jlDoGrKeDpvdhARlFOwbqFayyZ59LyuJPLhw0
 UdznP/RlwH4f/YPfg2MqZOmZt4pzXCW+6yPiLRUcy+TUgZoWYRmEdStCA0WO1hC0rRW51oCA8
 PjVylTxO7zGsTW14s0updvVN0wr9ydoW+XHJCkYmvLXOORBbWe/4I86cgun42NeFeWXolMZvd
 xiEazlZN56kJdN7ZzzwZWmtrljsZNJ6zrnIS6lE/h5XqQ+Bg6zFU4k55WB+v3PSWuINB6F6Dd
 AP6z46eBJmtAxXEUw1vbmbGKo8nrY3Ljjraz3A5ozwZ5pAhrrxDb/ur396vKnNx/Y7oFbyOua
 3d3HKhKOyGzcWejpdEsF38UPBYIRVWqKtbCccMPT9V65f5dOXMM3ovKtHHMBIgJTlpq6+bajD
 niZBE2XAKq7lpI0lXGYuGy6iGPf7ir2OozBdt3dGI/eIoTl8mTNHXzXzVccjG5HAjOa5AnUfX
 p01au8t44UR6PRLg/b+5CZr5yjpfs1bICBTpbNFNAWDb9BdEGWLQWj4N0ZOh90DiRfjdmLHvp
 1GhGmaPJBWtPTNOxSBcUD5hx/lRmibDXmXIyqW8d5REoehqX5zp3l9is602XrJR7AHnfN6ZKR
 GPUqbQ87wSdN9wD1nbUa7D4VLkH8c4e8lw5QAnGU0J92bg4vsBqnXPWnSk7eHdVZImx436Gwx
 Hl7SwCPB6VsB4+2bggdOXiXBCJDlMrqYiISkWPwlGFKMBBz3ZY8Ji4oUWhbMRVRHNYs5ec5AX
 l/U7CmrPvmHwhm7QoKPTAB+kXFy1/ICGS1NhZFMZX72IMzn6J36lPn5jVbKJ8D1LoS6jioM7z
 BPr2bW0SEcBfb1TzMbDRymGNRryREJJ+wChpw5y5X7retZ98N/QyNL2cJ7Jq0E6pnEGUBL1LL
 rXySmDT1T3BlDoUW5rJuLn+61A+Ybc/3qkx9rk+9VmwFJVd4v8ExIh326Pvm1S9ScbOGnh0g7
 PEHo24RSRhVHxpOsFGKZuGnyqH0iNw54HTCTV3sR5QAMnLhw+WNDMWMx1mcP7IiwGw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.11.21 um 09:40 schrieb Fabian Stelzer:
> On 30.10.21 19:04, Ren=C3=A9 Scharfe wrote:
>> Silly bonus question: What's the purpose of the "+ 1" and "- 1", which
>> seem to cancel each other out?
>
> They do. But only for the xmemdupz. It is important for the strstr() to
> skip over already found strings (" with " could be in the principal name
> as well - multiple times even). And doing strstr(line +1, ...) can be
> problematic for the first iteration.

Ah, right.

>>  		do {
>>  			search =3D strstr(line, " with ");
>>  			if (search)
>>  				line =3D search + 1;
>>  		} while (search !=3D NULL);

This can be shortened to:

		while ((search =3D strstr(line, " with ")))
			line =3D search + 1;

I still would have tripped over the +1 / -1, though.  Calling an rfind()
or strrstr() or find_last() function that deals with it internally
would have helped me avoid that, I think, but we don't have use for such
a thing anywhere else.

Ren=C3=A9
