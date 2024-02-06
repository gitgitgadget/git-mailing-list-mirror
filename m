Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A025F13FE4
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244628; cv=none; b=fuIddF20qKz6xWBrZkNMsK/WaNd6BKpE1F6R/QmoDu4bFvkWOBn4VK/eRsl7SDNRrY+8Xr5IKL5Lp++NjeXrxst0YFZTTlilToaOk/w1BV8r1Ie97JKQqIQLK2oGaCjO0t9R3hHlNmkeK4U90oC9WLlZndCiP2K0miWcIkCVMO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244628; c=relaxed/simple;
	bh=5xDnck1Rfy25pklrFyBjWxcLajuQKDY8sSRK7G12DI4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=V/e6BtvYyCSBDjuevagQRAPHXQnYtl9LLVdrvny8vO9V9aVT46sWI8Y7Ie/XIBMntmX4B8QvB3VhfgAgjjhNWSi0S3AJ/fpTmZYHVSXpv4xXRYkCFJCkvf0KgGOlmaAMOTMo84atogD5lHs9Id/CW3XeLmTbc68A8/cLGdVGIEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=qMePdU2a; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="qMePdU2a"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1707244623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Ck2Ajddh5yhBE+TDb/ghrMhCwDdBQuEfaaSJcBOjAs=;
	b=qMePdU2aZu0A1ELQDEux0lzFrIbing1iu8TJikRQ3CA1QxK6cEUNc3wfwPxjhNurIuHHY5
	Btk/hyb9DK+35jFqHH12LTS8miaUBtlMnruG83UnCi/4d23WOqIt1DykY4TBWD8JKl/lPk
	2tobDZoDIAVioL2i9BhKAblgC1uySUqkY2iML4h9jqunuDhA91M9bN6Gml/7QrWoGoQM44
	HzqS2lx+D0+Hn3gxXTVUDrEJjQwRvzM41VYbMiaIVvtdmtXKc+J2MjgdLa1+e2cKT/CCBu
	cY/yi93Y7PtHR/LZBSf5g5NgqkKlaV3X6aplzIHRAo0ufjVZayriBYU7O6y1YQ==
Date: Tue, 06 Feb 2024 19:37:02 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kyle Lippincott <spectral@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: clarify <oldbranch> and <newbranch> terms further
In-Reply-To: <xmqqle7xih0s.fsf@gitster.g>
References: <e2eb777bca8ffeec42bdd684837d28dd52cfc9c3.1707136999.git.dsimic@manjaro.org>
 <CAO_smViHVZRObZjg0tEPXezJZb7wvs9LQdHUFJQTK4-ASCfrmw@mail.gmail.com>
 <xmqqttmmlahf.fsf@gitster.g> <8f588db87929b063462dbf4ff134adc7@manjaro.org>
 <xmqqle7xih0s.fsf@gitster.g>
Message-ID: <59ee31e27daff7f9e9f6c4a3bb81086f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-06 19:28, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
>>> I think I laid all this out and more in a separate message.
>>> https://lore.kernel.org/git/xmqq8r4zln08.fsf@gitster.g/
>> 
>> I agree about this as well, but that will perhaps be handled in some
>> separate patch for the git-branch(1) man page.
> 
> If you truly agree with the longer term plan, which includes removal
> of the bullet points your patch updates, then reviewing further on
> that patch becomes a waste of time in the larger picture, doesn't
> it?

Hmm, it doesn't seem like a waste of time and effort to me, because
the first patch would move/add the descriptions of the <oldbranch>
and <newbranch> arguments to the descriptions of the branch copy and
rename operations in the "Options" section.

This needs to be done anyway, if you agree.  The following patch would
either dissolve as many sentences from the "Description" section into
the "Options" section, or have those sentences converted into some
kind of more readable prose.

I hope you agree.

> "Will be deferred to some later time, let's take this small update
> as-is" has already been said back then.  Let's not do that again
> this time.

Oh, I've also heard that too many times, and I also know where such
an approach usually leads.  Nowhere. :)
