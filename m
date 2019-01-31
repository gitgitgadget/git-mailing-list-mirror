Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E2C01F453
	for <e@80x24.org>; Thu, 31 Jan 2019 18:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfAaSGQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 13:06:16 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:35910 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfAaSGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 13:06:16 -0500
Received: by mail-wm1-f45.google.com with SMTP id p6so3578230wmc.1
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 10:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Z30yJskYMxnKQD+WrC6D7XVnz7SwzhYqIc+0QZ+gzPI=;
        b=C+OupI2eqJl1SrrzrG/0D/8f/2VX7tfehEB0dwXM245g8KdgdAEgprRdfHNODg6xFZ
         c86Bc2/aJSjn7DDyUucP5W3Bzng9sR1AI669Cd+PetDSiroatl2XqIZsp5qeNzyjrEbP
         rb0EGUtvNrV+QNYw2e4gxk70ErpyPQWXv60lHzg5pKQ7Yi0bRgL/JYHywbHdYRPqnxQL
         TVwP4eRkJ8ONz8YNNr6m0qBueLzAy91SqdDZCibY9XK5irxLwJ+Ole8AAQlsZpjUdH8G
         nNUKSyR1+IruukWCHTFEwTjaBpBRz9YrlBYIou3KUnrgdq8mSIqgR0XKrD6ahKPrRvKf
         icqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Z30yJskYMxnKQD+WrC6D7XVnz7SwzhYqIc+0QZ+gzPI=;
        b=gsLogTkpF5ek2nq6GGMciq+2oihf3/MMKMPvxFMLOAXW02Hjuczu5Rw6hKeXyGyUPs
         1sigLcJ7eeAA83OQBTsaWnhXMHp/F69RJQ+0qTSBj7ifbAJredW0tChyw+6+f/VZkVn8
         t//XkWyWIatkB6pPixEU6aJgScOYj+HDLBU/ho/AUln+kSFdxgDl1ynHXjWk7pO1rm2m
         BEaHhdT10x3YjaZrCJPVHPLQJClIc6Q1b4Ho6Dl/gOuEgoxAwC8PyGLUoo//ig9OZT6O
         1TcfMWBlets0qRdj0Ij8p/ffy7+5Ej3nSmzEhiior19b3fE4zxc2QBuxfZo/xk2v759D
         vVxg==
X-Gm-Message-State: AJcUukegTIXj29dT4njxrdJatDY97sewjHqfr9iVZaF2Y9oyAi261HNz
        T+AHlqXWDOfXuwVDUvJxCfHVTQ6q
X-Google-Smtp-Source: ALg8bN5eCmcTpQ3bCZTrY80zkmO7CXcxxy2kW1OESkdzHoG9TLiDmpn4zGuoubfqnsXKFUB34ff3bA==
X-Received: by 2002:a1c:4955:: with SMTP id w82mr31809126wma.33.1548957974198;
        Thu, 31 Jan 2019 10:06:14 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k7sm5750135wrl.51.2019.01.31.10.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 10:06:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH (Apple Git) 12/13] Enable support for Xcode.app-bundled gitconfig
References: <20190129193818.8645-1-jeremyhu@apple.com>
        <20190129193818.8645-13-jeremyhu@apple.com>
        <xmqqo97z5ac9.fsf@gitster-ct.c.googlers.com>
        <7A37A7C1-6B82-44F8-AECB-189A57B94FBD@apple.com>
        <nycvar.QRO.7.76.6.1901302030100.41@tvgsbejvaqbjf.bet>
        <EE1DF652-C42D-4106-8A81-55262EC578D0@apple.com>
Date:   Thu, 31 Jan 2019 10:06:12 -0800
In-Reply-To: <EE1DF652-C42D-4106-8A81-55262EC578D0@apple.com> (Jeremy
        Huddleston Sequoia's message of "Wed, 30 Jan 2019 13:09:32 -0800")
Message-ID: <xmqqzhrg3dnv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:

>>>> A concern shared with 13/13 is this.
>>>> 
>>>> While it may not hurt too much to look at one extra location even on
>>>> non-Apple platform, it probably is a mistake to have this xcode
>>>> specific change in generic part of the system like config.c or
>>>> attr.c.  For that matter, would it make sense to force Apple uses to
>>>> look at one extra location in the first place?  In other words, we
>>>> already have "system wide" location (i.e. system_path(ETC_GITCONFIG))
>>>> defined so system owners can give reasonable default to its users.
>>>> The value of not using that facility and instead adding yet another
>>>> place is dubious.
>>> 
>>> This allows for per-distribution configuration and could be useful for
>>> other applications as well that want customizations specific to their
>>> install of git.  For our specific use case, we do not want to munge the
>>> system policy when installing Xcode.  Prior to doing things this way, we
>>> were just changing the default in our distributed git binary, but this
>>> seems a bit more flexible.
>> 
>> I think you misunderstood Junio, thinking that he referred to
>> /etc/gitconfig. He did not. system_path(ETC_GITCONFIG) refers to
>> <prefix>/etc/gitconfig, where <prefix> is that runtime prefix when
>> compiled with RUNTIME_PREFIX.
>
> Oh!  Awesome.

I do not think you misunderstood.  system_path(ETC_GITCONFIG) may be
in <prefix>/etc/gitconfig when building with RUNTIME_PREFIX, but
then I do not think /etc/gitconfig (without <prefix>) comes into the
picture.  So as long as you want to add "a forced by distribution,
not editable by end user to set a global policy for the entire box"
configuration, that goes against the design of the configuration
system, which wants to have three levels (i.e. per repository, per
user and per box).

I think the arrangement jrnieder illustrates in a message in this
thread to use the inclusion of distro-provided file from
/etc/gitconfig, which documents what is happening clearly and still
allows the user to disable the distro-provided one if needed, is
probably the best solution under the current design.

