Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BBFC433EF
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 13:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346394AbiDKNSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 09:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiDKNSm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 09:18:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCB73AA48
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 06:16:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bv19so7783110ejb.6
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x/qs09DwUGgcUfu9/X1p1OGPU62cBATMoPuiVLxZ+AQ=;
        b=R8smVg8SWruSPkkM2mz7EjINC104FAOyJQXQCZtQUqqOX88rMfcNcmhRAGjzDFEkqL
         JWJ4uhrnlclrfrGOGwtHdrFMq7BI4UFb4T0zq58UAt4z8fgKh3NsNyhxsEL9RAgnSGpy
         sS7M7qL/vprVNZp0aaMhaIWrqeGCNJq3XOFyE/LhFWLw4+JX0Vuhcw6ye45Rdtf/zeAA
         GiUHjrynrZzy7vi2OhV/mCCLqiL3zUT4hpNZpPHURAeVUsdJO+sGZYCfYOKUG5i3kABP
         sM6aQTjN6VqnnAk70lCoe5msn0LvDZy6wdQzf6j58XnSH5NpXH1VrVmN+ul5M+F9raeQ
         zzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x/qs09DwUGgcUfu9/X1p1OGPU62cBATMoPuiVLxZ+AQ=;
        b=H6OP2vCc5UYveZs2JusJUh3OZTXD9E+vrqirLQ9K/VAE7gNFKBhazZ0RK/SvKefLeV
         WYy6Z9g8uYARDMqphxkDmIl1bJAdU2UHHm0F8dKOu+EDzYyIcWr0OTNa1wZF/+ib24a4
         tis7CWogwxyUWsjk00ETWwPbqfrZFtcAx+/F9tLeo6GnAWnrziJ97D+YnM4vSc4huNUn
         f+rJmE9cjTiplviAkcodrShzoXQBL0Fl6c/7yF1Rj1Yy3xA894HJ+sZOvWXN2M+E4cXF
         k7nOrevqs4soaZc63DIcmu7P7w/h5XEl9RUX5LAKs/Wo1J2jUUbqWZfi7kOjtx3jm41p
         x1fg==
X-Gm-Message-State: AOAM530wMC78I4fBsKoSI0F85blSyRiK4aI9M0cwqU1OA4B+Fj6UVrmh
        NIp4QR8QFWCHwsGFiJpa4gbPviLk/D4=
X-Google-Smtp-Source: ABdhPJw3Go8/66wX4m55S6gZ0WMPNaRQezzKHfO7oUQYy5/pMhsRHBZctGk6siQredUWZ/sWpTWauQ==
X-Received: by 2002:a17:907:7205:b0:6e7:ee50:ea94 with SMTP id dr5-20020a170907720500b006e7ee50ea94mr30161343ejc.351.1649682986269;
        Mon, 11 Apr 2022 06:16:26 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id q16-20020a056402519000b0041d77e14005sm2774210edd.82.2022.04.11.06.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 06:16:25 -0700 (PDT)
Message-ID: <ed6656e0-a865-319e-0f56-23ab1da3eef3@gmail.com>
Date:   Mon, 11 Apr 2022 14:16:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 1/6] t0066: improve readablity of dir-iterator tests
Content-Language: en-GB-large
To:     Plato Kiorpelidis <kioplato@gmail.com>, git@vger.kernel.org
Cc:     matheus.bernardino@usp.br, mhagger@alum.mit.edu
References: <20220410111852.2097418-1-kioplato@gmail.com>
 <20220410111852.2097418-2-kioplato@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220410111852.2097418-2-kioplato@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Plato

On 10/04/2022 12:18, Plato Kiorpelidis wrote:
> Be consistent throughout the dir-iterator tests regarding the order in
> which we:
>    * create test directories
>    * create expected outputs
>    * test if actual and expected outputs differ

When writing a commit message it is important to explain why you are 
making the changes in the patch, rather than just describe the changes 
themselves.

In general modernizing or standardizing existing tests before adding new 
ones is a good idea. However it is important to do it in a way that lets 
reviewers see there are no unintended changes. In this patch so much is 
changed it's really hard to tell if you have changed any of the tests or 
not. It would be much easier if you had not renamed all the directories 
and files that are created and renamed the tests as well.

I think that having separate setup tests makes sense as we're going to 
want to test different iteration schemes over the same hierarchy but it 
would be helpful to have the "expect" files written in the same test 
that calls test_cmp. That way it is much easier to debug test failures 
in the CI as it one can see the contents of "expect" as well as the diff 
from test_cmp in the CI output.

Best Wishes

Phillip

> Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
> ---
>   t/t0066-dir-iterator.sh | 227 +++++++++++++++++++++-------------------
>   1 file changed, 118 insertions(+), 109 deletions(-)
> 
> diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
> index 63a1a45cd3..fb20219487 100755
> --- a/t/t0066-dir-iterator.sh
> +++ b/t/t0066-dir-iterator.sh
> @@ -5,145 +5,154 @@ test_description='Test the dir-iterator functionality'
>   TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
> -test_expect_success 'setup' '
> -	mkdir -p dir &&
> -	mkdir -p dir/a/b/c/ &&
> -	>dir/b &&
> -	>dir/c &&
> -	mkdir -p dir/d/e/d/ &&
> -	>dir/a/b/c/d &&
> -	>dir/a/e &&
> -	>dir/d/e/d/a &&
> -
> -	mkdir -p dir2/a/b/c/ &&
> -	>dir2/a/b/c/d
> +test_expect_success 'setup -- dir w/ three nested dirs w/ file' '
> +	mkdir -p dir6/a/b/c &&
> +	>dir6/a/b/c/d &&
> +
> +
> +	cat >expected-out <<-EOF
> +	[d] (a) [a] ./dir6/a
> +	[d] (a/b) [b] ./dir6/a/b
> +	[d] (a/b/c) [c] ./dir6/a/b/c
> +	[f] (a/b/c/d) [d] ./dir6/a/b/c/d
> +	EOF
> +'
> +test_expect_success 'iteration of dir w/ three nested dirs w/ file' '
> +	test-tool dir-iterator ./dir6 >actual-out &&
> +	test_cmp expected-out actual-out
>   '
>   
> -test_expect_success 'dir-iterator should iterate through all files' '
> -	cat >expected-iteration-sorted-output <<-EOF &&
> -	[d] (a) [a] ./dir/a
> -	[d] (a/b) [b] ./dir/a/b
> -	[d] (a/b/c) [c] ./dir/a/b/c
> -	[d] (d) [d] ./dir/d
> -	[d] (d/e) [e] ./dir/d/e
> -	[d] (d/e/d) [d] ./dir/d/e/d
> -	[f] (a/b/c/d) [d] ./dir/a/b/c/d
> -	[f] (a/e) [e] ./dir/a/e
> -	[f] (b) [b] ./dir/b
> -	[f] (c) [c] ./dir/c
> -	[f] (d/e/d/a) [a] ./dir/d/e/d/a
> +test_expect_success 'setup -- dir w/ complex structure w/o symlinks' '
> +	mkdir -p dir11/a/b/c/ &&
> +	>dir11/b &&
> +	>dir11/c &&
> +	>dir11/a/e &&
> +	>dir11/a/b/c/d &&
> +	mkdir -p dir11/d/e/d/ &&
> +	>dir11/d/e/d/a &&
> +
> +
> +	cat >expected-sorted-out <<-EOF
> +	[d] (a) [a] ./dir11/a
> +	[d] (a/b) [b] ./dir11/a/b
> +	[d] (a/b/c) [c] ./dir11/a/b/c
> +	[d] (d) [d] ./dir11/d
> +	[d] (d/e) [e] ./dir11/d/e
> +	[d] (d/e/d) [d] ./dir11/d/e/d
> +	[f] (a/b/c/d) [d] ./dir11/a/b/c/d
> +	[f] (a/e) [e] ./dir11/a/e
> +	[f] (b) [b] ./dir11/b
> +	[f] (c) [c] ./dir11/c
> +	[f] (d/e/d/a) [a] ./dir11/d/e/d/a
>   	EOF
> +'
> +test_expect_success 'iteration of dir w/ complex structure w/o symlinks' '
> +	test-tool dir-iterator ./dir11 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
>   
> -	test-tool dir-iterator ./dir >out &&
> -	sort out >./actual-iteration-sorted-output &&
> +	test_cmp expected-sorted-out actual-sorted-out
> +'
>   
> -	test_cmp expected-iteration-sorted-output actual-iteration-sorted-output
> +test_expect_success 'dir_iterator_begin() should fail upon inexistent paths' '
> +	echo "dir_iterator_begin failure: ENOENT" >expected-inexistent-path-out &&
> +
> +	test_must_fail test-tool dir-iterator ./inexistent-path >actual-out &&
> +	test_cmp expected-inexistent-path-out actual-out
>   '
>   
> -test_expect_success 'dir-iterator should list files in the correct order' '
> -	cat >expected-pre-order-output <<-EOF &&
> -	[d] (a) [a] ./dir2/a
> -	[d] (a/b) [b] ./dir2/a/b
> -	[d] (a/b/c) [c] ./dir2/a/b/c
> -	[f] (a/b/c/d) [d] ./dir2/a/b/c/d
> -	EOF
> +test_expect_success 'dir_iterator_begin() should fail upon non directory paths' '
> +	>some-file &&
>   
> -	test-tool dir-iterator ./dir2 >actual-pre-order-output &&
>   
> -	test_cmp expected-pre-order-output actual-pre-order-output
> -'
> +	echo "dir_iterator_begin failure: ENOTDIR" >expected-non-dir-out &&
>   
> -test_expect_success 'begin should fail upon inexistent paths' '
> -	test_must_fail test-tool dir-iterator ./inexistent-path \
> -		>actual-inexistent-path-output &&
> -	echo "dir_iterator_begin failure: ENOENT" >expected-inexistent-path-output &&
> -	test_cmp expected-inexistent-path-output actual-inexistent-path-output
> -'
> +	test_must_fail test-tool dir-iterator ./some-file >actual-out &&
> +	test_cmp expected-non-dir-out actual-out &&
>   
> -test_expect_success 'begin should fail upon non directory paths' '
> -	test_must_fail test-tool dir-iterator ./dir/b >actual-non-dir-output &&
> -	echo "dir_iterator_begin failure: ENOTDIR" >expected-non-dir-output &&
> -	test_cmp expected-non-dir-output actual-non-dir-output
> +	test_must_fail test-tool dir-iterator --pedantic ./some-file >actual-out &&
> +	test_cmp expected-non-dir-out actual-out
>   '
>   
> -test_expect_success POSIXPERM,SANITY 'advance should not fail on errors by default' '
> -	cat >expected-no-permissions-output <<-EOF &&
> -	[d] (a) [a] ./dir3/a
> -	EOF
> +test_expect_success POSIXPERM,SANITY \
> +'dir_iterator_advance() should not fail on errors by default' '
>   
> -	mkdir -p dir3/a &&
> -	>dir3/a/b &&
> -	chmod 0 dir3/a &&
> +	mkdir -p dir13/a &&
> +	>dir13/a/b &&
> +	chmod 0 dir13/a &&
>   
> -	test-tool dir-iterator ./dir3 >actual-no-permissions-output &&
> -	test_cmp expected-no-permissions-output actual-no-permissions-output &&
> -	chmod 755 dir3/a &&
> -	rm -rf dir3
> -'
>   
> -test_expect_success POSIXPERM,SANITY 'advance should fail on errors, w/ pedantic flag' '
> -	cat >expected-no-permissions-pedantic-output <<-EOF &&
> -	[d] (a) [a] ./dir3/a
> -	dir_iterator_advance failure
> +	cat >expected-no-permissions-out <<-EOF &&
> +	[d] (a) [a] ./dir13/a
>   	EOF
>   
> -	mkdir -p dir3/a &&
> -	>dir3/a/b &&
> -	chmod 0 dir3/a &&
> +	test-tool dir-iterator ./dir13 >actual-out &&
> +	test_cmp expected-no-permissions-out actual-out &&
>   
> -	test_must_fail test-tool dir-iterator --pedantic ./dir3 \
> -		>actual-no-permissions-pedantic-output &&
> -	test_cmp expected-no-permissions-pedantic-output \
> -		actual-no-permissions-pedantic-output &&
> -	chmod 755 dir3/a &&
> -	rm -rf dir3
> +	chmod 755 dir13/a &&
> +	rm -rf dir13
>   '
>   
> -test_expect_success SYMLINKS 'setup dirs with symlinks' '
> -	mkdir -p dir4/a &&
> -	mkdir -p dir4/b/c &&
> -	>dir4/a/d &&
> -	ln -s d dir4/a/e &&
> -	ln -s ../b dir4/a/f &&
> -
> -	mkdir -p dir5/a/b &&
> -	mkdir -p dir5/a/c &&
> -	ln -s ../c dir5/a/b/d &&
> -	ln -s ../ dir5/a/b/e &&
> -	ln -s ../../ dir5/a/b/f
> -'
> +test_expect_success POSIXPERM,SANITY \
> +'dir_iterator_advance() should fail on errors, w/ pedantic flag' '
>   
> -test_expect_success SYMLINKS 'dir-iterator should not follow symlinks by default' '
> -	cat >expected-no-follow-sorted-output <<-EOF &&
> -	[d] (a) [a] ./dir4/a
> -	[d] (b) [b] ./dir4/b
> -	[d] (b/c) [c] ./dir4/b/c
> -	[f] (a/d) [d] ./dir4/a/d
> -	[s] (a/e) [e] ./dir4/a/e
> -	[s] (a/f) [f] ./dir4/a/f
> +	mkdir -p dir13/a &&
> +	>dir13/a/b &&
> +	chmod 0 dir13/a &&
> +
> +
> +	cat >expected-no-permissions-pedantic-out <<-EOF &&
> +	[d] (a) [a] ./dir13/a
> +	dir_iterator_advance failure
>   	EOF
>   
> -	test-tool dir-iterator ./dir4 >out &&
> -	sort out >actual-no-follow-sorted-output &&
> +	test_must_fail test-tool dir-iterator --pedantic ./dir13 >actual-out &&
> +	test_cmp expected-no-permissions-pedantic-out actual-out &&
>   
> -	test_cmp expected-no-follow-sorted-output actual-no-follow-sorted-output
> +	chmod 755 dir13/a &&
> +	rm -rf dir13
>   '
>   
> -test_expect_success SYMLINKS 'dir-iterator should follow symlinks w/ follow flag' '
> -	cat >expected-follow-sorted-output <<-EOF &&
> -	[d] (a) [a] ./dir4/a
> -	[d] (a/f) [f] ./dir4/a/f
> -	[d] (a/f/c) [c] ./dir4/a/f/c
> -	[d] (b) [b] ./dir4/b
> -	[d] (b/c) [c] ./dir4/b/c
> -	[f] (a/d) [d] ./dir4/a/d
> -	[f] (a/e) [e] ./dir4/a/e
> +test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/o cycle' '
> +	mkdir -p dir14/a &&
> +	mkdir -p dir14/b/c &&
> +	>dir14/a/d &&
> +	ln -s d dir14/a/e &&
> +	ln -s ../b dir14/a/f &&
> +
> +
> +	cat >expected-dont-follow-sorted-out <<-EOF &&
> +	[d] (a) [a] ./dir14/a
> +	[d] (b) [b] ./dir14/b
> +	[d] (b/c) [c] ./dir14/b/c
> +	[f] (a/d) [d] ./dir14/a/d
> +	[s] (a/e) [e] ./dir14/a/e
> +	[s] (a/f) [f] ./dir14/a/f
>   	EOF
> +	cat >expected-follow-sorted-out <<-EOF
> +	[d] (a) [a] ./dir14/a
> +	[d] (a/f) [f] ./dir14/a/f
> +	[d] (a/f/c) [c] ./dir14/a/f/c
> +	[d] (b) [b] ./dir14/b
> +	[d] (b/c) [c] ./dir14/b/c
> +	[f] (a/d) [d] ./dir14/a/d
> +	[f] (a/e) [e] ./dir14/a/e
> +	EOF
> +'
> +test_expect_success SYMLINKS \
> +'dont-follow-symlinks of dir w/ symlinks w/o cycle' '
> +
> +	test-tool dir-iterator ./dir14 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
> +
> +	test_cmp expected-dont-follow-sorted-out actual-sorted-out
> +'
> +test_expect_success SYMLINKS \
> +'follow-symlinks of dir w/ symlinks w/o cycle' '
>   
> -	test-tool dir-iterator --follow-symlinks ./dir4 >out &&
> -	sort out >actual-follow-sorted-output &&
> +	test-tool dir-iterator --follow-symlinks ./dir14 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
>   
> -	test_cmp expected-follow-sorted-output actual-follow-sorted-output
> +	test_cmp expected-follow-sorted-out actual-sorted-out
>   '
>   
>   test_done

