Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D419D36C
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 01:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726882859; cv=none; b=Xk0cOB4zh6KblHKj00ygI6Rgc2gbpd6aaFwqDcslXZkBUZUcdrqClTFNiVJNWkiZ0A1nOVtpvfaOAz8ojTdb10D7FmHevUYHOG2n57w5A/eu3V1/EFzsikFxok7FLtIA8wxnRb3Mc/HhI1Z661GQc7b9Wxuz3vHxbUJ9qE5iJYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726882859; c=relaxed/simple;
	bh=fscIFvIDH/tZw2Mtf5WnkwDMNXmBeupOA9b0iAB7VV8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GQ15MfMShjjB4c+nETpkL+LLY0ZZPNe77EdHFwaTUGV7p7WEcuvrL8yUGJ4iV4PBEpqBlCh/rw/YwNIpnPXScUvRLls4/6amqM2qOTCBbSZwWd/eu83c0EBbDMaoOMh0+yn9V3r2LyPSp9r+0K0ovhvWFjwk59OHjLHFPRHIkmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=v1jmTPPE; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v1jmTPPE"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B34951CF61;
	Fri, 20 Sep 2024 21:40:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fscIFvIDH/tZw2Mtf5WnkwDMNXmBeupOA9b0iA
	B7VV8=; b=v1jmTPPEKb8Nct+Vz0PklJeSG6mMd0X5yx9yJmfwJashI5FM+0lryT
	ak3ICw+yhbpT3KV6l/qE3KA8OTYOwD7uujuvFTcJciUDsRcfPnNO8+zxaO7/xy5D
	XoPJZCFWvCJulbcVWFnsfhEq0UQCCCQiq+gb93KF4fVvKOzGh4zlY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC0331CF60;
	Fri, 20 Sep 2024 21:40:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25ACA1CF5F;
	Fri, 20 Sep 2024 21:40:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Josh Steadmon <steadmon@google.com>, =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: What's cooking in git.git (Sep 2024, #08; Fri, 20)
In-Reply-To: <xmqqed5ddexk.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	20 Sep 2024 17:32:39 -0700")
References: <xmqqed5ddexk.fsf@gitster.g>
Date: Fri, 20 Sep 2024 18:40:55 -0700
Message-ID: <xmqq7cb5bx7c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8B9D1BD4-77BA-11EF-A00F-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> * ja/doc-synopsis-markup (2024-09-05) 3 commits
>   (merged to 'next' on 2024-09-16 at d471154a0b)
>  + doc: apply synopsis simplification on git-clone and git-init
>  + doc: update the guidelines to reflect the current formatting rules
>  + doc: introduce a synopsis typesetting
>
>  The way AsciiDoc is used for SYNOPSIS part of the manual pages has
>  been revamped.  The sources, at least for the simple cases, got
>  vastly pleasant to work with.
>
>  Will merge to 'master'.
>  source: <pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>

Will have to be held until it gets updated for its use of "sed -E"
that does not work on macOS (and presumably other userland derived
from BSD).

Thanks, Josh, for reporting.
