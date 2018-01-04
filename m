Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 478F81F404
	for <e@80x24.org>; Thu,  4 Jan 2018 22:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753336AbeADWLk (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 17:11:40 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:41401 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753119AbeADWLj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 17:11:39 -0500
Received: by mail-wm0-f67.google.com with SMTP id g75so6109022wme.0
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 14:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=mU+zx2+fyJ5ZaaAUpuNfAsWkTwJz5mcmhxJ2m1YZvok=;
        b=fQYYFiGdNNW8SBzcgnruzY3mkKGz0hbPYUckhK2SedFowU55ETASYd3y+6JVUlasJm
         apKyVaTiD4CLBO6Dh9OfdFQkfuURkbq2S+U7TzjdQmGbWxrsLdvIrnaaVdG5jcHInFZe
         CY0Gi9fT/EAw/CGrh20oDyRD3ea9dDpa61BIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=mU+zx2+fyJ5ZaaAUpuNfAsWkTwJz5mcmhxJ2m1YZvok=;
        b=C0dca7x5HePemQs4QMQ+CcrxWseU995jZbWSCn7WVEUmKJUTlPtipGuXEuDeT5Yum0
         rZAkbB8d2/gfNuPchRWP4hIG5W6xfI0inojp8MH6wq/7TO+fazu2ba6Eg7gYe/K6sFNN
         iwZKx1e50uhJqnDBMkELagWWcLECVmfPSC5mpCkXOy7rUeJ1C9dCS/Tq8xz0w0GN+iVS
         BNh1H9U1E3iQ90iQvyNv6VRYrfyqVynacQM76ZDD9DYQ4uR8biesc8s1AfNIeIetoGis
         OB3ULhjRGwxPsAIqhs2k0DU9Pfp3DZWLYTRnWJrRWK/qs3IXLcfqYlgQOTvWl1iyntN9
         wX/Q==
X-Gm-Message-State: AKGB3mJK0R1Z7oQk+igEr3smG428iRfwy8vFGV2aVUWPM33qwXZxigQt
        Xibp0DAIKa3qbhFCYJ2tDRaTA5gOZIM=
X-Google-Smtp-Source: ACJfBou+pv7Eqh1+EmXrlOH/Rui4I4YUVJbFixmTBAy9ll2x+xxJEjUgYEHrQdVjY/hfVPsqAfoQRw==
X-Received: by 10.28.18.3 with SMTP id 3mr666862wms.64.1515103897663;
        Thu, 04 Jan 2018 14:11:37 -0800 (PST)
Received: from zen.linaro.local ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id 139sm4835575wmp.7.2018.01.04.14.11.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2018 14:11:36 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaro.local (Postfix) with ESMTPS id AD97F3E01B5;
        Thu,  4 Jan 2018 22:11:35 +0000 (GMT)
References: <1515092151-14423-1-git-send-email-git@matthieu-moy.fr> <1515092151-14423-2-git-send-email-git@matthieu-moy.fr>
User-agent: mu4e 1.0-alpha3; emacs 26.0.90
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Thomas Adam <thomas@xteddy.org>
Subject: Re: [RFC PATCH 2/2] Remove now useless email-address parsing code
In-reply-to: <1515092151-14423-2-git-send-email-git@matthieu-moy.fr>
Date:   Thu, 04 Jan 2018 22:11:35 +0000
Message-ID: <87po6pcm08.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Matthieu Moy <git@matthieu-moy.fr> writes:

> We now use Mail::Address unconditionaly, hence parse_mailboxes is now
> dead code. Remove it and its tests.
>
> Signed-off-by: Matthieu Moy <git@matthieu-moy.fr>
> ---
>  perl/Git.pm          | 71 ----------------------------------------------=
------
>  t/t9000-addresses.sh | 27 --------------------
>  t/t9000/test.pl      | 67 ----------------------------------------------=
---
>  3 files changed, 165 deletions(-)
>  delete mode 100755 t/t9000-addresses.sh
>  delete mode 100755 t/t9000/test.pl

Should we add the tests for t9001-send-email.sh to guard against regression=
s?

>
> diff --git a/perl/Git.pm b/perl/Git.pm
> index 02a3871..9d60d79 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -880,77 +880,6 @@ sub ident_person {
>  	return "$ident[0] <$ident[1]>";
>  }
>
> -=3Ditem parse_mailboxes
> -
> -Return an array of mailboxes extracted from a string.
> -
> -=3Dcut
> -
> -# Very close to Mail::Address's parser, but we still have minor
> -# differences in some cases (see t9000 for examples).
> -sub parse_mailboxes {
> -	my $re_comment =3D qr/\((?:[^)]*)\)/;
> -	my $re_quote =3D qr/"(?:[^\"\\]|\\.)*"/;
> -	my $re_word =3D qr/(?:[^]["\s()<>:;@\\,.]|\\.)+/;
> -
> -	# divide the string in tokens of the above form
> -	my $re_token =3D qr/(?:$re_quote|$re_word|$re_comment|\S)/;
> -	my @tokens =3D map { $_ =3D~ /\s*($re_token)\s*/g } @_;
> -	my $end_of_addr_seen =3D 0;
> -
> -	# add a delimiter to simplify treatment for the last mailbox
> -	push @tokens, ",";
> -
> -	my (@addr_list, @phrase, @address, @comment, @buffer) =3D ();
> -	foreach my $token (@tokens) {
> -		if ($token =3D~ /^[,;]$/) {
> -			# if buffer still contains undeterminated strings
> -			# append it at the end of @address or @phrase
> -			if ($end_of_addr_seen) {
> -				push @phrase, @buffer;
> -			} else {
> -				push @address, @buffer;
> -			}
> -
> -			my $str_phrase =3D join ' ', @phrase;
> -			my $str_address =3D join '', @address;
> -			my $str_comment =3D join ' ', @comment;
> -
> -			# quote are necessary if phrase contains
> -			# special characters
> -			if ($str_phrase =3D~ /[][()<>:;@\\,.\000-\037\177]/) {
> -				$str_phrase =3D~ s/(^|[^\\])"/$1/g;
> -				$str_phrase =3D qq["$str_phrase"];
> -			}
> -
> -			# add "<>" around the address if necessary
> -			if ($str_address ne "" && $str_phrase ne "") {
> -				$str_address =3D qq[<$str_address>];
> -			}
> -
> -			my $str_mailbox =3D "$str_phrase $str_address $str_comment";
> -			$str_mailbox =3D~ s/^\s*|\s*$//g;
> -			push @addr_list, $str_mailbox if ($str_mailbox);
> -
> -			@phrase =3D @address =3D @comment =3D @buffer =3D ();
> -			$end_of_addr_seen =3D 0;
> -		} elsif ($token =3D~ /^\(/) {
> -			push @comment, $token;
> -		} elsif ($token eq "<") {
> -			push @phrase, (splice @address), (splice @buffer);
> -		} elsif ($token eq ">") {
> -			$end_of_addr_seen =3D 1;
> -			push @address, (splice @buffer);
> -		} elsif ($token eq "@" && !$end_of_addr_seen) {
> -			push @address, (splice @buffer), "@";
> -		} else {
> -			push @buffer, $token;
> -		}
> -	}
> -
> -	return @addr_list;
> -}
> -
>  =3Ditem hash_object ( TYPE, FILENAME )
>
>  Compute the SHA1 object id of the given C<FILENAME> considering it is
> diff --git a/t/t9000-addresses.sh b/t/t9000-addresses.sh
> deleted file mode 100755
> index a1ebef6..0000000
> --- a/t/t9000-addresses.sh
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -#!/bin/sh
> -
> -test_description=3D'compare address parsing with and without Mail::Addre=
ss'
> -. ./test-lib.sh
> -
> -if ! test_have_prereq PERL; then
> -	skip_all=3D'skipping perl interface tests, perl not available'
> -	test_done
> -fi
> -
> -perl -MTest::More -e 0 2>/dev/null || {
> -	skip_all=3D"Perl Test::More unavailable, skipping test"
> -	test_done
> -}
> -
> -perl -MMail::Address -e 0 2>/dev/null || {
> -	skip_all=3D"Perl Mail::Address unavailable, skipping test"
> -	test_done
> -}
> -
> -test_external_has_tap=3D1
> -
> -test_external_without_stderr \
> -	'Perl address parsing function' \
> -	perl "$TEST_DIRECTORY"/t9000/test.pl
> -
> -test_done
> diff --git a/t/t9000/test.pl b/t/t9000/test.pl
> deleted file mode 100755
> index dfeaa9c..0000000
> --- a/t/t9000/test.pl
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -#!/usr/bin/perl
> -use lib (split(/:/, $ENV{GITPERLLIB}));
> -
> -use 5.008;
> -use warnings;
> -use strict;
> -
> -use Test::More qw(no_plan);
> -use Mail::Address;
> -
> -BEGIN { use_ok('Git') }
> -
> -my @success_list =3D (q[Jane],
> -	q[jdoe@example.com],
> -	q[<jdoe@example.com>],
> -	q[Jane <jdoe@example.com>],
> -	q[Jane Doe <jdoe@example.com>],
> -	q["Jane" <jdoe@example.com>],
> -	q["Doe, Jane" <jdoe@example.com>],
> -	q["Jane@:;\>.,()<Doe" <jdoe@example.com>],
> -	q[Jane!#$%&'*+-/=3D?^_{|}~Doe' <jdoe@example.com>],
> -	q["<jdoe@example.com>"],
> -	q["Jane jdoe@example.com"],
> -	q[Jane Doe <jdoe    @   example.com  >],
> -	q[Jane       Doe <  jdoe@example.com  >],
> -	q[Jane @ Doe @ Jane @ Doe],
> -	q["Jane, 'Doe'" <jdoe@example.com>],
> -	q['Doe, "Jane' <jdoe@example.com>],
> -	q["Jane" "Do"e <jdoe@example.com>],
> -	q["Jane' Doe" <jdoe@example.com>],
> -	q["Jane Doe <jdoe@example.com>" <jdoe@example.com>],
> -	q["Jane\" Doe" <jdoe@example.com>],
> -	q[Doe, jane <jdoe@example.com>],
> -	q["Jane Doe <jdoe@example.com>],
> -	q['Jane 'Doe' <jdoe@example.com>],
> -	q[Jane@:;\.,()<>Doe <jdoe@example.com>],
> -	q[Jane <jdoe@example.com> Doe],
> -	q[<jdoe@example.com> Jane Doe]);
> -
> -my @known_failure_list =3D (q[Jane\ Doe <jdoe@example.com>],
> -	q["Doe, Ja"ne <jdoe@example.com>],
> -	q["Doe, Katarina" Jane <jdoe@example.com>],
> -	q[Jane jdoe@example.com],
> -	q["Jane "Kat"a" ri"na" ",Doe" <jdoe@example.com>],
> -	q[Jane Doe],
> -	q[Jane "Doe <jdoe@example.com>"],
> -	q[\"Jane Doe <jdoe@example.com>],
> -	q[Jane\"\" Doe <jdoe@example.com>],
> -	q['Jane "Katarina\" \' Doe' <jdoe@example.com>]);
> -
> -foreach my $str (@success_list) {
> -	my @expected =3D map { $_->format } Mail::Address->parse("$str");
> -	my @actual =3D Git::parse_mailboxes("$str");
> -	is_deeply(\@expected, \@actual, qq[same output : $str]);
> -}
> -
> -TODO: {
> -	local $TODO =3D "known breakage";
> -	foreach my $str (@known_failure_list) {
> -		my @expected =3D map { $_->format } Mail::Address->parse("$str");
> -		my @actual =3D Git::parse_mailboxes("$str");
> -		is_deeply(\@expected, \@actual, qq[same output : $str]);
> -	}
> -}
> -
> -my $is_passing =3D eval { Test::More->is_passing };
> -exit($is_passing ? 0 : 1) unless $@ =3D~ /Can't locate object method/;


--
Alex Benn=C3=A9e
