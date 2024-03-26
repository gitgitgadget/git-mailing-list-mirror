Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD171327ED
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711439495; cv=none; b=MciTVenMLf/jyCtmvuNfctY8nOtZsHOTUgXqES+TuDzvq8IKETP11w+Bkb0BHE31W39heF5yJOu8/7QOu745V9P6F31xJ6AApzIYWGjuqBSZyljm+6bbhZO9NnfHGu/vbRPJZSjYHE1li79PKZO1KPBrf8LRaDPvhQFwfUQr1S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711439495; c=relaxed/simple;
	bh=X9sOOTX3k57iA6+08XlFOj1chDf3QR4Fcausw2oh3k4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=hlATggHeiPxBHXly4IufTh9S1bIr9l7XwiJyC7GfLXMuR+sspfgR1NA4QnH46sJgrQOxf76sJppYDLUJqd4sOSN91weJUKW1HvprCHRMAtXZqajqMiOqzaS+4D2BqtCWD8zaHV/u+uBiSXzWK98Tu9XHar5KB8UMg73rYiSjRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Dj0adeBl; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Dj0adeBl"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711439483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07U+fprvTInxqgQ+NtAsarD5sT3SaUx71j6SEzBY2OE=;
	b=Dj0adeBlNyCO4PSb+k3NxaR5zCaX54w4gRNhEo3QqD/HOJc+4Qc6uRcptdO2QjCw6LzFMf
	7/3mzwbI8Yu0qfW/dRC2mMbHTOVz5WwyudHYqrgJGii9Ppg35aAvzWd4q2UmXa8fSmGuoN
	Q3/wYIEsQRHkwyQhJZCXpOACtru6wt0n0+YpZYHQkb1LhWsWgl9NNYsXcFk6vvS5uubMVU
	wSx3DoiELKYnXnOJNs/RjOeCyZg+hHfVggEZwyvBGDZqZTHJeozak6siey4LMSMIkM6HsC
	oHS/aVrlVURu0mumY+iI2CJXzwHeEF8OR0HVtlRDNvKw6eCcO7oW9J257wSJwQ==
Date: Tue, 26 Mar 2024 08:51:23 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Brian Lyles <brianmlyles@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 phillip.wood123@gmail.com, =?UTF-8?Q?Jean-No=C3=ABl_AVILA?=
 <jn.avila@free.fr>
Subject: Re: [PATCH v2] SubmittingPatches: release-notes entry experiment
In-Reply-To: <17c0263586f87125.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
References: <17c0263586f87125.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Message-ID: <da3a915b302c40dc8815d72d3e235a1f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-26 00:37, Brian Lyles wrote:

> On Mon, Mar 25, 2024 at 5:21 PM Junio C Hamano <gitster@pobox.com> 
> wrote:
> 
>> +[[a-paragraph-summary]]
>> +
>> +*This is EXPERIMENTAL*.  When sending a topic, you can propose one
>> +paragraph summary that appears in the "What's cooking" report when it
>> +is picked up to explain the topic.  If you choose to do so, please
>> +write 2-5 lines of a paragraph that will fit well in our release 
>> notes
>> +(see Documentation/RelNotes/* directory for examples), and make it
>> +the first paragraph of the cover letter.  For a single-patch series,
>> +use the space between the three-dash line and the diffstat, as
>> +described earlier.
>> +
> 
> One very minor grammar note: "you can propose *a* one paragraph
> summary".

Actually, it should read "a one-paragraph summary", to be precise. :)

> Otherwise, this patch looks good to me. Thanks for considering this.
