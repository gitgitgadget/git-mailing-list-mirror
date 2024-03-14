Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C666DF53
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 06:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710397247; cv=none; b=KW3/HbzrVtNRElBfLkEM0hB65xAz9n7uQUFAX8AfByUefn9QVrzkwCt1F/WE9PjCGlfNSH4lVKpkf6t3iVTyDK1FWIhwDczMz4cd1HLGPrEIDW48VoeVCmA2Dcm5xo5+pByHLmjc4BvEvEsU56MTs73C1+ZLot0vMX2XcrFrdbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710397247; c=relaxed/simple;
	bh=yL3WI4etDfbLkXCV1Zgwq+8J8/+YG4ucesgADw1jrTg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rkFohA9lWXWST36HtM8HnXSzL5v8aQFI8gv0pWM0B5v65PA9lslLzlMe6VSHAzv+A4XskopJ2tQvUtkR/QYC5H1XgxMGzhzR8UVauC4vb2BqQOtrdwjl4c6Mg4HZ2C6MopBmIMMWwfAjXDqqKWd3xk/JLRY7EtwMImV1pazI/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=mM/rhaC8; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="mM/rhaC8"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710397243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6oIW63NzGJnLKEi2OQwyA8llSVYsWCM9w77I0nvScd4=;
	b=mM/rhaC8BvcS2YLBa4FpcfTyxYQXthrXfhuKQpbohTcPnfepfucqvUgtPPEyNB+WjMmcBp
	8LQ+RKdftubSTbcHMh61GL+hSKzhdFKFblff1KnvWjiWgC5TLFek2SqkP/zojFiofEXIFE
	CxXJ9tc4pn/RhS3wQiuZXVWhJpbi9h58ljV1J6drgxACVYr+JYKq17guvcepJn8+hdljYh
	Nhbi6R/Vv//XKVxFDGjHhT8/A69MdNQO1MjdVzu34gXJl7Q6b4g64NN2k7BkdBnqH4B8Du
	eHEScjni8lobLGxyD38ww0NfVImXBO6yjsgtT/phDEUo2FjcIDah52SK6L4B2Q==
Date: Thu, 14 Mar 2024 07:20:43 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, rsbecker@nexbridge.com, github@seichter.de
Subject: Re: [PATCH 3/3] t1300: add tests for internal whitespace and inline
 comments
In-Reply-To: <xmqq8r2l1rot.fsf@gitster.g>
References: <cover.1710258538.git.dsimic@manjaro.org>
 <292ab942c38de44476c6c5bf045c375bf4f6a70d.1710258538.git.dsimic@manjaro.org>
 <xmqq8r2l1rot.fsf@gitster.g>
Message-ID: <9ed8b0f2ad3521eb14dd24082b4aa993@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-14 03:18, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Add a couple of additional automated tests, to improve the coverage of
>> configuration file entries whose values contain internal whitespace, 
>> or have
>> an additional inline comment.
> 
> While this may document the current behaviour, I am not sure of the
> value of carving the current behaviour in stone, especially after
> checking if the current behaviour is a bug.

Please see my comments for the first patch in the series.
