Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F18341F453
	for <e@80x24.org>; Fri,  5 Oct 2018 08:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeJEPQo (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 11:16:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46243 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbeJEPQo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 11:16:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id a2-v6so5522174wrc.13
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 01:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=zEVmJMN1Z9STYqTis1Nbw+i5vAno4debMxNxvu+FxDU=;
        b=gCh5EPL/Xi2m+kqOGdIqhGx1nNAo0q+oYLG7AGmdzQh1DMxgoJTIdT0ZsDY7EJ+Wmq
         d3Zpg3f4Dtj7xAkvIV3KQNW6RfBTzz+dPTuZP+EnOiUbLdLaWkib/GzcvvcocQaaBoY+
         Qu62OjX7ZolWL2RLLDx84G+paM/r7cN7i0I3HecgSjrErGyPhDyVHbJ4eUpy33rfNs8r
         lp24ZlNRP22fZk2sb2ce4yX90on7G6pon4+1Kv+aEl1TTNU4CLcm0wzvkpyLg/HZ+5SN
         oJ8auc1dymW54GhaBg8YRKbVgRiw8imRf6Kk52qFwNN16a+gnqE2ecp2FDVLqbmOw+5p
         xERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=zEVmJMN1Z9STYqTis1Nbw+i5vAno4debMxNxvu+FxDU=;
        b=jVKePMgZKDo0jk70gZ+rNFvShcqltih9klQ599bSNmvGh5VMC0sKZDhZyGKX84wdon
         2xREbIGhmzdhIYQqxxpP7GOY+hOBaRdbppKHbfc4GV+shMGFqlRykl/K0XVIhGZ9w2NX
         yt2P90wzkrmJvnAresOXlU+babSunWsoKq8tVYpkh+JZxq2ZLbDyXlGit39MCebxmPA/
         Vy6Row19vmhFwhI11nYGBWg+6LYNfLPzrWlGmUmnkeGG2SwBzfzaX+IuOMjPu7eeXPa1
         yPE3949dWWyatRN6TWrqksk+fB/fP8gCusjEHzPGxuLrTAAcvfMrSZPi6JB2EGvZtB6J
         6LKg==
X-Gm-Message-State: ABuFfojwhy4r9l1QXVEMyXmV5x3v/8fRms4fcEsZv2ThOXBjLp37Zf8h
        hz7RLY82iU0nwMwmgHg5784=
X-Google-Smtp-Source: ACcGV62S4/yMxXUn3wpGaJpwY3Yt7znCrnOLQfmt3v4kFtsyZlBhybSPhs3WkM48CbmXTtME/UG+fA==
X-Received: by 2002:adf:f84e:: with SMTP id d14-v6mr7465556wrq.174.1538727545722;
        Fri, 05 Oct 2018 01:19:05 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l125-v6sm5365186wmb.1.2018.10.05.01.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 01:19:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, myon@debian.org
Subject: Re: [PATCH] grep: provide a noop --recursive option
References: <20180929140132.GA31238@msg.df7cb.de>
        <20180929145527.23444-1-avarab@gmail.com>
        <CAGZ79kbw96x2Dow7d-sUfOHXiVN8j9KgqEObo+TrVd5zWKbaEA@mail.gmail.com>
Date:   Fri, 05 Oct 2018 01:19:04 -0700
Message-ID: <xmqqftxkztzb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> git-grep is always file/tree recursive, but there is --recurse-submodules
> which is off by default. Instead of providing a short alias to a noop,
> we could use -r for submodules. (And if you happen to have no
> submodules, this is a noop for you)

I am not sure if it is an overall win for those who do have and use
submodules to easily be able to go recursive with a short-and-sweet
'r', or even they want to work inside one project at a time most of
the time.  If the latter, then using 'r' for recurse-submodules is
going to be a mistake (besides, other commands that have 'recursive'
typically use 'r' for its shorthand,and 'r' does not stand for
'recurse-submodules' for them).
