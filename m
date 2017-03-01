Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08F122023D
	for <e@80x24.org>; Wed,  1 Mar 2017 19:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbdCATkX (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 14:40:23 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34442 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbdCATjl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 14:39:41 -0500
Received: by mail-qk0-f172.google.com with SMTP id s186so87560855qkb.1
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 11:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AounWprJq1SZ/VngysA1t/obf0qR/8cb4UKOWiBnw7k=;
        b=OpOm3vjlxjOZZXPtbRqctNmm66Eis9/Mxw46x5DSBkd9282oUkrcOcR5LK2/RCrn4k
         Ja3lnG8SJkcksZtAboGiTuyXf8zAqnKfoROQQx9cUhmQGVgS8zIGSWsfq9Fd5t/B7Y1T
         jZ0GluUEtStyyAQmGhlRF1op/BMJsVXxulV71tKlxl4SRD2zlaqGaPACCnNxQh4Q/PGx
         GEh+DpOXEP0LY+7S4rQUrD6/Yimr5esxiqZqekEcqz5orH6tNM6n0D6qP/kCA1jvsfx8
         LGhBngG027ukSmycU/iOHj06LgO2wrnB9p4f7zzQIq7kaZxxmunHN8stizXWlwKn5Csk
         g+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AounWprJq1SZ/VngysA1t/obf0qR/8cb4UKOWiBnw7k=;
        b=t0WXZhFCTMvIu2RS4kXSN0oaXhf9fVWLqIiRzQiLbPDshMWQ5LSiZ6IDeBy/UE12+w
         E8c5V51vY2dshIiQ+vOYjUFhXka6NnNzUpCEJq3JvSqLZowDlsnfyKUn5um2j/26hU4G
         rb8llv1r8qjKN6VO+n2Log8RDgzvXonDXFyc32kT9FUkAIwk2DNjkcVL525cSd999bn9
         EctKZrmeMMA7jlWfU/KY+WNfTBp4JAU81+vC50C4UEO1HGTlWTlbREWysJF2EObqgBMg
         xI8ktRHStMqMeMlzZYscoEalw/3m8HZmKe0wLsQc5Wfqmv6tmxVbZyrklFH+JiaL7WP4
         veeg==
X-Gm-Message-State: AMke39maJY90ecUMQq46BnTAx2o7a2/slBDy4ssSH5LJJf5LOuv9vptifRBgaOqwPDZLMj7JYxzr4NRhE27sGg==
X-Received: by 10.55.31.170 with SMTP id n42mr12574889qkh.181.1488397158302;
 Wed, 01 Mar 2017 11:39:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.178.20 with HTTP; Wed, 1 Mar 2017 11:38:57 -0800 (PST)
In-Reply-To: <20170301193210.tgvnjgc2hfaeebqf@sigill.intra.peff.net>
References: <1488297556.2955.11.camel@enea.com> <20170228181719.t67abnnnsdcx2xfd@sigill.intra.peff.net>
 <58e05599-5dc4-9881-d8c0-89ad1f2e3838@web.de> <xmqqfuiwhnud.fsf@gitster.mtv.corp.google.com>
 <20170301193210.tgvnjgc2hfaeebqf@sigill.intra.peff.net>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Wed, 1 Mar 2017 11:38:57 -0800
X-Google-Sender-Auth: EgysHUwH_8NLQBf4NMMOQEmbVc0
Message-ID: <CAPc5daUyu_=5GeGqBAG_KvkZFE_0oD6Wa_HhoRQwZ2ANUwOF+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] pretty: use fmt_output_email_subject()
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Adrian Dudau <Adrian.Dudau@enea.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 11:32 AM, Jeff King <peff@peff.net> wrote:
> I would think that future callers would just need to provide a dummy
> pp->rev. I guess that logic could be pushed down into
> fmt_output_email_subject(), so that it skips looking at
> opt->subject_prefix, etc, when "opt" is NULL, and just hits the
> "Subject:" case arm.

The "flexibility" I was wondering about is that the current .subject can
point at any caller-supplied string, not "Subject:".
