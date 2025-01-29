Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBFA19580F
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 07:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738136422; cv=none; b=K5nZrMdrAs78z49BTEaezEsTJLIXkGV/0ZNA400RXYhWF2g22p3r7RXmqHRDm7hwS3JawlRNYbzJeLmfd9olYAstQa2ZkiNVh2e+jvkwqEh+dQo06ZjQPASF451BwwvV6Oh7ui97SY7I2ru+JloYsM1R66q7jUTFnCC1SmSkKRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738136422; c=relaxed/simple;
	bh=7K18hCAmclDpthcA/NGBJRC5OoAr63KxyMBQaoD72s8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mwJ1uzWjj57qPcg+w1RQiC1WQJxmdNClBApXjK7agmp7+tzUpai7WTuJD87agObHw9OsuFK2LC2M4RUUN3TeWkRjrtKJME07tbtZwxAlRglksIaMiSfBdOkWYK/4a0JkbkfdDomuKvDqkgB9WquM3mHBlARRJijA+E6S+KyZg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4YjYwB235tzRpL2;
	Wed, 29 Jan 2025 08:40:10 +0100 (CET)
Message-ID: <37c14379-68e4-4c52-a08d-b78c7797ef26@kdbg.org>
Date: Wed, 29 Jan 2025 08:40:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] reftable: ignore file-in-use errors when unlink(3p) fails
 on Windows
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Reich <Zottelbart@t-online.de>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>
 <6acb9e8a-7014-4605-b8af-59c4584e9fe6@kdbg.org> <Z5ShoLCWREAsWZVh@pks.im>
 <267314c0-3aba-4f69-9f41-89392391290f@kdbg.org> <Z5c6VlsdNXwYkUsv@pks.im>
 <b9b548e0-e42e-4854-92f2-337a26f692ac@kdbg.org> <Z5iEcjJpUI3spSrB@pks.im>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <Z5iEcjJpUI3spSrB@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 28.01.25 um 08:17 schrieb Patrick Steinhardt:
> On Tue, Jan 28, 2025 at 07:52:48AM +0100, Johannes Sixt wrote:
>> The interactive question is only useful when the user has control over
>> an uncooperative process that keeps a file open for an extended time and
>> can find that processes, which is either obvious or extremely difficult.
>> As I said, I haven't seen the question since a long, long time now, but
>> I am also the first to admit that my way of using Git is rather narrow.
> 
> That would be a much wider change compared to what I'm proposing though.
> I don't quite feel comfortable with pushing for such a change as I don't
> have enough of a stake in Windows to be able to judge whether it would
> be sensible or not.
> 
> If Dscho confirms your take I'm happy to do so. But otherwise I'd prefer
> to continue with the more limited scope, as I know that the behaviour is
> unexpected and unnecessary in the reftable library.

I can live with the narrow workaround that you proposed. A more thorough
rewrite like I propose would have to cook for quite some time before it
can be released to the general public.

-- Hannes

