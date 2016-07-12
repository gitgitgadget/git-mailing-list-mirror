Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34DC21FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 18:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbcGLSMa (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 14:12:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60747 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750720AbcGLSM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 14:12:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B9D092A3F9;
	Tue, 12 Jul 2016 14:12:27 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H9HjjS5i+mwFxjeZY0CQzq44PgE=; b=nvRVB2
	voGrdTspDBeanAdL8jgaztvg9p5wq6EnQlFWXMa0NRBjlW4zfbfPXilEfzKLvcJn
	pJCCnuojdOX1dsuMpcmmcSsWmQgGdhcUu9T14jmHAMSzT0E9ifoaCmJT4dcazOVN
	JnMP47tohULFyVeOW0FG1O9Rqqd2r3arBMvEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LrWcx9VqgxfxhxoWLyg76sCG+O+pB5QJ
	LaKL0MBMptev2jp24F3QxgWVgqw17w3feuR9CRnkcVuVldgiVhiqcAw0ifci7P39
	IAPkn+2uWgQet9L5KsBBu28Xrl82PSvTVfAH318TEJFNp/53zwN4eiBiwGRZEanO
	nZ9bo6A6BSI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B1B262A3F7;
	Tue, 12 Jul 2016 14:12:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 349712A3F6;
	Tue, 12 Jul 2016 14:12:27 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>,
	git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
	<87lh17kgdy.fsf@linux-m68k.org>
	<20160711235417.GA26163@sigill.intra.peff.net>
	<xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607120927410.6426@virtualbox>
	<20160712073912.GA26431@sigill.intra.peff.net>
	<alpine.DEB.2.20.1607121257450.6426@virtualbox>
Date:	Tue, 12 Jul 2016 11:12:25 -0700
In-Reply-To: <alpine.DEB.2.20.1607121257450.6426@virtualbox> (Johannes
	Schindelin's message of "Tue, 12 Jul 2016 13:25:20 +0200 (CEST)")
Message-ID: <xmqqbn2267zq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30ADC5D4-485C-11E6-9012-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Cool! Thanks for working on this.
>
> Well, I had to. Git for Windows v2.9.1 needs to get released, and I won't
> do that with a failing test suite.

Let's do 2.9.2 together, as this is not limited to GfW.

Taking Peff's suggestions into account, perhaps like the attached?

It wasn't readily apparent to me why 2038 check worked, so I added a
short paragraph at the end, but those who know the test helper well
enough may find it redundant, in which case I am fine with removing
it.

Thanks.

-- >8 --
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date: Tue, 12 Jul 2016 13:25:20 +0200
Subject: t0006: skip "far in the future" test when ulong is not long enough

Git's source code refers to timestamps as unsigned longs.  On 32-bit
platforms, as well as on Windows, unsigned long is not large enough
to capture dates that are "absurdly far in the future".

While we can fix this issue properly by replacing unsigned long with
a larger type, we want to be a bit more conservative and just skip
those tests on the maint track.

The test helper reads the timestamp given from the command line into
"unsigned long" using strtol(), which gives us LONG_MAX upon
overflow, so feeding 9999999999 and seeing the resulting "timestamp"
shown in year 2038 is a sufficient check for that condition.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0006-date.sh | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 04ce535..6070c29 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -31,7 +31,7 @@ check_show () {
 	format=$1
 	time=$2
 	expect=$3
-	test_expect_${4:-success} "show date ($format:$time)" '
+	test_expect_success $4 "show date ($format:$time)" '
 		echo "$time -> $expect" >expect &&
 		test-date show:$format "$time" >actual &&
 		test_cmp expect actual
@@ -48,10 +48,22 @@ check_show default "$TIME" 'Wed Jun 15 16:13:20 2016 +0200'
 check_show raw "$TIME" '1466000000 +0200'
 check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
 
+test_lazy_prereq 64BIT_TIME '
+	case "$(test-date show:iso 9999999999)" in
+	*" -> 2038-"*)
+		# on this platform, unsigned long is 32-bit, i.e. not large enough
+		false
+		;;
+	*)
+		true
+		;;
+	esac
+'
+
 # arbitrary time absurdly far in the future
 FUTURE="5758122296 -0400"
-check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400"
-check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000"
+check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" 64BIT_TIME
+check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" 64BIT_TIME
 
 check_parse() {
 	echo "$1 -> $2" >expect
-- 
2.9.1-500-g4c1e1e0



