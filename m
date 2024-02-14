Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75F413B2B7
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707938407; cv=none; b=HGbySuKFf6AILbaQemfHZR+DdZcGnczi1TAhmXB07quVqhIbOy/FfKjDiiTveFh705E6TuIU6p3eY+BprfDkQtgz8mHq/2j3k+Rbs/yGLL6wvyMq/4iztPKvHxb/p/9DS26PgWcla96pkbdqRyo5k8FDk5a8IZVQwk4Nm7riUKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707938407; c=relaxed/simple;
	bh=TgdHgxdSj/Im7fPw1BS8y2RIMcwJIBG+gQfG2t0mWWU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=lANY9PfLjuMX2Pmpk0gJfRmX3pxrk1+WmzQk1NvTvAEcF0MhNnrZmfwiiEvDQD2qctdHGZrdH1t7TrRS+/a09ab0471Pi1uwU/DX4hjVqhMYwYgGGwdcz0E429UllHwXaUurYTl8SnfJTdmt+wryicf+o8p+FIZpVKu4gUOZRw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=wY0S1hte; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="wY0S1hte"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1707938402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3Y3k0ten+ZOTdZqHMEzXU+LlZMOVYSYF1lzoTX2QgY=;
	b=wY0S1hte0VusgX3Ix+mcVIKW+qqdVMuwDVPb1duaSYRCuyAnRTNAKCWLviJZpmR8RPqOB7
	aF+5suT/STUuWMaUJXcSMB0cXDN+BNVx8b0DxvYqffXfVQRaQRnY8ECQHgsxCZHTfTSDAh
	f7dFu5+MN21HEofrUgfhC7xxBu/lvIU10rYTo93GzhyP4TbCet6PzcyRmHPYTJ7Hzk+hv8
	2L7GZOLqufgeoIc3UJlCGJgOZwy03AoS3TldhN2cdQ7k0E9HTpgomJEl9KoRuVjAtb3xck
	ZPt0t1WbclohubTGNngQUtOZgo9VRbahA5pf2QIfMig2edLVa/hUb/ON6E+RVw==
Date: Wed, 14 Feb 2024 20:20:02 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: add shortcut to "am --whitespace=<action>"
In-Reply-To: <xmqqle7mvp4x.fsf@gitster.g>
References: <xmqqplwyvqby.fsf@gitster.g>
 <c329d3ed43f852453ad78ba430363416@manjaro.org> <xmqqle7mvp4x.fsf@gitster.g>
Message-ID: <31285decfdd9390cfea5cfdd558dbbed@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-14 20:09, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>>> @@ -128,6 +128,9 @@ include::rerere-options.txt[]
>>>  	These flags are passed to the 'git apply' (see 
>>> linkgit:git-apply[1])
>>>  	program that applies
>>>  	the patch.
>> 
>> It would be nice to, while there, move "the patch." to the line above.
> 
> It belongs to a separate topic.  These files are sources that will
> be line filled by AsciiDoc, so there is no reason to make such a
> change unless the topic of your change were to make the source
> "prettier", which is not the focus of this patch.  Having such a
> change in the same patch will be distracting.

Makes sense, it can become distracting, especially in a short patch
like this one.  It's better to stick to the patch topic, and leave
small cleanups to a separate patch.
