Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625D613D2A3
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484424; cv=none; b=koyvsciVcQR4HHgrqTMjEjrw8X8JratlvSzKcWPPHqR+qrxeSVC6k9RozrfuymOj88/oLy2SkL2vUevIsuovuFdJqwvxX1ieqBSsWpnHM6NkknAoCU6pKxenjwAiacOwPHtSAvAGLl7TOzfZXDpWNdX46FbxqAKrslH6aHNcsG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484424; c=relaxed/simple;
	bh=3HZ2fWcF0kvmrZLNZmQrNggJBzNSHQbWG1Xzxm6UNuQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IKbdXEXYyklBj3OOatwNaJ8yV1H898LRgIRdt4oFsSCAwKT/kwWQSto5tUB8Y3L5Y50BpBhT6oRiwUrTtV2NfmTvhQKKMM+yj8gTKye9u1pwggwequZ5Kp/VMEbLcnQ25ytJcnNW4EXJZhO0J8Rjz+u1KR6XHy9Nss6LghWy6bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PiXKst4W; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PiXKst4W"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BE41F2F9F8;
	Tue, 26 Mar 2024 16:20:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3HZ2fWcF0kvm
	rZLNZmQrNggJBzNSHQbWG1Xzxm6UNuQ=; b=PiXKst4WG11uNf/hcSe+zmyNkfAk
	1xP8Riac6W/+UKDkOFEbJ+7VA5lSRI7WNPkv7SZTQWBQIGPwonni0kwwltqrWtee
	Fi1OpgkEsvWa0rqPfjVSdZV7JnLP5PEtQ0/aTzYQIFk7iRs0dafVd1HBNHC6LQev
	EKIZY2H4rPebg9Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B66BA2F9F7;
	Tue, 26 Mar 2024 16:20:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C24642F9F6;
	Tue, 26 Mar 2024 16:20:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH 4/4] doc: git-clone: apply new documentation guidelines
In-Reply-To: <CAN0heSoSNxuoObvO_xtu1fXb+XYH+gBvVOWfJVBkpXouR0cmWQ@mail.gmail.com>
	("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Tue, 26 Mar 2024 21:03:25
 +0100")
References: <pull.1702.git.1711318739.gitgitgadget@gmail.com>
	<5ae83d3f799e9ab84d5233f77cb91715415ae167.1711318740.git.gitgitgadget@gmail.com>
	<CAN0heSoSNxuoObvO_xtu1fXb+XYH+gBvVOWfJVBkpXouR0cmWQ@mail.gmail.com>
Date: Tue, 26 Mar 2024 13:20:16 -0700
Message-ID: <xmqq8r24agov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 4320F5B2-EBAE-11EE-84B9-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Martin =C3=85gren <martin.agren@gmail.com> writes:

>> +`git clone` [`--template=3D`{empty}__<template-directory>__]
>> +         [`-l`] [`-s`] [`--no-hardlinks`] [`-q`] [`-n`] [`--bare`] [`=
--mirror`]
>> +         [`-o` _<name>_] [`-b` _<name>_] [`-u` _<upload-pack>_] [`--r=
eference` _<repository>_]
>> +         [`--dissociate`] [`--separate-git-dir` _<git-dir>_]
>> +         [`--depth` _<depth>_] [`--`[`no-`]`single-branch`] [`--no-ta=
gs`]
>> +         [`--recurse-submodules`[`=3D`{empty}__<pathspec>__]] [`--`[`=
no-`]`shallow-submodules`]
>> +         [`--`[`no-`]`remote-submodules`] [`--jobs` _<n>_] [`--sparse=
`] [`--`[`no-`]`reject-shallow`]
>> +         [`--filter=3D`{empty}__<filter-spec>__] [`--also-filter-subm=
odules`]] [`--`] _<repository>_
>> +         [_<directory>_]
>
> Don't ask me why, but I need this on top (whitespace-damaged)
>
> -         [`--depth` _<depth>_] [`--`[`no-`]`single-branch`] [`--no-tag=
s`]
> -         [`--recurse-submodules`[`=3D`{empty}__<pathspec>__]]
> [`--`[`no-`]`shallow-submodules`]
> -         [`--`[`no-`]`remote-submodules`] [`--jobs` _<n>_]
> [`--sparse`] [`--`[`no-`]`reject-shallow`]
> +         [`--depth` _<depth>_] [`--`[`no-`]{empty}`single-branch`]
> [`--no-tags`]
> +         [`--recurse-submodules`[`=3D`{empty}__<pathspec>__]]
> [`--`[`no-`]{empty}`shallow-submodules`]
> +         [`--`[`no-`]{empty}`remote-submodules`] [`--jobs` _<n>_]
> [`--sparse`] [`--`[`no-`]{empty}`reject-shallow`]
>
> i.e., some sprinkling of "{empty}", to keep each of these "[--[no-]"
> from simply disappearing. This is with Asciidoctor 1.5.5, which is
> admittedly starting to get old, but still ok as per our INSTALL
> document.

The original from Jean-No=C3=ABl was already bad enough with all these
{empty}, but now this is even worse.

>> ---bare::
>> +`--bare`::
>>         Make a 'bare' Git repository.  That is, instead of
>>         creating _<directory>_ and placing the administrative
>> -       files in `<directory>/.git`, make the _<directory>_
>> +       files in _<directory>_`/.git`, make the _<directory>_
>
> This should be __<directory>__{empty}`/.git`

The worst part is that I am not sure if there is a pattern easily
understandable by document writers to help them decide where to
sprinkle these {empty} mark-ups.  Of course, they are visually very
distracting and made our documentation that used to be perfectly
readable in the source form to something much less pleasant to read.

Can we make both the rendered output nicer while keeping the source
still readable and easy to maintain?

Thanks.
