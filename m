Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622841FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757903AbcLAUHf (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:07:35 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34964 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754747AbcLAUHe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:07:34 -0500
Received: by mail-yw0-f195.google.com with SMTP id b66so20191848ywh.2
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 12:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e0jP3SE+FFTyiqfIDWasiRrn2NtKHnTlcqSHvgIWQzs=;
        b=cJRRdqF4XVRe9lk5WCSQeLNAXZuCK7bnedka2bgrG54zh4VIpPqdp+iTUAywOl1Jkq
         vhpKT0uBYcIrhL8gJNUVORLjf76ADo2F/4qg49rCxCtEe2SaCwVOjN4kGtyacT+ulWEN
         TgE8+kIrGOK8xtoqvDvs9XjiM9ij/DSM99bbdx3Qaj0BWApepqLPoldxfR3WA0wknq1o
         Rq/TH1LECTOIRdJQ3xDTJRAQLzCQTK90xFhy2U6mJzYX+imwq1t9G0/60vZFKs/QMqD9
         MfVaqdBen86EtwYlLDV7lOQa5iKvbOPmzETTwo2M1uiHp+xxPn3wCaYlI58kJm5+GXXQ
         /Zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e0jP3SE+FFTyiqfIDWasiRrn2NtKHnTlcqSHvgIWQzs=;
        b=DJf1xMAYwhShtd1EOHGgee35mleRAa9hjKZ54t4pGgiQ84GYizvTFuLCxL/j+bkc2e
         KGXbqIGleFXjSxBBxmifef0MW5hhvvZzyyNgUTpLewNDSscniBqKqwkMY0ysFFwCFfvk
         BD/V2uvb+rR8EkC3vRNwZn8J0X6RqAhrj7NgZHaNQeDOmyFONLrgiVB7o05quVsjsqIb
         XMOGXfzqCsrQ+mnuhMASJvrTvv5sASmegjp69NcniYWXKDh84Wu53+ck79T1FYmGICTo
         EJCdHwmXtg0lz7LBscCkJt1lBEN341t3yhn22yq+/4HSPgaWpqlEXtbSyiwgST1q2WdT
         asfQ==
X-Gm-Message-State: AKaTC01+PeV8D4bhWmbAbOQ/uluNE+wtArfRR4t0QN+2+fA7Jt7wBlsK+WlTi/aSEFZk163h2iq3d1Mzb7P7ww==
X-Received: by 10.13.234.19 with SMTP id t19mr46396881ywe.204.1480622853698;
 Thu, 01 Dec 2016 12:07:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.118.87 with HTTP; Thu, 1 Dec 2016 12:07:13 -0800 (PST)
In-Reply-To: <20161130170232.19685-1-tboegi@web.de>
References: <6a7e155-f399-c9f8-c69e-8164e0735dfb@veekun.com> <20161130170232.19685-1-tboegi@web.de>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 1 Dec 2016 12:07:13 -0800
Message-ID: <CA+P7+xoJb=SukbnJVJrXR6WV9+UtGnsn776KGkrHC7X-T_wZWg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] convert: git cherry-pick -Xrenormalize did not work
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git mailing list <git@vger.kernel.org>, eevee.reply@veekun.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 9:02 AM,  <tboegi@web.de> wrote:
> From: Torsten B=C3=B6gershausen <tboegi@web.de>
> diff --git a/convert.c b/convert.c
> index be91358..f8e4dfe 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -281,13 +281,13 @@ static int crlf_to_git(const char *path, const char=
 *src, size_t len,
>                 /*
>                  * If the file in the index has any CR in it, do not conv=
ert.
>                  * This is the new safer autocrlf handling.
> +                  - unless we want to renormalize in a merge or cherry-p=
ick

Style nit, usually this line should begin with an aligned *? I think
it's not really that big a deal, though.

Thanks,
Jake
