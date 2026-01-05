Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B41DD0D4
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610385; cv=pass; b=Y1jqCSCyuMz2ymyGDux9CIYDHU1kTbveSB5GIuFIO+27mTViThyHYz//eC4S6+qVtsZ8TJB6RjWNWHNfKQ0KitjW36J0drka/3ehKbzQGsVVDgO5NM+ZTGsgPgmu5GRqsYGqhaFBDmv/cDGRTBSNo/Sb9CNY+VU+YqDY/y6rVMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610385; c=relaxed/simple;
	bh=4Cho69UOYqNEMQR+xieClxDzFiyLAsipWbDHnMUEGpY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uiVC4fIRUzkfwxoC3l7Tt4uZARv0cMbXapCkYtmyMja8LYLBF3BhIV/jRFGdP2jl/sFBrWBr0EjwooJx/Vppmq4Y/b6R4z/CPG+ye5gX1irS4kZK0Qc7rhAFE9CmOJEFGpwZoCRtT21qzT6xRJG5wHAEGmMPk7ErKIvqGsINzow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=KcCbvq2Z; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="KcCbvq2Z"
ARC-Seal: i=1; a=rsa-sha256; t=1767610370; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=T5drjePkPXPecI3VHJSBEjIUCJ/5dxzkCn5pq0h+sa+fy2tXeDyEayw/ZJ5QzT19zkeHbT9y8MqiwREJJN2+LmlWPP/EpnzsThFtPnNUuv57aYpUWe3GCwVm0UM0Z9jha56wPVu3s8OMSAKULfCEs+oXMN89NNQnbXf+CRI2c+E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767610370; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TPm3FVLsZgfKBKJvxClIAtB9g/A8ZynNQ5RjrjN54ks=; 
	b=CLY+TV4AedmKgIja8sHh2EIQM5Z91yW5x02I8yNWtwbMc7YWF9J6+SojjSWg7rZd2Rhm/UkJb2cuAz4pP1+DVKcuPx+Gx33RR2oD90ihAZYisE0qac3NCr1uVi+etSti6v++0vaMKjJUPC6priCUn4nkQuXbAmeWUI5YrzvNk5o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767610370;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=TPm3FVLsZgfKBKJvxClIAtB9g/A8ZynNQ5RjrjN54ks=;
	b=KcCbvq2ZYigaQWf4/USZLMeo3QeodoYr9D7AeU03WZD49W2u9q246uTGL2L/ApFZ
	UHVtIJPuN5/ugigivtMm95x+z47vqAQFxmWmXng9vd2obPcxLjQCe1gfUCH6q1HqRpv
	/lOO0kzKVFmCMV8HSF71PXrmhfI9KlcfKoU9OwzY=
Received: by mx.zohomail.com with SMTPS id 1767610368301696.5458946872528;
	Mon, 5 Jan 2026 02:52:48 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Patrick Steinhardt <ps@pks.im>,
 Josh Steadmon <steadmon@google.com>, Ben Knoble <ben.knoble@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v6 00/11] Convert remaining hooks to hook.h
In-Reply-To: <xmqq344ulu4a.fsf@gitster.g>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251226122334.16687-1-adrian.ratiu@collabora.com>
 <xmqq344ulu4a.fsf@gitster.g>
Date: Mon, 05 Jan 2026 12:52:43 +0200
Message-ID: <87h5t0babo.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Sun, 28 Dec 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> Hello everyone,
>>
>> This series finishes the hook.[ch] conversion for the remaining hooks in
>> preparation for adding config-based hooks and enabling parallel hook
>> execution where possible (that will be a separate series from this one).
>>
>> v6 is minor refresh for some last nits. Details + range-diff below.
>
> I didn't see anything iffy in the series.  Will replace.
>
> Should we mark this for 'next'?

Yes, I think it's ready. Thanks!
