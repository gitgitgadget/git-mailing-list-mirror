Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48E4C1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 22:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031891AbeBNWnj (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 17:43:39 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38020 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031527AbeBNWni (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 17:43:38 -0500
Received: by mail-pl0-f68.google.com with SMTP id h10so2753416plt.5
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 14:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XeX1EgOrik9PkiTA1ogfyIeuX0fjV9hi/bF483VZKvA=;
        b=BeC81PB/KkKEqe3r6753Wk5FsJydknZ+evMgsPks9vIC9TX903h6E2lq1mO/34njcQ
         Khb7F3jA3+TuWCy7SOH075riZrp2w8T049+KhIN0Tskvp1gV+aZBdzLYzy4nmGKfpDIx
         xNuJ5V9rk0ypqwgTB9Ch+k6ndpm0FfBh4E+eUdqCgpwniwXN1TB3RocLvcS91SD8Ezji
         HwD5rhM3LEortVUi7sIXNHA7Ds0oONSuI83x4lvjMArKezVNccHBNNNgu+6rO1byOcnt
         OpA+9sFVmfP2AM68VypeVaVwy7YljjhfhVw8uDhqeMFF+xdBnCR3FMosdl5crDhxapCy
         tgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XeX1EgOrik9PkiTA1ogfyIeuX0fjV9hi/bF483VZKvA=;
        b=mfhvGFS5UZSsM3sO6PCfIJlUoXzjcGYTB4UC4/1igsn0yeWHrTV4p7zYNZAC6Llf4x
         qFuiMzLbEG7wzFRKsIEiLHcRTCZB8+/cjhOjY3psKZNX2Nuj6L6998XAqf/0+JWaOU1g
         fI0VrnVF52P3wnWP3gtw7heQkxKFlhkchXxTIgSVh/49M9IqOsndJzoBsE67OQfKbm0Q
         bI2O2kPi55H7xWv9ekJczJu9oDnjH8fr7n4W9TlNVib2QaOUJCtRbo9VoyncW7CozyH4
         VX9Mcy0exft+xBemmHx7otb2wCnzd9GitSg5RIqdBYkady50Okfs0QJj/IvIGXBB+aZF
         K7LQ==
X-Gm-Message-State: APf1xPBMgMOb0gCWZs0sY199gNjgQKRxA24vuJZpFNeBuqy1vfbWHZ7I
        U1mD6ARGNw8/EaH6hvRerfo=
X-Google-Smtp-Source: AH8x224NSAjNA5QuZ25yN8LtLKmGlfkIoYBpRu7fHubcpDjYKVZypLTM6m9UyU5/xBVedTFLKEdpIA==
X-Received: by 2002:a17:902:6bca:: with SMTP id m10-v6mr507640plt.351.1518648217452;
        Wed, 14 Feb 2018 14:43:37 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id f13sm5542355pgp.59.2018.02.14.14.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 14:43:36 -0800 (PST)
Date:   Wed, 14 Feb 2018 14:43:34 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 2/8] perl: move CPAN loader wrappers to another namespace
Message-ID: <20180214224334.GB136185@aiede.svl.corp.google.com>
References: <20180214222146.10655-1-avarab@gmail.com>
 <20180214222146.10655-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180214222146.10655-3-avarab@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

> Move the Git::Error and Git::Mail::Address wrappers to the
> Git::LoadCPAN::Loader::* namespace, e.g. Git::LoadCPAN::Error, that
> module will then either load Error from CPAN (if installed on the OS),
> or use Git::FromCPAN::Error.
[...]
> This also makes things a bit less confusing since there was already a
> Git::Error namespace ever since 8b9150e3e3 ("Git.pm: Handle failed
> commands' output", 2006-06-24).
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Makes sense.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
