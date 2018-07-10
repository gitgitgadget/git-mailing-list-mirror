Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E98991F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbeGJSSU (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:18:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53463 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732200AbeGJSSU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:18:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id b188-v6so25603953wme.3
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 11:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rcqsQjaQU0wGHEyI/lUi0AEbX9fDKKivMeQEfwh+hYc=;
        b=KPbDLVG1p3+WEVmcE3XNaPQCA8VXRaqbiqhRyjEY1uh/6eKXl8cHRKWDncGGLTZhP3
         X0cVdgo+DBap7TJcIEpKkNDAU3xoTf4c9WEiidoLtrdOL/y6LFySTEqyKCxXoxDCpxuN
         Z5cbx9GSCVU5mRq/aZ7XyIladivYS9g5bNFRack2IDO8YSOsMnaZo5PUc/Km4POerph+
         o7CdOHdOiv8g/GOeJ+ZMhjeR1S8RxOhSjGlsSgLo6FgJobml6RmFBOaYAtDxTC2zkk7b
         akHoDa6PaSrWxXAV9R3+r1BhsjeFVUh5O+pbT0HRQQ85QyxE5l9v//ASeOSS7UWrw5OS
         B0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rcqsQjaQU0wGHEyI/lUi0AEbX9fDKKivMeQEfwh+hYc=;
        b=JA7DlmeVAOvDcq+TxBlLllyDwyG7Pp0u6UXbRPy96l3shXlePzFPNHWZD4XGIBnPu9
         U1o8XP8LMMsQBff0PnDTPAvpeoP7Yrg9ovJYuqWs28IMeHUcK8W4L7VfNV/FonvfLC3V
         CYeWU7t1XuKHvjV9N2wN4wiieKN05oZj+m7uHIYroWdS3LwImDlawNBHoI9AAtZcu74p
         yWcTYD/sYxZYNJqtK35RNH6OqimEuU48EVOnU61cOwVAQdLy1GFO6RtBctAfDNexYssF
         RCQZtvaZq+pz+1PkjUq+spgT0ApoFDjYH4UslpAhEYZJxqmB88VlV8cT8/jcKYzE+oCm
         HQHw==
X-Gm-Message-State: APt69E2T9ZpZVyr5jQNsuXX47CqUpeQOLKKaB0oPcgwDN7rO/x8T5/jZ
        n4qE7cO9zNc9Y8ECf5EYzPaZ3iKk
X-Google-Smtp-Source: AAOMgperQHhYTl5hiN/CnrxRWOpzZp1WfMsAJKMRA6YTqxiHWkVUUFN209hqLmWAisJJ/xzb3o1CaA==
X-Received: by 2002:a1c:1183:: with SMTP id 125-v6mr15112214wmr.138.1531245191878;
        Tue, 10 Jul 2018 10:53:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t140-v6sm15478228wmd.14.2018.07.10.10.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 10:53:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v3 01/13] sequencer: make two functions and an enum from sequencer.c public
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180710121557.6698-1-alban.gruin@gmail.com>
        <20180710121557.6698-2-alban.gruin@gmail.com>
Date:   Tue, 10 Jul 2018 10:53:10 -0700
In-Reply-To: <20180710121557.6698-2-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 10 Jul 2018 14:15:45 +0200")
Message-ID: <xmqq7em37zax.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This makes rebase_path_todo(), get_missing_commit_check_level() and the
> enum check_level accessible outside sequencer.c.  check_level is renamed
> missing_commit_check_level, and its value names are prefixed by
> MISSING_COMMIT_ to avoid namespace pollution.

It is not too big a deal, but we prefer to hear our story told in a
consistent voice.  We'd phrase often the above as if giving an order
to the code base to "become like so", i.e.

	Make X, Y, and Z accessible outside sequencer.c; rename A to
	B and prefix its values by doing C to avoid namespace
	pollusion.

> This function and this enum will eventually be moved to
> rebase-interactive.c and become static again, so no special attention
> was given to the naming.
>
> This will be needed for the rewrite of append_todo_help() from shell to
> C, as it will be in a new library source file, rebase-interactive.c.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
> Unchanged from v2.

You added an excuse for being sloppy in the naming to the log
message; the log message is an important and integral part of the
patch, so please do not label an update like this as unchanged.

"eventually" is fine, but that means we cannot split the early parts
of the topic, once they are polished well enough, into a separate
bit and have that graduate earlier than the remainder of the topic
until that "moved and become static again" happens, which may be a
bit unfortunate.  Let's make sure we can get to that "eventually"
step soon.


