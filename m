Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A125C1FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 22:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbcLEW0u (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 17:26:50 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35767 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751590AbcLEW0r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 17:26:47 -0500
Received: by mail-pg0-f42.google.com with SMTP id p66so141213115pga.2
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 14:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=en+hJ5jX23VRrVFC0sbOQ7guhk0hsuKubPxlZIUxiEg=;
        b=l/EMNa8KizEp9MxAmUU0cmR+h8UbfVkpXYePs7Nn1pELlrhVEwKQktptpbKEWUjiex
         V75+ZWUyBEbVwsUSNcNOCTNXfIjKn8ujcLl0NrmLRpbrLKm++bMczTuZFOrYisdH9LrU
         Lablkr/otIGt1K6xa9Wxs82H21vZih4ju3Kzo33/jeFJ8nq4BW/Bnm7c681dIyd+1roD
         64uF9Fo+8XzZAGreVdbFSPOnhXv9vqdwUa0l3Yc2keDxk5Jk9laKMpfvtnGzZEE5/5E4
         YDhiME+AWWIiySsCfnpHPgAC6otZlAKND4Eg/YIYLywNm9PN2LfoGt4qikxBklM4YULr
         WkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=en+hJ5jX23VRrVFC0sbOQ7guhk0hsuKubPxlZIUxiEg=;
        b=crpP9/SMK8Y1KOfK+a5Z3MlSx2Vb10WE79KWfHtBD0rt5qdSW4W34eAfXB559PVbve
         iVVFYIP17GGJZO8z+epIUKjLrPzHyYo8rQ34+l+dPYS3ZcAhYGtN3KSsqVfMz4ygzm2L
         8oce0AFrVb3/JZ/FQ0kin1rlyULmg1nD7jq1JiTNmwfQuBjIxJ5lZdLStPcomykhrDZi
         YezOddIlEC1DIaO5UubDMMVjRym+TVPwbarjxBk7GtF0kXKTimhb77akb8pQ021XvLf9
         MGyfATNQxFg8cxz3KodSWnrDBYCUg2DMwjeIBRM3XnjooWs4GZN3eo9UWlFap6eCrA4w
         68Rg==
X-Gm-Message-State: AKaTC03HCAUXa3mgHvMOnjMM3ve/usvSpuvdORuObS7UJMHYdUHbna5yJexyiRu54EoJt0XP
X-Received: by 10.99.157.129 with SMTP id i123mr106143667pgd.148.1480976806217;
        Mon, 05 Dec 2016 14:26:46 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:20ca:c78:1a67:9579])
        by smtp.gmail.com with ESMTPSA id n25sm29736037pfi.33.2016.12.05.14.26.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Dec 2016 14:26:45 -0800 (PST)
Date:   Mon, 5 Dec 2016 14:26:44 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     David Turner <David.Turner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCHv2 17/17] checkout: add config option to recurse into
 submodules by default
Message-ID: <20161205222644.GG68588@google.com>
References: <20161203003022.29797-1-sbeller@google.com>
 <20161203003022.29797-18-sbeller@google.com>
 <20161205192918.GB68588@google.com>
 <CAGZ79kaMXmNUaUCZJaTrcodAoSBPSxXr5JPrZGQeg=m-HrN11w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaMXmNUaUCZJaTrcodAoSBPSxXr5JPrZGQeg=m-HrN11w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05, Stefan Beller wrote:
> On Mon, Dec 5, 2016 at 11:29 AM, Brandon Williams <bmwill@google.com> wrote:
> > On 12/02, Stefan Beller wrote:
> >> +test_expect_success 'option checkout.recurseSubmodules updates submodule' '
> >> +     test_config checkout.recurseSubmodules 1 &&
> >> +     git checkout base &&
> >> +     git checkout -b advanced-base &&
> >> +     git -C submodule commit --allow-empty -m "empty commit" &&
> >> +     git add submodule &&
> >> +     git commit -m "advance submodule" &&
> >> +     git checkout base &&
> >> +     git diff-files --quiet &&
> >> +     git diff-index --quiet --cached base &&
> >> +     git checkout advanced-base &&
> >> +     git diff-files --quiet &&
> >> +     git diff-index --quiet --cached advanced-base &&
> >> +     git checkout --recurse-submodules base
> >> +'
> >> +
> >
> > This test doesn't look like it looks into the submodule to see if the
> > submodule has indeed changed.  Unless diff-index and diff-files recurse
> > into the submodules?
> 
> I took the code from Jens once upon a time. Rereading the code, I agree it is
> not obvious how this checks the submodule state.
> 
> However `git diff-files --quiet` is perfectly fine, as
> we have submodule support by default via:
> 
>   Omitting the --submodule option or specifying --submodule=short,
>   uses the short format.  This format just shows the names of the commits
>   at the beginning and end of the range.
> 
> and then we turn it into an exit code via
> 
>        --quiet
>            Disable all output of the program. Implies --exit-code.
> 
>        --exit-code
>            Make the program exit with codes similar to diff(1).
>   That is, it exits with 1 if there were differences and 0 means no differences.
> 
> Same for diff-index.
> 
> The main purpose of this specific test is to have checkout.recurseSubmodules
> "to just make it work" without having to give --recurse-submodules manually.
> All the other tests with the manual --recurse-submodules should test for
> correctness of the behavior within the submodule.
> 
> So maybe I'll need to rewrite submodule_creation_must_succeed() in the previous
> patch to be more obvious. (Well that already has some tests for
> files/directories
> in there, so it is a little more.)
> 
> But to be sure we can also add tests here that look more into the submodule.
> I am thinking of "{new,old}_sub_sha1=$(git -C submodule rev-parse HEAD)" and
> comparing them?


Ah ok, that makes sense now.  Its kind of like if I run git status it
would show if a submodule is at a different sha1 than the superproject
has recorded.

-- 
Brandon Williams
