Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976CC42E41C
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790538164; cv=none; b=H7j7QSBkbzm5o64izU6/H0pd7O79MYkaQ1DkZmC4C19n0tTlx8PyfAcLSV/lU7jfKm+i5JF7Hg2THryYrdBwAfueIXLMWkYR3sdq3O/o5Sed9jPoKhFFOau0UXdtzulw1O/esehf27UfCJGRLkbqS48QNBJK7rSQvV5HhUqultY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790538164; c=relaxed/simple;
	bh=mud3jQgBcA25I98V4hs21Y5m+dvhrqm+elVB+VMesRc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QQwbxB9Xzb/cbTm4MkowLDwtnrW+aWMPcxi3z7YAJHF9EdBuERuMxwz+YyeUklli7E8IeKibFMJZTVoIQSNSYvr/j8F30PazhXVJvgtv0g5s7th2YdY/SG4T4jygJIZbVI25Q2lzVJbKT9bSvu8odnsbszLSGvU7Nyk4CSJQYDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=e8S86gcR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iHcEXeZv; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="e8S86gcR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iHcEXeZv"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 27501EC00BE;
	Sun, 27 Sep 2026 15:42:41 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sun, 27 Sep 2026 15:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1790538160; x=1790624560; bh=aIePa7+ju7wtBpob2pBHldrbrHUN+5FY
	6IVq76Y068c=; b=e8S86gcRhFvX9l1nZEnpD3KKaGLcWIctgm1MAedWldeCX6gV
	8enMBj8POaeRjtAp+aPovhyzKPKaULG/GtSseJIKhuOUlCwYyw7anWJZO3wHqwPn
	Aui2tiaqFBvKs/VeVgGVVsySI86tsNX8DbGplmzxOXaQoZD1XPA8aqQZMyC5ksr+
	cmedWUikSRdJuzucd4M9hI2Pr8EDDUB+1HgbhAEVzLAjgOLO0ppMOl02hRr+XQmE
	VVIeBZtLIBSpfxNEBin7XgFCpW+Ix6OyRsPhb4OFZgocmEJgPtorJWXU3nfJRrr0
	LnP5aY7cxsMyUqI0aJKaB5ZV0F32BUNbhakXSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790538160; x=
	1790624560; bh=aIePa7+ju7wtBpob2pBHldrbrHUN+5FY6IVq76Y068c=; b=i
	HcEXeZvwvDPWMeGqD0DGio1Va53R0Kf9yM4fYET8icX4M8TzeHqtnlNPMZbZjiAa
	DjTNYsprne3K3ud9HTf1VPbUI37bMLc5oG1q1FrLIq48g0doRO5A16I0v277Qfgt
	zLultz7Qb9qdsmwKspMZpXMYzP7AHSWNceIyeWqvsc3SqVVwJWuGpNOrS2/pcuCj
	ne1Cb5mjMCXYCzUTNEXYdHQuQT+3fID1u5im6johYM9EoJgXY5iWWcVJNZevy3qA
	/S8r0lIf5VGkOg0L2MUwVj8aEFCGpHYtImkPkYG7sxp/OHYquHFdZfQOwcBl4ccW
	6YTxnZ1bJimEU0VogZXrg==
X-ME-Sender: <xms:rnG5anzuQoHphdKlKtch3G5PxgbN2LUSD8KVKojGdUyULNWX8k88D1I>
    <xme:rnG5aqHGoWkIBZUzPSNuSIIgy71HfqG9AJcx2sT33POWnXkCQv5rm-5k_xeZi_hml
    yY8-2dzClzt9LZsD-f7dwCOL15cvg7vW3SS8qz2Sge3mDyC_9Eb2iU>
X-ME-Proxy-Cause: dmFkZTGm9TLS8/oDwdg/VIIchBk8y6EfJK1pVcHdoKMPdKu/ujW52k5aEIHlfawZRcAwk/
    pwqRxG1azqJj2SD1FRKg7e0FX641c5XlC3nqHvVwhCoGmjzdOq5UWazxypLY8qF3lSiQZZ
    miQDfIy2QTUpOTyksR9aoLB3p1Fj4yxeNlwJzHESlyYqukjUABtvAoNu+ZwyB/Z1vGLElp
    qYchtJbc2/Hmfb8OIBmq0iV6vKjVO3jEKFY2cenpKurJqjC9ycHUDrmwpQgcNg7oaedhgr
    gRgkxYBufPrG1skijTswr8BRRyzaGsyXqB23pKTWGsXmqC0Qee5cUd1yN7AQPtkY+hDjbt
    fJRowmQjzuG7cL0u+m3gm6XcoFydGI0Yn0X/s263q8VMxwMH63fk/pZQkOTayR9O48OJiG
    BbO4JppyTbYxBrl2KMfHlqWO3n3eeL3scDFLP77OB5rNZsjyioY6K+37SlzuGyy/ueyivy
    RkTOGc6YzEvrKUoP5InRZfDpIfFelsXKOObxAE+5dH5IGKZw+hAD2CvSlvAViKP2rXp1Uc
    ZWFpFYg4k0xBSIuqNiPxcyPAak7sm61A7tDWEwzVjNdEyYm+LuE7G4Ryy79ukk0IYHakvo
    yYmvGqiJzzfkJN8I6a+CBIXkShXquFVTpxQQxAc3mx3meC3Nnk35sPKiPsow
X-ME-Proxy: <xmx:r3G5amYizQ6scms91SNp8D6CHj2C24-XA835fE53Zogobn3aJ2JwhQ>
    <xmx:r3G5anNXZ53IrjgJEJ6fvtcaRlDL15HNimo4K0JaQYHbc3XaKDQ1ww>
    <xmx:r3G5arbD1uIiqVSZAvJSVm8zSU-kc0EKJh7T9X4FzSqtT3tCmTWTzg>
    <xmx:r3G5al0mpReer5dMbx7vsew4stTIK-_XVGt3NAA4VuVsJpTzKa5tvQ>
    <xmx:sHG5am8xiVXdOjazuS4tiATOMMkdF8UeQRejXh2-5jFo82nWLzYJVYkz>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 6D61E22C008B; Sun, 27 Sep 2026 15:42:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 27 Sep 2026 21:42:17 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <57741bea-f264-45ab-b5fc-52466fdcb03e@app.fastmail.com>
In-Reply-To: <xmqq33uusvst.fsf@gitster.g>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
 <V2_CV_format-patch_learn_--range-diff-notes.cdb@m5gid.xyz>
 <V2_format-patch_learn_--range-diff-notes.cdd@msgid.xyz>
 <xmqq33uusvst.fsf@gitster.g>
Subject: Re: [PATCH v2 2/2] format-patch: learn --[no-]range-diff-notes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Sun, Sep 27, 2026, at 14:50, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
>> index ef92704de39..640c5dec52e 100755
>> --- a/t/t3206-range-diff.sh
>> +++ b/t/t3206-range-diff.sh
>> ...
>> +# The '--range-diff-notes' has no effect but is allowed
>> +test_expect_success 'format-patch --range-diff-notes=not-a-note (no --range-diff)' '
>> +	test_when_finished "rm -f 000?-*" &&
>> +	git format-patch --range-diff-notes=not-a-note --cover-letter \
>> +		main..unmodified &&
>> +	test_when_finished "rm -f 000?-*" &&
>> +	test_file_not_empty 0000-cover-letter* &&
>> +	test_grep ! "^Range-diff:" 0000-cover-letter* &&
>> +	test_grep ! "## Notes " 0000-cover-letter*
>> +'
>
> The second test_when_finished is redundant, I suspect.

Oh yeah. If there is no Range-diff then
there won't be a notes section. I'll fix that
in the next version.
 
>
> Other than this minor nit, I didn't see anything questionable in
> this step.
>
> Thanks.
