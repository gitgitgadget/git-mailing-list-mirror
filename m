Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B8944C81
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726861299; cv=none; b=m6niAW+zZuLNu0QepHDMRDl8kd2RGlmK2UwvhfVuyISaO3HL8Y2vVASG6SNy2VGAaInRJRpbLPIfYofCyIwpX9L9E+qVwrda/21ZB9hJzv3LJdZHLHoSU+pGsHZ4GXoYPJje9ri1hl+g/K+xMqj9gxtgkurAXZDrvEy8zyy/fq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726861299; c=relaxed/simple;
	bh=auvGelH+wnSntKtLqZ6xGVjWC+xJUrXrLos/tGvIo0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KVewT34R+xz/CH2slAyt9grGgnFGz4zW02ld7AAGXBtd4rj6yy742cSr5ndEVd6CBWOB19vZ54OKuH050wAF6yyni0jV7DZUes1mKF9PsdPyrcspArqN+QfriCLpWj7Dl/NXfRCIG4sIu52d6y397biGKBfvHrC4qnAOuq9V8pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QKm2ebUc; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QKm2ebUc"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 208961E1F7;
	Fri, 20 Sep 2024 15:41:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=auvGelH+wnSn
	tKtLqZ6xGVjWC+xJUrXrLos/tGvIo0c=; b=QKm2ebUc/8Sdu5eMH3VmPiawHKd+
	ktT6rcBggKmBc9X9cxxlpzE1vWA86kcXO3Sf5sJeBLtYz3gROzfie/24ifgbRfKW
	B53dlxnLnbId4wufwLOeLa31l863dhDktf+dfXuPTVKnouTG9U3YJ6dedCS6bHGk
	oGo24fhCtUbL0E4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 168361E1F5;
	Fri, 20 Sep 2024 15:41:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 810351E1F4;
	Fri, 20 Sep 2024 15:41:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [TOPIC 10/11] Project Tracking
In-Reply-To: <Zu2FMQnLCKQ2skkM@nand.local> (Taylor Blau's message of "Fri, 20
	Sep 2024 10:22:41 -0400")
References: <Zu2DmS30E0kKug2a@nand.local> <Zu2FMQnLCKQ2skkM@nand.local>
Date: Fri, 20 Sep 2024 12:41:34 -0700
Message-ID: <xmqqployf6z5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 5879F236-7788-11EF-9206-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Taylor Blau <me@ttaylorr.com> writes:

> * Peff: In our project, the formalism of voting is =E2=80=9Cis it merge=
d to
>   =E2=80=98master=E2=80=99 in Junio=E2=80=99s tree=E2=80=9D.

Graduation from 'next' to 'master' is mostly mechanical "spend 1
calendar week and you are done", so 'next' matters a lot more.

> * Emily: I want to have the process of getting from discussion to merge
>   be less fuzzy.
> * Peff: So in brian=E2=80=99s example, let=E2=80=99s take SHA-256. The =
process by which
>   the maintainer decides that is inherently fuzzy.
> * Emily: Sure, but I would like to be obvious to someone besides the
>   maintainer.

FWIW, this also is fuzzy for the maintainer, especially when not
many people who ought to know a lot more than the maintainer are
staying silent.

> * Jonathan: (to Peff) you mentioned sometimes you have a mild negative
>   feeling about something and you=E2=80=99re good about expressing it o=
n-list,
>   but for a lot of contributors that will cause some discomfort and it
>   will cause them to stay away from that thread. If we=E2=80=99re a lit=
tle more
>   clear about what=E2=80=99s expected, then conversations can get stall=
ed less
>   often - e.g. when a thread needs a comment from a refs expert, gettin=
g
>   that comment that supports forward progress.

Yes, either forward or backward.  Having to keep a series that looks
potentially worth doing for weeks on 'seen' without getting any
movement is *VERY* painful.  Would it motivate more experienced
contributors to review and express either support or refusal if I
more frequently, say after 20 days since its latest round got queued
on 'seen', a topic that does not seem to get enough support to be
merged to 'next' and is not getting rerolled?

> * brian: I just gave Taylor feedback on the SHA-1 series that he wrote,
>   saying that I didn=E2=80=99t love it. But others felt OK about it, so=
 we moved
>   forward.

For this particular one, I consider it is not "we moved forward", by
the way.  Please do not consider anything that is not marked with
"Will merge to 'next'?" (with or without the final '?') moving
forward.

> * Peff: it=E2=80=99s important to leave at the end of your review the w=
ay you
>   feel about something instead of just having a few comments.

Yup, that would clarify area experts' position on topics and would
help everybody a lot.  It would also help me when updating the
"What's cooking" draft, which is how the topics currently in-flight
are getting tracked.

Thanks.
