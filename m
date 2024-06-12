Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAC754BD8
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 20:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718222956; cv=none; b=TJf+qDJBzx1XDAXP2VG6IRk5ljDCn4uDBfV99jZWV/2D/A4955ZDqmTN5gurGG8u/xNI9nwdmAusYi16PmCSWc2N1flJSQIJsuNMsBZ1KMkQqRzjtiHa9Yf6Li3rXzRFVMCnc4KVT8bRGiZzAEu/NE4ZZDGp2wgmxplsOSesX+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718222956; c=relaxed/simple;
	bh=WYZf/yqSwD604bkx1w2asZZriYXwwznFM0tpLasNGd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pwgh0bFy+dbfsa6sCpEnAaZaDyQ4yfN+mcNOeanFBoW6U3cSNcZ6IbNGyiKhoXpwg1cxIci08gzG4oNsdaMSGsABo06U/4L4QFRcjOLczZnyflCS6614EZ54EByUth7tMwvBmPVHTOk4xEzMqczNsW72RNogzlA1Hm36M3bqX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=p5XdCUi2; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p5XdCUi2"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0634E2FAA0;
	Wed, 12 Jun 2024 16:09:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WYZf/yqSwD604bkx1w2asZZriYXwwznFM0tpLa
	sNGd0=; b=p5XdCUi2UUC7NSvrnyyOqTtH4vG5eg3/g5/yQI2v5ZfrqcGU8oSlY6
	pUnJcT9lnQHhwIrsWq1tFUpxEHOM+Gj4G67jHiyDRX/KRjyhuweGgf647hjnTaeT
	ovPIpCscRCymsxHY6EOSrH1KafQSVa4VIEUjoj51X1BKHmLWBkoRs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F29212FA9F;
	Wed, 12 Jun 2024 16:09:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 63FE62FA9E;
	Wed, 12 Jun 2024 16:09:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org
Subject: Re: [RFH] t9500 failing???
In-Reply-To: <CAO_smVh2yZRfs2vq2RKY=eLj8-0BgPierxksq376u=X-=pbKWA@mail.gmail.com>
	(Kyle Lippincott's message of "Wed, 12 Jun 2024 11:38:30 -0700")
References: <xmqqr0d2p1x3.fsf@gitster.g>
	<CAO_smVh2yZRfs2vq2RKY=eLj8-0BgPierxksq376u=X-=pbKWA@mail.gmail.com>
Date: Wed, 12 Jun 2024 13:09:02 -0700
Message-ID: <xmqq5xudq5y9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9DFA98E0-28F7-11EF-9C8C-C38742FD603B-77302942!pb-smtp20.pobox.com

Kyle Lippincott <spectral@google.com> writes:

> So my conclusion is that 4.62 is broken, and that newer versions are unbroken.

Thanks for digging.
