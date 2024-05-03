Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140C1156C60
	for <git@vger.kernel.org>; Fri,  3 May 2024 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754960; cv=none; b=VCs+gmza76wcJREF4Ed55Q3/Tqkp66GMRB9NbhwXQ7pFXUlbLyOT/10yAV1Hqf0HFmEen2aVDaaoJ3i+tImILfDXeQhbLFj/nIGr/zeTjnOcUx0bTYJrSAUVEF+C4xi5eXHPCAvOdLsboy912FENVilxzFUDPqxSi7oeHluuaVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754960; c=relaxed/simple;
	bh=84pL+wXrLtHABPtVbBEU9ezRsrbjHwAfspgR7luTVnQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HTfEVfb3ZwIRWp6WVeAUOMS+TkW3YObUEtyXYW7wFKcNoA41qDTgLZ+GeDnGPjCxHS2drCTB9yXRUpXFxw5V9Clqbr2xnjWnFbnSYVV9jNXE0e5Y43EO00QqREZ2or4QN/oSvtimgKCTlvz+rQxSILTWusupeC3utu170C9LFTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UR2iOrNe; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UR2iOrNe"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A2DD11A57C;
	Fri,  3 May 2024 12:49:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=84pL+wXrLtHABPtVbBEU9ezRsrbjHwAfspgR7l
	uTVnQ=; b=UR2iOrNeJ5C30r2XfXbBqNQW68XdhckZDLOmtjiV2Za2QlzFaYUsvH
	C9Yi1BUXYgtDTtju12SPZ5UbXr/bA5dog/epreiPr/KgDTKAqy3d4CApVbxY+IkW
	zJAcpggUcU7CSpQUp0K+XmmmkCMVlevCOD4xPDq8k7lq+aZJWATNY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C0111A57B;
	Fri,  3 May 2024 12:49:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1ED2A1A579;
	Fri,  3 May 2024 12:49:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ci: separate whitespace check script
In-Reply-To: <awbex2f6p4sqdneevwrsba4gayidhvxrdyqjqffcn7ub5imcmm@t3wfqe5xmytv>
	(Justin Tobler's message of "Fri, 3 May 2024 10:27:20 -0500")
References: <20240430003323.6210-1-jltobler@gmail.com>
	<20240502193840.105355-1-jltobler@gmail.com>
	<20240502193840.105355-4-jltobler@gmail.com> <ZjSKqaJxd55328Fn@tanuki>
	<awbex2f6p4sqdneevwrsba4gayidhvxrdyqjqffcn7ub5imcmm@t3wfqe5xmytv>
Date: Fri, 03 May 2024 09:49:13 -0700
Message-ID: <xmqq1q6ialiu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1349457E-096D-11EF-8299-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Justin Tobler <jltobler@gmail.com> writes:

> On 24/05/03 08:56AM, Patrick Steinhardt wrote:
>> On Thu, May 02, 2024 at 02:38:37PM -0500, Justin Tobler wrote:
>> > The `check-whitespace` CI job is only available as a GitHub action. To
>> > help enable this job with other CI providers, first separate the logic
>> > performing the whitespace check into its own script. In subsequent
>> > commits, this script is further generalized allowing its reuse.
>> > 
>> > Helped-by: Patrick Steinhardt <ps@pks.im>
>> > Signed-off-by: Justin Tobler <jltobler@gmail.com>
>> > ---
>> [snip]
>> > diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
>> > new file mode 100755
>> > index 0000000000..f57d1ff5f0
>> > --- /dev/null
>> > +++ b/ci/check-whitespace.sh
>> > @@ -0,0 +1,74 @@
>> > +#!/bin/bash
>> 
>> This needs to be either "/bin/sh" or "/usr/bin/env bash".
>
> Since the script is using some shell specific features, I'll update this
> to "/usr/bin/env bash" in the next version.

This is a question to Patrick, but what makes it bad to assume
"bash" is in "/bin" when it is OK to assume that "env" is always in
"/usr/bin"?

All other comments by Patrick I found very sensible.

Thanks, both of you.
