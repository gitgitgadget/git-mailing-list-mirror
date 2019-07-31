Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29EBA1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 15:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388373AbfGaPCB (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 11:02:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34648 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387946AbfGaPCB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 11:02:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id s49so31176841edb.1
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 08:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=D6ONyyeEp+uVIMsF1A9b4xtyHecC1Tsb16uFZLmVnWA=;
        b=YwmLAcbIKXYQ404aOmVVbEY1rNzXLBBbijXAH424qBFfzDbtUPqpAueJRgRjYh9i+3
         TPFcpF77q9KCjGYM9loK+zJ/e5uywn7pMzhVytWJQw0V3alCY1/DYfW64vbV8OUIFsUx
         mpvQaZT8fRhFqwUbsTEUDYrTdTeshwS4v5S6V+bwPAnnY9WETTruT1j8sZLhP8dWq64e
         c2uqPBn5EQKhekXJTVI6OYeutda5aZSnEtxUi4aGXw7/FU0lp20oyHU1k0ljyamN/bbX
         8xgzjWCblB2GuinZL8VRP4/WROxyvbYdlVcecRkqXr5vdYkN6y9bKhNPviD0B7JUEl61
         8nXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=D6ONyyeEp+uVIMsF1A9b4xtyHecC1Tsb16uFZLmVnWA=;
        b=fppX4qvi6QzYysTbE9j+nEd+/DbUANFGZi0S14g5T1umNcYZIRPHxZExLaU88A5s+Z
         CVQsIZEMYvPb46tY+YJZpxJyiWHh64MxzSlMlX1GfHNdgx4y/+SwavcM8XZniihIpCM9
         rHZ2UijX+1FzLVy4QtnKrb4iiH1OtNqf/PLZqZbAemiKXM5YtHU7shgJItflrX2icI89
         3XR5l77joynz/n/KjwNhJWjaRv9GZxGuhHkhfTnHXAI9Uq3RNTKxI5TvnuMl0dfD8wkX
         VHKPitg2UdJRgpG/uNApPM1a5TsnWJ0cV9tnB3Alf6EShv8I9muF7TUrF087AVIKCqhK
         OYGA==
X-Gm-Message-State: APjAAAUDQcxCzNxwxA8sogn5khETGe0HMYMj4cOorrHwOe5dJr/Mjr7W
        NOMu1TeRqrbJQ0kJu7ZRRDC5GuxV
X-Google-Smtp-Source: APXvYqwQTQNX3hHu/D5++L1xjeckGZXzmBkY7FMQ1QmnP7fIzwmLKvQwyJg7DnFZd8PfBLFEOLBJsQ==
X-Received: by 2002:a17:906:a3cb:: with SMTP id ca11mr97234644ejb.79.1564585318939;
        Wed, 31 Jul 2019 08:01:58 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id y11sm12442219ejb.54.2019.07.31.08.01.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 08:01:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        jnareb@gmail.com, pclouds@gmail.com, carenas@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 2/5] repo-settings: add feature.manyCommits setting
References: <pull.292.v2.git.gitgitgadget@gmail.com> <pull.292.v3.git.gitgitgadget@gmail.com> <c0129066a02b39535110ae592c16ca0e5d6d6c24.1564515324.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <c0129066a02b39535110ae592c16ca0e5d6d6c24.1564515324.git.gitgitgadget@gmail.com>
Date:   Wed, 31 Jul 2019 17:01:57 +0200
Message-ID: <87mugu5jtm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 30 2019, Derrick Stolee via GitGitGadget wrote:

> +feature.*::
> +	The config settings that start with `feature.` modify the defaults of
> +	a group of other config settings. These groups are created by the Git
> +	developer community as recommended defaults and are subject to change.
> +	In particular, new config options may be added with different defaults.
> +
> +feature.manyCommits::
> +	Enable config options that optimize for repos with many commits. This
> +	setting is recommended for repos with at least 100,000 commits. The
> +	new default values are:
> ++
> +* `core.commitGraph=true` enables reading the commit-graph file.
> ++
> +* `gc.writeCommitGraph=true` enables writing the commit-graph file during
> +garbage collection.

During the whole new commit graph format discussion (which has now
landed) we discussed just auto toggling this:
https://public-inbox.org/git/87zhobr4fl.fsf@evledraar.gmail.com/

This looks fine, but have we backed out of simply enabling this at this
point? I don't see why not, regardless of commit count...
