Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4E21C2BD
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721061377; cv=none; b=i2DkqehiGCMSkIb2II7SV8H+u/OMj31+U4sXR35mCCTDlH6FSPGmdqIT3hqgiw2NI92fmtXX3Mlz8lWp0hOQXPgnklhvOGmMWOUuz9TMuwJNr413k59OagkuCjbuWmgh1fpmXj+P8/TZ+jTS6eut9S7oCe+OXNByvOCHfc5xcis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721061377; c=relaxed/simple;
	bh=bMdRZ2Aajc5TTT3hTastBcCZegdXznKlNiU7CUXx6v0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H/jKIJgBbA6CMw2gokCLaZnXMOA6EhykjNlV3hiInz83aK+qEcg8hRUR63RxzRtFISI1YxP6bpdRw7U14FGg0WcU9nwb3Foi68esF+T+Y0UjXHLrfM6wL4AP2ACt7Uc1fqRPgy2lAAjbwpdaguZIoOWQK/Gmd9/zFrlOyPXwosg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=r+tJH0Ih; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="r+tJH0Ih"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AC7CF1FE4C;
	Mon, 15 Jul 2024 12:36:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bMdRZ2Aajc5TTT3hTastBcCZegdXznKlNiU7CU
	Xx6v0=; b=r+tJH0IhzzJiie4OXj4W1aneUEVq0rJf+0lA+skOVYgYl7vXD9vzhn
	FzA/WpVjoVRHzkY/CrpzicYMEWud1xbWX1+PMawUBHI7EeA+Yh7l4KMlsX51PcKr
	XV7EseT+Acn6OFYwqHumoywPFO7vlAIenyvoqYcyG8npVvhngdI3A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A2CEA1FE4B;
	Mon, 15 Jul 2024 12:36:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CFE8E1FE4A;
	Mon, 15 Jul 2024 12:36:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  chriscool@tuxfamily.org,
  git@vger.kernel.org,  jltobler@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 8/8] ci/style-check: add `RemoveBracesLLVM` to
 '.clang-format'
In-Reply-To: <CAOLa=ZTjHKX3EMbVu1_bjdDez=3aODZQYY4npKrCY-7ZRXN1hQ@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 15 Jul 2024 12:07:43 -0400")
References: <20240711083043.1732288-1-karthik.188@gmail.com>
	<20240713134518.773053-1-karthik.188@gmail.com>
	<20240713134518.773053-9-karthik.188@gmail.com>
	<xmqqa5ilcngi.fsf@gitster.g>
	<CAOLa=ZTkYs_Wz2YM82Nm0yPJX8-hYV3WC-aMEqYNRoS+2ZpG3A@mail.gmail.com>
	<cccf899d-12c4-4046-a958-33374bb870c6@ramsayjones.plus.com>
	<CAOLa=ZQfhD21Anzd3wWwWcxji7tJydaiD7mrhReH5zLQdXBWng@mail.gmail.com>
	<xmqq7cdm90h7.fsf@gitster.g>
	<CAOLa=ZTjHKX3EMbVu1_bjdDez=3aODZQYY4npKrCY-7ZRXN1hQ@mail.gmail.com>
Date: Mon, 15 Jul 2024 09:36:12 -0700
Message-ID: <xmqqle224npf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 59C4145E-42C8-11EF-806D-965B910A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Ah right. Let me summarise:
> - Method 1: Inject the extra config to '.clang-format' in the CI's job.
> This is the current method.
> - Method 2: Create '.clang-format-ci' to use in the CI
>   - Method 2.a: The new file contains '.clang-format' + CI specific
>   rules.
>   - Method 2.b: The new file simply contains the new rules and we inject
>   the rest in the CI's job.
>
> I'd say methods '1' and '2.b' are similar, since they modify the tree on
> the CI. So no real benefit of one over the other, no?

Sorry, but I am not sure what you are trying to say, especially with
2.a and 2.b, your assumption on "the new file".  Is it tracked?

Try running "git describe --dirty" and see if the command can tell
the difference.  If you smudge .clang-format, which is a tracked
file, it will be noticed.

But you can use a temporary file and use --style=file:/... to point
at it.  The temporary file can be an untracked and ignored file,
just like any *.o files we would create during a build.  Then "git
describe --dirty" would not complain that you are making the working
tree dirty.

The temporary file does not even have to be inside our working tree.
If we know we can write into /tmp/clang-format-rules file, then the
CI script can do something like

	{
		cat .clang-format
		echo echo "RemoveBracesLLVM: true"
	} >/tmp/clang-format-rules
	git clang-format --style=file:/tmp/clang-format-rules \
		 --diff --extensions c,h "$baseCommit"

right?  Then "git status" would even say "there is no untracked
cruft" (although I do not know we *need* to keep the working tree
that clean, without untracked cruft).
