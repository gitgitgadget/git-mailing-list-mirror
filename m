Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 521E51FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 10:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754073AbdDKKW1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 06:22:27 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:34615 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753452AbdDKKWK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 06:22:10 -0400
Received: by mail-oi0-f51.google.com with SMTP id g204so104809311oib.1
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 03:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CY8xmfdSo250wXaYi3NW+se3Kx5lUFb+01W1T5cfZbM=;
        b=XRdxuLJcndbb6I4Df1qzVIbU+EVrgmJNv1wb0EkZnG7vbmkEqgwA9ze2jm8gDlu6v5
         HOluwZQRGzJbbONrjWc+czgrQAghAMLmG2Iz8rodLRJL0CCPCJMH/uDhaxOxr1ZjXI3V
         R7J+uVbyUT9BjL7+eniEWDq0ICTjfUvf/X9LDgyqtZhoNXMy1hzsK3wPxFrpGA/4dvYE
         Ka1ZDFWKWp8ELyFWpeYuDDNslIjELOeJo8vc2R+LzUEA1gCbQojlMQ6tC54Oc1ZZ07QP
         uhKNdLhw7YnVUo6Dw99SdScK2UK/7X5/sooRmDRLj7/lTb+tjdezJgaSdm+fjYq4aa0n
         eD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CY8xmfdSo250wXaYi3NW+se3Kx5lUFb+01W1T5cfZbM=;
        b=gFhrjiCf3OwDi6vhmay8aXgthpBf3IBmiVlTUBXCrbdUYVG5tBDQWmeW/I8sFxlBXV
         4XBbqzwSuPzE2tePq/fp9AWnfIuJt8efRPBM9Q103LVz/8iK0/s1xt8OIYL2CK+/bfgK
         COwAB5r8au7q15ovbDpK5js4dNWk4I5vb+QtfZm8L7ORyFdZtOV9AgXpYKp2JUxHXHDo
         pL8mcmkclt5i7nZ7ybnikggWqhN0I0m1nJU17SWzE/3KY/BHdl68yl4kzMGODbQXKzzd
         Hh2qnYjuWkgdNtk/MqTg1QH4dOYV61UGphTJU+aef6SYgQ+DUuHnJb5fVs59/NUIjLn2
         tY4Q==
X-Gm-Message-State: AN3rC/69aQryeH3LMCJnnQG5DckNqXEKTGpYMVl5mTXLpTh8mObOTNnQ7EcpXU7c7Tvf+vZaldU+tOvzR9HYcw==
X-Received: by 10.202.195.212 with SMTP id t203mr13860215oif.23.1491906129613;
 Tue, 11 Apr 2017 03:22:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.35.80 with HTTP; Tue, 11 Apr 2017 03:21:49 -0700 (PDT)
In-Reply-To: <CACBZZX4QfeiL7kB2+3pPbKjPGnQRXrGooQ-QrpgUtPnZRF=o8A@mail.gmail.com>
References: <20170411092050.15867-1-ryazanov.s.a@gmail.com> <CACBZZX4QfeiL7kB2+3pPbKjPGnQRXrGooQ-QrpgUtPnZRF=o8A@mail.gmail.com>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Tue, 11 Apr 2017 13:21:49 +0300
Message-ID: <CAHNKnsQvGrDnp9fivTwJxw1JCP+R3VXQKNS2kKvsaG=sWhRxTg@mail.gmail.com>
Subject: Re: [PATCH v2] http: honnor empty http.proxy option to bypass proxy
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Knut Franke <k.franke@science-computing.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 1:09 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Since nobody pointed this out already, some grammar/spelling fixes.
> Also CC-ing Knut who wrote the commit you're referencing.
>
Thanks a lot! Will fix in v3.

--=20
Sergey
