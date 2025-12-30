Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E2C1D5147
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767109070; cv=none; b=jNvsruBXtkbXxJkUk6GofaHvnGpy4k9GHs1nW2VdsPYaeJ66yMKW6hfpFFFEaIlWeZrAQSh+hj4zpVrSRyB/DgEOZw+PaWig95F0LhoFX+iy2VKxm0Y35zz+JhDKnHJQ53faolJxtE/0BTjvpHarvTlIaA8ZJ+2uaUVY+DVXf+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767109070; c=relaxed/simple;
	bh=+gb9rfEAB3gS3/gyry94Dq9zmFtICyHjCCkEiFuTe04=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n/lHDfLtB9lA+TkHj/MzTiQAaRiSCUHwqdWe2KYiHCwEoUkfBYZ0m4q1kEe1t2M+k3xz0X2F49pBo/yjSWxjp7PLo97HvSWrYQbSXAyRc6zd4gzRkNykNOUa5/GTCJqmha/FrvbGp9svMEPiSiAV2GO6RFu8gmxUkUSLhAaoypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NH8Ns7Hm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QvWJWyOY; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NH8Ns7Hm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QvWJWyOY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8F8047A0085;
	Tue, 30 Dec 2025 10:37:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 30 Dec 2025 10:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767109067; x=1767195467; bh=Ux8Z1Dh6ox
	ydS1TgWW0uFK3UFj7wW/MlyznwXybvhSg=; b=NH8Ns7HmEKe9DPMrJsC4aH9gFZ
	LVRF9Ka/W7e2oqrnGlzuv68nbGIhbykq6LsVcBEg0YEseS5GVLzYWxZMf1xBAsZL
	H8zmE51rLQ9hGAdmAJnzYSkqs9NMdNkE5V+tOvARepU6nhegF5vQh6GV78ph5l21
	qq3UVFd2W5XVUaK7fCi2v4t51YP+3mLUVAdFH67Az2Dejft2ksssPvHnFYrAlrmJ
	YhIXW51mfBkrh1zBp13//UNFjjZegnhXq2o2NtU+tjPEmkO3Ya5lwZsmYUB5pwH4
	JnYtB/ez17sTcieguxcyhH9Fq11B04QJ3vu41mGkGUpZqbv5Xe1qEzrzX53g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767109067; x=1767195467; bh=Ux8Z1Dh6oxydS1TgWW0uFK3UFj7wW/Mlyzn
	wXybvhSg=; b=QvWJWyOY9xyMMOu26kbn1RgPXhX86L3CEpmOFF5p3MsCBrrQ3EF
	GexW4DAfh9shtjdwvWFz7V5rM4r5CiVJC0Fej2Q9/vNK/bt4AQbMb4oEAmdn9K0o
	Rgj+jAqRjo7BalFH0cFXc6Fp8Fszn4h4piWrB8wHxGPehmuC9rNyswbcFnMbb1hW
	wjNtL7EE++o7uItbwllyJ2n4ZQf4hfJ/Tsf3wDs7Dk4wJANXCZzLtVz8GMLfNlt3
	zsBdRFGi+OMY/mCpxARfei0maiaHNEm7QzZWeUoUnXupUk8Cnr/oWdykmVi/En/b
	t0MHR/3Zn9uS8fVWDsEQ0X6kiCe5d7H0dtg==
X-ME-Sender: <xms:y_FTacEHyqjv7ORPxNgWkWJOQTHg51Odegh7mkxagAqPJozJn0VzhQ>
    <xme:y_FTacVzF0ixae2Pflz4HTGY4AgqOi4jUkTD2c_BZrcIgN-i9FkHYDhJg5EDmJEFZ
    KxzfPXznUOjFgvPxqZCy6gn1s14k9in1NGJ3AruTZiYoSiwVw>
X-ME-Received: <xmr:y_FTabJWhcGi_CB8KhHxk64iiDSxb7RWxva4fj3N665SAPwiN5wKN6aIz8xntf9rU-6jSkFF-o-WlvEEcD1tN_k9XGzgF8tsPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektdegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhhuhgssehprghulhhishgrghgvvghkrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:y_FTac_j4VL_VOiN1a0AWMMJssnkFbZBb1R7F86NPqN8QAfSzzYxwQ>
    <xmx:y_FTaeIu724sS4lNVZZ4srOWlFLCqVsjbRhZonJrKdW1n9sgUn7A9Q>
    <xmx:y_FTaRlQ5KJhMyV6UWan6vW4-_bTZmSc7Kjp5A4Ygsekj2O-g5PLRw>
    <xmx:y_FTaSOkI4jsEUkYgWGmrE8oNzBO6OZrPGGoKdTr5_2tFz4NWk3d_g>
    <xmx:y_FTaXImmm6OrDfL2mzeDeYCEOFL58tE4kXSTTYkJWXcd7e7ZcGmKNUr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 10:37:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v2] fsmonitor: implement filesystem change listener for
 Linux
In-Reply-To: <pull.2147.v2.git.git.1767096494372.gitgitgadget@gmail.com> (Paul
	Tarjan via GitGitGadget's message of "Tue, 30 Dec 2025 12:08:14
	+0000")
References: <pull.2147.git.git.1767082450088.gitgitgadget@gmail.com>
	<pull.2147.v2.git.git.1767096494372.gitgitgadget@gmail.com>
Date: Wed, 31 Dec 2025 00:37:45 +0900
Message-ID: <xmqq5x9of0ae.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thanks for a quick turnaround, but it would be more efficient if you
hunted all the leaks yourself, instead of getting a report for one
issue and updating the patch to fix that one issue.

Here is what I am getting these:

    $ make SANITIZE=address CC=clang && cd t && sh t7527-*.sh -i -v

Note that "-i" is to say "stop at the first one".


expecting success of 7527.12 'create some files':
        test_when_finished clean_up_repo_and_stop_daemon &&

        start_daemon --tf "$PWD/.git/trace" &&

        create_files &&

        test-tool fsmonitor-client query --token 0 &&

        grep "^event: dir1/new$" .git/trace &&
        grep "^event: dir2/new$" .git/trace &&
        grep "^event: new$"      .git/trace

fsmonitor-daemon is watching '/home/gitster/w/git.git/t/trash directory.t7527-builtin-fsmonitor'
builtin:0.1039108.20251230T123036.129805Z:0/event: dir1/new
event: dir1/new
event: dir2/new
event: dir2/new
event: new
event: new
HEAD is now at 1d1edcb initial
Removing dir1/new
Removing dir2/new
Removing new
not ok 12 - create some files
#
#               test_when_finished clean_up_repo_and_stop_daemon &&
#
#               start_daemon --tf "$PWD/.git/trace" &&
#
#               create_files &&
#
#               test-tool fsmonitor-client query --token 0 &&
#
#               grep "^event: dir1/new$" .git/trace &&
#               grep "^event: dir2/new$" .git/trace &&
#               grep "^event: new$"      .git/trace
#
1..12

=================================================================
==git==1039073==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 40 byte(s) in 1 object(s) allocated from:
    #0 0x55c18d8d4042 in calloc (git+0x8c042) (BuildId: 4097db008a82663ae0b3398128a7ab4e09bbdd21)
    #1 0x55c18dc10f14 in xcalloc wrapper.c:154:8
    #2 0x55c18d945f72 in kh_init_str builtin/fsmonitor--daemon.c:656:1
    #3 0x55c18d945828 in do_handle_client builtin/fsmonitor--daemon.c:871:10
    #4 0x55c18d945191 in handle_client builtin/fsmonitor--daemon.c:987:11
    #5 0x55c18dc283e2 in worker_thread__do_io compat/simple-ipc/ipc-unix-socket.c:532:9
    #6 0x55c18dc27a7f in worker_thread_proc compat/simple-ipc/ipc-unix-socket.c:606:9
    #7 0x55c18d8d64f4 in void* ThreadStartFunc<false>(void*) lsan_interceptors.cpp.o
    #8 0x7fe358257b7a in start_thread nptl/pthread_create.c:448:8
    #9 0x7fe3582d57b7 in __GI___clone3 misc/../sysdeps/unix/sysv/linux/x86_64/clone3.S:78
