Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792690894;
	b=nLMHeS7dXScIctP0zGlBLpBGde57mc1wJ50q6CEInDS3wvuGiTKgzQEmOAeR9PNPeaP1
	 2JaaWarURc0pCWB+b3XhcYJkcGwKfCOUS8dL0ewIiYs+BfSsX0X4nTodAyYQv17WiUefN
	 Tt4Mt9W7DzKtmBOtID/0QomytSwWBRGXqmJXr9I0VEVuC31mw5Omniw+TNRSZc+8Hd0W2
	 UZSt6s+sfPyEIb9Bz8HFP0/vn5l1/YPon7mfV+cPWsaMBE/CPH47cMhdOK6eHZdHeb1X3
	 AqexQ+m5Vt31opWCRXHGM3dmedFJn7g4qu5r57/tOxG2DfxiZ36kiZKKUWDD5EmUedQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792690894;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=EUuE49qtaV6FIc4hwZLbdvfMGlwGSxF1qB9KPFRZ3gA=;
	b=WhGEeB8DskGEtYQizAvpe8vfXueIIPWObEufZRwF+ZQmcylYG8o8gMtd9HPn/Rr4pXDN
	 oIlUmNCF/NwgA2WLBEnL915QS87v9faAmO8XALwOWBjtX8nbZ38tnDB+KoMEBIf9kBr4e
	 flDthmyaMET2+QC8AL5YczF41ey+91GT23vf5YLXDxcptKvFf2SshsPcTpDn8I/eNEd0V
	 /nyuHVLMta0A0yeXew60cTEMiyWfTDTzJrMUX9c2z/1yUyvVj/BsurLI3A+sHLRMhgpqU
	 SUjSHB5/9qfLiEpilKCqN905zIbm9pNjvNR/BwT4NhJBhMVUthB7CfsUl33134srnXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=f9tLX6DF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZiaoxrVB;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2CC606A31B
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 17:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D2CC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=f9tLX6DF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZiaoxrVB
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 69BCB7A013C
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 13:41:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 22 Oct 2026 13:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792690891; x=1792777291; bh=EUuE49qtaV
	6FIc4hwZLbdvfMGlwGSxF1qB9KPFRZ3gA=; b=f9tLX6DFWWhAyx+pUrM54kecs2
	cZrX9YusWX5NdSFJUpFAW4AYA+8qKfn6YpxKkApaAWY4L09asT3LJlA4DgrIh+N/
	Q92nlLib3gTzsAxoElYl9eHiFGrZURIFu3IhhsZZZ0WcYupHzJ3N9xPqAdapnFF8
	r7LU8ysyCPnIgvdB8Kfd81amC3MWSIQTnaeXZlCHOc9GkVGol29n5EQCqVEOKLxZ
	NLX5py/igQ2rCfAAHYxdVb4uv7/CYgDRubgqSQ7TB9X7URyf2UUqLPLqGeUbTV92
	q1lQR0q7M9ssHf0e5KoNDLNcrli7+9cKcqld4GJY1beoT0kKlShLcN82jruw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792690891; x=1792777291; bh=EUuE49qtaV6FIc4hwZLbdvfMGlwGSxF1qB9
	KPFRZ3gA=; b=ZiaoxrVBBj/k4tdjSSY5T3nJtHuY0XPDajLHgp3vFGMjsAcdzOX
	2Ogpk5YvD1KFJTAs/2ilA1iO2pfqtoiPU+HmXHmzkrvAnU12s/l42tUcMLggz9Gd
	u3xNVEQVhYa0/3xbJjRKr/pvH9FVVLgI3yJkjpxPWDARqYuXl7vLAuqyat3wP2f7
	XyLCdSsI2uNIL63ZP7uPAAJmnroh5nRhUvB2gxUYHrsVmLWAy7SXF+17VzjoAIBs
	rGn+TGlWM+eQFtbeX/FUzCimsmmR7Vtr8A4biW9Zhwmsu50s7bJ2kWIFXG2BAcsm
	tdbwTZA5SmBNUe8q+/HtSsyEFdFh4cIcy0w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792690891; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:JLC/YtJe1lknzbSe7gNwZmO+iPRUcdMdafFQl2ND1/C1ERJ
	eaXSADGC8UOQBIopnBVrJReeTNI72fv2m1OXe8Bv2jmNkrsm7qDS1Sws9FitOPfI
	EgGFnoZRdZWS6ALGS+SRn8h1jzp/aBFeL5MfqCtkGcvr8WPFgAzFaso+oMpjgjlo
	cd3e8j9X7TaHiwLJV+WHVRSy94oKUkd6vSkdg/sM2dAsxDSSFs9X91LWHQa8SMDr
	d6i82+AR9qzDGq0R85M1FW8yOJJTtB3Bljd1dUlaKv0Z/IweLAIwh/+SIdKz+LCu
	ZWCmzHVxBJM9CPKnHh4StCOgtBlyPbd/VZAbIqw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:3q4ExWRk1xUCDst4m/j6PeDpSJ/0LcQadyhEaodD3mw=:p4V1TDyZ+IRbw9Ms6h/WmN/84HKDWUZCYpq3+nmO2iQ=;
X-ME-Sender: <xms:y0raaiCZoX5uI0tXytLwvq_-XsDzOsEL2Bbo59z-xTFLKWvPI5LHEQ>
    <xme:y0raatNgkJLHWsxT91oNptcxxRUeKxn_JHKHp9HRHZgxR0wxcDn93tjzW7DtynmII
    pAkbqh9KPUP67eMBXPxUKRuBnE6Oa8tTswAFizcBSPS6NklNI4PQOM>
X-ME-Received: <xmr:y0raajygr6JC4o45B58Ia64TK8k1BiS-loMohuTAyfiYat-mneiGzVOj0kY1CjBzGwPCA0y1-lLaQlMD3d0tI5m2Gbc4AteBRjpQ>
X-ME-Proxy-Cause: dmFkZTFmEwxukPnUwr1Kt9GCg2ppfw/VrsZZ9b9RJrzuM7wrjrnkSprQc554y4iLbUT77m
    oX3CSBuEQDY/faq2V6JAEcCytmrLpBvi0XRKWmP8MjXHQBhfmMWJWrJ4stEVn8ZND5cdTM
    JuLWpfyg15flocG2gJ646HEKMRxKEHNkblALgAnz2Q6prpIBiqJjHpyBH1b1aBnhcgoouj
    ZeSyvZZCNmCAeft68lWJSwgCug30xF7FEk3po//TKI/pikxYDlEa4kV8UZnGveJ7kam461
    hyXGXxbg2s1zVk76zBScTxNSS6YuA3LYMRdk//HiF4bhTFIry9NNrt524Gs7Je0ByXPkZP
    5rCcRhsb0pEHTHb++UuYtfMvdS1yN9GU5BPy1zX29Z6hE5fsCatRXmEW2tem/yFeUUc8/3
    N/df6LrFqhcJrnw7NKO1qPO1OYhMWxg2NWimC3Klp5qwF2j9AtDN1bcW/tj/zojib6PtBi
    3A2r486sofrTSxKxYg2XCpffyWFRcArTXttwOWWim/+UirzBc1lq/3qYVbDlFOp08VKPS9
    C1Zl0Zm17wkM7qhvL2jzwllfPaarKYuRGH3OLyJZqzk438uJEB5nmz4lhuSHIjdFMRYrzP
    bCdiDeNodfSxsJq5iQSUU559ywigKMM7NeJX0vtbWZXVVD3PVYzQJJyakX1g
X-ME-Proxy: <xmx:y0raalWBWiB_TDEHolTJsk_AeBKRovgQIUVWxWSIMps9QlZj7HlwLg>
    <xmx:y0raatPK8XrQTZXit9X6aJBr2RbjEMxISZmYMdNcmmVryp1J_-Mt4w>
    <xmx:y0raavDoGRilCY6frL9LKNsc_l7DjgrW45wc4MnVdJ1b-Fz_36pG_A>
    <xmx:y0raaieMHPtsb8qkf4C-j-uw2mKwI5fq_3jBghlkKvgNLHpQJXE-0g>
    <xmx:y0raalf_eJRGxDDEFkQh5ND_I8mdgHl_BLVQSss9bbk_FIhry0lBJPbX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 13:41:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: kerylefondji7@gmail.com,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com
Subject: Re: [PATCH v4 1/1] archive-zip: refactor 'path too long' error
 message to use Q_()
In-Reply-To: <57e076d3-cfea-475d-b68d-a9f36746db35@gmail.com> (Phillip Wood's
	message of "Thu, 22 Oct 2026 15:29:30 +0100")
References: <xmqqmrs92y4c.fsf@gitster.g>
	<20261020183908.861-1-kerylefondji7@gmail.com>
	<20261020183908.861-2-kerylefondji7@gmail.com>
	<57e076d3-cfea-475d-b68d-a9f36746db35@gmail.com>
Date: Thu, 22 Oct 2026 10:41:29 -0700
Message-ID: <xmqq1p9hhbue.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Keryle
>
> On 20/10/2026 19:39, kerylefondji7@gmail.com wrote:
>> 
>> diff --git a/archive-zip.c b/archive-zip.c
>> index 6f73ca6d58..5ab3ba786f 100644
>> --- a/archive-zip.c
>> +++ b/archive-zip.c
>> @@ -328,8 +328,10 @@ static int write_zip_entry(struct archiver_args *args,
>>   	}
>>   
>>   	if (pathlen > 0xffff) {
>> -		return error(_("path too long (%d chars, SHA1: %s): %s"),
>> -				(int)pathlen, oid_to_hex(oid), path);
>> +	 return error(Q_("path too long (%d char, SHA1: %s): %s",
>> +	  "path too long (%d chars, SHA1: %s): %s",
>> +	 pathlen),
>> +		(int)pathlen, oid_to_hex(oid), path);
>
> The indentation is still messed up. If you look at the deleted lines you can see that
> we've lost a level of indentation inside the "if" block and the function arguments no
> longer line up. It should look like
>
> 	if (pathlen > 0xffff) {
> 		return error(Q_("path too long (%d char, SHA1: %s): %s",
> 				"path too long (%d chars, SHA1: %s): %s",
> 				pathlen),
> 			     (int)pathlen, oid_to_hex(oid), path);
> 	}
>
> Thanks

Thanks.  Just in case Keryle is reading the message in a terminal or
webmail app with variable width fonts, the easiest way to see what
is wrong in the posted patch is to visit

  https://lore.kernel.org/git/57e076d3-cfea-475d-b68d-a9f36746db35@gmail.com/

which should show the patch in fixed-width font and even uses real
tab chars properly (so you can click-hold on the left end of a line
and move your mouse right to highlight the indentation to tell the
difference between a run of spaces and a tab).
