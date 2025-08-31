Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB9218E25
	for <git@vger.kernel.org>; Sun, 31 Aug 2025 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756661378; cv=none; b=Z6dJuXna5WTE54XquUUd8N4yX9O+UMYnasmYcP3wriZbepaWQ7OBwUc8tk/7T2EMwHtwkbm+qqSZBSxQTWaYemJro5MIaC9C6ZG4c6B0bk2VdADs0rrJzddKjdEKS1tutZtLvnOYnE6fWLYRzjp81LBZiDjMyt1h6PQ9bI+nkwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756661378; c=relaxed/simple;
	bh=Sqa1RyB41vmge2Xmn815jOHEm3yCGsSef5Iwivm2OAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dkZ7dl7KYJJJiDpwk+AJKkg/GEXkXKMeX7UdQeU2cX9QzzUC2gBrgZM7DkZjfSgYlmrXqIb1kGVTz929FctuzYhIi2thHNIgKY0i+lUeDlNnLlpvq8MTfEgTFi56QLIWx+vbk5MaBmWJ/QQArpoW0M54jgXh8Y1qwI657+uAqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=aRW3ky9H; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="aRW3ky9H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756661371; x=1757266171; i=l.s.r@web.de;
	bh=qPThEig6dkO/eRSY3bYhB45ARP0xk4Gf8QddTOLixUQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aRW3ky9HrKgdRV4hgvoPJGUXxAKpR3UR+9VslvI8BXuso9nDDDKaTD2oSGKRZdak
	 qv8KLSzmyxvV2l+fgNbZdZVyIdZsfR89qYJLTsHqqR7BgwdGXahbECYKEad7TsfsV
	 QGTVjWATR77PjWOAgXFmwaNRhC+7dBZ5YgfZ+Nn3Vvm07HHSr6S4yPu4CUoxxvXM/
	 l60mHPAkhvtR8VjY5HDUgjgyaCy5ABoJ2AJzRsjg4RFJmZ90VD/uaD91PKTOej6yd
	 z9luJxLZ0UwM04E7G2Jh117ahVEc3rrbF28PMzQABnXn02grp5Y4yHgks//nMFIvb
	 OTyNaW1twsOV6Kg4UQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.159.98]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZjEJ-1ux0hQ0LTT-00X3M4; Sun, 31
 Aug 2025 19:29:31 +0200
Message-ID: <fdee7ee5-21ef-4c5e-92e7-eb92fe07251e@web.de>
Date: Sun, 31 Aug 2025 19:29:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Aug 2025, #12; Fri, 29)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8qj1n71s.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq8qj1n71s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:io+1O+eu+jIedc0S6q1oK5xQCngYEpOqaMCHGKl7Q1bwTGxTZ59
 fPo8PTaPNtk3nqAkck+PaxVDqyaLX9Hp/NrbL085mOSQOumBwesUy3t3SPr6QZjR74UH/7K
 KOBHYfm2T3c9OwiSzpkJKOJCSJ6Lytq5wtk7yJ5MXGo3MFnB9QU890A+1gYgIAqWPICQdZm
 TFwoKeYa79+3/5yJW8x5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gpNlfWjVLA4=;JAjc7P0kEHpr0AtBTJN50dE1EgA
 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

On 8/29/25 11:37 PM, Junio C Hamano wrote:
> * rs/describe-with-lazy-queue-and-khash (2025-08-24) 1 commit
>  - describe: use khash in finish_depth_computation()
>=20
>  Instead of scanning for the remaining items to see if there are
>  still commits to be explored in the queue, use khash to remember
>  which items are still on the queue (an unacceptable alternative is
>  to reserve one object flag bits).
>=20
>  Will merge to 'next'?
>  source: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
Please keep it in seen for now -- Peff's proposal to use an oidset
instead looks promising.  I'll do some more measurements over the next
few days and report back.

Ren=C3=A9

