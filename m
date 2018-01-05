Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 252461F428
	for <e@80x24.org>; Fri,  5 Jan 2018 18:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752385AbeAEShy (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 13:37:54 -0500
Received: from mut-mta1-se01a-zose1-fr.yulpa.io ([185.49.21.248]:60892 "EHLO
        mut-mta1-se01a-zose1-fr.yulpa.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752370AbeAEShx (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Jan 2018 13:37:53 -0500
Received: from zose-mx-out01.web4all.fr ([185.49.20.46] helo=zose-mta-hub-out-mua-02.web4all.fr)
        by mut-mta1-se01c-fr.yulpa.io with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <git@matthieu-moy.fr>)
        id 1eXWsI-0004nB-DO; Fri, 05 Jan 2018 19:37:51 +0100
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTP id 1B20160E71;
        Fri,  5 Jan 2018 19:37:50 +0100 (CET)
Received: from zose-mta-hub-out-mua-02.web4all.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-mua-02.web4all.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Au61FaQiI5FB; Fri,  5 Jan 2018 19:37:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTP id 114F260E62;
        Fri,  5 Jan 2018 19:37:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at zose1.web4all.fr
Received: from zose-mta-hub-out-mua-02.web4all.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-mua-02.web4all.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 09q4sH-Cm0ku; Fri,  5 Jan 2018 19:37:45 +0100 (CET)
Received: from moylip.numericable.fr (3.136.192.77.rev.sfr.net [77.192.136.3])
        (Authenticated sender: matthieu.moy@matthieu-moy.fr)
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTPSA id D19C960E4A;
        Fri,  5 Jan 2018 19:37:43 +0100 (CET)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Thomas Adam <thomas@xteddy.org>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH v2 2/3] Remove now useless email-address parsing code
Date:   Fri,  5 Jan 2018 19:36:52 +0100
Message-Id: <1515177413-12526-2-git-send-email-git@matthieu-moy.fr>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1515177413-12526-1-git-send-email-git@matthieu-moy.fr>
References: <1515092151-14423-1-git-send-email-git@matthieu-moy.fr>
 <1515177413-12526-1-git-send-email-git@matthieu-moy.fr>
X-Originating-IP: 185.49.20.46
X-SpamExperts-Domain: zose1.web4all.fr
X-SpamExperts-Username: 185.49.20.46
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.49.20.46@zose1.web4all.fr
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (6.6464901268e-05)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5qFxyVqzGJJapkeXXEv+wVDj1g3/PwYZaTCzSym8uE9HPImhfA8k5/zW
 UdbqUfA/+atZAIrjsCRyglG39ay7s40zkSakW8+kgCjGkeOx1qmz3ywmUacsjxjAsJqLMS98bO5z
 ycA319z5HV3CMmoHwxoemuNNL7GGp+zW501rEhQ5LqisX5+l+fRB3wYlhH1KyOfHzJ6mVE7ewsip
 SVIfs4a9/t5lDJ0RvV+O4AazRCDVZoJMI94JyDNTYfA50Otxn/jk0+YoVjbPYBbwrj5eWUnOiXFL
 iKIvpft9mm8OdmYqEPKqj4wpSPprxfaL4KUPa+d7ax+3+Jf/9S3laQAPwF4OOPS2BLJ6Do0LA2bx
 tTWVqi2fY8oW0hCeiKrXsIHuXDVcbwW2vZRbwlTsaou4YdkkTMgPdccxEqDs1YXBmdsdph+zJwql
 Pd7TjGfWxGLgmXGIZgivQPDIYm4WSM8blQV7LjJv6mzjqKuJJhZmAO87f5jxqIuHmumvO07FITnq
 MT3dKxLhoxcmaInYbR5vlqHMyA/lkPBbC6c0vlSRGDQGZ79loFWGs6aHjUJ9h7NVQthDlN3ZFexZ
 fYgAG9qTPTpp5PS1j/T/np9d21JHIowhxzFHIp09+LXjBI7tFUvo6Ni0le2DVmUTXV7P/TeeGAfu
 3dtmPbt22v14990vrczqwXb6wx3Ks8PAWCiB5XmocRYyV5KHfiKBno8OsMogRnWlQ9fDAeXihC1X
 mRU9VPw70z6bhalFEM/pjPCQA+BAlngHvY0q9Gw5NOloxVW0K/tO3saCFey4hE3JznGRzrizu129
 acHYDxLXrLFZ27x/iSr1SfvgmNhQd5GjBg/FbRJc9aUV1oY4fX3W5eOCNA39aaEeNVeYHTQ4qc4p
 rBw6OWxEnZ+B9jntbFMsB5h9L3Pcq6EXKX3cZxLzrCA9pYo1HvE2dZcCZBCEfYvQUHiJ0yEw/ggH
 k6NxP0mFXr1FslXeNHk15VolAGHS5rCXQKDyHv3TiDImoWFJv2x8Vhm7/dDfeKdHWm+j+q2hZS63
 ia/tIkSE0ngbX0T3LvR1Khr2Eo2bTut7ztDdNHV3VH6Kds23J7LHDHZzGBAiCeuHbrg=
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We now use Mail::Address unconditionaly, hence parse_mailboxes is now
dead code. Remove it and its tests.

Signed-off-by: Matthieu Moy <git@matthieu-moy.fr>
---
 perl/Git.pm          | 71 ----------------------------------------------------
 t/t9000-addresses.sh | 27 --------------------
 t/t9000/test.pl      | 67 -------------------------------------------------
 3 files changed, 165 deletions(-)
 delete mode 100755 t/t9000-addresses.sh
 delete mode 100755 t/t9000/test.pl

diff --git a/perl/Git.pm b/perl/Git.pm
index ffa09ac..65e6b32 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -880,77 +880,6 @@ sub ident_person {
 	return "$ident[0] <$ident[1]>";
 }
 
-=item parse_mailboxes
-
-Return an array of mailboxes extracted from a string.
-
-=cut
-
-# Very close to Mail::Address's parser, but we still have minor
-# differences in some cases (see t9000 for examples).
-sub parse_mailboxes {
-	my $re_comment = qr/\((?:[^)]*)\)/;
-	my $re_quote = qr/"(?:[^\"\\]|\\.)*"/;
-	my $re_word = qr/(?:[^]["\s()<>:;@\\,.]|\\.)+/;
-
-	# divide the string in tokens of the above form
-	my $re_token = qr/(?:$re_quote|$re_word|$re_comment|\S)/;
-	my @tokens = map { $_ =~ /\s*($re_token)\s*/g } @_;
-	my $end_of_addr_seen = 0;
-
-	# add a delimiter to simplify treatment for the last mailbox
-	push @tokens, ",";
-
-	my (@addr_list, @phrase, @address, @comment, @buffer) = ();
-	foreach my $token (@tokens) {
-		if ($token =~ /^[,;]$/) {
-			# if buffer still contains undeterminated strings
-			# append it at the end of @address or @phrase
-			if ($end_of_addr_seen) {
-				push @phrase, @buffer;
-			} else {
-				push @address, @buffer;
-			}
-
-			my $str_phrase = join ' ', @phrase;
-			my $str_address = join '', @address;
-			my $str_comment = join ' ', @comment;
-
-			# quote are necessary if phrase contains
-			# special characters
-			if ($str_phrase =~ /[][()<>:;@\\,.\000-\037\177]/) {
-				$str_phrase =~ s/(^|[^\\])"/$1/g;
-				$str_phrase = qq["$str_phrase"];
-			}
-
-			# add "<>" around the address if necessary
-			if ($str_address ne "" && $str_phrase ne "") {
-				$str_address = qq[<$str_address>];
-			}
-
-			my $str_mailbox = "$str_phrase $str_address $str_comment";
-			$str_mailbox =~ s/^\s*|\s*$//g;
-			push @addr_list, $str_mailbox if ($str_mailbox);
-
-			@phrase = @address = @comment = @buffer = ();
-			$end_of_addr_seen = 0;
-		} elsif ($token =~ /^\(/) {
-			push @comment, $token;
-		} elsif ($token eq "<") {
-			push @phrase, (splice @address), (splice @buffer);
-		} elsif ($token eq ">") {
-			$end_of_addr_seen = 1;
-			push @address, (splice @buffer);
-		} elsif ($token eq "@" && !$end_of_addr_seen) {
-			push @address, (splice @buffer), "@";
-		} else {
-			push @buffer, $token;
-		}
-	}
-
-	return @addr_list;
-}
-
 =item hash_object ( TYPE, FILENAME )
 
 Compute the SHA1 object id of the given C<FILENAME> considering it is
diff --git a/t/t9000-addresses.sh b/t/t9000-addresses.sh
deleted file mode 100755
index a1ebef6..0000000
--- a/t/t9000-addresses.sh
+++ /dev/null
@@ -1,27 +0,0 @@
-#!/bin/sh
-
-test_description='compare address parsing with and without Mail::Address'
-. ./test-lib.sh
-
-if ! test_have_prereq PERL; then
-	skip_all='skipping perl interface tests, perl not available'
-	test_done
-fi
-
-perl -MTest::More -e 0 2>/dev/null || {
-	skip_all="Perl Test::More unavailable, skipping test"
-	test_done
-}
-
-perl -MMail::Address -e 0 2>/dev/null || {
-	skip_all="Perl Mail::Address unavailable, skipping test"
-	test_done
-}
-
-test_external_has_tap=1
-
-test_external_without_stderr \
-	'Perl address parsing function' \
-	perl "$TEST_DIRECTORY"/t9000/test.pl
-
-test_done
diff --git a/t/t9000/test.pl b/t/t9000/test.pl
deleted file mode 100755
index dfeaa9c..0000000
--- a/t/t9000/test.pl
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/usr/bin/perl
-use lib (split(/:/, $ENV{GITPERLLIB}));
-
-use 5.008;
-use warnings;
-use strict;
-
-use Test::More qw(no_plan);
-use Mail::Address;
-
-BEGIN { use_ok('Git') }
-
-my @success_list = (q[Jane],
-	q[jdoe@example.com],
-	q[<jdoe@example.com>],
-	q[Jane <jdoe@example.com>],
-	q[Jane Doe <jdoe@example.com>],
-	q["Jane" <jdoe@example.com>],
-	q["Doe, Jane" <jdoe@example.com>],
-	q["Jane@:;\>.,()<Doe" <jdoe@example.com>],
-	q[Jane!#$%&'*+-/=?^_{|}~Doe' <jdoe@example.com>],
-	q["<jdoe@example.com>"],
-	q["Jane jdoe@example.com"],
-	q[Jane Doe <jdoe    @   example.com  >],
-	q[Jane       Doe <  jdoe@example.com  >],
-	q[Jane @ Doe @ Jane @ Doe],
-	q["Jane, 'Doe'" <jdoe@example.com>],
-	q['Doe, "Jane' <jdoe@example.com>],
-	q["Jane" "Do"e <jdoe@example.com>],
-	q["Jane' Doe" <jdoe@example.com>],
-	q["Jane Doe <jdoe@example.com>" <jdoe@example.com>],
-	q["Jane\" Doe" <jdoe@example.com>],
-	q[Doe, jane <jdoe@example.com>],
-	q["Jane Doe <jdoe@example.com>],
-	q['Jane 'Doe' <jdoe@example.com>],
-	q[Jane@:;\.,()<>Doe <jdoe@example.com>],
-	q[Jane <jdoe@example.com> Doe],
-	q[<jdoe@example.com> Jane Doe]);
-
-my @known_failure_list = (q[Jane\ Doe <jdoe@example.com>],
-	q["Doe, Ja"ne <jdoe@example.com>],
-	q["Doe, Katarina" Jane <jdoe@example.com>],
-	q[Jane jdoe@example.com],
-	q["Jane "Kat"a" ri"na" ",Doe" <jdoe@example.com>],
-	q[Jane Doe],
-	q[Jane "Doe <jdoe@example.com>"],
-	q[\"Jane Doe <jdoe@example.com>],
-	q[Jane\"\" Doe <jdoe@example.com>],
-	q['Jane "Katarina\" \' Doe' <jdoe@example.com>]);
-
-foreach my $str (@success_list) {
-	my @expected = map { $_->format } Mail::Address->parse("$str");
-	my @actual = Git::parse_mailboxes("$str");
-	is_deeply(\@expected, \@actual, qq[same output : $str]);
-}
-
-TODO: {
-	local $TODO = "known breakage";
-	foreach my $str (@known_failure_list) {
-		my @expected = map { $_->format } Mail::Address->parse("$str");
-		my @actual = Git::parse_mailboxes("$str");
-		is_deeply(\@expected, \@actual, qq[same output : $str]);
-	}
-}
-
-my $is_passing = eval { Test::More->is_passing };
-exit($is_passing ? 0 : 1) unless $@ =~ /Can't locate object method/;
-- 
2.7.4

