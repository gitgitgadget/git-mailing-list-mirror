Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 627101F404
	for <e@80x24.org>; Fri,  9 Feb 2018 22:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbeBIWkx (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 17:40:53 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43059 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbeBIWkv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 17:40:51 -0500
Received: by mail-wr0-f194.google.com with SMTP id b52so9682216wrd.10
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 14:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=eFfrrX4yzzyCZ0I2idhLrenvOBK8AXGPg5J54+sbS9k=;
        b=Czo9CxshnDYz+kY9YwPYrXOlLkZfoisEbcY6sQce1hBRHlVpueu70BzqfESSsWZJK0
         X+Yommz7mcGmciHW0EZDAU339/XwUfmvHfeGZMMskNsJUXgpRxQ8I0u7BY/k+fPf2+9B
         cObW02z5FLZbSIzPBh12/tAclWAt7R409IXptMIBIWYWPu174hDIr54PocxqoYfhg90B
         vtuSokCPm/vBWvYoFHce/+MD8DySfgUpwJ4J89++Z2knaoVBYRsnUGuKlS/iWvPrVpI3
         yUNVEWhX/PCM3hPUksnTp0ajJRSQ+HWmnuI+Vu+31wAAgsB+oEMeVd9aZiUT3C98QL3y
         Q3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=eFfrrX4yzzyCZ0I2idhLrenvOBK8AXGPg5J54+sbS9k=;
        b=UZ48se7k7Z+PlHrx+i6la/DrmGHI12l/9gc1YMp35j7oI+grO4wzFsnUznIlzp/Iot
         6AvOg7obousyKNl3V2dY6I1/KBlItRk9beYmQt4dpWJdzjJJcjyWPOvX/u/gEbOWrc0L
         jdSCykdYdiL/BHQv9LtgKsh6XZfzrYmHi7R2HxUEUTowJ3no4Ci0FT9NUpxtTTMoN9cY
         vaUr1w9ptCxx1D74g+UQESYy1cXEGwwQMRQGXZzWXFAXsGT6hFYvByaksWRz8K/Zebn8
         ZVH55YnqjQHd/ZusKzEDrxbB4jY3lbp9tvt09QN1ur1nNOfimnuPtTz2PIGmMsMLpwTr
         Dq2Q==
X-Gm-Message-State: APf1xPAkjZO9tktK+UYM3rZ3WsInd5KAJvqef9VPlWGrGPWnORFy+2kp
        PVuE4b0FzCcM6uFZwHMoHDY61jWb
X-Google-Smtp-Source: AH8x226yowsxv42wKHPuWWV8KXVqVKKzO9tk/fLssWsS7Wtm6WuLaFaro4TXfWM24Bri6D6B27vDxg==
X-Received: by 10.223.130.234 with SMTP id 97mr3704175wrc.144.1518216050362;
        Fri, 09 Feb 2018 14:40:50 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h13sm5070951wrc.89.2018.02.09.14.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 14:40:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Leo Gaspard <leo@gaspard.io>
Cc:     git@vger.kernel.org, Joey Hess <id@joeyh.name>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] fetch: add tweak-fetch hook
References: <30753d19-d77d-1a1a-ba42-afcd6fbb4223@gaspard.io>
        <20180209214458.16135-1-leo@gaspard.io>
        <20180209214458.16135-2-leo@gaspard.io>
Date:   Fri, 09 Feb 2018 14:40:48 -0800
In-Reply-To: <20180209214458.16135-2-leo@gaspard.io> (Leo Gaspard's message of
        "Fri, 9 Feb 2018 22:44:58 +0100")
Message-ID: <xmqqk1vlvlan.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Leo Gaspard <leo@gaspard.io> writes:

> +tweak-fetch
> +~~~~~~~~~~~
> +
> +This hook is invoked by 'git fetch' (commonly called by 'git pull'), after refs
> +have been fetched from the remote repository. It is not executed, if nothing was
> +fetched.

Need to tighten explanation of "nothing was fetched".  If the only
change I made to my repository is that I created a new branch that
points at an existing object since last time you fetched, you would
obtain no new object when you fetch from me.  Would that count as
"nothing was fetched"?  Or would it be still fetching something
(i.e. your remote-tracking hierarchy will record the fact that I now
have this new branch)?

> +  <sha1> SP not-for-merge|merge|ignore SP <remote-refname> SP <local-refname> LF
> + ...
> +The `<remote-refname>` is the remote's name for the ref that was fetched, and
> +`<local-refname>` is a name of a remote-tracking branch, like
> +"refs/remotes/origin/master". `<local-refname>` can be undefined if the fetched
> +ref is not being stored in a local refname. In this case, it will be set to `@`,

Don't use "@"; leave it empty instead.

> +TODO: Add documentation for the “ignore” parameter. Unfortunately, I'm not
> +really sure I get what this does or what invariants it is supposed to maintain
> +(eg. all “ignore” updates at the end of the refs list?), so this may also
> +require code changes.

If you are not using the feature, wouldn't it make more sense not to
add it in the first place?

