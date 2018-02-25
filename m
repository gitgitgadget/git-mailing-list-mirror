Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20B881F576
	for <e@80x24.org>; Sun, 25 Feb 2018 10:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbeBYKyb (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 05:54:31 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:52789 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbeBYKya (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 05:54:30 -0500
Received: by mail-wm0-f48.google.com with SMTP id t3so12309755wmc.2
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 02:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IJ2QMEptufpiWIab5264QcQtpi0XE9Gh28K5sHYqn/4=;
        b=cU7byKcVm2uHiYNwpaXIyWWur+LqFKzOw+C8Hxvfxmw9T0cf5sAsQ/emCYbD1D3mc9
         ykSfVjjsSU4aBMZZnTPD5Wv+CAjUsB5c+MKB4EoiwjUECqVU+jc5pUPfT0VeNdRQ1kxS
         9JMzlu59e4QQwTgTSMOvT7zmNHDdKfdkQge+t2IElTujv3ta3gj4oPhaFKWQFFkq3rYD
         eBdbiZ5pbnp4KiAMlLE5TArHdLLFfHrIbqI+uf5hYqsNZZrmh9YYTE9i5PcbdQOBH0a2
         0N1nwcn/7ah7FWh/8Q/qTLn4uSdr+pVZpnIwc9RZcuhn3kaODKQ4QTh0XMEuMSMurmxT
         gHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IJ2QMEptufpiWIab5264QcQtpi0XE9Gh28K5sHYqn/4=;
        b=lICDWsgpdYfQAljm/8xO/G1Q5yr4PbGya5jI9LiGl9xpyOFEcc7qOnCFhj1W44YhlT
         tp7iXTkORJfKmVhfc2IeRCcNfJM2NDRUbKoLyFZ7ldsQULJmKefDWiIbXLOQAoSlCV7b
         s9A11VoJc4WVAtvZfTQGv/FTk24VUzew1hr0XAhDfKAS3huXNkVNeugiGbYGWPiTKp91
         xHSKdAqcTgfli4XJQgwcuXtfYwWoJdAMNexZXtfsBqLRwW8xcYNDjtV0rEhQOoISAdYR
         NhbOT86VemiaMQAxrdGMIKJ1TWp/5YkrYPhY1LgEUF0eLczCdSKny5PoWUpVF0X48uhM
         hc9w==
X-Gm-Message-State: APf1xPCPN0oSU5f2wVShjmNFVwtVMznaoijqPAQKvls7tjr41czWIUHK
        OC6z+LD3EkYMOJeAZkkOvdixxl/QrIUx5B5RHywaGA==
X-Google-Smtp-Source: AH8x2267wAMC3VHAY58vc5/48QUjzAon3yGzGQU4PaXk2uySxlg7DE5uR9gskhEyATSl3W9W5CE06Hyuh6PejO7v/OU=
X-Received: by 10.80.217.202 with SMTP id x10mr10045360edj.118.1519556068840;
 Sun, 25 Feb 2018 02:54:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.139.133 with HTTP; Sun, 25 Feb 2018 02:54:08 -0800 (PST)
In-Reply-To: <cover.1519389319.git.johannes.schindelin@gmx.de>
References: <cover.1518307771.git.johannes.schindelin@gmx.de> <cover.1519389319.git.johannes.schindelin@gmx.de>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 25 Feb 2018 02:54:08 -0800
Message-ID: <CA+P7+xpr1Ho4+xi4QhADP6sWRMP49yqvVRkcHkCY2QUZWkUz5Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] rebase -i: offer to recreate merge commits
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 23, 2018 at 4:35 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Changes since v3:
>
> - fixed a grammar error in "introduce the `merge` command"'s commit message.
>
> - fixed a couple of resource leaks in safe_append() and do_reset(), pointed
>   out by Eric Sunshine.
>

The interdiff seems incorrect for such a small list of changes, it
appears like large sections of code added by this series appear in the
interdiff without subtractions from the previous versions? Is all that
code new to v3? If not, I'd suspect you accidentally diffed between
the wrong points.

Thanks,
Jake
