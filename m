Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E558C1A
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 18:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727114948; cv=none; b=LvE8hCfBqYU8KbvTj/BRBh2bWFURlzjfpbXgfYDGBEX1kKtcwNj8jlNQezUgWfWNG5QVX3OPVdCRSpzJ88vZ/bW6vIN3/iJFv51BAAdBLujlcZ0Uyc1kjsXxOzXnZbXTbTIlq417jMdXnYfaCrOMtr5jovdC/YzmKjgzy2niBw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727114948; c=relaxed/simple;
	bh=+cWagZonKE+GPY0gcAspJ+gIN3cA7yZNsfyY8n/vEcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ha54SZwd5aDpI0DFoK83L3H6za6aFobTQCbRnp50ECPdukT//T6bZWgKkaJopbiF1ABADInAPiVbwOQcfN/QuZdPD0bOebtKg7czUpL5GlRhs84kfn81jMwbQ0aGS3mJhjracJzm9QkUZNCWydUCKruM3iuPM3vl7JrbIj+wJ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=D+Gy24i8; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="D+Gy24i8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727114938; x=1727719738; i=l.s.r@web.de;
	bh=3s3KU2ZdPQU9OVEMDiqBwKtgR1OOExoOOa78gl+phkY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=D+Gy24i8saGqczidl7kqFtRIDuwmjDnndOEc+mllvLiQcTOeHWcYTsGPr58JaH7v
	 fjZZrmeLLRPgkgeKJ24JeH3mIjaX8qYSq7Ud1/o4sHi3nbnQYSOe6cDR2DrCS03VK
	 SxIm55CibY7n/YBf5hGDWXfHhTvIV3XMw7FZhAVYxvYRijf5SBzM5k8waPGzQN+wU
	 EoSk+UpG228leDf0sFohQ1dRVu6sONY1wNY0+sCLdGdVHgm+J85w0z9a81Y6WAvAS
	 92bJKX7bzfFyWDEIjBb2SfDSYbir1oRE5Lq6Pkix/VyndpwNCQKzG4cvo5kmpUEyG
	 sPnli2YLrD5tAkoUAg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.152.135]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MftBr-1sGzpL2G1h-00hmZW; Mon, 23
 Sep 2024 20:08:58 +0200
Message-ID: <2c3472d4-ad40-4636-9840-51fa97bca02b@web.de>
Date: Mon, 23 Sep 2024 20:08:58 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug report: Undocumented interaction of --exit-code and
 --ignore-space-change for file move
To: Ian Turner <vectro@vectro.org>, git@vger.kernel.org
References: <d8512f2b-400f-4daa-a59f-5d10d4fc3840@vectro.org>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <d8512f2b-400f-4daa-a59f-5d10d4fc3840@vectro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QEDlQXwI371VWXf4BlhrEldMrbe0iKWMqt+10jB5cS8dz1690+Y
 tPdmasHitmTxH7wO6KZtGVOGr0eUB+7V0p+HHPFOBGDZ+zEljZlNb7ZOjlgWTHdksH3GPAc
 siWoxibYsGoPfaRcUkGjK7IMHrjv0fyg8s5rgnQhWZeKArpLPUBq6zGhIof3/0W9KeW3Fa1
 TFmMhGBTpvjvL7d4KLZ0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y16XjGa8ZZc=;SiVPDtxxy7XZmHLSPdQD7LvYYmI
 9CnUz0p6Y8GbwwSm/vt9joczlaDmSAV0tK/uq0xCn3/GrRQ7HXIww+NCI82Dgf/vh/h7VcJt0
 SoCE1pvuUw2fI3212jGNfECYl+ahhEz+inIWBc/2j+eURhylCfk2aYHkH6YshlEgMuT58J3FL
 0RQqP1cNyCB775dnVZgzJNdJkkLywleYf32Wl5V4j+sUmz6GKPanRozZ33sBMS6QgrSfMv25r
 WoJpGfoEzl9rVkAnHolLL9no+W7IkBuoHbjLDpn+pYs0GYacv+6a0g2geYrdSS+iZlUVwxDsl
 Gcxtbx3BJ5s07wVOumTrUZ5Rit/BE6TD9sfUTkf50xUObmeCcqoPRMAfOPfbD6LYVbbYwnY5t
 BaVEjMwfSHsfITmtLsC3KiFFmiqUlpyeW86YpJ+OtHqFn8fwvSRegQhGz3KlEVF0Kk1PrQKI1
 yMkGhx7xmpx0wZgRdCxJL6u/SqoBD6uEsA+8n/jL+j2VwGbS/9nIQj8mDiC5/GAVlhsNevyNb
 FkEBnwyXLz1t7xtpUvt78fikoZE9qUYI5jocYnvM7QlY8Z17zTPdBCjeX1wHvFUrZv1bLu7Df
 QT+3IuslJLztFRQ0hhlqH8X55vkSgff54mbYjwl0y0BEnFAhfaga8QmS4pE818Drr2M1zhoFx
 f2/nsRelp99lEe71jKQRizX1mL/MM6w0ueCvFZMhoO9H5QXpAvTTH9+2LLu7fE6oO/ncAYv1p
 0mLfoBOPr5Z2tHFrlUb1ehJUbxS5YuUakUKUA54XkPVLLgwWwHWDjRozi99dfbPOlkLBBpdAv
 jZ+JidNa6jIq94do9HAS/q/Q==

Am 23.09.24 um 18:29 schrieb Ian Turner:
> I noticed that there an undocumented interaction of the --exit-code
> and --ignore-space-change flags to git diff, when the diff only
> contains file moves. Specifically, --ignore-space-change will cause
> git diff to return a zero exit code in this situation.
>
> I am not sure if the problem is with the command behavior, or with
> the documentation.
>
> STEPS TO REPRODUCE:
>
> git init
> echo foo > a.txt
> git add a.txt
> git commit -m "A"
> git mv a.txt b.txt
> git commit -m "B"
> git diff --exit-code HEAD~1..HEAD # returns exit code 1
> git diff --exit-code --ignore-space-change HEAD~1..HEAD # returns exit s=
tatus 0
>
> EXPECTED BEHAVIOR:
>
> Both of the last two commands above should return nonzero exit status.
>
> WORKAROUND:
>
> As one might expect --no-renames undoes this behavior, although it
> also changes the diff output if not using --quiet:
>
> git diff --exit-code --ignore-space-change --no-renames HEAD~1..HEAD # r=
eturns exit status 1
>
> OTHER INFO:
>
> Tested this on git 2.39.2 and git 2.41.0, both on Linux.

Thank you for the report!  It's a known bug in the code.

d7b97b7185 (diff: let external diffs report that changes are
uninteresting, 2024-06-09) exposed it more widely, unfortunately,
causing v2.46.0 and up to report the wrong exit code even without
=2D-ignore-space-change.

87cf96094a (diff: report copies and renames as changes in
run_diff_cmd(), 2024-09-08) fixes it, but it's not in any release, yet.

Ren=C3=A9

