Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCE9C20248
	for <e@80x24.org>; Wed, 27 Mar 2019 12:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfC0MOR (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 08:14:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54483 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfC0MOR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 08:14:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id f3so15982536wmj.4
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 05:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Cy02O4/3XrbIqx3nDOR9+4sjNVZ4mw/s6sHQdFKpPEg=;
        b=XqJ692fmey2j+ORN6uHaXEN/AuPl2aOVaNao2WrLVQO6ZJeaWhhTFqYH4kngz97yjB
         NKWa0hjrKr/DTPUCeFSWPa2vJonipFG4YYR+plSq28s4qTr19uHre6OXK9fDp5sro/as
         CQrKZUj2w9/zWh0z4kAfMVCRvNea6eUKeyFFGCjVEqtAQS5xSj+3MWid+nqsCLB8RX/H
         yu2BmjbpOYDwG5b/n2nxQ6o2EAVZPLkME2BCVj3vBPMFRL4UgPOfd1xrJ3sfm80llSWe
         cf6+DURr7jCeOy5++j1k2VgAKaYMhzvfYbnkqQtcWk9vfgAwPfwDL/4s1A0WqDRoMk9G
         djoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Cy02O4/3XrbIqx3nDOR9+4sjNVZ4mw/s6sHQdFKpPEg=;
        b=Xo9B8MRsauZ5jcbgEo1ELLzg6dmHPIKO1F1DRQ/5Dzz0zQuaCEgZXLTRtIzzUncz17
         2/9F5tVO9tnKdIzED+Ebw80lUSqNWeuUkV6OBn//DaZROKKf7C9cVYJFPNN+7ZGiqEWe
         RItJ2QSvKHEVYDzPuiLMUXReC6IIz1QE8vZ0P6jR8OcFAZFpRMneVxW34dU5Pd5C2Oux
         4UUy/64G7JKRWJrywnfJT1CQOPXvhdauahyIWuR1kgzVVdtmc5ncYkny695cr/HSOSuA
         mMHvvSdJFVoimdk2q3Vnv1jhGDzzZz4GCBGvY1ovUyNA5hOJfHjVWJ0GdJTu4ERL4Nf7
         X/8Q==
X-Gm-Message-State: APjAAAXQ5VnaEZKALzTeizvQy7FEz9/kK7DOqkACpTiOnn7fZCnRJqiA
        tFauGbRPaPWfHnQIX9PO2E6v2sLg
X-Google-Smtp-Source: APXvYqydikTyKq7OacTATa9u/MfHShaUa5Ho73RYNtewdc2FJQyxjWarfbPQRFLZb+YmTkOAI4goBA==
X-Received: by 2002:a1c:e185:: with SMTP id y127mr13027987wmg.76.1553688854573;
        Wed, 27 Mar 2019 05:14:14 -0700 (PDT)
Received: from szeder.dev (x4d0c7b09.dyn.telefonica.de. [77.12.123.9])
        by smtp.gmail.com with ESMTPSA id z14sm26545899wrv.78.2019.03.27.05.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 05:14:13 -0700 (PDT)
Date:   Wed, 27 Mar 2019 13:14:11 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, Mooga <contact@m-mooga.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [GSoC] microporject test_path_is_*
Message-ID: <20190327121411.GE32732@szeder.dev>
References: <38B8E527-2338-485E-8840-29121F259687@m-mooga.com>
 <CABPp-BHwUoqk79Kf=ynna5x+mCJyOLz66v6pDieyEeM7YCRS+g@mail.gmail.com>
 <877eckbpdd.fsf@evledraar.gmail.com>
 <20190327104935.GD32732@szeder.dev>
 <874l7obm0c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874l7obm0c.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 27, 2019 at 12:21:55PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Mar 27 2019, SZEDER Gábor wrote:
> 
> > On Wed, Mar 27, 2019 at 11:09:18AM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> > There are likewise several that use one of
> >> >    ! test -e path/to/filename
> >> > or
> >> >    ! test -f path/to/filename
> >> > or
> >> >   test ! -f path/to/filename
> >> > which could be replaced by
> >> >   test_path_is_missing path/to/filename
> >>
> >> Interesting that for some we use the 'test_is_there/test_is_not_there'
> >> pattern and for others 'test_is_there [!]'. E.g
> >> test_path_exist/test_path_is_missing v.s. test_i18ngrep.
> >
> > It's unclear what the '!' should negate in case of 'test_path_is_file
> > ! file'.  What if 'file' does exists, but it's not a file but a
> > directory, socket, fifo, or symlink?  'test ! -f file' returns success
> > in these cases as well.
> >
> > OTOH, it's quite clear what the negation should mean in case of
> > 'test_i18ngrep'.
> 
> *Should* we make it better? Yeah sure, maybe. I'm just pointing out for
> context to someone poking at this for the first time that now we
> sometimes do "! foo <arg>" v.s. "foo <arg>" as "foo_is <arg>" and
> "foo_not <arg>" and other times "foo [!] <arg>".
> 
> So yeah, maybe we should improve things to disambiguate the cases you
> mentioned, but right now e.g. "test_path_exists" and
> "test_path_is_missing" are just "test -e" and "! test -e", respectively.

I'm not sure why 'test_path_exists' exists, as I don't readily see a
valid reason why a test should only be interested in whether the path
exists, but but not whether it's a file or a directory.  Luckily it
haven't caught on, and it's only used twice in the whole test suite.

However, as shown above, the existend of 'test_path_is_missing' is
very much justified.

> The same caveats you've mentioned also apply to "test_i18ngrep" b.t.w.,
> there we squash the 3x standard exit codes of grep[1] into a boolean,
> and thus e.g. ignore the difference between <file> not matching an
> <file> being a directory or whatever.

I'm not sure I understand, 'test_i18ngrep' handles the missing file or
not a file cases reasonably well:

  expecting success: 
          test_i18ngrep ! foo nonexistent-file
  
  error: bug in the test script: test_i18ngrep requires a file to read as the last parameter

or

  expecting success: 
          mkdir dir &&
          test_i18ngrep ! foo dir
  
  error: bug in the test script: test_i18ngrep requires a file to read as the last parameter


> 
> 1. http://pubs.opengroup.org/onlinepubs/009695399/utilities/grep.html
