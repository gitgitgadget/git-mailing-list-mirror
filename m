Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D86A2023D
	for <e@80x24.org>; Wed,  1 Mar 2017 23:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753794AbdCAXqa (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 18:46:30 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:33122 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753787AbdCAXq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 18:46:27 -0500
Received: by mail-it0-f42.google.com with SMTP id 68so9318729itg.0
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 15:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ok5Da7/nTGxQszFuHPDRsgw4gRcTqQckLrzQzU5nFlI=;
        b=KEbltmwh3XPhzAy5l0NgqFPAfGUmq/CYE9JZyTHc3tmeoxWLjXBS7ofIXQdEva0oyL
         zXt8D3g8j/mxM6jFBasK9YBJnmuZjLoL2/A9OknGpWhgJQeO+NnLkDeR5VSljP9J+Rdj
         2Bo/62/IqAkWexncdpmEe4E3cx/1MagzIDPEgi/0FnRkRGPAoZiLpIrigERjMMPnkbnP
         Bu0Hxn/xDoqc6XkxyMPPlI0R4UfB6ubgp1+6Fu2sNyEzrp9VSpf7yordPvSxWKjLrWVH
         aO+V3b3PZns7ZlaKDRN2E50UJMfiMqlO1M8eOnDfSLS2nc7beT0tbTAxNEd1IbqGq2Rc
         3ClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ok5Da7/nTGxQszFuHPDRsgw4gRcTqQckLrzQzU5nFlI=;
        b=anajxbeQj4tlktCRAQp1QWDrLVlRCtjC6+hjZ0LzfMleDJjxTta+nAi7xVrgKB1QPZ
         SdHCuIpaiFsG2I6jcdvy7pR1ZqWb451piW6U/6ExNTlb3EyfX1ORvBzeV7aLnNKOjNv4
         xBt1gIyb6FU/wk04oeoogOJ2YCsAoT4u8k8z0ONHH9ZSx6w6EMTCcp3wEdiuVOggb8aG
         y1UrN6SRgCjUZ8p4zRLqpleJj7+0CpC1+uR1fOmdaGNzNjgHVtfTqZaeKWUm+0RKxtd5
         3pC4xAowvPS7ePyYcDEHPUEEv1uyX0YQbbCw9nSfctiECTuz4ukilo7sCpNvuwCeun4k
         AUqQ==
X-Gm-Message-State: AMke39kKHUI/Y/5nJNX5ejKJnVEWrmfraDMRUYz0bfXNnaOGqriYg8bsawvA2TtGq6BVpuaHwg0G1NtaV6KsgA==
X-Received: by 10.36.65.135 with SMTP id b7mr7444100itd.86.1488411521086; Wed,
 01 Mar 2017 15:38:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Wed, 1 Mar 2017 15:38:40 -0800 (PST)
In-Reply-To: <20170301203427.e5xa5ej3czli7c3o@sigill.intra.peff.net>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan> <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com>
 <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com>
 <20170301195302.3pybakmjqztosohj@sigill.intra.peff.net> <CA+55aFwf3sxKW+dGTMjNAeHMOf=rvctEQohm+rbhEb=e3KLpHw@mail.gmail.com>
 <20170301203427.e5xa5ej3czli7c3o@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Mar 2017 15:38:40 -0800
X-Google-Sender-Auth: Le2bw-5UmgE6DCGtOKQs3jk3m1o
Message-ID: <CA+55aFz4ixVKVURki8FeXjL5H51A_cQXsZpzKJ-N9n574Yy1rg@mail.gmail.com>
Subject: Re: [PATCH] Put sha1dc on a diet
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Dan Shumow <danshu@microsoft.com>,
        Marc Stevens <marc.stevens@cwi.nl>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 12:34 PM, Jeff King <peff@peff.net> wrote:
>
> I don't think that helps. The sha1 over the pack-file takes about 1.3s
> with openssl, and 5s with sha1dc. So we already know the increase there
> is only a few seconds, not a few minutes.

Yeah, I did a few statistics by adding just logging of "SHA1_Init()"
calls. For that network clone situation, the call distribution is

      1        SHA1: Init at builtin/index-pack.c:326
 841228        SHA1: Init at builtin/index-pack.c:450
      2        SHA1: Init at csum-file.c:152
4415756        SHA1: Init at sha1_file.c:3218

(the line numbers are a bit off from 'pu', because I obviously have
the logging code).

The big number (one for every object) is from
write_sha1_file_prepare(), which we'd want to be the strong collision
checking version because those are things we're about to create git
objects out of. It's called from

 - hash_sha1_file() - doesn't actually write the object, but is used
to calculate the sha for incoming data after applying the delta, for
example.

 - write_sha1_file() - many uses, actually writes the object

 - hash_sha1_file_literally() - git hash-object

and that index-pack.c:450 is from unpack_entry_data() for the base
non-delta objects (which should also be the strong kind).

So all of them should check against collision attacks, so none of them
seem to be things you'd want to optimize away..

So I was wrong in thinking that there were a lot of unnecessary SHA1
calculations in that load. They all look like they should be done with
the slower checking code.

Oh well.

                      Linus
