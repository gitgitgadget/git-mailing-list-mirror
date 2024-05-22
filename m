Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92031442F
	for <git@vger.kernel.org>; Wed, 22 May 2024 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716413689; cv=none; b=fizD4lcEFT5DzIs35dEX4/at9Oa/iR7OtzbWDeDE2EQJYMQTgqFW3H6BK+aE16XGPZLnESGKqbuBU+QOxiq0MGumtXCCS+lXbvyOkkRgbWI4fWdTDEYRBC5WG08GTsHvrsNQmA5EfF9xvRu7cJfiYAaey38+OJXORqFGyv2GgEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716413689; c=relaxed/simple;
	bh=+bYOnP0qnoI45MaAEouWjWAlmrpy6uPm7oNGUCsMbmA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FLg/pmop+rLF/qAfXWzuzugP4dvtYHUCkWsQAcy4+U9BfDGvdPgu01UAUz76NesSEbEdYO3kcpHx7kbsfmDA3Pg6wyDQ3mvYX6SnSwoFo/w0XpSuAQbqAbJpq8JXx6/Kk7GrhVogSDB082UUi3ngv7xpV+xvPapyNwiHk25LnG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=RK2blANf; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="RK2blANf"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716413685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SbtOo8h5dhzmIS6uap8D5N89Tk6h6ECwhnLYPobexc=;
	b=RK2blANfT9rNjlB7i8b8Pd+MWvCxg+RpcMqP9RTM3+Oh0ogiV4gEVNGQO50rgizODFbqat
	D8VAYI6g+Mc9IkuF9zs2fJKHYUqK085xUu1w7H1tyqa05iBCH8n6PR5ByUz9yDCmOsvsfj
	4LZlAJZsKNq7paY5nSuhYzP7+lC+5iZoo3Gb1aRa6Ef7LbJkEi0lA0b81Fude9UgOukU2h
	+vPIT3CVyoreWiH1068oj8pHRO2Gkl0ipRtO/fdUrZZHRljc312Vy5h1qOWI9Yi+wYGnY4
	zt+OA/5RDQM/9tc8fRiIQaa8NNG8kzpgA4A+A2thyr7CA+eyhMA4ou9pYB7cgQ==
Date: Wed, 22 May 2024 23:34:45 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, rjusto@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2] doc: imply that interactive.singleKey is disabled by
 default
In-Reply-To: <xmqqy1811qkx.fsf@gitster.g>
References: <7da73f15a018d858519eefa373001ccb3eaf32e2.1716412958.git.dsimic@manjaro.org>
 <xmqqy1811qkx.fsf@gitster.g>
Message-ID: <673887a14c4f74deb4ef7771a331689b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-22 23:31, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> 1:  3141fe9f7328 ! 1:  7da73f15a018 doc: note that 
>> interactive.singleKey is disabled by default
>>     @@ Metadata
>>      Author: Dragan Simic <dsimic@manjaro.org>
>> 
>>       ## Commit message ##
>>     -    doc: note that interactive.singleKey is disabled by default
>>     +    doc: imply that interactive.singleKey is disabled by default
>> 
>>          Make it clear that the interactive.singleKey configuration 
>> option is disabled
> 
> Heh, "note that" would probably be better, as we are going to say
> "Make it clear" anyway, no?  That is stronger than just to imply.
> 
> Keeping the original version of the log message probably was
> sufficient.

Yeah, but I felt like it needed some adjustments, because the patch
itself was actually changed.  I hope I won't have to send the v3
because of that? :)

>> +	When set to true, allow the user to provide one-letter input
>> +	with a single key (i.e., without hitting the Enter key) in
>> +	interactive commands.  This is currently used by the `--patch`
>> +	mode of linkgit:git-add[1], linkgit:git-checkout[1],
>>  	linkgit:git-restore[1], linkgit:git-commit[1],
>>  	linkgit:git-reset[1], and linkgit:git-stash[1].
>> 
> 
> The resulting text reads well.
> Nicely done.

Thanks.
