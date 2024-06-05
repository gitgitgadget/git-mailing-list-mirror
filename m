Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EEA1459F4
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 05:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717564942; cv=none; b=YQbGBSR0DzZ/+FuqdSWiEckSHVU7lpvbkDgjlcE2CH0xpe6FZNJd6Doe7u02TBzPM+rI0TMXRogohIIcicfwGqg0b8mEJntU5DuEVPvZvgRmN9QcVlY4u8nf1u03PHelezyjSNjb8a/LC/dqo5CeKL/YdNU9nD3pJitixSuOK6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717564942; c=relaxed/simple;
	bh=GN2HHRtvLNhR6kTsq1xVVfL3+EUhT93oLSE/JdjsRW4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LU8SZ3hg1Lq+e7FRJmDQ8xoJIFKJUsa9BcSQQBRLqJ3l8FUUlp0wfI57fM3KV/BAiqk/smGTJsV9MjiOPkkmRh4RCjdW3CT1wE1tJmMIYJ65j8dGvWqB0ZY6WfUYz02Wr5hCaACBMT+1714Hirz8P6fliegVA15YbskTxzmvZBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qwIhc9T6; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qwIhc9T6"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C4E471A197;
	Wed,  5 Jun 2024 01:22:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GN2HHRtvLNhR6kTsq1xVVfL3+EUhT93oLSE/Jd
	jsRW4=; b=qwIhc9T617FGR45D92YhxCRjzGbYoWHDMcCWVL38kbF8xwuLjI4ZT8
	bEFXZpOrQY1P4fRKNiRiNCuuVscAlyCWA0RdhSc1jbF0uUuLbI5Rkw7zfJ0GpjQl
	nb2xAU7KYTYc6T+b87Z08Qa0dnJHBFe73kCMKzwSdvn5j996OUuWI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BD1481A196;
	Wed,  5 Jun 2024 01:22:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 17E9B1A195;
	Wed,  5 Jun 2024 01:22:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] Documentation/lint-manpages: bubble up errors
In-Reply-To: <b39a780d33e9ff00bc44886ed7e10904470c75e6.1717564310.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 5 Jun 2024 07:16:51 +0200")
References: <cover.1717564310.git.ps@pks.im>
	<b39a780d33e9ff00bc44886ed7e10904470c75e6.1717564310.git.ps@pks.im>
Date: Tue, 04 Jun 2024 22:22:18 -0700
Message-ID: <xmqqtti8x8tx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 943FD47A-22FB-11EF-954B-6488940A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> +echo "$findings" | sort
> + ...
> +exit $ret

All make sense.

