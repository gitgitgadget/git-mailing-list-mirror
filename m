Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9383620248
	for <e@80x24.org>; Fri, 29 Mar 2019 20:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfC2UFV (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 16:05:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45647 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729972AbfC2UFV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 16:05:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so4004435wra.12
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 13:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c9Om5PO5rhUn9df7p1AjtehE2Y8pzZQxrWMK4t0LJkM=;
        b=jgp6HLwRUFEYOzJN5Oyfv5jjPDNo8noOqJFIl+BljQm3RQF7bu8Hqvge+hmnLAaLsW
         HTEXChJzr6njvax3UDziJlsamsva7dmtkAjj6TyfMenxkd1gKo9nwcQty/uEKDET0eth
         0VAoE6eFCQ6u+baYCvMbUZdfDgQT5agdjmQsRjfWburbwobmrztEQFY56HE8hWtGGax3
         xTh6A3qZOiQOzTsTHh8/+hl9bwz6RPFVHDKeUcMeMAEIkENakISCo9bhVrDSv0NvRQy2
         cTsmU6aQZlGZJGxGlFVDQOz7hrY834AzwA/JdPt+DU1RGFssLpf9AI0UgrVUyIDLc5CE
         eOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c9Om5PO5rhUn9df7p1AjtehE2Y8pzZQxrWMK4t0LJkM=;
        b=W/gOW2I/VdxKkhwFqPTgVZ464UV106S5BJfwh6Cif1aBlSjAV6sga+cpcKC9VY386d
         Fju+8HM+MLw83+EKLrpWeJ8beZ9REcqhBP9QhUPOlsx+QsWv80rg8yFGkNU1rfHPgVnk
         DsRS6qH6aDg8DeLsuFFKGCQVsq0bxklGcTBBXA8UpccS3PlGvtTj58FPQQ+QcE/Ny2qv
         xSlfsgBvwOr1X7YcozWSLFjHesB9w6KhlolRaJpJg3S505TkBUSKCrr3C3ys4SZ1A6GR
         TABrr6OuLfRgr2lM8QBx1kMmVClNnqk1RkGHFFX5oojNbM2nDyCB6ftZE/tbQe9cMNPE
         HfRw==
X-Gm-Message-State: APjAAAUM/djF4ihOSS+CsGwY8uRc2iO1rkcjDUYpW+sHB7ArcUq8iDtK
        X25MgsnoPZLDEw9Pc62wsqU=
X-Google-Smtp-Source: APXvYqzQuWo+cA3DzP7JCnz/jsg90L5kbZ/WYMnFAWj3mlz0ebXtibhXNx9YCSbH+cx7KcftLxIQQw==
X-Received: by 2002:adf:d84d:: with SMTP id k13mr35833405wrl.154.1553889919198;
        Fri, 29 Mar 2019 13:05:19 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id o130sm5627173wmo.43.2019.03.29.13.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 13:05:17 -0700 (PDT)
Date:   Fri, 29 Mar 2019 20:05:17 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>,
        Benoit Pierre <benoit.pierre@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GSoC][PATCH v4 2/7] clone: better handle symlinked files at
 .git/objects/
Message-ID: <20190329200517.GO32487@hank.intra.tgummerer.com>
References: <20190226122829.19178-1-avarab@gmail.com>
 <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190322232237.13293-3-matheus.bernardino@usp.br>
 <20190328221049.GK32487@hank.intra.tgummerer.com>
 <CAHd-oW78Cwhq8sFFjOX4c6kS8JsEUUd_RGgheJhdN6MLAr+G2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd-oW78Cwhq8sFFjOX4c6kS8JsEUUd_RGgheJhdN6MLAr+G2Q@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/29, Matheus Tavares Bernardino wrote:
> On Thu, Mar 28, 2019 at 7:10 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > I notice that we are currently not using 'linkat()' anywhere else in
> > our codebase.  It looks like it has been introduced in POSIX.1-2008,
> > which sounds fairly recent by git's standards.  So I wonder if this is
> > really supported on all platforms that git is being built on.
> >
> > I also wonder what would need to be done on Windows if we were to
> > introduce this.  I see we define the 'link()' function in
> > 'compat/mingw.c' for that currently, so I guess something similar
> > would be needed for 'linkat()'.  I added Dscho to Cc for Windows
> > expertise.
> 
> Ok, what if instead of using linkat() we use 'realpath(const char
> *path, char *resolved_path)', which will resolve any symlinks at
> 'path' and store the canonical path at 'resolved_path'? Then, we can
> still keep using link() but now, with the certainty that all platforms
> will have a consistent behaviour? (also, realpath() is POSIX.1-2001)
> Would that be a better idea?

Yeah, I think that is a good idea.  Note that 'realpath()' itself is
not used anywhere in our codebase either, but there is
'strbuf_realpath()', that from reading the function documentation does
exactly what 'realpath()' would do.  So using 'strbuf_realpath()'
would probably be the right thing to do here.
