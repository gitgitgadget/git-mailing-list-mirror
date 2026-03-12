Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164B131D381
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773341363; cv=none; b=UiaM/pDtsf4n280HG9hXqbFPuABYcLb6C/I6/FaVPCHVWUuUyRpDNmFF6BKvLpjzzx847WhiffENJMLFNxNsOrnxmUeQG14a8SaqNeEJMxIvbHdBcz6Ik0r4j3+TJb/e3fETQOFwuU+fCkyhSQCCTxOXilAV7u4V7ydkysTWW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773341363; c=relaxed/simple;
	bh=uYV7JwiBCEQQFMX1Bb4IKffEgbDoZdWKOPHMxq9Pik4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/DHVQkuC6uOL1xV1xD0wBNuNhfNnXbi8PACb3n9JCKgTcjqKAN7DRz6qErHj+KbzSJIvoE/kwV4e0jZqJswpUcXUM1R+FwE8ZFFY0ofitZxAVXXWE8vAFZacbziVCEBZimJQV6/hQjbIjH4Vxtsu6pwzh59clFeHSW4LXofVl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=ddybhKAE; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=emlq0RNt; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="ddybhKAE";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="emlq0RNt"
DKIM-Signature: a=rsa-sha256; b=ddybhKAE/fiIrM2AeU3xLUCf4Me9BIhAQ8fZHa3DVwBAxVAxglzjstBRLBiY2aU3stGJd2S4JGW9GWxLL2IZ4StuUvPycPnmp2QmGiveAsgMc2ZLLBZQQU4rCFquwt1NyZOH9aDTL13fD/x0id3knDNBEJwE4EemCU50ZWf7hem8UVqKxAH4D6G3W6h6VbsU/kni4npxca7J026gFxKZiBWdW5o44TLYbyzTfC02ilpvivfLaI0WFeLZReY2C8iOyK5TDV+rNrNM9zC+byJTrQwaMnPlR2DBfME9FvLgArjLlYYn2i9HjqS8ra1vvw834m/xBGIXHHa03I2Reo8Fig==; s=purelymail2; d=malon.dev; v=1; bh=uYV7JwiBCEQQFMX1Bb4IKffEgbDoZdWKOPHMxq9Pik4=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=emlq0RNt7n4+70zk0La2uVthrtha6Vswz6SaSEMGWlECb8t5kWioVCsnY0snBlPkDXy75b3O7JFPd/FlzE4dKxhqvp14PxjCVQoYvkw3SNzTQztIVpPIW0iJJJ2FmxKkY/66BvTbx4h0X9WPFLGgOCaib/p5EQBz6GzqNMXXkR8pmXWoN8m9rHCN12bnAYBtQsYpUs2rUfyAYgrEkAUPHTPOvABTP4eG/2y+bT+5JJPE9EWP7H2Qyqugr3lNCo42D+K0UMBrE7ia/kdLEkUfFr6MVswWQi2L9kPtUVqr4IZal76plAafS/0NwizrzVsSdXeEyt9xJ9fbl5o7NVX4BA==; s=purelymail2; d=purelymail.com; v=1; bh=uYV7JwiBCEQQFMX1Bb4IKffEgbDoZdWKOPHMxq9Pik4=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1390042710;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 12 Mar 2026 18:49:09 +0000 (UTC)
Message-ID: <2c9861c0-fdac-4123-8cd9-4a841755abf3@malon.dev>
Date: Fri, 13 Mar 2026 02:49:05 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] builtin/mktree: remove USE_THE_REPOSITORY_VARIABLE
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, phillip.wood@dunelm.org.uk,
 jltobler@gmail.com, ps@pks.im
References: <20260312164203.964033-1-cat@malon.dev>
 <xmqqsea5ezwl.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqsea5ezwl.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi Junio,

> RUN_SETUP also guarantees that the repo points at the_repository.
>=20
> The patch is not wrong per-se, but at the same time, it is not a
> very interesting change exactly for this reason.
>=20
> Where did you read that dropping USE_THE_REPOSITORY_VARIABLE is a
> good idea?

I mentioned this at the bottom of v1:

> I originally intended to attempt the #FIXME in t1006-cat-file.sh.
> I followed the clues all the way here, only to discover that the
> FIXME required a level of expertise far beyond my capabilities,
> so I gave up. However, I spot the global variable here, so I went
> ahead and fixed it =F0=9F=98=89

In other words, I just happened to see this thing. I didn't go looking=20
for it ;)

> As somebody (Phillip?) said earlier, we probably should update
> document and clearly say that removing USE_THE_REPOSITORY_VARIABLE
> is not a high-value target when done in the builtin/ directory, even
> though it is very desirable thing to do for more library-ish part of
> the codebase.

I am fully aware of this, and I did not specifically modify=20
the_repository in builtin/ during previous patches. It's just that this=20
macro makes me particularly uncomfortable, and I believe it would be=20
better to remove it.

On the other hand, this patch is indeed boring and useless. Feel free to=20
ignore it.

Regards,

Yuchen
