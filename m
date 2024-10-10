Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF841CCB4D
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 19:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728587331; cv=none; b=or2SBzSPiJ/HP6AhQk7FQIjMr9ZczQ2+TIlFx+KSQKQHdtavy/iUawL8lDIQakzrG0OtSdnRpwD4LK8UhRqWS0aoCwaPYIStoRDCUQRE3lzlBe6qiGyphInN4sA2B0G/JJ+VH4N7PWwhJfVIQ8r/g9MYW3y7v7XIW7Ut7FPPT2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728587331; c=relaxed/simple;
	bh=AlhHlGrNk/BdZw14UWj52bhNo+RueRZzGvi0rxAohag=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=iIGOC8Xw8PTmK/cULuatyTo1NfmEqWxBCCpc2Reaq3yc1m6fuqKkzvFAY+EWI1oWygqBkfckvTpEY41iKb0wr2dMmdaewATbR4mCNd5sYP6Uh0AgOnFlJrEOJBRHqhR4EU0P1Mn3fszcmDP19aAP+vWHbq2VvD+yeiDrAxkTCKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=ow9RCPAv; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="ow9RCPAv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=bijWjXuUxhd5nOOgJgkPcDeQIUm0TG3kt8IK6hdwnKw=;
 b=ow9RCPAvTviqu0DTKGxCWt7yx/r6lFd2RJ7G04mA8xz9jbmfbCI2RPeLbjHDcNwSwDBjUOKKTgXT
   oa/xgrd8OP+r+Kq7GTFKePR+fL6wW3G39WXmcLRVjJuwWDX58cfbJGf77Or8V9f8Gob3dBljE7Au
   ttcBZDpFCCsKAbRH6DDxmqMHwadpKP7GawOLjBA4o1yIHjVGa4LxUfy8yrhyWfsIEgCRZ8Igi6kl
   1WxtS3wMglQ/o82e+X4D4u2zg7ccrg0/y501s8SKYu0TLCSwpDCtZqoVMlxlM4m5Oynv8TeEA3i8
   B6K1q8vQDMMjUTkseUtaYWMcZWg+YujGME0jKA==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SL5008SXMINQH20@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 10 Oct 2024 19:08:47 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Thu, 10 Oct 2024 21:08:23 +0200
Message-id: <D4SD24J4X5ET.34TQIQDDCX8E@ferdinandy.com>
Subject: Re: [PATCH v5 3/6] set-head: better output for --auto
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 "Taylor Blau" <me@ttaylorr.com>, =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <xmqq1q0xhu13.fsf@gitster.g>
 <20241009135747.3563204-1-bence@ferdinandy.com>
 <20241009135747.3563204-3-bence@ferdinandy.com> <xmqqjzehq9qk.fsf@gitster.g>
 <xmqqv7y0lzn5.fsf@gitster.g>
In-reply-to: <xmqqv7y0lzn5.fsf@gitster.g>
Reporting-Meta:
 AAH8u2vpEoRpHK4v3/WC03d2eHTq9aUOBf4nF1Wfyq2TlhcZB89qEMJ+1f3MNOu+
 iEJW2OdUz3Lf2SCM9d4Zdhde42zWkFaREOS4pOEGb35LQvnT8CfRpkoNX7JAHiEg
 h8CJB39M7AJ5rTVsV3jIhprjr8rfrpZs1jL3IC5SQ0USWZlu9/x1Eizi95UCEby8
 OJWwNcvzORTCAI3gH0PUYj/IQiZHmaVCaONaVmmWLvazBOqlILjO+EcuI1f465Xj
 F75fJzc3hZBjlls+PzXeE7UPJcpHkT2jPz/5khJV4EuH2SEz/6GvmCabCmQR3vyn
 ee0KoTo7lq/Z+TAQHmltE3LZYCtVWqjQJplXQ+ANQuOeMlzdv3InnmzppUOxCvUR
 GuL6C/Zwkvqj4CXX4cAqS5tmOAOMOR2s0cFE/33Fh6v8tL3+872sCYKRIEynAGBQ
 ijHcxpmgNYm5SWpLPQ5TEhjkC7xGY6xyuplzLJSr4S5OBMatoWhZIzo=


On Thu Oct 10, 2024 at 17:57, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Bence Ferdinandy <bence@ferdinandy.com> writes:
>>
>>> +static void report_auto(const char *remote, const char *head_name,
>>> +			struct strbuf *buf_prev) {
>>> +	struct strbuf buf_prefix =3D STRBUF_INIT;
>>> +	const char *prev_head;
>>
>> I think we need to initialize prev_head to NULL.
>>
>>> +	strbuf_addf(&buf_prefix, "refs/remotes/%s/", remote);
>>> +	skip_prefix(buf_prev->buf, buf_prefix.buf, &prev_head);
>>
>> If the symref was not pointing into the "refs/remotes/<remote>/"
>> hierarchy previously, skip_prefix() comes back without touching
>> prev_head (i.e. not starting with the prefix does not clear it).
>
> The two uninitialized prev_head were also noticed by compilers in
> multiple jobs at GitHub CI.
>
> https://github.com/git/git/actions/runs/11265515664

I wonder why that didn't fail the build for me locally. I was running

make -j8 install PREFIX=3D$HOME/.local

for testing. Should I have added a flag or ENV variable somewhere?

Anyhow, the v6 I sent earlier today should fix this (and hopefully all your
other comments as well).

Thanks,
Bence

--=20
bence.ferdinandy.com

