Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76594FC0E
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 01:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733709385; cv=none; b=SU7zrMT/CsgdOFtSyJiWeje1lbp9VorAzjm3fnDWcAdHLkeKBIGXU7noDtigWBVy58oxMFhxIek+SSd9+NTkB3W2h054x86OCsjD6UWVE5cM7h9oRxeODosDd0uGBIwnt9IdmfzR3GxMzGZuzu2/9hfr9c5Kv5XqoGcrFWDxvvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733709385; c=relaxed/simple;
	bh=cqtT9FImnPbvrk/YX/BBfyRIs3Al6GzBMpnL/j7fhZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bHT48FjfTdbbtUet852FSKnW+Hlg6bicuaTfvJF0aHa3Gt/k/RNBqwyKb21XjZrhWmcpNJXxJrUca+GZGbtwaZVxGh/HyL1iBdoNXfSm556hWFqGyXFxwq+s8+qUSZ3MDo2fRH2pp1U9N9XB0utU325bCw5OPLGsWPMQKrdrZ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HdOVEcT3; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HdOVEcT3"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5CF441383707;
	Sun,  8 Dec 2024 20:56:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 08 Dec 2024 20:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733709382; x=
	1733795782; bh=jy9ej73jHU0BleUiSVd+lQ7SHDxE3TRxInIsIegfQ94=; b=H
	dOVEcT3ALiBz0Dbu+V7c+Dw3w4ey5awma711NLToP/iBOcuAnsyNQKOTX/1y3aMP
	iGPN8gRjiIIkdD9lQO10FbOFqG5ZhTKnE9GHCfFKYRSsBhFPetdbnKW91PmkZk1X
	bN1U7aTAfLRxuBTUq2PblMr7NifSj8+gQ6s5yFNuicmzkKPwMzdOzh5KIh0Op8eB
	YHaVQCxqERlYxHfx/GKhfyckHQNoT6L+KrNxninj9BvcXMGkEv1Ukv8N4IP9bGNq
	aUgTGX7j56/tRPb+jBlXvnnOqFoAwY2Q5jL4dMksHv1rTtw63yVpwQ5vpp/JIkmN
	vqIyNiOMoLAuQ8YCkErgg==
X-ME-Sender: <xms:Rk5WZwCGV1rhSXUqeEp479Hp1H0-6zhEd2VdWRgfBU6VFWA5wrD4bA>
    <xme:Rk5WZygqnumJx8OIjuAZPxa3eLHIz070HuRAp72VrrEbkZCLxVZ8pGwYu9ZJjjZEj
    IeYEBvA52Nhw3j0XQ>
X-ME-Received: <xmr:Rk5WZzk7eBZA_9pH8ez0_93mNmopsYiYdN48G06WnxlcL0dljdJvwsxQCjc7vV3X6HlPHho7w8djqM1Y56Pp59y_p6RKsfxWtTKvS5Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeeggdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekofdttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepkefgtdeuvdejfffgheeufeeugefhtdejhffg
    kefhhfetieffteehleehtdfghedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:Rk5WZ2zZ1eGRiFLW5Lqvwe5GEA-bDa7UqIE7Wd92eRzm2BDt0V1how>
    <xmx:Rk5WZ1RfOJ2RVziluGyE40Cfvn6C4txK3AfL97BuP0VN3xX0Om8fYg>
    <xmx:Rk5WZxar_NCPZ0zBfEWlBS0LB7SnCEwYuINymQr-IrKoq05gaRaHKg>
    <xmx:Rk5WZ-QtMDyj5ELL0dOVpsw_SzctL5loK4NDeVBRMoCsLgm9N0cd6g>
    <xmx:Rk5WZzMVnEF9kuAyfh19n_GIshp8dbyhEqUH4ZqtqU78N06vYwTDaLl->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Dec 2024 20:56:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] strvec: `strvec_splice()` to a statically
 initialized vector
In-Reply-To: <xmqqttbdprj0.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	09 Dec 2024 10:35:31 +0900")
References: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>
	<5bea9f20-eb0d-409d-8f37-f20697d6ce14@gmail.com>
	<xmqqwmgf3nf3.fsf@gitster.g>
	<c949fea0-817b-45f9-b8b2-55e1cb55e915@gmail.com>
	<4e60eedc-e4d9-423c-b2e7-f1c65bccc254@gmail.com>
	<xmqqser33ga6.fsf@gitster.g> <xmqqy10pprnp.fsf@gitster.g>
	<xmqqttbdprj0.fsf@gitster.g>
Date: Mon, 09 Dec 2024 10:56:20 +0900
Message-ID: <xmqqikrtpqkb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Rubén Justo <rjusto@gmail.com> writes:
>>>
>>>>> ...
>>>>> Sorry.  I'll re-roll later today.
>>>
>>> No need to say "sorry".  Thanks for quickly reacting and starting to
>>> work on it.
>>
>> Any progress?
>>
>> Thanks.
>
> Sorry, you did send and I did queue v3.

... and it seems to be causing problems, I didn't look very deep,
but it looks similar to what I reported for the earlier round.

TAP version 13
# start of suite 1: ctype
ok 1 - ctype::isspace
ok 2 - ctype::isdigit
ok 3 - ctype::isalpha
ok 4 - ctype::isalnum
ok 5 - ctype::is_glob_special
ok 6 - ctype::is_regex_special
ok 7 - ctype::is_pathspec_magic
ok 8 - ctype::isascii
ok 9 - ctype::islower
ok 10 - ctype::isupper
ok 11 - ctype::iscntrl
ok 12 - ctype::ispunct
ok 13 - ctype::isxdigit
ok 14 - ctype::isprint
# start of suite 2: strvec
ok 15 - strvec::init
ok 16 - strvec::dynamic_init
ok 17 - strvec::clear
ok 18 - strvec::push
ok 19 - strvec::pushf
ok 20 - strvec::pushl
ok 21 - strvec::pushv
not ok 22 - strvec::splice_just_initialized_strvec
    ---
    reason: |
      String mismatch: (&vec)->v[i] != expect[i]
      'bar' != '(null)'
    at:
      file: 't/unit-tests/strvec.c'
      line: 97
      function: 'test_strvec__splice_just_initialized_strvec'
    ---
ok 23 - strvec::splice_with_same_size_replacement
ok 24 - strvec::splice_with_smaller_replacement
ok 25 - strvec::splice_with_bigger_replacement
ok 26 - strvec::splice_with_empty_replacement
ok 27 - strvec::splice_with_empty_original
ok 28 - strvec::splice_at_tail
ok 29 - strvec::replace_at_head
ok 30 - strvec::replace_at_tail
ok 31 - strvec::replace_in_between
ok 32 - strvec::replace_with_substring
ok 33 - strvec::remove_at_head
ok 34 - strvec::remove_at_tail
ok 35 - strvec::remove_in_between
ok 36 - strvec::pop_empty_array
ok 37 - strvec::pop_non_empty_array
ok 38 - strvec::split_empty_string
ok 39 - strvec::split_single_item
ok 40 - strvec::split_multiple_items
ok 41 - strvec::split_whitespace_only
ok 42 - strvec::split_multiple_consecutive_whitespaces
ok 43 - strvec::detach

=================================================================
==2199597==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 192 byte(s) in 1 object(s) allocated from:
    #0 0x556696842825 in __interceptor_realloc (/home/gitster/w/git.git/t/unit-tests/bin/unit-tests+0x67825) (BuildId: 408260ac1cf86eb6b93dfb7851633403d20c9aef)
    #1 0x55669691c87d in xrealloc /home/gitster/w/git.git/wrapper.c:137:8
    #2 0x5566968ebd2f in strvec_splice /home/gitster/w/git.git/strvec.c:67:3
    #3 0x556696846c1d in test_strvec__splice_just_initialized_strvec /home/gitster/w/git.git/t/unit-tests/strvec.c:96:2
    #4 0x55669684c1bb in clar_run_test /home/gitster/w/git.git/t/unit-tests/clar/clar.c:307:3
    #5 0x55669684a772 in clar_run_suite /home/gitster/w/git.git/t/unit-tests/clar/clar.c:403:3
    #6 0x55669684a471 in clar_test_run /home/gitster/w/git.git/t/unit-tests/clar/clar.c:598:4
    #7 0x55669684ac2f in clar_test /home/gitster/w/git.git/t/unit-tests/clar/clar.c:642:11
    #8 0x55669684d78c in cmd_main /home/gitster/w/git.git/t/unit-tests/unit-test.c:42:8
    #9 0x55669684d8fd in main /home/gitster/w/git.git/common-main.c:64:11
    #10 0x7f85891ebc89 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16

Direct leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x556696842640 in __interceptor_calloc (/home/gitster/w/git.git/t/unit-tests/bin/unit-tests+0x67640) (BuildId: 408260ac1cf86eb6b93dfb7851633403d20c9aef)
    #1 0x55669684ad3e in clar__fail /home/gitster/w/git.git/t/unit-tests/clar/clar.c:676:29
    #2 0x55669684bf45 in clar__assert_equal /home/gitster/w/git.git/t/unit-tests/clar/clar.c:829:3
    #3 0x556696846db6 in test_strvec__splice_just_initialized_strvec /home/gitster/w/git.git/t/unit-tests/strvec.c:97:2
    #4 0x55669684c1bb in clar_run_test /home/gitster/w/git.git/t/unit-tests/clar/clar.c:307:3
    #5 0x55669684a772 in clar_run_suite /home/gitster/w/git.git/t/unit-tests/clar/clar.c:403:3
    #6 0x55669684a471 in clar_test_run /home/gitster/w/git.git/t/unit-tests/clar/clar.c:598:4
    #7 0x55669684ac2f in clar_test /home/gitster/w/git.git/t/unit-tests/clar/clar.c:642:11
    #8 0x55669684d78c in cmd_main /home/gitster/w/git.git/t/unit-tests/unit-test.c:42:8
    #9 0x55669684d8fd in main /home/gitster/w/git.git/common-main.c:64:11
    #10 0x7f85891ebc89 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16

Indirect leak of 18 byte(s) in 1 object(s) allocated from:
    #0 0x5566968423c6 in __interceptor_malloc (/home/gitster/w/git.git/t/unit-tests/bin/unit-tests+0x673c6) (BuildId: 408260ac1cf86eb6b93dfb7851633403d20c9aef)
    #1 0x7f85892644f9 in strdup string/strdup.c:42:15
    #2 0x296c6c756e28271f  (<unknown module>)

Indirect leak of 4 byte(s) in 1 object(s) allocated from:
    #0 0x5566968423c6 in __interceptor_malloc (/home/gitster/w/git.git/t/unit-tests/bin/unit-tests+0x673c6) (BuildId: 408260ac1cf86eb6b93dfb7851633403d20c9aef)
    #1 0x7f85892644f9 in strdup string/strdup.c:42:15

SUMMARY: LeakSanitizer: 262 byte(s) leaked in 4 allocation(s).
