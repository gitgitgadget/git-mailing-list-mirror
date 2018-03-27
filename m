Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDA6E1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 00:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeC0ATC (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 20:19:02 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:44234 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeC0ATB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 20:19:01 -0400
Received: by mail-wr0-f169.google.com with SMTP id u46so20587514wrc.11
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 17:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=19CuvJa4FhKWxW+oUi1ee+bLZpEe6x9Nmqs8eZSHecQ=;
        b=euxB+Z+qV1AMAO0mbFXJ8nHUbH+ft2SkgeXuFbyOT6jLcNBqvMlBNvRdTPIi2pxXMD
         e0qiM47a48B4XuvJak0qIyPnZ2j/T53+GeIS7DAlstvTqmpJQfAz9ZLz3wGXY1ZIzvrn
         /ex3IWprr/1DpcXL6sfA7J8RhN285C/k95GeMwEjwiReb0U5whGDPIIQxs2S8A0hm/Wi
         iSW1Jk6SnzQ5cccChamKrOz0DMWbdY0TVQBKH1/vdTkWYqaEXto+2vl6fEUcGNR73OfJ
         tP85YxyONRO8ex+nvmzxTFlLYt8kNYb4sbybGOT9gX5yhgRdGbUvCUbGH+js+0t0dyO6
         ZzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=19CuvJa4FhKWxW+oUi1ee+bLZpEe6x9Nmqs8eZSHecQ=;
        b=WXx+WcQBIj9yS1doVSQQ7bNDacmeL8bRrhxg8Bz6sCrTmNN16h0a5A3icTz4j5fU8Z
         giKM3rlSI3/lWaP8c2PCgrbqqU3uWLzQh/QnZWPu0/M/XCmzAvuKtQcgDIjhrQtDb2Pv
         91JvLSF/DlP83QmhTmMvOIZi9F6f+3cwFMIQfGu+cIEG0dXe5wJHVPwqJZknvk9rKiQ9
         +usLRhTDWoB6AQiRB9plqfZY/TVwUdT6oaZKUtRvfH3BAYBs0buHP55ClmDY4iDpYNsY
         h4nUckLAKKI5GUeqZV6TuEnfgHJ6xRLCVByxWkXsd9XySZQ1vjiKuyhxirz2eo7YtHVt
         Vg+w==
X-Gm-Message-State: AElRT7E7x1lRHLeJx0VddHxdMRJVsIOIBGqdNWUvWFD3KjjJDmvs63dE
        3onPCQRYY1kKXCUmvqKENuG1ULLkF6IWy8M5Xy589ayv
X-Google-Smtp-Source: AG47ELtRklNMqcfx4naJ2r/XVwkS/MnbCvQq6Ga65rm/Is+x962HGbc/lMkhZzQudF6IRtTsbZQ098eQMVYwY3VecTI=
X-Received: by 10.223.156.206 with SMTP id h14mr30038903wre.281.1522109939952;
 Mon, 26 Mar 2018 17:18:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.147.71 with HTTP; Mon, 26 Mar 2018 17:18:59 -0700 (PDT)
From:   Jan Keromnes <janx@linux.com>
Date:   Tue, 27 Mar 2018 02:18:59 +0200
X-Google-Sender-Auth: FvHcB2uSExfluv2O0jV13QJZdfg
Message-ID: <CAA6PgK7L04VoHT7A8M_mwq5kA+9BiQxrd6iPjPHOpa4=Z3futw@mail.gmail.com>
Subject: How to `git blame` individual characters?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git developers,

I'd like to understand what would be required to run `git blame` on
individual characters instead of full lines. Could you please point me
in the right direction?

Someone asked a similar question about "Word-by-word blame/annotate"
on StackOverflow a few years ago, and one of the replies said:

> Git tracks changes snapshot by snapshot. The line-based format is calculated on-the-fly, and it would also be possible to have a word-based format.

Source: https://stackoverflow.com/q/17758008/3461173

This leaves me hopeful that a character-based format can somehow be
achieved. Here is a fake example to illustrate what I'm looking for:

        $ cat myscript.js
        for (int foo = 0; foo <= 11; foo++) { console.log(foo); }
        $ git blame --character-based --pseudo-json myscript.js
        [
            { "commit": "abcd1234", "summary": "Implement loop",
"characters": "for (int " },
            { "commit": "bcd1234a", "summary": "Rename iterator",
"characters": "foo" },
            { "commit": "abcd1234", "summary": "Implement loop",
"characters": " = 0; " },
            { "commit": "bcd1234a", "summary": "Rename iterator",
"characters": "foo" },
            { "commit": "abcd1234", "summary": "Implement loop",
"characters": " <= " },
            { "commit": "cd1234ab", "summary": "Go up to 11",
"characters": "11" },
            { "commit": "abcd1234", "summary": "Implement loop",
"characters": "; " },
            { "commit": "bcd1234a", "summary": "Rename iterator",
"characters": "foo" },
            { "commit": "abcd1234", "summary": "Implement loop",
"characters": "++) { console.log(" },
            { "commit": "bcd1234a", "summary": "Rename iterator",
"characters": "foo" },
            { "commit": "abcd1234", "summary": "Implement loop",
"characters": ")" },
            { "commit": "d1234abc", "summary": "Add missing
semicolon", "characters": ";" },
            { "commit": "abcd1234", "summary": "Implement loop",
"characters": " }" }
        ]

What would be the most direct way to achieve such a character-based
blame/annotate? Should I write some sort of Git extension, or hack
into Git's source code?

E.g. I looked for an option in `git-blame` or `git-annotate` to change
the "next line boundary" from "carret return" (line-based blame) to
"any whitespace" (word-based blame) or "character-by-character"
(character-based blame), but I didn't find it. Could this be
implemented in `blame.c`? If so, which methods would need tweaking?

Many thanks!
Jan
