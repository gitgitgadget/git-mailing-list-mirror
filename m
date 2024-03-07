Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DF782D9C
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813551; cv=none; b=XXvb9ns6CvHv/DPT2WpVtMuOnJ+/ec6HWuGceGXgjK+vq3b+uOQFlC8SY/E8uaE1QOGvRQgsOYRnXCZl3jROd/eobB3MkJ4YHDsdevMvAUuCg8RbKruIAHWHYAFzaNQi4pSbRZSgJbPL/HrDclAyXD+aXN6abxIBLsLOat3egt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813551; c=relaxed/simple;
	bh=8QZazedIRS0fsoEhoYRRFLdoQf/m9gG0z0Jfx1SBFOY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k7BqcKgM+vhbELRA9PS0SdNqCqn7/0yDlnCj6ZeVuqmy52O16r4CLnVe4Kz6MlnBkZOvHabUJciGwS7L66tHNYDyeZOi4cxf5y6wDXKstBSUMMqIE8yiov+bdKTBLHsf6Uv4fzNh8rIPNNhV39iQacaHrLME7Top5rYfqQR+Iq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FnW7GhGH; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FnW7GhGH"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 161971E15B2;
	Thu,  7 Mar 2024 07:12:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8QZazedIRS0fsoEhoYRRFLdoQf/m9gG0z0Jfx1
	SBFOY=; b=FnW7GhGH8YIQLtDE3iOgQ9hNrttJlAN+cpWpk3ahSwebNN96FUew3I
	Kdy4fcrcFHGODk+sEtitwjlfW0xMh1smrlMDwIZaL7eS+sXs/qk167z9YB0By7Uh
	JE9iYuA0A7fT/VpVqBqW6a3Et7Pkx+P6hTq7LYdbbhlwSB7EdB6IY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DB481E15B1;
	Thu,  7 Mar 2024 07:12:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 67F9F1E15B0;
	Thu,  7 Mar 2024 07:12:21 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ralph Seichter <github@seichter.de>
Cc: Ralph Seichter via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] Allow git-config to append a comment
In-Reply-To: <2560952c-4495-4a71-9497-aa40032e1d2b@seichter.de> (Ralph
	Seichter's message of "Wed, 6 Mar 2024 18:24:56 +0100")
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
	<xmqqttljtkn4.fsf@gitster.g>
	<2560952c-4495-4a71-9497-aa40032e1d2b@seichter.de>
Date: Thu, 07 Mar 2024 04:12:20 -0800
Message-ID: <xmqqplw6nsuz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F334D30C-DC7B-11EE-9D87-25B3960A682E-77302942!pb-smtp2.pobox.com

Ralph Seichter <github@seichter.de> writes:

>> If you are illustrating a sample input, please also explain what
>> output it produces. What do the resulting lines in the config file
>> look like after you run this command?
>
> The result of running the above command looks as follows:
>
>   [safe]
> 	directory = /home/alice/somerepo.git #I changed this. --A. Script

That would have been a crucial piece of information to have in the
proposed log message, as limiting ourselves to a comment that is
tucked after the same line as the value, things can become somewhat
simplified.  We may not have to worry about deletion, even though the
point about "we need to look at and typofix them with our viewers
and editors" still stands.

By the way, you may or may not have noticed it, but my example
deliberately had a multi-line comment:

    $ git config --global --comment 'the reason why I added ~alice/
    is because ...' --add safe.directory /home/alice/somerepo.git

How such a thing is handled also needs to be discussed in the
proposed log message, and perhaps in the documentation as well.

> ... My patch only supports
> single-line comments, and only as a suffix to newly added key-value
> pairs. This is a deliberate design choice.

Such design choices need to be described in the proposed log message
to help future developers who will be updating this feature, once it
gets in.

Thanks for writing quite a lot to answer _my_ questions, but these
questions are samples of things that future developers would wonder
and ask about when they want to fix bugs in, enhance, or otherwise
modify the implementation of this "add comment" feature.  They may
even be working on adding other features to complement the "add
comment" feature, by designing support for viewing or typofixing
existing comments.  When they do so, it would help them to know how
this existing feature was expected to be used and how it would fit
in a larger picture (which may not have yet existed back when the
feature was invented).  Answering these anticipated questions is one
of the greatest things that a commit log message can do to help
them.

Thanks.


