Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC8B3A1CB
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741993; cv=none; b=mrl4GqR382Muq5HFMk9WRBrlAkZe4MIs8R9aKE4L3uXlg6WM3DJOzMwFEE6WY8TBozC0M4oGFt/M4PjOiDxuo/YDqDvDoh29wrpbQW9MuMaavez2EnIjF1PrY4+S2duU+HRah0y9ZY0GovUXPbrkVHx+kf5+y2tiT33F0feQpGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741993; c=relaxed/simple;
	bh=a0XObzPwHV4DhaDTvNEay1L02BCiekWm1bV7+mZ1Zj4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BSGB0DuVKxNxiCM93MpW6n/gsyIA0rsqOOjWgbqI1FBHeceVyUM4wZ5gviOqY+a/bCd5yzpK32lMOvx857trb0qlZzTzrZfAq/mskhFJ/mHlHbmEefWFC3GXZtjOMKJceDTstT7nJl9zjDvAlb2/1Q2R1JhXrD0kejnPqhHA8rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OFv6gn8x; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OFv6gn8x"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C4B1734B17;
	Wed, 31 Jan 2024 17:59:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=a0XObzPwHV4DhaDTvNEay1L02BCiekWm1bV7+m
	Z1Zj4=; b=OFv6gn8x0dxEZtsaN+WabfzXjQOhKp1tBhPGDYFbKNf/BX8nztEuoE
	dgXkd9vkSgKU9MQ0HAOJ3vYOidT94cbgc/6G0W9HeV8Q9RoczWI1b5Em0gt+1KuK
	CPpLyjqnYj2Nd67BFuGsxE49430yrTUfzc/xqQtx/h5VEnte54fBg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BD49534B16;
	Wed, 31 Jan 2024 17:59:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EFE3F34B15;
	Wed, 31 Jan 2024 17:59:41 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH 2/2] Makefile: simplify output of the libpath_template
In-Reply-To: <20240131174220.4160560-3-gitster@pobox.com> (Junio C. Hamano's
	message of "Wed, 31 Jan 2024 09:42:20 -0800")
References: <20240131174220.4160560-1-gitster@pobox.com>
	<20240131174220.4160560-3-gitster@pobox.com>
Date: Wed, 31 Jan 2024 14:59:40 -0800
Message-ID: <xmqqr0hx2joj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6B1B8430-C08C-11EE-95B7-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> by a directory name.  This way,
>
>     $(call libpath_tempate,$(SOMELIBDIR))

"libpath_template" obviously.
