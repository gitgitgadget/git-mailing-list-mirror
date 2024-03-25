Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90AF5B669
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401465; cv=none; b=Bw42xlOhadXAq0vYmH2D4XKlJD70OPfAEmueUWCdPU6ZjBuabEOkDfVuEX8ca+CY2G6pcibI6FQqgRB0iyWP95gHcIRzjXxo306Z3sJkNiRMfL3DofgwWot2BJd0eTZdHGrXAv6O370GKMeVPcdW2gkpybt66JrOgqrgzzVpsVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401465; c=relaxed/simple;
	bh=L1LuIMX0K52MdET7YY1fhoMj+bqJ8a99Rj7Vth8nQfg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pJAsYH1CldBTXTql5A4MsrpAV8RFgNcvV8Mz2qOKmkiSYG/agST7unHk1rIOYIZzkaJiHFi3DgedCVnQnu+2OInefIvvuZSlY9+KfG1r+nEYazS3U16SIAX2lnlGllCgcE0DecZayGWMRgREqbbXucs8WFpQPrQA38XNfOKECSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Qj0He44m; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Qj0He44m"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711401461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7k6czYHezVF8O52M5tfSfP2p7swQGFejAUWnx/0wNPM=;
	b=Qj0He44m77eOoyvyqXUq7ikCIMdewDN4MEs6e/er+f4bZFY3u74FD44GgHa2PJ6bzYOrDH
	iCo+PzshQ1aPeo14dFDtJWNBzI1WbRPCM65flShOXwokCBpChfrJJ/+nD38MCjOWGhVWRb
	pQQVv/AS7JaFmp2D5ytXFEqJNNwtxwkqH4WaqwY4azLXp0FiEFz3hqD2cH5xLlT8kvnzLv
	yw9m/oOA7zF5NxhSFoKgCKfuydqV8ortnurL9KpJ8Wbqyd69NhnO7APJ0/o7c2e/LqCblp
	T0Xtie3IEMEe89ymrUcoyHsdMpwNP7pUTn9gEJlQxY+AqSJuquzJoAK73DKHhA==
Date: Mon, 25 Mar 2024 22:17:40 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jn.avila@free.fr
Subject: Re: [PATCH v2 1/3] grep: perform some minor code and comment cleanups
In-Reply-To: <xmqq5xxahvmi.fsf@gitster.g>
References: <cover.1711302588.git.dsimic@manjaro.org>
 <55867253d2925892f5192dbc3145f7bc9221b791.1711302588.git.dsimic@manjaro.org>
 <xmqq5xxahvmi.fsf@gitster.g>
Message-ID: <ab5145b696565ba170c90e2fc1b9a7e1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-25 22:03, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Move some variable definitions around, and reflow one comment block, 
>> to
>> make the code a bit neater after spotting those slightly unpolished 
>> areas.
>> There are no functional changes to the source code.
> 
> It cannot be objectively better than the original as "neater" and
> 'unpolished" are fairly subjective.  Let's leave this out and take
> the two "obviously good" documentation improvements for now.

That's fine with me.  This "experiment", so to speak, has also taught me
not to pay attention to making the code "neater".
