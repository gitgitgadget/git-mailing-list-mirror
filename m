Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC1721F404
	for <e@80x24.org>; Thu, 25 Jan 2018 21:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbeAYVp6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 16:45:58 -0500
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34126 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbeAYVp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 16:45:57 -0500
Received: by mail-yb0-f195.google.com with SMTP id u35so3624924ybi.1
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 13:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZOurB7NSQtV9pxAO9tvlTW5cVY9Ao59Ff+agE64Ff3w=;
        b=rmjl3sCbIVYSDLegawjpGBp1g0eCIicYdzVbjj2aswky7wjGc5DTY6RaKL5wzP8WYU
         PewLvRAF0+HCZIWT24C+gUZuDuWcLIQ15+Krls7VfxXwCg0IhSicOz1VKtPKbYUsR9fg
         ynlSrCiaEAghcbtt5f5ctuBWdvoGEpsy8VKBE1180gx6w2s0lzV6kxlyC7ODWXGvKaOO
         dJ6r9EchGewaBHsGEy+hVny1o24pDq4IofbHFNyOGcaRq76abdhoh4/tlaluEycMmOrl
         B0E0jwr6qrV5nj2iaJgAzDWStKVePRdD+w21sXgXpZd9krZTfzq+IKZUiSHxZos7hWW3
         ZfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZOurB7NSQtV9pxAO9tvlTW5cVY9Ao59Ff+agE64Ff3w=;
        b=avdPOxb2Yl4sz2j82hVi279PyQ9rDxI7pHnaM6ukMHy7tlrKnNHUqgs8oahoHuvshS
         d253VeUFE2OoEVpfUsc7Da6ytpAufcyhXQGAzd03b43gQHarUQN4h1/RH8MLXkJ6lR4h
         qnRd3kwvDEghPbu7ibb77dg9ZeEB+sbMX8/UgyKEPnOsabc0uWU/lqsKpxWu6HQ4S/jd
         bXgzIrFJV7SahSIZea5VU/CrEh8rV3NIwrlIpAK9FtUO3d27+4lxW4jd/r3akuKfLt35
         Iz30ga53th5KFCp3gwmtLfmDWBIlcu0J5BMMptbOS2IasKaPF4oue8zCREFYuFxSqmlK
         LPxg==
X-Gm-Message-State: AKwxytd1jCepr7FfHh33mGG8yZv9C1brwrc4kOTQik/Gikx+6qlNB15O
        gqSqHsJEeKn9IwwC437+qioSNEVNeV6nYJS7HXWZHA==
X-Google-Smtp-Source: AH8x2267dzmOmE0bT9zQ6LjdTc9FIZzglyp9uPfGmM1s0QRCyh/B4fHzfHWkCeZdZsz3FwrAUgPlfNur137vk9GVa+s=
X-Received: by 10.37.219.83 with SMTP id g80mr9683187ybf.201.1516916756082;
 Thu, 25 Jan 2018 13:45:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.210.209 with HTTP; Thu, 25 Jan 2018 13:45:55 -0800 (PST)
In-Reply-To: <20180125140231.65604-4-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com> <20180125140231.65604-4-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 25 Jan 2018 13:45:55 -0800
Message-ID: <CAGZ79ka61UCXWAP4X8CTdCSiPUBnsO1_-wNSkGmV0VjZyAqcpw@mail.gmail.com>
Subject: Re: [PATCH 03/14] packed-graph: create git-graph builtin
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 6:02 AM, Derrick Stolee <stolee@gmail.com> wrote:
> Teach Git the 'graph' builtin that will be used for writing and
> reading packed graph files. The current implementation is mostly
> empty, except for a check that the core.graph setting is enabled
> and a '--pack-dir' option.

I wonder if this builtin should not respect the boolean core graph,
as this new builtin commands' whole existence
is to deal with these new files?

As you assume this builtin as a plumbing command, I would
expect it to pay less attention to config rather than more.


> @@ -408,6 +408,7 @@ static struct cmd_struct commands[] = {
>         { "fsck-objects", cmd_fsck, RUN_SETUP },
>         { "gc", cmd_gc, RUN_SETUP },
>         { "get-tar-commit-id", cmd_get_tar_commit_id },
> +       { "graph", cmd_graph, RUN_SETUP_GENTLY },

Why gently, though?

From reading the docs (and assumptions on further patches)
we'd want to abort if there is no .git dir to be found?

Or is a future patch having manual logic? (e.g. if pack-dir is
given, the command may be invoked from outside a git dir)

Stefan
