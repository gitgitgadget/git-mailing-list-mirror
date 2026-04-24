Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62A5319848
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777048165; cv=none; b=fmaLdQa/CHBNBMNBg189Hpv8DbnMbbIotRjt821Ox4mByAOMp0yg9zbUwAVQ1htYAW1QNH9cOa7EZBYfxal+a+g6q7taKUhIZdBrTIksJChHVgN1FHvSNG9u9cX7j+k+pXjE5OvcT0MYAGlP0xiBhvRuQZxO1uGCEUIguRdKrQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777048165; c=relaxed/simple;
	bh=70kbbdqcECQvof/+CLI24QI90B3EG7sw+5DL/TlWNas=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Cwq2PjAGgbSPiwYvNeyYrk9e0g+KzbIwR9RQi4YV3MIEgXarDzTwcWHViK8HgM1hmYF26gbepxUkfXjqq7nPQmV6Kv/JNxHmpHu2vxxKxeKO4j4jhJ3S3M5R/V2oRYhry1exd6q4y5MQCdE93xBSjzZETF7WsFmM7SDXYyGdxFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=pCmRHFLr; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=l6QGxwJE; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="pCmRHFLr";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="l6QGxwJE"
DKIM-Signature: a=rsa-sha256; b=pCmRHFLr2zVlyVn/FH+jPJ+gYPEBSpG2ip+FgCKT5NmDXVPS5+RVCkPKCaz95IREUklyVwxNBbNpD89fxe7io7ibb3VzsQELelktXYSeKE36Z7xHf9RGJ5T8BNPiRVYn6vFrAcV0hSXkOcPZKxfMfg0p/9cEXoWJUSCiLnPXnfUlXEWAFiQssFcyv/ZBlrVNPq6gG3xX7uKuqZAJh0Dymko2nbHqRydGaYEU/9qmMUsUY5trQ0ok4oo/5aTiK9QtFwmFd4y4vriEXecRzArYEXkFmKkHdW6LdUOHfYcU+PwKFeU1OKCUXb0LvlXSy+pihQrvh3FuoedMkGYfF9OLMA==; s=purelymail2; d=malon.dev; v=1; bh=70kbbdqcECQvof/+CLI24QI90B3EG7sw+5DL/TlWNas=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=l6QGxwJE4FwLvQkmxVexZNH2wiux8mINkFGYo0UZqmdScytObtHYmavkb2mom6RZ8aGbTFSYvZCZ6LN/zWIPTJj55GbBiL/QpQCPOEtEIaAUfFX66rf2tN79p4SvYlf29vMVjpbE/3OiBP4CFvEMfZlIvTWgLzxxIFRP8rh+JW1iYWUcrwrMDnkvzrLKCdGXiGF8gm0qxZl5uWLC45w3gp+xUhMOWJOgO4tcfhKPOhQo23UlU9aV9NS2JH7WpodZvB0ZfetmeN5Edl91be/fgxEwKbYYUrT7+aa/tFAznvkQeI4OoWswlqr+6s/ISrX8LL/U8FSU9A2qUKZwPaWKMg==; s=purelymail2; d=purelymail.com; v=1; bh=70kbbdqcECQvof/+CLI24QI90B3EG7sw+5DL/TlWNas=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1200268987;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 24 Apr 2026 16:29:13 +0000 (UTC)
Message-ID: <d83ee7a0-b5e8-445f-af93-91c78ef63ff8@malon.dev>
Date: Sat, 25 Apr 2026 00:29:13 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with git send-email and --reply-to
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 git@vger.kernel.org
References: <26f3a5b2-1656-482a-9349-ca3592b8bba1@amd.com>
Content-Language: en-US
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <26f3a5b2-1656-482a-9349-ca3592b8bba1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 4/24/26 21:13, Christian K=C3=B6nig wrote:
> Hello everybody,
>=20
> either I've found a bug or there is something absolutely not obvious goin=
g on here with git send-email.
>=20
> I want to use the --reply-to option with git send-email to make sure that=
 people reply to my AMD mail address and not my gmail address used for send=
ing mails.
>=20
> When I use the option on the command line it works fine, but when I put t=
hat into my .gitconfig it doesn't seem to have any effect.
>=20
> Any idea what could be wrong here?
>=20
> .gitconfig looks like this:
>=20
> [user]
>  =C2=A0 =C2=A0 name =3D Christian K=C3=B6nig
>  =C2=A0 =C2=A0 email =3D christian.koenig@amd.com
> [sendemail]
>  =C2=A0 =C2=A0 reply-to =3D christian.koenig@amd.com
>=20
> Thanks in advance,
> Christian.

The most straightforward solution might be:

[format]
     headers =3D "Reply-To: christian.koenig@amd.com"

This is equivalent to manually adding this line at the beginning of the=20
email. In most cases, there shouldn=E2=80=99t be any problems, I guess?

Thanks, Yuchen

