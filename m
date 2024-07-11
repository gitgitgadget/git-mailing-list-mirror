Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389AD17C7B2
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726621; cv=none; b=ffyRIvSe6Gr6rmc2E1r3FkEHjpfRrLIQruZsA5IW7boWNu6t0Fa7TW2EMXd5wfdgpR3RtwJX4jR5jJObpo54jUBxJ0Qkh6hutxWWk0a46TVcgT+wvOu+iD3/LdaRNYf7HNUP8y6qwohFB0uwFn4Sx/Qh+VqdX8EbyRNwzC5DEis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726621; c=relaxed/simple;
	bh=V+FJk+UX5zJUG6fRwrlxiJ7TufCaEJ0a5Jbxwi7++WM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TvVenFkARNIIFrdUfv4tKGiNgSklJZijvqiJSLHagJdAV4UTMx/F+esYv4sitmysN0szXnxN/11QY7fkmvZkOB7kFNz3Zw0/WulevHIPMFWczA0JTcmKT5z6evOLzVW5WMcZJ80etS8bdmzgZxQzU9RovnlXfq34C8eR95Wmf+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jC/8uSNW; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jC/8uSNW"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1554C3F377;
	Thu, 11 Jul 2024 15:36:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=V+FJk+UX5zJUG6fRwrlxiJ7TufCaEJ0a5Jbxwi
	7++WM=; b=jC/8uSNWi85Jv27bl/bo6p7ttLlodhqvj5/tW/tmKIHyBAEqhzAOH1
	+WHdPhKPPwvLj5sZcCVSbedrgpbDNBDY8n/7KrEWWNujmdsdba/6eB08Dzz/WwzV
	nhRq0pbj/vcQTRcW3g09UPDFFa9LfcTKo46NWrKyv0VxreixjO1IM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D8E43F376;
	Thu, 11 Jul 2024 15:36:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 69AA33F375;
	Thu, 11 Jul 2024 15:36:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: Kyle Lippincott <spectral@google.com>,  git@vger.kernel.org,  "Randall
 S. Becker" <rsbecker@nexbridge.com>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] Documentation: add platform support policy
In-Reply-To: <CAJoAoZmo6ey1RAqgtM098LLLrdKODf2OYyV=YqyFH5VXiSB6RQ@mail.gmail.com>
	(Emily Shaffer's message of "Thu, 11 Jul 2024 11:37:35 -0700")
References: <20240709225042.2005233-1-emilyshaffer@google.com>
	<CAO_smVjZ7DSPdL+KYCm2mQ=q55XbEH7Vu_jLxkAa5WTcD9rq8A@mail.gmail.com>
	<CAJoAoZmo6ey1RAqgtM098LLLrdKODf2OYyV=YqyFH5VXiSB6RQ@mail.gmail.com>
Date: Thu, 11 Jul 2024 12:36:57 -0700
Message-ID: <xmqq34ofsoti.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EFFDA034-3FBC-11EF-BEEC-965B910A682E-77302942!pb-smtp2.pobox.com

Emily Shaffer <nasamuffin@google.com> writes:

> ...but this seems harder to keep track of. Where are we remembering
> these "due dates" and remembering to break them on purpose? I'm not
> sure that there's a good way to enforce this.

If you come up with a good way, let me know.  We have a few "test
balloons" in the code base and a due date that allows us to say "now
it is 18 months since this test balloon was raised, and nobody
complained, so we can safely assume that all compilers that matter
to users of this project support this language construct just fine"
would be a wonderful thing to have.
