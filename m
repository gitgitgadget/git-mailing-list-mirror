Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B822594
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 00:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789752; cv=none; b=cC9emfEAPFbY/zJDie1iPIEcdk1vRKv5qe3E3rMdlIjJyEMacAlVE09pYb3z03oe1w+eiSYmAOYaU+oDzUCbT3A7NwHKYDEv+Z/AaDT5yLaZ0HRmayTTBWZgKJnF3BtZkuFu0MgKgexb2dOHPnBZEGbeSWBxyZ6zOX5OC2KLRUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789752; c=relaxed/simple;
	bh=4wzD+nM2KvUFwX4dY49cBcJuuf5Mga7OvKt0GC18urI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R0IE0wlDwZZ8eXHxgVSeqVbIil1N+h8zMe8r3+NDwz2sf/R35MvzKfSyemB9Gz+Lg4BR/zn/SXpPzTBIHb5XtOdSsCJcJbmTByzUi00YZclWbvY/FVEK2aVXrC+4mo0qEWWzN8O8WR+9eEW6idsLw8hb4WFKRCo1R+VEH6JRvCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5WosH/rz; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5WosH/rz"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F2051383937;
	Mon,  9 Dec 2024 19:15:49 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 09 Dec 2024 19:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733789749; x=1733876149; bh=4wzD+nM2KvUFwX4dY49cBcJuuf5Mga7OvKt
	0GC18urI=; b=5WosH/rzYighpwSVpEfdQzWnGtR6UPcj5tm/OfcG1bCPQ+IzEg+
	siCkNPiD53F8rneHauJUJxD2iGORM+Bl8Hc45PvXpUcn0ZMDOEDOsO9nzL69Rtza
	vsr4aXVjZbKManlg1s4a4CWNqLntuSNAQt5KDhWKJvQ6tLWVEj6dEcVv1hvcQyWM
	XF7NjU635V4252kiplPKx3dAcDCDCbA07m7NUVLEk4cbuEeuGxFKBVWLWA3Qokrc
	+aWz7mtfnptZJMbIeoNwr8xC1nY62Hf+/kS4T/LQX6JZbn8PTYn2i7nBvHcprzdA
	URtgTkF4VDzJnzv1UnfDk8lZJR39ZKvIm9A==
X-ME-Sender: <xms:NIhXZ0S2Sw4QYfD7s8GKOTKAK6j1n0dQK1Z4YyxcbCMn2nsg9lWMUg>
    <xme:NIhXZxzPo2LN8Tc46HXN_4E-LWojwVNHUuHpiPvDpHXKRT8vR_Z9BhzsFE0lzYurj
    2YqvinjoDIm25lq4Q>
X-ME-Received: <xmr:NIhXZx2vAllvRffY0IAKIc0Hzgzatk6LFZKT5q7XxTi6hZ6o-_sZk8N1BXkvzt6z6dGWlgB18EV_QVkl3-NmgOudZG0e9rTBnhjqduU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeejgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedv
    udegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NIhXZ4AJGCn87nCqsSP5Rw35nq8YzieLw83sUNQjOYFa3EwYAHtINQ>
    <xmx:NIhXZ9jPCBZHjmDFozd5Z8--sjmoku67ORaK-oYMrNXKNR3FNQkkYQ>
    <xmx:NIhXZ0org7irN9k9xDZhkrZQxDMt1rleaahO58Z7PZauZyXQ3uG6jQ>
    <xmx:NIhXZwh8k-8f99FO7dm7GnBjBsO67FGJ32U5LguFjuNJcN-2ehbPXg>
    <xmx:NYhXZ9eDJbb5RFUGYPK1FCbpa-JuXndzj3xPNpqEY1Gwt-PfUFoiKf1g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 19:15:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org
Subject: Re: [PATCH] bundle: remove unneeded code
In-Reply-To: <CAOLa=ZQpBf-ZE8BmXRUXJ247p44Enj0vrJv2KHVDXtGzY6SU8w@mail.gmail.com>
	(karthik nayak's message of "Mon, 9 Dec 2024 13:09:20 +0000")
References: <20241209-fix-bundle-create-race-v1-1-e6513bdcbf8a@iotcl.com>
	<CAOLa=ZQpBf-ZE8BmXRUXJ247p44Enj0vrJv2KHVDXtGzY6SU8w@mail.gmail.com>
Date: Tue, 10 Dec 2024 09:15:46 +0900
Message-ID: <xmqqfrmwmlzh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

karthik nayak <karthik.188@gmail.com> writes:

>> The workaround was originally added to deal with tags, but the code path
>> also gets hit by non-tag refs, causing this race condition. Because it's
>> no longer needed, remove it and fix the possible race condition.
>
> Nice, simple fix.
>
> [snip]
> ...
> Shouldn't we add a test for an annotated tag and verify that the tag
> object is also included in the bundle?

I agree that it is a good idea, especially because 895c5ba3c1
(revision: do not peel tags used in range notation, 2013-09-19)
naturally does not come with a test for "git bundle".

Thanks.
