Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2947D1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 18:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeI1AuR (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 20:50:17 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:45686 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeI1AuR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 20:50:17 -0400
Received: by mail-pg1-f176.google.com with SMTP id t70-v6so2542412pgd.12
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 11:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I7GeeQBQoiv1G00F9/UYk6p3qTMdXBPJ4AJlykRJHmk=;
        b=XE2lawOIHcSidLcKrnWmOxYhPvbk9MOgh5U/QZ10BxifNWYpPjIbhdRw4FRU3L01wZ
         czKjBLl/zDOkIbYQoywrxSBO2paK1q3RrXYnWknvLO/LqV3NTiqmckcz/ASu1A+oZeux
         qPHlYVYBRxo3yotdVwEEvLagA69AfVkf8k+PGjqDOfMtIQFp/4ZkGEEJqclY9YJBDzbO
         2oFhulED4dTIqcoJNOUt8ySKFndF8bLg2MQPeOTA+ZZpoS/yELyYC/M5M3tkz1j2+Z7m
         fB/n9KsnoIDGtSi980PL77yIwvF6gBCWyKVngVhJtVpMoMB4cs3YyEnX+fAoRHg2R/11
         xbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I7GeeQBQoiv1G00F9/UYk6p3qTMdXBPJ4AJlykRJHmk=;
        b=Lka8wdverep70tW88uqGK4rFxwPpJRE7R107SRBYjHlXg8QaKcAGyhk2YS7teQyxG1
         7KxactS9l149SvFejNBLjD+PH3lkW9vKzh0w18WCXr+k6V9EmND0UuuL17coTUYCiAAF
         G4hcqLryk9oi+P6pJymHt7DHhk2ap1Ocolfd4MJmoOrGuyaIddxF0BSpIILdahhHOce3
         EXs5MM2dbfOXOjJRrohBEmNcrIdzGacvEJ5A/Swnm7fep6BqDBXi5mcd+Le47F96GqxR
         jeXMUAFoojV5I+Mr8RjLuOs2Voqyl4jV0wkKY/Ncr65pmAG+pPT69ToS2RHCclcollho
         eDtQ==
X-Gm-Message-State: ABuFfoiHyYVT6TPMfHeV3Er9MJecNGSeouiavW2KzK79j10ebL7HnSdN
        nKv6p0aAmQQ6a2g/SPf1+tzuDURcwxSzRw==
X-Google-Smtp-Source: ACcGV615OoJ4I/97l+XTVb/Oo9HD4OPNhqFuZ3wgAZuEVjcSTLabOvJjkSxKyp4877hHImddBSux9Q==
X-Received: by 2002:a63:4860:: with SMTP id x32-v6mr11477800pgk.375.1538073042500;
        Thu, 27 Sep 2018 11:30:42 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:79fb:7d7a:4d6b:acb7])
        by smtp.gmail.com with ESMTPSA id k185-v6sm5471609pfc.160.2018.09.27.11.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 11:30:41 -0700 (PDT)
Date:   Thu, 27 Sep 2018 11:30:36 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Add proto v2 archive command with HTTP support
Message-ID: <20180927183036.GA55647@google.com>
References: <20180912053519.31085-1-steadmon@google.com>
 <20180927012455.234876-1-steadmon@google.com>
 <CAGZ79kaBvHwUUf0rXeAwBY-M+Oi9JjsQnLs4v3FAvx4a9ZRbSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaBvHwUUf0rXeAwBY-M+Oi9JjsQnLs4v3FAvx4a9ZRbSA@mail.gmail.com>
User-Agent: Mutt/1.10.1+54 (2af6caa1) (2018-07-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.09.27 11:20, Stefan Beller wrote:
> On Wed, Sep 26, 2018 at 6:25 PM Josh Steadmon <steadmon@google.com> wrote:
> >
> > This is the second version of my series to add a new protocol v2 command
> > for archiving, with support for HTTP(S).
> >
> > NEEDSWORK: a server built with this series is not backwards-compatible
> > with clients that set GIT_PROTOCOL=version=2 or configure
> > protocol.version=2. The old client will unconditionally send "argument
> > ..." packet lines, which breaks the server's expectations of a
> > "command=archive" request,
> 
> So if an old client sets protocol to v2, it would only apply that
> protocol version
> to fetch, not archive, so it would start following a v0 conversation, but
> as the protocol version is set, it would be transmitted to the server.
> This sounds like a bug in the client?

Yeah, basically. We're telling the server we support v2, even if the
specific operation we're trying to do doesn't have a v2 implementation
on the client. So this is going to make it ugly to replace existing
commands.

> >  while the server's capability advertisement
> > in turn breaks the clients expectation of either an ACK or NACK.
> 
> Could a modern client send either another protocol version (3?)
> or a special capability along the protocol version ("fixed_archive")
> 
> > I've been discussing workarounds for this with Jonathan Nieder, but
> > please let me know if you have any suggestions for v3 of this series.
> 
> Care to open the discussion to the list? What are the different
> approaches, what are the pros/cons?

Jonathan suggested something along the lines of what you said above,
adding a new field in GIT_PROTOCOL. So we'd send something like
"version=2:archive_version=2" and have the server detect the latter.

I'm not sure if that's the best way to go about this since I'm not
familiar with the version detection code for other parts of the system.
I worry that it will lead us down the path of having to specify a
version for every command that we eventually convert to protocol v2. On
the other hand, I don't see any other way to work around this, at least
in the archive case. We can't peek at the client's transmissions on the
server, because v2 requires that the server speaks first...
