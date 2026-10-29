Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793305939;
	b=D/2+MFjZ6ZgSebLYM1KVRUOxUfF9YB1uRo2GxurzSSmqD2k9mcLVsGqben/rQ7BfreoY
	 Y5YQ4QK/j1WpS+V100dqPbXDcErG+2BmtxqJ4QDUhHXnJt1/0qM0OdcunFPllVBESbi61
	 11PhFvqjyv5vOcib0kibhThuEMlJfMi1ZreCkUn24RLsWdRJHsElVoTL3Nkream0lp8Sq
	 BDYcDMxsEqsQqXaMeZ6SgUAesRzh8yIdbzQrMZpxkWCeMWLFE3Bd4OOtSpsqVm3O3+vsE
	 PneabSFzKlQ5V1xJc9duBH1ERSpReUbZI1Lnzri/gqiAwmOuLvbDDSffAWz1AyRVmdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793305939;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Xb5XAStuufhA3tc7tDbPf0W2Q7twbV2aDKoW8241Ok8=;
	b=z6Tbuy/txeZ1VHxTQTo2Eesgm1I8pYLoLcHsJOSiuv1gWbNnb+MIWoCLc7Oq4uzdAqfF
	 wFMhn7dWAMfmy5bPe9+WGg/mgGou7KtfIxwi5k6CHO7zsR3LG2K4Sp+CjiRaGAF0LiRWp
	 bpBmpH32R6P+yPmkKGs/mGtCtqAj2oBLlkf3h7K7vUPVPPmkudexhxVApYQAhB+0J5Da4
	 V8pzcIeW0AIBHlMDXB51YoPwVTNxt95zno7ECBfy8y/ZHRUKftMPX+M7nDB3uvIrhyLYN
	 igoRdDzRNHPvOdHwVgwryl5nzif1hF7X4sVI1FMTsYj4ncho/Ag6B7Rxq78OKtgIhlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=kRxsR6pH;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="xhCw/rFS";
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A025606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 20:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A025606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=kRxsR6pH;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xhCw/rFS
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id CFE0B1D000CF
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 16:32:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 29 Oct 2026 16:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793305938; x=1793392338; bh=Xb5XAStuuf
	hA3tc7tDbPf0W2Q7twbV2aDKoW8241Ok8=; b=kRxsR6pHI4o1Qak3af2w6pqeDy
	sQ1WRNRt2QzVnEfBEZ1HMf0bxoc23hQ2scYQCVPYT5LN7Ef99L9mApk2aW1hTlLs
	IMDtYdOly85AkjUkOL132dDmiQsswNB8McfYC7oncnM7NDjjSOMN7s70ta1TVqrW
	KyMWgxCKIWA+0BYWYYRH0D//6nvPPVawtn4t0Dop8mTbmCcZJiEaTn6cShIvYWkt
	dw+LB3uV+CSpCSc/bYWacztAC2mE1gkK14sXFnskKCr3pePRDXhr/gqTmFLLMdrk
	sGHkOdVZX0C3UpsCi/Zkv2tnRvL8wr0o7lYm3kXmdDxdaaNd6QspeGEaIHgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793305938; x=1793392338; bh=Xb5XAStuufhA3tc7tDbPf0W2Q7twbV2aDKo
	W8241Ok8=; b=xhCw/rFSuRRQZht9k3uqr2PQRgusZ2G8O/ZzfpTnUznDB2sONYn
	wLqcWQkwOOJJnNWB6/Hbo2CEotuZRZJcpFMDSekXYPD+Vp2YZuIdPtWDPlh2G0Am
	dWpvd2yAG8Uvlec2XWRkleokZonAsxjNX/Sza7/FP+MEz7seXMXWSGFiWRY9PRWH
	jn3wAd3KK+8CTzrNAxqWCMjyJZY2M2uK8AhHkwd+R+i+u4/MYRHQEZZ8zeuGvPsG
	f+U1jF6t2PQtYy5QXQUXrq+OfNmi2SD1qS4kXuWKopA45W+bo8W3Xr1iZb+fEuaz
	1ynC6cvOOKHsRJQ73QVaTuB8InR9j6nN2XQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793305938; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:GbuaQZN4TI6OpqJlWa+C3QKSxDFyZIu7KX4q98j3GnqrqF7
	JbxdWLYSGDob7SfhJnjYskgA/q6KoPgdng4nVa//5q7r+5sXm4pGXpuoOOh3TJ7H
	IvLF90/ut/az+spkZj8QYKZagM/Y+lfdLOa1FTnBZP+ov7aSxMG5DyGmpBzCP10R
	hebxV9MU7dRDnd+wzWgR5rdK8aKVQFF0/GyUcqokuHVEV3oocrnO+y1qczQBK1Xl
	yjV1ijnznPL3KsAYWGmqVqFxnNoG+BjT0PY29H03eL7gZkZnYe6mqkodgUJ2bG9e
	ypgiobBXYf0DCvf/Y7L4VaCVlF0MvCZIK7md21A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Gw0fXETqsPNv0iDFDMcVWS1OfuASeizjKOq7WWJ9jk4=:w8EbIl3DlvbYg+mKKdWW4PrgvjnKz/aphpm89BEV7lY=;
X-ME-Sender: <xms:Uq3jalJt1-hJjJiTT0CBQvj8bomehdID0zemOtua_ub_NAXvI93YrA>
    <xme:Uq3jaoL4t_ZW-fvPt4jeRFksQ_1nbbxT8RNkabz_aXImejikZlJh0IB3tZPQtCMWP
    AcP3zk9Du1O0Jt6Marh1uSeONENqz8ATRjqH3HzBcVKpr4egkCXZjA>
X-ME-Received: <xmr:Uq3jaiupW5dBAA8vxSc2m0HqUzQ0l009AqvDTXYOcfun5lCPEyM7Vm-rIZ1gVq_Jr1Vr0HXK-6iC8lykecAmWHchFizPM67l01NB>
X-ME-Proxy-Cause: dmFkZTF/At7jBa29taRoeJ/KbQnkkSHZzlup7ps2XquL0EuQXNyc67lpbWuWo+1Cn+XzfU
    mj2d5nsrBZHHH6InRj/CDPexn5M1kmCKZVse0BAmc6dzDYRK+EpYHeO11+5Cp6KTdRhWyF
    jg0YecEHiC8immFa29QIWfnUALgme63zkOVVIayGbMQLNI9+pNUJvqbtCHq8M3il6OQ4jK
    VhZAJ6VipRs3gMZOOq3ugSO2SgECdg56RFSBgld2zK16tFjMPl3ELloH/T5PPOJ25N9lix
    cKk4b1AAfmPGdqLt0iBzd/Aa4qa4ulVZgWCXCmC8UFsNxWuuWwqZodROf310IYMSEWk8Oy
    u1iMoOZrdNhPU49uAQmc4u+7WDt08o2I64FVSRnO3f0NfbC5U4Z3cOEM6S35uECbDMhARx
    4rkO8lYaRA01Rfd/6jUCLvSaajY+Ujqt1Q8ln0GA9EVQLNWPmKWLnhUH90hl/vPYaNCyKG
    6ITu8twJehExz8x+qZu50ZuI+kahv6hfGVEUIgsZzJgE3UOVLev53/WeFDZFBrCzxh2gSz
    myaEFDeByXhN2W4sMcooc5PWqLBr3hTkmRs8IJAnzEtmsG4NGEPm3o3/Xh79mUU8xhRgQO
    QcEy1qCDRZCdRGr0Pq4rKjyK5Yme36traom8rNHEtIoUna8ToN09LcbhSf5g
X-ME-Proxy: <xmx:Uq3jalS3x-KwXvayYVMw1YhBqJNvjBKEYkugyqCBcIu5TlpUarw2QA>
    <xmx:Uq3jaoO8b4QdWBpg5tdOeSb94oQJjxGQNtZeBUA6QPrPi2WOFmRwzw>
    <xmx:Uq3jaqZDS3idgfPYkrVxeYed0TDNzwMdnFIJrxxjtG7odayz2PRSxA>
    <xmx:Uq3jaiwFxq8jn3a92Top2zmS6GibvWGIn2cyRlcYlyqSeEQuTU4C3A>
    <xmx:Uq3jaiPTsn_wCfWNSty6gA-66Gbdj0416IlGQAk7cps7v9JRhh_rpIXv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 16:32:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: "Tilak Kumar" <raaztilak07@gmail.com>,  <git@vger.kernel.org>
Subject: Re: [GSoC PATCH] t5402: use test_path_* helpers instead of test -e
 and test -f
In-Reply-To: <DMHLKVCPT29F.1JXB7BAOXBPYT@fastmail.com> (Mark C. Chu-Carroll's
	message of "Thu, 29 Oct 2026 16:17:13 -0400")
References: <20261029200024.32206-1-raaztilak07@gmail.com>
	<DMHLKVCPT29F.1JXB7BAOXBPYT@fastmail.com>
Date: Thu, 29 Oct 2026 13:32:16 -0700
Message-ID: <xmqqcxss1c4v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
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

"Mark C. Chu-Carroll" <markchucarroll@fastmail.com> writes:

> On Thu Oct 29, 2026 at 4:00 PM EDT, Tilak Kumar wrote:
>> Use test_path_exists and test_path_is_missing instead of "test -e"
>> and "! test -f" in the post-merge hook tests, so that a failure
>> reports which path was unexpectedly missing or present instead of
>> failing silently.
>>
>> Signed-off-by: Tilak Kumar <raaztilak07@gmail.com>
>> ...
>>  
>>  test_expect_success 'post-merge from squash merge runs as expected ' '
>>  	GIT_DIR=clone2/.git git merge --squash $commit1 &&
>> -	test -e clone2/.git/post-merge.args
>> +	test_path_exists clone2/.git/post-merge.args
>>  '
>>  
>>  test_expect_success 'post-merge from squash merge receives the right argument ' '
>
> looks correct to me.

Thanks for writing and reviewing.  Queued.
