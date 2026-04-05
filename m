Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B1126CE2C
	for <git@vger.kernel.org>; Sun,  5 Apr 2026 02:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775357306; cv=none; b=uc6KdV0N4mU6aXxjq2Hdx+RkzqZpH2Q4oi5cJ7SSr2X0afVhXx9/s4BqDLAgPMQJyregtrlaLlSl53YX5BeE2emFdeoO1riUIAd0n8/EpHbQwBJ3O5h+2Ulp1wKslvMEdUBe8pNW5+Np7SmTsCVMXf8dZW5waxifnNqdf5xxhEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775357306; c=relaxed/simple;
	bh=2Qyv784fdLp1xu0aXiB0yplxS4kIkGqNbkOTODs0Q+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QC1jjDsdfbOacrZeYsY9Pbh5qWrf3Q3dJPIgQrV3J1SYvOhTksbSAkdfWy5cHReLwp/vb3XPM06XnF4+3KKu3To2A+ewGYP7H4Smh/i1Jm6GjB98im3gouBxifmCBNjuO0E6EuJPq+5hKUI+BgYhyEeJXd0ws+NCr9Yq4l6/64s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=YnVeZjCN; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=QUC5n2/t; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="YnVeZjCN";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="QUC5n2/t"
DKIM-Signature: a=rsa-sha256; b=YnVeZjCNCv+RP5xeVaEDbSCUgS3EgJCcEZpKDXJCm4W+UnYkQN+J4frKBh7uvOVT2J470CTQ8kCIvcH6IE3bZYpSpRU83UqMUyVB2x+fd0quJAqlhEdfSTCYO67TVEAntOUcwxkUOrL8jXvDY8fiddmTmzv4kLwyhLDa0qJML+pyS5zXWTUxrzxIqdw2wU9Ecxh9x+NnghQP6ter4n2SHsR3PeqHAvvWKAafZYnAUhBts/Fwc+JeUL3VUSFUmiPbLCPfpw6QKsCr4tWufUmmRakURWr0obQ1QnN9yHzc2mXegTjE+jswLvDhVFstEBBHpjtJva7evSaxYZAp8mRSRA==; s=purelymail2; d=malon.dev; v=1; bh=2Qyv784fdLp1xu0aXiB0yplxS4kIkGqNbkOTODs0Q+E=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=QUC5n2/tf8LXqUgJDHtiC3ub7p98/Jsp5S1lISSWtOfe+IP1j71FXAX/7LSpMTu9ABSZar1mMwDf1bWwIGTlVynG35N96B9cHhrUabVmwMoApd9LPsGS9PJfiIgYf2w3cQnfTB3xR7Mw9EcSKv3Wv6KYde6HGIyIZhtgnv+W83yIul4FAzKzN3E8nJdIRkKnmOOMMH1KKPihGHuKFZJp4yRWWU+Y4guBshfZxBUBCwTNdihPERfpVNouUeDEBUikVFCEFBtGaEMNUnRiFzcin9dl2BzEsViDFsg6ll/CTsNuKomUlH8Ck7bv+Lk4gNdahU3UA5YLw31Sv/oa6A9pqg==; s=purelymail2; d=purelymail.com; v=1; bh=2Qyv784fdLp1xu0aXiB0yplxS4kIkGqNbkOTODs0Q+E=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2105106148;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 05 Apr 2026 02:48:19 +0000 (UTC)
Message-ID: <7841c013-1f6e-49e3-9f47-f25044764a11@malon.dev>
Date: Sun, 5 Apr 2026 10:48:16 +0800
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
To: Jeff King <peff@peff.net>
Cc: Justin Tobler <jltobler@gmail.com>,
 Luca Stefani <luca.stefani.ge1@gmail.com>, git@vger.kernel.org
References: <CAO0HQ0X_pQmew5tJReOL=u+CMxCjAQynx8JfjykoYAUE59YNzw@mail.gmail.com>
 <d6c63949-1998-4cde-8cb0-902fd7db988c@malon.dev>
 <CAO0HQ0VEJsG6MYrp_bSTuU09PDsypGPrM0XazvM8er0kB32Gqg@mail.gmail.com>
 <4be492cf-347b-4fa5-9bdd-83e7ea8abd92@malon.dev>
 <20260404230939.GA1360412@coredump.intra.peff.net>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <20260404230939.GA1360412@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 4/5/26 07:09, Jeff King wrote:

> Alternatively, should the odb transaction system be more forgiving here,
> and act as a noop when there is no odb?
>=20
> Bisecting the segfault yields ce1661f9da (odb: add transaction
> interface, 2025-09-16). Before then, we passed around the
> object_database itself, saw that its transaction field was NULL, and
> returned immediately. After that commit, we pass the object_databse to
> odb_transaction_begin(), which narrows it to odb->sources (which is
> NULL) while passing to object_file_transaction_begin(). And then that
> function looks at source->odb to go back to the object_database! But
> the source being NULL, it segfaults.
>=20
> Immediately after that commit, the switch from taking an odb to a source
> is not helpful, though I think eventually it is used to set
> transaction->base.source. But should the whole thing check for a NULL
> source and return early? Or otherwise establish some kind of noop
> transaction?
>=20

In a nutshell, are you suggesting that odb_transaction_begin() should=20
return silently when source is NULL?

I understand and agree with your intention, but in practical terms, if=20
the odb has not been initialised correctly, data will be lost silently=20
here and the caller will not receive an error message. I=E2=80=99m concerne=
d=20
that doing this might lead to more bugs in certain situations

Would it make more sense to treat this as a bug instead, e.g. by
triggering a BUG() when source is NULL?

> I haven't thought about the implications (nor even really looked at odb
> transaction code before). But doing it that way would fix not only this
> bug, but also other potential bugs throughout the code base when callers
> start a noop transaction.
>=20
> +cc Justin (author of ce1661f9da) for any thoughts.
>=20
> -Peff

Thanks! Yuchen
