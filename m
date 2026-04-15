Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F443793B3
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776276191; cv=none; b=HvukSl5Mird9+d2y8BbqspcIkKlbdbrXDQQ+PzYV10w4RZTaxpVR3B/njyBTq7/WkXYInOYbyaWugowbf+mui0ult8YEf+bFINQkPc03K8yKuLwIfC26m/3QXTAoPJE+V6e971wOunFc3Embh4gw9FGMjhnIWuYBiYEevE2CRGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776276191; c=relaxed/simple;
	bh=wnaF4oMBsvVlevhgDr0C0/rvFaRRczsb0LLe9m/8t20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9wOi4rKLzC/mk9GlZyQwpZPuAbsITOE6TUa0y30G33jYyVrRua7Nfcl17zX6lBTWb/R4N3Y7HlCuICgxILvksZU363CHd6vAY3RNwQSv87r0aE5A2wOowbF+g4tgXVrBLJu8OKaBjtSWwVRffSqvb3KVDvxceyLoUwB5xG22nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=baqWBoU1; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=bYos9O+b; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="baqWBoU1";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="bYos9O+b"
DKIM-Signature: a=rsa-sha256; b=baqWBoU1BgsgANjsePZkT6l7N/aAjWE+hMTDOyS5T9yMh7xOLPHt0qCRY+0aEWB99UVnlMr1jlMqbzU7/n+LWnCjkCstG6SnWG0Eo7ldyOJzq3su5JKTXWG4DVRpMtrdQE47JmtzNUsiRcWgn9xdADKbBHSjkXAVWb+rmjeuUgHJ6UhkQGdKnxVGzsYTIzjm8wdDRdJsDCDvkirewCZNXhLLjD60A6E1G7hlq0NTwkNGdI3fUZQ+ywon/TxezR2H119qT1SjTf/Kdepgd/7VLBDkTo1cZx7kNyv2c+VHnCFOpjcCb/GhR/oBCd0i57JLVhjEFcNEfDibF8nB5kTx2A==; s=purelymail1; d=malon.dev; v=1; bh=wnaF4oMBsvVlevhgDr0C0/rvFaRRczsb0LLe9m/8t20=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=bYos9O+bY9yaA/dzpui6PR0ttVYs00s5BSR4rzrdbaZko67o4rLoyuR0I7LQ+9Uh1FIWlMJZQUzRANLvZU2SYYLJK65umiCzGYVGdHP0d1yiKSYdcgBDUxXeYwUrxDIpc9Laph97mUWXrSyjFHdo+94LH8H1fLQiK+I7HEHqgipOJ8Kzq5gU85HRrehJ5sSmX4XbdEsnOHehV0pN7CFQq7d/ywA1rfflvrC5huG8XvpTBUeK9zdGL1JsthsRHXfHkG9887yURQlkxMht97VX4hop5PzUo9jxk47U36Zkq3Rm5U9b9p15jC9vE5kigArd+SbBMER0ORS8I0FoAR6XVA==; s=purelymail1; d=purelymail.com; v=1; bh=wnaF4oMBsvVlevhgDr0C0/rvFaRRczsb0LLe9m/8t20=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1138729646;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 15 Apr 2026 18:03:05 +0000 (UTC)
Message-ID: <c87f1f12-d0cc-4150-8f43-4dc9cc1fe24f@malon.dev>
Date: Thu, 16 Apr 2026 02:03:00 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH] promisor-remote: fix promisor.quiet to use the
 correct repository
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, Trieu Huynh <vikingtc4@gmail.com>
Cc: git@vger.kernel.org
References: <20260406183041.783800-1-vikingtc4@gmail.com>
 <fbe81fee-ef1a-499e-bf53-d6f1761bb30e@malon.dev> <xmqqzf3dxqdy.fsf@gitster.g>
 <a6382ad3-6ce4-4e85-bdff-8e90068f25dd@malon.dev>
 <fcnv7hv53khhctafvzqn6dygbyq2tkyy4i2gawcbahdnevg2hw@7h6bvxlub7ib>
 <xmqqwly86s3a.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqwly86s3a.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 4/16/26 01:39, Junio C Hamano wrote:
>=20
> The discussion thread stalled at this point.  Are we happy with the
> proposed changes?
>=20
> Thanks.

After running it a week later, the error had (surprisingly) disappeared,=20
and I couldn=E2=80=99t reproduce it no matter what I tried.

Since the code works well on everyone=E2=80=99s computer and on the CI test=
s, I=20
suppose I must have got it wrong earlier.

Thanks, Yuchen
