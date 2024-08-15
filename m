Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECE31B3F26
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739232; cv=none; b=EA+89MoJXLjBdcelKyFxWUH+fs58+iAJ+BXVrcMC59CnQeKyIe9rUveqnBYx4ExL4Pjgma31+h8XwRimz+5gtQM6wDgE6++TfwwyvqvwgfI7gpW+APjYk7yjq+47YigtX+tDD15vDO03VPHj9lZan+2KNre64r22YPYuM/Jisz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739232; c=relaxed/simple;
	bh=WkeOrOY/XDv9YN7kFv7sp4eAiTNub69mvfWDwzVl1TI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cSffZhEVWOptc5V4zuoICfDB03ijaLbslsE3Cpic2F8bo3mX9RrNc1wgPi/c+5pd4Q834juDYEKjw6fWKg7owM/nTjrhyMe3ANZeXUSLiMb0j4shbAZvwSkTSUq1CvImUdaHDNVmcS2fwozxQtfETOmv1YcZo8lXUhtFFC/CSDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pUJVU9sM; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pUJVU9sM"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B33F23290;
	Thu, 15 Aug 2024 12:27:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WkeOrOY/XDv9YN7kFv7sp4eAiTNub69mvfWDwz
	Vl1TI=; b=pUJVU9sMsXCIrXUHQzvgRhM/aR/Hlue7cAPwjWk1Hx7WbwOXGnDlwo
	8OxSThTbiH7KHS4+OM9x+MHLtREqP0qUhmGI31zTQtpevpnoQdj0w5mBwKAqZL9Q
	kSBlupgvt0EYXGDYoOu7wSDYR4v1hPduYoUvd6U3cenRuKY6G5baI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 33F9B2328F;
	Thu, 15 Aug 2024 12:27:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D79A2328E;
	Thu, 15 Aug 2024 12:27:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Avi Halachmi <avihpit@yahoo.com>
Subject: Re: [PATCH v2 4/8] git-prompt: replace [[...]] with standard code
In-Reply-To: <232340902a1feeafe526528eb88b8d0814d11545.1723727653.git.gitgitgadget@gmail.com>
	(Avi Halachmi via GitGitGadget's message of "Thu, 15 Aug 2024 13:14:09
	+0000")
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
	<pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
	<232340902a1feeafe526528eb88b8d0814d11545.1723727653.git.gitgitgadget@gmail.com>
Date: Thu, 15 Aug 2024 09:27:08 -0700
Message-ID: <xmqqsev5u4yr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 38328E6A-5B23-11EF-81CC-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: "Avi Halachmi (:avih)" <avihpit@yahoo.com>
>
> The existing [[...]] tests were either already valid as standard [...]
> tests, or only required minimal retouch:

FWIW, our local coding guidelines to spell these with "test"
(without closing "]"), but this change certainly is a good first
step to get rid of non-portable "[[ ... ]]" construct.

Thanks.
