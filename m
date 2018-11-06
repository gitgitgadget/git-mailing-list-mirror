Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB1551F453
	for <e@80x24.org>; Tue,  6 Nov 2018 08:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbeKFSVu (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 13:21:50 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:38759 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729867AbeKFSVu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 13:21:50 -0500
Received: by mail-ed1-f52.google.com with SMTP id a2-v6so5230409edi.5
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 00:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xLBV38WzFbddvx6vPjjbuS+XfRs8wyE1KfG3NtM844E=;
        b=EB3zkUQ/MQXolSBzbt2dE70p+I91NrFi0bqINa3rnf1bgmFm3Pk/Rrv1ppFK73cbwU
         s8c5O2UvExoj9F0P3HKiXIMh3lFaMh90ekWL1cXmRs3NcqaUpUmzQd2lS8NhYyW3NSXa
         m/LRUSDV6Y+c2HwehM8xu/dJX2zbUL7pFZAKgnMO+ZjcxoEt9KRJvD9gXCIZjBWgtxwc
         NSLbnyrjzYi29XUSMSAD2ZyRN79k/xfNkD6g2vY7NUUxRgEiH5i3Xky/MXTqHZU1Vibh
         GKx7Hv7TMT4WvJLoGNA/R4JA6Ue95pZlw5t+giw3jCcWqWEiGsdR2NxKawACJ4bwhQWL
         OHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=xLBV38WzFbddvx6vPjjbuS+XfRs8wyE1KfG3NtM844E=;
        b=Y5OnVUIKb4ia0Ddg8RnhCmiSEqCKQKKKdQJmbFuqwlW2eNlW5BpYyeBK1vRgRQg7OE
         B2qznQoNjAmnke9RPMN9xx0Hw+VLvViaHzF8vderMcJbwMgofNpzApfoviW8L9cHteii
         1C6vTzr63hCFQ+ZAE1lMrXjH1LzvBo3yB2ecriYfh3jDZw1jc3E2LYb/a4arrZynxE5v
         pRFO67VQBYTRL9jPcZ3GjgyGUe1T2lD5sBVJNlXnDTpmOa7wqNY58BQPjU3t4v+voYo7
         lhkQNmMIKX4krZy4e9YSSMqxvslbOSI2SdCsXTGpDWZpsDjN3kNW/11pfI08qgvocUEt
         AfyQ==
X-Gm-Message-State: AGRZ1gKzI83gvXMo9rkszqfsSDh4Bks+CymR+hNeR6D8qN3QlNThxuzU
        BisNR78wHDjQeJirxeCLKaM=
X-Google-Smtp-Source: AJdET5euN6A4pTrLY1Z/UqXOIIZXfokk3zyQTpo+rh6wskovIEeyl3DUO5Yaai2cmGbPvkq/ZLj2+Q==
X-Received: by 2002:a50:b68a:: with SMTP id d10-v6mr8429054ede.101.1541494657059;
        Tue, 06 Nov 2018 00:57:37 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id r8-v6sm10331667edo.19.2018.11.06.00.57.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 00:57:36 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] sequencer.c: record revert/cherry-pick commit with trailer lines
References: <20181104072253.12357-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181104072253.12357-1-pclouds@gmail.com>
Date:   Tue, 06 Nov 2018 09:57:35 +0100
Message-ID: <87bm727fcw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 04 2018, Nguyễn Thái Ngọc Duy wrote:

> When a commit is reverted (or cherry-picked with -x) we add an English
> sentence recording that commit id in the new commit message. Make
> these real trailer lines instead so that they are more friendly to
> parsers (especially "git interpret-trailers").
>
> A reverted commit will have a new trailer
>
>     Revert: <commit-id>
>
> Similarly a cherry-picked commit with -x will have
>
>     Cherry-Pick: <commit-id>
> [...]
>  I think standardizing how we record commit ids in the commit message
>  is a good idea. Though to be honest this started because of my irk of
>  an English string "cherry picked from..." that cannot be translated.
>  It might as well be a computer language that happens to look like
>  English.
> [...]
> @@ -1758,16 +1757,10 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  		base_label = msg.label;
>  		next = parent;
>  		next_label = msg.parent_label;
> -		strbuf_addstr(&msgbuf, "Revert \"");
> -		strbuf_addstr(&msgbuf, msg.subject);
> -		strbuf_addstr(&msgbuf, "\"\n\nThis reverts commit ");
> -		strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
> -
> -		if (commit->parents && commit->parents->next) {
> -			strbuf_addstr(&msgbuf, ", reversing\nchanges made to ");
> -			strbuf_addstr(&msgbuf, oid_to_hex(&parent->object.oid));
> -		}
> -		strbuf_addstr(&msgbuf, ".\n");
> +		strbuf_addf(&msgbuf, "Revert \"%s\"\n\n", msg.subject);
> +
> +		strbuf_addf(&msgbuf, "Revert: %s\n",
> +			    oid_to_hex(&commit->object.oid));
>  	} else {
>  		const char *p;

Others have already commented on the backwards-compatibility /
switchover concerns, so I won't spend much time on that. Except to say
that I don't think changing this would be a big deal.

Anyone trying to parse out /This reverts commit/ or other pre-set
English texts we put into the commit object is already needing to deal
with users changing the message. E.g. I have a habit of doing partial
reverts and changing it to "This partially reverts..." etc.

Leaving aside the question of whether the pain of switching is worth it,
I think it's a worthwihle to consider if we could stop hardcoding one
specific human language in commit messages, and instead leave something
machine-readable behind.

We do that with reverts, and also with merge commits, which could be
given a similar treatment where we change e.g. "Merge branches
'jc/convert', 'jc/bigfile' and 'jc/replacing' into jc/streaming" (to use
git.git's 02071b27f1 as an example) to:

    Merge-branch-1: jc/convert
    Merge-branch-2: jc/bigfile
    Merge-branch-3: jc/replacing
    Merge-branch-into: jc/streaming

Then, when rendering the commit in the UI we could parse that out, and
put a "Merge branches[...]" message at the top, except this time in the
user's own language.
