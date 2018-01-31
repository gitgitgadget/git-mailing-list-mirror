Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC9FF1F404
	for <e@80x24.org>; Wed, 31 Jan 2018 23:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932094AbeAaXWu (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 18:22:50 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50919 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754273AbeAaXWt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 18:22:49 -0500
Received: by mail-wm0-f68.google.com with SMTP id f71so2340920wmf.0
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 15:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=aHssFkDunlWYO1VXwSUFqmntyIqeGsBCu7v1Pew1hRU=;
        b=ldAaQyQxQg95VwDGq04MlYyZ0cROUF9BoObgDSARZFkz9cjs7yH8vyhYZvANiwVguM
         UFWnYmF4icKV4jiCFyl5Lz16lP5Q8PZ7X9AHM6OJVZZdEf5Vu0lnfRNW/GVeImxB4f9A
         pooCgrG2jNpf+CERN+rtlOOFTChNjPp7KQim53rjkJEXnF9VUFGyJH7ejPXV0CHYkTNS
         aAUYCJt4LGclmNj7zFzoMnD3JzfuYcP9D+o8r4d8XblFB8G3z/nDdVN5XirF+MGBm+sK
         BJGT90dY0HgNsNCFb3SQ8UxA3JjEBVWC+OxJBV9cn1YVTf2VumXiPGLfGWyFTNFAJQb2
         PdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=aHssFkDunlWYO1VXwSUFqmntyIqeGsBCu7v1Pew1hRU=;
        b=uFvR7AOlCLk146ltw5Yf6Zk9jhpZMPt+lVsZRGMboF+hwPouG5HxJynl3lgXcqukkC
         fxzLbhj4ttCoPwaLnhVQ3OQEqHTIG9k4hZgqQs4ZlK5jfm/B2Wwi/KtWwGlFVwz702vi
         enxlpw1+5QdfPtGii9Y+uY4+p53otWIvBEvrR3VjjIjlImu1OgdXTsErNOfth/YpO9N0
         3KJN3kov9Vmwc68ESfDiN0afJsiWHrZubLKbCPEfANfn245CkeyejrN3IJZAc+f9/yV7
         ush9LQGMCri7a4y3Vgodq+cKBD+TIt9PAxXBy6DePdWqUWH87HxVpZF/MIgynR5mzGow
         mcdQ==
X-Gm-Message-State: AKwxytfcueFBlTrmW9imqwfuW0RZ8u/8vk7QZhx6CNcHkAa0d2ykLkdd
        57LMhqZIiopCCy2xE6Z5g4I=
X-Google-Smtp-Source: AH8x227nEgxXa+1/EDEM7qbtBrlvbTKa3pACIMrHIZaazm+yd5oKmKgXFncXgEStSVTSzuYibPY2pg==
X-Received: by 10.28.235.6 with SMTP id j6mr4948401wmh.22.1517440968093;
        Wed, 31 Jan 2018 15:22:48 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 62sm923716wml.24.2018.01.31.15.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jan 2018 15:22:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>, tim@tim-landscheidt.de
Subject: Re: [PATCH] gitignore.txt: elaborate shell glob syntax
References: <20180126095520.919-1-pclouds@gmail.com>
        <20180131093051.15525-1-pclouds@gmail.com>
        <20180131093051.15525-3-pclouds@gmail.com>
Date:   Wed, 31 Jan 2018 15:22:46 -0800
In-Reply-To: <20180131093051.15525-3-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 31 Jan 2018 16:30:49 +0700")
Message-ID: <xmqqh8r1r4u1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

>     `.gitignore` file).
>  
> - - Otherwise, Git treats the pattern as a shell glob suitable
> -   for consumption by fnmatch(3) with the FNM_PATHNAME flag:
> -   wildcards in the pattern will not match a / in the pathname.
> -   For example, "Documentation/{asterisk}.html" matches
> -   "Documentation/git.html" but not "Documentation/ppc/ppc.html"
> -   or "tools/perf/Documentation/perf.html".
> + - Otherwise, Git treats the pattern as a shell glob: '{asterisk}'
> +   matches anything except '/', '?' matches any one character except
> +   '/' and '[]' matches one character in a selected range. See
> +   fnmatch(3) and the FNM_PATHNAME flag for a more accurate
> +   description.

Where the original did not quote single letters at all, this uses a
pair of single quotes.  Did you make sure it renders well in HTML
and manpage already or should I do that for you before applying?

I think what you wrote is accurate enough already, and those who
want to go to fnmatch(3) would do so not for accuracy but for
authority ;-) Perhaps s/accurate/detailed/?



