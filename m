Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794953017;
	b=h4hKtaQ+DYxZr9TDkOUKUpdDci1TYCHzx8NH91Tmq6kyGVofXRNaSO6W46ks79Obyirz
	 /PV+L8e0Di8emzK7rfbMc7h7PLtrWct2UVindf3Lo8hH7d0gzXMYUhXU6AJ4YMwXe1D2B
	 xe07CruRtqY078mVP97KXSkuW+8I6bjsAUlcZIX/F3nbRsSEreXscfqwl7IB294GGoYS/
	 qzkhChMbctLPXFwkIzJe10xkKvW+ksBVB876eFxxRFCWR/Nxwt19dZB40CZ5uITZwD9gh
	 xMFYB9D2hZViEOZJcv9R0g6M4GjGdlhMcHwKKW8oSKxd2iw/AY5WecfrbA5MHyBvwyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953017;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=UMvVnstuEHSsv5GuWIjzZb+z3NhXCLJftOU3hOUKzu4=;
	b=CR6f9wiVn2VH2tHb/nkvakEXrE7KSAeIz6F8/CHt3MwEa11j33Ku+W2CPiYnG66hbU9k
	 vTYwpdvRANjZljYI2Ut4EQmgvdYcQeHmeULn2bp5/u89DZMguw5FTa7Wfj/kCEgxKp2H9
	 596cA9gnfSBUZ1R5n1uQcRUsFXZl5taV1i5ZkSENyUHfuya4vvRQV1sVlx8zZI2maZFIc
	 nrB8KP1o4eWAAoqLYcKNWT2RgmcLgk0p1jtPqHHS/1yw9BsVOov36owYY0Ax+WT+WEro5
	 ha0ilVowvABsVvahL50p9FCYIu9w0nDUmEdh8Au4gHk2athe+eFhbk9r9qfFOgpdHlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=M+bm2o8a;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31789606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 22:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31789606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=M+bm2o8a
Received: from localhost (ip-109-41-49-131.web.vodafone.de [109.41.49.131])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AHM3Wdx1850321
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 17 Nov 2026 23:03:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1794953012; bh=UMvVnstuEHSsv5GuWIjzZb+z3NhXCLJftOU3hOUKzu4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=M+bm2o8a3GF1tSU5OaLRZZE4XnCymyGCql6TQek7JHxsaoDSeqXuefuaR4XzuVymp
	 574kkzTnH4TdnAqRSOvqhfxL1WjQbQYl48UZIVd6dZ4lGPbMhfIwXHBnLBRawlg8rC
	 5F0wx4ZVgQwOgUc92PTkL53fI9mrfCNYg4fng6Q4=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] utf8: add display_mode_esc_sequence_len_counted()
In-Reply-To: <xmqqbj7ncexk.fsf@gitster.g>
References: <xmqqmrr7fllq.fsf@gitster.g> <xmqqqzgjcjes.fsf@gitster.g>
	<ghy0arkv39.fsf@gouders.net> <xmqqbj7ncexk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 17 Nov 2026 23:03:31 +0100
Message-ID: <ghtslfkte4.fsf@gouders.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Nov 17 2026, Junio C Hamano wrote:

> Dirk Gouders <dirk@gouders.net> writes:
>
>> You have better knowledge of the users of this function: would an early
>> return perhaps handle a significant amount of cases?
>>
>>         /* The shortest SGR sequence is "\033[m". */
>>         if (len < 3)
>>                 return 0;
>
> Do you have any benchmarks?  I don't.
>
> I find it of dubious performance merit to run this comparison for a
> long string as it is eaten one UTF-8 characters at a time by the
> caller, and when the length is actually shorter than 3, then
> runnning the remainder of the function for a few steps should not be
> 10x more expensive than the above comparison, no?

Meanwhile, I thought: even if the test would be a good idea, the
"\033"-test probably is the one that handles most cases.

Maybe I will look closer, but not now.  Correctness is more important
and I need to work on v2.

>> And, why not add some tests (the untested function I showed had
>> an off-by-one error):
>
> Sounds good.  Should I just steal what you sent out?

That wouldn't be stealing, of course you can use it.

Regards,

Dirk

>> diff --git a/Makefile b/Makefile
>> index 4c84eea6e2..3c8dc9ca40 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1564,6 +1564,7 @@ CLAR_TEST_SUITES += u-strvec
>>  CLAR_TEST_SUITES += u-trailer
>>  CLAR_TEST_SUITES += u-urlmatch-normalization
>>  CLAR_TEST_SUITES += u-utf8-width
>> +CLAR_TEST_SUITES += u-utf8-ansi
>>  CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
>>  CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
>>  CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
>> diff --git a/t/meson.build b/t/meson.build
>> index 1cf1d95f70..e224df58c8 100644
>> --- a/t/meson.build
>> +++ b/t/meson.build
>> @@ -27,6 +27,7 @@ clar_test_suites = [
>>    'unit-tests/u-trailer.c',
>>    'unit-tests/u-urlmatch-normalization.c',
>>    'unit-tests/u-utf8-width.c',
>> +  'unit-tests/u-utf8-ansi.c',
>>  ]
>>  
>>  clar_sources = [
>> diff --git a/t/unit-tests/u-utf8-ansi.c b/t/unit-tests/u-utf8-ansi.c
>> new file mode 100644
>> index 0000000000..c19d8bce78
>> --- /dev/null
>> +++ b/t/unit-tests/u-utf8-ansi.c
>> @@ -0,0 +1,14 @@
>> +#include "unit-test.h"
>> +#include "utf8.h"
>> +#include "strbuf.h"
>> +
>> +/*
>> + * Test len limited functions for ANSI SGR lengths.
>> + */
>> +void test_utf8_ansi__sgr_len(void)
>> +{
>> +	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("\033[m", 2));
>> +	cl_assert_equal_i(3, display_mode_esc_sequence_len_counted("\033[m", 3));
>> +	cl_assert_equal_i(5, display_mode_esc_sequence_len_counted("\033[31m", 5));
>> +	cl_assert_equal_i(7, display_mode_esc_sequence_len_counted("\033[0;31m", 7));
>> +}
>
> Thanks.
