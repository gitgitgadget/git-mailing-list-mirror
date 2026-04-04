Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F57D86341
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775322455; cv=none; b=F3wxaQzKbPG3NM0auIdRxBVIomvhCoOIDUU/8hUpjleQie+N7MyjMCaEqa91ZEZJxJob1x14vFaQN0zehF5GJV7FvVqHYeVehJae++kGB7FVO/LOAzXg6p9Gvh1Gf9iQP0FpAbnWPOdq9FSkSvcOc+Vi79PjcbGn/SQULQRkEg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775322455; c=relaxed/simple;
	bh=c4txrloRZItvKJGVmrmxoLVcWrCGiu2Lvopy94DJyzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqUGVyos5WPsJrIEip2CAzayPvd5E2Tcq41AU+Xk5Z7DwLiDvr4hKqFzZ2z39rX3Zb5okIcYwZJcvKUECIqpwOJhRfrHTvUkEUU6Rt8afH7PLEWHLybBlRH9RcypuSAuvXbytLVq0jMdfxALtK/HFEWBi/8H5wVpaEspEeNuQ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=aWAhFn0v; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=lctOGADM; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="aWAhFn0v";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="lctOGADM"
DKIM-Signature: a=rsa-sha256; b=aWAhFn0voHXHeoN5mU9fnjpIl6JiAuaH4u1J41ycHJLD7id9a0Eddn0G7r8mBt9LUxjHRJYyLnCUB+5dIvP+jIjy/AXHVW1xeXiiWWHjgqU6rDcnhViquP7OeLAN9Q/i9BRIJWACAzEDoni6fjNgKtSuX+lpnv7Lit2q5p1lHziavtk7QzqN9uMPs89BVw6AXFihT7Q/Ms2DjUNYKe+8trNKBB3coxFA8n+ELozrHaED65xFXy+q+yRljbbNVivEwE7M7FTOwBdrZz4vH+3S1MWXwjC2CLPFFDXXmCW1XizVT2roTAwOcJkVS1HlKYM0k7XgeoHIv0oycT2lZ2c18g==; s=purelymail2; d=malon.dev; v=1; bh=c4txrloRZItvKJGVmrmxoLVcWrCGiu2Lvopy94DJyzA=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=lctOGADMeg8DdZ4uT8ldHuB/ZoEMntT08+HMvfSTvkC9fLplN+kmbJLFC2AAYY15VARoBzdGUJxyROgyPaR6Z5a4OlsWBsWITcbH7Jb7BxK7cAnVp5JwScwN3XFXQHMTsfnYlRKS+0T58v18va/Poo946a5eWCya9d9otKs7GNa1Vc/9TIdk3Bli/UZQTqada6ipgUSUKlNqG4GG3nVLvutUxO/E8MBp3R+5hx9FPbw6PCIg8v0dzP7P/P+dJAYgFEI7dsMzgz+PoX2pXg9cm7NbJUjvWeN/uwCBUDe1goROj/k3oqDjNdLKqyGgMAebd4hZp55XmD730EseKavSmg==; s=purelymail2; d=purelymail.com; v=1; bh=c4txrloRZItvKJGVmrmxoLVcWrCGiu2Lvopy94DJyzA=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1561183331;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 04 Apr 2026 17:07:31 +0000 (UTC)
Message-ID: <4be492cf-347b-4fa5-9bdd-83e7ea8abd92@malon.dev>
Date: Sun, 5 Apr 2026 01:07:27 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] git diff --no-index segfaults on large files (NULL object
 database)
Content-Language: en-US
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: git@vger.kernel.org
References: <CAO0HQ0X_pQmew5tJReOL=u+CMxCjAQynx8JfjykoYAUE59YNzw@mail.gmail.com>
 <d6c63949-1998-4cde-8cb0-902fd7db988c@malon.dev>
 <CAO0HQ0VEJsG6MYrp_bSTuU09PDsypGPrM0XazvM8er0kB32Gqg@mail.gmail.com>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <CAO0HQ0VEJsG6MYrp_bSTuU09PDsypGPrM0XazvM8er0kB32Gqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 4/5/26 00:53, Luca Stefani wrote:
> Thanks for looking into it.
> Locally, I simply check against null storage and it works just fine,
> flags is always 0 in my experiments so a check against
> INDEX_WRITE_OBJECT also worked.
>=20
> diff --git a/object-file.c b/object-file.c
> index f0b029ff0b..68303aa99c 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1654,7 +1654,8 @@ int index_fd(struct index_state *istate, struct
> object_id *oid,
>    } else if ((st->st_size >=3D 0 &&
>        (size_t)st->st_size <=3D
> repo_settings_get_big_file_threshold(istate->repo)) ||
>       type !=3D OBJ_BLOB ||
> -    (path && would_convert_to_git(istate, path))) {
> +    (path && would_convert_to_git(istate, path)) ||
> +    !(flags & INDEX_WRITE_OBJECT)) {
>    ret =3D index_core(istate, oid, fd, xsize_t(st->st_size),
>    type, path, flags);
>    } else {
>=20
> Luca.

That looks good, almost exactly what I was about to send. I was=20
mistaken=E2=80=94 there isn=E2=80=99t a hash_write_object flag after all ;-=
)

It looks like this is your first time posting on the Git mailing list.=20
Would you consider contributing this (as a patch)?

Thanks! Yuchen

