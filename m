Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C682A37F755
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776151413; cv=none; b=IdX8CIZoe3yv2HQo0hf3W5nchQpBV0dYiyJM4tN+/x8w0jk/udXgpTdxSsBSHLy4QEmE01VvzH+EPDOOVG5V1PnBuRhA6YQPyzm1j49IlTq7HQqibBKOTJqOT5Mh4V5aUVBCK2j/u25f6S4p0N8nfq5RGFhvmW0nXaCNfj2oaPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776151413; c=relaxed/simple;
	bh=Fe16mtdEDw/0c2AcwtiA7Jf9mwMxUtDV/HknEDjYY/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/EgFLCpVPvcqSxOLNes386K3ldFILH+0X1G/c9EtYx6B6UIjzr1Hw/Vy2Lm3A3FYnQPg9yh8FmpYfn3DxMLf3FkBgFf0CYd6yKe+9kaFwoMjliSHJFDjZBe0j9bY7OCJwel1+I75WznMExeCaS93W80cKjfoMCNrgC2A5QR1Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UkmFSC2C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wCMmgDc6; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UkmFSC2C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wCMmgDc6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 304B47A00DC;
	Tue, 14 Apr 2026 03:23:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 14 Apr 2026 03:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776151411; x=1776237811; bh=SLWoX8fjl3
	8Om3Pmywh1SVLnUyMHg89ISHwDBGY6d2U=; b=UkmFSC2CNgq81Bujh2auiI0n0Y
	viwq2tJuCu6nXSB1aPRHulATT76JNHoTtOVlVtaZFaauESBKRvr9rdmIRsoPjwAC
	dEH2mYlkfDu1AAafHSWzZVgyJ4lxv+m/5yvncGAewsXMBRPKs9Mgcn1aw+HjHf0V
	effsV0hpUjCow2b5nDqknRaUBgFrKWA7KzOVW4Li6e+XV01N6xQ3B8FraeJKmFQ8
	vUpo7BQjh6xoH2DgDgXNuzJ8DwJpmQK4kGn9YyRpXbjBXKU/W6Q1i9kCYmr9yxry
	PU/sm8F/9bdRSiSxd3+E7ekL6/3P4EwekR//nWNnuUEbdPnpxgNh1/4EtxYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776151411; x=1776237811; bh=SLWoX8fjl38Om3Pmywh1SVLnUyMHg89ISHw
	DBGY6d2U=; b=wCMmgDc67DDsqlxvHypRbZTBcEC65X1k9yx/cRTcjK0iqy5tzVm
	dl5J12snRFEaB5yFgKWY93tuzHCKF7xtcMDI618S/+Xnqkbqka7s2SfNMTRuk9r5
	ycayrA880TZls9ApjAWLQn+nykeo17iV/srkbJGVnDTLwyrZ9pWW8oYvwGSHzT3Z
	DiU1w98f+lboCs7rPjs+caqFqUZ/Q+kF2YQ1vJou7mZv7mXevf1xL+Qwo79ICsTU
	O1KW5273jq5CdICbHjF+UkuIyTJ4FYkoRXqSzV4PkLDiPDcPL4QcjilKQlHkFQM9
	RzY5c821GT1O+0nDT/jpLdmu0lAalZwPVYw==
X-ME-Sender: <xms:cuvdaQzWx7l-MTUacExPbe06rtQN2FvmGozdgNdwcL7wq97lbWg5rQ>
    <xme:cuvdaaSKCDiQMotQNvv5_lpUL2Udro27UzLxatZPVeb1cnhotjvLysci61JUn9Nwt
    a_z8ArFvMFvwbXczicGhapqeShLqWd5q2_aLRmK6IPdtEGnBsVrUw>
X-ME-Received: <xmr:cuvdaf9Vq8Nbn-iG3-h7u56lGt_SnJ80n144h1rGPuUI_SoRQpbVPrQU88nDyPdTxF3J11z4nEPy6-i1qQqSjRAn3vexDhRia-21JSNvLhTbqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegtdehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:cuvdaZoAJdCPsIKhG8zM1rD9DDuOj2J1o45YbFjszd0w8YIZUd8wKA>
    <xmx:c-vdaUkbCuLjVvlK6454UE3wmN9A0K0pGyinPaCnH16if5SyslgRoA>
    <xmx:c-vdaYIftWWYiw1kzpMtW9W0eb1H-TOR7vOHMx2a-_YgANA2aO2GHA>
    <xmx:c-vdaRzp2asd9WWDBLhmyqzRaPGoliySDLGVQRp9ARcFjQLNd2mieA>
    <xmx:c-vdaULa3IEpbgi9Gxe5EW2q4GDYhrHE0c-tjhBAJ6d1QtpoHhfiKho0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 03:23:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 30c98394 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Apr 2026 07:23:30 +0000 (UTC)
Date: Tue, 14 Apr 2026 09:23:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/12] t: prepare `test_match_signal ()` calls for `set
 -e`
Message-ID: <ad3rbjDYad8rTybG@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
 <20260413-b4-pks-tests-with-set-e-v1-1-5b83763a0e84@pks.im>
 <xmqqldeqkesa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldeqkesa.fsf@gitster.g>

On Mon, Apr 13, 2026 at 09:26:13AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > We have a couple of calls to `test_match_signal ()` where we execute a
> > Git command and expect it to die with a specific signal. These calls
> > will essentially execute the process in a subshell via `foo; echo $?`,
> > but as we expect `foo` to fail this will cause the overall subshell to
> > fail once we `set -e`.
> >
> > Fix this issue by using `foo || echo $?` instead.
> 
> Hmph, if the 'foo' command that is expected to fail succeeds by a
> bug, we won't see 0 on the standard output anymore.  Comparing 13
> with 0 or 13 with an empty string "" would fail either way, so that
> may not give us a practical difference, but this somehow leaves a
> foul small in my nose.

Hm, true, it is a wee bit ugly.

> The technique used in <20260325062114.2067946-2-gitster@pobox.com>
> would give us something ugly like
> 
> -	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
> +	OUT=$( ((st=0; large_git || st=$?; echo $st 1>&3) | :) 3>&1 ) &&
> 
> and it ensures that we give 0 when we succeed, but I am not sure if
> this is worth doing.
> 
> Or perhaps
> 
> -	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
> +	OUT=$( ((large_git || echo $? 1>&3) | :) 3>&1 ) &&
> +	OUT=${OUT:-0} &&
> 
> I dunno.
> 
> If "large_git" somehow writes into file descriptor #3, then OUT will
> be contaminated with something other than $?, so the additional "if
> empty substitute with 0" would not work without doing something like
> 
> -	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
> +	OUT=$( ((large_git 3>/dev/null || echo $? 1>&3) | :) 3>&1 ) &&
> +	OUT=${OUT:-0} &&
> 
> I guess.  For that matter, if large_git spits out "13" to its file
> descriptor #3, I do not know what would have happened ;-)

How about the below patch? It's a mouthful, but the intent is quite
explicit and it's overall not too bad, if you ask me.

Patrick

diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index 74c2a27972..84319cf169 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -42,12 +42,12 @@ test_expect_success 'create blob' '
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
-	OUT=$( ((large_git || echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((large_git && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT"
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE even if parent ignores it' '
-	OUT=$( ((trap "" PIPE && large_git || echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((trap "" PIPE && large_git && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT"
 '
 
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 8e68a00dcb..a371ea690e 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -260,7 +260,7 @@ test_expect_success 'choking "git rm" should not let it die with cruft (induce S
 
 test_expect_success !MINGW 'choking "git rm" should not let it die with cruft (induce and check SIGPIPE)' '
 	choke_git_rm_setup &&
-	OUT=$( ((trap "" PIPE && git rm -n "some-file-*" || echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((trap "" PIPE && git rm -n "some-file-*" && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT" &&
 	test_path_is_missing .git/index.lock
 '
