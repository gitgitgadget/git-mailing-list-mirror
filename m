Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837862C69E
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 07:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300859; cv=none; b=hOR5jFURHw7BKhFE+hqRLzBCybG34HTKNhjTujm28p5Tdkwf0ByO3P7djJ0VFTLVTP81eNqX8EKhCQuONg5WSHkvxcQmfditt4AEvf/3aJ0oP2vfKmDtlXIrSRAUw4qRlb8faGjCqFRrHrPD8mpMKJ51031vx6AthaTO6rR57vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300859; c=relaxed/simple;
	bh=rXpMTPasOIt9crMnaCULfrjnE29yFyIH5pmQMF7XUmU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KcCj50WaczJpi2JoaGPAcRCwWawGIG1Lhlxa2oSE3PnO7wRukQdAIgbaKJJiAVh4/LjO92ugrnjTtvM4v2nKfUyHg8qs5C/5VxkjlLu4MuyfDD0S7OC6JKia+jVWJ8NTvShyCGlLYhs12m4LHlFROeaBc0dbr6PDKaWhufHXq7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=TlbazZLA; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="TlbazZLA"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712300853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9imnx69KCiH0vtn5unBRA0yZy37QyoIPFI56r42olaY=;
	b=TlbazZLAqfAsAAq5vEMh0EtBsyjpVQcuP4rxbsARUbShSTy32gNezWMZG3BisLqfNH2P1R
	ed7c1d4GNWMGv1/W5rqEPDr5Xidb2PMo5clxJAW9mX2Do4mhibaXk/pfW3wDsJzDY9Q8eS
	Vogse8Ay+qRAvKqnYEqMLIKxZv5JbuN41YHslviiekNjx0qget/rZ/WWrr3SvxNvqpnoa/
	BHNyn2XddsKVJOMXE9dOYew7lZCe5K4Vw/hhHe/3buVhse0X7aAOewoll8lHPQSTDw1rDe
	wXV205igAvlPwtdqKakuGJ0sz80Fz7rFVhvgk4Uot4K0bAiavRC5xKKGkQnZTA==
Date: Fri, 05 Apr 2024 09:07:32 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] send-email: make it easy to discern the messages for
 each patch
In-Reply-To: <70c97d51-b26a-43f3-9856-af405f396576@app.fastmail.com>
References: <0e087ed992def0746f3d437253248904c2126464.1712262791.git.dsimic@manjaro.org>
 <70c97d51-b26a-43f3-9856-af405f396576@app.fastmail.com>
Message-ID: <37827a9d31e494074310024b86b242c0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Kristoffer,

On 2024-04-05 08:52, Kristoffer Haugsbakk wrote:
> On Thu, Apr 4, 2024, at 22:34, Dragan Simic wrote:
>> may be seen as redundant.  Though, it doesn't look too bad, and making 
>> that
>> last newline not displayed would make the code much more complex, 
>> which would
>> not be worth neither the time and effort now, nor the additional 
>> maintenance
>> burden in the future.
> 
> “Not worth neither” looks like a double negative. A double negative in
> mainstream English leads to cancellation, unlike in some regional
> dialects where it acts as an intensifier of sorts.

Good point! :)  However, that part of the patch description has already
been deleted for the future v3 of this patch, because it treats the 
vertical
whitespace as separators, instead of as terminators.
