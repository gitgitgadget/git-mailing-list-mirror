Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E78BA2013A
	for <e@80x24.org>; Fri, 14 Apr 2017 22:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754788AbdDNWIs (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 18:08:48 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:36037 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752688AbdDNWIq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 18:08:46 -0400
Received: by mail-ua0-f171.google.com with SMTP id a1so52053018uaf.3
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 15:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=Ukol5yROecwGTvQEARIhyA9Y3FS5UVkuLkr63Hjm6bE=;
        b=QS09sqbUIPXWnHAfVycccPgWUJfg1KbMWwLKWC9cDfeu/4AseED6NB0vGLs3GKPZ7x
         5O3xQ1ykvC30VV4A1S+Uv2sUXHkgTDmUaRpYJABcQZL72xNX/BZdUZ2Uf3fpVCGnzMLj
         0HlneA8wslnBZswrKHHJVqjCl2f4yJfc0nyBEEiLZofv2b0UhprwIKEMJ0Ov29gdAMY3
         YoOXg2tuwzfQCPx6sWqskAUjreL6LKU/TIXCgrRBQfX2RDm/FLcZdIo9VeVL3OECwAJX
         ZUB51ROzE9QiQGYTaru0irEIjNO6e0gFlBkKUoKxwzd79Evy06Y4/jME+zTYOSvu2Ixd
         Mpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=Ukol5yROecwGTvQEARIhyA9Y3FS5UVkuLkr63Hjm6bE=;
        b=jtgp76SId6KGVrf/jG81Mxo7YZumGf0q/TytFlsXJo6+U2yvpX2p6l7h1uyDL9kFiT
         sXEqUQMIyPVZjhDcjH/15L8HzCbQGBQOTenjd/u4ws9LoPD1oN4jCkVpi0mQ5Gk4g4XO
         /8/EiNuEsJpQSg8/5xhpaH4+RR93uuMlQ/XRfZ2IvdGRjpbtZMw9Q5xFfH6Cjkb/xQXB
         /Qi/7bh4JtfEwZ4ZoHnma5nNl6TRGvZfqhzJ/qaQJheWjVKDQUSEmCaT6vUzk7Z67Azr
         J6JhrzbNgoggnExU2A00u5nRSWv1P33wPPHaNn8Ue6RBJmIHZAD0VnenB8l/4pWl9/i0
         611g==
X-Gm-Message-State: AN3rC/7DDo/lkJvJPueo/l6pxKbefK0mtkuQmjaVQetKi3SiQkycYU2Q
        Z10xLN8B+Eev8cEWPSJhEdSIKJz6UQE1
X-Received: by 10.159.38.193 with SMTP id 59mr5419240uay.142.1492207725662;
 Fri, 14 Apr 2017 15:08:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.75.7 with HTTP; Fri, 14 Apr 2017 15:08:25 -0700 (PDT)
In-Reply-To: <CAELgYhf1s43p62t6W14S=nDt-O247cPqsPMUDfye1OTnDND3Gg@mail.gmail.com>
References: <CAELgYhf1s43p62t6W14S=nDt-O247cPqsPMUDfye1OTnDND3Gg@mail.gmail.com>
From:   Carlos Pita <carlosjosepita@gmail.com>
Date:   Fri, 14 Apr 2017 19:08:25 -0300
Message-ID: <CAELgYhfwwLZXGN9yHZ04koDwGn3=KbuJOxhLM-+PCbumTmMunw@mail.gmail.com>
Subject: Re: Index files autocompletion too slow in big repositories (w /
 suggestion for improvement)
To:     =?UTF-8?B?4oCcZ2l0QHZnZXIua2VybmVsLm9yZ+KAnQ==?= 
        <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is much faster (below 0.1s):

__git_index_files ()
{
    local dir="$(__gitdir)" root="${2-.}" file;
    if [ -d "$dir" ]; then
        __git_ls_files_helper "$root" "$1" | \
            sed -r 's@/.*@@' | uniq | sort | uniq
    fi
}

time __git_index_files

real    0m0.075s
user    0m0.083s
sys    0m0.010s

Most of the improvement is due to the simpler, non-grouping, regex.
Since I expect most of the common prefixes to arrive consecutively,
running uniq before sort also improves things a bit. I'm not removing
leading double quotes anymore (this isn't being done by the current
version, anyway) but this doesn't seem to hurt.

Despite the dependence on sed this is ten times faster than the
original, maybe an option to enable fast index completion or something
like that might be desirable.

Best regards
--
Carlos
