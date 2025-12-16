Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418962F25E1
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765881735; cv=pass; b=b9BgCYt+KM68l+vM3CZcGXJXo4zp973WzKZzT4wzUR8M6WSSuEK5/rhx6VUIUwArJItLoZ3xVf24c+iu0IciY08RRHSehrdxL9piMtObbwW83nl81p0kMtXdx2Ct+hvWbns+/2dcDu3mBL6RNXkRr6lWwam3zXnON/Fnz4yj+3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765881735; c=relaxed/simple;
	bh=8de7wrEW3kRwrmWmAfvbQgv8gL0WmgF6cWE67jUNT6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DsHGiL1rBJ+JNA3AHoOTcuPa0LmZqXeCn4QIIQfeEM2xGqtYdP5On9qT4357gJkVcpkkg6HwcWGyesn1NA00CHJ02hFFc1rBk/aRwT5N2qucn/vhER519pqCzW4SF2bCPNuEyYvynqoRjQfcXNLXsHU2kxXnsSM5n8D0lE3kKJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=HRAntdnD; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="HRAntdnD"
ARC-Seal: i=1; a=rsa-sha256; t=1765881720; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BbFnGIscO9LmwPalbnhkg15QESE0qKIc0Lbd/spUCTGLL4+NGA6H3MPNzB3h3W9sFYCXp7doka6rLsA+K609xTEFEKpFh6jmiKcYnmpZyOTYlLBjqOWvveeIgB/X+wEisqclP88u1Y9HcRrT2jsQVo/knl4UGJzQ3TGJw6LqxBc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765881720; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wKkTA8VWnUHK2S9COj3qOooxPwVOe8FD65PfUyeR2hM=; 
	b=LXHZHrHtWbRL+g9cZVplKWtwovTACCV7F50F34tq1ygRkSnMsDaFMb3K+QKZzu8MZHWw76TUj/LL/uOXtMxkb0Amvv5jZFHBmlYe9MDn+0LJE2jffaUUaMdXayQkCGy6knTdAiDksRb4R8W7XTFCmlTI3OLSFe5kYEgkwypId4E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765881720;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=wKkTA8VWnUHK2S9COj3qOooxPwVOe8FD65PfUyeR2hM=;
	b=HRAntdnDn0cm0PXa/rghuqz76/IGVOsBm0vfli3+ZYHi+N+pDrayqZ6pQEg86xa9
	WSlCs7Tp0UCE/nD7JRwtNTs4Q1FfKRsD57t8EjN4GM9XJXkfrP6Q5vALSbErWqZZAtT
	P2wiDrBtfBK7EfLkQ3qXOymyC+VwgLkwqVqQBrmk=
Received: by mx.zohomail.com with SMTPS id 1765881717935205.09427854651767;
	Tue, 16 Dec 2025 02:41:57 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Josh Steadmon
 <steadmon@google.com>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
 <phillip.wood123@gmail.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: What's cooking in git.git (Dec 2025, #03)
In-Reply-To: <aUEUrXFaAfgzSs12@pks.im>
References: <xmqq4ipwc7y2.fsf@gitster.g>
 <87ldj6x1ys.fsf@gentoo.mail-host-address-is-not-set>
 <xmqq1pkv5gpv.fsf@gitster.g> <aUEUrXFaAfgzSs12@pks.im>
Date: Tue, 16 Dec 2025 12:41:52 +0200
Message-ID: <87v7i6g13j.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 16 Dec 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Tue, Dec 16, 2025 at 10:59:56AM +0900, Junio C Hamano wrote:
>> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>> 
>> > On Fri, 12 Dec 2025, Junio C Hamano <gitster@pobox.com> wrote:
>> >> * ar/run-command-hook (2025-12-04) 11 commits
>> >> ...
>> >>  Use hook API to replace ad-hoc invocation of hook scripts with the
>> >>  run_command() API.
>> >>
>> >>  Will merge to 'next'?
>> >>  source: <20251204141535.1986263-1-adrian.ratiu@collabora.com>
>> >
>> > I think this can be merged to next, since the latest iteration has been
>> > sitting for a few weeks with no more feedback and all tests are green.
>> 
>> "tests being green" tells us that with the current coverage we
>> didn't see any regression but not more than that.  Especially, it
>> does not say anything about the quality of new code (and test) and
>> if it is in good shape to build on top.  
>> 
>> It also is very hard to tell from "no more feedback" if there is no
>> room for further improvements, or people are simply disinterested in
>> the topic and are not tempted to spend their brain cycles to help
>> improve the topic.
>> 
>> If there is no more comments, I'll try to see if I can block some
>> time to read the topic over myself with a pair of fresh eyes before
>> deciding.
>
> Thanks for the ping, I've now did another pass through v4 of this patch
> series. It looked mostly good except for one question I had. Depending
> on the answer I think this should be ready to go.

I'll give Junio some more days in case he wants to take a look again at
the series, then send one last re-roll fixing your nits/question and
also addressing Junio's feedback, if there is any.

Thanks!
