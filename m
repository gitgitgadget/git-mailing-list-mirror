Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C12981F453
	for <e@80x24.org>; Fri, 28 Sep 2018 00:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeI1Gkb (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 02:40:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35449 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeI1Gkb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 02:40:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id o16so4482263wrx.2
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 17:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rSLsRM2REk+9bYLHPWK+W/IxqwjdUpPtwZqeNsk8oyY=;
        b=pOwNUK7rbZB7jQeKTQcr4Z9RdWP/eEL/N8CyiR3HNHDZs7AWoHeWDYfWRuIBktHZt3
         NovFkQzyBlIgAgSgOltmCeOwOJ9sx+Dv0gx2QSB5wQvTH0Xtymz08euoI0/UivrM7ttl
         hECKI4rAIIk+l3EcInFn6AbG4+Rk2LSA1sdb8obJg4x5oxK0ZASojgPqaAZQ3B8JU1uL
         cgpOewwoYHj09GW9GrIY1H9TkaGiwfrfoJPQBn/tY+5MC8HY7c/F8N2ZyxSVVDYNh52Z
         gMJrdz+HSDBKowkbL4pzF1RKoiuuITDPIp3bZubglQ5fg5DjwsJIhaT+UlbQTvedGrjZ
         790w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rSLsRM2REk+9bYLHPWK+W/IxqwjdUpPtwZqeNsk8oyY=;
        b=O5z5YlXvoXTaqZhD/S8I4OBdC1DmshwXi6zQkhoWOBtfdWFR+I4gPot7SFvAL2ftRf
         WPJUXXjFzkxrjd9QbPYGxN0O/f6tZAZVnwR62SivL2mIp3bVtmbeUnQoVsNllB6hknla
         qlMjRK+iEWx1KJGXhirppC/0oMfc7S5IkrwZoEGUQUg6ultidZESbilOzXpUnbg9dSbE
         ZHAz+BOR1mH0zaqGYkJ6vCRGYt02Q2K9YtNM40Gmfgsw/4e82zBn87OWt1IIkgWvMZQA
         j1qJUEXzlMM22mecm09W0eoJgbXgJhBBbMrao8beQ4PVgoQbN36QVXJxRYm+PBmhowc1
         ovYQ==
X-Gm-Message-State: ABuFfoiKQUygEUaBI60mWV2iMWzCLNLzSakMfNQhGLyYi6gWrB09zm7F
        MFaCbxDTbHFypSckyeMRXXE=
X-Google-Smtp-Source: ACcGV629IwrF25kKYF0oJRg4OM5weNCUK9kG7S2zR/3qYUqDf+rOdMADMWyLBge7AtM4aqJHeNqXew==
X-Received: by 2002:adf:e2c5:: with SMTP id d5-v6mr10515045wrj.139.1538093974585;
        Thu, 27 Sep 2018 17:19:34 -0700 (PDT)
Received: from localhost (x4dbd8656.dyn.telefonica.de. [77.189.134.86])
        by smtp.gmail.com with ESMTPSA id f12-v6sm3056805wrj.55.2018.09.27.17.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 17:19:33 -0700 (PDT)
Date:   Fri, 28 Sep 2018 02:19:29 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v6 3/7] eoie: add End of Index Entry (EOIE) extension
Message-ID: <20180928001929.GN27036@localhost>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180926195442.1380-1-benpeart@microsoft.com>
 <20180926195442.1380-4-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180926195442.1380-4-benpeart@microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 03:54:38PM -0400, Ben Peart wrote:
> The End of Index Entry (EOIE) is used to locate the end of the variable

Nit: perhaps start with: 

  The End of Index Entry (EOIE) optional extension can be used to ...

to make it clearer for those who don't immediately realize the
significance of the upper case 'E' in the extension's signature.

> length index entries and the beginning of the extensions. Code can take
> advantage of this to quickly locate the index extensions without having
> to parse through all of the index entries.
> 
> Because it must be able to be loaded before the variable length cache
> entries and other index extensions, this extension must be written last.
> The signature for this extension is { 'E', 'O', 'I', 'E' }.
> 
> The extension consists of:
> 
> - 32-bit offset to the end of the index entries
> 
> - 160-bit SHA-1 over the extension types and their sizes (but not
> their contents).  E.g. if we have "TREE" extension that is N-bytes
> long, "REUC" extension that is M-bytes long, followed by "EOIE",
> then the hash would be:
> 
> SHA-1("TREE" + <binary representation of N> +
> 	"REUC" + <binary representation of M>)
> 
> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
> ---
>  Documentation/technical/index-format.txt |  23 ++++
>  read-cache.c                             | 151 +++++++++++++++++++++--
>  t/README                                 |   5 +
>  t/t1700-split-index.sh                   |   1 +
>  4 files changed, 172 insertions(+), 8 deletions(-)
> 

> diff --git a/t/README b/t/README
> index 3ea6c85460..aa33ac4f26 100644
> --- a/t/README
> +++ b/t/README
> @@ -327,6 +327,11 @@ GIT_TEST_COMMIT_GRAPH=<boolean>, when true, forces the commit-graph to
>  be written after every 'git commit' command, and overrides the
>  'core.commitGraph' setting to true.
>  
> +GIT_TEST_DISABLE_EOIE=<boolean> disables writing the EOIE extension.
> +This is used to allow tests 1, 4-9 in t1700-split-index.sh to succeed
> +as they currently hard code SHA values for the index which are no longer
> +valid due to the addition of the EOIE extension.

Is this extension enabled by default?  The commit message doesn't
explicitly say so, but I don't see any way to turn it on or off, while
there is this new GIT_TEST environment variable to disable it for one
particular test, so it seems so.  If that's indeed the case, then
wouldn't it be better to update those hard-coded SHA1 values in t1700
instead?

>  Naming Tests
>  ------------
>  
> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index be22398a85..1f168378c8 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -7,6 +7,7 @@ test_description='split index mode tests'
>  # We need total control of index splitting here
>  sane_unset GIT_TEST_SPLIT_INDEX
>  sane_unset GIT_FSMONITOR_TEST
> +GIT_TEST_DISABLE_EOIE=true; export GIT_TEST_DISABLE_EOIE
>  
>  test_expect_success 'enable split index' '
>  	git config splitIndex.maxPercentChange 100 &&
> -- 
> 2.18.0.windows.1
> 
