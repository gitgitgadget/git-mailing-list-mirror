Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 925541FAA8
	for <e@80x24.org>; Tue, 16 May 2017 17:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbdEPRVy (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 13:21:54 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34668 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbdEPRVx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 13:21:53 -0400
Received: by mail-oi0-f44.google.com with SMTP id b204so34103560oii.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 10:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q3wOqIBFDBn7hqPslTvcOoFgE8uERW8jLfhkzHNlojY=;
        b=kOxkochgIsQNdrCYf6pnpnxS60tx7NDHXQfl5y6XVzF394mzvWEFZbglFjgCsH79zk
         uRZvSx9HUOqaGFc0IUfh/zL1byKX/aI9RszvEqxVPVVsKxP/lSMC6ylOPnzvzruF46hd
         igCSzy0Y/t7U1LF8CKuIojhVv7ydcMaoQEFdrO51VC2uo0CLoOzwYAPp3PDaVGsy/Hn0
         NFCZWZypgNnqa8ZqhAWxJknrsR/BmEAdMtOeXhLjntlqhj8JqCcj7mv38cku493C5CiR
         Kawj5gllfOZvYAjkGmXuYlhz0UXR7aSU/oVfWKihsGyeRwA1xZlnJ6kcdTEFQRMoHXTd
         Jr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q3wOqIBFDBn7hqPslTvcOoFgE8uERW8jLfhkzHNlojY=;
        b=IC0jRikWJmpMgYgrmAhaB4qNBhOTzfAUzif4wpzb2Xbkx8dRBo5hrv4EGpzLVS89Ul
         pXSqUFFPhYNid2iKTfG9jYTOxnbhL9faIUz93pdt5Y5rX4+kyYdqfD0+GLkKXxcAt0xX
         DCKCSURE8phVqvQrSF29jTSoN927HfZswoQEoTOgz4OT2iANDa4SMUYQv3JlCN8Zyhmf
         U8aj3cvx3aW5wMevOy0tXZZGNntYQ5ING8Tven8JIcxzV2YRp/ZiDBpuLSX3mVRG5UtM
         2jlRaDTSAwwAalI+yOCGgr5af0z+pQgJN+AfBG2spll7OmVWHLEJdIm8p27iyl+sj3MA
         9YBw==
X-Gm-Message-State: AODbwcAWGZpnbRXdVcMOFfp9TkEvkTiDiHGAZbwCU5YbI+w/rTFXJRo2
        +hwa8J/3E0X+oXcxglACjdNr0uOjXEBEqaw=
X-Received: by 10.157.83.30 with SMTP id g30mr5773444oth.48.1494955312502;
 Tue, 16 May 2017 10:21:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.54.53 with HTTP; Tue, 16 May 2017 10:21:51 -0700 (PDT)
In-Reply-To: <CA+zRj8Uxh1SGdVW=zz29Q4m4OnDcs665T0XtV6FiZ_qZSiG-8g@mail.gmail.com>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <alpine.DEB.2.21.1.1705161220230.3610@virtualbox> <20170516161858.stp4ylwfmbgc4oid@sigill.intra.peff.net>
 <CA+zRj8Uxh1SGdVW=zz29Q4m4OnDcs665T0XtV6FiZ_qZSiG-8g@mail.gmail.com>
From:   Eric Rannaud <eric.rannaud@gmail.com>
Date:   Tue, 16 May 2017 10:21:51 -0700
Message-ID: <CA+zRj8XLQiTmiVbsJZ7XjdW4bQvMSJpCtKW8xx5JvMKOhBDmLQ@mail.gmail.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly to --exec
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeremy Serror <jeremy.serror@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 9:59 AM, Eric Rannaud <eric.rannaud@gmail.com> wrote:
> When I use "git rebase --exec <cmd>" I'm basically writing a "foreach
> commit in range { <cmd> }" in my shell. Same idea with git bisect run.
>
> A transparent optimization that tries execve() then falls back to the
> user's shell sounds like a good idea.

One issue with the execve-else-shell optimization is that sometimes a
binary exists that will shadow an exported function or a shell
builtin:

  git rebase --exec true master^^  # OK but in fact this runs /usr/bin/true

In this case it doesn't really matter. If the optimization is only
applied to "simple commands" (i.e. no arguments), then it's probably
OK. I can't think of problematic cases. Except weird things like:

  $ git rebase --exec time master^
  Executing: time
  Usage: time [-apvV] [-f format] [-o file] [--append] [--verbose]
         [--portability] [--format=format] [--output=file] [--version]
         [--help] command [arg...]
  warning: execution failed: time

/usr/bin/time requires an argument. Even though the bash builtin time
runs fine without argument.

  $ time

  real    0m0.000s
  user    0m0.000s
  sys     0m0.000s

But if the optimization is applied to more complex commands, then we
will have problems. For instance, the builtin echo supports \E, but
/usr/bin/echo doesn't support it.

In any case, the manpage says --exec <cmd> and "<cmd> will be
interpreted as one or more shell commands.", it doesn't say "--exec
<executable>".
