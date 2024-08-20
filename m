Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F86B18E37E
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 20:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724186295; cv=none; b=F22A9FhJrmsPlYJERm+Z5BBuL/OGPn5iSCIYa0u4xh36YXXn8NIDbCrr/i1ZKeIp2d+GlCNC7cHW8XALkFK4u1CHo3eCL7dhNOqnOeRHk429B7gMAAGY9h5WxAHKpGo6UN2ZwRNooYErgFLzrcgo7sgNANFjslSziz+v5ALlWh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724186295; c=relaxed/simple;
	bh=gn3oX1/Bwn6JLuoEWhjh1zVf5oGKASYC3en593v8yv0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fATSV/sGnKaWPvz6IuB5rSvWUp5UZcELw7P9TuQbQqtOAFnHy002FW7omMDNnFHvgHRkmtVw09CTaDmmJUTZvgcA55x2b73Bhem3z2+k2qjUPc4KEY6M4l90ReFtFOx4PgevDGhT4lbEuph4fWpPkwcVJ30r1eOObwFHkI7afpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=V8p+p23L; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V8p+p23L"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5ADD01A8D4;
	Tue, 20 Aug 2024 16:38:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gn3oX1/Bwn6JLuoEWhjh1zVf5oGKASYC3en593
	v8yv0=; b=V8p+p23L3nnJzPGGQZTZMYK5/fsBuMMjg6uA3Z3Nec0w9S8HeKZ4AG
	ma/rRoi2OchFwKcwZZxdq37+xdQtJ7dfiMM1g7kE9CEh+czNe4hTO+vURwgF6LAh
	N+aln/IRrNZVeLTLNpf69bpbUhNWnQDZaNiGO4UQCWI6055Q0vois=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 535591A8D3;
	Tue, 20 Aug 2024 16:38:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BFB1A1A8D0;
	Tue, 20 Aug 2024 16:38:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 0/2] Update the win+VS build definition
In-Reply-To: <ab765f95-1208-fa77-01a7-2dd4f5eea90d@gmx.de> (Johannes
	Schindelin's message of "Tue, 20 Aug 2024 22:15:43 +0200 (CEST)")
References: <pull.1775.git.1724164270.gitgitgadget@gmail.com>
	<xmqqv7zvb4mu.fsf@gitster.g>
	<ab765f95-1208-fa77-01a7-2dd4f5eea90d@gmx.de>
Date: Tue, 20 Aug 2024 13:38:11 -0700
Message-ID: <xmqq34mz6ibw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1E980812-5F34-11EF-99AE-9B0F950A682E-77302942!pb-smtp2.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Do you mind if I applied these directly to 'maint' and merged the
>> result upwards?
>
> I concur that this is a good idea.

Will, do.  Thanks.
