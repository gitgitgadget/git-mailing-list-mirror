Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F144E208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 19:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbdHOTA6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 15:00:58 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33906 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752374AbdHOTA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 15:00:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id x64so2393248wmg.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 12:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iny106LrL8kCm5qEqmIyPItvMWZZ7LK/6Ok7rI7/Op4=;
        b=j0JJX7eGd4Tl5cdXl6endi7LXrcUXktlrxbZgePqGDDfe5U6Vb3nJ5awuIwr2zwSDa
         AQjOOov8Ty7OAMZtws7dHXNL1VCtykjj7tlOuY3N8OEJFenxdHPfI/8VHvcI7ajV9leZ
         yVLNeom7C78uaFXSeBBCrTCXdfu81hIeX2y2BN0OWWOZF88uf3Egmvkb3gHZoJmlTQdI
         yPbmHb/zYonXL9gc40waHgXbvPBqAPcexV3IWwD0FpwBanl013fZDedbzVl+AHJA+aRN
         cdB0NAGz9orFB+sILGfgMBLZmVUU6IE/CRmAuHXzJIbfoci7hs2OGqad28zuo5LsqMol
         wacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iny106LrL8kCm5qEqmIyPItvMWZZ7LK/6Ok7rI7/Op4=;
        b=iRy+bnkBwwdmaNoFGsutZq6OYhoajeP3tSQ9Evm0HfaJZO2C4gM3muTBDiMv2shioV
         E4VTGjI6BzZgqoQHD22n9nJMySRLMPau20G3+oAoDRC3j6x1mBLNegg9x6RhNrkPz4fb
         i6a06w/YJxCZDhIKo5WKBwtaDH0mIP+Si293N+0zpGGXuzwVc1nEpSc18rfibz++e5ul
         PnAD4XlUxEV2zVKor3/4H5RHwuLK/k3fu0xSm4Z5mYLvHIc3AbHmTBpJ5F0tb6cALcbH
         deB345YSODMQGkUuW74/lSavZsp6yu5bm0pNrjTQ5dJbsR+QrS+p8lU3LcQSsZkHb1NW
         xcww==
X-Gm-Message-State: AHYfb5jySE6oKLeHFixIRqEzunyCOO0FjIzb4pVRw3usgxfG9St49LP0
        rcXEwSqqn7d0Vnk0p+Y=
X-Received: by 10.28.128.213 with SMTP id b204mr1732432wmd.128.1502823655488;
        Tue, 15 Aug 2017 12:00:55 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB6853.dip0.t-ipconnect.de. [93.219.104.83])
        by smtp.gmail.com with ESMTPSA id 5sm9366035wre.5.2017.08.15.12.00.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 12:00:54 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] sub-process: print the cmd when a capability is unsupported
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170815173611.2267-1-chriscool@tuxfamily.org>
Date:   Tue, 15 Aug 2017 21:00:53 +0200
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <836F754B-C78C-4D19-8365-875D96B3F115@gmail.com>
References: <20170815173611.2267-1-chriscool@tuxfamily.org>
To:     Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 15 Aug 2017, at 19:36, Christian Couder =
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
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> sub-process.c | 13 ++++++++-----
> 1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/sub-process.c b/sub-process.c
> index 6edb97c1c6..6b133f8dce 100644
> --- a/sub-process.c
> +++ b/sub-process.c
> @@ -158,7 +158,8 @@ static int handshake_version(struct child_process =
*process,
>=20
> static int handshake_capabilities(struct child_process *process,
> 				  struct subprocess_capability =
*capabilities,
> -				  unsigned int *supported_capabilities)
> +				  unsigned int *supported_capabilities,
> +				  const char *cmd)
> {
> 	int i;
> 	char *line;
> @@ -184,8 +185,8 @@ static int handshake_capabilities(struct =
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
> +				cmd, p);

Wouldn't it be possible to use "process->argv[0]"?=20
Shouldn't that be the same as "cmd"?

- Lars=
