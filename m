Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D292311CA9
	for <git@vger.kernel.org>; Sun,  9 Jun 2024 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717919852; cv=none; b=lU4DIFL9h5fikjNKgwORcglW1eXCSnqF2vGXAUltihisfmKD8kCx8PJHVbS3RaE230+ZHHkgqyQJW/DmKKBcNCZQIvigpmR3jydADobEeAC9KidwlY2e8BGYaRB5a/PEqYPHPfpCqoa2Mk+VEdzFiZPwi0qAHfwGqmfrWeQJ/G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717919852; c=relaxed/simple;
	bh=44LqCbI1jXimNicQ2BH2ENDcszaAk9ZzHiJXbn7YsYY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rLI7+kSBcrkSBEQJjnnYd/6Y6NjZLOAxfKOkk2z8reCPOdAiqIpEY3wGELHY927Fzr3ry+05oWkH8iFn08dsGvjzz2KjqK00jrbhCM+HW47MLQKPFveXN2lGPe4cltSnpkZlup9jwA5UX6Q2h7xZmu3U2h9GkiHQknJlY+6G6Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=TgjI46Mu; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="TgjI46Mu"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717919840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXbld2jk7ic8pzrJmPkHkdB6ZpfSY8Tyk6yOGxW0mhU=;
	b=TgjI46MuqncWUUBRrtkxFOOOAUlPRQ+0xmhLUYzSXnRnOqHZ9aruu1BVI+TbsxLHmpdxua
	jlz6JdhdV//Ws3t0Uer4gdw1UxpZbh3yVvk2B+Nhqdjwtq0JvpQf3FY61oZMSFF+cxZpD2
	1smfNRViJ3SUm5TnqnQylnwotdCqJqlbDK/2A7+kaaSBQW60LHSG0s/1+oFy4FL4vbnbyZ
	0gwCoeJRTtOKIYGj+1G27xwNbNODLn34jl2l1PvbM/fdHd7TrN4e8yzBGficdkCN2CfqcX
	C5fW+34zDntmEqpA25ya8N30qLfZaRb67Fa2U+zum80fzwO2GTwjPTI+UK1q8A==
Date: Sun, 09 Jun 2024 09:57:20 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: phillip.wood@dunelm.org.uk, Jeff King <peff@peff.net>, Junio C Hamano
 <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <219a195c-74d0-4c21-bf54-0752bb5b01df@gmail.com>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <20240604101700.GA1781455@coredump.intra.peff.net>
 <xmqqikyo207f.fsf@gitster.g>
 <20240605090935.GF2345232@coredump.intra.peff.net>
 <6056d585-6380-43e7-adf1-9f9aadd2a7db@gmail.com>
 <a8d3415e3913e3a0798a748ed7f7a093@manjaro.org>
 <219a195c-74d0-4c21-bf54-0752bb5b01df@gmail.com>
Message-ID: <7937845d7cb7ae0179c4922ed154c5c7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Ruben,

On 2024-06-09 09:44, Rubén Justo wrote:
> Some concerns were raised about controlling when to send coloring 
> escape
> sequences.  Several ideas were discussed to address this, including
> introducing a new command ">", a modifier for "|": "||", and others.
> Alternatively, we could leave it up to the user to filter as needed.
> Or, simply, do not send escape codes at all.
> 
> So, looking back at the ideas discussed in the thread, perhaps a
> reasonable next step might be to reintroduce the 'P<program>' command
> and let '|<program>' be the way to send raw, uncolored, chunks.

Actually, it would be better to re-introduce the "P" option, without
any parameters, which would display the current hunk through the
already configured pager, and let "|<program>" be the new option
that pipes hunks _without_ coloring escape sequences to "<program>".

As a follow-up, after the dust settles, we could add "><program>" as
another new option that pipes hunks _with_ the coloring escape sequences
to "<program>".  That would be a rather clean approach, which would
also reserve the "weird-looking" commands with additional parameters
(i.e. "|<program>" and "><program>") for the more advanced operations,
while the "normal-looking" command (i.e. "P") would be assigned to
the, presumably, most commonly used new hunk operation.
