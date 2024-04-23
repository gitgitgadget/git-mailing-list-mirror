Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1ACE57E
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 01:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713834609; cv=none; b=motCmFPe7KVofXOpHJ/lN0FkQ2D+JU8J/5rx0yE5WvbFJpAwzUL3qZxvkVUvbKUbCzQa0gh5wgDUm5yMNp6vOgIsE0E9gfVOHq4wRdaVH2l/u4Ro0C7POO72mhh7/bHk/YASObW22k7rtlPbzIlcTv8WswVRLHHcAqWqU8+qtnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713834609; c=relaxed/simple;
	bh=Bq4ZMXWYcverYhxKgUmS3OW5KyG63AuvEjuW6kdaA/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FfXtA4xKBq49D2qlVqWxRJOYHkC47IKuELM66o5Q2mmAB2R+bqW+hQJBNT2kGuIr4wwTt3wrQj741vcYTQY7CNgvRxEjE6jiByRcqc0018X6666GA+Nd+oHch8r7Z/THNPQgRNolkSqd3my5h2Myd91PX/80D72iB70K+/2hoeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=U59WoFQX; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U59WoFQX"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B6452CE17;
	Mon, 22 Apr 2024 21:10:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Bq4ZMXWYcverYhxKgUmS3OW5KyG63AuvEjuW6k
	daA/Q=; b=U59WoFQXCtPHO3aNbAP8nJVQ9zpFrS4F5StHXWmuOtSji+Vifp165s
	Fe7LF+AX2w0fOFUwA3DyWnwKyP/3H/qCvvA57tchv2Y6VYQ5u/bzv4JTyQsQQrVK
	rIvkM/dAZJyAZN/bYE0WbuNezoCxRaQFZX4FV8s7GelW5NjbMwOzo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5485F2CE16;
	Mon, 22 Apr 2024 21:10:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B05EC2CE14;
	Mon, 22 Apr 2024 21:10:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: Josh Steadmon <steadmon@google.com>,  git@vger.kernel.org,
  avarab@gmail.com,  christian.couder@gmail.com,  me@ttaylorr.com
Subject: Re: [RFC PATCH] doc: describe the project's decision-making process
In-Reply-To: <CAJoAoZmOqEd9HcHMrOUwSXNJi2a8DLeO_11gW1h_HuaK79WEVg@mail.gmail.com>
	(Emily Shaffer's message of "Mon, 22 Apr 2024 11:41:43 -0700")
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
	<CAJoAoZmOqEd9HcHMrOUwSXNJi2a8DLeO_11gW1h_HuaK79WEVg@mail.gmail.com>
Date: Mon, 22 Apr 2024 18:10:01 -0700
Message-ID: <xmqqedawsx3q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 36815E26-010E-11EF-AA18-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Emily Shaffer <nasamuffin@google.com> writes:

>> +Finalizing a Decision
>> +---------------------
>> +After a suitable period of time has passed, the maintainer will judge whether or
>> +not consensus has been reached. If so, the consensus decision will be
>> +implemented. Otherwise, discussion may continue, or the proposal may be
>> +abandoned.
>
> I think this captures the status quo. But I'm also left saying,
> "indefinitely?! how do we tell people 'thanks, but no thanks'?"

Wouldn't telling people "Thanks, but no thanks" count as a
consensus, which happens once a consensus to discard the proposal
has reached?


