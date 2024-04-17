Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375847F7F0
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365278; cv=none; b=FNuzgxEGhNT2DuA+6EOplsAY5CzpGsAABulDpqPT2YUAHXNdQQ25gMHwLRCmpUg+h9UkbT3VLLwVP5JTKFOPBx1Rzwxvudzd/9VAc2kKhrUMr/O72lfg1A37nwVAvpoGUqWtzVe4AkgNlhgXZe4zuBL+1eAjNsCq5jiq+dYEn1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365278; c=relaxed/simple;
	bh=QSPkcyJ2K77XC5jTE6WkiRe+RQt/EOHXJMinMB3vqIY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RqOPNtb2Dj9i4/m/F0IosMw2I38RV5YB3Es/Q11wm7FzN0K1TwI9BPUiBntum3Xrwcpx36XzchokGQMkLk9yjxMpWEQA56WTugaJLvMNimoNkPVTk8/RZwqNuwALDM6cIEStMqOKAyRTQIIks6xDu4Hr5AzYfEwJhHg5gtqfwuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hpNvyb5b; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hpNvyb5b"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B07CC1DF1DB;
	Wed, 17 Apr 2024 10:47:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QSPkcyJ2K77XC5jTE6WkiRe+RQt/EOHXJMinMB
	3vqIY=; b=hpNvyb5br32tDgBrRLcDA+FO3eex5iaJioNvToOLbiwmOc45kw6iQt
	Qbsbl4lPJuXUgKyEoxGzEx8kTnbtTGcCagsf4v6n7bKHA0It1MaxP/h91nqOuuK4
	UMHPLNo7x+2tzISGEbI/57FanzbM6E3u/MSZHZC91QEwYu/yShODg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A88CA1DF1DA;
	Wed, 17 Apr 2024 10:47:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12A281DF1D7;
	Wed, 17 Apr 2024 10:47:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Linus Arver <linusa@google.com>,  Linus Arver via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Jonathan Tan <jonathantanmy@google.com>,
  Emily Shaffer <nasamuffin@google.com>,  Patrick Steinhardt <ps@pks.im>,
  Matthieu Moy <git@matthieu-moy.fr>,  Kipras Melnikovas
 <kipras@kipras.org>
Subject: Re: [PATCH v4 2/8] SubmittingPatches: clarify 'git-contacts' location
In-Reply-To: <CAPig+cQ=xgfExyCM2qyobv7CNRz7=J8S_=w-C-VoCNZ6M6FBbg@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 17 Apr 2024 01:48:29 -0400")
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
	<pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
	<c43de19d867cb5e63fe6689b2b7d645dc4741950.1712878339.git.gitgitgadget@gmail.com>
	<xmqqsezqmrtd.fsf@gitster.g> <owly34rl53mr.fsf@fine.c.googlers.com>
	<xmqqjzkwdigv.fsf@gitster.g> <owlyzfts52ln.fsf@fine.c.googlers.com>
	<xmqqfrvkd843.fsf@gitster.g> <xmqq8r1cczw8.fsf@gitster.g>
	<CAPig+cQ=xgfExyCM2qyobv7CNRz7=J8S_=w-C-VoCNZ6M6FBbg@mail.gmail.com>
Date: Wed, 17 Apr 2024 07:47:53 -0700
Message-ID: <xmqq4jc0cag6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 796E1740-FCC9-11EE-86C1-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>> @@ -1118,12 +1118,12 @@ valuable, such as changing the Reply-to address or adding more CC and BCC lines.
>> -codebase and run `contrib/contacts/git-contacts` (you must have Perl installed +
>> -in your system).]
>> +codebase and run `perl contrib/contacts/git-contacts` (you must have Perl +
>> +installed in your system).]
>
> I wonder if we really need to hand-hold so much to tell people that
> they must have Perl installed, especially since the command being run
> _is_ `perl`. It might be sufficient simply to say:
>
>     ... codebase and run `perl contrib/contacts/git-contacts`.]
>
> Anyhow, it's a minor point.

True.  In the original it was a good idea, but once we show the
invocation that is explicitly done with 'perl', we no longer need to
say that.

Thanks.
