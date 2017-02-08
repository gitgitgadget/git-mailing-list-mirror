Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88B3D1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 23:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751027AbdBHXqx (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 18:46:53 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36203 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751440AbdBHXqv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 18:46:51 -0500
Received: by mail-pf0-f196.google.com with SMTP id 19so12410647pfo.3
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 15:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MjKHArRqZXS2obfoW8Qos8bVGHy/zaNJ/x5D3pQj+Y0=;
        b=py8jomG5+5E1WQN56EdeKQf/umHOxER/M5/9phnXXDJC+2UEw9jP2P21QZwmnGw0GN
         j/xEENxnGAKFNH7Q77w3b/DE7KJUzIrOKvPWnuTALvXdiAMrJ7B4ZUEc4gmcQf9zlslR
         BJNyVYvH3m9fMnOSfeXLPrfWmAzBVX69AsDKdAAzWjZuEgLXyprLUtZY83udOyOn5s9O
         VYO5+riX6dC9HNu9GhA832v7AB9YrzF3n3oIvkK2KPDCNQTGJVi9lI0LYD/pZuVsZYsD
         p1tCOlAcn2/iAF0/FW+r7KrQIuKxIKJi/2nWm8Tezg93HACiqfRVDUD4xNF6hS5WQL6G
         9k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MjKHArRqZXS2obfoW8Qos8bVGHy/zaNJ/x5D3pQj+Y0=;
        b=De1O+SxveWwc7KC8PcE6dEgwk7e4ABe0wo8Qq/P1RmPQti94Fy0xeATtJJ8O7uflaT
         Vdh/EmG4CW203oWcWV0c+T9HqWRJr4HQsQbZtSpQfxxT7vl8daRF6JdkWm2gnyXX1ex/
         W95VZtkDtwP/vcH9lIzK97PDYeGOfSGhhiHQ5kEq4wWJzkoFSWcGa6bogmkg8vQ0H+IC
         N+HAYKCLa52RDXysvAxB2U7+U1LGkzHWhdZ0hmJYGWoX6QssCN6IEJ//XhmTBpW04Q4A
         wbdB7uQeFKqB7LmLZp+q/BjLaEdbcIY8A+oYh1iGf6shDTx4zHUQS/nWOUx/pz2FP30h
         afzw==
X-Gm-Message-State: AMke39kyjUChXmSQX3ThnnVhV+U2WOdjTON2Nw6kyXQI3PcJednOEnY/hIuNBx7UH+8KvA==
X-Received: by 10.99.8.194 with SMTP id 185mr211164pgi.76.1486597153069;
        Wed, 08 Feb 2017 15:39:13 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id m6sm23080940pfm.22.2017.02.08.15.39.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 15:39:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thangalin <thangalin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Automatically Add .gitignore Files
References: <CAANrE7rmUZcJkw+thMczv3D=7sqcUHBsorzvEZgYg=6AEfrU=w@mail.gmail.com>
Date:   Wed, 08 Feb 2017 15:39:11 -0800
In-Reply-To: <CAANrE7rmUZcJkw+thMczv3D=7sqcUHBsorzvEZgYg=6AEfrU=w@mail.gmail.com>
        (thangalin@gmail.com's message of "Wed, 8 Feb 2017 11:05:28 -0800")
Message-ID: <xmqqmvdwtfq8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thangalin <thangalin@gmail.com> writes:

> I frequently forget to add .gitignore files when creating new .gitignore files.
>
> I'd like to request a command-line option to always add .gitignore
> files (or, more generally, always add files that match a given file
> specification).

That is essentially what "Untracked files" listing in the editor
buffer given to you when you type "git commit" is about.  By not
saying you ignore .gitattributes, .gitignore, .gitmodules, etc., you
are reminded if you forgot to add them.  "git status" does the same,
and perhaps you want to make it a habit to run it before committing.

I am tempted to say that there should be a way to somehow forbid use
of the "-m" option to "git commit" by default, until the user gains
more familiarity with use of Git.  That way, they will learn to pay
more attention to the "Untracked" and "Changes not staged" sections
;-)
