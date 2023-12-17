Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777C445BF2
	for <git@vger.kernel.org>; Sun, 17 Dec 2023 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OMXZGvOO"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C746B1CFBA6;
	Sun, 17 Dec 2023 12:15:50 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FXGV8HdkJ4crD3lpNzcnkxEegG3Jh4h4C4/r3X
	+bQT8=; b=OMXZGvOOzkMvXD/eQAR5X8wHDsaegErEAYaw24yFU+BzcPhu7RGEXR
	Pdp5HBpxHlDARzC/YO0HnnEZCThitrqdvvXkXfhNGD41/xRjC/mz2aWovT0a1VVb
	EcxMOSPKiu4wxRqADxqUq8r3bBHArSM+QBMA7EYuLamQqcWWKgzDI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B06FA1CFBA4;
	Sun, 17 Dec 2023 12:15:50 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0B3DD1CFBA3;
	Sun, 17 Dec 2023 12:15:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?ROaXoOaVsA==?= <wushuripple@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: End-of-line comments are prompted with "is not a valid
 attribute name"
In-Reply-To: <xmqqsf45nbzm.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	13 Dec 2023 11:22:53 -0800")
References: <CAOQ=bxz8txyOt6p5L0qfx5DFKfxUhWvHW0pJP+YTbWVfBpvYxg@mail.gmail.com>
	<xmqqsf45nbzm.fsf@gitster.g>
Date: Sun, 17 Dec 2023 09:15:48 -0800
Message-ID: <xmqqo7eoiwcb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 ECED570A-9CFF-11EE-B8F0-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> This is totally expected; nothing to see here.

To put it another way, we do not have "end-of-line comment"
(i.e. the leading part of a line has payload, but the line is
chomped in the middle with a comment character and the remainder of
the line is ignored) at all.  We have "commented line" (in other
words, a line that is totally commented out and gets ignored).

I think it is very clearly documented in "git help attributes":

    A `gitattributes` file is a simple text file that gives
    `attributes` to pathnames.

    Each line in `gitattributes` file is of form:

            pattern attr1 attr2 ...

    That is, a pattern followed by an attributes list,
    separated by whitespaces. Leading and trailing whitespaces are
    ignored. Lines that begin with '#' are ignored. Patterns
    that begin with a double quote are quoted in C style.

