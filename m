Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3287213B287
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721753566; cv=none; b=tzHguusEvz6KfAARYRe3Q11YnjbjZ57AMvWo+rGMiXm0dgpiCIOryBi7FP05p3/wXcMuakoU7QKwo7Dis0WK/UFzq/6/C3+CMT2q2V3vYRyeznW3aueiuHxFMvrksRrfBuHCqhE6Fgc+igVmx2zWrbu5Hs/jr03soND+Fw/iTjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721753566; c=relaxed/simple;
	bh=txHGViMezBNNtil+EaZu6Kq+YCANuHlqVQGPPvjLUHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M9OMivFDKEe6+rHPjrdQTvZqTTTROoECS3bEk2xMjYM1E1QibMtqVVp67Ot62XLoLsodPhos40DcoEtDnp/eof715aHbm8OZUJWcLv66w9oxoYax7jOukbVTO+oaNlPwlZYr1ZnBsZuw1IRaMExH2ess4V4n79wgwFyoWuETpP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FK7jhZAE; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FK7jhZAE"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AB85E20648;
	Tue, 23 Jul 2024 12:52:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=txHGViMezBNN
	til+EaZu6Kq+YCANuHlqVQGPPvjLUHs=; b=FK7jhZAEUV8qxvU6Gvrg0N4eo/Ge
	It3bu28eHA8djTb3mv/0spObV57bPsEK+NHrkik8xDpQX7lWT5WmFPHbZQeki19z
	QlWHjeUQcSeQ2M4rnznb6jvIGfAqwMl/lsFY9K0rstb2BbL4wt+GtJ+d2lO+SRSN
	usTr3iA3b7oWxT0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A3D6C20647;
	Tue, 23 Jul 2024 12:52:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2C1C620646;
	Tue, 23 Jul 2024 12:52:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] add-p P fixups
In-Reply-To: <62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com> (Phillip Wood's
	message of "Tue, 23 Jul 2024 10:15:03 +0100")
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
	<62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
Date: Tue, 23 Jul 2024 09:52:39 -0700
Message-ID: <xmqqed7k2gq0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F9905F8C-4913-11EF-A53F-92D9AF168FA5-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Rub=C3=A9n
>
> These changes themselves look sensible. As rj/add-p-pager is only in
> seen I assume you'll re-roll with these squashed in once everyone is
> happy?

Ah, good point.  Throwing around "oops, here is a fixup" makes the
development harder to follow for those watching from the sidelines.
I try to keep what is in my tree on 'seen' fairly complete, but
at some point we need to "sync up".

Thanks.
