Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66C891FADE
	for <e@80x24.org>; Tue, 12 Sep 2017 12:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbdILMCp (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 08:02:45 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35190 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbdILMCo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 08:02:44 -0400
Received: by mail-wr0-f194.google.com with SMTP id n64so5991524wrb.2
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 05:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OcE4EzRiy3a5ZqEgVhcn+MgEtz4iAaPjOpxQWW+r5qs=;
        b=LbmRppweW2Fan71yDerssdJ9f+LIfHiaVH5/xm9+0ozRMm/Gd+wLvYJ6v5iaU6ftfs
         5yjv4B2w3xTyIK99Uy4jotNWvVeMKMKmqFi5Rpbf/uIaiqlJDdloO7+26pDPub3m+1Eh
         tzhB9A4TLh4BbWcUlA7hhHczgnh5hs/Cv+KjaJ2Uxm/Jv9PYpgV10zNotNQFwugR1MEw
         XXNOTKgj6OZCPCdIKX/KlxzLkItwjIvPZ+/T7pG4MAAWn4mvc28GrRjNzogCcC9+F4Nh
         9g6pwG7fUJJ5UGjS/4P4iK3AgbooO8C7fvjrMhwetB/YkjdzsjuCGkBiD7Kb9uY0zPxp
         VkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OcE4EzRiy3a5ZqEgVhcn+MgEtz4iAaPjOpxQWW+r5qs=;
        b=lXIbx7OZCnl3BaaFXG0OFu98OIiEQRuWdqap9bknD+fh1epKKyjcAeCSwtJLEVqOOE
         emEGJvkYzEBltWgS+gk9DJtwdBzFwwM4LWFNIR6W6KXXvCiINMLdKgvPHQSHtg6PXuDo
         HgKLSDATnszsmu1ocVlpgjbWq4NaJnhLjFXO66l+VNCxfKF4cKOAXR3Lyik/ZcuQXcbM
         UQz9maAUv+3re/lFL8Izkgmv+oG0g0kNLQB9eg+/IMsoeY2dm5B/fXdXZHUNm6zI9qm4
         +OseizOcx24qJWbaqblRL0CpKg/bFYEv/Wkv33dLcVt7Asbrs7RrfKHTJD06G1GRIMUB
         ezww==
X-Gm-Message-State: AHPjjUgYTnv+N6G2x9qdXRZ027WwvkJzpdSJpSL7oXHeoPR8PAwiUtO5
        UUGSOLyQPoU1ZQ==
X-Google-Smtp-Source: ADKCNb5ZHlSc73hCwa+8TnG1v5iUH0ch/uYAKKoCFSAh5wt7RCdgRyBatYm1sy84d+vnGvhq2Lqijg==
X-Received: by 10.223.185.5 with SMTP id k5mr8256438wrf.189.1505217763027;
        Tue, 12 Sep 2017 05:02:43 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id u33sm4953599wrc.91.2017.09.12.05.02.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Sep 2017 05:02:42 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] sub-process: print the cmd when a capability is unsupported
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqlgll5300.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 12 Sep 2017 14:02:41 +0200
Cc:     Git Users <git@vger.kernel.org>, Ben Peart <peartben@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE6D0955-424A-4330-99FA-64B6A82E048B@gmail.com>
References: <20170816124036.25236-1-chriscool@tuxfamily.org> <758d36a7-8066-7e1a-30d0-62baf2796520@gmail.com> <xmqq4lt7pir9.fsf@gitster.mtv.corp.google.com> <xmqqshgri3dv.fsf@gitster.mtv.corp.google.com> <xmqqlgll5300.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 11 Sep 2017, at 05:27, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> I still think we would want to turn warning() to die(), but it
>> probably is better to do so in a separate follow-up patch.  That
>> will give us a good place to record the reason why the current "just
>> call a warning() and pretend as if nothing bad happend" is wrong.
>=20
> And here is such an update.  It seems that pretty much all comments
> in the original thread were "warning is wrong--we should die here",
> but nobody seems to have bothered following it through.
>=20
> cf. <20170815111725.5d009b66@twelve2.svl.corp.google.com>
>=20
> -- >8 --
> Subject: [PATCH] subprocess: loudly die when subprocess asks for an =
unsupported capability
>=20
> The handshake_capabilities() function first advertises the set of
> capabilities it supports, so that the other side can pick and choose
> which ones to use and ask us to enable in its response.  Then we
> read the response that tells us what choice the other side made.  If
> we saw something that we never advertised, that indicates one of two
> things.  The other side, i.e. the "upgraded" filter, is not paying
> attention of the capabilities advertisement, and asking something
> its correct operation relies on, but we are not capable of giving
> that unknown feature and operate without it, so after that point the
> exchange of data is a garbage-in-garbage-out.  Or the other side
> wanted to ask for one of the capabilities we advertised, but the
> code has typo and their wish to enable a capability that its correct
> operation relies on is not understood on this end.  The result is
> the same garbage-in-garbage-out.
>=20
> Instead of sweeping such a potential bug under the rug, die loudly
> when we see a request for an unsupported capability in order to
> force sloppily-written filter scripts to get corrected.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> sub-process.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/sub-process.c b/sub-process.c
> index fcc4832c14..ec9a51b7b1 100644
> --- a/sub-process.c
> +++ b/sub-process.c
> @@ -181,8 +181,8 @@ static int handshake_capabilities(struct =
child_process *process,
> 			if (supported_capabilities)
> 				*supported_capabilities |=3D =
capabilities[i].flag;
> 		} else {
> -			warning("subprocess '%s' requested unsupported =
capability '%s'",
> -				process->argv[0], p);
> +			die("subprocess '%s' requested unsupported =
capability '%s'",
> +			    process->argv[0], p);

Looks good!=20

Thank you,
Lars=
