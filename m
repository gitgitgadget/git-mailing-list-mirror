Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BE83F8F6
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183878; cv=none; b=tPWdtLLm0J8rF2Rm2gvAATBVUafL12kOnTsbnZxKiTQfg72ewyPB6UKx4H5UfRzubuw+toewW4P8KfIauqSxi44A11BpHF550OE4KWIWH1iLfH4H9W/eLb1Rtd5goChsLJPQHl2IBs2jIXT4MsB5I0fWMOSFfqBILoHNlOJzEek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183878; c=relaxed/simple;
	bh=Nx6kYy2JVlr7BcP6fpOCkzHSZ1oP7LWVwS70dsq1LoI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YP49B5sLZDQnCLCwogMEACEW6wtoUyUzqxTgQezFLk1i/nuVsbc+1Gf5kc0DHCtNF3VtJNH/JbNCxkk6Ju1Lu71eFY+32i7ehFH2moWKVAaStrcwDXuEdMiqRuwtrIWjJvmm7INmU81t28qNIGxdDylBYcDcmMEsZ5orR+hlGW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=U4hv95ND; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="U4hv95ND"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710183875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SxiCrrbH72IRDYuUq/WtOboF8WFsJ77WUTtV57/dccE=;
	b=U4hv95ND7sYdYqE6N7plvFSzVpSBxc/emXArcY4ftdu782dDt47FzoPP5vv7f6LQ4p6PO9
	T0drKWClMG+LfwsNRJ3wiS0s24rELQcAJMgLfTHBGUi6Tobq4oOUPimZRHavlTASDtT+Vl
	o0Hh0vrAcR/RgKe03FTj1JSxTiNPPQGyxoeI5ukCPD64RZj05U7AgLdvB32Jof/Ce7ujYC
	hXmAmtupAVdbJNTxNKHX5cuyp5QLn7OdWgtErKt3xuX8dT3Hx+03XpGmC1XdEcFrGqj+jh
	XzFuDyYyO4/AjZh8Pb/HZn/JwSxHIDHLsqfHMGYxmuY6fmJR2Od9ScoYDTqVyQ==
Date: Mon, 11 Mar 2024 20:04:34 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Ralph Seichter <github@seichter.de>
Cc: Junio C Hamano <gitster@pobox.com>, Ralph Seichter via GitGitGadget
 <gitgitgadget@gmail.com>, git@vger.kernel.org, rsbecker@nexbridge.com
Subject: Re: [PATCH v2] config: add --comment option to add a comment
In-Reply-To: <277b3187-f793-4782-aa18-50bc15febe9a@seichter.de>
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
 <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
 <xmqqy1apudvv.fsf@gitster.g> <5eff951e815e2fdab3834c4aa4160ed8@manjaro.org>
 <ba6d65ca-8ae2-4d93-a5a5-e0b60768c302@seichter.de>
 <265e5b2d352c34dfe0625904b3356000@manjaro.org>
 <277b3187-f793-4782-aa18-50bc15febe9a@seichter.de>
Message-ID: <349b8a67931a2fddfff35db393023bf0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-11 19:57, Ralph Seichter wrote:
> * Dragan Simic:
> 
>> I mean, perhaps the whole thing with the tab characters may not be
>> the right example, but I just wanted to point out that the more
>> major an open-source project is, the more discussion is often
>> required.
> 
> Oh, I have no qualms discussing things, but over the last 40+ years,
> nothing good has ever come from debating the pros and cons of tabs and
> spaces. At least that's my personal experience.

There are pros and cons to both spaces and tabs, so there's hardly
anything that can be concluded about either option being better or
worse than the other.  They're both good and bad at the same time.

However, I think there should be some way to allow the users to choose
the kind of spacing between the automatically added comments and their
respective values.  Yes, readability may be subjective, but I think
that the users should be allowed some kind of choice.
