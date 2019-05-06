Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 491D11F45F
	for <e@80x24.org>; Mon,  6 May 2019 23:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfEFXbO (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 19:31:14 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:44412 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfEFXbN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 19:31:13 -0400
Received: by mail-ed1-f52.google.com with SMTP id b8so16932869edm.11
        for <git@vger.kernel.org>; Mon, 06 May 2019 16:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=6IxvSOcwOf6C6exeAYC5FqH7hZagLvsGgvEmTuHNQ6I=;
        b=jVxs5uw79Tiw1OJHtFEwJRobj9+FqWfI7J4qYkSJdth4wmQOQoL1cmJf878VsAWPas
         stFYE700FFHd+0A9H/hZotHfv7pLvh+F+32BE9UQ8nctyNx9M7NBt3Zk1xKAPNMr2FtA
         fGa67id8VxZ4e3KYdLhLuC6kncCWKtSkIlhvzH8iZu+zoo+JxzAv23FAue9ulzswCCfv
         hC/xjloId3BhlIi0pE8vl8Nu54SCFKmuHYKly+ACp1d1/awJoenW1rvmAhMIhbYs9T0/
         I/7a8DjnLGzOGcCUspjdVinpE9Qy14PHhXeKtnkMp3bUObynWxk4/FWdtX54QaBumh/b
         Sagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=6IxvSOcwOf6C6exeAYC5FqH7hZagLvsGgvEmTuHNQ6I=;
        b=XWqRaD2yiCqyN2e6maXIYKKAK45eS3Lq2YwWW6qd7Z8co8ELYTbVKNMlOZBIYZxtXG
         g4NCacTn18BYLPkAuESR1d3GKxBNFC6QuBipfIQhMHTVzmJS/EWFkBcSknbqLM8/fbaZ
         mmMPqSJF9gmKNGg5VZMzLc6oxDniRwjanei3zWS+Shxme+RUCuVjW7ninIJJGFhLFzR7
         Q8IwV3jcAoXSRN5oGQHtYbHri6Mgw5efyQSy0N1zcrrqSD63j5naHl6c5nZqx7aWvMQh
         pusaHbSiEMXZRR3q6OkWtINOl7AQx7h/rJH/CyMqcyUkcGrKXstAAMJLFj841TOZ3M+P
         PNhw==
X-Gm-Message-State: APjAAAVfTqBTIHJPVBld+DvJyhDnyjShInSbqeINjdSXLLWSGSK+W8/t
        EUuHzpkQsAkJpBQvbFFtwNs=
X-Google-Smtp-Source: APXvYqzrdrMSQ1EAUSOfd5Y/irWsr7ulb4KZ0YIGIkNZZ3xKiZWffFdt/BD2b5zVzZPv+XqIc/FeaA==
X-Received: by 2002:a17:906:899:: with SMTP id n25mr21748619eje.131.1557185472130;
        Mon, 06 May 2019 16:31:12 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id d33sm495720ede.10.2019.05.06.16.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 16:31:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Palauzov\, Dilyan" <dilyan.palauzov@sit-extern.fraunhofer.de>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: .git/config validations by (for silly errors) by git fsck
References: <36d37bdd70fba719ecee2c5572a8b85bc9940944.camel@sit-extern.fraunhofer.de>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <36d37bdd70fba719ecee2c5572a8b85bc9940944.camel@sit-extern.fraunhofer.de>
Date:   Tue, 07 May 2019 01:31:10 +0200
Message-ID: <875zqni2ip.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 06 2019, Palauzov, Dilyan wrote:

> I added manually a remote to .git/config, but updated only the url= line, forgetting to update the fetch= line.  So two
> remotes had
>   fetch = +refs/heads/*:refs/remotes/origin/*
>
> and fetching from the one or the other has overwritten origin/master.  git fsck has not helped.
>
> Please introduce a check in git fcsk that triggers, when two different remotes share the same fetch line, or if the
> fetch line does not reference the remote name.

Pehaps we need a 0bc8d71b99 ("fetch: stop clobbering existing tags
without --force", 2018-08-31) but for remote branches :)

There could be room for something like this in some config-lint tool,
but what you're suggesting is not an error in the general case. There's
many use-cases for having remotes with overlapping or identical fetch
refspecs, e.g. maybe you fetch the "same" repo from two different URLs,
or one is a superset of the other (and can clobber the subset).

When you remove a remote there's even a check for this, we discover if
the refspecs exclusively "belong" to it (and then remove the remote
tracking branches), not if other remotes overlap.

Whether such a check would be viable would be one thing, but it wouldn't
currently belong in git-fsck, its job is to check the object database
for sanity, but perhaps there's cases where it makes sense to expand
that (e.g. shallow/narrow clones where you want a "full" check).
