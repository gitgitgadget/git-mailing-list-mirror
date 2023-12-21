Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD94187E
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 02:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cAHpomqk"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 537991BFB09;
	Wed, 20 Dec 2023 21:46:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=J7OlIxgHZA3RTpTWSn7/uPxInh/SKqhF4wNwVn
	uDQr8=; b=cAHpomqkYhv1cB8u1DKNmPGiiSAai87q8LXWUGF8pv0dL9uHcoYIQa
	++RReZS9ts32+6/B3tbPx2+EwluZX8XPjAXFjoE++UKpeqABL1cy0ppuQpD7hS+G
	uvVPTWGN6jV5bbosEJZYch8Zdhx4Y5Zv7QV7bABGDOY2dvJZ0kYfk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B7B51BFB08;
	Wed, 20 Dec 2023 21:46:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A08DD1BFB07;
	Wed, 20 Dec 2023 21:46:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH/RFC] sparse-checkout: take care of "--end-of-options" in
 set/add
In-Reply-To: <ZYN-5H-2NNoRRpf-@google.com> (Josh Steadmon's message of "Wed,
	20 Dec 2023 15:55:16 -0800")
References: <xmqqbkakqx6s.fsf@gitster.g> <ZYN-5H-2NNoRRpf-@google.com>
Date: Wed, 20 Dec 2023 18:46:51 -0800
Message-ID: <xmqqplz0p90k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 32469F98-9FAB-11EE-BF2A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> I can confirm that this fixes an issue noticed by sparse-checkout users
> at $DAYJOB. Looks good to me. Thanks!

Heh, there is another one that is not converted in the same file for
"check-rules" subcommand, so the posted patch is way incomplete, I
think.


