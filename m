Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EB6241E9
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560664; cv=none; b=kpqfh7iQFRiAaInZkvhQmFw46GhJk3nstCl6UIrzG4jRWhPXda8HsK/qk6w8xE9gE8tXNl0F4pOT1NqwliiIA/EEGXQCMANEaCpddMvDMIeUWaT+Z+gcShl0fUhrUWz8Zb107IU8MU3I3ANSI1CXs+S+XV16tzvq/0c8zJI8HWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560664; c=relaxed/simple;
	bh=SWzqZVVH2IweeCTNfEJSgwC2hyDiuGSaICRG3O1bqng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qjgfeNM6PTdczM5seZCgABRx5+sRdrGLQNQy58AMLT9oSCrDzgJsLIVTTs31w33gWDGJ4+PPjlFhM3988zTS6YOYiOG7WywW50mJ8tI2gWnMwA/Z8cU3hJUh6UhsjE4dzPv5AXNFYnZnWB1qlWwABuoCBnE/huFgceUuDxfVIao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RbcDE+0T; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RbcDE+0T"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CC25E214D8;
	Mon, 29 Jan 2024 15:37:42 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SWzqZVVH2IweeCTNfEJSgwC2hyDiuGSaICRG3O
	1bqng=; b=RbcDE+0TbUNRXoeOJcAoTlgNtMdHLmp2mMhNWbh/Piich2rp738Hho
	gwu7s+h70ZNWFlKgZ+iKK/Iw52RRCNHCFO+o/kyyNt1FZShvkyD9J6UfzAV7XllD
	un5iGSEjnCDh4f1AY20MjgmDXqw8f5h851ozLUVHOz4jnygPIcV0o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C3E68214D7;
	Mon, 29 Jan 2024 15:37:42 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 56ED0214D6;
	Mon, 29 Jan 2024 15:37:39 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 0/4] for-each-ref: print all refs on empty string
 pattern
In-Reply-To: <20240129113527.607022-1-karthik.188@gmail.com> (Karthik Nayak's
	message of "Mon, 29 Jan 2024 12:35:23 +0100")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240129113527.607022-1-karthik.188@gmail.com>
Date: Mon, 29 Jan 2024 12:37:37 -0800
Message-ID: <xmqqy1c7ho4u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3E66B902-BEE6-11EE-A6E5-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> This is the second version of my patch series to print refs
> when and empty string pattern is used with git-for-each-ref(1).

Thanks.  This is probably the third if I am counting correctly, and
the changes relative to the previous round match what I was
expecting to see.

Will queue.
