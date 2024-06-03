Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8212A77109
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717413213; cv=none; b=ldu7e69nTubIc8OICyb1ft0/BfnMBZVUnSeYnwMp1P4zEt44HY0gOY+1/uz2bkY7uMh0lyKpsiHRkASBwNC97BH4eNmbsVXRr2F6Ja5Rdbb/tnOE6YSuxaplcAf8XsBP7OF1OL3/JxXpdM4E0oG7kdu30Oc7kCXZCWNsFgilI5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717413213; c=relaxed/simple;
	bh=U/41AU0U0qiWxeJKKwxxugSGj4NLCmohI7EgrtAHA/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WDmDEWnFfANmYDNCbRZQFSh/vOJGssEJEmowMxPrXLnfPLUtQSXHUyWojAVOiuC/49SoM/9pcdxU4UK78SokyIMUtGM4vblsrXstVr/qGkY5ApILUSMqgP3jY1LwzNtBVoQ6KiBX2OU931r7Ah7GTXt5izP22Ls616eeSjnTyh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PMkbVcjB; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PMkbVcjB"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4214631C23;
	Mon,  3 Jun 2024 07:13:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=U/41AU0U0qiWxeJKKwxxugSGj4NLCmohI7Egrt
	AHA/k=; b=PMkbVcjBMiABpolP4v3jCjDNV1ZwFuKre+hQfnhlOzeIWHPVMRtMXA
	GRBOIhO3w1scHcAQeBugFVTrmOY9dowedvl3fCfFx8RwEYRuND83BdgB2SOxEMR9
	r+/W1XGg/Uk8m29Bti0p26RknW+ChmSy9Assx/VnB5m+taULG0mmI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A50631C22;
	Mon,  3 Jun 2024 07:13:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 95CBC31C21;
	Mon,  3 Jun 2024 07:13:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "darcy via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  darcy <acednes@gmail.com>
Subject: Re: [PATCH v2] date: detect underflow when parsing dates with
 positive timezone offset
In-Reply-To: <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
	(darcy via GitGitGadget's message of "Sun, 02 Jun 2024 23:06:48
	+0000")
References: <pull.1726.git.git.1716801427015.gitgitgadget@gmail.com>
	<pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
Date: Mon, 03 Jun 2024 04:13:27 -0700
Message-ID: <xmqqwmn66zzc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4DD5E842-219A-11EF-8AC3-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

"darcy via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     fix: prevent date underflow when using positive timezone offset
>     
>     cc: Patrick Steinhardt ps@pks.im cc: Phillip Wood
>     phillip.wood123@gmail.com

You're expected to respond to review comments before you send in
updated patches.  I didn't see the review comments responded to in
the thread:

  https://lore.kernel.org/git/pull.1726.git.git.1716801427015.gitgitgadget@gmail.com/

Please see "A typical life cycle of a patch series" section of the
SubmittingPatches document.

  https://git.github.io/htmldocs/SubmittingPatches.html#patch-flow

Step #3 and Step #4 are distinct.
