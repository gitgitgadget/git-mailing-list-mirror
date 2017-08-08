Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ED8C2047F
	for <e@80x24.org>; Tue,  8 Aug 2017 04:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750740AbdHHECI (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 00:02:08 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35700 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdHHECH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 00:02:07 -0400
Received: by mail-pf0-f173.google.com with SMTP id t86so9413835pfe.2
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 21:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NNckhzqrz8B40S7zkPv9dYtIVTEC87lRXpfjcRCpn/A=;
        b=mp5caWQKb3ZeFZw4Yjrq4mUCiE6uLJ6c4zEmrzC8nVF2g2HeuHVavLduja48BCTKve
         kNpj78pVdilrA32zZC9MXQXWgrNHAeeAxyg6qk6cvtjPEdHYfWe+Gxr6bAWpOSVnw3QK
         9/w8Lxg0shQCSzz4xe4ScvtLHeNo0nxBZMbcgASsQgOCPne+F+hgUKNGRbSayEzm1AR2
         NrToQVzRB2ggXj0RbXAsnqIl25KqdaG4zvLJ+q9rTjeOgN7qGclalf6495ef9hBg/oYn
         apRNy+6hmAOCzek6NZKeKDl7ZfANS3GUxHO+lXuhZYSDkZcgyaGWZI5vrXVVU8hhP4/d
         eqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NNckhzqrz8B40S7zkPv9dYtIVTEC87lRXpfjcRCpn/A=;
        b=DbosqD9x8hj2evgAZrNVWe58uCtE959ATAz56rM1JELwDeNniFoxopCuKm+cF/hnCE
         rGD+cwwx08SOFX2SWB7+WpOJ04IzCA0eprvwnPyWSwWBBELZ5J76S6ovVSNaOdx2TlZU
         fNhMCCBkbBMlbhL3MktNfuhwe4NQCZxgvJvVSggTTh0Ecj730NeHvfWaBv6KvW13NBoN
         AFFKRrEgm5io2DorfyRs8MHtOSTBLCjZfBcQJ1uMyY6uiBweUg+puCPpTMpm9nYEuQ5N
         oeDdQI4b1VXyqIsUs0902YjZZpnqDXCL/HRGLnmHq3E2jNi5232JwPyDlHJOLfWS0pLo
         hg1A==
X-Gm-Message-State: AHYfb5iHinxeedx27xf3ss+U3cE3bnfIS01fgrEClAWnGx5KJ245XbBV
        HtwR81n9pz9PlXbRP+VbRkn6hhJGXav+
X-Received: by 10.99.112.16 with SMTP id l16mr2643683pgc.143.1502164927357;
 Mon, 07 Aug 2017 21:02:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.238 with HTTP; Mon, 7 Aug 2017 21:02:06 -0700 (PDT)
In-Reply-To: <xmqq1sonozdx.fsf@gitster.mtv.corp.google.com>
References: <cover.1502128418.git.martin.agren@gmail.com> <CAGZ79kaEA7DRm4inO=XPCVvA3mJioV_yckAVEUbCo5DEwoxbUQ@mail.gmail.com>
 <xmqq1sonozdx.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 8 Aug 2017 06:02:06 +0200
Message-ID: <CAN0heSqbi-2VzhXtFO--v2+kMKuUbt4Z3QgtjW6WLEFP+VeoTg@mail.gmail.com>
Subject: Re: [PATCH 0/6] clean up parsing of maybe_bool
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7 August 2017 at 23:12, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The series looks fine to me overall, though patch 5 is overly gentle IMHO.
>> We could have removed it right there as Junio is very good at resolving
>> conflicts or producing dirty merges for such a situation.
>> But delaying it until no other series' are in flight is fine with me, too.
>
[...]
>
> I am fine with either in this case, but I probably would have opted
> for removal at the end of this series if I were doing this series,
> because
>
> -       git_config_maybe_bool(K,V)
> +       git_parse_maybe_bool(V)
>
> that may have to happen during evil merges would have been trivial.

Thanks, both of you. I could wait a couple of days to see if there are
other things to address, then send a v2 with a more aggressive patch 5?

Martin
