Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474401BD9CD
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 20:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733432268; cv=none; b=riuhZpxuQz1nUciZtrZ/+772AO61NvtK0YGLS7iiEgKPLbzSSxlb0L0ZbA+CMW3WKbImgYqvxB4C+MfTGAWpS//dmDKHiyJCWzXrXekwJxC86s9LfzdbORX/4Ov1eW190m8sYiZWgePa4SFGmQFeCTvKexMkTABKiSTuPS56BEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733432268; c=relaxed/simple;
	bh=GGTMvE3QpcP782n4f97oEv5VGLws5Vrx+d+fkRZMugw=;
	h=MIME-version:Content-type:Date:Message-id:Cc:To:From:Subject:
	 References:In-reply-to; b=YqK42J+ka27Pzs7/C3NfaYLLDqg+djNrBimoVixCwWPYwVrmFCRf23WHgJwavpH0C8ZgpBzFIRq48WZ0qit6bEwgcTVBT4I8oAK7/dDc4GGTzpQpUCke2reHNcU13rvr26fC1w/KUVE3WoMFSu7KQFGICRdHS5iEkEb7PClRBOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=Li8FV9rl; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="Li8FV9rl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=ePqlViSAPELSPJf/0CtoC+6pcboCr/pELvkqyWyoJFU=;
 b=Li8FV9rlcVmB9r5yWeR/JOuuGRdP29+CzSyotFVeR1rDk8j0O7PAQ3jNxwiiZ/atjdU9SmDR8evh
   fx0qcbRoz4OWClk5GdL19gAzdqffF4joPHSM6zHcwghVukdgjeOys+R2IfeiRoYzUMqlStKTsStW
   0wcucUiNHZRn1sx6OoruJ+NDsu4kcicjGqTf7tfnOX+ZnhpEFYLjjkh5+EXDpzP3RDvGaO0HliLA
   enKd12xqdJGGqMx6hk2zflOze+52qEtkAFnUQZQsIpwL2PuS9r67Gk0OXcizlh5Wk7GE+vukJeYc
   lw9t5tcmSrFjMGV9FgaaKU3kdaeSwB9GkDPxig==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SO100MZOGW5E890@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 05 Dec 2024 20:57:41 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Thu, 05 Dec 2024 21:57:11 +0100
Message-id: <D642FXNUF2ZU.1EPADL3CIBAXE@ferdinandy.com>
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>, <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>,
 <jonathantanmy@google.com>
To: "Josh Steadmon" <steadmon@google.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [PATCH v15 09/10] fetch: set remote/HEAD if it does not exist
References: <20241121225757.3877852-1-bence@ferdinandy.com>
 <20241122123138.66960-1-bence@ferdinandy.com>
 <20241122123138.66960-10-bence@ferdinandy.com>
 <wmu5ld4xsfjz2tpp54jmxqroma423t5nn2jh3q5gq2wswr6fkm@vrlhigyuxfzu>
 <444kgiknevb3kwtypjjc2glryaav27t5fafgyzqq5257w7o4pf@4fngcyfmvfcp>
 <D641F472LOV5.223NEPZXKIL4Q@ferdinandy.com>
 <hpaekjhdpcovhdptdntdligp5jcdp7mygh5brnggu7itf5grzp@vl4l7uwnb3n7>
In-reply-to: <hpaekjhdpcovhdptdntdligp5jcdp7mygh5brnggu7itf5grzp@vl4l7uwnb3n7>
Reporting-Meta:
 AAHyVEHSVsd4GV5vO6tRCMGqlmPRp4VUMDWYPuLSmMv6Zr9F2CQGMWQE4EQD2eX5
 dfpak8oiHwd8fW7XJ7BvT3UEbox6HauXt9USGzGkaFb97d2oFkLSOA7VnO9Lrfdc
 lN234Gx5/6G0Hpj+1/MQB+VOhqTJyG7SByFeOmzikbiJgkfhGwoltZMS3GF9gamZ
 8ZknYJ4c0h4zRTWQmbUpyRqKZvyTLOmaJzyWH1h4yB6uykS4jl8Bz1cs+XoWx8we
 R2Blz7jGEqB3cKpmQdvEAFzvLXq5/gVr4vbr8CK9UWQkD3uN9rSN2fsMxX2JW4io
 q2e/WIr19jh2wb4KW90GlndLlYNNBm1V3vxLfwkKk6tZoX+73/U79caNBIUnohf+
 H0jXVkWUITQQETCFPgWbSxOlqSfskqzmBHvRYKd/MFrVTSK+3Jnzfw3sPrpajo3Z
 XGq/lXbcwBIFeiNe57INtRi/mWsprEAZShS1HBv7TlRV9eBfmuj6HrM=


On Thu Dec 05, 2024 at 21:11, Josh Steadmon <steadmon@google.com> wrote:
[snip]
>>=20
>> Thanks for looking into this! I think the issue is with=20
>>=20
>>  $GIT fetch --tags "file://$REMOTE"
>>=20
>> instead of adding a proper remote. Tbh, I've never seen the above syntax=
 before, so first I just ran your script, which reproduced the issue for me=
, but then I modified it to use a proper remote which works as expected:
>>=20
>> rm -rf test_tag_1 test_tag_2
>> GIT=3D~/git/bin-wrappers/git
>> mkdir test_tag_1 && cd test_tag_1
>> REMOTE=3D$(pwd)
>> $GIT init .
>> touch foo.txt
>> $GIT add foo.txt
>> $GIT commit foo.txt -m "commit one"
>> $GIT tag foo
>> cd ..
>> mkdir test_tag_2 && cd test_tag_2
>> $GIT init .
>> $GIT remote add origin $REMOTE
>> echo fetch --tags
>> $GIT fetch origin --tags=20
>> echo regular fetch
>> $GIT fetch origin 'refs/tags/*:refs/tags/*'
>> $GIT --version
>>=20
>> So I'm assuming this is why also the tests never caught this, since prob=
ably
>> all of them are using `git remote add`.
>>=20
>
> Yeah, I think the issue is that we check the `--tags` flag first, but
> only add the ref_prefixes entry if it's not empty already. Then after
> that we unconditionally add HEAD. So that's why moving your strvec_push
> earlier fixes it. I'll send a fix + test patch in just a minute.

Awesome, thanks!
