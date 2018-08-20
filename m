Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 517A81F954
	for <e@80x24.org>; Mon, 20 Aug 2018 08:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbeHTLOe (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 07:14:34 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:36917 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeHTLOe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 07:14:34 -0400
Received: by mail-it0-f41.google.com with SMTP id h20-v6so19362478itf.2
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 00:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BNuviZ5of97TtId4Hpjj6GA9Sa2NWDgVlwPetm86Ae0=;
        b=ADTVWeh5mrJ73hWHBKJMWevkuTnzbu3LbBTusa2lqpk0mWAWCDYLNkf4EAegBf+S1O
         YWw5XqQdyKvqZuOQvhOF/miy2nu8j/RPc3f2KWhwCBeyk940vGNYOipSdfJuOqZyJOIK
         K3sXSfzVFrlRRwJ9zXUtiLALztonD/RTnDxLB4RISC7We3TSDO1uucG/JC8qNLnpd0S4
         x7X/tfIWrL8zPHiprwZman1eNEYZBCMbqZoZ8kWW9lg1ed6PDcyhIH8/WIwOqCoFJgR5
         N1nA7mKo2FzB2NStMsCmwl4taqVfsvlpVyyrqJHgKZtk/PoNz+gx4BoE4C9MuH4g4pNx
         km9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BNuviZ5of97TtId4Hpjj6GA9Sa2NWDgVlwPetm86Ae0=;
        b=qZIUjVsDE6uj/1ElvO1CvSr8PEx6IAcoRoyNf/5GMaKGJhl7hc+bZ+ro6n2wiNimJ5
         jzraHufrJF6AajTBQM9J1yxOVgoQJDSHvwUHcGUBVyJPtoZTCPY9LRkYWc7X64f63Ddz
         OGi6DwWq4CjvqmFePwsrA2CuoKf+WmSV37OsZPLmmCtXcCS1r0PdbS3KqOlkqZbB/e1Q
         jrNGM7QDkeRhbMC2WzPQsTYMunpa6kfU/0EOX8+8S1hRPb0WvP7blIIpTpN036hbcBbn
         TxJGY2ViDMfcmkGTeD4hTkWG/BMIBjRHPTn4VewBUmjucCzIkkcFzb/U4lXX16pb8Pih
         EkeA==
X-Gm-Message-State: AOUpUlH9+yOQ5dkn3P3HRXY208f53VlsYDDzpxYhGZg5WiWhlcQx9WMG
        pDTlAg7urBSSUokUbf+vKSX6RzdSkMV86Huz4lD6b3Yz
X-Google-Smtp-Source: AA+uWPwZq3NbnWqs1F8p02Gsxjj4zB/cBVLYfb/5akALp/mWJ12ui1lfPrEcthgPBQj+98+jqCfsk74mQwxr2aG9poQ=
X-Received: by 2002:a24:fac2:: with SMTP id v185-v6mr33618791ith.145.1534751997409;
 Mon, 20 Aug 2018 00:59:57 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 20 Aug 2018 09:59:46 +0200
Message-ID: <CAP8UFD2V8NQxGAhWvGK1q7uozcE+dpwHcgRw8SVsT4T=7zJXXA@mail.gmail.com>
Subject: Draft of Git Rev News edition 42
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Pawe=C5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Simon Ruderich <simon@ruderich.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-42.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/305

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition on
Wednesday August 22nd.

Thanks,
Christian.
