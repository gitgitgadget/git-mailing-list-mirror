Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1974C65
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 05:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717826088; cv=none; b=bKhO4j3F8rQnMqzRpVZx8vODx468TyrudUJfqQrg8LcOms0Ws0+50u1tC2Hxuiy+qfFs7VOH4QRgFrjd7sxe84TCwylILSo0/WYcpX7oyUHFUnfXcEmhsqsPqYmWc2o0Cuxu14wAjbS1tmN4K/tmTyMBKNsPQbIOALXJfnC9q9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717826088; c=relaxed/simple;
	bh=VvC5QvzGHBr/+zl0n34no7JXUCCXSK1InG3LAa5rVsY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MEKTtYs98VZJ/o3Rat+1A8pXAv0C8lpzcFPdTrx6PUVEsS2su27dE8aGm3N5lPrqFOKO8c+a+p2T25/MgiOAq5+zBCuyqpvWnKQdjHDQw6bd+G3iEN82F+i0v/CHUNMhqQ7SFW68ID6G02kQnEEwTnYUNehv6m7HvEn8QbKqGaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=cZA7QH7n; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="cZA7QH7n"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717826076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYBQuY5BNEuPkZSLSgRSivyTMxQPw3dkOcqfpHgocL4=;
	b=cZA7QH7nIv+bG9cEPOxHZpAveghqDfhOtx/H7S7D99LaecGb6FsJH4ygI0bxp5qp92wHS/
	YtV+Zvc12MUfLdjHIQWaQeucqooBLpkkKo9idlsmHiikw/GKTwx+r/l+2GSB9DRoxHPkEs
	eJsWPZI5PHsSa1Xh9KYa0iBtagcX7UWlvEbpdQ2PH+V/rl6655Yk5EPj1wYD6izkG/qI7t
	zEBtuU5BO4Edn7lm2OL+HVxuoKkhiLqaHPHvXft3NiznOWa40GZMr9rsdoeTpSrCDxqUyI
	DdeTDDcHM8y6kwraX8VCuJoQWVv3tUBzbTiYC5nQkgpMvG3AMmY94HM7uAk/nA==
Date: Sat, 08 Jun 2024 07:54:34 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: phillip.wood@dunelm.org.uk
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <6056d585-6380-43e7-adf1-9f9aadd2a7db@gmail.com>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <20240604101700.GA1781455@coredump.intra.peff.net>
 <xmqqikyo207f.fsf@gitster.g>
 <20240605090935.GF2345232@coredump.intra.peff.net>
 <6056d585-6380-43e7-adf1-9f9aadd2a7db@gmail.com>
Message-ID: <a8d3415e3913e3a0798a748ed7f7a093@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-06-05 15:21, Phillip Wood wrote:
> On 05/06/2024 10:09, Jeff King wrote:
>> On Tue, Jun 04, 2024 at 08:32:04AM -0700, Junio C Hamano wrote:
>> 
>> Given that the main use case for "|" is for human viewing through a
>> pager, I think the colorful, filtered version meant for users is the
>> best default. And then the "bare" version can come from an alternate
>> command or a knob.
> 
> I think that's a very good point. It is hard to see what "|" can be
> used for other than viewing the hunk as (a) git does not read the
> output so it cannot be used to filter or edit the hunk that is applied
> and (b) we pass an isolated hunk so the post-image offset in the hunk
> header is likely to be wrong and there is no indication as to which
> file it comes from so the program being run cannot apply the hunk
> itself. Having the escape codes does make it harder to filter the
> hunk. For example to just look at the post-image as one needs to do
> something like
> 
> 	grep '^[^-+ @]*[+ @]'
> 
> instead of just using '^[+ @]' as the pattern but the bonus is that
> the output is colored.

Agreed, but as I already explained, [1] only when using the bare "|"
command.  When "|xyz" is used instead, the version of the hunk with
no coloring escape sequences should be piped to xyz.

[1] 
https://lore.kernel.org/git/844704794168f9fcb85c75014c84cde0@manjaro.org/
