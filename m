Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F05C1F453
	for <e@80x24.org>; Fri, 22 Feb 2019 00:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfBVAhP (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 19:37:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40542 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfBVAhP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 19:37:15 -0500
Received: by mail-pg1-f196.google.com with SMTP id u9so246668pgo.7
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 16:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yqaAeobRIJziOW+apdGaqODgut9LO4F0A1lgy+/6BQM=;
        b=JIcHUrH/ZHj5grCqDJZKbB6TafKfcyg0K4xiticrvebidaJNSsaG83whUvF/6/e2sh
         aAU1Ew2nUBbnLco/jhzQIkbGDQK+yvTiqGFWPzKU1BfeJL2ORM6l/I09zxm0uj3LFlgW
         u7xrLgOuN57MMOA1/pcdazMuhSpPhEQsSgSTqvJ06iz8nBBb5LfNmP++uApKiiS1RG3B
         PBUzG7qHUPmGMWld0hILlP1DvZAnlft2R5SWS/Yl83Y7pki/C+9EtYKsZTYITDa7Tk8R
         qymXmdPUy5oFGNexd+bNUK9HneZM0i9+V/PDSmiq1Z4ixyyiQ+adIrdCYSIXJjLrL4Ak
         KgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=yqaAeobRIJziOW+apdGaqODgut9LO4F0A1lgy+/6BQM=;
        b=Mr6CDBGZHkkLlU7GtBE/2RFlipNgFQXGizQ3hBChAvxVOO0pDASjOtrUikMKU0xGmN
         XrvTskIw2ujSoN59KVe61ghSjHYXtAHSIAnUiBbH1itWF/V4ZBoaHDjv6h+/8NMQDF09
         y0QKYi2aV4ZdIQplinXgU4qULx3h1dETKtt9xSAFvFG9r+lV6sxFsdYoIeFM/9PbPE+D
         Qnb1m7OJjJpTzUAk1BWNUTCbZFXAZPPz2oy9/5RsscyJzQ6IwRd5TuuARDIkgswY+ZkP
         SZGVkwv+knQA+sF4W5Hz+ZJJH0fEj/njRNEiX/O3yOjtUPkTuKrmbxe85butzpwu8VxO
         BUZw==
X-Gm-Message-State: AHQUAuarJVFA41+lKJMSz0wAoEI/Foegt3+PpwDZu6GWv5495g8EjP4g
        EALwqUHRxG8PQaa5Wh1o9QAnlA==
X-Google-Smtp-Source: AHgI3IZbF/XqnG3dKJWgCEsiHVzSHpnjPM52oruBFQYe7lU94wSgHMmRtBCazkYvrVivbhVxpvrmAw==
X-Received: by 2002:a62:4754:: with SMTP id u81mr1364567pfa.66.1550795833830;
        Thu, 21 Feb 2019 16:37:13 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id b85sm281708pfj.56.2019.02.21.16.37.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 16:37:12 -0800 (PST)
Date:   Thu, 21 Feb 2019 16:37:06 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Sebastian Staudt <koraktor@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 0/2] BSD portability fixes for 2.21.0-rc2
Message-ID: <20190222003706.GA159944@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Sebastian Staudt <koraktor@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com>
 <20190221192849.6581-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190221192849.6581-1-avarab@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.02.21 20:28, Ævar Arnfjörð Bjarmason wrote:
> Last-minute fixes for two issues new in 2.21, not in 2.20.
> 
> This fixes a NetBSD portability issue I noted in
> https://public-inbox.org/git/87d0nm5x1d.fsf@evledraar.gmail.com/
> thanks to SZEDER for the help.
> 
> Then there's a another fix for a test breaking on OpenBSD due to
> recently merged unportable regex syntax.
> 
> Ævar Arnfjörð Bjarmason (2):
>   tests: fix unportable "\?" and "\+" regex syntax
>   commit-graph tests: fix cryptic unportable "dd" invocation
> 
>  t/t5318-commit-graph.sh | 3 ++-
>  t/t6120-describe.sh     | 8 ++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> -- 
> 2.21.0.rc0.258.g878e2cd30e
> 

These both look good to me. Thanks!

Reviewed-by: Josh Steadmon <steadmon@google.com>
