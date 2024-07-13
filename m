Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4CD22318
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720885058; cv=none; b=Dipk0Je5BpWEZGq/UeC1In9Ul5OvHWfK/e2QGJooeuE9ZCipM0jb+BtNM94tNemrlxSt0ev4lL/Mn2za1VEnqKBeZ2P6e8f6HNp8U1Z+K/tN6eugSR+5O4lSc4UD1xEfJrRx4imGVP+uar1dYOwUPbUosOcvXQZvodbtjQzSBAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720885058; c=relaxed/simple;
	bh=8UML6Gs/rJnBbXDkDxKzv6b61RqXoJb6HM+NSmlgDNQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H8yE5pvvryjzrzT/zlKtQhSZ+7Micq5afizd1jb7cEXuYt75/DbcShskhux8RHECb4rPPXVHqMu9kHarMXcyZ/6TWkApIG3ugs1CO4zlJ8zvfcyZVMKLy3rUE662aEr3bDGp/HMpRbz172kAMm1eKduRf2WpKee4x4p2RbZONgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dg3HsIzt; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dg3HsIzt"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 658CF2A1F8;
	Sat, 13 Jul 2024 11:37:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8UML6Gs/rJnBbXDkDxKzv6b61RqXoJb6HM+NSm
	lgDNQ=; b=dg3HsIzt64JcEwYdsBfmaxlARsT6rmklzbv0eZ2f4o0L9QQKDQwQqg
	LZOU3vQQluHCMAasR8KCjxCcDjfe4SBofSCV+vTGAeAFcWQJcnvBMrecltP0hRnb
	itv3CqCGK1oSL+tKU8SPldwLHTcrYGKXi7nfA7mmdmVa2ZqS8eZMU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D5912A1F7;
	Sat, 13 Jul 2024 11:37:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C15922A1F6;
	Sat, 13 Jul 2024 11:37:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chriscool@tuxfamily.org,  git@vger.kernel.org,  jltobler@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 8/8] ci/style-check: add `RemoveBracesLLVM` to
 '.clang-format'
In-Reply-To: <20240713134518.773053-9-karthik.188@gmail.com> (Karthik Nayak's
	message of "Sat, 13 Jul 2024 15:45:18 +0200")
References: <20240711083043.1732288-1-karthik.188@gmail.com>
	<20240713134518.773053-1-karthik.188@gmail.com>
	<20240713134518.773053-9-karthik.188@gmail.com>
Date: Sat, 13 Jul 2024 08:37:33 -0700
Message-ID: <xmqqa5ilcngi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D36B6326-412D-11EF-BDE9-965B910A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> +# [1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#removebracesllvm
> +echo "RemoveBracesLLVM: true" >> .clang-format
> +
>  git clang-format --style file --diff --extensions c,h "$baseCommit"

Style: lose the SP between the redirection operator and its operand.

I know this is well intentioned, but will there be any downsides for
running the check always against a dirty working tree?  

I know during a CI run, the working tree will not be completely
clean, as we create and leave build artifacts, but this is as far as
I know the first instance of us munging a tracked path, changing the
working tree in a way that "git describe --dirty" would notice.

This is done as the last (and only) step of check-style job and the
ci/run-style-check.sh script may not do anything like "git describe
--dirty" right now, but things can change.  Perhaps I am worried
about this a bit too much.

I unfortunately couldn't find an option to "git clang-format" to
tell it to read from an extra file in addition to the usual
".clang-format" file---if such an option existed, we obviously could
use an untracked/ignored file to prepare the custom format file and
use it without making the working tree dirty.

So perhaps the posted change, while making us feel dirty, is the
best we could do for this step.

Thanks.


