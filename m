Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F68C1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 23:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032032AbeBNXqe (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 18:46:34 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41688 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031901AbeBNXqd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 18:46:33 -0500
Received: by mail-pg0-f66.google.com with SMTP id t4so2836048pgp.8
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 15:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FHeQtjmTuYrgyhrnVi+GVCECLpGbL8sv6iNKbwJQ/g0=;
        b=hW888nGD2GaxTiXv1r8FKfzvYFMCU5H0LJLHmd3r98nOa2+/aqeZj/YX3ZvPGBfD0w
         Cn8xNGbUP+1lFYYpbU2w548984EEHyu/cq/8kVM/pCx237pcvWpaup4Y+Nz4dkHhsyMC
         AlQMA3C3hrAQuN7V1ZV7/TnQ+uR7xNhEIzLQ5lMD1gXvWCx7puXGXugmVBmhZ+Y5HrmZ
         ABIISVe+QwLUmx+pW2g2wN0l0zBHfdAoe29VYj0Efd6vi6KAztV1lTysBsQycuKWdQo5
         ivGSweQvwnFkVW1XHjoOspzr0pvHT5BxFvWq/Se/1DVCiDvT8yAd94LxIx89+0uz8JV3
         cTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FHeQtjmTuYrgyhrnVi+GVCECLpGbL8sv6iNKbwJQ/g0=;
        b=qKM5DAjFURhm3FdZQB6X+dzyacjRSy5HhuIeWoY4LEYk+CmogheC189hl2+eTm5q3R
         t0b8sr8ZVzsMcTrElEPh2XfnRVxsQR/0JuPJ33iQvVMQ00jg2J+sn48vPHMJESfA3yKk
         0GkrXacQ3wYNQUlvnJ7ivn0z8IhOGyDEUTVik4ZOkzdpCNTlZFLYLPRWT3iNc3uM5FQv
         UZFUPhIIZAspElPLfqHyHWXWtrWNaLWUcBS09MzEQQOyxjPzEPVtbMcGEJMamxvhz++O
         TVxm+flhioYkTLZKTv/yiP/9WPIi+nerjNZoWnGHqdNX2PZOGx6dX6tpR6kY1vhO8Lp8
         Flng==
X-Gm-Message-State: APf1xPDKpXUiKT4vm8L1sbxOUwU+S9zLNmwOq9TlVwq79DCNFL3w2Ihg
        ZkkUa/6hVZqYQz23HnNoD4cYZfx0
X-Google-Smtp-Source: AH8x224g/81B9V3FuHWKRqpTl8r++vrsUvHeDh8bd/d8yITGdr67FvSCN8DliBarGEp9fYuC98bGhA==
X-Received: by 10.101.64.74 with SMTP id h10mr565974pgp.200.1518651993016;
        Wed, 14 Feb 2018 15:46:33 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id u13sm39539068pfd.169.2018.02.14.15.46.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 15:46:32 -0800 (PST)
Date:   Wed, 14 Feb 2018 15:46:30 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@splunk.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 5/8] perl: update our copy of Mail::Address
Message-ID: <20180214234630.GE136185@aiede.svl.corp.google.com>
References: <20180214222146.10655-1-avarab@gmail.com>
 <20180214222146.10655-6-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180214222146.10655-6-avarab@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

> Update our copy of Mail::Address from 2.19 (Aug 22, 2017) to 2.20 (Jan
> 23, 2018). This should be a trivial update[1] but it seems the version
> Matthieu Moy imported in bd869f67b9 ("send-email: add and use a local
> copy of Mail::Address", 2018-01-05) doesn't correspond to any 2.19
> version found on the CPAN. From the comment at the top of the file it
> looks like some OS version with the POD stripped, and with different
> indentation.

Were there changes other than the POD stripping?

> Let's instead use the upstream version as-is, and without copyright
> notices stripped. Like Error.pm this doesn't cleanly pass --check, so
> add a .gitattributes file to ignore the errors.
>
> 1. https://metacpan.org/diff/file?target=MARKOV/MailTools-2.20/lib%2FMail%2FAddress.pod&source=MARKOV%2FMailTools-2.19%2Flib%2FMail%2FAddress.pod
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  perl/Git/FromCPAN/Mail/.gitattributes |   1 +
>  perl/Git/FromCPAN/Mail/Address.pm     | 436 +++++++++++++---------------------
>  2 files changed, 163 insertions(+), 274 deletions(-)
>  create mode 100644 perl/Git/FromCPAN/Mail/.gitattributes

Yikes re the stripped POD with license notice. Thanks for fixing it.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
