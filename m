Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72D741F667
	for <e@80x24.org>; Wed, 16 Aug 2017 15:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbdHPPsv (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 11:48:51 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37875 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751588AbdHPPsu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 11:48:50 -0400
Received: by mail-wr0-f194.google.com with SMTP id z91so710468wrc.4
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 08:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=m+k9jvCGezcREBYiah4RthhapIqKWSl7IdUdfAu7580=;
        b=LAmaayrOh1zoYy4SNHizD0XFtTMull60qr5UEe6+hURJE0mS4AFa8pXYYZ1nDbbd+T
         BgKPf1OAsPwXPhIzInb930zWhX1rcQgmc/CJlULNB9UR4dQvpChIPVUInGmIFyY2I4y2
         gxc1ea1MIK4pu0/ovAsA8kqMBa0FIPOcCe04UUjRst8l89rkfR1Pbn6qoWsZnmbaB/7s
         qmKUdhiY+e4jAh126sqPdNL8LBr7OfvY2GiSv++oJJoOm0W6T8EG2lkmKfzL+R/9oJs5
         ZdJjoXR8TSoPLbYF1/5BJuTMUz/X9+hBLjjKB1pZSRpEtPPx/wpo/sf2KnLhI8yTmBWZ
         k2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=m+k9jvCGezcREBYiah4RthhapIqKWSl7IdUdfAu7580=;
        b=NfPUrlGGegGld/D8IIPlPfJP3alJ8KwP9hsQ4iO/G+czTFJhNIfTw30c6OLrnhokc2
         AWuKU8EmU+b7ay5AlRUQO+gwrLwIEwxC7q6WAkFe0/w8KzQrDls6vVl2zNzM0XvraeTf
         +xDIaacKOUhE0yFYJqT+6XF0GrpseE8w8HWL9yBp4vPws28RXtdXPkc5fKgUWU8olMiA
         y/z4AFzQMpqI/cmXZC4VLrNrRg5lpklDgZ3wfqhjWTDEfoOICp6755XP+PjfOsD07/AC
         hI+04AnIPeXLoXwAJNKUW5yHbHe/tOr1bMOxyXpbvmks/GQMmR1aIsYZam0wufCW3Qy5
         +Zyg==
X-Gm-Message-State: AHYfb5grXooDZ+Xlu5r2CAQiG77lFJKc5dYRd7Ijxb1ecpKlPn7ra++r
        r92vGKtQE6FaFA==
X-Received: by 10.28.26.5 with SMTP id a5mr1735313wma.80.1502898529619;
        Wed, 16 Aug 2017 08:48:49 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id m15sm956576wrb.85.2017.08.16.08.48.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Aug 2017 08:48:48 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] sub-process: print the cmd when a capability is unsupported
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170816124036.25236-1-chriscool@tuxfamily.org>
Date:   Wed, 16 Aug 2017 17:48:47 +0200
Cc:     Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C7814B93-B103-4D77-B815-2AFC1A9CB566@gmail.com>
References: <20170816124036.25236-1-chriscool@tuxfamily.org>
To:     Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Aug 2017, at 14:40, Christian Couder =
<christian.couder@gmail.com> wrote:
>=20
> In handshake_capabilities() we use warning() when a capability
> is not supported, so the exit code of the function is 0 and no
> further error is shown. This is a problem because the warning
> message doesn't tell us which subprocess cmd failed.
>=20
> On the contrary if we cannot write a packet from this function,
> we use error() and then subprocess_start() outputs:
>=20
>    initialization for subprocess '<cmd>' failed
>=20
> so we can know which subprocess cmd failed.
>=20
> Let's improve the warning() message, so that we can know which
> subprocess cmd failed.
>=20
> Helped-by: Lars Schneider <larsxschneider@gmail.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> Change since previous version:
>=20
>  - Use process->argv[0] instead of adding a new parameter to
>    handshake_capabilities(), thanks to Lars.
>=20
> sub-process.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/sub-process.c b/sub-process.c
> index 6edb97c1c6..6ccfaaba99 100644
> --- a/sub-process.c
> +++ b/sub-process.c
> @@ -184,8 +184,8 @@ static int handshake_capabilities(struct =
child_process *process,
> 			if (supported_capabilities)
> 				*supported_capabilities |=3D =
capabilities[i].flag;
> 		} else {
> -			warning("external filter requested unsupported =
filter capability '%s'",
> -				p);
> +			warning("subprocess '%s' requested unsupported =
capability '%s'",
> +				process->argv[0], p);
> 		}
> 	}
>=20
> --=20
> 2.14.1.146.g7de11f915a
>=20

Looks good to me.

Thanks,
Lars=
