Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90F191F462
	for <e@80x24.org>; Sat, 25 May 2019 23:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfEYXjp (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 May 2019 19:39:45 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:44649 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfEYXjp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 May 2019 19:39:45 -0400
Received: by mail-ed1-f51.google.com with SMTP id b8so20205076edm.11
        for <git@vger.kernel.org>; Sat, 25 May 2019 16:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=DZmoDtKVP7q6FPG9W+Awrvzi5pOsAjyMuhlOoE1C0ZQ=;
        b=H4v1OWdHQjaLypC4qPT9W9LpPDT+lWCeMXMnVy+tksknPcrv8PxuprVGIyi37xG/Mh
         t/WnMCwl5PWXzo3MjlKGS5FLEQcU0x5lwty3YYgzxASNIySsJ5qSbc0Ezn4kPINTvjVt
         1Tg2/GCQnJv3zasyoqzstuozq/RAGAB8mwOdb1g7GSXhYtZilr4jcw84Cn5hgSUM7s8f
         F0347UYmWwjZor2HqILRf2DyuNKHOSOJozbq4C2YM8tSS3tgYYEAbIvNaEV7COnuddHC
         aB+qwdOwFtuu/2CNqF7VVovJXmd0K87GntFNnC5XqfdD0l1x7tvQlWyeXYReAdhqEFli
         xtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=DZmoDtKVP7q6FPG9W+Awrvzi5pOsAjyMuhlOoE1C0ZQ=;
        b=XNKS/6kuBIV9pGYhHK62cQivqi0W51d/fRF85OrxC/Sjbbcx2s0bN6BzWIQVDrBadn
         TJJOFb6LPQ4g1in1Zq1/BFcF5FfNly6CQfERCMy5zd1txN42yweQ8nWUPH8zNbjIjSNQ
         mpum8GP+F/GuEV+uzuu0F8BnAvQ5bcRpAfn+SFwF0U/3f9uZsdadTMdVdHyKa+oZsF7T
         /d+Kxqogu6qCIDNTSBeEMlg4hC6MPQ5bFmQ7AgtHc/zLqLYvOiKCH9XbdjxjPKJq2OhX
         ldfyqA0MCO4nuZBlfigRT0WRHyERuoBic0i1PdbsZC5JItlmgz7Uq+rVSnIUKIm1e2mc
         CpbQ==
X-Gm-Message-State: APjAAAWZhaRk4nA2U2HNyWGyHTmufC5J3xgu0QH0wEx4CSp0LnllzRch
        3ISXqw4dhKe6iEU/ZQmgP0M=
X-Google-Smtp-Source: APXvYqwIBCGf0UzKnTqFZG461Xwp4cSvFGA7yxifMjvwXNh/ZmnrYb1ZuyzBgeY7Jl9zDKTiT5Ojlg==
X-Received: by 2002:a17:906:7c10:: with SMTP id t16mr77646608ejo.161.1558827583814;
        Sat, 25 May 2019 16:39:43 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id i5sm1918502edc.20.2019.05.25.16.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 16:39:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Shawn Landden <slandden@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: receive.denyCurrentBranch that allows pushing data, just not changing branch
References: <CA+49okox4CfSWgQrdAYrM=R3ZNThWgkEY9RZtDzOMxAVs5b7Dw@mail.gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <CA+49okox4CfSWgQrdAYrM=R3ZNThWgkEY9RZtDzOMxAVs5b7Dw@mail.gmail.com>
Date:   Sun, 26 May 2019 01:39:42 +0200
Message-ID: <875zpyf6ip.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, May 25 2019, Shawn Landden wrote:

> It would be nice if when pushing to a checked out repo you could get
> up git to still push the commits, just not update the branch's HEAD.

How would this proposed feature differ from what
receive.denyCurrentBranch=false does now?

You have a commit X in a non-bare repo. Your checkout is checked-out to
X, your index has X's content in it, and the branch reference is at X.

Now you push Y to the branch reference, what would you like to have
happen to the checkout & index at this point?
