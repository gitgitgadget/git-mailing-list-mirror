Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290C91805F
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 22:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707518562; cv=none; b=oLcZP/QDgQ0i5CKRDQeOAUkbw8bziMd1/nxgHw4lmEjE+i/PDRssgj73XwJ6h5ERNbIjwC3pytvCDgZ+S3XX2mOZFZA6yufTMwwKo47F6EGUcRAZZseTbwEcQC2d96WxdL/PQmTQjpr/OH3XtiBg2O9MaSpgmaw6i2L3AxrYgpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707518562; c=relaxed/simple;
	bh=W+TPA0WsSu+Pn4f+Vocm/hFiXnlqIMBBILrv04r9jmY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CfcHKcandKNE3hxfRSmIbWAyxRgKb99OFUE5pHKT8hs8JRwtvnJezVyhHaooo00gSdYKMfQDHQx9wf6y2rDdFXgwd31dZ8w8+ZE/GEtRkun6d76c9a/rC9UKpArrUXxIMcAmaIHMYfxh8mqNdrgVpylRs9rozIOgZB2B5s4d/BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DoF3LtQy; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DoF3LtQy"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A6F8B1C5442;
	Fri,  9 Feb 2024 17:42:39 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=W+TPA0WsSu+Pn4f+Vocm/hFiXnlqIMBBILrv04
	r9jmY=; b=DoF3LtQyr2Mcq83UTwOflD0JcgKsLUFhNA/8yeBjBzy7koqfxnlAWS
	HjBD2DjbqRamISi4srSk7nLeOKVpI21B+ZbzeH9lgvLlwS9h7qK0F31mMStZQDHs
	CfbH3faIEHQhOswidT9f1QneVVI9shaTwMEeLUqrMcvNwaS50Wrhs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E4CE1C5441;
	Fri,  9 Feb 2024 17:42:39 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 004DF1C543F;
	Fri,  9 Feb 2024 17:42:38 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Hesse <list@eworm.de>, Philippe Blain
 <levraiphilippeblain@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,  Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] imap-send: include strbuf.h
In-Reply-To: <20240209222622.102208-1-list@eworm.de> (Christian Hesse's
	message of "Fri, 9 Feb 2024 23:26:22 +0100")
References: <20240209222622.102208-1-list@eworm.de>
Date: Fri, 09 Feb 2024 14:42:37 -0800
Message-ID: <xmqqil2xcl9e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 871537A0-C79C-11EE-A477-25B3960A682E-77302942!pb-smtp2.pobox.com

Christian Hesse <list@eworm.de> writes:

> From: Christian Hesse <mail@eworm.de>
>
> We had this fixed in 3307f7dde2ae8f5281d0782f7291a073c9b1cdc2,
> and it broke again in eea0e59ffbed6e33d171ace5be13cde9faa41639.

Thanks, already reported and fixed, I believe?
