Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D836420248
	for <e@80x24.org>; Sun, 31 Mar 2019 18:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbfCaSQj (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 14:16:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41545 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfCaSQj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 14:16:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so8943740wrq.8
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 11:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+PP1oLyD6nMIYIYDDoDWN6JjzmbamxN7cyrFiptfXIE=;
        b=MDUAX663GjE15F4duxIS423TkmiTnhG8duHwec3W2Bne18+WQzGR9pX4tH2UdO1+nj
         oktDSL4xX98wXfElt5g4dfh1QmXCn2GjulccDrb3rwcF/WlnJhew70JkQvKLUqgI3TSY
         1GrbF3XprAdWqsPBkUwkemzz0MGei7gYn8t46rn3oB5v9zKh8vM15zD8du21SFe/Qt0y
         fQvS3YP0H1SJNtQj5tud1OeYOHxRILKc3rDd8/hBRnilP5ZtTj8RP61V+pbRdhgN3VVQ
         16gNtQZfrcOVtR0I+bhplCe/8SYHpbZbAO33c+Kdj//0eDmZYaL1+mTayDMT7SmLTi4t
         3nWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+PP1oLyD6nMIYIYDDoDWN6JjzmbamxN7cyrFiptfXIE=;
        b=d8aMYxNfuhH2RWFRd7tuRFCJ8oPpyfkujxXc/NdlMnCzE9LfQYbiJGC6PBtUwb4yPz
         RAD4NH1U+RZcvadHfMyT10L6Fj7T6CjClRT4yit55gdGTrfjauF3GZKQXFMekX2Jyp5Z
         Hd7JVnTfzhtfguvXMCZjBjti6zbz+BsHsOM5agyKf6B5MP6rdioFrY3sHPBvjd92LoMu
         0B4IryHI3MiKQs1zzWD5YO3ax1njhUgJO4URAUj8+79WnYwNGY3lqHGJe5laipRMObV6
         XJnFprAQL00xB3YQ5Rg0om4xmYjCbMZt4uSZX3+HNKr0ObaF/2gbG4ftfX91tmXj7MDf
         V2tQ==
X-Gm-Message-State: APjAAAUC5amSIBHWQriWIr2OHt4uler9jYm48/XyYsPl9jzFgXII1YMD
        uzfw1Of16MxUmiSyMsNv2YE=
X-Google-Smtp-Source: APXvYqwRTKBvUOa2Zd7snxVMZcauPNQvKPgATWcZX7AvS5GiOBrMXGbk6EVZSedlb6Tj/iXQ3RTzkg==
X-Received: by 2002:adf:de8d:: with SMTP id w13mr37211379wrl.26.1554056197642;
        Sun, 31 Mar 2019 11:16:37 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id m6sm9023292wrr.53.2019.03.31.11.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 11:16:35 -0700 (PDT)
Date:   Sun, 31 Mar 2019 19:16:35 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        kernel-usp@googlegroups.com
Subject: Re: [GSoC][PATCH v5 0/7] clone: dir-iterator refactoring with tests
Message-ID: <20190331181635.GU32487@hank.intra.tgummerer.com>
References: <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190330224907.3277-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190330224907.3277-1-matheus.bernardino@usp.br>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/30, Matheus Tavares wrote:
> This patchset contains:
> - a replacement of explicit recursive dir iteration at
>   copy_or_link_directory for the dir-iterator API;
> - some refactoring and behaviour changes at local clone, mainly to
>   take care of symlinks and hidden files at .git/objects; and
> - tests for this type of files

Thanks.  I read through the series, and only found a few minor nits.

One note on the cover letter, as I'm not sure I mentioned this before.
But as the series progresses and there are less changes in individual
patches, it is useful to include a 'range-diff', so reviewers can
quickly see what changed in the series.  This is especially useful if
they can still remember the last iteration, so they don't necessarily
have to re-read the whole series.

This can be added using the '--range-diff' option in 'git
format-patch'.

> Changes since v4:
> - Improved and fixed errors at messages from patches 1, 3, 5, 6 and 7.
> - At first patch:
>   - Simplified construction, changing a multi-line cat for an echo.
>   - Removed unnecessary subshells.
>   - Disabled gc.auto, just to make sure we don't get any undesired
>     behaviour for this test
>   - Removed the first section of a sed command ("s!/..\$!/X!;")
>     that converts SHA-1s to fixed strings. No SHA-1 seemed to
>     be changed by this section and neither it seemed to be used
>     after the command.
> - At second patch, removed linkat() usage, which is  POSIX.1-2008
>   and may not be supported in all platforms git is being built.
>   Now the same effect is achieved using real_pathdup() + link().
> 
> v4: https://public-inbox.org/git/20190322232237.13293-1-matheus.bernardino@usp.br/
> 
> Matheus Tavares (6):
>   clone: better handle symlinked files at .git/objects/
>   dir-iterator: add flags parameter to dir_iterator_begin
>   clone: copy hidden paths at local clone
>   clone: extract function from copy_or_link_directory
>   clone: use dir-iterator to avoid explicit dir traversal
>   clone: replace strcmp by fspathcmp
> 
> Ævar Arnfjörð Bjarmason (1):
>   clone: test for our behavior on odd objects/* content
> 
>  builtin/clone.c            |  75 ++++++++++++---------
>  dir-iterator.c             |  28 +++++++-
>  dir-iterator.h             |  39 +++++++++--
>  refs/files-backend.c       |   2 +-
>  t/t5604-clone-reference.sh | 133 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 235 insertions(+), 42 deletions(-)
> 
> -- 
> 2.20.1
> 
