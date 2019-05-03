Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B5EA1F453
	for <e@80x24.org>; Fri,  3 May 2019 09:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfECJsc (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 05:48:32 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:32821 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfECJsb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 05:48:31 -0400
Received: by mail-it1-f194.google.com with SMTP id u16so2871634itc.0
        for <git@vger.kernel.org>; Fri, 03 May 2019 02:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sZkOtSttLgFR3HJ3iedhx0AAVw/3JuLF2l/qtX3ax5w=;
        b=LE4vP9HeytPWnsLRS9z2hXGdLofRjcB2ALLYxyIl7BcBiwBdFk3Oz35QcTD7qaCpxp
         qdHjnsJ2+E/plhgnfoaWJP3Kett1gjVRpl23V0UBwZfb04gXqunk7KPgy6we56HwhgjC
         RvWsbBuO/yBFjDW5Ox1ACdQLhA7Sonxk53D22rbU8jdslfEv4vra0vvD2wYmodrhIfuM
         1PQp3/Mbq02Q0SuFTdJ400vl+Jk0Om5HQqtO4D3SU28fnk6fcE8v0CVLtGx4kFz0tnfD
         PQ8MViUbXucc6s1Nc7wDPq+dIMt6uTYN2cX9RJKszCJuIHzW3L/VS28AjJg42Z0cSE1U
         FiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sZkOtSttLgFR3HJ3iedhx0AAVw/3JuLF2l/qtX3ax5w=;
        b=QuYVE06HPvtRQLQeXSZDblmpvBbULONnhM/nJaieH+fVMSbXo9WK3I9kNWDWRLpFdP
         YJqOV2Jzx4ZgU02WiZAy0oqI6DnZaykOGFQCICpktAAiP/9GH2vhZfizgGFWIOA9VNYh
         FiQTWs1m+Uj6dJtGQvvM7zUsl0i6QlQF2Ki85dswLP6KCoA9tcRvlknhq8d7acdl7+qW
         OiNHuVxB8pAvrU3u76vLz+UHZWQA8nY25E91M4fjvBCp+sQh730lQ0hXijLFa8RU/FPT
         TIKMAt/hhb3xihYx+DDbIdPEWiQmQu8IuD4/HR0tq7SnIW+XmxxVzmP2LHV4Asii5X+Q
         tI4g==
X-Gm-Message-State: APjAAAXmggHbQHaf2+aD5xug1HgIeGQNGN2D4kqP4e3oaVOZSZ3LHdVS
        6NEl0LfUhvsE7IQKCV0+g6c=
X-Google-Smtp-Source: APXvYqyLtzx6DgMkQcusGxCVMxh6ckI8l4FoJAWI2EJKh9See8gbF1Rq099d/bjKVPZ+wC5MuMiw2Q==
X-Received: by 2002:a24:d245:: with SMTP id z66mr6004706itf.35.1556876431171;
        Fri, 03 May 2019 02:40:31 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id a134sm819088itd.19.2019.05.03.02.40.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 03 May 2019 02:40:30 -0700 (PDT)
Date:   Fri, 3 May 2019 05:40:27 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 0/4] remove extern from function declarations
Message-ID: <20190503094027.GA1729@archbookpro.localdomain>
References: <cover.1555352526.git.liu.denton@gmail.com>
 <cover.1555487380.git.liu.denton@gmail.com>
 <20190422214901.GA14528@sigill.intra.peff.net>
 <20190425120758.GD8695@szeder.dev>
 <nycvar.QRO.7.76.6.1904301919580.45@tvgsbejvaqbjf.bet>
 <20190501100108.GA8954@archbookpro.localdomain>
 <20190502000422.GF14763@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190502000422.GF14763@szeder.dev>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 02, 2019 at 02:04:22AM +0200, SZEDER Gábor wrote:
> On Wed, May 01, 2019 at 06:01:08AM -0400, Denton Liu wrote:

[snip]

> > 
> > -- >8 --
> > Subject: [PATCH] Makefile: filter out compat/ from coccicheck
> > 
> > Since most files in compat/ are pulled from external sources, ensure
> > that they do not get modified when we run coccicheck because we do not
> > want them to differ from upstream as much as possible.
> > 
> > Make exceptions for mingw.c and win32/*.c as these are files that we
> > have created and not pulled from upstream.
> 
> I'm not sure that we really need these exceptions.
> 
> C_SOURCES comes from C_OBJ, i.e. it is basically all '*.c' source
> files that we compile, taking the platform and Makefile knobs into
> account.  On Linux we don't compile 'compat/mingw.c' and
> 'compat/win32/*.c', so when running 'make coccicheck' on Linux it
> won't look into these source files anyway, so we don't need these
> exceptions.  On Windows, however...  well, is it even possible to
> build and run Coccinelle on Windows in the first place, with all its
> OCaml dependencies?!  If not, then these exceptions won't do any good.

I assumed that Coccinelle runs on Windows but now that you mention it,
Cocci's origin was as a Linux refactoring tool so I'm not really sure if
it actually does run. Unfortunately, I don't have a Windows box
available to test it out on so let's assume that it doesn't work on
Windows, unless someone says otherwise.

> 
> Anyway, if we do want these exceptions, then what about
> 'compat/win32mmap.c' and 'compat/winansi.c'?  They look like "ours" as
> well.

Good point, I wasn't really sure which ones were ours so I just went off
of what Johannes said. If we decide to keep the exceptions, I'll dig
through the log messages to find all of "our" files.

> 
> 
> FWIW, out of curiosity I've run 'make coccicheck' on Linux with
> 'compat/mingw.c' and its friends explicitly added to C_SOURCES, and it
> seems to work...  it even found two places in 'mingw.c' where
> COPY_ARRAY could replace memcpy() :)
> 

Since you mentioned this, shouldn't we run Coccinelle on all of our
source files, not just the ones that are compiled? Since the
Windows-files aren't checked, they are in a blindspot for us.

I guess a point against that would be if one were patching a file that
they couldn't even test-compile, then it could be possible that faulty
patches are sent, but I guess we have enough people on the mailing list
that could verify the patches so I don't think that's a problem.

Perhaps we could implement a 'coccicheckall' target which excludes
contrib/ but excepts mingw.c and friends?
