Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07751DA21
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 05:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709012142; cv=none; b=qDqC3YUfmES/4dVnP3GTQ6/EDDf8RO444EBW2nA6SVDR16pGYonBOFMscH00IHLHH+DNLZBs8rRCkBCNjW56s9vg2fVGsouKBPm63JbdpB+BQ5dPB8lP/Msg89/Wh2XUgEFFfbndNtYazP5aK1VAwzyGpTLhWEJjGgV3mLGuBEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709012142; c=relaxed/simple;
	bh=Q6gX3wSb9mOiv+v/4iySKaYTp4hv+1N4rk5Nb/ipB7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nae01kKJx1t3jpEsPeFNF36FAjukcNVt4aX8HdESCcpneGNSu/G5iOEvrv9DglEF27+CGnzyQwr3Uc+sgESPPVZFXnsqszGFUmui7s+TcoE/ELEOP+c9gB+eNPFTzbq2pYKGAOU91QwNNzNMksi/yLK6bBcJOtsG3wSQf+L8LnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=f+qqmVaX; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f+qqmVaX"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 33CB02187A;
	Tue, 27 Feb 2024 00:35:40 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Q6gX3wSb9mOiv+v/4iySKaYTp4hv+1N4rk5Nb/
	ipB7c=; b=f+qqmVaXQl2VJseNx1N9+aC6uubyx+MHKFjl7UASRwSHxrsDWhvess
	8Pv5HEribBQ9Iti6S0vZi98nYn09AdMqSawcBjA4HR61uiAtUI3yufNlcjXCwytw
	Qv5sDA6Yq/mAyiOhLQYVFGJX+fR3Cn8mzvfO+P3VcxhFdtB9vwQjI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2BC1321879;
	Tue, 27 Feb 2024 00:35:40 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CB0A721878;
	Tue, 27 Feb 2024 00:35:36 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org,  Kyle Lippincott <spectral@google.com>,  Calvin Wan
 <calvinwan@google.com>,  Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3] doc: clarify the wording on <git-compat-util.h>
 requirement
In-Reply-To: <CABPp-BHbuvLSSr2186XqiHFQD=NUYess5zdwG4bqY6FzQfG8oA@mail.gmail.com>
	(Elijah Newren's message of "Mon, 26 Feb 2024 20:25:19 -0800")
References: <xmqq4jdxmx2e.fsf@gitster.g> <xmqqh6hxlcae.fsf@gitster.g>
	<xmqqle76kdpr.fsf_-_@gitster.g>
	<CABPp-BHbuvLSSr2186XqiHFQD=NUYess5zdwG4bqY6FzQfG8oA@mail.gmail.com>
Date: Mon, 26 Feb 2024 21:35:35 -0800
Message-ID: <xmqqv86ah3ko.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 08D783F4-D532-11EE-B051-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Elijah Newren <newren@gmail.com> writes:

> I like this latest version.

Thanks.
