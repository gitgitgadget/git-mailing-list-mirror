Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 173441F404
	for <e@80x24.org>; Tue, 10 Apr 2018 23:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754581AbeDJXbh (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 19:31:37 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:42441 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754405AbeDJXbf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 19:31:35 -0400
Received: by mail-wr0-f175.google.com with SMTP id s18so14360735wrg.9
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 16:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=R02sMQq1BXTw/xj/UEwZljOErEklAUqtRGJ033TPRJ0=;
        b=gHv3UNS/li5oSMlsMsCSdp8aCg/82THcNPlMALu0qxOEarEVQbcMMvA5XoD8KZ1G0e
         L2873j51vSfBudMQ3yvqR1dvHhjgLvhpJ4UoIanrCwh84exu8OTRI6LpsIVPx6eX07Ba
         2TEVTdyn5v21D9RkqEo6iQgo0rDlMucn41jXQ43+NOHYiJrGm1oEFCTg3yt5NaTxPqa8
         WEKTQNUSyAkK+P2aMzIJfAPd8bECLN1unGXeQxmIJH7zzE02w6aLza3BdlNJMBooLMCR
         IQlnpt/sbJlFEbFYoj9ukxeoYgK2GBLsoypycvBlf9Bk4i0CTGFNWgkf6a6xziTNPtfR
         tecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=R02sMQq1BXTw/xj/UEwZljOErEklAUqtRGJ033TPRJ0=;
        b=WYYZqZBSUELo5lxgJiNHciXhsNsj+vhs8f2Es6gW+1yVhqPCipOMoLMCykfDU+9l96
         U9W3ruI8V95yX42wHgxS0cvDXJmTQs0u9juhhkhs+zsoM24b3UC1Wrr0aRZuPZcOWUeN
         Zeg9Yzm9w0OFDy0Dgab/5jC+CnV6zzGtU1zlfq09BJI7gIb/TkXw9EXSTRPrjIDAATC8
         gmqLGv/Q7UvjTO1mWVUs93yAYIZUx0Z2dgX2UNj2RTLuv3B5LfhEzcOiXo/DGMavdgLn
         IkswjUZdTRAFMelLYBUSIEemAv8X7l8W5+VE4lBZjXftpHxUx5WfhMOdfrWKi9nmD6tb
         Dprg==
X-Gm-Message-State: ALQs6tBdQlWnJ3xua9iEiI8z/KM2ya/k+hmzohPCQdXFYfNst3auj6ym
        8/Lqa1zxc95/e0SQXNzs2N8=
X-Google-Smtp-Source: AIpwx48SrGj+xidFNEavN8eOwhx58d4qM2jJeuMpYo8mvc/gJbBJBjHLnlOLUAxv6Xlr7iBanWguPg==
X-Received: by 10.223.226.140 with SMTP id v12mr1537956wri.188.1523403094281;
        Tue, 10 Apr 2018 16:31:34 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id e10sm6777083wri.23.2018.04.10.16.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 16:31:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Chris Maes <chris.maes@macq.eu>, philipp@gortan.org,
        Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        philipoakley@iee.org, Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: git-gui ignores core.hooksPath
References: <74c84bda-4f3d-b2d3-91cf-e80e84fe46b1@gortan.org> <3a3eb88e-0d7b-e689-c4e4-207569ebd667@macq.eu> <xmqqd0z61xsv.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqd0z61xsv.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 11 Apr 2018 01:31:32 +0200
Message-ID: <87muyabpuz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 10 2018, Junio C. Hamano wrote:

> Chris Maes <chris.maes@macq.eu> writes:
>
>> Is there any hope from here that anyone will pick up this / these
>> changes? Will anyone else be assigned the main responsible for this
>> git-gui repository?
>>
>> Just hoping to revive the discussion here, since the
>> https://github.com/patthoyts/git-gui/ repository seems quite dead.
>
> It indeed does.
>
> I've played a patch-monkey in the past for git-gui and have a few
> topics queued still in my tree, but that serves merely as a bookmark
> that is slightly better than a pointer to the mailing list archive.
>
> We need a volunteer to take over this part of the subsystem;
> somebody who actually uses it, passionate about improving it, and
> can speak tcl/tk somewhat fluently (I qualify none of these three
> criteria myself).
>
> Any takers?

Isn't everyone involved much better solved if we come up with some plan
to split these off from git.git? I.e. I think if if git-gui, gitk and
gitweb were proposed for inclusion in-tree today I don't think we'd
bite, and instead point to things like [1] or [2].

Of the three gitweb is a bit more glued to the rest of the codebase
(test & custom test lib), but gitk and git-gui already have their own
external projects.

It looks like if they started making tagged releases, along with some
small Makefile changes like generating their manpages from ASCIIDOC,
downstream packagers of git-gui and gitk could simply start pointing to
those as the authoritative source instead of whatever gets shipped with
git.

1. https://git-scm.com/downloads/guis/
2. https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#Web_Interfaces
