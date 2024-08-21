Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F084052F6F
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256105; cv=none; b=SscvzLl2alXT6Ia9C9aDI768PuqZVNAAQEOmacsOOwad5dGH58NBDpkG3GR1sOSlQrb8ty1potqNxHK0bCn8eW0xtoGHpi7C2em3xx1JspUybf/0n+QteA3pkNHedJeAb5T9VPO5uWFTvhcv8rXMeECXQTmPcd1sGmqMIcy3CUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256105; c=relaxed/simple;
	bh=XJknMd+veifjalS6agmJKVoLMh3SUWIJaeBDAXSlR2w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gHV29bjZQMuKFiwh3JSM2r/SY9MhljnSC0Nrr8KAPu7Bzri2bC33e+LbKll+9dzISl6b1Vm3BgFfnhG/Gn1ufv5qGa3fByUGX+xigkQsSes1YPQweWNmx5EjYQZ84mcwMlV+rykGCAnpiQ/2Dczs/B/H+b65tflKkSSxWiZ0Bzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hhtHDQmh; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hhtHDQmh"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA44F36B42;
	Wed, 21 Aug 2024 12:01:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XJknMd+veifjalS6agmJKVoLMh3SUWIJaeBDAX
	SlR2w=; b=hhtHDQmhP2TN0g3D04QwRb7J0dE9ZfnxQmGmEBeVxlTZCid8I7ZGNY
	Km4C8iEg+UXiGo6I8ngvLdJ6Hyop15hTrT9G5Q6V4orJLAePRn34Keg4T3PSqHmz
	eFcJm0S6x66Al7ABC+TV1hUd/XXNfsZDAXkTYkakN5XmoXAvIYWrM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E1CC236B41;
	Wed, 21 Aug 2024 12:01:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 53A0836B3F;
	Wed, 21 Aug 2024 12:01:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Yukai Chou <muzimuzhi@gmail.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [PATCH v2] doc: add --show-names for git config
In-Reply-To: <ZsWO-K4UFXsG7QNY@tanuki> (Patrick Steinhardt's message of "Wed,
	21 Aug 2024 08:53:52 +0200")
References: <CAEg0tHRL9+tqY0k2GiGzhc-VgMVsHqppLRFHbc=M33R6AoLXEg@mail.gmail.com>
	<xmqqcym4fqhp.fsf@gitster.g>
	<CAEg0tHQDT7LesB2kiQD4rXwcUs5ZhOH+YWdn990tfGdrnYdgZg@mail.gmail.com>
	<ZsWO-K4UFXsG7QNY@tanuki>
Date: Wed, 21 Aug 2024 09:01:41 -0700
Message-ID: <xmqq34mx3lwa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A855A968-5FD6-11EF-AA7C-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> +--show-names::
>> + Output also the names of config variables for `list` or `get`.
>> +
>
> This looks sensible. I'd probably drop the "also" here, which reads a
> bit awkward. Do we also want to spell out how names and values are
> separated from each other?

Sounds like a good thing to add.  Thanks.
