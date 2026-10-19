Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439791;
	b=G/pJXent4KUjOokAUQzNhl9PPaskiwVOGAdQma2xlSM4CMYkLkjqRfUUaBEIBYBVP8Dv
	 6VT3A6Hxrc4AVTzZdrSf+ymD3Cf3dLc0n6mf6h3qFTE3xsDeyTh0FNjmEKcpUDTAI5Aq1
	 j/hbgCjL9w2bXval63whX6q2ROhEUyHNx7SdLETOPDIZJwIR9Dq8HrbxJRs1sD4KfT5Gv
	 evpacE90BJvRisHQEQ66Vl/dea6DW6W55r1MacLl56O/C8O+EO+DZhyQwHnbSZQtw88CD
	 Yr/A1qI5pjnBd1999yxLSKz7jF9Ia0RHrKzzNit3LgiBLU9DAZTq1d2dx3mph6FMyow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Content-Transfer-Encoding:From:Mime-Version:Subject:Date:Message-Id:
	 References:Cc:In-Reply-To:To:X-Mailer;
	bh=H7n7iSF32ZNaqFLMwFNXhezSTYu/0N6YfeP3+x5D5AM=;
	b=O0tzME/GgVZ2mj5QbmLamgF689MpO/pmFgQe9bVpOFVtaOq725ODF36g6tUh/tn1+nhQ
	 ryUKa4+41Xx7wJU7j8wQLmQycfkXC0samH0vWI29zwmBGv6UOe2n+qwHn8zFVnz/EMJal
	 LFSyXfHOCQYiM6V54kzek70/3qbSja/arHIy6XaN8XfhcB/d+8ol56xN/hrbvu243cHxa
	 DON9/+PMSDBNo4GP/1GQnTDmkeOumBAEr9p/Z2GEqUnXkifDkWvlk683aWcmEFF7kAqXH
	 a2067Jj4l/yalB33qLgxF64CxzGaNEbQClX31imv2QESEDQB9ny0YwRP6LXTQl452TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mKHfxxjT;
	arc=none smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5449660A2628
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 19:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5449660A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mKHfxxjT
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67990a45e02so2246272d50.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 12:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792439790; x=1793044590; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H7n7iSF32ZNaqFLMwFNXhezSTYu/0N6YfeP3+x5D5AM=;
        b=mKHfxxjTQ3N4d/GXh0gm+GRpXf9N6OCL3fAqj+inXiNjCpnCpy7Agpl2h6m/4SAb1Q
         zHLB6gGX/JWrxtO24LWQGkbTMTz6GBMCI/n927XdaxpUTizpDKltJ09ozTRzrH8rDsOA
         Wzn+fpSYGeNgJWWhrDgCVd2ckz1/xg/N+uum3mIdD83OOq01vk3unkjXwP0lhie3EJrY
         C/DZOxfnPjvlz0MQsOwCKGjY97mFfUAg5TqpiWnphBn0R31F1EgnAhoeTC2K75lWpz2l
         hmE+/7mUNEyiynYFzpO0AsRosknNB7B1g3x/pCixkZ/UUz1ucMkT3r7n0iHlflTlHwtl
         pgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792439790; x=1793044590;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7n7iSF32ZNaqFLMwFNXhezSTYu/0N6YfeP3+x5D5AM=;
        b=B5NLk7EPS40QhowxDaevPLe26FxAyjqT8fQQvOOHP1xOlB3dDwAeZiW5CvzBw2nigp
         ettozb1gW6QlU4eF01BxZNDLmcJx2FYmZBBFM4LFHXZs6hhzkoTg6NkSGHUIkozfZZyl
         kLpAQzkaGR8SmS1mqfd5ePYKNJt4vnU9s/IJwLORxFINMlDer6Eu02iie4z+M9M7l/C7
         CPbbns2f71AAfTAJxq6+AbwbiJb8TGe8v7yNgpybmcRxEZ7ZFZ/Flc2zOJTqYZ56+5kH
         BlYkW6QRlaZSs8+/q5MIiUC3hOudy871J/5U/zfH0rvUpjzuX88LfzcWMpc7Q/KvDHh8
         dcZg==
X-Gm-Message-State: AFq9FYJSkxKdtuYQSPWoCRzSkcEFl1fqDUGPvVpxYWxhgdaisog9FqdA
	n+dccCUGlhSTC8L0zn+Cc5XWMWTSda4jdTY1HQnUuQVs5M6JLcbEM9V3
X-Gm-Gg: AYBFou2QjRvRVtupTbfPgWYVkFsymnmoyM2NKZIE9jYH4LIcFNrjWsjpFRsOh3HuLup
	Nji+RGraExvHWUbRK0n4KpHZhfWXWPrn0c13UM7qSp9K/cEBsa0gSVpG5hHn+6ETGPtjVcgdaPl
	y2CeFnvtYpceOZA89qzoL0+SnpSKFsh5uJQRc/1UFePd3JefJPv7SG7CbT1O1kKb4HWkVk3XPxs
	6zdPD7ohYqPLQuOsgOutUTbKBuuGbhn/gMXQKK01DAExh79GviPvGdrxKmytZJcXLOwawdDVVdr
	S/qjj38kypx4nB6HSpNSkxBiuVZgsyN2Gh4ENdx5IkSTQbQqFz+7WkG8cE7q+gW/WQzOdlkA48x
	N3Gy4uRkbO0leN9lz2VFfjxIdjC3TlyABj64FdSlbooX5Gh5u3LFy0sSw9WqFfWv1KqpALiSoWT
	A3qm5stazPltB7b2/C5YYbc7VVQzatkpGNUWdgE8zaTrRNa5XjPVecir9iH27B6Zr9JINwbWIw6
	Ib0Qi0cHMlCo4OdrtBWmZCpM+uiUZLWmeibstdj9c3VeatbHKSv1/ws+88ke9mIS1cmEH0syt56
	OLd/iRfOwAaAktEe5BWPo/at8EVVe3l0p1ryWPC/ivbxpOQ=
X-Received: by 2002:a05:690e:4852:20b0:679:980d:9986 with SMTP id 956f58d0204a3-679ca4dff7bmr1992293d50.13.1792439790256;
        Mon, 19 Oct 2026 12:56:30 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:a9b4:ceb5:f03c:386b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b11b9acbc4sm4270507b3.42.2026.10.19.12.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:56:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/5] completion: fix Zsh handling of stash names
Date: Mon, 19 Oct 2026 15:56:18 -0400
Message-Id: <841E7396-646B-4667-84C8-A51BDD7371F2@gmail.com>
References: <atHZvexnI0Ia7Xjr@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
In-Reply-To: <atHZvexnI0Ia7Xjr@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (23D8133)


> Le 16 oct. 2026 =C3=A0 04:01, Patrick Steinhardt <ps@pks.im> a =C3=A9crit :=

>=20
> =EF=BB=BFOn Mon, Oct 12, 2026 at 01:48:29PM -0400, D. Ben Knoble wrote:
>> When Git completes stashes for Zsh, it eventually invokes something like
>> this (via our redefinition of __gitcomp_nl):
>>=20
>>    compadd -Q -S " " -p "" -- 'stash@{0}' 'stash@{1}' && _ret=3D0
>>=20
>> Because of -Q, the braces are unquoted, and Zsh will leave us at (for
>> example)
>>=20
>>    git stash show stash@{
>>                   cursor ^
>>=20
>> =46rom here, the list-choices widget (on Ctrl-D by default) will show
>> stash@{0} and stash@{1}, but the complete-word widget (Tab) will just
>> add another brace. Zsh things we're trying to do a brace expansion, I
>=20
> s/things/thinks/

Will fix!

>> think! Interestingly, using menu-complete (Ctrl-N) does cycle through
>> matches, since it's taking a slightly different completion path in Zsh.
>>=20
>> We might try to fix this by passing surrounding single quotes (using the
>> -S/-p arguments of compadd, which we can do via __gitcomp_nl's other
>> parameters), and indeed Zsh will generate
>>=20
>>    git stash show 'stash@{
>>                    cursor ^
>>=20
>> but completing here won't find anything, and I'm not totally sure why.
>>=20
>> Instead, though, we can let Zsh quote metacharacters (removing -Q) and
>> everything "just works." It changes the output format a bit (users see
>> stash@\{0\}, for example), but I find this an improvement over not being
>> able to complete names at all. menu-complete is unchanged aside from the
>> extra backslashes.
>>=20
>> So, override stash listing completion in Zsh with a working version.
>=20
> Hm. I assume you tried finding a variant that works for both Bash and
> Zsh so that we don't have to carry this override?

Actually, no. I assumed Bash was working and haven=E2=80=99t tested it eithe=
r way.
Presumably we=E2=80=99d have a report from someone if it were doing what Zsh=
 does?

Many Zsh users, OTOH, use the Zsh-distributed completions,
which stackoverflow for me (and anyway I prefer ours).

I won=E2=80=99t have time to see if Bash is also Brien here, but this should=
n=E2=80=99t
change Bash=E2=80=99s behavior at least.

Oh, re-reading: yes, I looked for something that was compatible
with existing code. I mentioned one such attempt (single quotes).
No luck, though.=
