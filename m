Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B113820248
	for <e@80x24.org>; Mon, 15 Apr 2019 07:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfDOHTB (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 03:19:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42103 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfDOHTB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 03:19:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so20406296wrx.9
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 00:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=C86xydEbYUKmgfUn+IDHdkiXHc0TTJHK+VmF5cb7gAY=;
        b=Sy8tb/3WhFBdbjUXATnajLiyrRE7p5Hg1r79uvs/EewYdnptIdkcN2eMXaM3Ix2y+b
         mwOwj65cxfBwrxAYBW6UAijtca5AvXe7TCe1ETrSVh81mUXsI88rxpmVo13OedzvrI8w
         8guGtBMEF53ogso9MAiXaCPzBTt4lne0bN/e6IDkJovMp9UTEPaWq9Kv3HuXdGFoLA3S
         n1v2dOZWoEWiLqEDWBc2z9Qinm28z80Brf1AvIg1RHKa8+bN/2nE8raBCOw094alOfY7
         EmKNPmSpgGN4YISYq1yKttZUKkjqvRCUOblL4vtJt8gJfgbjzkE8rVuB92hl27yTHlqo
         oPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=C86xydEbYUKmgfUn+IDHdkiXHc0TTJHK+VmF5cb7gAY=;
        b=YWrhVIjXWvFHdmloCCH7h6TwkymgdnHB/Un5DRf9Hn3t7sIU5przXUxdiGUBlKGuqJ
         W9+mNvNnsKM+gJLNKKWMG7gkhkAP+oKSm+rtuel467R4l8tYIVwXpKWY8WoiIRiGanea
         dAwQjFRI1/6XaEENsFd+M1yQvXAf71kAB1O0JrgJJq46unHziCcm3xWibllhxG5v4El5
         hg3qNIc4SC957FWwL4Hh2cLdZ1wDIIATsMN0WpFyZ9OWsoDNcsHpnYz7LoTO6ZkmFkAM
         HHcGsmk6akr/VxbwgGDTB+X0XvWrTUbVei3EHp1QmkVPCS8O0HwZc4LZtTtqNMnZ6ka2
         8Lcg==
X-Gm-Message-State: APjAAAU6+42tQEAMaFX8dwI6/CZ2EIBsmYOkBAaec/HBXFbFnG2e5uH8
        kaZhQ5NFq6NvhQ6zdV1/qxU=
X-Google-Smtp-Source: APXvYqzV8DyFgfKWWmiTH6UOpMR3MVGSmwI4Qib1OQBf02UWDpSItXVhj5wr6XzlF6X7wsslDvDhCA==
X-Received: by 2002:adf:9427:: with SMTP id 36mr47581858wrq.128.1555312739097;
        Mon, 15 Apr 2019 00:18:59 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o10sm74513704wru.54.2019.04.15.00.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 00:18:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/7] check-docs: do not pretend that commands are listed which are excluded
References: <pull.168.git.gitgitgadget@gmail.com>
        <96ced7e17cb40c4d0f15955c482857196862ab80.1555070430.git.gitgitgadget@gmail.com>
Date:   Mon, 15 Apr 2019 16:18:57 +0900
Message-ID: <xmqq4l6zsplq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Subject: Re: [PATCH 3/7] check-docs: do not pretend that commands are listed which are excluded

Sorry, but I cannot quite parse the title.  I am guessing that you
meant "do not pretend that commands, which are excluded, are
listed", which is a mouthful but at least can be parseable X-<.

> In the previous commit, we taught `git help -a` to stop listing commands
> that are excluded from the build.
>
> In this commit, we stop `check-docs` from claiming that those commands
> are listed.

I think the result would become more readable (and I suspect that it
would at the same time make the title parseable, but I am not sure
as I do not quite know what the title wants to say in the first
place) if you clarified the verb "list" here perhaps with "listed in
command-list.txt".

The output from the sed script that filters the contents of the
command-list.txt file is compared with the ALL_COMMANDS list, and
we complain if an entry in command-list.txt is no longer in the
ALL_COMMANDS list (i.e. a developer removed a stale command but
forgot to remove it from the command-list.txt) [*1*].  

The step 2/7 marked the subcommands that ought to be on ALL_COMMANDS
for the purpose of this check but that are excluded from the build,
as a preparation for this step, and this step 3/7 uses the list of
excluded ones to avoid complaining them being in the categorized
list of subcommands (i.e. command-list.txt).

Makes sense.

	Side note *1*.  Another thing we would want to catch is a
	developer adding a new subcommand to ALL_COMMANDS while
	forgetting to give it a category in the command-list.txt
	file.  That is done in the "other" loop before this part,
	and the patch is correct that it does not touch that loop to
	filter the command-list using the EXCLUDED_PROGRAMS list.

We can read that "stop listing them" is done as means to some end,
but it is unclear what the end-user/developer visible effect this
step intends to achieve.  After thinking about what the patch does a
bit more, here is what I came up with.

    check-docs: allow excluded subcommands to be in the command-list file

    One of the things this build target makes sure is that all
    entries in the command-list.txt are about subcommands that still
    exist in the system (i.e. if a developer removes a subcommand
    and forgets to remove it from the command list file, it needs to
    be flagged as an incomplete change), and it is done by comparing
    the entries in the file against the list of subprograms in
    $(ALL_COMMANDS) variable.

    However, the latter list is dynamic---not all build contains all
    the Git subcommands categorized in the command-list.txt file.
    And such a partial build would falsely trigger the check,
    complaining that some subcommands are removed but still are
    listed in the command list file.

    Fix this by teaching the logic to use the EXCLUDED_PROGRAMS list
    prepared in the previous step.

or something like that, perhaps?

The same logic to warn about "removed but listed" commands that are
not built (hence missing from ALL_COMMANDS list) is also fed the
list of all documented subcommands by looking at "make print-man1"
in the Documentation directory, so that it can issue "removed but
documented" when a developer removes a subcommand but forgets to
remove its documentation.  Don't we need to teach a similar
treatment on that side of the coin?

I am wondering if it makes that easier to instead add EXCLUDED ones
back to ALL_COMMANDS on the receiving end of the pipe, rather than
filtering them out in the sed script that reads from command-list,
i.e.

	# revert what this patch did to the upstream of the pipe
	(
		sed ... filters comments ... \
			-e 's/^/listed /' command-list.txt;
		$(MAKE) -C Documentation print-man1 |
		sed ... -e 's/^/documented /'
	) | \
	while read how cmd; \
	do
		# instead add them back here
		case " $(patsubst %$X,%,$(ALL_COMMANDS) $(EXCLUDED)) " in
		*" $$cmd "*) : ok ;;
		...

That way, the documentation side can be fixed at the same time as
the command-list side of the check that incorrectly reports "removed
but listed".

If we go that route, the earlier rewrite of the proposed log message
I suggested may want to be further updated.  Perhaps by replacing
"use the EXCLUDED_PROGRAMS list prepared in the previous step" with
"add the EXCLUDED_PROGRAMS list prepared in the previous step back
to ALL_COMMANDS list when checking entries from the list of
documented and categorized subcommands." or something like that.

Thanks.
