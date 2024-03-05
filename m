Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58867944F
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659233; cv=none; b=UhKjDFas4F7t6rN2BdX/QwsOokWwduGDNjc4KTUxleYyt9L9rV8/8NAsji3Q2a9rQ9n6DSQI/6+CDaJlL+xscW5wE6CSdIbxj411SVgnm6+oXjFdJuJPu1rURJj8z+YBVLp+M6NSOw9WPyeBceNOF/QpcAefScPwRdGx8NhdW3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659233; c=relaxed/simple;
	bh=xMMjucMvduiCNMcvP5wgOpaZV3bbxG9K+7kT9qpV298=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Ka2+wUhNPiZB0L5E1wtPvXQyhziGQLXfz01qKKj+RS9I+vG9U51tIoMETvf0BMVA2Ey0v/CI5SzPbQ9GWyZ3kpTQuVXrFPjfwdXTA35/eHbrgE8/YRgc5yaNZQKEzyc6rItieDRLBdpDEQRPLcqg84d6IcPkPGDgv//2WHQvNtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ntNTeTeH; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ntNTeTeH"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709659228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3t4Wz8BDI5AMWcjBiq7rH26XbRUd2ehxuCfgE7JFuy8=;
	b=ntNTeTeHApPIlzwkb6rGQNr3LgoDMdhBGJT0eGZgLB2ojQvnA68YOQXIO0tAc7v+0dWtNU
	rkhzUK4xDrOOF98CrmLIU6wS3FBTL+Yc6nnHiv7CCCQJGFAGixIXuRHlHH1iP05TqPwi/A
	gFSkMa4JBJ25yUGQHQlWc2uyXp/H2lmEoVEO6NVO/yOSqXSQaYu2+l6P/1j3zuXPTxwk4N
	+Qo4GMXejrE8ET4Nup7WTO66nS3CxrfnEWBS7hiLvju/W+to/SUjYVDo+2T+db3+Vx/aRH
	Id+2RcYkVLz3k8yhXcHen7+CKa3ODmCFT1YEsqg4NWOyz9+wFlU0pI+Mwj9o3w==
Date: Tue, 05 Mar 2024 18:20:27 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Manlio Perillo <manlio.perillo@gmail.com>, git@vger.kernel.org, Junio C
 Hamano <gitster@pobox.com>
Subject: Re: Clarify the meaning of "character" in the documentation
In-Reply-To: <3bef4fef-0a00-4ed8-878e-372c4d8f552d@app.fastmail.com>
References: <CAAToxAEE-2B_8Wqrquk1peOnqTbOpV_8KZmsJ2dgk-mfCZXHiA@mail.gmail.com>
 <5e10f1e5-b87f-43cd-ac1e-d7c01b7dad21@app.fastmail.com>
 <xmqqsf1466eh.fsf@gitster.g> <52d6850914982ffaf15dda937d611ffb@manjaro.org>
 <3bef4fef-0a00-4ed8-878e-372c4d8f552d@app.fastmail.com>
Message-ID: <1e71ce757c3d773fd7354cd12473b851@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-05 17:58, Kristoffer Haugsbakk wrote:
> On Tue, Mar 5, 2024, at 16:42, Dragan Simic wrote:
>> May I ask why would we want the comment character to possibly be
>> a multibyte character?  I mean, I support localization, to make it all
>> easier for the users who opt not to use English, but wouldn't allowing
>> multibyte characters for the comment character simply be a bit 
>> unneeded?
>> 
>> Maybe I'm missing something?
> 
> Personally I think it’s okay. `%` for example is a good candidate since
> you seldom use that as a leading character in prose (after a
> whitespace), and it seems that `%` is often recommended as an
> alternative.

Isn't '%' actually an ASCII character?

> But if it doesn’t make the code more complex: why not? (I just
> personally don’t have a use-case.)

Frankly, allowing multibyte characters as comment characters looks to me
more like a programming exercise than a really needed feature.
