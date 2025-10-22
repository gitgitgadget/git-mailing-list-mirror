Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0AC35B128
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151723; cv=none; b=TMiuFV1Ab/+SIPlD0oFMCt3uipNSEsRBNY9XD/sfLl18KYrt3fqgRxkn++OW/6EeXGcpcBb0t3xn6WavnUOFNEJHQ6YoFB66cpPkXgkwZX5/6aRPmxfRa5p9nIe2bjBi9Pv5EQM524BIaCzQKnNyIuU0EGMo5omlUk/zYV4UevI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151723; c=relaxed/simple;
	bh=uGlLxCJpt0HZ0nu9w0xK2eZi84xpnPY/gN2j9hmXvrc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aoHJk1mTBsXURkbUHzPoaUgPKneaUBk/DuBcsr6UUY5LjntpFIJTAV/nhejhnsgsTqFQHqXM5AhJ5T04ziFOrRSagjv3JOilx9Enif+o96JzXQeYvX0LiBqwQAZCkodfzkrNIMpv+HaqnOEUr5b/pGrd9Kjg8U4E+0bCwyQi2Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hOuJcC8W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=drIlHA5+; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hOuJcC8W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="drIlHA5+"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DBA2314000CC;
	Wed, 22 Oct 2025 12:48:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 22 Oct 2025 12:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761151719; x=1761238119; bh=EoqSb8rxFs
	L2V6yV5JvfI+IsQX6xmawbpZTxSP/yEe4=; b=hOuJcC8WXk2oMOztbN8WdRVIBV
	k1dQvWtmEoTvdv8QqEnovLfGOXtt3YcRAwSdIijNV+Xyo/7Ny0imkCQ1FqiGVvvI
	xyBVuAzzRQUbGY0WCEr3Sy+7rSG0aWATMODxQjf+9zj2sWpZ9OS0wT9e7DiJJx+r
	pQPlhWuNRgDN0QJ+RxZOxmfakCULeLPUCe09nJls//R1jNIRzxZMW2hsYvrdViBv
	scCjf76FrgQqB+J7h0tLvnQ72vT1LyvHG1jKjA+L1z8/Q9xnTPh0v7Ycy1Aks6z7
	VmfJyHVu+JCa6cv/vvcbwPxWBkDM9USC7POD9TRWw+x9fO1uuOyaNyWn6A6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761151719; x=1761238119; bh=EoqSb8rxFsL2V6yV5JvfI+IsQX6xmawbpZT
	xSP/yEe4=; b=drIlHA5+U48cjhxIORjswEc2ntN2vXxjypzljY049k5oVXIFt0R
	KhpvoDWjzL6g7PcbwfAgCWEoIoKxkxOJIT5ws7A984H8BGiHVQiJYiZldUcpOxzs
	hr6C7evceisVxiCG4RemVSmQBHNrB1Fm+CE/Nk9X1ocbFJSMIZf5+taMkUWIeixa
	rYr0DwImyj1+F4UH6XfanyzWA+a/6/nCNpF6EBPFeNPmmdAgytGUBq4kxRUxBOXl
	2kNFgGpUWonyPkTe6z+VbJM64D00Qx7pO1QZaOtc2OCBLujWc7GfANVQs4fcIR3t
	QtC0qtAAq/T9ht9iTbCLB2avRXZXGOGMj8A==
X-ME-Sender: <xms:5wr5aORMON4Aw0pkt_tZ0q2ME2fyJ5sD3RF3S7j8RRfzWj4yoE9ZOg>
    <xme:5wr5aKp7aujQshIbVmVscyng4Zs86ATB99-zYBeqnFP63Up6VPXES9UDeH5PYomUu
    HweSwNxcjAhZdJ-xrVqDOabdbevFfxIcFleNWZS2MHFvSaYCiayfA>
X-ME-Received: <xmr:5wr5aEL2O7DtYmEOIUHjbXFvL5mHqXt3ZcTLJH0grOM_VqtLpeZsSfczMxgLHSEdLIq-TQSNFVTo1s66vzGM7hPB-R5lFsa3akKY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeguddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgfdvffeuffegvddtvedvfffhudeuhffhgffhheeftdeihfehkeelkeegueeh
    fedunecuffhomhgrihhnpeguihhffhdrtghinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehjrghkvgesiihimhhmvghrmhgrnhdrihhopdhr
    tghpthhtohephihlughhohhmvgdvugdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:5wr5aFpQQK_yvGNj0eiNeFSjoZTS_Gkf-MYTfsE0ai2Sq0nQtHDkcA>
    <xmx:5wr5aEzPoLqRgN4WrLz09pIWUdAbUT8TnCjA5-hBDyn-9vWinbyMlg>
    <xmx:5wr5aBPlwvZSXsU8CjPHuPgONExKSYQvRI6N3HMWVMH8XRXevnfY1Q>
    <xmx:5wr5aB7jhyjfEBVuh7IEkDt_X_Yf8SpHFTesCjZ8AlXZPS0xYkn78g>
    <xmx:5wr5aArTyQA27o-DL4NSemOebtbB_cM-FnkjaiKTOJMRTuvXTDiEVZpt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 12:48:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Jake Zimmerman <jake@zimmerman.io>,  Lidong Yan <yldhome2d2@gmail.com>,
  git@vger.kernel.org
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is staged
In-Reply-To: <20251022091112.GB853931@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 22 Oct 2025 05:11:12 -0400")
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
	<20251017075153.GA4078773@coredump.intra.peff.net>
	<xmqq7bwt1kyf.fsf@gitster.g>
	<20251018094037.GA1060824@coredump.intra.peff.net>
	<xmqqh5vww7xa.fsf@gitster.g>
	<20251021073640.GB259661@coredump.intra.peff.net>
	<xmqqy0p4wcac.fsf@gitster.g>
	<20251022091112.GB853931@coredump.intra.peff.net>
Date: Wed, 22 Oct 2025 09:48:37 -0700
Message-ID: <xmqqikg6zxui.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Tue, Oct 21, 2025 at 07:38:03AM -0700, Junio C Hamano wrote:
>
>> > So really, the regression fix should probably cover both of them (which
>> > it would if we move the /dev/null redirection into the flush_quietly()
>> > variant).
>> 
>> Do you mean something like this on top of your patch for 'maint',
>> and the latest from Lidong to the 'master' front, then?
>
> Yep, exactly (though with the "o->file" restoration that Lidong
> pointed out).
>
>> Having calls to this helper in two loops in one function looks a bit
>> awkward but the conditions to enter these two loops are mutually
>> exclusive, so it is not like we can remember the result of the calls
>> we make in the first loop and reuse in the second loop, so this
>> probably is the best we can do.
>
> Yeah. I suspect there is some formulation along the lines of: if we have
> diff_from_contents set but are not looking at a content-level diff, then
> up-front in diff_flush() we should quietly flush each to find out what
> is changed and what is not. But the loop for NAME_STATUS, etc, needs to
> know _which_ pairs still had changes (whereas --quiet only cares about
> whether there were any changes at all). So we'd have to store that
> somewhere.
>
> And of course the chance of regressing some unconsidered corner case is
> high. Definitely not something we should entertain while doing another
> regression fix. ;)

Of course.  The "redirect inside flush_quietly()" change by itself
is turning out to be tricky enough for the other caller of the
helper.

Here is what I have on top of your patch right now, after ditching
the idea to move the redirect to flush_quietly() because it would
mean redirecting N times for a N-path patch, but one thing that is
frustrating is that I cannot come up with a scenario or test in
which it makes a difference to this other caller if we forget to
restore o->file member.

diff --git c/diff.c i/diff.c
index 9b8d658b9e..ceb57d1ef8 100644
--- c/diff.c
+++ i/diff.c
@@ -6814,6 +6814,16 @@ void diff_flush(struct diff_options *options)
 			     DIFF_FORMAT_NAME |
 			     DIFF_FORMAT_NAME_STATUS |
 			     DIFF_FORMAT_CHECKDIFF)) {
+		/*
+		 * make sure diff_Flush_patch_quietly() to be silent.
+		 */
+		FILE *saved_file = options->file;
+		int saved_color_moved = options->color_moved;
+
+		if (options->flags.diff_from_contents) {
+			options->file = xfopen("/dev/null", "w");
+			options->color_moved = 0;
+		}
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 
@@ -6826,6 +6836,11 @@ void diff_flush(struct diff_options *options)
 
 			flush_one_pair(p, options);
 		}
+		if (options->flags.diff_from_contents) {
+			fclose(options->file);
+			options->file = saved_file;
+			options->color_moved = saved_color_moved;
+		}
 		separator++;
 	}
 

