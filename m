Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C7841F453
	for <e@80x24.org>; Mon,  4 Feb 2019 17:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfBDR40 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 12:56:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38151 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBDR40 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 12:56:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so888000wml.3
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 09:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=s+GBaGEZe4FcC6J13vg1NMHhwwI8YEhQ3B8cia/ZvGU=;
        b=EtBcfU9RQrqudw53ewO/xWV3SIZyQYwFkyV4B1ryYpgUQhTTJSw2FGnKt1tM9aUysG
         phbYHNBAt3jrq8FCQjkv0j3wSi5OJSMvKymj1Wyr287CgJgeAahqHwbmdE7Gk9WsRwov
         O8HFUEERMXSKHZeSHYfDKKON9K4v75T0+3TXGnvP2EM6ouWwGqW7ooeebtgcVL3tD5SS
         4Cw62E0Ul0arJut/pFiDY6FW2P4Js3V+wGTIwOPsUIPyeFli4sSpjyxFc07Tzz2b6SJb
         o6201lW/xHnyyk5YUYGAoYrr/ZM+QgBcSahSQaj0YBQJXdiMsunSsivnnmkctQQcyQ2J
         Kipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=s+GBaGEZe4FcC6J13vg1NMHhwwI8YEhQ3B8cia/ZvGU=;
        b=e9vrb+pnLsIMLJo6Mglnh1jbhltyQLdkKyLVjcKI2CWPEk55oI4o9vyC7asEhKlDxe
         w7gmUX3JpMTJa4/PUPv9PP6NbywzAPV11BhwTWMu8eTiTfdE5Ramiv7+g+eegDIqmJWo
         mMb0EhWoz8dP3z+vYFyYg2lh47e4FXYJdSO2oIyrUN+3mKdh7i49p30cGgFztVoloEZc
         Am+lx/22ohc+D7dvzPykNf47ilFHbyvTUzJENHd6JvmkbIeFutEfl6fTYhOVvCya9urM
         Zo57MAmA1hAwNGStRxwo0CIHuE7avnrdggPaTw+6Ts3xG3z85mqvHY7zZjXbY22Ii9eL
         wpFQ==
X-Gm-Message-State: AHQUAuY6vY0E/mB776saTNN/t6S7T2ZiEsXvSz3EuiS1y4iP5Dy/t7OO
        IT880HaUUI+UWWXsfv7D2Cc=
X-Google-Smtp-Source: AHgI3IZF/q/YA/4VtPUy9ATk7CLB9HOfCUR2YSrXYC52pn7mnK4AiggntF+cMpmoaSYkzAHUWi5P/g==
X-Received: by 2002:a1c:c707:: with SMTP id x7mr446596wmf.120.1549302984188;
        Mon, 04 Feb 2019 09:56:24 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k3sm11834089wrm.7.2019.02.04.09.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 09:56:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shahzad Lone <shahzadlone@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 [re-fixed] ] [Enhancement] Improve internals / refactoring.
References: <01020168ab79f642-10a06c5b-c3f7-441e-86f8-bff5e41ac834-000000@eu-west-1.amazonses.com>
        <01020168b080030b-eb0a0634-f2b9-42ed-a3be-76995e7127eb-000000@eu-west-1.amazonses.com>
Date:   Mon, 04 Feb 2019 09:56:22 -0800
In-Reply-To: <01020168b080030b-eb0a0634-f2b9-42ed-a3be-76995e7127eb-000000@eu-west-1.amazonses.com>
        (Shahzad Lone's message of "Sat, 2 Feb 2019 23:16:45 +0000")
Message-ID: <xmqqbm3rwi7t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shahzad Lone <shahzadlone@gmail.com> writes:

> Subject: Re: [PATCH v3 [re-fixed] ] [Enhancement] Improve internals / refactoring.

Since all patches are attempts by their authors to improve
something, the above has a very low information density.  As all the
changes in this patch are about const-ness, it would probably be a
good idea to sneak that word into the title---that way, when placed
among many changes, a reader would be able to still recognize what
this change is about in "git shortlog --no-merges" output.

Perhaps

        Subject: [PATCH v3] tighten constness

or something?
