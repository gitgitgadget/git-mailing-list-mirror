Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA71541867
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QMXIred4"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E4971BAFAC;
	Wed, 20 Dec 2023 11:51:42 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jp455/+RJ0n5
	/EYjC8lH7LU2pl8Z0ebsMvRpGm6dm48=; b=QMXIred4RAUIZTujBfy25ga94Ycy
	+erSNi4zbc6JuFfL5HmvJPJXOqPHQ3/WesDNNf3uuRZMcjX+DDlsvGLJM2JH2C2V
	Z9+FEErixdNBTAQg6eN0WrpWd/F/2EJ0L5tRvKoU3sSO6kaoNUhv75qweQVa30Dl
	RAN+XFy8J6uqlac=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F27161BAFA9;
	Wed, 20 Dec 2023 11:51:41 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 616811BAFA8;
	Wed, 20 Dec 2023 11:51:41 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Michael Lohmann <mial.lohmann@gmail.com>,  git@vger.kernel.org,  Michael
 Lohmann <mi.al.lohmann@gmail.com>
Subject: Re: [PATCH] Documentation/git-merge.txt: fix reference to synopsys
In-Reply-To: <c6814a39-b4f9-4b1e-b81b-45ffe4aa7466@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Wed, 20 Dec 2023 16:43:16 +0100")
References: <20231220070528.8049-1-mi.al.lohmann@gmail.com>
	<c6814a39-b4f9-4b1e-b81b-45ffe4aa7466@web.de>
Date: Wed, 20 Dec 2023 08:51:40 -0800
Message-ID: <xmqq4jgcu89v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 0CB425E6-9F58-11EE-9C69-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> +It is possible that a merge failure will prevent this process from be=
ing
>> +completely automatic. "`git merge --continue`" and "`git merge --abor=
t`"
>               ^^^^^^^^^
>               automatically
>
>> +can only be run after the merge has resulted in conflicts.
>
> The connection between these two sentences feels weak to me.  Are "merg=
e
> failure" and "conflicts" the same?  Perhaps something like this:
>
>    A merge stops if there's a conflict that cannot be resolved
>    automatically.  At that point you can run `git merge --abort` or
>    `git merge --continue`.

Just being nitpicky and curious, but does the abort/continue also
apply when you run "git merge --no-commit"?

I do not do documentation all that much these days, but when I was
involved heavily in discussions on documentation patches, I often
said "'git merge' gives back control to the user" to refer to both
cases, either because it couldn't complete the work it was asked to
do, or because it was asked to stop before completing the work.

> The only guidance I found is this paragraph from CodingGuidelines:
>
>    Literal examples (e.g. use of command-line options, command names,
>    branch names, URLs, pathnames (files and directories), configuration=
 and
>    environment variables) must be typeset in monospace (i.e. wrapped wi=
th
>    backticks)
>
> So shouldn't we wrap all commands in backticks and nothing more?
> Probably worth a separate patch.

Thanks for a good review.
