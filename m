Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67C1DA39
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t5MaOXq7"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E41101
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 12:01:21 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B15733F813;
	Mon, 23 Oct 2023 15:01:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Z05RM9zHJWEtMAE3HJTrsgbG+vhrjkwDZX1L7I
	EG0Po=; b=t5MaOXq73irgXRz4PklI1xteZod7W7jMAOu4h1RhWTeGYugTlEHqE2
	Gx1RZFTYjn+jhBv81xjbg7VV6OeG/sx54xhxmOYKm50YE6igTmtA1VvcTeKL6Cgr
	oAZBa8nJ754iMJ2iGo8n7Z9FIPB0GZFo9zencquZ1p/x2DcCnE5BU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 93E8E3F812;
	Mon, 23 Oct 2023 15:01:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9143A3F811;
	Mon, 23 Oct 2023 15:01:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: Dragan Simic <dsimic@manjaro.org>,  Oswald Buddenhagen
 <oswald.buddenhagen@gmx.de>,  git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
In-Reply-To: <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io> (Jacob Stopak's message
	of "Mon, 23 Oct 2023 10:30:54 -0700")
References: <20231020183947.463882-1-jacob@initialcommit.io>
	<fd26df85661d554ced9d8e0445f75952@manjaro.org>
	<ZTL1wJIIK/5YWQK5.jacob@initialcommit.io>
	<d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
	<ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
	<5fac8607a3c270e06fd610551d7403c7@manjaro.org> <ZTT5uI5Hm1+n0Agx@ugly>
	<58a6a25a7b2eb82c21d9b87143033cef@manjaro.org> <ZTZQZhtTxvGT/s81@ugly>
	<bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
	<ZTatzlzCkPOW3Rn7.jacob@initialcommit.io>
Date: Mon, 23 Oct 2023 12:01:14 -0700
Message-ID: <xmqqfs21noxx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8B1FAA0E-71D6-11EE-A4FA-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jacob Stopak <jacob@initialcommit.io> writes:

> Git-Sim is a visual dry-run tool for Git that creates images simulating
> what the corresponding Git command will do, without actually making any
> change to the underlying repo state. Another important aspect is that
> command syntax mimics Git's exactly - so to simulate any Git command, like:

Ah, OK, now I see where your "--table" is coming from ;-).
"git-sim" was exactly what I thought about when I saw it, and I did
not know that "--table" came from the same set of brain cells.

One thing that nobody seems to have raised that disturbs me is that
even though there may be educational value in having such a
"feature", having to carry the extra code to implement in Git incurs
extra cost.  I was reasonably happy when I saw that "git-sim" was
done as a totally separate entity exactly for this reason.

THanks.
