Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678B112B82
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708815271; cv=none; b=B9cXAvSIU0QBIOZ0DZ8FmX9Mve0yxaxvMlNrrHWP90vI9Hy79QNk/EsOm+L7UT5rG1Ufov08KwIZqHi2qZuch0JNwvtfXCsrLY3Hu1KQjywNwxkNbA/LEIzvUzC4gEdNEm+ywENO+9QofBvb/WAdE9w6g2FdekgVnDpTKzXdH1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708815271; c=relaxed/simple;
	bh=1dY/XV0RQrV76cfrTpLL3MvUeqWl831SSrf3FHb1/LA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wd7MvpgGSAxT43GLoHbU8iUA1vMzy31jkDEY87aTQNo66pvBLKj+UuB3fmFW7UYheRZzO16ZNOL3SW2k7Bc1UQ9sxv+70ivZPzBdCr2YlaAuc4v2IIQmUne87SylmKUmc6RvR4EI5h7ZOzGnm4sHyeZqB8KFe2GMrY+F4kePBzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rqS58ZfS; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rqS58ZfS"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 57A101E9C8A;
	Sat, 24 Feb 2024 17:54:28 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1dY/XV0RQrV76cfrTpLL3MvUeqWl831SSrf3FH
	b1/LA=; b=rqS58ZfS7RcxD02pTtflXgEidw2ba6c3McU1SauECSTJW6K1a4ltQT
	BHZmiL0NInmZYPuNRIPUToDFoBMPSeGZeEicGPZY/bTCARpafLJY0KsfnDyjpm1c
	U4bq7HM+13PkLFZPd1u2P+dvOqphonhBe4sIBXIlj9Kvg5Ag4KCPg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E0751E9C89;
	Sat, 24 Feb 2024 17:54:28 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7B5C71E9C88;
	Sat, 24 Feb 2024 17:54:27 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org,  Calvin Wan <calvinwan@google.com>,  Jonathan Tan
 <jonathantanmy@google.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] doc: clarify the wording on <git-compat-util.h>
 requirement
In-Reply-To: <CAO_smVg4E4bENU18tiv8xnscnk46i=GW=Kq+xKvO1Nf7qCGy_A@mail.gmail.com>
	(Kyle Lippincott's message of "Sat, 24 Feb 2024 14:38:09 -0800")
References: <xmqq4jdxmx2e.fsf@gitster.g>
	<CAO_smVg4E4bENU18tiv8xnscnk46i=GW=Kq+xKvO1Nf7qCGy_A@mail.gmail.com>
Date: Sat, 24 Feb 2024 14:54:26 -0800
Message-ID: <xmqq7citlbh9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A9941EDC-D367-11EE-8F7B-25B3960A682E-77302942!pb-smtp2.pobox.com

Kyle Lippincott <spectral@google.com> writes:

> This "In addition" ties to the "are allowed to" 19 lines below, which
> was confusing for me until I intentionally ignored the "In addition",
> continued reading, and finally caught the other piece of it. Perhaps
> either `Exceptions:`, or something like `The following cases are
> allowed to assume that their header file includes "git-compat-util.h",
> and they do not have to include "git-compat-util.h" themselves:` -- I
> have a slight preference for the latter form, but I worry that the
> "These headers must be the first header file to be "#include"d in
> them" bit will be missed.

I'd appreciate people to help figuring out what the preamble should
read like to make it easier to follow.

> ... I don't know
> if we need the reasoning why you'd #include these files in the bullets
> below, which is why I didn't include it here. I'm assuming there's a
> concern about implying that builtin/foo.c should include builtin.h
> instead of git-compat-util.h (even if foo.c doesn't use cmd_foo()?).

It is more about helping folks new to the codebase understand the
reasoning behind the convention.  As whoever implements "git foo" as
a built-in command is supposed to

 - declare cmd_foo() in builtin.h
 - add builtin/foo.c, define cmd_foo() there, and include builtin.h
 - add "foo" and "cmd_foo" to git.c:commands[].

it is natural to expect any and all builtin/foo.c to include
builtin.h (hence it makes it convenient to allow an exception by
including compat-util in builtin.h to give everybody in builtin/
indirect access to compat-util).

But those who are not yet familar with the structure of the system
may not understand why it is natural.  So, addition of "why is this
header allowed to be a substitute for which source files?  Because
these source files are supposed to be including that header anyway"
is an important part of this patch.

Thanks.
