Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F7BB1F45F
	for <e@80x24.org>; Tue,  7 May 2019 11:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfEGLTL (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 07:19:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34234 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGLTK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 07:19:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id f7so11461988wrq.1
        for <git@vger.kernel.org>; Tue, 07 May 2019 04:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qX2rmZ4RQtkDIkwv8dt3J0xRMtCRnbdSl9RjES7njMs=;
        b=XDiupsFGl+Wi1LPU6qvXvBw4gQggGa6VAMlovytv05v2dI/fIyyKDlXi8sDmrYPdje
         B0+2+a/IVay7MuLpu4XzAQyTgIK1rhNCM7SsYxTDZfrInaz27DAOKX6C4gJor+1rVuWZ
         jaIpsLKEHTIAvMKQpX8t9n22u5R9++AZY+GSXgF7lCLf4WTswD6HdPnvhDMpn61leLZr
         VIT2QdcQplCKZy1FzFZweglUSxZAybIAPqsJgtPz+7Jh8amX6FaGqYIcDJ7zyRsAFoKb
         4QUe/tiKu+avZ/xhG0XxnAav45yhTrDDbzUGtuf1hOqe0YBAH12Y0qqE0M7yRJK8bbjK
         3gyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qX2rmZ4RQtkDIkwv8dt3J0xRMtCRnbdSl9RjES7njMs=;
        b=F4LhcgeDCCyvXm6qKeDZrkBswWUDKiBXfdCJIeyLcgkBcNyPhm9gWNCSaqbJvslDZI
         tr0eziNbX6BR581bjiMuZdeWxxkofzxB0B/OKPQSmo2zl8xy8S+B1yJxBuVUdr/prwZg
         M++6ei7//zEioZtuKNTcxnprkHCdNiZrfyMkcMi6R7MpMvhPSxM6U05Y46WUHHGWSh2r
         5UYCZLf+7hILbQFaFdTF53Y2SqKKIQ7ZSu473J25ZsNz/WTmqiWqbMVoqJBtce3KT5yY
         wPJzM7tIThmfd+LIjbWbOgq/XnO3TCYoMiADMmwbb4H+4YPKUEk2sPtwoEox04EZYevF
         E7aw==
X-Gm-Message-State: APjAAAUVzrOx0iN/SdDCLRh8SwYT/z8uNA0Jz30ErB5fOwSNTQQYrhvU
        OjR9/OsvYKnmp3wGvpwEg7dvClRjVew=
X-Google-Smtp-Source: APXvYqz4onkuNr4/ZrF5Xcc2FYKCEOW+JFAz98BbvBAk7ETG1+8j5v5cQTl8dbVbbdPLqNGhcNCJsg==
X-Received: by 2002:a5d:4a87:: with SMTP id o7mr21984501wrq.207.1557227949050;
        Tue, 07 May 2019 04:19:09 -0700 (PDT)
Received: from szeder.dev (x4db46d44.dyn.telefonica.de. [77.180.109.68])
        by smtp.gmail.com with ESMTPSA id c10sm29102629wrd.69.2019.05.07.04.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 04:19:08 -0700 (PDT)
Date:   Tue, 7 May 2019 13:19:06 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] coccicheck: optionally batch spatch invocations
Message-ID: <20190507111906.GM14763@szeder.dev>
References: <nycvar.QRO.7.76.6.1904301919580.45@tvgsbejvaqbjf.bet>
 <20190501100108.GA8954@archbookpro.localdomain>
 <20190502000422.GF14763@szeder.dev>
 <nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet>
 <20190503144211.GH14763@szeder.dev>
 <20190503174503.GA8242@sigill.intra.peff.net>
 <CA+P7+xoRGVAP4nHE=neUZGkn9RX_hxN9xVzfWexR79ZWT0ejSQ@mail.gmail.com>
 <20190506051148.GB30003@sigill.intra.peff.net>
 <CACsJy8CLjUdHCro8QJfTozMB0xVWppHuFRSLCvFSaeKO_PxAog@mail.gmail.com>
 <20190506234334.GA13296@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190506234334.GA13296@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 06, 2019 at 07:43:34PM -0400, Jeff King wrote:
> Subject: [PATCH] coccicheck: optionally batch spatch invocations
> 
> In our "make coccicheck" rule, we currently feed each source file to its
> own individual invocation of spatch. This has a few downsides:
> 
>   - it repeats any overhead spatch has for starting up and reading the
>     patch file
> 
>   - any included header files may get processed from multiple
>     invocations. This is slow (we see the same header files multiple
>     times) and may produce a resulting patch with repeated hunks (which
>     cannot be applied without further cleanup)

I wonder what would happen (and how it would perform) if we told
spatch to ignore all include files from our C sources, but then run it
on each of our header files as well.  It still would have to parse the
semantic patches over and over again, but those are rather small
(compared to, say, 'git-compar-util.h' and 'cache.h' that are included
in most of our source files).  But I don't know how the lack of
information about preprocessor macros would affect Coccinelle's
analyzis.

> Ideally we'd just invoke a single instance of spatch per rule-file and
> feed it all source files.

Well, ideally we would invoke spatch with '--dir .' to "process all
files in directory recursively", and exclude those that we are not
interested in (parts of 'compat/', 'sha1dc')...  but alas, such an
exclude mechanism doesn't seem to exist.

