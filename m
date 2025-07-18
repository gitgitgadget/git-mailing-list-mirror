Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1901293C5D
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828923; cv=none; b=XXjDzW5sDhRtRzAWtlQee/5GJs7I0VOGRnPQIas57+ABofgXgR+KpprAgjUyB3cn8KX9mX8FK+5AHjY4ilS6xF+zTyPS1QZgD0d40sV7nR24cSVslPxGNuDZx4d6y4+qAFIsGJwKYi7Gs1jebewx8r1XxTUvpSQpDRsMK5gtlx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828923; c=relaxed/simple;
	bh=hKxsM8ofXpN36HrJPD3NVud8GIlTHWqqxn158kkGFO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iI9LBPG+gDrFBvJMZCnur46AaxIMok5VGSfl2POIv9UabOAy7gpN1d0iF9iNQhlpTB6VZY5YkGu1O1LBs+FsW2nABQ76s0nrAC/vT8FatS68OfxNlALflIh4Ypnd/a31bRm413Fjt8i2GZ0ZrAB33Nl2wWX8ycic42wU7Qbcehc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=OM5v7m11; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="OM5v7m11"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752828910; x=1753433710; i=l.s.r@web.de;
	bh=6V7UJ8Wvfzy1w7A18EWnIR83+j05+ZiSiodXHIoKx80=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OM5v7m11roMmGN+u9VZ/t9hvT0NhXaJDZG4tM+oOF6qsxyzUyHhxVe9qQCwd3hGY
	 ovqTOwAYq3nDRlmczbZ9YhYsi2xHX7uJXK0iZ6OAJInz2dZ8SopoACQx1cAq4orbB
	 GRSyKRmjS7b+wqj+DdVJAAZCvAdenU7ezz/11tob7QuzelKD3/tSGYeUm7EUh+Ddc
	 3xWnrcfov+eveeuQsYVWIp3C9AFtXSrhy1pG8i7GVZNSyOt/7peM1BgYq7yMPjDkP
	 dKayyZjYpwG68dRqmGq5gD4vFQfQIIHfcsPi7Lu4mdWl6JyOJJG7yhJQuZBYYg/Wt
	 LeDVFrQRhk8LtqMesQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6sBv-1ufxrt2aER-00uMdU; Fri, 18
 Jul 2025 10:55:10 +0200
Message-ID: <d0e9826d-a972-47ca-ab69-f1711efa4a74@web.de>
Date: Fri, 18 Jul 2025 10:55:10 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Jul 2025, #05; Thu, 17)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqo6ti49fk.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqo6ti49fk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ov5TXIYWkQPJLBlAaLFLf2ljLIcXC+cOi+xaRZRHeuUgIA1QrEl
 BOCXIdF/8MZXST66JQWWmJSirE0J81PEqPsSz0pPpMYKRqvZHmXX77S6WwMfmKv62qMqyxp
 Ge5ev/EnClzt7DUL7Oy0MOOeEQIF22dQAHkMyOUGjJ0X5giKKhYl7+L97E7A/zApa/ecEG6
 K13gSixHtGOzuz4vCJEvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nTiZDnE5JJ4=;ZqZNI/+BxvSP4h0DiYsmgYDzIEF
 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
 OaZEBp7ux3F2iQX5nX9rya8=

On 7/18/25 2:41 AM, Junio C Hamano wrote:
> * rs/pop-recent-commit-with-prio-queue (2025-07-16) 4 commits
>  - fixup! commit: convert pop_most_recent_commit() to prio_queue
>  - commit: use prio_queue_replace() in pop_most_recent_commit()
>  - prio-queue: add prio_queue_replace()
>  - commit: convert pop_most_recent_commit() to prio_queue
>=20
>  The pop_most_recent_commit() function can have quite expensive
>  worst case performance characteristics, which has been optimized by
>  using prio-queue data structure.
>=20
>  Will merge to 'next', after squashing the fixup in?
>  source: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
Will send v2 shortly to address the feedback so far.  Pondering whether
to make the replace optimization implicit (no longer requiring
prio_queue_replace()), but that's probably worth a new series.

Ren=C3=A9

