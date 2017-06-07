Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1264C1FAEB
	for <e@80x24.org>; Wed,  7 Jun 2017 21:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbdFGVig (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 17:38:36 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:35143 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbdFGVif (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 17:38:35 -0400
Received: by mail-io0-f177.google.com with SMTP id k93so12718349ioi.2
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 14:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kC5Yhn9hMaAcchL076H2vP0vnmtssT2HJlLUxrB/TKk=;
        b=apVNzDODJkqwYg9tLiiExnj7y2CDTGGfeUjR+cjl6ECeTqk/87hiqaBF38jAHJQ83e
         YIaZWMAiuSiOoOz3AC6n0YJO3+3UTps5h7nQ9d3s3BcRhff5ANQodUX0a+/FM7RkiYr0
         DHCkvnVbw0s3XVY6QGRsyJ1KFKkKRuXuu83mNpZ12b3Qj8bFaWbiLBB8IFGNfEfOaRro
         ZS/LqglMExjOn2TqP9Nh+8KgOrwOyaBPnc6WuCIeAkePgKIYIbKpJ6k/XqYhAysg8w3P
         bbnFC/G9ug6o3w9pKegl5Yra0e4t1qkM3yAIsU97JlKCeaQCAQzIJN7qWxf/SgtII0bW
         y4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kC5Yhn9hMaAcchL076H2vP0vnmtssT2HJlLUxrB/TKk=;
        b=g5s9fQBcxx0BSE+4+TKphgwSg0iC5HEyysCygeoDeCvo3Nv4ofaEntXAH0hcrupOob
         ChHJ7qoG+/Wc43d8kpJIYSyXzZL9SM9963p5UwPEoLtQvTIQZ/BuFElcP11ZsaRSMo8M
         pq4JjA7Gi62Hg8nSA4513LgsVTy3vEASOUKd2wf6LBO3Ig9xNYhaOc1CBcE6/fse242Y
         k8QSJz+IIuC0u0nu3qWqsbmCy1YVPNv153v35iUSgOxAHUe7AJP2muVZDfVsfEsoYgTe
         2Wv15KNkhx6FTvtHmjUoHbFovTDmWVF5ZkIDMBfjD47LL804H4dzU3ulGM9DxIY+lhna
         BwTA==
X-Gm-Message-State: AODbwcC1aYaAu2/V4mERgDRlARTwcRYo3H98NFiEYYwnzyMOFm0U5Zis
        NsWo4d2UDn0I6P90KBbbp1TBSIkd9g==
X-Received: by 10.107.173.18 with SMTP id w18mr10782187ioe.80.1496871509502;
 Wed, 07 Jun 2017 14:38:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Wed, 7 Jun 2017 14:38:08 -0700 (PDT)
In-Reply-To: <20170601155105.28356-7-benpeart@microsoft.com>
References: <20170601155105.28356-1-benpeart@microsoft.com> <20170601155105.28356-7-benpeart@microsoft.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 7 Jun 2017 23:38:08 +0200
Message-ID: <CACBZZX5a6Op7dH_g9WOFBnejh2zgNK4b34ygxA8daNDqvitFVA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] fsmonitor: add a sample query-fsmonitor hook
 script for Watchman
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2017 at 5:51 PM, Ben Peart <peartben@gmail.com> wrote:
> +if [ $1 -eq 1 ]

Tiny nit: Needs quoting:

    $ .git/hooks/query-fsmonitor
    .git/hooks/query-fsmonitor: 15: [: -eq: unexpected operator
