Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687AA4F5FD
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858966; cv=none; b=FbFyQka+jrGCfuncCD6vgnfSo5yvDZi5kxfe9cgGBFZkDcS6Eqrn1CIjn8dfjvpQqaOHcrBWCTmq8DIp8c4evTnj+4cfT/qp3Bwwvx6oLjYX76bn6ADrCoA1gM5pTf3dPRcsVNdVyU/8M89pGuEYXTMmWfGw1Ny1iRZucUiiHNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858966; c=relaxed/simple;
	bh=dJpLAEz2aJeF5eRrr6Z+pngsL15jxP/SgjUFggt7yQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p3Sr0PQYARCXneetilQfoAw0+DNBye2wkYtJ18pinS2O/9tBGuC9iCxprFencsvcq8z/zlaUx9O00dcGWTafjtYRlSKrgTagpS+c8/Uqv3gUkhQsT1nZ9spF3nAt9h0cA4g21zHKJRa3bwGw/fkpnZWNNwzUyJDchpcifnU7pR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IQTMib2x; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IQTMib2x"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 44C2B1EA876;
	Thu, 11 Apr 2024 14:09:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dJpLAEz2aJeF
	5eRrr6Z+pngsL15jxP/SgjUFggt7yQw=; b=IQTMib2xWyHSXMAcOheg/a+8YTP9
	jPBmINHK5rXRbR4BjfwDO6qfG1+jfgadxeDjIAvFf2L3AgIfD5CtL546aKEbk4vw
	u9xWeOI8fgxMoq6nen45UeX+y9nd5386nSrF+HwC2wCSQ1vtxKLC5hMjNQr+sZMp
	10k272URAiic168=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 38C751EA875;
	Thu, 11 Apr 2024 14:09:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9ABA01EA874;
	Thu, 11 Apr 2024 14:09:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc: =?utf-8?B?56eD5aS054Gv56y86bG8?= via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  =?utf-8?B?56eD5aS054Gv56y86bG8?= <ttdlyu@163.com>
Subject: Re: [PATCH v2 1/2] doc: git.txt-Fix inconsistency param description
In-Reply-To: <CAN0heSpvKFKVnyve0wvcVJ3gvm5H8OggVTKpz2Se4je3iRHwCw@mail.gmail.com>
	("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 11 Apr 2024 12:39:59
 +0200")
References: <pull.1669.git.git.1707479467028.gitgitgadget@gmail.com>
	<pull.1669.v2.git.git.1712822221.gitgitgadget@gmail.com>
	<28a5625f32cca6ef134a385fe9ba66962c40100f.1712822221.git.gitgitgadget@gmail.com>
	<CAN0heSpvKFKVnyve0wvcVJ3gvm5H8OggVTKpz2Se4je3iRHwCw@mail.gmail.com>
Date: Thu, 11 Apr 2024 11:09:16 -0700
Message-ID: <xmqqttk7u5yr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 9CB77290-F82E-11EE-A45D-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Martin =C3=85gren <martin.agren@gmail.com> writes:

> I wonder if this patch should instead change both --namespace=3D<name> =
and
> --namespace=3D<path> to --namespace=3D<namespace> and give some motivat=
ion
> such as "Make the placeholder consistent with the gitnamespaces
> document." What do you think?

Sounds sensible to me.

