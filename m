Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ED9320248
	for <e@80x24.org>; Sun, 24 Feb 2019 15:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfBXPDJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 10:03:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46908 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfBXPDI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 10:03:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id i16so7148105wrs.13
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 07:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=X7iz5YOAVy7QWTDYJxy7M5eLo3qPUItPIApCReJadTk=;
        b=ZuJdhbEJLXCzRfwbcWX+khPWbW7EuZ/Ufj8xJZaYp/dfudpDZTYiEoKN6f+G7wy6EG
         6aY4xgSbab77I5mVkbE4pzaO4KU72Zh9uyMZ+l9+nOZrsAXAg6i0v2M5KLRVv4qxzYwQ
         yT5xOYOs/q0zI01XIQjJLBWfr2jN4a5jV6IjsTxrnFv9/0ZgyoiQAZ2nEaM02I+4Ht5r
         lNxoH6g1Z2F7k3wLtolEJBc3rtFDJYl1fgu9XiG32ARasrFyx65TX/Pf2mWkOz5VKz2S
         /t7cmizU/1udqEK1v3el6lmKMrkqvwKOBT98yDhPAa31/UzvBNfvo3rgY8WvSF0rqeIN
         4znA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=X7iz5YOAVy7QWTDYJxy7M5eLo3qPUItPIApCReJadTk=;
        b=cTSK40IWBtk9wuXqKU3q4qOa4Ps7FrkJGrkuWBs+ukpx3wq/bHoUmyjFuRiXBxKdgT
         UQ6V7nuQBWmn0G7dGqd+Ry5p/3aYsDbA9YleatX02OlhIP0ggWtc4F6+9ZKSSA1GWqYa
         Oj57I6mA+n2Csa692SJuEUEF/wPp+E/KKhN7L71lDUp8PNgWxTuK0qGZJiDKNi13q/es
         5RW0gMFE9apxoM5Ch6JTTMZytZpLhGHBaVfQvivcgr42QKvc5lTuNcYAFhbn7UgC3jBA
         E7pml70DeIRkFJ7njfOHFkE+pCUvknQBpTdzQ0K6ttQ2ZXem+4ZlKrS6hWrywgvNOgz6
         /fag==
X-Gm-Message-State: AHQUAuaOxbpq+AE/Ellk8Jgf69edT5gTje0zVR3jSuJ8AhGz7afT92aP
        g49wJfNT7AlA8fbjfxZUG2M=
X-Google-Smtp-Source: AHgI3IYOeR7DGNIT54pdVpWdQASGX5oH3GG+htGjtGah1N3r7x/zremB/rABx+GqpElYBo2QVurDzQ==
X-Received: by 2002:adf:fdc3:: with SMTP id i3mr9045580wrs.252.1551020586468;
        Sun, 24 Feb 2019 07:03:06 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d1sm2598679wrs.13.2019.02.24.07.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Feb 2019 07:03:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Christopher Diaz Riveros <chrisadr@gentoo.org>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Fabien Villepinte <fabien.villepinte@cdbdx.biz>,
        Fangyi Zhou <fangyi.zhou@yuriko.moe>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        =?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
        <pclouds@gmail.com>, Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Sebastian Staudt <koraktor@gmail.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBR?= =?utf-8?B?dcOibg==?= 
        <vnwildman@gmail.com>, Vasco Almeida <vascomalmeida@sapo.pt>,
        Zhilei Han <linusboyle@gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.21 round 2
References: <20190224071630.5639-1-worldhello.net@gmail.com>
Date:   Sun, 24 Feb 2019 07:03:05 -0800
In-Reply-To: <20190224071630.5639-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sun, 24 Feb 2019 15:16:30 +0800")
Message-ID: <xmqq1s3xns9i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> Please pull the following l10n updates for Git 2.21.  These updates come
> from nine l10n teams (Bulgarian, Catalan, German, Greek, Spanish, French,
> Italian, Swedish and Simplified Chinese).  Jimmy contributed the essential
> translation for Greek and formed a new l10n team.  Alessandro made the first
> contribution for Italian since 2013 and became the new Italian team leader.
>
> The following changes since commit 2d08f3deb9feb73dc8d21d75bfd367839fc1322c:
>
>   Merge branch 'ea/rebase-compat-doc-fix' (2019-02-14 14:28:22 -0800)
>
> are available in the Git repository at:
>
>   git://github.com/git-l10n/git-po tags/l10n-2.21.0-rnd2
>
> for you to fetch changes up to ab8f4f5d73caaf2713346b456de095df690e8cf5:
>
>   l10n: bg.po: Updated Bulgarian translation (4363t) (2019-02-23 23:29:23 +0200)

Thank you and the whole l10n team as always.

Will pull.
