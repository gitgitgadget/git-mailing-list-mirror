Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 506A31F731
	for <e@80x24.org>; Mon,  5 Aug 2019 19:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbfHETc6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 15:32:58 -0400
Received: from mout.gmx.net ([212.227.15.18]:38359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728759AbfHETc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 15:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565033571;
        bh=U8iOpQZ6kipAwAJcZOOb++WtzhlosoHxWgX1LNampG8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DIjXFSOIlzOmVgxFwh3ehO4lF5Nae6yOVBI3XK7oipfa58TbO+kRMQdEv3/azbkQW
         Qgpyw6iAWYWIU57fDOuv01BmL2mdr6QDnVZjHX7kWdVANBtyKRyRObMB1kSsX4Voga
         bgwUsmvh6ZzZA7cVTvbAq1SPsTSmCx6ZYv2kzTI0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M6zkD-1iI2VS1ZDh-00wkLQ; Mon, 05
 Aug 2019 21:32:51 +0200
Date:   Mon, 5 Aug 2019 21:32:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Carlo Arenas <carenas@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] pcre2: allow overriding the system allocator
In-Reply-To: <CAPUEspi2i_ZYoseQ8SkJm6k-YPva3fR4G5kFsGOT0KyNZNkQEw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908052132020.46@tvgsbejvaqbjf.bet>
References: <pull.306.git.gitgitgadget@gmail.com> <3397e6797f872aedd18c6d795f4976e1c579514b.1565005867.git.gitgitgadget@gmail.com> <CAPUEspgH1v1zo7smzQWCV4rX9pKVKLV84gDSfCPdT7LffQxUWw@mail.gmail.com>
 <CAPUEspi2i_ZYoseQ8SkJm6k-YPva3fR4G5kFsGOT0KyNZNkQEw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Dms28iLdCm6tR2ujN7HYvA2qhfHxOt2Vc3HMyhBaq1tbsMGwnbk
 5xWSFoVYk1NBbgnGVy2Xn/ILyuYRJEXmB8CM9S88f5TdCfikbcpqoaWgXK5nA4lNQZP+34s
 Go/kglyfPNnERdrDhWsX6KRFMfUZKkULkYeUjotLt6aOhCDCUpubQnH3wL2Z3IjNABBIpFp
 tKRFCeRjg4VAjAeSZWfXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JfBGIF0zclQ=:hsB285ijauqx/sIJIGrfIL
 fqOsfY8AYyJ9xqC5kQ7qFK1ASBTXiQ2NdtCXezXW5MHR6PCpwx2Ko/aUwzUnl6AgM7VRPKYod
 4cvAd3HWOT8NhWSUfaEbGxcaAc/b/uBjulta3gna3oxf2S7GNUTVFFRzITAyVAiJDfLC37SJn
 QPYUag+mZw7tNzYlfUINunQ2FXJeKhuGntryOY7tfcxTrRx0SPngeGjqyZvj39xlIqzs6YB4L
 3gPUmj2dy2o5tzAV7ONnfSXV3PUN3cFqOKnRFEDBLVCAuoGlPBFq4NJj0eBueFdkJlYTH2Y3i
 84n5KMgIViHzqnZIIqcxsqw+s+dO2qVkfovteETrci/euwKYFlr2wQX8QCMKULb+Z9eKFK4R/
 hbQwx1MZny5UOZs+RbnVLLkRXH3vUzaJu22jII8s4IMzEj0D5Se+loe8LKwxWFZM5bWlfp6Np
 Gk55kL3bO4rC2hmdd4MOf5CpvDAC6bOGOszDoidT4lmmImH3lwZF1wWjMDa+SMHdy4H1O07wA
 x3fTr7kTNcoj0/UjMRJasiuZDKB/If8xHVzwLB0wIfyyCGIGj0Tu30tcwqQdtk6+9cgJduywl
 8ysNinFs25GRd/eYv5LG2LCe3bQsNqMRkzCkuQGuyPdpMCxHv+g+JDdLWpPuMX76V0CaSYD10
 2xkZKKVwPFWSxbinmV4zDvMHOddHdNGeQqoJgTk8QHbeHuLeNgCQDXSsjhik7Y6QTkLj5gsPh
 b4+9xRxFZhj1OcHIz5JZJNpXwTiyrtObMvr70svbljjZyoYhXE5NRXlbYLagxQ1C3YctqLC7w
 a3RwOaXnkrB2WDe9Xv/RPAFRW7GlTfrtjKtB++v6E7orgH/SM2HLg8a/6wp5sRJ28e8IL6Kbv
 qXuAZ3/1ecG2UMghWmu+NIrkg052M3UP34/zo0uCetTegNnWwqzAfO76aOCdDYfsI2B+Fqbmx
 PVlk3xQ77XfHCovJoh0KMUVzHAJMZWNaMmJlsZCAb8RSJR82HMv8uPia4bjcAGi6OomjnAZ+F
 wpap8OxVA3ACSdEUzYIUQhEZkl9ldS8BSrCHC48UL/Tyh3Ofkb3ic442tY8hFTutGz4CdTcYD
 L0znvgNGHmXbSFb3oiMk0p2hOLYLF+lo6MwG3zkZvut9iUD/5lkcBzKOV7MAzL0VnOG+VFiJL
 qerck=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

On Mon, 5 Aug 2019, Carlo Arenas wrote:

> And forgot to mention that technically these are not UTF-8 tables but
> single byte tables like for example the ones used with en_US.ISO8859-1

Thank you for pointing that out, I completely missed that.

Junio, do you want me to re-send, or can you touch up the commit message
while applying?

Ciao,
Dscho
