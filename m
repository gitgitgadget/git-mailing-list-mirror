Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA2D18131D
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 21:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477426; cv=none; b=H5jnx96txoRfjEUbGeYK1I+y6/SOyKgjUzFCxUk2qYOUMtViXtbdqLuAq7J8OaIqpdrkYy8I/MTd3TXgJ5vrx6xQysFuQIf7kge0AhkOynfv+gVnYm3YjU1XGXXwug+raaDM59pmsk5QtgnHlLAOPCMb6jsax8Bon00PrtrjsXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477426; c=relaxed/simple;
	bh=PzsIfe/i0DrqbE2dqU4g92SbbV515Yykm8GQ9usxlFE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RE+3hHeG7KX03O8OAaIX/SvlyxABu6XPXLQobr7rbD1cZIvnvk34KMtPgCyg1aYhfO+03FlViBs7eeYW7w0G1yiQgrbGeIzQwHAOzySW9ezwv0vYrhKhflSVcFbwQcmHG7US5A3XfgDBJGJdhO3jQgy90vqRjTqxP2g7eq9NiPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TzHJisJY; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TzHJisJY"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 90D7B2BFD4;
	Thu, 18 Apr 2024 17:57:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PzsIfe/i0DrqbE2dqU4g92SbbV515Yykm8GQ9u
	sxlFE=; b=TzHJisJYJEhzrHI0shWAIwFBXGXzzgLCxHOMMpZ4bg/sQ74foq1din
	ZyXiGs3rgXSAExEcz4sSn5/60Mzbsr4BALvkdM1QQMGgAvZB5aPUgBVEACWm31gQ
	ryTatbzxBgle0WduEc7SV65JODOJaSaA6Y3Ycpaal5olJvVZCFGUo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 75D092BFD3;
	Thu, 18 Apr 2024 17:57:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D0C962BFD1;
	Thu, 18 Apr 2024 17:57:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jonathan Tan <jonathantanmy@google.com>,  Emily Shaffer
 <nasamuffin@google.com>,  Patrick Steinhardt <ps@pks.im>,  Matthieu Moy
 <git@matthieu-moy.fr>,  Eric Sunshine <sunshine@sunshineco.com>,  Kipras
 Melnikovas <kipras@kipras.org>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH v6 0/8] docs: recommend using contrib/contacts/git-contacts
In-Reply-To: <pull.1704.v6.git.1713477125.gitgitgadget@gmail.com> (Linus Arver
	via GitGitGadget's message of "Thu, 18 Apr 2024 21:51:57 +0000")
References: <pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
	<pull.1704.v6.git.1713477125.gitgitgadget@gmail.com>
Date: Thu, 18 Apr 2024 14:56:59 -0700
Message-ID: <xmqqbk66pc5w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9585F74E-FDCE-11EE-BF7F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Make git-contacts more prominent in our docs.
>
>
> Notable changes in v6
> =====================
>
>  * Prefix the command with "perl" to avoid the need to have it installed at
>    /usr/bin/perl per the shebang line in git-contacts.
>  * Drop "you must have Perl installed in your system" guidance because it's
>    a bit moot now given the explicit call to "perl".

Looking good.  Will queue.  Hopefully we can have this in the -rc,
as it is a low risk documentaiton-only change?

Thanks.
