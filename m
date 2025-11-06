Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637542EC095
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 10:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426453; cv=none; b=jiBQMfQ/9gw3hfkl830CCEHv63TzdoX0p5hYlYo3gJtTsVd/+zVAIB0HCQWki1BX6cRsN3evuI54I4SFRKy8KEjlgFyA0HSZ1oiU4maGWoZRNYx0+DPMHXa7NpbdcaYcreH0r5F2NjcI1N0eSQEAF+So1ftqjKBk3qY8skET+B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426453; c=relaxed/simple;
	bh=2zwUiNZCcVeTZ7MsGgRoeld8QzJW6Wl343mXqq1Cfxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mG6nxIP+3GY8mGXctUV02FjlhuzNIFyWv5s18uHC8eXmZIsZoUrGA9ErADcYbOftLC1wYRLc8KwMbDT+NSmlmPu4dGqqK+jNnkuCFwKSRaTX8frvTCWRD/7kv2besjDCBNfye3IQ1mHdGFWKnww+qEVqnsX/XDMfgFaK8svhU6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KrPitwUp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GXKxoM5N; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KrPitwUp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GXKxoM5N"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5E34814001B0;
	Thu,  6 Nov 2025 05:54:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 06 Nov 2025 05:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762426450; x=1762512850; bh=BJuSezuqCj
	PICEQqJmvASRYDj8YCjWS1VWdZ9zJK49o=; b=KrPitwUpX7fRsJpTFwHBxhiAl/
	VihAMjNepfj1Stm3mXt/SHhxWVAzhieANChqaJyRCuW+4q6kcwzuKQhfZDy3iNLO
	HxchY9y2t+sKxSHjqETIY+8jySP7FAMIgGCDFtxSUDbrO5DKPQF8rnrL/BcFKvw3
	MbyqlnNaTp9uWwmNobwy4riaxe9SrB3nEDu/Knwm+e7yOjek9kaZVVNuxGU2kvhy
	v79JnyKeqcfiBschSJTgZgKye092QWf1ra1gyarPni8/S96g9kTBta859PZuXbWm
	x9hnp1D12je9noBvufy/Xw50lohv2fsKS7a5UEygQ5O3NuyXrV1UxiA8qszw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762426450; x=1762512850; bh=BJuSezuqCjPICEQqJmvASRYDj8YCjWS1VWd
	Z9zJK49o=; b=GXKxoM5NguGhP0tTMY4fBIi+66PHirvvAyJBg8cl+uzpSNsJqDU
	GFe/3O1Ma1X6psPUsm/FsqF6G43XCK5FwhQb8y31LTE3aQgUA/rhZd+3thmEt32D
	VKwNDOYtoW0N04XZ/nNd8ovOCCso1CKPFZs1Z4FeUSDVBjX+Ndqw8IO1vJF01x6O
	eor7A8SElEbIt6kr/GE7uPrYXQ6/I+q+FHalPh7qrJK/vr7A6eNeLpS6w3mg5/M0
	7vlmsdqB7UAtxunSm9K2Kkv3wkVamt1as2+1i6meg9ATNXA1A1+iW+POa7IaUcQ1
	OtNMCBTyxYDtf/Wh4QRupIaZnKB+zS+duwQ==
X-ME-Sender: <xms:UX4MafhSfkB4mVrniQ8znl8fLVzf1eT6azCaNlSKx3c6zLo2gU-kWQ>
    <xme:UX4MaZ0xFFqdlVZMsR8KVJGB788su3nCEX9K1tE6C0IZz7klMVeQU5-o04HQ_LUwb
    7XlHO9ur4gLGTcYWCCimyJIIU6C9KDsMCRYBKuZ3NKY7dejN6a8nw>
X-ME-Received: <xmr:UX4MaZhjKQ-3FSqEuUqYD1uTJPuQ8yDRlzJ6tjQqq5EtnmeYvxx1mvnp-OW4ELMWC__iv_n3sUu_6JFRA291sZHKPqDn5HnNFit0l92eOU0b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeiheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesughinhifohhoughivgdrohhrghdprhgtphhtthhopehrrghmshgrhiesrh
    grmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:UX4MaZdF0JJPEWsk9I2nEJ0FAC8iVHNrYe0ui1A16i9DT8lsyQf_TQ>
    <xmx:UX4MacleUkKVT7RbMLxe4WPRUEPMyLHrjzt17ojcElYP2WWhrEhPgA>
    <xmx:UX4MaSvYswiy4EXlpzs3BEFwdO_oGgOiBP5UP5uYGNJKhqwMr-HpTw>
    <xmx:UX4MaS8_gH08m6QuM8T0lJYSquLl0QPaWam2C7pnyrujvJxp-o2rVQ>
    <xmx:Un4MaTcHW-JQPt7Yi_8DFJTv8RxY2anV14AaqSLQAOT8zDbK3QiCJWO->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 05:54:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 808bb246 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 6 Nov 2025 10:54:07 +0000 (UTC)
Date: Thu, 6 Nov 2025 11:53:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: v2.52.0-rc0 test failure on cygwin
Message-ID: <aQx-RnNX28BPU2cS@pks.im>
References: <f22c95ad-43c8-41de-8315-e707224e830b@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f22c95ad-43c8-41de-8315-e707224e830b@ramsayjones.plus.com>

On Tue, Nov 04, 2025 at 11:49:46PM +0000, Ramsay Jones wrote:
> Just a quick heads up: the rc0 build on cygwin has a flaky test, thus:
>   
>   $ tail test-out-2-52-rc0 
>   Test Summary Report
>   -------------------
>   t0610-reftable-basics.sh                         (Wstat: 256 (exited 1) Tests: 90 Failed: 1)
>     Failed test:  29
>     Non-zero exit status: 1
>   Files=1024, Tests=32232, 2703 wallclock secs (23.38 usr 60.53 sys + 7886.88 cusr 10419.88 csys = 18390.67 CPU)
>   Result: FAIL
>   make[1]: *** [Makefile:78: prove] Error 1
>   make[1]: Leaving directory '/home/ramsay/git/t'
>   make: *** [Makefile:3327: test] Error 2
>   $ 
>  
> Initially, while investigating the failure, I was running the test by hand and it
> didn't fail ... So, I tried a stess test, like so: 

Interesting. My first hunch is that the root cause is auto-maintenance.
git-maintenance(1) spawns `git pack-refs --auto`, and that process will
open the stack so that it can verify whether it needs to be packed or
not. And Windows being Windows, the file being open may mean that it
cannot be written by another process at the same point in time.

In any case, I was able to reproduce the issue. But disabling auto
maintenance with the following patch does not fix the flake.

diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 3ea5d51532..52bbf4fe57 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -204,6 +204,7 @@ test_expect_success 'ref transaction: corrupted tables cause failure' '
 	git init repo &&
 	(
 		cd repo &&
+		git config set maintenance.auto false &&
 		test_commit file1 &&
 		for f in .git/reftable/*.ref
 		do

And I guess that makes sense? I'd assume that Cygwin already knows to
open files with POSIX semantics, so it should be possible to write to
the file even if it was held open by another Git process.

[snip]
> So, not really an answer, but I have noted several times over the years
> that cygwin seems to delay setting some file attributes until after the
> process has exited ... [yeah, I don't see how either! ;) ].

What? That's horrible if true. How doesn't this cause more issues?

I wonder whether the issue is surfaced because we use the shell to
truncate the file. If you instead use `file-tool truncate 0` for example
then I cannot reproduce the flake anymore:

diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 3ea5d51532..1058f83993 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -207,7 +207,7 @@ test_expect_success 'ref transaction: corrupted tables cause failure' '
 		test_commit file1 &&
 		for f in .git/reftable/*.ref
 		do
-			: >"$f" || return 1
+			test-tool truncate "$f" 0 || return 1
 		done &&
 		test_must_fail git update-ref refs/heads/main HEAD
 	)

But this may very well just be due to timing again -- spawning the
process will be slower than using shell redirection to trim the file.

All of this is quite curious. I don't really have any better idea than
to use something like the above patch. It's ugly, doubly so because I
don't understand either the root cause nor why the patch properly fixes
it. So I'd be grateful if anyone were to enlighten me :)

> I noted the above last night and, unfortunately, I haven't had any
> time to look into this tonight. (hopefully tomorrow).
> 
> [I haven't tried bisecting because, well ... flaky test! ;) ]

I have verified that the flake already exists in Git 2.51, so at least
it's not a regression in the current release cycle.

Thanks!

Patrick
