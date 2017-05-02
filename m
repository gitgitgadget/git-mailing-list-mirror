Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1D80207E3
	for <e@80x24.org>; Tue,  2 May 2017 00:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751082AbdEBAcv (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 20:32:51 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33071 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbdEBAcu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 20:32:50 -0400
Received: by mail-pf0-f169.google.com with SMTP id q20so27334217pfg.0
        for <git@vger.kernel.org>; Mon, 01 May 2017 17:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4Uf9YGCiQTEUbn2KvnsO27SEvfjvUrHQTSbunkSp40c=;
        b=VZu6JyMYU0SFuHD6IZytLgcJICJTGwuKhN2VKyYDPbrQu7y6h5zB3hv7rLCcmG+q0Y
         tuA/t8jEabdiSAhYDpvH/bDMQzVX5ka50H3Q5F6/ZLEpxTVL24LIJuMP5Nw6x+xeiEwO
         CYObVvNmZOsqa3mrKRsgXBpDSXrsmMFVHzEnprjOghoiT0DSwM8cSaDpHTRXJOTQx++a
         gbYmNzZyrWXckq11/Vh33cjyE7PTCxvCNOjUk71rl4fuT7jyZ5kX/nosmEFb+guzQ4T6
         fQXqa+VAiTuPjdD9tQrQ7EbO/SLC9gAg9PsytWgL/rQovQRRjwvEJdqH6dLE0AjAKZT4
         wGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4Uf9YGCiQTEUbn2KvnsO27SEvfjvUrHQTSbunkSp40c=;
        b=ogFa77V+0/YPVdkTwhXz2FkYMECLeqaJCGbHNBhRsIHCjtxoehhWBomVg4jAbtye/q
         bQ53S9lbFHS6/T15h9dXYhOaT66SaMs7/d2O1A21Ym7mK8CYv7Yo7h09tJrrEwZFXlmB
         E/zJPfVx81lEvI0Lpa+c8jQ2+aweedGRDZcznDno2M7NcWOkwbDBI+N0ibypoioCrZ/m
         U4ncLsOoJCzUq+8AuCAmxOQ2wRMMOBGNvJkqzVGVMI/YDoD4JFmYLwZRGpzX4TBvj6E9
         ObRlwNNTpEJe30OSBVgjQURyYCYSm1uK+b7NUqERu22NqRXBGbz0siBCidnw/nqqwZdG
         W71Q==
X-Gm-Message-State: AN3rC/6U5kNhbfLFgBz5GspBWYEbgaERDfb6bvzX2SATC5NL73w7J2ol
        ddFQBZ4GE7fzyA==
X-Received: by 10.98.33.29 with SMTP id h29mr29369648pfh.248.1493685170238;
        Mon, 01 May 2017 17:32:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3c5e:d1c1:579c:ef99])
        by smtp.gmail.com with ESMTPSA id u78sm6950851pfa.47.2017.05.01.17.32.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 17:32:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Daniel Ferreira \(theiostream\)" <bnmvco@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC] [GSoC] Port git-add--interactive.perl:status_cmd to C
References: <CAEA2_RLvjRDytE03hfe84TTqvCQm324BXV=GvTU3UVqNWJUXiQ@mail.gmail.com>
Date:   Mon, 01 May 2017 17:32:48 -0700
In-Reply-To: <CAEA2_RLvjRDytE03hfe84TTqvCQm324BXV=GvTU3UVqNWJUXiQ@mail.gmail.com>
        (Daniel Ferreira's message of "Mon, 1 May 2017 19:46:59 -0300")
Message-ID: <xmqqo9vcf68f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Daniel Ferreira (theiostream)" <bnmvco@gmail.com> writes:

> Reproducing either of these comparisons "natively" would simply
> require running run_diff_index() or run_diff_files() with
> DIFF_FORMAT_NUMSTAT and tweaking diff_flush() to format appropriately
> for the "interactive--add case".

A more usual way to drive the diff machinery and react to its
findings is to use DIFF_FORMAT_CALLBACK interface, and walk the
collected diff_queue to work on the paths discovered.  The way
wt-status.c builds "Changes to be committed" list out of the
"diff-index --cached" it internally runs and "Changes not staged for
commit" out of the "diff-files" it internally runs would be a good
example to study.
