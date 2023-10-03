Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C269DE7AD59
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 18:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjJCSAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 14:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjJCSAr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 14:00:47 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6518DAC
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 11:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1696356040; x=1696960840; i=l.s.r@web.de;
 bh=7Xgpp8AfEQK37+l1BvJuycnYaCV5oM/q48Z1VL+GGVQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=AoidBxVnu3m/c5msmTzZv0cik2G/TK3hE4i5bnY6u9Vch3ZviIFYf9pDImZ2kaIzAUMWDhOf8zc
 hl4d7ZpRV7F3PJ5C37f/jb3NZ6QXl9rXZq24UVxvCetbWcYPW5m0H6H1GP3tWWqtiNufq05S87IP3
 NK7QrpFAUuOfRIevFN8C/MFkPrDMV42BTEmunKpzDM75vslRqFqax9wlPTHbcqlqwLJjKedEfxfFu
 KYVz9J/mxAYV0A0qdzmm43zau/ns8Wu8vGuyjW80Ro4IQIzU46Z1OyT3Teagi3JrhVZRGFdLc7xOp
 78N2FWeltQBvnX5VvtsNbtxfHmQtoFnwOuvg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MEUW8-1qqVf8394s-00GEPY; Tue, 03
 Oct 2023 20:00:40 +0200
Message-ID: <77c42646-2fa6-426f-934e-63b71d6355ad@web.de>
Date:   Tue, 3 Oct 2023 20:00:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parse-options: drop unused parse_opt_ctx_t member
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <ebcaa9e1-d306-4c93-adec-3f35d7040531@web.de>
 <CAPig+cRZ_KzyjWjm-G2qn+t-QA_=CL-tMvTSyZBKrmiHK3RQrg@mail.gmail.com>
From:   =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAPig+cRZ_KzyjWjm-G2qn+t-QA_=CL-tMvTSyZBKrmiHK3RQrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LFZfTDsSCGO2ZAIy3tTTPkj+AEX8n19EJo0e9eD6qUgUVLKlAdf
 Ewp34SnRjYVWYDtAdznmW1lAuNKOtYnfqQ2jwNCFABbEYuMcKT14RfCKiZiGQ3Qk2mKHjh/
 zRWD3L8tRkyQoi09xWHYbxEwTlNajqQ462ZJrrdqFzjiwi2ScklDOulqfWyD1+r73QFyrDl
 g/AeN+4TakrnxD63cfNYw==
UI-OutboundReport: notjunk:1;M01:P0:mPRd5gxa95E=;Szg2HIT9psIK0Ipsh/kSAxHJOh4
 nEwABOwzjoET/q6j58voNO/+495cUi/uA7GEMM/xEkY2PhGnMHyTAxlt9fx0jkb+VOqNwqiAg
 QJ3KDCyEX09ZSueSs6MwGKaDeBDqSoC4hfFlr6rwn29foRx6dzFDwCyKQ4EVhIasyIiYfL6XX
 e1CNQpzUXU75gsSuyWI3IQYcvk1Of45YWLecRbN6DR65b+IxuhDUP5kvunpDmwSgGwSYY4ZAg
 KfgcxABW1bFF7NHJwgTLvHew28ibyUafAcUX6Uay6gIzzMneG5XhbcRja2cQaBJzHg/rYo33D
 LihaVQbl050dccKyu19BcrJSH1q9CFknu5lRzYB4jpOj8fOtWIlhRTp2p6lel595l7ErihzZG
 MlZj909SFCw5B+kInJCYiPPng++updwZ/qNJ6ykANjv908/il19985eAuvhy+0gaHlL3gTkGl
 gQpQMde7dnzbsBqsllft/VDpiIFagIMCoA2/qrgkvdKHiCCXKMCfKXD0iA6z/QUiseGqdTSD+
 b9zMSZpG484hZwyUckdAda5eOjGOKA7t2SEaXx5ZhHmzrnJXFtM6YxTKsPQofzicWbPE3WU5F
 W8VdVsOMlHA+L6QYwSONRjpVr9GSOH1djyz4jogXjcjR6ChmIwYENBIOBx8DxeUiLfkgjI2SA
 mRoYT0fBWyDMIhe2w7fxzcgcyj7b+ltLn/NNf02Aj+/s/MNGddwObhGwJovIqfarJ43iStyIU
 AHRqW0AgYYLZJcieFrnZIHXNuomVeyo7xplse9XwIsJwcHsO5kseontk4maYcIeq0VT/L8vks
 g+f5c0OTOrpgC5HO1lZceFFY8IBK3jXzRQjY2BaPRBvXeJ/viYPq+K+llgURnRDQfsVwY0H4j
 4XmG+Cjjp6O9EGk3UamDEazELIg9xjeFGBmjM9dpiuWb5Z8icenhrXRK02N0E87KDZ/ikRgOC
 MobvhA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.10.23 um 19:38 schrieb Eric Sunshine:
> On Tue, Oct 3, 2023 at 4:55=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> =
wrote:
>> 5c387428f1 (parse-options: don't emit "ambiguous option" for aliases,
>> 2019-04-29) added "updated_options" to struct parse_opt_ctx_t, but it
>> has never been used.  Remove it.
>> ---
>
> Missing sign-off.

Oops, thanks for catching that.  Technically not necessary, I guess,
since the patch is trivial, but here it is:

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
