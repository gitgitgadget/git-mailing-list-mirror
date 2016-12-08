Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F0331FC96
	for <e@80x24.org>; Thu,  8 Dec 2016 10:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752376AbcLHKV0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 05:21:26 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:35003 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbcLHKVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 05:21:25 -0500
Received: by mail-wj0-f195.google.com with SMTP id he10so39560980wjc.2
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 02:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pMsgnuv3Aw7UucFw7R/Eto/Q8cJN/7K+28aUb23QrWU=;
        b=ExVMzt2ex+X9W2DPlkqg07KK+FJz/BpvWUIMP1ZwbPNgrbSQXUeoME5+JltaNY2/vf
         zQdfFKj87IBFbzK7abM7FCwyZTnfJjsDjpYo37ZM7AeC6qz1AlcEjJmaYb87OurrY8j3
         jhLmjHODyRSVvPwFoXmhuAZOYlKtu21/Oq1ztEshB39/OANVEM9IdWgqN5kJlYvQLwRj
         RvODEyvneWyjt7fvVrMJWT/fIqxojJ4sslklronDpGCdgzKh05hKv83HU7yQDGt/7JDf
         qcJou05plSxfpoH8Ovk3hedC/hn+/1Ydjb0uznI+zJl0pv28EkLJ2fqIVabEgTnlbrF3
         7fZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pMsgnuv3Aw7UucFw7R/Eto/Q8cJN/7K+28aUb23QrWU=;
        b=HfMyBSN4F2sQ3dnWv3A27a+faY2Tu9sedC2U1MIjJIzGGf3ijBbIcBc3h5jNfKI/ET
         zaktEGR9Nj24rmYhaAPJOCTU9+LNJj+OgqolSz0jt7D0KU5PFKy4f3eoVzDaFo2fhCBo
         XOBqsCVvQ8AcF6eAR5BXeXChGP/l+Srq9Gc2axjyBLDHFzXVwifTMKqkEeXSQ6S2sauv
         as8QP7AinBQKqFsnbkuAEjIxoKviU/E9UISm46AO8BXl343l4Mw8WtmHOyc1FHci2e6x
         xctSAYDvo+d/ZX2pUEzSWj3CY+8X6c7mTzvarsP5cqoqPgi+TQ+N2gKv76LXXsagGEFn
         e2aA==
X-Gm-Message-State: AKaTC0096Ht1IalnECqdDBXBVftxt/0o56jlic9ALJRBQuVe5QRVFHSrt3HidVdTqscTh9LWVWMOkTFskDzwow==
X-Received: by 10.194.66.37 with SMTP id c5mr62689908wjt.138.1481192483564;
 Thu, 08 Dec 2016 02:21:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.179.188 with HTTP; Thu, 8 Dec 2016 02:21:23 -0800 (PST)
In-Reply-To: <20161207215133.13433-1-s-beyer@gmx.net>
References: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com> <20161207215133.13433-1-s-beyer@gmx.net>
From:   Paul Tan <pyokagan@gmail.com>
Date:   Thu, 8 Dec 2016 18:21:23 +0800
Message-ID: <CACRoPnSzHo2wqZyP6nfMaZBCy9-m6E72vTGRTjGcuSdo-qJ4dw@mail.gmail.com>
Subject: Re: [PATCH 1/5] am: Fix filename in safe_to_abort() error message
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stephan,

On Thu, Dec 8, 2016 at 5:51 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> diff --git a/builtin/am.c b/builtin/am.c
> index 6981f42ce..7cf40e6f2 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2124,7 +2124,7 @@ static int safe_to_abort(const struct am_state *state)
>
>         if (read_state_file(&sb, state, "abort-safety", 1) > 0) {
>                 if (get_oid_hex(sb.buf, &abort_safety))
> -                       die(_("could not parse %s"), am_path(state, "abort_safety"));
> +                       die(_("could not parse %s"), am_path(state, "abort-safety"));

Ah, this is obviously correct. Sorry for the oversight.

>         } else
>                 oidclr(&abort_safety);
>
> --
> 2.11.0.27.g4eed97c

Thanks,
Paul
