Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9021056B7D
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 21:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PXRp1PSk"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B23E1D330A;
	Thu, 11 Jan 2024 16:30:57 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EGDnwTcg1lgtnrBEBCRKLteuJ1tR8rqOrMfkGJ
	VU/5o=; b=PXRp1PSkAR0BghCQn3d+46HlVOb2VRMqfQJJbansJLhB2RBw+OLhXT
	6+PPI2pEIY6h3/kjdlWSHnF1CqbjKcavHDdQiEsLYA0XW9xhVVhTttw4EMYaZ21o
	tybKN9DmfuC+GI+qu2MClLv6hNkiQVuguIDbcLrZlftcAUEo+/S7c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 11D7B1D3307;
	Thu, 11 Jan 2024 16:30:57 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D1881D3305;
	Thu, 11 Jan 2024 16:30:56 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chaitanya Tata <chaitanya.tk17@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Add support for `git rebase -no-edit`
In-Reply-To: <CADA7-FOE_81ze8hdaRGLPbipihnvFcEYfp9uwnPxPVxDepG4nA@mail.gmail.com>
	(Chaitanya Tata's message of "Thu, 11 Jan 2024 22:55:47 +0530")
References: <CADA7-FOE_81ze8hdaRGLPbipihnvFcEYfp9uwnPxPVxDepG4nA@mail.gmail.com>
Date: Thu, 11 Jan 2024 13:30:55 -0800
Message-ID: <xmqq4jfjftgw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B49478E8-B0C8-11EE-9FD7-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Chaitanya Tata <chaitanya.tk17@gmail.com> writes:

> Hi,
>
> I have a feature request to add `--no-edit` option to `git rebase`
> like we do for `git commit`.
> The workflow I typically follow is:
>
> * `git commit -a --fixup=XXX`
> * `git rebase  -i HEAD~15 --autosquash`
>
> But it requires closing the editor without any changes. I can
> workaround this using the `GIT_EDITOR` option, see [1]. But it would
> be good to have this built-in.
>
> Thoughts?

With what is in the 'master' branch, you do not have to say
interactive when you do not want to go interactive.  I.e.

    $ git rebase --autosquash HEAD~15

should work fine.  Building Git from the source should not be too
hard.

By the way, make it a habit to pass non-option argument after dashed
options.  It is easier for your readers to understand your command
line that way.

Thanks.
