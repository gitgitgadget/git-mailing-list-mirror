Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4937AC433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E55BF23A53
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbhANUWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 15:22:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53451 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbhANUWk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 15:22:40 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8967AF5D0;
        Thu, 14 Jan 2021 15:21:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Qq946YlaDLUS
        +Vj0VDU8/7753/8=; b=ncXq8RhBQIwDH4GZtjtSN9Bg7I+95VWQHRO/QcBkz3PM
        EmYpLe6bgcIy3/pX5mSBg5kYzbA15Uk/SMH2YaHZAoVTXtTjcoAG2QRU6YMTEVaQ
        BVwTcAg09uIT23PuMRRFcvGmYo8G4OJFgZDxX38lW/BU5UKaEUQLTwS645xRUD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=uqzFoR
        oaGIe+SVoCDnuxa7V8shljwxHiX2b5igxB0kLZf/KuacQAML3h/qI35d6VFQYG8/
        nmJSDugcn9/nslMb2EYdGDVI2NFSmMlObQhlGQWmB/f8/zjDRGKj5HDLTd9Dcwab
        rJ9AA+puiFphOuGIPMKf/lk7eWZfykO1RadEc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EBD0AF5CF;
        Thu, 14 Jan 2021 15:21:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 28029AF5CE;
        Thu, 14 Jan 2021 15:21:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 10/22] mailmap tests: get rid of overly complex blame
 fuzzing
References: <20210105130359.21139-1-avarab@gmail.com>
        <20210112201806.13284-11-avarab@gmail.com>
        <xmqqlfcx239z.fsf@gitster.c.googlers.com>
Date:   Thu, 14 Jan 2021 12:21:55 -0800
In-Reply-To: <xmqqlfcx239z.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 12 Jan 2021 14:34:16 -0800")
Message-ID: <xmqqbldrxo9o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 25B02BF6-56A6-11EB-820A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> +	6 6 1
>> +	Santa Claus
>> +	7 7 1
>> +	CTO
>> +	EOF
>> +
>> +	git blame --porcelain one >actual.blame &&
>> +	grep -E \
>> +		-e "[0-9]+ [0-9]+ [0-9]+$" \
>> +		-e "^author .*$" \
>> +		actual.blame >actual.grep &&
>> +	cut -d " " -f2-4 <actual.grep >actual.fuzz &&
>
> An approach along the lines of ...
>
> 	NUM=3D"[0-9][0-9]*"
> 	sed -n -e "s/^author //p" \
> 	-e "s/^$OID_REGEX \($NUM $NUM $NUM\)$/\1/p"
>
> ... would allow you to drop "cut" and also not assume that names do
> not have more than 3 tokens.

Trying to lead by example..., here is the suggestion in a follow-up
patch form that can be applied on top of the series.

----- >8 ----- ----- >8 ----- ----- >8 ----- ----- >8 ----- ----- >8 ----=
-
Subject: [PATCH] t4203: make blame output massaging more robust

In the "git blame --porcelain" output, lines that ends with three
integers may not be the line that shows a commit object with line
numbers and block length (the contents from the blamed file or the
summary field can have a line that happens to match).  Also, the
names of the author may have more than three SP separated tokens
("git blame -L242,+1 cf6de18aabf7 Documentation/SubmittingPatches"
gives an example).  The existing "grep -E | cut" pipeline is a bit
too loose on these two points.

While they can be assumed on the test data, it is not so hard to
use the right pattern from the documented format, so let's do so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4203-mailmap.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git c/t/t4203-mailmap.sh i/t/t4203-mailmap.sh
index 89cb300f28..d4a6e73736 100755
--- c/t/t4203-mailmap.sh
+++ i/t/t4203-mailmap.sh
@@ -739,11 +739,11 @@ test_expect_success 'Blame --porcelain output (comp=
lex mapping)' '
 	EOF
=20
 	git blame --porcelain one >actual.blame &&
-	grep -E \
-		-e "[0-9]+ [0-9]+ [0-9]+$" \
-		-e "^author .*$" \
-		actual.blame >actual.grep &&
-	cut -d " " -f2-4 <actual.grep >actual.fuzz &&
+
+	NUM=3D"[0-9][0-9]*" &&
+	sed -n <actual.blame >actual.fuzz \
+		-e "s/^author //p" \
+		-e "s/^$OID_REGEX \\($NUM $NUM $NUM\\)$/\\1/p"  &&
 	test_cmp expect actual.fuzz
 '
=20

