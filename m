Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222941CF80
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 23:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u+v18hY7"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C941BC2
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 16:49:41 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 552A031A9B;
	Wed,  1 Nov 2023 19:49:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6d80Wu5NzQxwRgpI9wqPqanEWwbfr6YQ4g2qNc
	lP7nQ=; b=u+v18hY7YKxfpDRX1T+mhDWxQv9V1H2Dg/SELL7J44JdtfA1rvxIUw
	JhbayR+cYQ0o8cGLZT3SyYzVaUqgotp/dzUp1X40e22XOrhq4Sg96b9qpneayurL
	qKj3c0p6L5NU+bWE9myZmHWVpzn+jbLflpwMQY1a23Dqusa0QrVqk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4901031A99;
	Wed,  1 Nov 2023 19:49:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CBF7431A96;
	Wed,  1 Nov 2023 19:49:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,  calvinwan@google.com,
  git@vger.kernel.org,  linusa@google.com,  phillip.wood123@gmail.com,
  rsbecker@nexbridge.com
Subject: Re: [PATCH v8 2.5/3] fixup! unit tests: add TAP unit test framework
In-Reply-To: <ZUKQ2eYmfMEhc_gH@google.com> (Josh Steadmon's message of "Wed, 1
	Nov 2023 10:54:33 -0700")
References: <00d3c95a81449bf49c4ce992d862d7a858691840.1696889530.git.steadmon@google.com>
	<20231016134421.21659-1-phillip.wood123@gmail.com>
	<ZUKQ2eYmfMEhc_gH@google.com>
Date: Thu, 02 Nov 2023 08:49:35 +0900
Message-ID: <xmqqedh9owz4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5097151A-7911-11EE-A20E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> On 2023.10.16 14:43, Phillip Wood wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>> 
>> Here are a couple of cleanups for the unit test framework that I
>> noticed.
>> 
>> Update the documentation of the example custom check to reflect the
>> change in return value of test_assert() and mention that
>> checks should be careful when dereferencing pointer arguments.
>> 
>> Also avoid evaluating macro augments twice in check_int() and
>> friends. The global variable test__tmp was introduced to avoid
>> evaluating the arguments to these macros more than once but the macros
>> failed to use it when passing the values being compared to
>> check_int_loc().
>> 
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>  t/unit-tests/test-lib.h | 26 ++++++++++++++++----------
>>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> Applied in v9, thanks!

Thanks for working well together.
