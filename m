Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A77511F45F
	for <e@80x24.org>; Tue,  7 May 2019 08:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfEGIb2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 04:31:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46407 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEGIb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 04:31:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id f37so17852135edb.13
        for <git@vger.kernel.org>; Tue, 07 May 2019 01:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=YWGpH+7aiuPhxlKtMj/Z2VxprTqVyAQiJzftZymnCFU=;
        b=i0pULT4aaNB2rfQD8LI9dYuo1rPyvU98CjGyCYEAg3/iMtAsWHpRx/mrzdQeg49Ncu
         Vm3UTNw2c7paeNR8czG9EYWwnTc33d8HpFNiHdOvUEa+M+1QKDwrmgyKyGlvUEQGiwns
         w0W8hDeM2XN1JpcTMV4V25kHVVtflURFCpoFGnOmnf7Plushtrfg9pV+tsygKrIsc9/R
         bzkRC5zY7V3B9oUycI3DcE45/07z6hc2CUisBD1vtcaSOb88CGBNyFYtj3RdcYJuI7dS
         flX9EFajgMEMGmWuwAkz87e/yqlvhUzcfdGptKYsGlbp5djIbUv3OH5/9RvWU6KAlrU6
         Wp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=YWGpH+7aiuPhxlKtMj/Z2VxprTqVyAQiJzftZymnCFU=;
        b=Y4bSgSfq7OAfLXDQmWUe423m6xYsYCZMRkiaSfpJjM3O3+aqSwfaKMH3wIG9lFSIik
         5AIh9iGdA5NaaaLLtYlr0ZbPa4283woPriBtB2gNf0zgOAiU4YBFzg1YTyEyHGOmMMGW
         gYBAtq8Mt+hAHeAnmKvmUIWzLLCd6kpoeMiC42ZeN0TnQztC6a9+ORiep73l20yCUBRD
         DeGIIUuhHA097RTqHQRNAt1lNiDJISYXnT1N11S22XxbqZ4eAV9voqRZ+M/Lj+GO6Uv1
         sO07KgWuVmJTl78aVlw9tXZJeFQNQljxJv0+orXiYVssaR64AQZlMouw9Zm510Ladb5u
         lLsQ==
X-Gm-Message-State: APjAAAVipfkvvEeCv2u3Os5V8dTsCnzsAk6IijZpxiFzDEJ6K8c2mSOZ
        VrkJZyA/4qYO33TAlct4N8c=
X-Google-Smtp-Source: APXvYqyykWzD4f6eNZ9fWyT5rx8hBoi6S3FnRdxsGWWo4+CgTxVuRDbGY7RPadA1UWt1txR1cjDJbg==
X-Received: by 2002:a17:906:b345:: with SMTP id cd5mr12043801ejb.191.1557217885221;
        Tue, 07 May 2019 01:31:25 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id g11sm1164222eda.42.2019.05.07.01.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 01:31:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 2/2] perf-lib.sh: remove GIT_TEST_INSTALLED from perf-lib.sh
References: <20190506202451.GA19850@sigill.intra.peff.net> <20190506232309.28538-3-avarab@gmail.com> <20190507071630.GB28060@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190507071630.GB28060@sigill.intra.peff.net>
Date:   Tue, 07 May 2019 10:31:23 +0200
Message-ID: <871s1ais2s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 07 2019, Jeff King wrote:

> On Tue, May 07, 2019 at 01:23:09AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> @@ -79,7 +95,16 @@ run_dirs_helper () {
>>  	if test $# -gt 0 -a "$1" =3D --; then
>>  		shift
>>  	fi
>> -	if [ ! -d "$mydir" ]; then
>> +
>> +	PERF_RESULTS_PREFIX=3D
>> +	if test "$mydir" =3D "."
>> +	then
>> +		unset GIT_TEST_INSTALLED
>> +	elif test -d "$mydir"
>> +	then
>> +		PERF_RESULTS_PREFIX=3D$(cd $mydir && printf "%s" "$(pwd)" | tr -c "[a=
-zA-Z0-9]" "_").
>> +		set_git_test_installed "$mydir"
>> +	else
>>  		rev=3D$(git rev-parse --verify "$mydir" 2>/dev/null) ||
>>  		die "'$mydir' is neither a directory nor a valid revision"
>>  		if [ ! -d build/$rev ]; then
>
> OK, so this is basically the same cleanup I came up with. The big
> difference is that you pushed the shared code into a function, rather
> than the funky double-conditional in the original. I'm OK with that.

Yup. It can be done either way, but this way allows for a many/many
mapping where we set the GIT_TEST_INSTALLED & PERF_RESULTS_PREFIX
depending on the different cases, as opposed to in perf-lib.sh where
we'd need to set GIT_TEST_INSTALLED and then infer a PERF_RESULTS_PREFIX
(or pass flags marking each case, which would amount to the same
thing...).

>> diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
>> index 494907a892..c8f4a78903 100755
>> --- a/t/perf/aggregate.perl
>> +++ b/t/perf/aggregate.perl
>> @@ -6,6 +6,7 @@
>>  use JSON;
>>  use Getopt::Long;
>>  use Git;
>> +use Cwd qw(realpath);
>>
>>  sub get_times {
>>  	my $name =3D shift;
>> @@ -103,13 +104,14 @@ sub format_size {
>>  	if (! -d $arg) {
>>  		my $rev =3D Git::command_oneline(qw(rev-parse --verify), $arg);
>>  		$dir =3D "build/".$rev;
>> +	} elsif ($arg eq '.') {
>> +		$dir =3D '.';
>>  	} else {
>> -		$arg =3D~ s{/*$}{};
>> -		$dir =3D $arg;
>> -		$dirabbrevs{$dir} =3D $dir;
>> +		$dir =3D realpath($arg);
>> +		$dirnames{$dir} =3D $dir;
>>  	}
>>  	push @dirs, $dir;
>> -	$dirnames{$dir} =3D $arg;
>> +	$dirnames{$dir} ||=3D $arg;
>
> I'm not sure I get what's going on here. Why do we need the realpath in
> aggregate.perl? We'd want to generate the same filename that "run"
> decided to store things in, which we'd generate from the command-line
> arguments (either passed on to us by "run", or direct from the user if
> they're printing a previous run).

So this is part of the "has sucked since forever, future TODO" mentioned
in 0/2.

I.e. if you pass "../.." as a path to "run" we'll try to discover a
built/installed "git" in a "bindir" there, and then we need to do two
things:

 1. Figure out a way to turn that into a filename sensible for the
    *.times files.
 2. Print some header showing that path in the aggregate output.

The "run" script will discover #1 for itself, that's what that "pwd &&
tr -c ..." command is doing, but then we just pass "../.." again to
aggregate.perl and have it figure it out again on its own, so it needs
to duplicate the logic.

Just having both discover the absolute path all the time for #1 made
things a lot simpler, e.g. if you do ../.. on v2.21.0 you'll get things
like:

    _____.p0000-perf-lib-sanity.1.times

And with $PWD/../../ you'd get:

    _home_avar_g_git_t_perf______.p0000-perf-lib-sanity.1.times

Now this is all pretty & consistent. Any path to a "git" will always be
turned into the absolute path, e.g.:

    _home_avar_g_git.p0000-perf-lib-sanity.1.times

And instead of "git" or ".." being printed in the aggregate header we
print the path, e.g. "/home/avar/g/git".

>> @@ -312,9 +314,6 @@ sub print_codespeed_results {
>>  		$environment =3D $reponame;
>>  	} elsif (exists $ENV{GIT_PERF_REPO_NAME} and $ENV{GIT_PERF_REPO_NAME} =
ne "") {
>>  		$environment =3D $ENV{GIT_PERF_REPO_NAME};
>> -	} elsif (exists $ENV{GIT_TEST_INSTALLED} and $ENV{GIT_TEST_INSTALLED} =
ne "") {
>> -		$environment =3D $ENV{GIT_TEST_INSTALLED};
>> -		$environment =3D~ s|/bin-wrappers$||;
>>  	} else {
>>  		$environment =3D `uname -r`;
>>  		chomp $environment;
>
> Is this codespeed thing a totally separate bug? Should it go into its
> own patch?

I could split it up, but figured any change like this would have had to
deal with and refactor with any existing uses of GIT_TEST_INSTALLED,
that there was a bug in some of that code and it could be removed was
just luck...
