Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3A055E7F
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 23:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038578; cv=none; b=DAVS+Z6p3oTXgUUv1X1uopADy8Czk88mg6H9vfTWgZFt+Hxgwk1g8gSMUIsi2SbUWvRuSQm78sKKRGoYewHhZOU9Dn2JerQSHgrPN7hrGqZXSRdYBYuQ+QceDJaaTYbahO212efNeldOwwDjOZuB2Y/1Lzj4WgMGUPiiQtB2sWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038578; c=relaxed/simple;
	bh=y3qhJRxTky7YStri80W06+95y90Pkmx9rMmWDqnx5Pk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MIB3n3Ogx/Y/Ebqk4K1nJt1sxDmcBDt5yDllwr/EwV4qJAHI3u3r+sNRlrcArGTdNzQF3E4dvT1XYqiE5AOffGVexuLlodaE+1qSjJjdNCy3Bt1+/fbP+da9wC4IBM+Mt70NsanmU3jfGz/RpKH943R0OFog+N+vmMlQXajisfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=lG7gfYgF; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="lG7gfYgF"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708038572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuqKllgtmYSLgENHBbYCR/aUL5JlbqsrI1G3MfEzYLs=;
	b=lG7gfYgFb1mIZq0NS6RoKrknTG5xrnUa/E9PEkDcNcVo4j6gZdxCqx1/QFbtXSklV7GJpy
	KXxI8HueHmeecx+xnpKSH3IBIVuLEfVd6gnuIRbCBZeDsYmvSC1UhqblcuhDwQtnwmtvZB
	V8qjlApRK1A+8zQhUlC6WLbUSwl1lbLEAWbKPYFl/fph8yWE1uVL7IP1pRIIJ/EeOIWFSR
	dKe/bbyT/XuW618oN2loGxX1yU1kh7kM9GRYKunUJfisChjE+k6UTLbQv0CAdRxK57WKTY
	ZtmZQITF0mNagOovVKxB3NTvTxuQ5YU9snC1A5nFJRyPxslnefz2i+TDes1jxA==
Date: Fri, 16 Feb 2024 00:09:31 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy
 operations
In-Reply-To: <CAO_smVizZ6K-tSSubr7Pd95zn42GAHrgeeSQ7ZWmKdPH7gMy3w@mail.gmail.com>
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <CAO_smVioz0izmunDRyHjU_7GGz-_Om_6AVw2CZGFyb4ZF8yedg@mail.gmail.com>
 <e02b953f3320eff7d6ae2ecf684c8be2@manjaro.org>
 <CAO_smVizZ6K-tSSubr7Pd95zn42GAHrgeeSQ7ZWmKdPH7gMy3w@mail.gmail.com>
Message-ID: <c1d8d7ec8639db564d09fd50ce9cf82a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-15 23:56, Kyle Lippincott wrote:
> On Thu, Feb 15, 2024 at 2:38 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-02-15 23:31, Kyle Lippincott wrote:
>> > Very minor nit: the prevailing style in this document appears to be to
>> > have a single space after the period, but it's definitely
>> > inconsistent. I don't see anything in Documentation/CodingGuidelines
>> > suggesting one way or the other, so don't consider this comment as
>> > blocking, just informational. If we want to achieve (eventual)
>> > consistency, we may want to use a single space after the period now.
>> 
>> In this case, I went with following the intersentence spacing used in
>> the surrounding text.  Though, my brain and muscle memory are kind of
>> hardcoded to use double spacing, which may not be as prevalent as a
>> while
>> ago, but IMHO makes reading text rendered using a fixed-width font 
>> much
>> easier.  I can adjust if needed, of course.
> 
> No need to adjust if I'm the only one mentioning it. I'm very new to
> the project, so please don't take my style nits as any sort of
> mandate, since I'm the one that's most likely to be miscalibrated. :)

Basically, when it comes to the intersentence spacing, it seems that
double spacing has lost its popularity over time.  It originates from
the old times when mechanical typewriters were used, which most people
probably don't even remember these days. :)
