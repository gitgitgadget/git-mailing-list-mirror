Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C819637DE84
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620216; cv=none; b=EnIhvZUV8hMbHkXhWw/7AaEv+KyNeRH/8vJNroE+Z2ZlzPlW4Qhj1tmSN+vVdoNmTmmRhQksqmioCLl7tIUSB+gAaUIrppgRNIrBe5FTXeU0AP9s4ujnMgKTKUmb4hVy3mdKIUYwrkNhIjCbOkdQA7zha0f/odZ/z+6iO9vy4YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620216; c=relaxed/simple;
	bh=EepzB6sUHSh6OuRdw3ZWsCghsvws3cYX2z6ZSCOM1uQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TEhyEV9yjJX2uvt8zHjS2e+m7WbNjne30jMOKL+XaACn+zrKXkXDEbYWuOE50Go3zuvqFRMECxPvbhumEYeGzZqUJlcIFYFbUxJZSC9OwTF/WsJumMyDbR7DB1uUBdwI2GDx+jDVm00XmdXlkQ30L+J3z5sBrDGo1JmkRM0P4b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CC58ymkg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WO/bOV2O; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CC58ymkg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WO/bOV2O"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id CC88C1D000F5;
	Mon, 28 Sep 2026 14:30:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 28 Sep 2026 14:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790620213; x=1790706613; bh=JG7KDxdcYz
	2P/Ap97ja83tN+PFsxyeid9cq8XCkN9J0=; b=CC58ymkg918Mhp9Aqw4ekQAUHj
	p3EuBaMv/sur7BfWA4aqJp6moy8KvIZ1YeLJvPSDiDmuL21yQCrFcV7lzB9N9Ouz
	TfffRbb0gMrToGE8BAZ1nrKjn6YVwYekVXTuufJ3gZXtpQA2qEEIQep0qdFslMnB
	r7p597Bf9EduOBLAySCVeTPG7zc0CI2CeP3UA5lRmD0ybA3BVDIoW4xOef4nHwpD
	ECmw9FvfsXdh6JGWRpmghWH7ycVy7HPhq+buifVAnvNtp+E0ozAmoJPqXXZ+Ibpl
	iDAcig4ibI9mRgNW3sIojIIUMuAGAYJmZn87yaA6I3YIBvU3ASBAB2C43gPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790620213; x=1790706613; bh=JG7KDxdcYz2P/Ap97ja83tN+PFsxyeid9cq
	8XCkN9J0=; b=WO/bOV2OTL2G7X2QnKsQaIDmPzD2Cg0bHJwK2AWNKC4cKMH+SEc
	XQz+Xs+s/opyxsI2nEDmpuvNIJMkK1bK5d8lq2vy3y/kzW+3tzkh+iFHm/FuvCcH
	Nuw/yxe0xfs9sDkRblOI0Ri2YIIgCrZx0yZj7zpEIvitCNF6p6MI2aB5M0lx+KsH
	/dl6F1//PzNYT3sc/rQObNvpSBDrKXqC7e6qYMN7mxKxb6jLolq6XoTTvvIY2su0
	Y4RgI/7b2VcNkIvd0hh4t0Fx6rhYA/7kga6Sa4P/qMbflLVHSZQ6MvHuK7W7F/a2
	Xgwwmuf14E+znaFqzekMFWnbpYJJNk1R1SA==
X-ME-Sender: <xms:NbK6aofH1N_FlcrdpKijy4MBxpXKdWtkMynSYn63HHOVtFdz106ORA>
    <xme:NbK6ahP_ft5LPfOdKWzFAMPjzxxj10i46sfAt5-TWkBYjw_pAkekvuuHoVtsSBGcl
    kKTd2GvmJnDskwpjJoqjExZp9H1qLLjDexnT588NyzLYQuN1Iv-Iyw>
X-ME-Received: <xmr:NbK6aui6q-KlQsg7ElhWBC5LeJ7FxEx735vBI2T9GUQLWgqiOJaS2dFSiGAOnKdT7EWkgvpArYayan7JqMSX-RGdNoaH_N0llnTc>
X-ME-Proxy-Cause: dmFkZTGZTeTbSN9brl5yzM9PcDoflwP0dbwsBXKo0ZyCZC/n8dMR3nxROPFjJn6My1OH2y
    EYn5DBgBymbb1vhybwDgw8ubEDLWd7sT2D/js0EMd7FXGlpwQnn3b4GbecH7lD9raEII7C
    BzP24gswQpEo3aARzAHBPAKgcuA+F8tjKtBR7DC36e8b4tQIGlLd8jjNY6PSLcKmrFugHW
    H8nAqkpybsWalWWX7c07zpdUai6M1ThOOzdC41EVoCDVn+Skp9S3OEa+HRkIdWtvr035nG
    GMmTQ8iR9lNRZuKrnEil6pH9B9NZ1O+jX4aFSwjptaeJVWY90JXOnAr+t8Bqog34wp2Wt5
    R6zRhyeRwMC52pQBNDEhtxCppvn43T3odEhnDRKiyyYrRnqn/5QCtLiXZOfQEH9IwY8XzJ
    bWXrSYwsMCHMXP8GC49840Mw0667VMaQ01BGfUwEJ1JbO2zrrP6mf79kRzuUsuJG4mYJWK
    mCs8kgGm+FW2nlHp9RFDWgGBAZ9mOhSr+WXkRfskoyMZmPVrJGNpflWW7B9e8DqQeTu46o
    4WOLo4gqcnZlwyjndx1yqG/H/yCJhCBJaibDSWKvOTVeC+gDfc87qFxgFyIMfBXxQrQqZm
    EVR/CH6H0QnV7P6S1WCPa9/ISstVkrI4Y0rdkvpAuUWgW2dqV0gh+KWrhTfw
X-ME-Proxy: <xmx:NbK6as0SCyRo6-3tWNL7ukttNvjFmowT-a4p2qaYwDkQ07OD1NxwZQ>
    <xmx:NbK6aghl2BMldL04gaSwc774ZK08OsommqDAsRVBuWZ-APZoWPpahg>
    <xmx:NbK6akeC3j9wZou4w6Ftko3eHr8AGEqDMpXf9OWJOQojANWc4Zy3Iw>
    <xmx:NbK6arlVKE7puS5nLOgvv1oBsOWwUigYFFuNFL7v7epqaM10zqnnHw>
    <xmx:NbK6at3WvjUPcwhJs2meX2dqy3Bb4IY_avRLDvsqlofoygyr8BaFbPLQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 14:30:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Jon Simons <jon@jonsimons.org>,  git@vger.kernel.org
Subject: Re: [PATCH] p5551: fix repeated runs with update-ref --no-deref
In-Reply-To: <20260928040511.GA498426@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 28 Sep 2026 00:05:11 -0400")
References: <20260926180648.60770-1-jon@jonsimons.org>
	<20260928040511.GA498426@coredump.intra.peff.net>
Date: Mon, 28 Sep 2026 11:30:12 -0700
Message-ID: <xmqqcxtxmdor.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Sat, Sep 26, 2026 at 02:06:48PM -0400, Jon Simons wrote:
>
>> Update p5551-fetch-rescan.sh to pass `--no-deref` when deleting child
>> test refs before each measured `git fetch`.  Otherwise, for repeated
>> runs, the second iteration will fail with:
>> 
>>     fatal: multiple updates for 'refs/remotes/origin/master' (including
>>     one via symref 'refs/remotes/origin/HEAD') are not allowed
>> 
>> Starting with 3f763ddf28 (fetch: set remote/HEAD if it does not exist,
>> 2024-11-22), `git fetch` instantiates the HEAD symref.
>> 
>> The test, introduced in 7893bf1720 (p5551: add a script to test fetch
>> pack-dir rescans, 2017-11-20), predates that.
>
> Thanks, the explanation and patch both make sense.
>
> This test could probably benefit from using --setup (which also didn't
> exist back when this test was written). But that's nothing new, and well
> outside the scope of your patch.
>
> -Peff

Thanks for writing and reviewing.  Will queue and mark for 'next'.
