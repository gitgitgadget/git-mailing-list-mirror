Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAA412B6C
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724431796; cv=none; b=ThIxi+WR26HaYN2LE/j/E+ABrj1zlDWo/TIE6m+R2q0ubhxTe3utMbskuEWwOv9rDexpXY5LtlryuGm5llIoNIzCoPIGAwB8dDF+egI5XQMRttzq3mlHItHgOacoCk/yl/Kpu2Z/OWJ8aeywnj2zdGq0fgMCM1zHTFGctJuYK8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724431796; c=relaxed/simple;
	bh=Q7mr16hVb/KcGif41hsffeiMVS9ka+14iv+qSxApJOE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IlTTs3DMpfOz8Ggbvx8EQw2nHmGRZiR2XD5wqK1sB38YHKzift8Sc3nfOOnvsxwtts6MtmVYqw/Gx2/wWpwZ/BHeJ4Zip/uh0TeS+DCBPsWjnt02zhE6Y4ekcRW/IgH3RMgIZNjjnKwmS5oJQ3CmQ+llwkjMZHNvcalGrNnR4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vYthnYNb; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vYthnYNb"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3B31B2453E;
	Fri, 23 Aug 2024 12:49:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Q7mr16hVb/KcGif41hsffeiMVS9ka+14iv+qSx
	ApJOE=; b=vYthnYNbqmbVatPlt4Xq9YWQJlFkR57ieS9qu6fjhuT+aL72i7LGaN
	5WRQYmCOIvWcTnV7Zztkon4vsfOVaNMdXirZMse+nChjxMK/GYZZuxDG+GSD2ynw
	Rs0rXaVWbbraMKZ7VfSdKcXhp6GkSO5pdT1XfFzadaqHoDyn7Rq5Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 34E0C2453D;
	Fri, 23 Aug 2024 12:49:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 013AC2453C;
	Fri, 23 Aug 2024 12:49:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  karthik nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/10] reftable: fix reload with active iterators
In-Reply-To: <cover.1724420744.git.ps@pks.im> (Patrick Steinhardt's message of
	"Fri, 23 Aug 2024 16:12:26 +0200")
References: <cover.1724080006.git.ps@pks.im> <cover.1724420744.git.ps@pks.im>
Date: Fri, 23 Aug 2024 09:49:42 -0700
Message-ID: <xmqqle0np4k9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B2C3B350-616F-11EF-A7F4-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Changes compared to v1:
>
>   - Remove a spurious change that renamed `init_reader()` to
>     `reader_init()`. That function went away in the subsequent commit
>     anyway.
>
>   - Fix a typo in a commit message.
>
>   - Fix some assertions in one of the added tests.

All changes relative to v1 looked sensible to me.

Will replace.
