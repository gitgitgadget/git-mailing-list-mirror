Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE375C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 20:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 904FA20835
	for <git@archiver.kernel.org>; Wed, 27 May 2020 20:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="a7rOxa27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgE0UBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 16:01:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:50415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgE0UBm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 16:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590609698;
        bh=X0qoAuEvp8dzfYuv2rD+PWLDIijaA4AGu+9zWPHsg/E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=a7rOxa27dWPVjtxY5k9SHkQJveUTBpeQdYbuWaW0Sw3DRPo6Sc7+Ivn9XThwL+Gbr
         86pSBL0YFYXofuBhfbf7jue0pezKKlqABi4k8BVXF8/0sgY4dvbhQPZXrTIG6oHzB/
         NjBhDLG9Z3mDnBm4038b/lwosOHdMkghZmwcVZWE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.214.52]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7JzQ-1jf9mI0blc-007miH; Wed, 27
 May 2020 22:01:38 +0200
Date:   Wed, 27 May 2020 05:27:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: jn/experimental-opts-into-proto-v2, was Re: What's cooking in git.git
 (May 2020, #09; Tue, 26)
In-Reply-To: <xmqqsgfmmt2c.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2005270526280.56@tvgsbejvaqbjf.bet>
References: <xmqqsgfmmt2c.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:q/kIH+pBkclwrL3zMLgswD1bDP6Oftckx5Za3nvN/NUN7S+9fnU
 DaFzd89Eb1RBLl2T/HluvUWyu1MjftuAv4fUlR74mYU5x8AmTNPKAQHFhbKXc12grOi988D
 lgoA0s+7o9TJfaDb1RXeucDyfuREzMDJVP+S5lkM3gaefYhz19u8w1TWYHC+RljX2+0kM6n
 cBQiVs2r4VAkvyIHw7WTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:apD9DfA7FHw=:cOjdHEIhrJI/D4FGgdikhg
 BzJX0UvTjMFJYXY2642nIN4dmt5ORJoNTYOJMuu6FFZDialHnt2sz/oYGJ9Ocq7SVFJWDWjyt
 r5R6sew9PdQsldjes9fSkJDhx7Xjp2jk3GbTcJwWDymxuM2Ge1kka1dJdrCU5JTLQjvRFs/6n
 m7xMEIJ8/+m5pS6OrcxCZBDd1GxA2THXhscJ/U/6MjTmETY2cEgvD3mDN7KXtxFMNCwv21MbZ
 Ae0thSAMk8hj9aU7Acjndr/e5qUMr/ZZvjYbVp/qfmzgjcKj+cRBWhdKJlvxKujrvbUj2QOKL
 jQZW4fVrnX7Jx4TwwDg9jU76PzRTZJhyMDr+1k9gt6NRUiWdN50bYT/gnzZ9pQ4RIg5JcKius
 Qd9Uina8sJ/2sJ8sHgYzXg1UwVdIE61D57hOXoDOsOnSMar4g/v6QJOYlXTXOTiWAN9RqHKGN
 2wiz9+Wx4kxCC6CUlVLR6x9AG9vyhYyvWRn2JlpQF/3e8V4tX30aSfkLEH9VjxMLG7ELhJwQd
 MLh9DnTRMqDsDCd3dRh2aaX+UZw63+1x5Ca8CsUn2l8qH+fQUK4AGFsyDp3MGh6lABIT/mBpU
 16Nx/0jDxNQzIhbBVm7GNapi/iKYzSaPXEddxMRK5C93WA172HFLCds8aUTBYq4OYHSF0J5Ft
 45+8J2TP6yDJye0GzbBoo6t/dri3CFk+KsTZMknct75KY5WY2VTPnBL9DKXL8A2W3gTHjHTef
 Xj7nOcUzJmhl1ouJOfRh7vtKOP0kyjgi6gkAxmHNP3zkJYzDw97rUaXkMLpdLxr70inHvobmq
 oESelIdmSnbtXo5qjB8a5ndyZj6GJzFYvluykpOBwtGx0PVrScnJKcdMwYR6/uwvpDC1NcZJl
 XSXJR8DLgicfMjp0ifqmaC7lWSAM4RUWdJsi/jQB5fVu2Th2AG97WlyN8OEuQiHBmbcGCyzfz
 wDB1gnTzC0aDy00j1RfkH+33fV69Qpl7MJ61+TG8wbKmGb9jjdPpRt9/loaBURYJ1A+iHwA0F
 5Bnc0fruiiwWiZi6W3jOD9LXcaKwGSB8g5MiT0rVrFZyB3GgTTZkyscUSet1D4RCcSfrwEocP
 F5NdCcrd9duUBhU23+tf6NjdyIiAKuVBsoFkm2ibfaestyY/4SkWQoR7SYNCyhnGFqXGIOwpn
 U4qtSaLY18HCcu99l78fUCUthPZGyemlmZ5/8dzrNY8eC2iZjAXwd9tIR3kxBp7puX1EJ1m73
 i0gJivkP1vY2wQl1Q
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 26 May 2020, Junio C Hamano wrote:

> * jn/experimental-opts-into-proto-v2 (2020-05-21) 1 commit
>   (merged to 'next' on 2020-05-24 at 53cd664dfe)
>  + config: let feature.experimental imply protocol.version=3D2
>
>  "feature.experimental" configuration variable is to let volunteers
>  easily opt into a set of newer features, which use of the v2
>  transport protocol is now a part of.
>
>  Will cook in 'next'.

Given that the `feature.experimental` option is supposed to increase
testing in the wild, sort of `next` but for users rather than developers
who build their own Git, could we maybe integrate this into v2.27.0,
still?

Thanks,
Dscho
