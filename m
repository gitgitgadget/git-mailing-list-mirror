Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC01036D4F7
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764597910; cv=none; b=Wx7vWeMmVLl+D1S3UblfNFQmUsr5ssn9uV4WIBdhtlqqf6kDIAfmXiarfp42RepZf9JXy4qN9nRaoKO7DzqHSvUq1cDaI8O7J2Prfgs/YgQjGZsCVv9AZkVRYVmiUGydiPWc6kTyPTHDifmc9tqQ2ErNaYmMfmwBAV+t9GQFbfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764597910; c=relaxed/simple;
	bh=8OdAyWK9fVNiC1Xza1fZFyLw/RyE7cT2Xk/UqniTpBE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OfTyVlOqQQmyWm2v5wx4Lzzw50fE2kQOwluTHGt6oAjCb86S7eKOyA2reqw60xW8o1z9vvDFOzJLroa7hchwW7E9U0kCplXW2lEEKyopWsbHLr/l3D1uAPEbsmgaxLU7wYi6FY6ST8dRQrrNdIt9Z8FXr5z2+BFl4AqIGM1im+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=rTE38OZi; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="rTE38OZi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764597899; x=1765202699;
	i=johannes.schindelin@gmx.de;
	bh=s5iaKP6pw1Im7z5luAngpt2FWakigMoLFXqE3f30PFw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rTE38OZiIRQ+htFh5d4DVL7IySECfWsOwXWRq+5XT1vc1wd/dz2Vqykra+Ma3tbo
	 WWHDgW9k3ZHtkVO2akW3qT60t1viEpGnz6tnxLzkguTlbWCNg28kpbbDJoJeTYyLm
	 eWuT97Y2biDYTxl7fu0PbMDwGHaLi36JyRn22Q4bBmJYmUtsbvuIJ8AI01qMvmPWL
	 CnYYBiCFIeswk5lP/ceLswM7onu9VqkumhFm1HG5FVtb0Qmv9ZwSY36BfMaZbzPbQ
	 ugmFQUC9760J8Rf/Feg8KxQTrWv3p7+rvUuRKNp1T9zqlnzbBNQ5CL4jhYybFim1A
	 C7GolSOjmDhuojE2cw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.165]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxDp4-1wJ1cp22K8-00vWHf; Mon, 01
 Dec 2025 15:04:59 +0100
Date: Mon, 1 Dec 2025 15:04:57 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im, 
    atthewhughes934@gmail.com, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/5] Audit and document Scalar config
In-Reply-To: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
Message-ID: <8ec87618-54b0-9b15-c7ff-f53e1f4fe2f7@gmx.de>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VAIeWWx91Xgin8wyPZsO+kvgVdYGF5s+yhfI5f0LIhHUjPlN2J3
 Z/qO77fRUmh+K2DJIE0oJa930XSZbJYnVSDNN8mSvCiswB39hKSBZJTeaqjkfhEGdS4XOQV
 9M3quxkcgoie1xlh8F858FFG9TXJiOsvhfwttEmd929FaKldtDbWxHiQIajFx5xnr+surnP
 qUfE16h84HiOLz2I4TnHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Vk9CL/yA/tI=;vcI3KJouZ6wJTdQlNgYrcQRGVyC
 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
 tlrHP+Q+c5aWoz0x8=
Content-Transfer-Encoding: quoted-printable

Hi Stolee,

On Wed, 26 Nov 2025, Derrick Stolee via GitGitGadget wrote:

> In September [1], we discussed that the Scalar config options could use =
some
> documented justification as well as some comments to the config file tha=
t
> they were set by Scalar. I was then immediately distracted by other work
> things and am finally here with a series to do just that.

Thank you for doing this, in particular the (quite long!) list of
explanations are excellent, especially when some user wonders why a
particular setting was chosen and wants to understand the reason.

>=20
> [1]
> https://lore.kernel.org/git/ffa61066-7004-48dd-9096-85b305373bc7@gmail.c=
om/
>=20
> I have indeed used Patrick's idea to add '# set by scalar' to each line
> added by Scalar, it took a little more work for all the kinds of config =
set.

I am glad that the work I put in to optionally add comments pays off.

It's a bit sad that there is no well-designed bulk-edit "API" function
which therefore requires constructing and `free()`ing that `file` variable
many times, but that's not the fault of this series.

> I made myself a co-author.
>=20
> While working to justify each config option, I found some stale or incor=
rect
> config options. I also relaxed the override setting in most cases which =
gave
> me an opportunity to alphabetize the settings.
>=20
> There was at least one case (I'm thinking of core.fscache here) where th=
e
> config doesn't even exist in core Git, but instead in Git for Windows. W=
e'll
> need to adjust in that fork to reinclude it in the right place.

Thank you for calling this out! I will take care of this in Git for
Windows and also in Microsoft Git (which inherits this flag from Git for
Windows).

To be honest, I am not so certain that we want the FSCache to be enabled,
it does have long-standing bugs (introduced by the partial clone feature,
for example, where the FSCache continues to retain stale information about
which loose objects are present even after the missing ones have been
fetched). I guess we'll have to measure the actual performance benefits to
reassess whether the feature is worth the trouble.

Thank you for your diligent work, as always,
Johannes

>=20
> Thanks, -Stolee
>=20
> Derrick Stolee (5):
>   scalar: annotate config file with "set by scalar"
>   scalar: use index.skipHash=3Dtrue for performance
>   scalar: remove stale config values
>   scalar: alphabetize and simplify config
>   scalar: document config settings
>=20
>  Documentation/scalar.adoc | 158 ++++++++++++++++++++++++++++++++++++++
>  scalar.c                  |  81 ++++++++++---------
>  t/t9210-scalar.sh         |  26 ++++---
>  3 files changed, 218 insertions(+), 47 deletions(-)
>=20
>=20
> base-commit: 6ab38b7e9cc7adafc304f3204616a4debd49c6e9
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2010%2=
Fderrickstolee%2Fscalar-config-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2010/derr=
ickstolee/scalar-config-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2010
> --=20
> gitgitgadget
>=20
