Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 473E81F462
	for <e@80x24.org>; Tue,  4 Jun 2019 14:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfFDOGW (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 10:06:22 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46953 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfFDOGW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 10:06:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id h10so592154edi.13
        for <git@vger.kernel.org>; Tue, 04 Jun 2019 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MuEb+cBksnjavR3R2ufRIkHDtZQRmjsZxsV0zqNCwUQ=;
        b=cHfXZXrVnRFX5wG0Cb2FzqzZiG+TxihumRr/thmu9DfgCnSMO4jzXYlOIWGJiHxECj
         52NvUQjUUuJ2Kb4kk8Zb2zeqHshczrnsz5L7d9ZBBzGSwxadhiVepMxVTyHb9QbtEQVn
         f9q+3w0zFdKesNgnbPKLYXwtUrIlbcpZz03xDF5rGAH5yXYfHwEpBWdrHhKXPgXpAXTz
         qJ9jFcDD6+v+/f0i7NomAJ63DwestQSNSGFcrHKLgonZNx+0TVzhLnVr0NRsergXJPhm
         q+yvgw0z1YWJB//rgO3bL2t1RUlaiDRhSdSqV3If3msGwU0kZu/+O0yh7h3apy7aiog7
         TXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MuEb+cBksnjavR3R2ufRIkHDtZQRmjsZxsV0zqNCwUQ=;
        b=MXDuWsgeZ9L85RhceocI/AYhACZCZuLtwc2xG1QIF3QssXF0CHSjKKmEN79444tBIf
         ZvMIbPrq7Pe8exagjiWy4pdEqGw4xQoPxDWO3Tz1a94UFlFAZ6kGvt46pa0ffCBnRCnX
         aXFfbRn4nbkvFVkxDB5/n/Qe30B3UHl4LixqrUs/f4vj8IuBjML5v2kZ/5g7BjvjbId6
         HiKbpt4qjJQ18OiOHkY+OMoMa8K6X68Q5Ht7tr57uAGwWRF14qjSumSsRcpBWXU2rKEc
         4sZBv5Th6gSl83iFI7ln2Dfdg62KcTuHT9KhKEZkjaZMnbNTGTcMaFjKewHa94aej9a4
         jTUw==
X-Gm-Message-State: APjAAAXHfqvyiMNI6bYxv0UiL9tKKdUVIjkBnuSJMxxo3QHjSyAr8I9Z
        rIQ5qIUJCTg6h9ANmxfYxb1Teq0yNkfUOAAHJe7qJ550
X-Google-Smtp-Source: APXvYqx7XG1/RTQkJU4qy8Zo3AcHZO//g2paaphMlXDsQ4AC3Yfi5jLzmKGqS+jz9BMR9AAwmY1RTMI2/PZ6D3hrRs8=
X-Received: by 2002:a50:b487:: with SMTP id w7mr36473060edd.45.1559657180176;
 Tue, 04 Jun 2019 07:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <BUKFSM2OTJUH.38N6DGWH9KX7H@homura> <c1dec466-55ca-8543-8f4e-b5daf1e0eab6@kdbg.org>
In-Reply-To: <c1dec466-55ca-8543-8f4e-b5daf1e0eab6@kdbg.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 4 Jun 2019 16:06:07 +0200
Message-ID: <CAP8UFD0d5ptCpn+u8-p=oa3gZFYdbeW+KapVcmKgqPQKR4scwA@mail.gmail.com>
Subject: Re: [PATCH] am: add --check option
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Drew DeVault <sir@cmpwn.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 4, 2019 at 8:03 AM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 04.06.19 um 00:00 schrieb Drew DeVault:
> > On Mon Jun 3, 2019 at 11:09 PM Johannes Sixt wrote:
> >> I have to wonder how --check works when 'am' applies multiple patches.
> >>
> >> When the second patch in a patch series depends on that the first patch
> >> is fully applied, what does --check do? Without the first patch applied,
> >> then a naive check of the second patch will certainly fail, doesn't it?
> >
> > Yeah, this was being discussed in another thread. It'll fail if the
> > second patch relies on changes from the first. Open to suggestions on
> > how to improve that, but I think it can be improved in a later patch.

I think both features could be useful. For example sometimes a
maintainer might want to know if applying only a patch that is in the
middle of a patch series (for example something security related)
could work without having to apply the previous patchs. So maybe both
a --check and a --dry-run with different behavior regarding patch
series would make sense.
