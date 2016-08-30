Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9C0B1F859
	for <e@80x24.org>; Tue, 30 Aug 2016 11:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758084AbcH3LmE (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 07:42:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35360 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756753AbcH3LmD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 07:42:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so2753161wmg.2
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 04:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wvViXJssEJvWsobfQa8s+wsyWPIF9RCnce4p0GasGtQ=;
        b=NFMKbDz+ac3AAXYjoH7pUoBc9thrJWMT3E1Ig4aZV6BqPAPnkSUyf73U1zXzhaRlzX
         QtCAYrhJCxWEVrf5LS5UnB4eMm8H+QHhpTYE6ptUI9incSD8vCsExTrbGcTTspK3XW6N
         9C3UPZWGe1USC6n/cddce/Qp4G8Xvv+NkbDGwQxTQkL6Py9HtS2+HZ8x1Ebsx/cgMTXK
         HjqM6jiz3S23yJQA1Vyo1QceoYeNgZNABYqmBO6rD5/BJZ/twiqlz//oRT4QzQG8hyo6
         32cLBNioLAxbRAcHPzZeTtX+qYNivSyomKY9BPL43uYDeFJzbgaS1vj8SdfLs4u4QnLR
         dRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wvViXJssEJvWsobfQa8s+wsyWPIF9RCnce4p0GasGtQ=;
        b=Jzn6G1r4IL42erwN2VdTZ7/u0Errvqgq7mcbwbpF4DffH+tBP4dJH5iTryiaxlL49b
         PxjaYUoHHItBSREIKYEN6A4zc3e29pZtIq7e7/3vHcQuhbPSMZm+Q9xHHuqy5L5Ne4Jd
         pDsvTLnfgRXL5c2vnV+FxCMd4pWSC7/0rSSw8JiXiLvm/rQkSAEZuxBkuQGaBCDl2wc5
         6bMOQbNa3NUASxHPtcbZFX4kokokPEI/jetCb9R4kcn2e9bSjr9GhKCQYWaW1OMiyVAF
         tX66ml74l4x43+izv63q1Mo4Qj9lL2wc9/FC/n4QvY81QAtl3NsS42150jfPQE8Pg46S
         L8Rw==
X-Gm-Message-State: AE9vXwPou2LvZbIZTS16V3bAIK922pqvy2eXGO6xyKnwB8AeJ4OFCmGZyqcgtw942IN2Cg==
X-Received: by 10.194.75.198 with SMTP id e6mr3093599wjw.31.1472557321755;
        Tue, 30 Aug 2016 04:42:01 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id m81sm18312197wmf.1.2016.08.30.04.42.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Aug 2016 04:42:01 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 10/13] convert: generate large test files only once
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq7fazcvsk.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 30 Aug 2016 13:41:59 +0200
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        sbeller@google.com, Johannes.Schindelin@gmx.de, jnareb@gmail.com,
        mlbright@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F976C223-0CF3-43FB-ABF2-FFE7C600138E@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com> <20160825110752.31581-11-larsxschneider@gmail.com> <xmqq7fazcvsk.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 29 Aug 2016, at 19:46, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> larsxschneider@gmail.com writes:
>=20
>> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
>> index 7b45136..34c8eb9 100755
>> --- a/t/t0021-conversion.sh
>> +++ b/t/t0021-conversion.sh
>> @@ -4,6 +4,15 @@ test_description=3D'blob conversion via =
gitattributes'
>>=20
>> . ./test-lib.sh
>>=20
>> +if test_have_prereq EXPENSIVE
>> +then
>> +	T0021_LARGE_FILE_SIZE=3D2048
>> +	T0021_LARGISH_FILE_SIZE=3D100
>> +else
>> +	T0021_LARGE_FILE_SIZE=3D30
>> +	T0021_LARGISH_FILE_SIZE=3D2
>> +fi
>=20
> Minor: do we need T0021_ prefix?  What are you trying to avoid
> collisions with?

Not necessary. I'll remove the prefix.


>> +	git checkout -- test test.t test.i &&
>> +
>> +	mkdir generated-test-data &&
>> +	for i in $(test_seq 1 $T0021_LARGE_FILE_SIZE)
>> +	do
>> +		RANDOM_STRING=3D"$(test-genrandom end $i | tr -dc =
"A-Za-z0-9" )"
>> +		ROT_RANDOM_STRING=3D"$(echo $RANDOM_STRING | ./rot13.sh =
)"
>=20
> In earlier iteration of loop with lower $i, what guarantees that
> some bytes survive "tr -dc"?

Nothing really, good catch! The seed "end" produces as first character =
always a=20
"S" which would survive "tr -dc". However, that is clunky. I will always =
set "1"
as first character in $RANDOM_STRING to mitigate the problem.

>=20
>> +		# Generate 1MB of empty data and 100 bytes of random =
characters
>=20
> 100 bytes?  It seems to me that you are giving 1MB and then $i-byte
> or less (which sometimes can be zero) of random string.

Outdated comment. Will fix!

>=20
>> +		# printf "$(test-genrandom start $i)"
>> +		printf "%1048576d" 1 >>generated-test-data/large.file &&
>> +		printf "$RANDOM_STRING" >>generated-test-data/large.file =
&&
>> +		printf "%1048576d" 1 =
>>generated-test-data/large.file.rot13 &&
>> +		printf "$ROT_RANDOM_STRING" =
>>generated-test-data/large.file.rot13 &&
>> +
>> +		if test $i =3D $T0021_LARGISH_FILE_SIZE
>> +		then
>> +			cat generated-test-data/large.file =
>generated-test-data/largish.file &&
>> +			cat generated-test-data/large.file.rot13 =
>generated-test-data/largish.file.rot13
>> +		fi
>> +	done
>=20
> This "now we are done with the loop, so copy them to the second
> pair" needs to be in the loop?  Shouldn't it come after 'done'?

No, it does not need to be in the loop. I think I could do this
after the loop instead:

head -c $((1048576*$T0021_LARGISH_FILE_SIZE)) =
generated-test-data/large.file >generated-test-data/largish.file


> I do not quite get the point of this complexity.  You are using
> exactly the same seed "end" every time, so in the first round you
> have 1M of SP, letter '1', letter 'S' (from the genrandom), then
> in the second round you have 1M of SP, letter '1', letter 'S' and
> letter 'p' (the last two from the genrandom), and go on.  Is it
> significant for the purpose of your test that the cruft inserted
> between the repetition of 1M of SP gets longer by one byte but they
> all share the same prefix (e.g. "1S", "1Sp", "1SpZ", "1SpZT",
> ... are what you insert between a large run of spaces)?

The pktline packets have a constant size. If the cruft between 1M of SP=20=

has a constant size as well then the generated packets for the test data
would repeat themselves. That's why I increased the length after every =
1M
of SP.

However, I realized that this test complexity is not necessary. I'll
simplify it in the next round.

Thanks,
Lars=
