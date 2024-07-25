Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B151BF40
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721883972; cv=none; b=fw3Exy0WJGP1749XkmbiaFGMbsmgYYdBsfyMC+7cY+hl52cgLqdCx3Qx2tCtFoxCQLHD/63RI9oHxFoVzgm2ZI0rsthvOc7RXHYeBs17kokk2fHWr+8P2jzHA+nzr4w19gsm383URqgLjtB66av62STYIuL2WmGu8kchoAs4vU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721883972; c=relaxed/simple;
	bh=+Vjd/4AZX5u7rV+7xehMl0L/vYxGJqgo8NH60Dp068o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=maOjkgkkHXPyj7DB1dw3Jt27b+i6HJpA2EpQq0R5lPYE2t2Lb2Vw+EA0+UgsbKRUsj6tRzhWZeaV/Hx4+ieqNQ1AdibNbg7Yjn5bRlQHz6Tit2Gzry6UwaIjomteO+0hLdfvT2aT0Z1XIYDnYwjI0n0PP2bUGlEwaV69SOxK4BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kiXGtNFo; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kiXGtNFo"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 25B0F23B20;
	Thu, 25 Jul 2024 01:06:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+Vjd/4AZX5u7rV+7xehMl0L/vYxGJqgo8NH60D
	p068o=; b=kiXGtNFor/oTu2QuBdKEMcI7UVrtpK5k588TTXlSybJ5ssiofK3pUP
	p8cmsvLpP0+hynjHiXQi5yuQRpP5HeVWxZDVKHMQEYo3jESTJGJ5BwWp96kVcE26
	U/ilVUm+WmIn7Frpw85GL/s+iQ44Sxglm/JF1tWhV051l+uNzwc3c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1E07D23B1F;
	Thu, 25 Jul 2024 01:06:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4F9D623B1E;
	Thu, 25 Jul 2024 01:06:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 1/3] Documentation: clarify indentation style for C
 preprocessor directives
In-Reply-To: <xmqqv80uwxn2.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	24 Jul 2024 09:41:21 -0700")
References: <cover.1721818488.git.ps@pks.im>
	<64e0b449936a6828ead98438d621f7e7684546c8.1721818488.git.ps@pks.im>
	<xmqqv80uwxn2.fsf@gitster.g>
Date: Wed, 24 Jul 2024 22:06:03 -0700
Message-ID: <xmqq1q3irrgk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 987D4FDA-4A43-11EF-AA5D-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> There has recently been some discussion around how C preprocessor
>> directives shall be indented [1]. This discussion was settled towards
>> indenting after the hash by two spaces [2]. Document it as such.
>
> It was settled to have space after and not before the hash, but I do
> not recall ever agreeing to two spaces.  I prefer to increment by 1
> for each level instead to keep the whole thing less distracting
> while carrying meaningful information.

Using the indentation consistently is a good thing I do not object
to.

Among our existing header and source files (excluding compat/ that
is full of borrowed sources), scanning output from

    $ git grep -e '#  *' '*.[ch]' ':!compat/'

tells me that

 - builtin/gc.c (3 lines)
 - git-compat-util.h (52 lines)
 - trace.c (2 lines)
 - wildmatch.c (6 lines)

use one space indent after '#' per level, while

 - hash.h (10 lines, inconsistently 2 uses 1 per level)
 - thread-utils.c (8 lines)

use two space indent after '#' per level.

In compat/ directory, only compat/nedmalloc uses 2-space indent.
There in the hierarchy are so many files we borrowed from GNU, whose
coding style sticks to one-space indent.

