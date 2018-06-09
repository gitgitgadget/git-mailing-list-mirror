Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 353461F403
	for <e@80x24.org>; Sat,  9 Jun 2018 21:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753381AbeFIV0h (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 17:26:37 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:53648 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753278AbeFIV0g (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 17:26:36 -0400
Received: by mail-wm0-f47.google.com with SMTP id x6-v6so8565830wmc.3
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 14:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=rxxHZVQMIb1/KcUdIOyDzwooy1pwLJEuyw5zE1zhZHI=;
        b=MCZ971jmVVm93aErHSyxVIZFWJ0/6we+xzWockz3fBjUXbCLwe6chDLhOYH7zTgOMT
         iKFq0031Wwe1dYf9T9pI0U9evp+VUhKJgWoPp4n3CO7d2rv0Ef4I5WEvLlvw2nt1yu3a
         32oVKz1LpteA9I9GMmNJ9jLXFoKgEHP7OsREIKXJt8rigkjmtqGYYZ6yeEoHQugmyyfW
         fYeJ3eiwvfNbfsQzfOywTyWmo3ktEfinAWkx3h8T6txOO6JLEzt/WJlyfkzB5g8dlL/d
         3wcrX7z0E0kFoDv7s3ZqQsWAjjBbYExPuO++5NlX0OEsNdrFwJ/rBp54bwzdZ1iJu6/n
         /ckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=rxxHZVQMIb1/KcUdIOyDzwooy1pwLJEuyw5zE1zhZHI=;
        b=cXnQhyCSF086HU709cqNKT7MS9Fvs4IFJD4HcHmYnen+ZjHS5qgJTq99Nhy0h6OdbR
         FDPNCmTnd0FuLhBKZpr7NVZ1wmVvLBFCPSiMbBQKwsBWGbVZvCCMwonlPGuvASm+o7IC
         SDyzasTip5faeeG0WJzh6745WFVIsnuAXZR5GW4CmL5aYpPh2bQQtt0xX1fWg1Qy/HWa
         wWHvp3LmHjXjc1r4c7Ujphm97YyUlcFspukHOwBEiu3qbKm8zTyQL3Rl84pP0c3t63eF
         E/gybCIKGTxGzUsMtp4w8n09EkTpp7VjCqi8RJk1QZfBMOczdzV9uDK51O15Znn6MOSo
         ZiDQ==
X-Gm-Message-State: APt69E1OBFLMXIhuwNuduHL/Ykg+t1JIGMctUAT9nTVkKxhPJ2L5k5EV
        vZa9Wputia6X8dhJl9gdpK8qJG4J
X-Google-Smtp-Source: ADUXVKKgeHm351hHvO6w8zaRMQlZJDmaAu3E9rldG8mwMWmyNelcYTTZ8caX/v63VKAUvBXVXdn6PQ==
X-Received: by 2002:a50:a666:: with SMTP id d93-v6mr3858138edc.294.1528579595645;
        Sat, 09 Jun 2018 14:26:35 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id b32-v6sm2888507edd.85.2018.06.09.14.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Jun 2018 14:26:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: State of NewHash work, future directions, and discussion
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180609205628.GB38834@genre.crustytoothpaste.net>
Date:   Sat, 09 Jun 2018 23:26:34 +0200
Message-ID: <87fu1vwt11.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 09 2018, brian m. carlson wrote:

> Since there's been a lot of questions recently about the state of the
> NewHash work, I thought I'd send out a summary.

Thanks for all your work on this.

> I know that we have long tried to avoid discussing the specific
> algorithm to use, in part because the last discussion generated more
> heat than light, and settled on referring to it as NewHash for the time
> being.  However, I think it's time to pick this topic back up, since I
> can't really continue work in this direction without us picking a
> NewHash.
>
> If people are interested, I've done some analysis on availability of
> implementations, performance, and other attributes described in the
> transition plan and can send that to the list.

Let's see it!
