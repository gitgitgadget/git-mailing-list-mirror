Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 820E81FAA8
	for <e@80x24.org>; Tue, 16 May 2017 19:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751766AbdEPTOk (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 15:14:40 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:36691 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdEPTOj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 15:14:39 -0400
Received: by mail-io0-f176.google.com with SMTP id o12so100224891iod.3
        for <git@vger.kernel.org>; Tue, 16 May 2017 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0/d+HYO6k9Dym5FYYGvrf9etkoTEg9bMKOQY2t9DZXI=;
        b=X9tyTjMWwBGJDpNDCaR9DojJd4gZDA5Lk5x23bsFHps4B2FZ+ILh/sWqUEIiI4IHhF
         gbqSIBP4sZLUeVT2gxsFM3ukKyCkNujbC/BvkCUa/7oZEu98KPW79qcjPMUVWqlDdeq7
         IoIXmiEQySwWKhY18Q1WSs+7zGjhlSC/TpdfjmdpyYHR5uVIfccuGVlpXbS4gYP9P+l4
         T+sZjGDIzB6VRG84ATO3tp6oyla+ZtTuZOPG1DQUbXXjt2CUhztDLghItKUCfbWQqk9/
         5uTk4SOGFcEqVNWq0YCr13DCB82mKC/IdmedtBSeD37TDzLwEMnhBGPUAL3j5uymIitn
         GYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=0/d+HYO6k9Dym5FYYGvrf9etkoTEg9bMKOQY2t9DZXI=;
        b=EETgOqsIiLCjBTABCJ6HFThvv76747QR7xvHjnDqsgQiy30rNDu6R1TDTlGSjdc1nL
         JRGsC/x2/mn7s/jJlWujB0Xhay22Xq4mbV+RHBw7JIqfr4IsJC3JxP6T7XIHqNKoVHYG
         L0eiM8KXaXd9j9xOUvk2eQhQ7tjJ5lLZGewV+uQ7FjRWynBgXsSRJNIbA/fegD5QU3CD
         n9dLGs4/Xe09vBV9DGqlPnaaykdtZJOFa/uu8uJ9ZL2/kRq5cvN1ifH99cYH6tqbrFcn
         b3lj3EUmMpF/Pbaku+Jb9x1yVFDpjxRSFV6DDsZI9pIT8AOjX63L9JmXudWr5yEElFxK
         /3xA==
X-Gm-Message-State: AODbwcAqK+RZ3r/kpjLnD7mPb5xOWUjdE2aK4VDdyvjpjVNotu4eolys
        VnBoZRu+MLDKPwg39yVfDXoFxUowCA==
X-Received: by 10.107.149.67 with SMTP id x64mr11760948iod.167.1494962078917;
 Tue, 16 May 2017 12:14:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.204.3 with HTTP; Tue, 16 May 2017 12:14:38 -0700 (PDT)
In-Reply-To: <20170516172307.36hyshwypomlsubx@sigill.intra.peff.net>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <20170516032503.bzkxmtqpmppxgi75@sigill.intra.peff.net> <20170516033736.23cfkouus3p67vhc@sigill.intra.peff.net>
 <20170516164124.GO27400@aiede.svl.corp.google.com> <20170516164750.3tw6xlbcbyuu5t72@sigill.intra.peff.net>
 <20170516171540.GG79147@google.com> <20170516172307.36hyshwypomlsubx@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 May 2017 12:14:38 -0700
X-Google-Sender-Auth: ECXQOQag8ImQrMJYgv6eFUf1FNc
Message-ID: <CA+55aFwB-MWASj7dZWkXWhgd4gvEfoOhL6Fo7kXeJSm9dht4Jg@mail.gmail.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly to --exec
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Rannaud <eric.rannaud@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeremy Serror <jeremy.serror@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 10:23 AM, Jeff King <peff@peff.net> wrote:
>
> I think the logic here would be more like:
>
>   1. During prepare_shell_cmd(), even if we optimize out the shell call,
>      still prepare a fallback argv (since we can't allocate memory
>      post-fork).
>
>   2. In the forked child, if we get ENOENT from exec and cmd->use_shell
>      is set, then exec the fallback shell argv instead. Propagate its
>      results, even if it's 127.
>
> That still means we'd prefer a $PATH copy of a command to its shell
> builtin variant, but that can't be helped (and I kind of doubt anybody
> would care too much).

I think it would be better to just

 (a) get rid of the magic strcspn() entirely

 (b) make the 'can we optimize this' test be simply just looking up
'argv[0]' in $PATH

Hmm? If you have executables with special characters in them in your
PATH, you have bigger issues.

Also, if people really want to optimize the code that executes an
external program (whether in shell or directly), I think it might be
worth it to look at replacing the "fork()" with a "vfork()".

Something like this

-       cmd->pid = fork();
+       cmd->pid = (cmd->git_cmd || cmd->env) ? fork() : vfork();

might work (the native git_cmd case needs a real fork, and if we
change the environment variables we need it too, but the other cases
look like they might work with vfork()).

Using vfork() can be hugely more efficient, because you don't have the
extra page table copies and teardown, but also avoid a lot of possible
copy-on-write faults.

                 Linus
