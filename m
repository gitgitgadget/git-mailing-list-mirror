Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDF278C91
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733386938; cv=none; b=NTSUnj4TIXlvchP+Qz3g97Z5/EQMLuy9XKHi+GfAx5jphX5FwPMx5H/R1kx92ccSFTjn0XwaBPAXMGq38NfcbYLPJcmx49z6d8Gjcb5vWWNIwHdF85pQgkUV+Q+xPrqUMTXVxyqHeAX5AxnmQ6Pae2SN0NbgR81ZCfgFWOyuo6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733386938; c=relaxed/simple;
	bh=3Fwb4aYGkvU6UyU2urTbaU/kenFOYZPNaAHR95Ra8TU=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=s4L1xO44LSqqYMPy1p2KdDwKV31liFsuNfl3iC45/9OQw588ShF2Np/sC/SUh54D5diOj4vBsn1GGjgO9ov1zSuEmG+yM30SfZyAZXvuQ3lFd90Qg8BBWdHCzMwyqov1SkVVVwNz03x2LQbQDgCj0QvOg3dRHVEenixSxgDU1i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=dmdMukAA; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="dmdMukAA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=FQyUk9YEvgiYxujMYxA5aZyVkvxs5oHmUJLZucaZPd8=;
 b=dmdMukAAQA+l7n9flE+Xgvrl2Clqg1qgZqALv+ZOFwhX8rgz0/MSS1ZTAZUvp8J1hoz39dAS61du
   5WYg+Gf8SYCLL6cv67UWEXRCsgcfM12sGqDv8aWJCxU4i8LQ1SY0FUPB1/FqAuFQvAkpVAEE5wo/
   q5675rd355Kj6sF6HEgfER4yrarHgdLtC7Arc+KJkW+4hUAhfUkrosdLSrqxq2Cbr7TCMV9eUA8p
   5GJDoN5ZxF1UlGEzbUyuVc/NHhREAILQCmfXB44RC5jTmRlhee6GU1WfLFvJaXVyekP4BiOhYwGI
   GcXVKeDeNEwbzlDbtxCwo4QmBU7QEw+yE9XG9Q==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SO0006VXHX2YD90@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 05 Dec 2024 08:22:14 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Thu, 05 Dec 2024 09:21:32 +0100
Message-id: <D63MDD4V1FLQ.SL5FXZ9YS8J6@ferdinandy.com>
Subject: Re: [PATCH] advice: suggest using subcommand "git config set"
Cc: <git@vger.kernel.org>, "Patrick Steinhardt" <ps@pks.im>,
 "Heba Waly" <heba.waly@gmail.com>,
 =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
To: "Justin Tobler" <jltobler@gmail.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241204130928.1059851-1-bence@ferdinandy.com>
 <fsqe37ibvarrsjugc4r2cairndr37cmyc64jneaqzhkq4qiiqd@6rskou37aqat>
In-reply-to: <fsqe37ibvarrsjugc4r2cairndr37cmyc64jneaqzhkq4qiiqd@6rskou37aqat>
Reporting-Meta:
 AAH11yhriUhgHy62OA9uybEiraNYFSONNmX64BVGEwUSEhg8BLOQd4mzo9UFnSBZ
 AHNwwSRX2ekeyf72T4Z61EwnSD0wYBViIwKkxP+yfl+X2LbDOCnaGSAswErt2dae
 eTlKWGnc/FIXxkNmeKf7mq/kSR9wb5XkC69YCxXJ6Kxi2Fw35GKCgQxlTDUdeEPk
 XnmV8//I12L3EP58RfewdpbBUPmHefhZKdaJ4GBcwVx3gzQZ8ifv8Mun3amCsgCw
 P/9FeHajagdCZ5jxN9pz9RszbM7jbFZ9rc8OQhYWxYB3Gzvu0VhJitgqhbz1U9dy
 zIuL7UyzPwXSk+8g/GUUXrNmHt1HXJokUcvfjoiVb2xfkitGfyEWB0cjm1rSrSwD
 08I7fB57cjP4MIsC50cIeTOhJwYEeoojGKlKfXAh2IxYM5oEsppPkBhMZ/fNF2f/
 7Kf4MUuWc/+z72W75UowTGo2ATiZVvGJWew+u/Nis3IvdBQf1UZtyaY=


On Wed Dec 04, 2024 at 18:19, Justin Tobler <jltobler@gmail.com> wrote:
> On 24/12/04 02:08PM, Bence Ferdinandy wrote:
>> The advice message currently suggests using "git config advice..." to
>> disable advice messages, but since 00bbdde141f we have the "set"
>
> When referencing an existing commit, I think there is a preference to
> use the output of:
>
>   $ git show -s --format=3Dreference 00bbdde141f
>   00bbdde141 (builtin/config: introduce "set" subcommand, 2024-05-06)

Ack.

>
>> subcommand for config. Change the disable advice message to use the
>> subcommand instead. Change all uses of "git config advice" in the tests
>> to use the subcommand.
>
> Both "git config <config> <value>" and "git config set <config> <value>"
> are functionally the same operation. So the motivation for this seems to
> be to push/promote usage of the new "set" subcommand. I find the newer
> interface to be more intuitive and in line with modern command
> interfaces so updating the advice turn off messages here seems
> reasonable to me.

Yes, that was the motivation, I'll make that explicit in the commit message=
.

>
> There does appear to be other instances where the the advice turn off
> instructions are open-coded and thus retain the prior format. This does
> result in some inconsistency, which may not be a big deal, but maybe it
> would make sense to also adjust those sites as part of this series as
> also. Otherwise the changes in this patch look correct.

Fair point. Grepping the .c files yielded three more instances, I'll change
those as well.


Thanks,
Bence
