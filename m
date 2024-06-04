Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A5D5F860
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524093; cv=none; b=o9XdptQ0dqjAnyBtay331HTPTsUEA4TwVKSzL9ZR8QnbZWQpDhZhKjZ6vALAs5orrIt2vQNeeBhJMUJoIYp1aRqG9faEUCxcBEwtm0n6OsULiDxr5FcGD/uIsn3DExrL8s7EqLLab4JWY3ddKqlyb4Iqlq6p6VM59pITdp0rn5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524093; c=relaxed/simple;
	bh=biLT3W6izCwYKK5oDj1zxoys6KVl0ToA7wFMrjYPT2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fK5YbBprX0BG2ofkylUlOABTsObzH7fSbuWjBYlnUfLcWkwu8hJvmfifsmrRJzhdGuiRjEyK6Iq5bCXk4dNjomZ0d7B8z8+8xVv2DS+pxXStS5Fn4eLWeWb3R2EWPFM41EISXzUD/5EPm6ZX3s7DR0JP/EyqIH+mRsf/I0Xtcfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=x/Te8Bh1; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x/Te8Bh1"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A65991CCD7;
	Tue,  4 Jun 2024 14:01:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=biLT3W6izCwYKK5oDj1zxoys6KVl0ToA7wFMrj
	YPT2s=; b=x/Te8Bh1Tp+1zZCnr00McbphJPe68klI9s8xWAPvyHYdnehUfRR6nX
	qrYxp35BhhCpqa7dHGtSmcODz0shnK8MtrOwyWbWXAOdckP/ZVvXZgzNfrQpYlOT
	ergFD56grAHndLy9bqdbjCeeSykDPYYKFEa9fYzFVRhxvjZ5yw4m8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E3D11CCD4;
	Tue,  4 Jun 2024 14:01:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AB8751CCD2;
	Tue,  4 Jun 2024 14:01:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Justin Tobler
 <jltobler@gmail.com>,  Dragan Simic <dsimic@manjaro.org>,  Karthik Nayak
 <karthik.188@gmail.com>,  Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v6 0/4] docs: document upcoming breaking changes
In-Reply-To: <f231d5ff-08e5-47b3-aadc-0f88566c2588@gmail.com> (Phillip Wood's
	message of "Tue, 4 Jun 2024 15:23:09 +0100")
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
	<cover.1717504292.git.ps@pks.im>
	<f231d5ff-08e5-47b3-aadc-0f88566c2588@gmail.com>
Date: Tue, 04 Jun 2024 11:01:21 -0700
Message-ID: <xmqqjzj4vb7y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 73F13B32-229C-11EF-B014-8F8B087618E4-77302942!pb-smtp21.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Patrick
>
> On 04/06/2024 13:32, Patrick Steinhardt wrote:
>> Hi,
>> another day, another version of this patch series that aims to give
>> a
>> framework for documenting upcoming breaking changes in Git.
>> Changes compared to v5:
>>    - Note that Git 1.6 was a breaking release, despite the fact that
>> its
>>      major version wasn't bumped.
>>    - Several smallish rewordings.
>>    - Note that items on the lists should only be discussed anew when
>>      circumstances have changed.
>>    - Add some conditions to the move to "sha256". Also, note that we
>> do
>>      not plan to deprecate "sha1".
>>    - Note that replacement refs are also superior over grafts
>> because
>>      they can be carried across repos.
>
> This version looks good to me
>
> Thanks for writing this document

Yup, aside from two typos and a misstatement I did not spot anything
that need correction.  Will queue.

Thanks.
