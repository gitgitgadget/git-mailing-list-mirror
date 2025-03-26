Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40091946AA
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 07:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742972623; cv=none; b=bOKF2YQEwg0uJij044edyiib8Svrlg28OwypF/Kd64MHt299ALeA018AOMj7Qyi/yIQbNCMybkpBfHv9R5P/W6uy1oZn3G/97gD6W8DC+tLKn721E59VAUetSBYs8HiXQRJxv6SUS1WLXWIUpWNEqK5aX8VBlL25/hH0DLyqCTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742972623; c=relaxed/simple;
	bh=ri7UbPCVm9jrU+eHDzSMe4srtX+ql6MTeoOSnzJr7U0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=b+BQzukmteL3L7aiPLWCgrJzaP4vYiIpu5CEmUkFjNlCv1nkm3xMBa4pZTdooF2bJlixVweCk660jHFk9RkU5jS50ZijvsELpord5/qGAkpKvaxsB5ziGCgyElnTpHOJ8Q94X3HVozzII32KFkNTVPoRFeb8v9t7VVGbHPYDtJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=iJAfAt79; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="iJAfAt79"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742972617; x=1743577417;
	i=johannes.schindelin@gmx.de;
	bh=ri7UbPCVm9jrU+eHDzSMe4srtX+ql6MTeoOSnzJr7U0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iJAfAt79iBkdK0LJrBEZWtp6xJcRAkDkaksE3VOETfYWtNdn8EwsHNInEVS3Eq7a
	 9lpIVlT1GHuD/3w5yb4ZbgEv+RRmobI353zj3JBqPnz8QulIht7d/fkiyHnkBiGij
	 7bMV9vM3lHcTBXxxIdGW3kS7dyv/VNEnS81AtEaUDE/1HhSkBAw8eNyQsKOUBScC1
	 FIY1SZMP+aarQHqv1zCJ1fwYqtdHkjzw8+FFBTz278FcNAiFh4Jxyzv+xCC7YQpQk
	 oIuy4HKk2f2UEne6Rhnk1PrwCsCv+20IjCeFR9JZqrmeaLrHZPwJBzofnwHdlbJs6
	 1FCyxDhWyJWd+cPHLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQMuR-1tjwmf3pNB-00KyEF; Wed, 26
 Mar 2025 08:03:37 +0100
Date: Wed, 26 Mar 2025 08:03:36 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 04/10] clar: avoid using the comma operator
 unnecessarily
In-Reply-To: <Z-OWmSe3vCDaZLXy@pks.im>
Message-ID: <b6b1fdc7-2ec3-d569-fc58-5f238e98f428@gmx.de>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com> <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com> <f60ebe376e10d7741f6bd657874a17f6c09d4477.1742945534.git.gitgitgadget@gmail.com> <Z-OWmSe3vCDaZLXy@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NJSLLL4tVuY4Iw3QbphxiW7KxJWKF7ZLo8vKkgyVrjPUQ2CBAGP
 cmF7StPPb9L9NbzjDutkPS65TnOIVXooFTVKpmRiU8T3DisrleIngSUZiGg3avV1i+5Uhy0
 0Tsu/9viQ1MFvcZw9v0xI8YdlAbKexYrDaeMsWd0jyJiWupCpQQYOwUQzFZymfIIRDjYMX2
 JVYr6ES0Cw5hQi1kVRLEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uv+/wjboOl0=;BfXd1TJixjGQJhO/OX5ne/avIKd
 rwwwodzPMIn3Mc3cdrMQsSAksy8vlfM+lcizlQexVjUaytAqFNlKmfahF33ArkA/b5v5YzkUG
 7A7ca0zu2Op8HH/hA0LA/+gmaxrhd/jog85RevGrjENoW6diWTKZzsT0Y+pRjagLMXrwNnL8A
 rHxW2vFAne/Om1ItZxrA7fZWjmzgPNahW+zE+iOMeShAOlRG9DmMq9Pc7/S/9RBEiy+R2mqkn
 zjhL2xW1RGNRzMVDaRxZe5Dse4Ci+75JK1daMfMqiRDX0Ewe74r/+98Jy3xGlJyKYVdsfR5kc
 AS477XguSqYbuTuGrXhfEU0F+D/8nAMSG44k9hzSZ37Ub5CnEtwQIQ10+oj+yCyBm0YU30K+C
 dm4KYxtVW80F5Rn38K3RcWtO1fQSVGKB+QvV+vEqo+eXu5xeI6qaYxB/qZUrTiG9zVFwSRfT4
 yZd1Ocd2ntshW6PUWiK9Jt+u/pUWVVSYE7txjJX+tpJnlKl/cXo3tuwdaYmgTlhSETfChhTFU
 s3QzHVNoqX6QNkDP0EPvjI/Enw4z8wmNtoWARuaYlw9+1FtocWmMqYKUuvBipWTsJk/VhRZ72
 gvXM4hkFLK/demizF9AlSp+mEG8jnT5ZEubXHwKLupRx1qc7MrqqOjBOVcRnj7XoUpdUZ4vQ8
 cJuQi5lFWamje2+cd3VrJAG0lXmYzKvA5X4v/g3NqtA8QABi7lbEb3NlPuj2qj29YEUQI0IcT
 Gz1QMpVJnm9mw8h1u6eE/rs5Yj0sMgsXnDZLiAJFdycB3WcH4/aTmCaJPp5wgqmwTVxocItdQ
 SdfhbLbGvh7bk0BjO4a8XggWNjowYRodGI/9eLp82U/fvVp0bC6IFzT6tkQrQTtmc1tkUW5Is
 JE5yTNm1NR/2rAKLQ+QaA3Cf0smnxwrv5MkPh/icbiGQDfESNf2udI6G6iLDvoC4uefgoe/Dd
 4DlSMQ7FHURPmozgy01oKJaF+4Oms5pWosiBOQ1C8//rT82TQnED2cH3hhF9M+0QEB3LAIufU
 tl8HgBKFCvbS+R1fBK+Vy1/+LUptWxdk4SUQoeqq1AvPOfrcQrSryjxhphJ7qkaCIK4/9Zfz7
 rxMTB+Z8L3kV8lhQf1tAv0rs73fD4FvYSzk1sddjW9rYfyKTJBB6OxJJSxQoo/INXQbsVROkY
 jUNAp3LLyYeCoVMZveSpDIRCw7+iTAZMHz9jVV6nBDitIdjePQFYdeArumVvTcpzceM7zgxqE
 TFFCa0Or7TekrtNjq8IR4B1saFeF06w8fyRLR4gsbgP+CK8TNuH6c+gefJinUrxW8OJCQpkTF
 7dMtlgkCb5ZMBatAdX3neK/c0A4ZcYuSvJ8yAZMgJrMDS6p+9U4yFCI+SCiu7Di4EW5fbtBiE
 5svzEQmoMjnnUgEMTnld3wyoCgJ79McrZxL4J1cyO8wSqI9b9jJo8NtZXC/r1Io5nkdoXxHfV
 8ddkPYp7R+ycKuIsm76XyVPgcikVY6jIGSab6gWbUWaxc0RK1
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, 26 Mar 2025, Patrick Steinhardt wrote:

> On Tue, Mar 25, 2025 at 11:32:08PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The comma operator is a somewhat obscure C feature that is often used =
by
> > mistake and can even cause unintentional code flow. In this instance, =
it
> > makes the code harder to read than necessary, too. Better use a
> > semicolon instead.
>
> This code has changed upstream already, but let's roll with your change
> anyway. I plan to update the clar to the upstream version soonish once I
> have landed integer comparisons, and will take care that there aren't
> any other comment operators left.

Thank you for putting so much energy into improving the tests, I really
appreciate it!

Ciao,
Johannes
