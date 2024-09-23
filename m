Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2410119D063
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109519; cv=none; b=QKSLa2BKDkU/7C9ID1NwA/v4Cu4IaVlOrjkZS6u5f8rCzjH9sH3sAp7RxdS1EZlEYHD+BigZy3jWNgWGiNYP0Gmsj2LycWBdP50sjqxFFQq3SV3chWlnu6UKzSQ7ByW5mBwTnND3GcgIgmVbxuxGMZSKftghkYpoK0aWIUHdBM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109519; c=relaxed/simple;
	bh=e5dHir9Pmgxl226i+LoTU5VN4wj3WpLTSO2uZfm5jfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RWwtppHGN457fLxzX4280wQ2eCiSg3onLhBYp0njrNK9BfsPX/NvNPRJLYVAJjg4p7Z4DQLVDOFjjrK14hhXBLYKkGPLuD7gZn++694RxSq+dyUkezlW7OsiaBytQrVHC5+1r7PvEvUuQ6/A3DF9OdVfbmFd+LJp+m/91HByO0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=s7Ycd09E; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s7Ycd09E"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CCDD721F3E;
	Mon, 23 Sep 2024 12:38:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=e5dHir9Pmgxl
	226i+LoTU5VN4wj3WpLTSO2uZfm5jfo=; b=s7Ycd09Er4yfRmNLbTOqpCs9f3gO
	o2kb0bPkpVe/FQ7P236AJhK4tV/tAo4hAFnYGM4kACf/Uqz/wZASy922BuqXZoZP
	LwsZfvdfZWcLh9XqXaEAWqT6ukDlXe+k7xUuGpd4fBmbQcevLUJH1Old46lQJUy2
	Y2qYJ7cBtglKVGc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C381221F3D;
	Mon, 23 Sep 2024 12:38:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 34F3A21F3C;
	Mon, 23 Sep 2024 12:38:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Chris Torek <chris.torek@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v4 0/3] doc: introducing synopsis para
In-Reply-To: <CAPx1GvdfE+v-wV=gbTZJi6GvwGhw8NZcZHnEwj0K+YSTfMs4Kw@mail.gmail.com>
	(Chris Torek's message of "Fri, 20 Sep 2024 23:54:28 -0700")
References: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
	<pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
	<xmqqo74rxvw0.fsf@gitster.g>
	<4ww5v253vz2g4i3z2x3dmgkrot7mcn2qm6ckjcxbyky6yvrozy@mr5hnrsfj6sn>
	<xmqq34ltbkah.fsf@gitster.g> <xmqqy13la5jb.fsf@gitster.g>
	<CAPx1GvdfE+v-wV=gbTZJi6GvwGhw8NZcZHnEwj0K+YSTfMs4Kw@mail.gmail.com>
Date: Mon, 23 Sep 2024 09:38:34 -0700
Message-ID: <xmqqh6a6496d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 4789D97A-79CA-11EF-A4BF-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Chris Torek <chris.torek@gmail.com> writes:

> On Fri, Sep 20, 2024 at 11:24=E2=80=AFPM Junio C Hamano <gitster@pobox.=
com> wrote:
>> The reason why I am curious is because https://ss64.com/mac/sed.html
>> claims that -E works.
>
> It does for me, on my Mac, which is deliberately behind current: I am
> still on Big Sur.

Thanks, Chris.

Josh, the topic has been cooking in 'next' long enough to graduate
to 'master' without anybody else complaining.  Could you
double-check and if possible see what is different in your
environment from others?

I can hold the topic in 'next' longer but not forever without
progress.  Help from macOS folks (if it is macOS specific issue)
is greatly appreciated.

Thanks.



