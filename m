Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFC415FA65
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986841; cv=none; b=Tixqm2pdstXefYjhEg8lKA/3/xcgC97aCq45hxejRlQxnssA/B0bqidqC60YZrkJSxcAjWJJ6RKoruxkvymjrLSaGdmevt27KnT+tb3E4OQ59fKCzG1A4oNZJRTVNIR1FYuUTgxOrsVcFBb76Mu45gz1JNk6g99jsA9bZAH4xdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986841; c=relaxed/simple;
	bh=G16bIrGCmrMFeQCt93XMMEbd4HBpbdVMTLAZGl0GbH0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OIICBisqyrYTakILz+QJzF2mSiL5J4vV0+xA+i1S+wtYOBGyDsEHD/mO6yw0cB1zQjVKCadvB2tXRAjJ3yeY2dm2dW8ePGM5LzxeEZNXWCJBb4n+Mq5/BIpbjwkV4qC+PTEzFS7C+MUNFgrMbSV+ju3Yj5EBoQZnjLi4adnbnN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VBFxKuEg; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VBFxKuEg"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B075925509;
	Fri, 21 Jun 2024 12:20:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=G16bIrGCmrMF
	eQCt93XMMEbd4HBpbdVMTLAZGl0GbH0=; b=VBFxKuEgIw8fPW27bJDRLknJE3ky
	EcdyE7P4Lg8R+yPEdBJHvAl/rXCAIktKRJjZOtdZ0jKWaN/CRsNZ80oS9dltmRJj
	QvbW3a4vjDHzbxw99r6+mQlRAH+t28IKDXV50JBvu2qdrFglEkDHx9kbeCN7MPcF
	ru1yWccgGtXA6CU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A8B4B25506;
	Fri, 21 Jun 2024 12:20:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1636325505;
	Fri, 21 Jun 2024 12:20:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2024, #07; Thu, 20)
In-Reply-To: <8d903487-2479-432e-a171-931f264bf9f0@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 21 Jun 2024 07:25:47 +0200")
References: <xmqqfrt7p3ra.fsf@gitster.g>
	<8d903487-2479-432e-a171-931f264bf9f0@gmail.com>
Date: Fri, 21 Jun 2024 09:20:36 -0700
Message-ID: <xmqq1q4qp8rv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3218503C-2FEA-11EF-9CDC-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>> [Discarded]
>>=20
>> * rj/add-p-pager (2024-06-04) 6 commits
>> ...
>>  Expecting a reroll to work well with jk/am-retry
>>  source: <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
>
> I apologize if the delay has given the impression that I lost interest
> in this series.  Due to problems on my end, I haven't been able to
> dedicate time to it.  I'll send an update soon.

No need to apologize.  I'll drop topics that are known to need
further work but they can come back when they are improved.

No need to rush, either.

Thanks.
