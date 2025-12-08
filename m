Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8C0328277
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765204198; cv=none; b=fycufFki1nsSsqZ23WSa3i94vfHB/RNw9i0pCzxRzo1MNI58UIdSpn/2X+onrH1/LovHtybcW2Djdo2GxiCv/tbAr1DOVSue92P5SCLo4TpQ/Ys4bRdA6jylivp1JCVYDzYs/uuC5axqj6ueGTd4LjVcevd/T5siwreQWejfAkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765204198; c=relaxed/simple;
	bh=RuPneK+ZjeTYonDlFG0PrCAxUsIHcU/q4VkzyY4mm8M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vnjnh7mL6oBJGvEH9nYFTBsrkmYvY7u4MPuhuscg+2/40c0gTplbqHQdB6HYTfoloZA5Q0HnMfcX/n7hGZQGQwXhlrixpbGe1Mvi6P8C7O58U+9Rb8aZbxy/ZvhYwimyowz+2/UaeftrQ0g9t/K/GJlyvh9l80jAKG0YfmjJGuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=epPQKWO7; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="epPQKWO7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1765204191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NlC5HpCJj4jlrZ0/PP+24Ji1r00ClUJ0MiMY+E3fYZo=;
	b=epPQKWO7cb1Z7ncJDHBCMGklEADzwk+naqsGxWU7mEStzqflZiCQSJBRGOcAs1IHCWdrWf
	rWgaybMXsfAu532Fqsjzuiu7Z3LeSxqJIMmh3NX5PCTfz2jk3ecAKkx3X4BdDXketCcxJ7
	N+faciSoc+2rouxXpyYYZVV7tcCnG0k=
From: Toon Claes <toon@iotcl.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano
 <gitster@pobox.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Christian Couder <christian.couder@gmail.com>, Elijah Newren
 <newren@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: Re: [PATCH 0/3] doc: replay: improvements like "mention no output
 on conflicts"
In-Reply-To: <d2a72ba5-ac7c-490f-9f2c-6cf849e65180@app.fastmail.com>
References: <CV_replay_conflict.101@msgid.xyz> <xmqq1pl6lzt6.fsf@gitster.g>
 <d2a72ba5-ac7c-490f-9f2c-6cf849e65180@app.fastmail.com>
Date: Mon, 08 Dec 2025 15:29:33 +0100
Message-ID: <877buxvygi.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>>> Explicitly say that conflicts do not give any output. I found this a
>>> bit confusing with the current doc since I am used to other commands
>>> complaining loudly.

Yeah I agree it's unusual, and I'm considering to submit patches to
change that behavior. But for now, thanks for adding these docs changes.

> On Sun, Dec 7, 2025, at 22:58, Junio C Hamano wrote:
>>
>> All looked sensible.
>>
>> The second one looked a bit sketchy, but that was the phrase used by
>> the log message for c4611130 (replay: add --contained to rebase
>> contained branches, 2023-11-24).
>
> How should `--contained` be documented?

I understand it might sound a bit cryptic, if you don't have any prior
knowledge about this command. But on the other hand, I don't have any
good idea how you can document this in more detail. I think it's fine
like this.

Overall, I agree with these changes.

-- 
Cheers,
Toon
