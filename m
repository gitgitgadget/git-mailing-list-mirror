Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60406111AD
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178688; cv=none; b=XC+eFHUOHJWdTBGz7hfRKNBpysGxiQzsm68hxpTjpb47bNT9Gbs2uZTiybhrthrlxnklxy9LxzALpvZ0i69XHMcGpYJJ207EFkTkGVngojl4oWbyh8zQSypeuPuZecR/PRYRMH0ZSJi0M9fxsfrECMS1uyBEAEcYTRgCkP+0TFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178688; c=relaxed/simple;
	bh=fFv7u5pusTQFfgM7huBEdP+GyXetG54K733XCgnwi3o=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=GPwpbMKOjdE/BAMRubI3oh5F7r9FAO6NIQxVtOuCNzox0h41GM7DX9aGwrTxfWS5AvdAHxyW5Un6MhIeEDrgcFHYpR424PVizxc4M2vXz15wPqusceITRTGBoQ87COHC/YWn10Mt9bsnwZjGjknMryP6aJNX8sickyr+9BLf2sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=X03KJLrK; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="X03KJLrK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=fFv7u5pusTQFfgM7huBEdP+GyXetG54K733XCgnwi3o=;
 b=X03KJLrKs7gjzNTYQmMpkodoTifwWysHkSyq78IudCULOQ86iBE5DwnFB2mSU7lyTjH35Cug7flo
   /TQtZ0pIUCdO62CZZ5471XD/AK+0qERLvhsLdkE6VcXsSIpoxly4/OfA4lJi1LsypMWemnWbNHGz
   uW/sf7AkoHXIUxCJNdQtp3NfgzzM+obzeZFBjU/WRhVpzEyWDmQk2aIwvgyRxRF+F6l3fYS9pK1S
   7VYGzk0AXXFPx3gAstU6n0sU9s5cFtufHumPwkclNV31+8rTyB2TB7MEtYWJI0KBQrSA2lwEf76u
   17XqwLaAfzp45aviQQd/EizUx87qUcvDRWepZw==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLI007BBASZST20@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 17 Oct 2024 15:24:35 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Thu, 17 Oct 2024 17:23:21 +0200
Message-id: <D4Y6NN4JPPLV.3JQ9OIPD3N6OZ@ferdinandy.com>
Subject: Re: [PATCH v8 0/6] set-head/fetch remote/HEAD updates,
 small change from v7
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>, <karthik.188@gmail.com>
To: "Taylor Blau" <me@ttaylorr.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241012230428.3259229-1-bence@ferdinandy.com>
 <20241014225431.1394565-1-bence@ferdinandy.com> <Zw8IKyPkG0Hr6/5t@nand.local>
 <D4X2ZZAT5LKS.1FZ375SIMBV2F@ferdinandy.com> <ZxAqhqHwomsRq2Ck@nand.local>
In-reply-to: <ZxAqhqHwomsRq2Ck@nand.local>
Reporting-Meta:
 AAHo0fHSdeujgZenMQEmt5GGKC/QNiuudDp94r4ZmpdGel6GlYOpAyJfvdSRzAdp
 Da8LRn31nF3iTMfaw7LcFTpsCSQpjb1in4Z7LzrgeK/nH8G3v70LkymR+ltPUvRR
 Ijqyd1k3fHH2NoVUmY7fg1NUyBqSoek41wTbwBFMoqpYDAMtuPcSIVul9Slfqa7d
 O12zrlAkMqM5o/ebf65/5i/o8xg0xJQZ1Dak5f52rEMVSHZtEo1Bt/lZBeKQzmQj
 ZZzf2a52UD6VglK/UluLrJEjK/R1bZY6HWJL6uGuLFNpT5q+GYFUsZKn0iLUpSmR
 AOEhF/kmpZDkaLfbzrjl8wXruyXUbuEXNUFmDZiShnY524aUnYrU5L/GPV4Lze+U
 Lt865VmbUtfcUulMG4c5zsNOn/IvfFimW7qWo+jvAvCJekoJ4cgsM4vXDCAXMu0Y
 lNjPbDVNuRY/k+M9yaAscX4E3m5NioxYpQ/eJcGgH7UmwulyBbtomoY=


On Wed Oct 16, 2024 at 23:05, Taylor Blau <me@ttaylorr.com> wrote:
> On Wed, Oct 16, 2024 at 10:18:44AM +0200, Bence Ferdinandy wrote:
>> Thanks for the heads up! I see that indeed the failing output is differe=
nt than
>> what I have locally (e.g. no "apis/HEAD -> apis/main" in any of the test=
 files
>> I have). On the other hand I can't reproduce it so I will need some help=
 with
>> this I think.
>
> I similarly could not reproduce it (I ran 'make test' on this topic
> before integrating it into 'seen', and it passed, otherwise I wouldn't
> have picked it up).
>
> I am not sure what the differences are. The 'ci' directory has some more
> bits on how the various suites are run, and the '.github/workflows'
> directory has some more bits still.

I managed to reproduce it in docker once, but I'm not sure how and I wasn't
able to do it again ... On the other hand (using some printf) I managed to
figure out that `fetch --multiple --all` is running both in the CI and loca=
lly
and the difference is actually what we see in the output (so no error per s=
e).
E.g. in t5505.55 update, if you run it locally refs/remotes/apis/HEAD does =
not
exist, while in the CI it does.

I'm not sure why this difference exists yet, so I'm hoping someone might ha=
ve
an idea. I'll keep poking around in the meanwhile.

Thanks,
Bence
