Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDCF5C8E8
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707585481; cv=none; b=S4APrCn6fN37ikS2AJt/p8LJ0hEeqIss71/Kai1puX4QT9Glznx1+SBcA9QW7vzNwKpyRBvedmp+YIWUmC0BBV7KWDbyKKwmkCrdnALuNCWRVGpI/gMf5WoaQpxBmj0PSKWey9nQStD2eNexfe+h3BsjjSEgO82aM2cQI262Qug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707585481; c=relaxed/simple;
	bh=fuEmMz6vFlNh8TTZzwIPgIS/lV8/O5Wn0Bt+4Bh07kQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pq78/TsAEOHTEbG0NKqy6+eoUzOU1K/6W3whUsifsIpcTEvLCfNqVLtghc3f6dr1vMLk0CBfgx9WO+y8H8xjV6l/A5wp7n8I65UlFeWyhqPd6U+rHjpYLx126+Rr/6qxukhV8KFm8ZauQHHWuXpjdZtiYvl9bPhCG48EXos8xYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=T1LTj9/W; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="T1LTj9/W"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AE6F01CC9D6;
	Sat, 10 Feb 2024 12:17:58 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fuEmMz6vFlNh8TTZzwIPgIS/lV8/O5Wn0Bt+4B
	h07kQ=; b=T1LTj9/W0lAtdSvalzCTINIkYivln9PcBJ+8ZlgyEOa2EiruU7OcXv
	A86P7bytiZIyUo4Eq2+b5xtibsfTZ0VCwH8JwWWxGN1wsCwoakkc9ibAfpxuXqqg
	bzCBvdy5S3G7cOySwS3dk4sRQy16JHUY8li9H2nMOok5TKdUdM1Xc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A6FDC1CC9D5;
	Sat, 10 Feb 2024 12:17:58 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1396A1CC9D4;
	Sat, 10 Feb 2024 12:17:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: git-for-windows@googlegroups.com,  git@vger.kernel.org,
  git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.44.0-rc0
In-Reply-To: <20240210101922.3663-1-johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Sat, 10 Feb 2024 10:19:22 +0000")
References: <20240210101922.3663-1-johannes.schindelin@gmx.de>
Date: Sat, 10 Feb 2024 09:17:56 -0800
Message-ID: <xmqqsf20b5mj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 55F67124-C838-11EE-9C69-25B3960A682E-77302942!pb-smtp2.pobox.com

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Dear Git users,
>
> I hereby announce that Git for Windows 2.44.0-rc0 is available from:
>
>     https://github.com/git-for-windows/git/releases/tag/v2.44.0-rc0.windows.1
>
> Changes since Git for Windows v2.43.0 (November 20th 2023)
>
> Git for Windows will drop support for Windows 7 and for Windows 8 in
> the next versions, see the announcement of MSYS2 on which Git for
> Windows relies for components such as Bash and Perl.
>
> Please also note that the 32-bit variant of Git for Windows is
> deprecated; Its last official release is planned for 2025.
>
> New Features
>
>   * Comes with Git v2.44.0-rc0.
>   * Comes with gnupg v2.2.42.
>   * Comes with libfido2 v1.14.0.
>   * Comes with the MSYS2 runtime (Git for Windows flavor) based on
>     Cygwin v3.4.10.
>   * Comes with Perl v5.38.2.
>   * Git for Windows learned to detect and use native Windows support
>     for ANSI sequences, which allows using 24-bit colors in terminal
>     windows.
>   * Comes with Git LFS v3.4.1.
>   * The repository viewer Tig that is included in Git for Windows can
>     now be called also directly from PowerShell/CMD.
>   * Comes with OpenSSH v9.6.P1.
>   * Comes with Bash v5.2.26.
>   * Comes with GNU TLS v3.8.3.
>   * Comes with OpenSSL v3.2.1.
>   * Comes with cURL v8.6.0.
>   * Comes with GNU Privacy Guard v2.4.4.

Impressive set of updates.  Thanks.
