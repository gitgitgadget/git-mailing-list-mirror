Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD17712FB2D
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546158; cv=none; b=B0+0rS2zH7laM9IvrKhPk2CsCweZdSSSve8KcvOSK7HsA8fKUYU5U00Mcx/52xXgsEhl9VoSGhwzrenuHoZEG23mTeBB+6ObJS3d1bwu1VIyUWEEIWXr3yxbino519bRygVwIjK+tUXeRvsP1lXIB4dZwJuJpklw/WxH/ksBQ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546158; c=relaxed/simple;
	bh=Xs3PLQMmhUvDw+3ohxffmkh8rOnqqgPYGKIjJe/Vlk8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cYwEf8tHFZRSz64I/MUbkCukfzRUq/EQjMLMfPGGIEfIgarPejsjAw3Ph3g//4MEauRwt/Zehx6XBGM0LQlD0TFjBtyRPycYchoYFZep9iZG+5G72Fmz5bwGH2fGNtjALCLvNwexWEtIqA2VXGZMU2BW13jzGG3EZv7Bx37wkys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qx8sCoxw; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qx8sCoxw"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 62D171C818E;
	Wed, 27 Mar 2024 09:29:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Xs3PLQMmhUvDw+3ohxffmkh8rOnqqgPYGKIjJe
	/Vlk8=; b=qx8sCoxwSxboMADxDuSc3+nGRL+oKXy/l1jgNgf55+2+qQO/QjhqeL
	6ihWJfVuq0Jk7rAf88jU4anSDvJPmTER4fE+/+lsQMpwD2HkMjeGGGWQFExY7S/d
	nNdJ1hLJwnf+4XGa6qrtxXBsUt96kyuyr1rD0K5kOWa8H+EjhHnxI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5ACE61C818D;
	Wed, 27 Mar 2024 09:29:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BCAD91C818C;
	Wed, 27 Mar 2024 09:29:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] RFC: add MAINTAINERS file
In-Reply-To: <owly7cho1eh4.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Tue, 26 Mar 2024 21:32:55 -0700")
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com>
	<xmqqsf0gvjrg.fsf@gitster.g> <owly7cho1eh4.fsf@fine.c.googlers.com>
Date: Wed, 27 Mar 2024 06:29:13 -0700
Message-ID: <xmqq4jcr6bx2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 013BA6FC-EC3E-11EE-B941-25B3960A682E-77302942!pb-smtp2.pobox.com

Linus Arver <linusa@google.com> writes:

> I realize that such an idea is beyond the scope of a simple MAINTAINERS
> (or similar) file that's checked into the Git code repo, but I think
> it's worth stating as a thought experiment.

As we already have agreed that neither of us care the exact format
of the file (yet), regardless of how a contributor, who is about to
send a patch, will find an area "maintainer" to help the patch along
the process, it is far more important to discuss and decide what
responsibilities and authorities are expected of these maintainers.

The development community has been fairly loosely organized so far,
but I'd like to see responsibility and authority spread a bit more
widely yet still not too thinly to compromise the project integrity.

> The overall point I want to make is that we need to be
> extra-thankful to those who sign up to say "yes, I can review
> patches in areas X, Y, Z" and recognize (in a very official way)
> their generosity in contributing back to this project.

Yup.

