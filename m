Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641B6446BF
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710343691; cv=none; b=pCbDW3JlvUrytrI6vYpawjZHlqbL0rHwM2alTYB/YtnsFmoEURd3r/8FvSkFYJYJ3ajovTTLl9aERqge7mDB07p+BXmCTRT2YAjW5FdchySnFIO2ane46R7XaFJPVxU7HKWrHdntmICKiJj6mkJZfw/Es9UiHWmnq4j1OdoT23o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710343691; c=relaxed/simple;
	bh=9nuNZMo5C9fxAcyKwmjoFpioAZy10cGM8aXtXMaHX10=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FkftQGUvFb7IpxhoCkYTq5fkyQV9f/1/HNH7T7P2h7OKHNRehfSL5jMmNFqJtXyO2jFAZyvGAxwWjXndUPJT+saXmlE9VCMouBDQnbAR8qC6B9ETLYe1H0qgq1++92vrDSvKp1fNS77woJACMEdoxfghb7w1ZkbcEBYQxAGF2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=uH6WNx0K; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="uH6WNx0K"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710343687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6NekNwi9cPm1xMDorBx0ZICLhAU2mjC4EdXURtXuzlU=;
	b=uH6WNx0KG2cOZp0ZW2e+WN4Lon5kj9Pmgt7sdEQdlTajfUvn04YoByvj35zSj/9F9sMS/Q
	4iQCvgftPolIgORhDbTf50Z6vM9GBOTmknjaY9nzOVrUZkgUmKj7jfRhMIvu+I6VZgSEyd
	Ev5Zi+7TZI9H+AFfHUWomb4lAv6eXooMP5CLXJsjuYEZCPOp07TSb0iGuI6PiMHaiMQEm0
	xDmLotmiHQzxOIlpwX8keZN/KJCV8x4nrenCE5z+t+1Xc75ASCe0kD3S9WeFHjz6vwlFKN
	FWq+bbv06feUct712C4hl/qNiMHcN59AZ31lFLC5+ImfVAUdtCru3PUPt8az2w==
Date: Wed, 13 Mar 2024 16:28:06 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, Peter Hutterer <peter.hutterer@who-t.net>,
 git@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v3] diff: add diff.srcPrefix and diff.dstPrefix
 configuration variables
In-Reply-To: <xmqqil1qf93z.fsf@gitster.g>
References: <20240312231559.GA116605@quokka>
 <fac4fec23597bff0f4594112d2a9976d@manjaro.org>
 <d15eb4b0-2ea9-44d7-af5a-2ea1162294f4@gmail.com>
 <e14ec355d447e16a794f313543dccf5b@manjaro.org> <xmqqil1qf93z.fsf@gitster.g>
Message-ID: <a4a45ec18e3e28f79fd278e34ea928e6@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-13 16:24, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Well, I required nothing, I just noted it.  Such a small change can
>> also be performed by Junio while applying the patch.
> 
> Doing so is trivial.  Having to remember doing so when there are
> many other patches in flight is a burden.  Don't put things on my
> plate when you do not have to.

You're right, there are more important things.  Sorry.
