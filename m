Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4E5363
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 00:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710809709; cv=none; b=cpMIhxpqGNPIsIfXXrKPwkOo6reln/4hGBQf6VNsNlGUTVrPZkT2uOt6ZGtdwMEYD84UaQX85Hwz4SKHF9j6eCe4Fq1GGd9QIlYMnmjN3nUCwBsS4goMkNUw00DiUsHX19MXC8Qf64SBj5ye3RHXHTmSGsjL2U8rQmUY0Wnp0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710809709; c=relaxed/simple;
	bh=Wzc4YW+XtUEubz5CsSz2y7mR+8+U2tNwCzTcqAP3wyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fnMelpvP8KaBCyC2C1h9XIBhfkH2UOiSi018Md4mjhYZ+2Oi8B/f7aBwF8YByXeNTCXQsSbIR5EQ+hSAbpuPF2jdRkAY0gQ1ir6PJrJvC98K2zR9vnq0+C4VzTIQgplnvYr+LsW121uSmNcCv081mYRGSnahfCE8l48cpK3VuUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mm2ZXywW; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mm2ZXywW"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A8CF63201B;
	Mon, 18 Mar 2024 20:55:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Wzc4YW+XtUEubz5CsSz2y7mR+8+U2tNwCzTcqA
	P3wyg=; b=mm2ZXywW55u+4lNv/cFzlv5lJWcek1OMRnQ1eCsp7R9pLgekTtW+CG
	YHkt6PXcBId2ZgUpZ1Gt/WZgXo3phxEx/3uNNNGjvbUxoPnj1LAsDx/k/AzYJSIN
	1k19JG1u+r4MKbcnOcTDVFjJTCl0hR0EfD93CvOT6iwMUQ1Z9Xl5Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8EBA23201A;
	Mon, 18 Mar 2024 20:55:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7429E32019;
	Mon, 18 Mar 2024 20:55:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] grep docs: describe --no-index further
In-Reply-To: <3e6136028ca3327b027d57c46fb8155ef3c0d6c5.1710781235.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Mon, 18 Mar 2024 18:03:23 +0100")
References: <cover.1710781235.git.dsimic@manjaro.org>
	<3e6136028ca3327b027d57c46fb8155ef3c0d6c5.1710781235.git.dsimic@manjaro.org>
Date: Mon, 18 Mar 2024 17:55:00 -0700
Message-ID: <xmqqwmpzrqfv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5174F2F4-E58B-11EE-87EF-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> ---no-index::
> -	Search files in the current directory that is not managed by Git.
> -
>  --untracked::
>  	In addition to searching in the tracked files in the working
>  	tree, search also in untracked files.
>  
> +--no-index::
> +	Search files in the current directory that is not managed by Git.
> +	This option cannot be used together with `--cached` or `--untracked`.
> +	See also `grep.fallbackToNoIndex` in CONFIGURATION below.

Hmph, this is not the fault of this patch, but the description is
iffy.  You can run "git grep --no-index" inside a directory that is
managed by Git, and it behaves as if you gave --untracked, if I am
not mistaken.

What "--no-index" does is to pretend that there is no system called
Git and work as if it were a strange implementation of "grep -r".
The reader should be taught to understand the mode as such, because
that understanding will apply whether the current directory happens
to be part of a working tree managed by git, or not under control by
git repository anywhere.

There is no tracked or untracked or managed or anything like that,
as we are pretending that there is no git, so it falls naturally
that --cached or --untracked would not work.

And from that point of view, swapping the order of "--no-index" and
"--untracked" in this patch does make sense.  All other options that
specify which haystack to find the needle in are all about git;
"--no-index" truly is an oddball that pretends that we live in a
world without git, and as an oddball, we should move the description
out from where it does not belong.  It might also make sense to
rethink where `--recurse-submodules` sits in the list of options
while at it, as it also is an option that affects which haystack the
search for the needle is carried out.

>  --no-exclude-standard::
>  	Also search in ignored files by not honoring the `.gitignore`
>  	mechanism. Only useful with `--untracked`.
