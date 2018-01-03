Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADECE1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 13:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbeACNCi (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 08:02:38 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:38527 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752388AbeACNCh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 08:02:37 -0500
Received: by mail-wr0-f181.google.com with SMTP id y9so1498767wrb.5
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 05:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Gsq/224Q1FBw07j8oa5CWmPHNcVOyBIh+OhhuqxC214=;
        b=kA8n3xpWgGEPgZPD8qAHGBvuOyMw/jsk8tF0/Nu5ZMMv8p4mkVlmzo3VgtRuIAG8H2
         /5nYk+vjV58eL4G4zwcE/+7bmIvGbWGxZgNQzk8woJzWtnx/SOiTgsBvYdOOmIUQR8ei
         AIlatBOhldl0moTvshszrkHoepuRTYYJayIto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Gsq/224Q1FBw07j8oa5CWmPHNcVOyBIh+OhhuqxC214=;
        b=IZFgKOxtEuUE60qLgyL8qI6NK6DiJHfCQcRW8sPHTOCIG57OMu4sT1uJdNM2qqXqlz
         JYfvgWCfPnOmZs0YSHctvH6Tp3rkkl2gL6pb41cF9/Mk/P/fGLhAqFu4IXCuVtC6ZiDO
         +DEhajG53oZkkAxq6tjI7F2+OECc+zooRkbVqRJREogU5CK/5zn/zdAku1wvyIQjKXQc
         94PUtIxQbrPoG/bN6jPDx5j12KrghybNA/rIkHRQhrIbnoO5ekYBNHBXFOxfoeZFsTig
         smWU6GgYMFZYus/rvPFgUV1009WfWKJDMmGRrfZ2NTXUXYVd71lepsFeV9a9+bJG7C0S
         7FBg==
X-Gm-Message-State: AKGB3mJP7T+pxyXTUnNWJ8mQGXowYpqiU/ZtfffT44ajDLdUyNBqC2MA
        rMhb/9Vu9mFrLOWhAcTjtLR/Tw==
X-Google-Smtp-Source: ACJfBosYVG7402qRLffZ4gXUFnmwR/QsZ+4rqve09jyJvXtSxPYr1SXk6rwjiYNmpQ9EK3hU70wMkg==
X-Received: by 10.223.161.208 with SMTP id v16mr1439825wrv.103.1514984556141;
        Wed, 03 Jan 2018 05:02:36 -0800 (PST)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id o18sm691429wrg.59.2018.01.03.05.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 05:02:34 -0800 (PST)
Date:   Wed, 3 Jan 2018 13:02:32 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 7/7] wildmatch test: create & test files on disk in
 addition to in-memory
Message-ID: <20180103130232.GD29210@dinwoodie.org>
References: <20171223213012.1962-1-avarab@gmail.com>
 <20171225002835.29005-8-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171225002835.29005-8-avarab@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday 25 December 2017 at 12:28 am +0000, Ævar Arnfjörð Bjarmason wrote:
> There has never been any full roundtrip testing of what git-ls-files
> and other functions that use wildmatch() actually do, rather we've
> been satisfied with just testing the underlying C function.
> 
> Due to git-ls-files and friends having their own codepaths before they
> call wildmatch() there's sometimes differences in the behavior between
> the two, and even when we test for those (as with
> 9e4e8a64c2 ("pathspec: die on empty strings as pathspec", 2017-06-06))
> there was no one place where you can review how these two modes
> differ.
> 
> Now there is. We now attempt to create a file called $haystack and
> match $needle against it for each pair of $needle and $haystack that
> we were passing to test-wildmatch.
> 
> If we can't create the file we skip the test. This ensures that we can
> run this on all platforms and not maintain some infinitely growing
> whitelist of e.g. platforms that don't support certain characters in
> filenames.
> 
> As a result of doing this we can now see the cases where these two
> ways of testing wildmatch differ:
> 
>  * Creating a file called 'a[]b' and running ls-files 'a[]b' will show
>    that file, but wildmatch("a[]b", "a[]b") will not match
> 
>  * wildmatch() won't match a file called \ against \, but ls-files
>    will.
> 
>  * `git --glob-pathspecs ls-files 'foo**'` will match a file
>    'foo/bba/arr', but wildmatch won't, however pathmatch will.
> 
>    This seems like a bug to me, the two are otherwise equivalent as
>    these tests show.
> 
> This also reveals the case discussed in 9e4e8a64c2 above, where '' is
> now an error as far as ls-files is concerned, but wildmatch() itself
> happily accepts it.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

I'm seeing this test script failing on the pu branch as a result of this
commit when building on Cygwin.  Specifically, the test fails at
9d45e1ca4 ("Merge branch 'bw/oidmap-autoinit' into pu", 2017-12-28), and
bisecting points the blame at 2ee0c785a ("wildmatch test: create & test
files on disk in addition to in-memory", 2017-12-25).

I've copied the verbose error output for the first error below, and
uploaded the full output, including verbose and trace output for the
unexpectedly failing tests, at [0].  (With 42 failures among 1512 tests,
there's a lot of it, so I didn't want to include it in an email.)

    expecting success:
                                    wildtest_file_setup &&
                                    printf '%s' '\' >expect &&
                                    git --glob-pathspecs ls-files -z -- '00' >actual.raw 2>actual.err &&
                                    wildtest_stdout_stderr_cmp
    
    ++ wildtest_file_setup
    ++ test_when_finished '
                    rm -rf -- * &&
                    git reset
            '
    ++ test 0 = 0
    ++ test_cleanup='{
                    rm -rf -- * &&
                    git reset
    
                    } && (exit "$eval_ret"); eval_ret=$?; :'
    ++ git add -A
    ++ printf %s '\'
    ++ git --glob-pathspecs ls-files -z -- 00
    ++ wildtest_stdout_stderr_cmp
    ++ tr -d '\0'
    ++ test_cmp expect.err actual.err
    ++ diff -u expect.err actual.err
    ++ test_cmp expect actual
    ++ diff -u expect actual
    --- expect      2018-01-03 12:43:11.116611200 +0000
    +++ actual      2018-01-03 12:43:11.216180400 +0000
    @@ -1 +0,0 @@
    -\
    \ No newline at end of file
    + test_eval_ret_=1
    + want_trace
    + test t = t
    + test t = t
    + set +x
    error: last command exited with $?=1
    ++ rm -rf -- actual actual.err actual.raw expect expect.err
    ++ git reset
    ++ exit 1
    ++ eval_ret=1
    ++ :
    + test_eval_ret_=0
    + want_trace
    + test t = t
    + test t = t
    + set +x
    not ok 490 - wildmatch(ls): match '00' '\'
    #
    #                                       wildtest_file_setup &&
    #                                       printf '%s' '\' >expect &&
    #                                       git --glob-pathspecs ls-files -z -- '00' >actual.raw 2>actual.err &&
    #                                       wildtest_stdout_stderr_cmp
    #

I'm digging into the failures myself now, but wanted to report the
problem in the name of getting more eyes on it.

Adam

[0]: https://gist.github.com/me-and/04443bcb00e12436f0eacce079b56d02
