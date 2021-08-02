Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A44C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1EE66023E
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhHBV4Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 17:56:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:57385 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230313AbhHBV4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 17:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627941371;
        bh=S/KgPmGIWuvbdNNsw2oE26BazwBynCD+90rMo/G6pFk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dnxeBGr1O9aFUdSkj0B1FafjDLL+fgm12NI3996ikRmO/bNm9/KJ2KAZg+65XPCsu
         AXwOwemLy7RNYWWFXBHlc4JdNjBVCTisJabncRTDdDDygP5J01R4RiiCQ7v11xPT3z
         5h2lWVqdH69wP8Ei6AMmOs1QX2V8CF+s2xkQv/6U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.101.220] ([89.1.212.168]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7i8O-1nFH1E420A-014mXO; Mon, 02
 Aug 2021 23:56:11 +0200
Date:   Mon, 2 Aug 2021 23:56:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ben Boeckel <mathstuf@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/4] advice: add a function to set the value of an
 advice type
In-Reply-To: <20210731022504.1912702-2-mathstuf@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108022353110.55@tvgsbejvaqbjf.bet>
References: <20210731022504.1912702-1-mathstuf@gmail.com> <20210731022504.1912702-2-mathstuf@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:65KUw4K3fBUcB5VIQZyU2Tdwr10gHWxJElPYAQPck7/fV7cy1F/
 gEmtPR7b6+orDH3Ubd9fHExT0N+yfYNXXoLudzGuMaIc/1x/Q/qUip+dHhWSMSctISA0Hy9
 7YpIlqmlBGng5DxPoc57mRS5ISMyodvkWOehgj1T2xkFusFZtsHqml0Ay9NDQ9uT+BzPi4B
 RQsPL0I2q+NHDZp9sSMrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wsCoenjNVaE=:kWGQct/Z6+fRygN9TTz8V6
 nf3ZjKITu0vfYEGfkq/CvGl8ARkINSSckXoOGJQoZnuvnwUaloIi89xw7nfb6icQgw848wspf
 8rtzUTiNk2FKGL9XIWQp0T8kD/9EaxWgJJbResRRJ94mbyJO6nNQpMs+I0XTLUTUDd7OhdIRc
 qmR0EwYmz1oV2Gf0AepcNSVPjdvv1qD4CQEJ4zGvBAqpNu6Rw7ThJKIEmOyAnfAzawW1c5y6k
 OOXyi0rMSvGoCaro5Zp4iLHT+4Go179GaR+At6+zeLomf4LU42swtsu8JfcFKzeDmIDl9lrer
 ifdo4Fdw3+A7M+pTpT9D/Ql6fHWx274dTs0AmgOL8XCJIWe0wDWloRitegs54t6qBnaUNOkqw
 sficbQd0PW892rXa4dg0MlzizbEU2rlykygq0lR+9APvmGmmZi1kNV8gwCL1gQ1XfCd17M3R3
 pvT3K5q/ehX2DAsRCVFEOB5F2Mf9fs8FphwbuCh0DjPlORaRmIlu/vvnVsTKhGhe0WHmIIvTJ
 uuWpM3lFKsP5KZ8jky55mdm8TvZbGmUZjN9vr1lLaiKO1CChg3YXdCLQR9r1wZ0l1Ov7jT9r2
 Tkj5+zq01moa8uqzdzulBfZXvHICSM2PKqgLQmmKEV+0PShaomM5NZfGbFmoChlhyjCLl6cV6
 sUJBsvZkLjUSld+PJWlJzaP7Fw0NlgC8yiYfzLdkWOLpg11S+phAWuSalqcbQ79mYLthVM8Tq
 u7vc6o8xA1Q/E8k12yfHO3YYVbbqMdZgko2tt1anNRdxl9EKgIrCvlcoEZqs9YZfnGXStgSa6
 1zivCpKEQ6bYd3hjSFBxm/QgHea+IE6lOZTky0OPtSIXOXF1g3ihO59qgwUzisMpKE6gdnQ51
 HWxmh+STSUXrIhd1R1UlTipwY4OhNax8I9mREw7YrUn46/XYCWDDRYtvW1R94DFJigczcH99k
 zZUMEQcyy9RUmeTtxjU0d4FnGacfQSOQ/wyctcpQJHcUCdYAsdj3hWB0WZxwroloHP1t/MVRh
 bVUBEWkIdkX+58O1Qt96FcQCRkLJP4nub/aRMm/du57WAWXuuFZppzotZ2z5CSTz996CeAH4M
 ZR5n16SzbcFZbc6ExIHLN1aeu9FActMTOWQVQs+slbVeDPd6as1ABUz7w==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Fri, 30 Jul 2021, Ben Boeckel wrote:

> This is setup for removing the `advice` global variables.

The idea to separate out this patch from the rest was probably to make
things easier to review.

However, without any callers of this function, I find it pretty hard to
review it.

My recommendation would be to move the addition of all the callers of this
function from 3/4 here (obviously without removing the assignments of the
global variables, that removal should stay with 3/4).

Ciao,
Dscho

>
> Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
> ---
>  advice.c | 5 +++++
>  advice.h | 5 +++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/advice.c b/advice.c
> index 0b9c89c48a..fd58631dc1 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -187,6 +187,11 @@ int advice_enabled(enum advice_type type)
>  	}
>  }
>
> +void advice_set(enum advice_type type, int value)
> +{
> +	advice_setting[type].enabled =3D value;
> +}
> +
>  void advise_if_enabled(enum advice_type type, const char *advice, ...)
>  {
>  	va_list params;
> diff --git a/advice.h b/advice.h
> index bd26c385d0..74425a9f1a 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -87,6 +87,11 @@ void advise(const char *advice, ...);
>   */
>  int advice_enabled(enum advice_type type);
>
> +/**
> + * Enable or disable advice of a certain kind.
> + */
> +void advice_set(enum advice_type type, int value);
> +
>  /**
>   * Checks the visibility of the advice before printing.
>   */
> --
> 2.31.1
>
>
