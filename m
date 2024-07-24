Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9449E79F0
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834954; cv=none; b=njuMkQT85u4SMqzOGKXMhEvbmuEjQ3fuUKDZE5jOuO0J6Yk8U0JX84IG14sJHynCMP8JUnUuLUFO8JgDiMmeVWrMLWtTUXp/ICiJ7maE4gEalL4y/buQ4XNrtclBkHIdPtNN11Sv2NonGNbhaylg2tOUJZG3Sx3U9mHiytGBuC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834954; c=relaxed/simple;
	bh=EVhtY8gGYhM6hSEOR9L8tQ5px5gVtvFkyfVhE05LmQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jl4SxWM3qGhJjWOnHDExSf3Lp1O/cMeMK7+485cdvAwV/82PmFMEbt0upPsqeCjCpFUWgShwnfKOX8IPAuMYUXS+xcfcTs562yR312d6anT4+SE7uF9AflwHAru6Ij22RxZKFNVmaNjxrYAiiJq/+iXnHZSH+12CjPpqS6cHq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=x+tkBOpp; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x+tkBOpp"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 63777188B2;
	Wed, 24 Jul 2024 11:29:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EVhtY8gGYhM6hSEOR9L8tQ5px5gVtvFkyfVhE0
	5LmQk=; b=x+tkBOppAlP2IR7D+5gpoU+i+Im3H6XI3tuDoR2Js2/S1wn1ZbHBaa
	bepg8iovlb0iFHdHPbUFbfvrenVmKsHIGeQ9aLqeieiIIID7y3sLMzeALKs8JVzy
	EX4+pVwKOm4rka11y5pTfZW7VsAtNouLbpO9SrJhwNl/1Q8n9au80=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A1E6188B1;
	Wed, 24 Jul 2024 11:29:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB1D8188AE;
	Wed, 24 Jul 2024 11:29:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: avih <avihpit@yahoo.com>
Cc: Avi Halachmi via GitGitGadget <gitgitgadget@gmail.com>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [PATCH 0/8] git-prompt: support more shells
In-Reply-To: <992128710.1986532.1721788902932@mail.yahoo.com> (avih's message
	of "Wed, 24 Jul 2024 02:41:42 +0000 (UTC)")
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
	<ZqAzpYuTrK6L-uyN@tapette.crustytoothpaste.net>
	<992128710.1986532.1721788902932@mail.yahoo.com>
Date: Wed, 24 Jul 2024 08:29:09 -0700
Message-ID: <xmqq7cdazu4a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 79933C1E-49D1-11EF-A6FC-34EEED2EC81B-77302942!pb-smtp1.pobox.com

avih <avihpit@yahoo.com> writes:

>  On Wednesday, July 24, 2024 at 01:50:16 AM GMT+3, brian m. carlson <sandals@crustytoothpaste.net> wrote:
>
>> We explicitly allow `local` in our coding guidelines.
>
> Yeah. I missed the guidelines initially, but I got to the same
> conclusion with git-prompt.sh - to allow only "local" exception.

It is a bit more nuanced than that, though.  Here is what we say:

 - Even though "local" is not part of POSIX, we make heavy use of it
   in our test suite.  We do not use it in scripted Porcelains, and
   hopefully nobody starts using "local" before all shells that matter
   support it (notably, ksh from AT&T Research does not support it yet).

For the purpose of git-prompt, I think it should be OK (without
"local", it is harder, if not impossible, to clobber end-user's
shell variable namespace with various temporaries we need to use
during prompt computation) to declare that we now support shells
other than bash and zsh as long as they are reasonably POSIX and
support "local" that is dynamic.

> That's nice. I did try to check whether it's planned, and request if
> it wasn't, but I didn't find the future plans (but also didn't try
> too hard). Though I think they're still doing bug fixes for the
> forseeable future, which is also great. Looking forward to it.

Do we know what kind of "local" is ksh93 adding?  The same as their
"typeset" that is not dynamic?  That is so different from what others
do and scripts expect to be all that useful, I am afraid.

