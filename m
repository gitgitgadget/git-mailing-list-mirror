Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5646018A6C5
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298102; cv=none; b=diJY18asB87mzhj9WbnMm2MHzhI37BDUh7lNuHTvFBeiHQOHfU3BTfzQ+hoAYY5Fqeu+rh2kRoKZRUsgWK2zDvcD3ucpieKjVX5/uiNbK7gJv+ylt7tEJsGDNANpa2jBBcLT7tiRne/OBmdaIAPlArnUWmzVXtDfMvt51PwEMH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298102; c=relaxed/simple;
	bh=mw8LpD2n7xiVwZKYZUvVN/Pm5O82km1zmhuHqJvxoVA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IyKpmaKo4Di7DaGyL0MhY8njhcTOVLosc7SZ8RNWsvZGE6rjRORA952TqltHz1Gmolje5mC3gfJBKVZSnjk/hvwAC+8qr0udCL8LTOlIf/vMJbPSga9Pu4vDqZxEuT6v7hFv1W9vGF47ukOGdXzADYMrZVdG2sufW21/vWOOgjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rVzUqDNb; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rVzUqDNb"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4A54F1140207;
	Wed,  4 Dec 2024 02:41:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 04 Dec 2024 02:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733298098; x=1733384498; bh=RQ6rM0HcsbOqELP58AB+7OzrEMzNJj1Q7sR
	a1KFnEZ4=; b=rVzUqDNbisdPFtLBH0jBkrwJDzE3f3SwVJ5e5yGm8zb9XS7j75y
	vPakyKMtEf+LJm0+2K4zvuNXhY89st305Ll/j+58BEtGIij+m0iudck4Jz8B4IGA
	/itUY04oGUiuQ1qRKXC7DE+2dj/Avp2XfArYo2p49YoB6zNfZs4JLStSceF/elmP
	u+gnCl4Uv9Z4G/YFFp8qjaVYvPRsk4A1v4SPomND0VIE1LBrNd2bbqWA058yLy+Z
	eOuSefJbP8amtVW87d77BJAhEXxSi+E2dCtYz4njXURvPnBBypy9ZmZnqO3hUU7o
	sczJC7W2XagSYO1dQYsvfpBIC2F5N4xZLlw==
X-ME-Sender: <xms:sgdQZwjBhZiuzWyTrMX2KsTnjU00rbGck06IgYBxjp9znAXlK-Mw4A>
    <xme:sgdQZ5B8tkd5rYnhpLsHRTyqgAq_D6M8lu11iqvBi606Wd-mQlrVf2cZYo36sWX-4
    vbM9GCSo-86GVghfw>
X-ME-Received: <xmr:sgdQZ4HBvCi1j1Bxdq8wwEvMQmmtvwFhhuF8dG7qfqmSS7vAd9fvruHIHZRELxQOcNVyE33QVw8KhrkgvXR2u_I8Z3-ZkBLlpXqaam0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:sgdQZxS2B3TILVLZNPSByJWkoZYPH81yrVy1y91KhMkiznicLQI1Ww>
    <xmx:sgdQZ9xCksNosdljsm-PfUJsAndz-3urfNbrwTTUHaO88qXpt5Dyig>
    <xmx:sgdQZ_67Dpn_TNnIxeu8JheJ9a83VR2kp1c2yFw4qKVimwfXOkKl5Q>
    <xmx:sgdQZ6zQ8WwtqXoamGoQg-GNihgJwaZ-0_fiBP9_evuh6QsfQXDhYA>
    <xmx:sgdQZ_tIlI2_6VDtrUYOBqbJjArr2OnRc7RRX9zflM_T-rW8gqk78n55>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Dec 2024 02:41:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] strvec: `strvec_splice()` to a statically
 initialized vector
In-Reply-To: <5bea9f20-eb0d-409d-8f37-f20697d6ce14@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Tue, 3 Dec 2024 20:47:43 +0100")
References: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>
	<5bea9f20-eb0d-409d-8f37-f20697d6ce14@gmail.com>
Date: Wed, 04 Dec 2024 16:41:36 +0900
Message-ID: <xmqqwmgf3nf3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

This is queued as rj/strvec-splice-fix, and t/unit-tests/bin/unit-tests
dies of leaks under leak-check.



$ t/unit-tests/bin/unit-tests
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
==5178==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 192 byte(s) in 1 object(s) allocated from:
    #0 0x5600496ec825 in __interceptor_realloc (/usr/local/google/home/jch/w/git.git/t/unit-tests/bin/unit-tests+0x67825) (BuildId: 6efbef9c6f87bfa879e770b463031b396d4d5efe)
    #1 0x56004973b4cd in xrealloc /usr/local/google/home/jch/w/git.git/wrapper.c:140:8
    #2 0x560049714c6f in strvec_splice /usr/local/google/home/jch/w/git.git/strvec.c:67:3
    #3 0x5600496f0c1d in test_strvec__splice_just_initialized_strvec /usr/local/google/home/jch/w/git.git/t/unit-tests/strvec.c:96:2
    #4 0x5600496f627b in clar_run_test /usr/local/google/home/jch/w/git.git/t/unit-tests/clar/clar.c:315:3
    #5 0x5600496f46fa in clar_run_suite /usr/local/google/home/jch/w/git.git/t/unit-tests/clar/clar.c:412:3
    #6 0x5600496f43e1 in clar_test_run /usr/local/google/home/jch/w/git.git/t/unit-tests/clar/clar.c:608:4
    #7 0x5600496f4bdf in clar_test /usr/local/google/home/jch/w/git.git/t/unit-tests/clar/clar.c:651:11
    #8 0x5600496f787c in cmd_main /usr/local/google/home/jch/w/git.git/t/unit-tests/unit-test.c:42:8
    #9 0x5600496f793a in main /usr/local/google/home/jch/w/git.git/common-main.c:9:11
    #10 0x7f59ea91dc89 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16

Direct leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x5600496ec640 in __interceptor_calloc (/usr/local/google/home/jch/w/git.git/t/unit-tests/bin/unit-tests+0x67640) (BuildId: 6efbef9c6f87bfa879e770b463031b396d4d5efe)
    #1 0x5600496f4cee in clar__fail /usr/local/google/home/jch/w/git.git/t/unit-tests/clar/clar.c:687:15
    #2 0x5600496f5f25 in clar__assert_equal /usr/local/google/home/jch/w/git.git/t/unit-tests/clar/clar.c:844:3
    #3 0x5600496f0db6 in test_strvec__splice_just_initialized_strvec /usr/local/google/home/jch/w/git.git/t/unit-tests/strvec.c:97:2
    #4 0x5600496f627b in clar_run_test /usr/local/google/home/jch/w/git.git/t/unit-tests/clar/clar.c:315:3
    #5 0x5600496f46fa in clar_run_suite /usr/local/google/home/jch/w/git.git/t/unit-tests/clar/clar.c:412:3
    #6 0x5600496f43e1 in clar_test_run /usr/local/google/home/jch/w/git.git/t/unit-tests/clar/clar.c:608:4
    #7 0x5600496f4bdf in clar_test /usr/local/google/home/jch/w/git.git/t/unit-tests/clar/clar.c:651:11
    #8 0x5600496f787c in cmd_main /usr/local/google/home/jch/w/git.git/t/unit-tests/unit-test.c:42:8
    #9 0x5600496f793a in main /usr/local/google/home/jch/w/git.git/common-main.c:9:11
    #10 0x7f59ea91dc89 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16

Indirect leak of 18 byte(s) in 1 object(s) allocated from:
    #0 0x5600496ec3c6 in __interceptor_malloc (/usr/local/google/home/jch/w/git.git/t/unit-tests/bin/unit-tests+0x673c6) (BuildId: 6efbef9c6f87bfa879e770b463031b396d4d5efe)
    #1 0x7f59ea9964f9 in strdup string/strdup.c:42:15
    #2 0x296c6c756e28271f  (<unknown module>)

Indirect leak of 4 byte(s) in 1 object(s) allocated from:
    #0 0x5600496ec3c6 in __interceptor_malloc (/usr/local/google/home/jch/w/git.git/t/unit-tests/bin/unit-tests+0x673c6) (BuildId: 6efbef9c6f87bfa879e770b463031b396d4d5efe)
    #1 0x7f59ea9964f9 in strdup string/strdup.c:42:15

SUMMARY: LeakSanitizer: 262 byte(s) leaked in 4 allocation(s).
