Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0277A1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 18:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbeHTVgA (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 17:36:00 -0400
Received: from mail-pl0-f49.google.com ([209.85.160.49]:40472 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeHTVgA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 17:36:00 -0400
Received: by mail-pl0-f49.google.com with SMTP id s17-v6so7517394plp.7
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 11:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/r//iaepMbK0v0HoBkvENdts0WYcGcAkXO5jc+ROOxo=;
        b=QhS+HS+AxZzJA4C/7NEeGtwF4MowvmnL6il1yKKemqjDE8FIu9eDLKLc4g0Q9AnUq2
         P9qNgxeJPboxw7+S7FraRD3frHyJcXEQXoEVurLRxBJoyZjXSJIYopnhVbaRpcYkVUb8
         klctLk3Dl7i5k5C8/44fgrKGwUK4Jl4uhRrQAMx3ZH6DjbwUI5lGr9WC4jHZ+2B7dnff
         i3I2buJ814z879GiGgehwCQWP0BlthxuvhdCZvf+wv7iL5f57fqjNH7KwbsU0Ve0cMyw
         iCdzvyit0c03djWjaNsFrMVuXFuZsxSkmmanEWhTjEk7zTlgPtV2QUSHil4CYsv6nTMG
         QOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/r//iaepMbK0v0HoBkvENdts0WYcGcAkXO5jc+ROOxo=;
        b=nfB/Vi35jlnbeaYcKlxzHovWPK2japPG0hvo28DqTQs2WU+FUAUUToTfC9REhsSTUi
         EIX/32ZMNdaaMVqAHLABICLeI7EpK/xdwLahV750tFBHOvC+pn6e6+H6PJChq9SbS0Bs
         imjkZDwan7nScGU2XZsim3PmDNA+M365wa0suuhNcnAj1kegcZskLEHVL6r99QkrH5aY
         EHoAGdQabdfJ/nnZ69597gEtZbcJYNBAHrbHbv+3XJl/ktQQoe9bs4RRqWgPVyyZYxfK
         u7o4ZIJYi0A6wgz7wvNryQbkWaOjF7Zr0H2LJpIBrgeFOZof40Dx72xky/nTMoGxWT/b
         eIbQ==
X-Gm-Message-State: AOUpUlETd77qG1nmLFsu8EMN1G25Lc5rTShqfdTfhU4HuKzMr/o2jd0A
        ks1Ig4Q3z3b1k6AQClcg8Fk=
X-Google-Smtp-Source: AA+uWPxV5ir/2ZXpCTgdYlchZaJHMWN6h8Lxc1ZCd0R+x1xjjkYgkqHZ786C3npKg5uRl50zvoPKeQ==
X-Received: by 2002:a17:902:724c:: with SMTP id c12-v6mr45884639pll.326.1534789158405;
        Mon, 20 Aug 2018 11:19:18 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id t15-v6sm18505113pfa.158.2018.08.20.11.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 11:19:17 -0700 (PDT)
Date:   Mon, 20 Aug 2018 11:19:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2018, #04; Fri, 17)
Message-ID: <20180820181916.GA31020@aiede.svl.corp.google.com>
References: <xmqqva88aa0c.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqva88aa0c.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> * jh/structured-logging (2018-07-25) 25 commits
>  - structured-logging: add config data facility
>  - structured-logging: t0420 tests for interacitve child_summary
>  - structured-logging: t0420 tests for child process detail events
>  - structured-logging: add child process classification
>  - structured-logging: add detail-events for child processes
>  - structured-logging: add structured logging to remote-curl
>  - structured-logging: t0420 tests for aux-data
>  - structured-logging: add aux-data for size of sparse-checkout file
>  - structured-logging: add aux-data for index size
>  - structured-logging: add aux-data facility
>  - structured-logging: t0420 tests for timers
>  - structured-logging: add timer around preload_index
>  - structured-logging: add timer around wt-status functions
>  - structured-logging: add timer around do_write_index
>  - structured-logging: add timer around do_read_index
>  - structured-logging: add timer facility
>  - structured-logging: add detail-event for lazy_init_name_hash
>  - structured-logging: add detail-event facility
>  - structured-logging: t0420 basic tests
>  - structured-logging: set sub_command field for checkout command
>  - structured-logging: set sub_command field for branch command
>  - structured-logging: add session-id to log events
>  - structured-logging: add structured logging framework
>  - structured-logging: add STRUCTURED_LOGGING=1 to Makefile
>  - structured-logging: design document
>
>  Will merge to 'next'.

I believe this is under-reviewed (which I certainly share some blame
for).  Please hold off and I can look at it today.
