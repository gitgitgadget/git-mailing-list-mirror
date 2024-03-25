Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2444C83
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 19:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393319; cv=none; b=GmgAVG5LBAV0ohmPwWHq7K2oJnXCYAUCahvIoAEbhCHWODG+2dqfZcUgz1WwIbzPEOyzbyYWwfm0wblF4nMpbYfkGgAVZ56BI3KD0AF6rYH+3dt7ESekF0RV6Xb+pvaUldTc5uSAX9DU7SpaaffbCsJpUQQDUmyM8Fb/8c4ewEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393319; c=relaxed/simple;
	bh=6SrtTQZMQl6pX8SqTHBcu3r/9AuyLMdpiWfAk8mhtq4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=enhZAWtsUIHR+zS3AU+r1OCtvL3xBpd5YgIDa+cjZZo33RUUJj3LK6zDcR+zRCgpZgrJ5tHmku9apmsA3mR0grL9pD/Yy0j9bvdRT5CQWqPGLNo0nBHqMzfYwF/EY48z+9T9AvO2QFsYawfqnsacqG51pMh+o/pg/V4dphy4pCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nYpMrIon; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nYpMrIon"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 423D330305;
	Mon, 25 Mar 2024 15:01:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6SrtTQZMQl6p
	X8SqTHBcu3r/9AuyLMdpiWfAk8mhtq4=; b=nYpMrIonGX5zeyXIsY9SFZwCTRZd
	cHqcU/f34JgNc1tVrH4O35TC14dqOg43Bp8A7hf/pAOXMN38KL+AhW4IrceJ0qC/
	8LzEy831d6hmdiQJwVjzi+iXw37B1d5oeNbwTNz+AeV5XA7Bwxd7hhBQDXdBhl9y
	InYnj4x5ALT2Skk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A1BC30304;
	Mon, 25 Mar 2024 15:01:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 06EE430303;
	Mon, 25 Mar 2024 15:01:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Torek <chris.torek@gmail.com>
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,  Philippe Blain via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] t/README: mention test files are make targets
In-Reply-To: <CAPx1GvcPEeC3HTdb4bUYASz-t=a7Z2MEUamB4QyO44y4MRy6Pw@mail.gmail.com>
	(Chris Torek's message of "Mon, 25 Mar 2024 02:59:15 -0700")
References: <pull.1701.git.1711293246094.gitgitgadget@gmail.com>
	<xmqq4jcvtxtz.fsf@gitster.g>
	<97212b72-70d6-e55f-8b2a-04ede4321288@gmail.com>
	<xmqqfrwfp0hh.fsf@gitster.g>
	<CAPx1GvcPEeC3HTdb4bUYASz-t=a7Z2MEUamB4QyO44y4MRy6Pw@mail.gmail.com>
Date: Mon, 25 Mar 2024 12:01:44 -0700
Message-ID: <xmqqsf0ejftz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 20487468-EADA-11EE-A670-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Chris Torek <chris.torek@gmail.com> writes:

> On Mon, Mar 25, 2024 at 2:49=E2=80=AFAM Junio C Hamano <gitster@pobox.c=
om> wrote:
>> As long as we do not use these $(T) files as an input to some other
>> thing and list them as the dependencies, we are OK, though.
>
> You could (maybe later / at need) stop listing them as `.PHONY` and
> instead use:
>
>     $(T)::
>         sh -c ./$@
>
> or similar, so that some $(T) *can* be an input. Note that this require=
s
> using double-colon rules earlier to build the test.
>
> I wouldn't do this without a pretty strong reason though.

Me neither.

I personally think a target that is marked as .PHONY and does not
use double-colon rule is a bug by itself but that is a separate
story.

In any case, just to avoid leaving the thread hanging, I'll take the
patch as is, as it documents a useful trick in the status quo.

Thanks, all.
