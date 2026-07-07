Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2415420892
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 04:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783398630; cv=none; b=sIh6KmJiRaVUZ8TW/Ask3V83cnnac5Qx7AZG1CXhRxvYfelS1Tb46nJb4VZwDhHXq4nrZVpFTVc59f9mXve/jXKybSzg0yYq0kAYKAC9LJLQukkAoGNrzeHH5mf+0bQ2RAyycB0Lp1/okO4KZjJbtK8cpR4W/PxWuPXIuJbk5rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783398630; c=relaxed/simple;
	bh=JQb/zHVQaLlmHWAvFG8NCtTFYxCF4tnqozE23Ogjx9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyiQ9NRa6m7LU6q+3uWF57tXpn3qkX/0QXbdBhKKbLU2UPvDhRekd8sXNLX97sISI8MPL/MRym2mRVAGOYk4MAVrYtacvDfAqBNduDgQ9ctn/6anJoKsm60FXNuldfA0uJDqIabeob5AGc4EpEzf9xgSsUffznSwCiQDxQQmqag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZEMWS1EH; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZEMWS1EH"
Received: (qmail 17167 invoked by uid 106); 7 Jul 2026 04:30:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=JQb/zHVQaLlmHWAvFG8NCtTFYxCF4tnqozE23Ogjx9E=; b=ZEMWS1EHAsf91l9aBN2n++RGvQnmC53/GL7uelvCRiX6Zz94NPEnAcJUBcjkNh0EqEpNGi0XbledgashmwX2bxrkXg7oIq0bTb1+sd/hGqJBNT29EYBZG417bHYJZNcTYrSXzNaPxFuqk7kwXJd5LVt141hcFMEM6KDmoVPigX1bKCu4iOa58sfeeLt7xYfW6q0wewUbt3l8HMHot3R25e3edHTHIrk2EU5z5Qivad9WPTjjqUQZOBbtRWNX6Vq7h80u7jqNtC2q9S6k+kMzKicY7MaQkG8+9Mf5qe1xzz1j+uc4mZB3eZGJODBiuv+XnwvrmY09cbNG7m02xNSAuw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jul 2026 04:30:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22011 invoked by uid 111); 7 Jul 2026 04:30:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 00:30:27 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 00:30:26 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 0/9] t: fixes and improvements for GIT_TEST_LONG
Message-ID: <20260707043026.GB677056@coredump.intra.peff.net>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
 <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
 <xmqq8q7namkm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8q7namkm.fsf@gitster.g>

On Mon, Jul 06, 2026 at 01:29:45PM -0700, Junio C Hamano wrote:

> > Changes in v3:
> >   - Fix commit subjects to mention correct prerequisite.
> >   - Link to v2: https://patch.msgid.link/20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im
> 
> The interdiff looks trivially correct ;-).
> 
> Hopefully we are now ready to declare victory and plan to merge this
> to 'next'?

Yeah. I wouldn't say I did a super-deep review, but I did look over the
original and have no complaints.

-Peff
