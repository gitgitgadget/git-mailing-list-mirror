Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBBA1527B4
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729628140; cv=none; b=HHLuebJy1xzn268Q4jdzN+KEE+eWmzGqiatkkbeBK80wyCKh7iyoHfS5Iq8NwfEopOYrmD0/Qnz/J1lA4iUeNiwGW42jaGCxzFFYYwAsUcIqB+PNQRXPDtutVHsnsW/kujAkOa+vD5iRwFReoA2ACcQJdHBgN7cSSbNY2nvQqBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729628140; c=relaxed/simple;
	bh=4XKfLvOnqCS9vlgKhBv8SSDFIj12WBkfjIE8Bcxy8MI=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=P0WhClfIkTRBqjt6v9NS/kISRndwqz+N2zldVa30KwTUuUYkv4pj2qirVNoaHSJcZUHpWnG5+QLk88wNcpQwltU/hUTFp138vDUFXJce2PiG+PQPBau56NJK5sr/G70AvwibAnc2iURA7is7Z1m64FRtAVr5HrHgpF1RvDGh60U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=j3eYRBhb; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="j3eYRBhb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=ZDLXF2L6Gb9rwOhPUMzqP+Pbnr/QRhOuAiIrENi5M3A=;
 b=j3eYRBhbhNvPN7ZTOLezYl2z71iL7ueefqeDmiDae1K7USohBBK39cP3dEPQGMHYT81crO4zJcIY
   8qAmZIs0l1kud6ZnCW5RTYBBiy92jkqtcHJQG15LjucGNLM/In8akuLkqH6AOmQSUa5UioTKMo1+
   5FE0Z5Ebe5TxB6Z3pO7y8FCumFFPnhTayNEp/1Mz2sU6w2dBdu0PsuJaG3gtgSmQTHKDs+Qpm2kM
   5oU++hoWA7cX5ombdq0X9D9dg6VMAx1vhwkovApgoR4oDhgojnioFSPpPXCJ6AuuoTXzwTpLB2qc
   15cKijYla5rqsKGNu9NfR2z93WZRelgA6txd1Q==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLR00KLKXM1SY30@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 22 Oct 2024 20:15:37 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Tue, 22 Oct 2024 22:14:12 +0200
Message-id: <D52LZ1W0FH29.1GVLRMGN80HPB@ferdinandy.com>
Subject: Re: [PATCH v11 1/8] t/t5505-remote: set default branch to main
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>, "Karthik Nayak" <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <43d44c82-b93d-4ac9-a5ac-ae5f70982cfd@ferdinandy.com>
 <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241022194710.3743691-2-bence@ferdinandy.com>
 <79c9cd6d-7bcc-4014-91c0-149505f70136@app.fastmail.com>
In-reply-to: <79c9cd6d-7bcc-4014-91c0-149505f70136@app.fastmail.com>
Reporting-Meta:
 AAG656Mgg8rkdVTkhA9mTB/tlXmcC2Vv9h4yPU9dKJPc5HdMkMGX4ZKUOB6YvE+z
 l01DlZftdJvDV31NUU+45iQpbNnTHNWvBZho0LKF+RPhz4fHyhg3+z/BfhBGPaJ2
 9hS/Qo2q8R4K6ad60RK/KGaGW6jPGZFPc5Zs9uZKT/R/OFMjZKi9jr9r2zelqENw
 mKDFgtmKtSXJJgUGE+HNIewzRGdzdA0Dt3XYreX6jMPqG9S75DuzfARj9nPU4ZoL
 /Y0q6D2NGHdvy0Iub3Ju/75aypOEsmGj5pkLYrdQ4pJk3vCb7YFHSKELwXuS6aNI
 V+oTCiteg+tslg5aKsJMIrvTT2WPZRsR03daA3eO/1IhtYsJJrQDbD1JsqrxaT1a
 X6hdvSfAOsfU38TMY70pPK/miXgBMnxP8D3YS/ueUOZ4YOGVIv7ZZKhJN7oAGKZE
 F4Sh/Vr6W5G6/dfwiM8ZCpvUnPsKX3DSUCN8bdTuMk6be1PpVriyy5V6


On Tue Oct 22, 2024 at 21:53, Kristoffer Haugsbakk <kristofferhaugsbakk@fas=
tmail.com> wrote:
> On Tue, Oct 22, 2024, at 21:45, Bence Ferdinandy wrote:
>> Consider the bare repository called "mirror" in the test.  Running `git
>> remote add --mirror -f origin ../one` will not change HEAD, consequently
>> if init.defaultBranch is not the same as what HEAD in the remote
>> ("one"), HEAD in "mirror" will be pointing to a non-existent reference.
>> Hence if "mirror" is used as a remote by yet another repository,
>> ls-remote will not show HEAD. On the other hand, if init.defaultBranch
>> happens to match HEAD in "one", then ls-remote will show HEAD.
>>
>> Since the CI globally exports GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmai=
n,
>> there's a drift between how the test repositories are set up in the CI
>> and during local testing. This issue does not manifest currently, as the
>> test does not do any remote HEAD manipulation where this would come up,
>> but should such things be added, a locally passing test would break the
>> CI vice-versa.
>>
>> Set GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain in the test to be
>> consistent with the CI.
>> ---
>>
>> Notes:
>>     v9: - new patch
>>         - a bandaid for the CI issue noticed by Taylor (cf:
>>           https://lore.kernel.org/git/Zw8IKyPkG0Hr6%2F5t@nand.local/),=
=20
>> but
>>           see
>>          =20
>> https://lore.kernel.org/git/D4ZAELFWJMKN.S88LJ6YK31LZ@ferdinandy.com/=20
>> for the root cause in detail
>
> Why no signoff?

Because I always forget :( I've been thinking on making it by default, but
I didn't want to add it to all the work related commits, where I'd be the o=
nly
one doing it, but I just found the format.signoff setting, so I should be
covered for future patches.

I'll wait some time before sending a fix for this :)

Thanks,
Bence

--=20
bence.ferdinandy.com

