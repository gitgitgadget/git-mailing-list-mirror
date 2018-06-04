Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CBED1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 13:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753063AbeFDNdi (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 09:33:38 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39152 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753197AbeFDNdh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 09:33:37 -0400
Received: by mail-wr0-f194.google.com with SMTP id w7-v6so31582089wrn.6
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 06:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=f+MmqoI02JhB93ZxctEwjGEdFgOMW6YsokLDsVeWs1s=;
        b=TXX+Y0ZpQHIiGcVOIC7XLgkg0Ib/UiDnuEPOdEZGvPC3U9dSYw5kzSPmrLgjq9vENE
         3CXkgKwxTaP+yqDGrsuK/r1aMt/VUKZYn47sZqpO17R/RLYaQFwvK0B1/eNYj4HEsuXb
         iQVaAlX0+JYmjxBH/O4vx98ALqMoNtnJFDYuAzZNQ9m/04pdreLc3vy2QaoG1knNEFNd
         /0XNvb7fgvSsCBl5QQm57NJ+PTCZrB0kL6U2B7gkLfH9J6rNgviGOCfAmFxc8OoKzC0j
         IadzNmb469NxFZ1fR7wbsdSUo+rnsxnVvPVGePS1Sl94CFGqMBEoOS13N+UvEoNNQ6Am
         ehCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=f+MmqoI02JhB93ZxctEwjGEdFgOMW6YsokLDsVeWs1s=;
        b=f10EjcTu354GgrlRUBd24nKj8ix3/r6aZ3ytMoHM3qdFIg0vB7C5XUAoN0qCg2btgu
         FCt36yaVXi1McJGqPqOgw+bMTvh7aZaP80wcMTb/Lx7FoXCjaDckskj67L0T2vyK6Qt4
         srjeLPX1PgNMI9wZ4J2f+UckcFbEoafgP4Knf0nUjIG9lJxbCh/DSazbMjtuaDSmhXeI
         rvvUhvCRbxQmZPoSErzXGYsXYaimRDyqR0NUye8VnbsuqDqnKffRCviAzW3sa/RW5K/l
         Zz3NqZroe9HpdO2KrrxxWJJPGPYSWznveZJBv6+OwUQOf6Tg8vrhg1UYjyL1qOrPOoG9
         qPQA==
X-Gm-Message-State: APt69E3qDREnL1YOqUpDljMJXD9KACuy8JbVVHApfFonQ4AmsNmENhgZ
        SGLZ1cCWVusPuo+FjHNn4Hs=
X-Google-Smtp-Source: ADUXVKKYii3N6aCWlNJNaGTZ7WcNPf1tQxaHfGZLBuYKLA3rpnFl+gQKkhkDaat9s7sllhxMaIe8uw==
X-Received: by 2002:a1c:7d56:: with SMTP id y83-v6mr10377434wmc.65.1528119215351;
        Mon, 04 Jun 2018 06:33:35 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u3-v6sm24057746wrm.60.2018.06.04.06.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Jun 2018 06:33:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] t/perf/run: Use proper "--get-regexp", not "--get-regex"
References: <alpine.LFD.2.21.1806030613080.7681@localhost.localdomain>
        <20180603133039.GF26159@hank.intra.tgummerer.com>
        <alpine.LFD.2.21.1806030935010.21364@localhost.localdomain>
        <0AE4648A05C445FBA049864F455B35A7@PhilipOakley>
        <alpine.LFD.2.21.1806040659590.11594@localhost.localdomain>
Date:   Mon, 04 Jun 2018 22:33:33 +0900
In-Reply-To: <alpine.LFD.2.21.1806040659590.11594@localhost.localdomain>
        (Robert P. J. Day's message of "Mon, 4 Jun 2018 07:03:25 -0400 (EDT)")
Message-ID: <xmqq1sdm65hu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

> one thing i don't see there, and it's based on an observation someone
> once made (i believe on this list), is that even if there is
> absolutely no ambiguity in a command, even if there are no pathspec
> arguments, it's still worthwhile to add a trailing "--":
>
>   $ git command options/treeish ... --
>
> since that guarantees that git will waste no time trying to identify
> any ambiguity since you're being so precise. is that worth mentioning
> in that page?

I do not think it is worth mentioning _anywhere_ if you sell its
benefit as "even there is no ambiguity it won't spend cycles".  

The point of "git cmd X --" and "git cmd -- X" is that they save
your human cycle, not machine cycle; you do not have to waste time
wondering if you happen to have X as path in the working tree.  That
may be worth mentioning, but only "maybe" I would think.

A more important reason is you may not _know_ beforehand if X you
mean to be a rev also happens to be a path (or vice versa) when you
are scripting.  Writing 'git checkout master', 'git diff HEAD',
etc., in a script you intend to be generic enough is risky if
'master', HEAD, etc. can be both rev and path at the same time, but
that is already described in gitcli page ;-)
