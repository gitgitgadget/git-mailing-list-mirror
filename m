Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DD7E20248
	for <e@80x24.org>; Tue, 26 Feb 2019 17:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfBZRsq (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 12:48:46 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:30339 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727624AbfBZRsq (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 26 Feb 2019 12:48:46 -0500
X-IronPort-AV: E=Sophos;i="5.58,416,1544482800"; 
   d="scan'208";a="371011943"
Received: from nautfst12.univ-lyon1.fr (HELO moylip) ([134.214.142.79])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2019 18:48:44 +0100
From:   Matthieu Moy <Matthieu.Moy@matthieu-moy.fr>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: Do test-path_is_{file,dir,exists} make sense anymore with -x?
References: <pull.152.git.gitgitgadget@gmail.com>
        <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
        <CACsJy8DG6+mmA5NT67V46=n1-5H_eh3779eE28YN4kcjb0Cq0A@mail.gmail.com>
        <87sgwav8cp.fsf@evledraar.gmail.com>
        <20190226170400.GC19739@szeder.dev>
Date:   Tue, 26 Feb 2019 18:48:43 +0100
In-Reply-To: <20190226170400.GC19739@szeder.dev> ("SZEDER \=\?iso-8859-1\?Q\?G\?\=
 \=\?iso-8859-1\?Q\?\=E1bor\=22's\?\= message of
        "Tue, 26 Feb 2019 18:04:00 +0100")
Message-ID: <86va1630g4.fsf@matthieu-moy.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Tue, Feb 26, 2019 at 05:10:30PM +0100, Ævar Arnfjörð Bjarmason wrote:
>> However. I wonder in general if we've re-visited the utility of these
>> wrappers and maybe other similar wrappers after -x was added.
>
>> But 4 years after this was added in a136f6d8ff ("test-lib.sh: support -x
>> option for shell-tracing", 2014-10-10) we got -x, and then with "-i -v -x":
>
> '-x' tracing doesn't work in all test scripts, unless it is run with a
> Bash version already supporting BASH_XTRACEFD, i.e. v4.1 or later.
> Notably the default Bash shipped in macOS is somewhere around v3.2.

According to http://www.tldp.org/LDP/abs/html/bashver4.html#AEN21183,
bash 4.1 was released on May, 2010. Are you sure macOS is _that_ late?

I also tried with dash, and -x seems to work fine too (I use "works with
dash" as a heuristic for "should word on any shell", but it doesn't
always work).

If -x doesn't work in some setups, it may be a good reason to wait a bit
before trashing test_path_is_*, but if it's clear enough that the vast
majority of platforms get -x, then why not trash these wrappers indeed.

-- 
Matthieu Moy
https://matthieu-moy.fr/
