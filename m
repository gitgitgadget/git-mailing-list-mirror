Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08649E555
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 02:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712370530; cv=none; b=oMQPlSj7ugbTUzQr5mo+FUYIpeEVK6qmHWTLj99HituO/24/uELsq1ejaaLYNjuk7KIsvm6nbvwHTtZW5DAQzSLlzx9oXzT/6/NwO/f61xrRf9nOJ37o/vu1xWrIT+qCP6ZZANF0OaUYBpn/ZyURpNiUol9k6zXz+hAT2zzLMHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712370530; c=relaxed/simple;
	bh=KR7xkM3mQDvJNszc7uEVRhMjtE5XhIeFqNpOPXSsFpc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qK+p7ssmK6iyQtK/Fs9WuY+GRRl6RrbR0XqF6XTkjlNGf1g8wtxIhdeQ8obCxorGrkmrpoQo1WcVKtimz/xhyK5Pqem6h/RZeapyqh+XxT8QE0yC528BZXoKypRJrxqspgHUhAnKJYBGmzVahovKQHeyB7KslY92XOkWw2PGJao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=V7S979rT; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V7S979rT"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BA5CB1F3574;
	Fri,  5 Apr 2024 22:28:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KR7xkM3mQDvJNszc7uEVRhMjtE5XhIeFqNpOPX
	SsFpc=; b=V7S979rTwiiEVetFmobeB/zHvqbTzvWeBqBLpyUcrZNHt8GcOPz2uP
	ZVns9lb2ws/tXDmE0ZLbiSE0Qg24zXmjo+wAz7wq2qIagRdcoXJnDcHHCqsO9wWk
	Sm/kXNxLP6b81RHZfN43j5BQj3HrCRiLtEWhTESK8YNOWn3lIxZwQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B232E1F3573;
	Fri,  5 Apr 2024 22:28:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E8D01F3572;
	Fri,  5 Apr 2024 22:28:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jonathan Tan <jonathantanmy@google.com>,  Emily Shaffer
 <nasamuffin@google.com>,  Patrick Steinhardt <ps@pks.im>,  Matthieu Moy
 <git@matthieu-moy.fr>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH v2 0/8] docs: recommend using contrib/contacts/git-contacts
In-Reply-To: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com> (Linus Arver
	via GitGitGadget's message of "Sat, 06 Apr 2024 01:22:08 +0000")
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
	<pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
Date: Fri, 05 Apr 2024 19:28:45 -0700
Message-ID: <xmqqttkfp6le.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6572D268-F3BD-11EE-8B0A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Make git-contacts more prominent in our docs.

Thanks.  Overall all patches look improvements.  I left some
comments on a few patches, though.
