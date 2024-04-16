Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD580139CE6
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 22:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713308229; cv=none; b=m/aInDacsPV9I723m+tDZhGtPBTf8XqIOTpOVrYxybxRzMalCpc7qG3le5ZMzLiQGVeqzDK8SYbsw7oTp9K5XFQ6sl5SPhWPKJH3XiWjt9gQZH81xvY6Et362cQjmM/WS19Ra7YBQgVD6T2gClXOwduvN3bsA8xmu16zSPcjKKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713308229; c=relaxed/simple;
	bh=hxT9AG58M5/laAbOn4wsBbjUnfM38baa9B9et88erH4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R9YwC/QOgge06KHCmgdfPBkQLQBEpFIQlzV9jdidvTRvJASaoLsIcSPSq2ZPzUWGhjq7hcSsUAHYHtI9fEjLPw6ibTuZfCRC/IUzIQxL7yAYjF4PglWfYDNAc4QP49EKoGK1MgkAV5uu8KVayb3YiaOb/rW5iDfZFmMP8BjaqBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BtCdoRT2; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BtCdoRT2"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FAD71D36E5;
	Tue, 16 Apr 2024 18:57:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hxT9AG58M5/laAbOn4wsBbjUnfM38baa9B9et8
	8erH4=; b=BtCdoRT2aIDPoKzS2l4huFBUOphXqFCO1CxEG7v6HOdVwoD5jPW2X7
	2dsg12ocDJhNABU+HC48J87/6ehYi6qrpr0fOWiLcZ0/gm5c4f/av5SKr9MOP2ca
	SxTZy3eWFmo5vWwd+Ln+XeSsCBGHFypXwQL6+Ie18IiBt3J1l/MTw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D7B01D36E4;
	Tue, 16 Apr 2024 18:57:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6661E1D36E2;
	Tue, 16 Apr 2024 18:57:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jonathan Tan <jonathantanmy@google.com>,  Emily Shaffer
 <nasamuffin@google.com>,  Patrick Steinhardt <ps@pks.im>,  Matthieu Moy
 <git@matthieu-moy.fr>,  Eric Sunshine <sunshine@sunshineco.com>,  Kipras
 Melnikovas <kipras@kipras.org>
Subject: Re: [PATCH v4 2/8] SubmittingPatches: clarify 'git-contacts' location
In-Reply-To: <owly34rl53mr.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Tue, 16 Apr 2024 15:44:44 -0700")
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
	<pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
	<c43de19d867cb5e63fe6689b2b7d645dc4741950.1712878339.git.gitgitgadget@gmail.com>
	<xmqqsezqmrtd.fsf@gitster.g> <owly34rl53mr.fsf@fine.c.googlers.com>
Date: Tue, 16 Apr 2024 15:57:04 -0700
Message-ID: <xmqqjzkwdigv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A52FDEF2-FC44-11EE-BAEF-25B3960A682E-77302942!pb-smtp2.pobox.com

Linus Arver <linusa@google.com> writes:

>> In the context of _this_ document where the user is working on _git_
>> project towards submitting patches to _us_, it is far simpler to
>> drop the above paragraph and tell them how to run the script in
>> contrib/, e.g.
>>
>>     $ perl contrib/contacts/git-contacts <args>...
>>
>> without hinting there is anything platform/distro specific, and
>> instead to have them all work from our sources.
>
> Indeed. One small change is that the script already has the execute bit
> set so I can drop `perl` as $0 (the execute bit is removed when it is
> copied into /usr/share/... on my system).

We want to be a bit careful here, though.

The script begins with "#!/usr/bin/perl", but on some systems ther
eis no such command (but /usr/local/bin is on user's PATH and perl
exists there).
