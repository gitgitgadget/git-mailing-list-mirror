Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5BF4203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 19:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757100AbcG0T2T (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 15:28:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59548 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756830AbcG0T2S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 15:28:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D2322FC1A;
	Wed, 27 Jul 2016 15:28:17 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2gm0ScSbJV78pFQ+M27jF6wWJjw=; b=qQRUm/
	66s4OcN2A9TrToeZ3Fe23GhrrJgsc7S23pFF6WRA8y8KbC5nVVLnBWCm5geCI7jz
	m1sCc25dcyHVPNOsoFI2NnMfVaWVJFaCd9S37DiyNtwJdY9mZ+g9jp35lbPZblnk
	DjzZW4ZZ67epu7xKRA/inliMYEmyHY665w2Wk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f84h8hO+y3TA/sNDzb5OhRT+bo/60L3M
	NzP9ZxuY0dRlTjaQbiQ0R5tuXw11GL8HQeqvx9AtVH61gK/DPs4RX97e9crci73c
	7QgRpvgAuQkolkkbux0phVPZqoVsJDeB7VrNijl3LheyxI0PFVglhMIVO5ENd5Pw
	yFhMXTCRxyQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 63DC82FC18;
	Wed, 27 Jul 2016 15:28:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A07CE2FC17;
	Wed, 27 Jul 2016 15:28:16 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Phil Pennock <phil@pennock-tech.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] t4205: indent here documents
References: <20160727185256.GA11657@sigill.intra.peff.net>
	<20160727185523.GB6626@sigill.intra.peff.net>
Date:	Wed, 27 Jul 2016 12:28:14 -0700
In-Reply-To: <20160727185523.GB6626@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 27 Jul 2016 14:55:23 -0400")
Message-ID: <xmqqbn1ix4mp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44978F1E-5430-11E6-A6D4-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Our usual style in the test scripts is to indent here
> documents with tabs, and use "<<-" to strip the tabs. The
> result is easier to read.
>
> This old test script did not do so in its inception, and
> further tests added onto it followed the local style. Let's
> bring it in line with our usual style.
>
> Some of the tests actually care quite a bit about
> whitespace, but none of them do so at the beginning of the
> line (because they things like qz_to_tab_space to avoid

I'll do s/they things/they use things/ here while queuing.

Thanks.

> depending on the literal whitespace), so we can do a fairly
> mechanical conversion.
>
> Most of the here-docs also use interpolation, so they have
> been left as "<<-EOF". In a few cases, though, where
> interpolation was not in use, I've converted them to
> "<<-\EOF" to match our usual "don't interpolate unless you
> need to" style.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t4205-log-pretty-formats.sh | 392 +++++++++++++++++++++---------------------
>  1 file changed, 196 insertions(+), 196 deletions(-)
>
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index d6518fa..f5435fd 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -145,199 +145,199 @@ test_expect_success 'setup more commits' '
>  
>  test_expect_success 'left alignment formatting' '
>  	git log --pretty="tformat:%<(40)%s" >actual &&
> -	qz_to_tab_space <<EOF >expected &&
> -message two                            Z
> -message one                            Z
> -add bar                                Z
> -$(commit_msg)                    Z
> -EOF
> +	qz_to_tab_space <<-EOF >expected &&
> +	message two                            Z
> +	message one                            Z
> +	add bar                                Z
> +	$(commit_msg)                    Z
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'left alignment formatting. i18n.logOutputEncoding' '
>  	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(40)%s" >actual &&
> -	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
> -message two                            Z
> -message one                            Z
> -add bar                                Z
> -$(commit_msg)                    Z
> -EOF
> +	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
> +	message two                            Z
> +	message one                            Z
> +	add bar                                Z
> +	$(commit_msg)                    Z
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'left alignment formatting at the nth column' '
>  	git log --pretty="tformat:%h %<|(40)%s" >actual &&
> -	qz_to_tab_space <<EOF >expected &&
> -$head1 message two                    Z
> -$head2 message one                    Z
> -$head3 add bar                        Z
> -$head4 $(commit_msg)            Z
> -EOF
> +	qz_to_tab_space <<-EOF >expected &&
> +	$head1 message two                    Z
> +	$head2 message one                    Z
> +	$head3 add bar                        Z
> +	$head4 $(commit_msg)            Z
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'left alignment formatting at the nth column' '
>  	COLUMNS=50 git log --pretty="tformat:%h %<|(-10)%s" >actual &&
> -	qz_to_tab_space <<EOF >expected &&
> -$head1 message two                    Z
> -$head2 message one                    Z
> -$head3 add bar                        Z
> -$head4 $(commit_msg)            Z
> -EOF
> +	qz_to_tab_space <<-EOF >expected &&
> +	$head1 message two                    Z
> +	$head2 message one                    Z
> +	$head3 add bar                        Z
> +	$head4 $(commit_msg)            Z
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'left alignment formatting at the nth column. i18n.logOutputEncoding' '
>  	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%h %<|(40)%s" >actual &&
> -	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
> -$head1 message two                    Z
> -$head2 message one                    Z
> -$head3 add bar                        Z
> -$head4 $(commit_msg)            Z
> -EOF
> +	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
> +	$head1 message two                    Z
> +	$head2 message one                    Z
> +	$head3 add bar                        Z
> +	$head4 $(commit_msg)            Z
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'left alignment formatting with no padding' '
>  	git log --pretty="tformat:%<(1)%s" >actual &&
> -	cat <<EOF >expected &&
> -message two
> -message one
> -add bar
> -$(commit_msg)
> -EOF
> +	cat <<-EOF >expected &&
> +	message two
> +	message one
> +	add bar
> +	$(commit_msg)
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'left alignment formatting with no padding. i18n.logOutputEncoding' '
>  	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(1)%s" >actual &&
> -	cat <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
> -message two
> -message one
> -add bar
> -$(commit_msg)
> -EOF
> +	cat <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
> +	message two
> +	message one
> +	add bar
> +	$(commit_msg)
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'left alignment formatting with trunc' '
>  	git log --pretty="tformat:%<(10,trunc)%s" >actual &&
> -	qz_to_tab_space <<EOF >expected &&
> -message ..
> -message ..
> -add bar  Z
> -initial...
> -EOF
> +	qz_to_tab_space <<-\EOF >expected &&
> +	message ..
> +	message ..
> +	add bar  Z
> +	initial...
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'left alignment formatting with trunc. i18n.logOutputEncoding' '
>  	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,trunc)%s" >actual &&
> -	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
> -message ..
> -message ..
> -add bar  Z
> -initial...
> -EOF
> +	qz_to_tab_space <<-\EOF | iconv -f utf-8 -t $test_encoding >expected &&
> +	message ..
> +	message ..
> +	add bar  Z
> +	initial...
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'left alignment formatting with ltrunc' '
>  	git log --pretty="tformat:%<(10,ltrunc)%s" >actual &&
> -	qz_to_tab_space <<EOF >expected &&
> -..sage two
> -..sage one
> -add bar  Z
> -..${sample_utf8_part}lich
> -EOF
> +	qz_to_tab_space <<-EOF >expected &&
> +	..sage two
> +	..sage one
> +	add bar  Z
> +	..${sample_utf8_part}lich
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'left alignment formatting with ltrunc. i18n.logOutputEncoding' '
>  	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,ltrunc)%s" >actual &&
> -	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
> -..sage two
> -..sage one
> -add bar  Z
> -..${sample_utf8_part}lich
> -EOF
> +	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
> +	..sage two
> +	..sage one
> +	add bar  Z
> +	..${sample_utf8_part}lich
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'left alignment formatting with mtrunc' '
>  	git log --pretty="tformat:%<(10,mtrunc)%s" >actual &&
> -	qz_to_tab_space <<EOF >expected &&
> -mess.. two
> -mess.. one
> -add bar  Z
> -init..lich
> -EOF
> +	qz_to_tab_space <<-\EOF >expected &&
> +	mess.. two
> +	mess.. one
> +	add bar  Z
> +	init..lich
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'left alignment formatting with mtrunc. i18n.logOutputEncoding' '
>  	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,mtrunc)%s" >actual &&
> -	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
> -mess.. two
> -mess.. one
> -add bar  Z
> -init..lich
> -EOF
> +	qz_to_tab_space <<-\EOF | iconv -f utf-8 -t $test_encoding >expected &&
> +	mess.. two
> +	mess.. one
> +	add bar  Z
> +	init..lich
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'right alignment formatting' '
>  	git log --pretty="tformat:%>(40)%s" >actual &&
> -	qz_to_tab_space <<EOF >expected &&
> -Z                            message two
> -Z                            message one
> -Z                                add bar
> -Z                    $(commit_msg)
> -EOF
> +	qz_to_tab_space <<-EOF >expected &&
> +	Z                            message two
> +	Z                            message one
> +	Z                                add bar
> +	Z                    $(commit_msg)
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'right alignment formatting. i18n.logOutputEncoding' '
>  	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%>(40)%s" >actual &&
> -	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
> -Z                            message two
> -Z                            message one
> -Z                                add bar
> -Z                    $(commit_msg)
> -EOF
> +	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
> +	Z                            message two
> +	Z                            message one
> +	Z                                add bar
> +	Z                    $(commit_msg)
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'right alignment formatting at the nth column' '
>  	git log --pretty="tformat:%h %>|(40)%s" >actual &&
> -	qz_to_tab_space <<EOF >expected &&
> -$head1                      message two
> -$head2                      message one
> -$head3                          add bar
> -$head4              $(commit_msg)
> -EOF
> +	qz_to_tab_space <<-EOF >expected &&
> +	$head1                      message two
> +	$head2                      message one
> +	$head3                          add bar
> +	$head4              $(commit_msg)
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'right alignment formatting at the nth column' '
>  	COLUMNS=50 git log --pretty="tformat:%h %>|(-10)%s" >actual &&
> -	qz_to_tab_space <<EOF >expected &&
> -$head1                      message two
> -$head2                      message one
> -$head3                          add bar
> -$head4              $(commit_msg)
> -EOF
> +	qz_to_tab_space <<-EOF >expected &&
> +	$head1                      message two
> +	$head2                      message one
> +	$head3                          add bar
> +	$head4              $(commit_msg)
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'right alignment formatting at the nth column. i18n.logOutputEncoding' '
>  	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%h %>|(40)%s" >actual &&
> -	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
> -$head1                      message two
> -$head2                      message one
> -$head3                          add bar
> -$head4              $(commit_msg)
> -EOF
> +	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
> +	$head1                      message two
> +	$head2                      message one
> +	$head3                          add bar
> +	$head4              $(commit_msg)
> +	EOF
>  	test_cmp expected actual
>  '
>  
> @@ -345,110 +345,110 @@ EOF
>  # as in previous test.
>  test_expect_success 'right alignment formatting at the nth column with --graph. i18n.logOutputEncoding' '
>  	git -c i18n.logOutputEncoding=$test_encoding log --graph --pretty="tformat:%h %>|(40)%s" >actual &&
> -	iconv -f utf-8 -t $test_encoding >expected <<EOF&&
> -* $head1                    message two
> -* $head2                    message one
> -* $head3                        add bar
> -* $head4            $(commit_msg)
> -EOF
> +	iconv -f utf-8 -t $test_encoding >expected <<-EOF &&
> +	* $head1                    message two
> +	* $head2                    message one
> +	* $head3                        add bar
> +	* $head4            $(commit_msg)
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'right alignment formatting with no padding' '
>  	git log --pretty="tformat:%>(1)%s" >actual &&
> -	cat <<EOF >expected &&
> -message two
> -message one
> -add bar
> -$(commit_msg)
> -EOF
> +	cat <<-EOF >expected &&
> +	message two
> +	message one
> +	add bar
> +	$(commit_msg)
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'right alignment formatting with no padding and with --graph' '
>  	git log --graph --pretty="tformat:%>(1)%s" >actual &&
> -	cat <<EOF >expected &&
> -* message two
> -* message one
> -* add bar
> -* $(commit_msg)
> -EOF
> +	cat <<-EOF >expected &&
> +	* message two
> +	* message one
> +	* add bar
> +	* $(commit_msg)
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'right alignment formatting with no padding. i18n.logOutputEncoding' '
>  	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%>(1)%s" >actual &&
> -	cat <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
> -message two
> -message one
> -add bar
> -$(commit_msg)
> -EOF
> +	cat <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
> +	message two
> +	message one
> +	add bar
> +	$(commit_msg)
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'center alignment formatting' '
>  	git log --pretty="tformat:%><(40)%s" >actual &&
> -	qz_to_tab_space <<EOF >expected &&
> -Z             message two              Z
> -Z             message one              Z
> -Z               add bar                Z
> -Z         $(commit_msg)          Z
> -EOF
> +	qz_to_tab_space <<-EOF >expected &&
> +	Z             message two              Z
> +	Z             message one              Z
> +	Z               add bar                Z
> +	Z         $(commit_msg)          Z
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'center alignment formatting. i18n.logOutputEncoding' '
>  	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%><(40)%s" >actual &&
> -	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
> -Z             message two              Z
> -Z             message one              Z
> -Z               add bar                Z
> -Z         $(commit_msg)          Z
> -EOF
> +	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
> +	Z             message two              Z
> +	Z             message one              Z
> +	Z               add bar                Z
> +	Z         $(commit_msg)          Z
> +	EOF
>  	test_cmp expected actual
>  '
>  test_expect_success 'center alignment formatting at the nth column' '
>  	git log --pretty="tformat:%h %><|(40)%s" >actual &&
> -	qz_to_tab_space <<EOF >expected &&
> -$head1           message two          Z
> -$head2           message one          Z
> -$head3             add bar            Z
> -$head4       $(commit_msg)      Z
> -EOF
> +	qz_to_tab_space <<-EOF >expected &&
> +	$head1           message two          Z
> +	$head2           message one          Z
> +	$head3             add bar            Z
> +	$head4       $(commit_msg)      Z
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'center alignment formatting at the nth column' '
>  	COLUMNS=70 git log --pretty="tformat:%h %><|(-30)%s" >actual &&
> -	qz_to_tab_space <<EOF >expected &&
> -$head1           message two          Z
> -$head2           message one          Z
> -$head3             add bar            Z
> -$head4       $(commit_msg)      Z
> -EOF
> +	qz_to_tab_space <<-EOF >expected &&
> +	$head1           message two          Z
> +	$head2           message one          Z
> +	$head3             add bar            Z
> +	$head4       $(commit_msg)      Z
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'center alignment formatting at the nth column. i18n.logOutputEncoding' '
>  	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%h %><|(40)%s" >actual &&
> -	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
> -$head1           message two          Z
> -$head2           message one          Z
> -$head3             add bar            Z
> -$head4       $(commit_msg)      Z
> -EOF
> +	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
> +	$head1           message two          Z
> +	$head2           message one          Z
> +	$head3             add bar            Z
> +	$head4       $(commit_msg)      Z
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'center alignment formatting with no padding' '
>  	git log --pretty="tformat:%><(1)%s" >actual &&
> -	cat <<EOF >expected &&
> -message two
> -message one
> -add bar
> -$(commit_msg)
> -EOF
> +	cat <<-EOF >expected &&
> +	message two
> +	message one
> +	add bar
> +	$(commit_msg)
> +	EOF
>  	test_cmp expected actual
>  '
>  
> @@ -457,34 +457,34 @@ EOF
>  old_head1=$(git rev-parse --verify HEAD~0)
>  test_expect_success 'center alignment formatting with no padding. i18n.logOutputEncoding' '
>  	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%><(1)%s" >actual &&
> -	cat <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
> -message two
> -message one
> -add bar
> -$(commit_msg)
> -EOF
> +	cat <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
> +	message two
> +	message one
> +	add bar
> +	$(commit_msg)
> +	EOF
>  	test_cmp expected actual
>  '
>  
>  test_expect_success 'left/right alignment formatting with stealing' '
>  	git commit --amend -m short --author "long long long <long@me.com>" &&
>  	git log --pretty="tformat:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
> -	cat <<EOF >expected &&
> -short long  long long
> -message ..   A U Thor
> -add bar      A U Thor
> -initial...   A U Thor
> -EOF
> +	cat <<-\EOF >expected &&
> +	short long  long long
> +	message ..   A U Thor
> +	add bar      A U Thor
> +	initial...   A U Thor
> +	EOF
>  	test_cmp expected actual
>  '
>  test_expect_success 'left/right alignment formatting with stealing. i18n.logOutputEncoding' '
>  	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
> -	cat <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
> -short long  long long
> -message ..   A U Thor
> -add bar      A U Thor
> -initial...   A U Thor
> -EOF
> +	cat <<-\EOF | iconv -f utf-8 -t $test_encoding >expected &&
> +	short long  long long
> +	message ..   A U Thor
> +	add bar      A U Thor
> +	initial...   A U Thor
> +	EOF
>  	test_cmp expected actual
>  '
>  
> @@ -515,22 +515,22 @@ test_expect_success 'log decoration properly follows tag chain' '
>  	git tag -d tag1 &&
>  	git commit --amend -m shorter &&
>  	git log --no-walk --tags --pretty="%H %d" --decorate=full >actual &&
> -	cat <<EOF >expected &&
> -$head1  (tag: refs/tags/tag2)
> -$head2  (tag: refs/tags/message-one)
> -$old_head1  (tag: refs/tags/message-two)
> -EOF
> +	cat <<-EOF >expected &&
> +	$head1  (tag: refs/tags/tag2)
> +	$head2  (tag: refs/tags/message-one)
> +	$old_head1  (tag: refs/tags/message-two)
> +	EOF
>  	sort actual >actual1 &&
>  	test_cmp expected actual1
>  '
>  
>  test_expect_success 'clean log decoration' '
>  	git log --no-walk --tags --pretty="%H %D" --decorate=full >actual &&
> -	cat >expected <<EOF &&
> -$head1 tag: refs/tags/tag2
> -$head2 tag: refs/tags/message-one
> -$old_head1 tag: refs/tags/message-two
> -EOF
> +	cat >expected <<-EOF &&
> +	$head1 tag: refs/tags/tag2
> +	$head2 tag: refs/tags/message-one
> +	$old_head1 tag: refs/tags/message-two
> +	EOF
>  	sort actual >actual1 &&
>  	test_cmp expected actual1
>  '
