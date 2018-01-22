Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A6C11F404
	for <e@80x24.org>; Mon, 22 Jan 2018 23:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbeAVXEe (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 18:04:34 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:41086 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbeAVXEd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 18:04:33 -0500
Received: by mail-wm0-f44.google.com with SMTP id f71so19317539wmf.0
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 15:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=HTAWN5gHTQ7mXGEi+G1iwyN5U8ScK1H6UsT0cX98H0A=;
        b=Bxbonyet4ERLBYgkBWRZvMjVEHqNolHx0MmmQTy+fdeIfFYKunmqaLDeBlr8xZwypr
         Rt4Bwh4ieRVzDQKIbBtP9wBzE74Cce+pX4eg5Hy7RPXK+yKDEENsb2Mo4Aj3WF+hADo+
         G39/Dj0o0B3wz+LDfzh5YixR/k4I8jGqHhC4cWo8YnHymHTEV3fDBHHDNP8hIMq27HXh
         65366q4Ofim8++H4dV/sq/PIS/zIDa85IVYD+3w00TSYxBQIHjYWqDTJMuPvVEUI5xdl
         mN5f7DXAYe8XC6fsc6rowyPCSGV/e4PNNuKHngzD1pkbUGa8hF1L3h+mak9+UUYaimoX
         j8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=HTAWN5gHTQ7mXGEi+G1iwyN5U8ScK1H6UsT0cX98H0A=;
        b=KemMk/YyY+74y9/S4qwlNZ2Jrq1njY0Q59+nG4zvG/zzvoMoqPQdtD/RAMmmEGK45w
         U3eM6hVD+kZCjP71mZPWIfwXGfuYFmqPCFZ5u1McLRUqkJVPkYLCNP/HnhtZUy5Ja8ki
         NdxYd1HD/CA24fvGLbxpSR4cuGr3Gm+hDBxNfP+qeYwDUBnNvV+peALIbMZTFG3jf887
         5B0Y/gt1gNFiFshkkD19kGMYXdleP1vtFcP29E2PsdLeG3VakX2SO2vPTT/j+UPIKEPW
         NHA7rvxuuvWVPnY88UKI48TceO3J2FgutXYmqD5Qj61ascz6EytORA9MJiJilZ7UX6uS
         X1Tg==
X-Gm-Message-State: AKwxytfkY344gotcsLW3Zh2SfJRQcks9Ft6HzkI/rRisHigYNEZm0nuN
        zakvXxIAUVQZVcnAkHjRk1M=
X-Google-Smtp-Source: AH8x226hTcj6yq1eTaGga1/JMcmL80qA6tbcQiDmra2Hh/w1XPtZ25mhKAZS6GTDpfKHKoahm4ohDw==
X-Received: by 10.80.240.86 with SMTP id u22mr15976211edl.276.1516662271912;
        Mon, 22 Jan 2018 15:04:31 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id p6sm10270308edh.68.2018.01.22.15.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jan 2018 15:04:30 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 04/12] fetch tests: double quote a variable for interpolation
References: <20180121000304.32323-1-avarab@gmail.com> <20180119000027.28898-1-avarab@gmail.com> <20180121000304.32323-5-avarab@gmail.com> <xmqqbmhln01n.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <xmqqbmhln01n.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 23 Jan 2018 00:04:28 +0100
Message-ID: <87wp09h4w3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 22 2018, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> If the $cmdline variable contains multiple arguments they won't be
>> interpolated correctly since the body of the test is single quoted. I
>> don't know what part of test-lib.sh is expanding variables within
>> single-quoted strings,...
>
>     dothis='echo whatever $IFS separated strings'
>     test_expect_success label '
>             $dothis
>     '
>
> works because test_expect_success ends up beint a glorified 'eval'
> and it sees the value of $dothis.
>
>> but interpolating this inline is the desired
>> behavior here.
>
> I am not sure what you meant by this, though.

Looking into this again:

    myvar="a b 'c' \"d\" \"\\\"e\\\"\""
    test_expect_success 'blah' '
    	/usr/bin/perl -MData::Dumper -wE say\ Dumper\ \\@ARGV -- $myvar &&
    	/usr/bin/perl -MData::Dumper -wE say\ Dumper\ \\@ARGV -- '"$myvar"' &&
    	echo $myvar &&
    	false
    '

Produces:

    Initialized empty Git repository in /home/avar/g/git/t/trash directory.t5510-fetch/.git/
    expecting success:
    	/usr/bin/perl -MData::Dumper -wE say\ Dumper\ \\@ARGV -- $myvar &&
    	/usr/bin/perl -MData::Dumper -wE say\ Dumper\ \\@ARGV -- a b 'c' "d" "\"e\"" &&
    	echo $myvar &&
    	false

    + /usr/bin/perl -MData::Dumper -wE say Dumper \@ARGV -- a b 'c' "d" "\"e\""
    $VAR1 = [
              'a',
              'b',
              '\'c\'',
              '"d"',
              '"\\"e\\""'
            ];

    + /usr/bin/perl -MData::Dumper -wE say Dumper \@ARGV -- a b c d "e"
    $VAR1 = [
              'a',
              'b',
              'c',
              'd',
              '"e"'
            ];

    + echo a b 'c' "d" "\"e\""
    a b 'c' "d" "\"e\""
    + false
    error: last command exited with $?=1
    not ok 1 - blah
    #
    #		/usr/bin/perl -MData::Dumper -wE say\ Dumper\ \\@ARGV -- $myvar &&
    #		/usr/bin/perl -MData::Dumper -wE say\ Dumper\ \\@ARGV -- a b 'c' "d" "\"e\"" &&
    #		echo $myvar &&
    #		false
    #

I.e. the desired effect is to get variables like the refspec like/this
not 'like/this'. I could also just apply this on top, which gives the
same end result, but now I wonder if starting some args with
e.g. unescaped + and with : and * in the string is portable:

    diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
    index 48f49b613a..2d311059e9 100755
    --- a/t/t5510-fetch.sh
    +++ b/t/t5510-fetch.sh
    @@ -587 +587 @@ test_configured_prune () {
    -			git fetch '"$cmdline"' &&
    +			git fetch $cmdline &&
    @@ -621 +621 @@ test_configured_prune unset unset unset unset kept   pruned \
    -	"--prune origin 'refs/tags/*:refs/tags/*'"
    +	"--prune origin refs/tags/*:refs/tags/*"
    @@ -623 +623 @@ test_configured_prune unset unset unset unset pruned pruned \
    -	"--prune origin 'refs/tags/*:refs/tags/*' '+refs/heads/*:refs/remotes/origin/*'"
    +	"--prune origin refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
    @@ -641 +641 @@ test_configured_prune false false unset unset kept   pruned \
    -	"--prune origin 'refs/tags/*:refs/tags/*'"
    +	"--prune origin refs/tags/*:refs/tags/*"
    @@ -643 +643 @@ test_configured_prune false false unset unset pruned pruned \
    -	"--prune origin 'refs/tags/*:refs/tags/*' '+refs/heads/*:refs/remotes/origin/*'"
    +	"--prune origin refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
    @@ -661 +661 @@ test_configured_prune true  true  unset unset kept   pruned \
    -	"--prune origin 'refs/tags/*:refs/tags/*'"
    +	"--prune origin refs/tags/*:refs/tags/*"
    @@ -663 +663 @@ test_configured_prune true  true  unset unset pruned pruned \
    -	"--prune origin 'refs/tags/*:refs/tags/*' '+refs/heads/*:refs/remotes/origin/*'"
    +	"--prune origin refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
    @@ -684 +684 @@ test_configured_prune true  false true  false kept   kept   ""
    -# When --prune-tags is supplied it's ignored if an explict refspec is
    +# When --prune-tags is supplied its ignored if an explict refspec is
    @@ -687 +687 @@ test_configured_prune unset unset unset unset pruned kept \
    -	"--prune --prune-tags origin '+refs/heads/*:refs/remotes/origin/*'"
    +	"--prune --prune-tags origin +refs/heads/*:refs/remotes/origin/*"
    @@ -689 +689 @@ test_configured_prune unset unset true  unset pruned kept \
    -	"--prune --prune-tags origin '+refs/heads/*:refs/remotes/origin/*'"
    +	"--prune --prune-tags origin +refs/heads/*:refs/remotes/origin/*"
    @@ -691 +691 @@ test_configured_prune unset unset unset true pruned  kept \
    -	"--prune --prune-tags origin '+refs/heads/*:refs/remotes/origin/*'"
    +	"--prune --prune-tags origin +refs/heads/*:refs/remotes/origin/*"


>> -			git fetch $cmdline &&
>> +			git fetch '"$cmdline"' &&
>
> Would this work with cmdline that needs to be quoted for the
> resulting shell script to be syntactically correct (e.g. cmdline
> with a single dq in it)?  By stepping out of sq pair, you are
> allowing/asking the shell that forms test_expect_success command
> line arguments to interpolate cmdline, instead of asking the shell
> that evals test_expect_success with its command line argument
> strings.
>
> In other words, I suspect that the caller of test_configured_prune
> now must sq_quote the cmdline arguments it passes to this helper,
> i.e.
>
> 	cmdline="$(git rev-parse --sq-quote arg1 'arg"2' arg3)"
> 	test_configured_prune ... "$cmdline" ...
>
> for this patch to be correct.

Sorry at this point I'm confused about this whole thing. This doesn't
work and overquotes:

    @@ -559,2 +569,3 @@ test_configured_prune () {

    +	cmdline_q="$(git rev-parse --sq-quote $cmdline)"
     	test_expect_success "prune fetch.prune=$1 remote.origin.prune=$2 fetch.pruneTags=$3 remote.origin.pruneTags=$4${7:+ $7}; branch:$5 tag:$6" '
    @@ -586,3 +597,4 @@ test_configured_prune () {

    -			git fetch '"$cmdline"' &&
    +			/usr/bin/perl -MData::Dumper -wE say\ Dumper\ \\@ARGV -- '"$cmdline_q"' &&
    +			git fetch '"$cmdline_q"' &&
     			case "$expected_branch" in

So does just using $cmdline_q without making the calling shell
interpolate it. Is there an idiom I should be following that I'm missing
here?
