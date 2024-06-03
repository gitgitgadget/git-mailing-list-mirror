Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EBE107A8
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431455; cv=none; b=hHfP+C6JCM7Dx1FF0FKrXj73n7PvY3kiUIMgQVGFRW0XFwxdGh0a1n65x+THeAY6vr7gqEu6MwZfsJwlt23q6tPG4LyEvDkzl0WlAIt07ftYqBvZBuMYY1vecjcZmUzTe53/ChxwSGOp5w2KNRW4Cptgi2iHagPEuJVADOWwns4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431455; c=relaxed/simple;
	bh=BHnCd27UgaDBY0tujQBzuE9n2SRzwkHquwL2Qn8cxyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iQ9JWOM89TQHAUtRu63RFIs+bxT7EYXpNStSalTxjFjFTge4b1kKIvKLHfmjSU90OTr3V/PmbAp2ngRHme08BYucDhmL5PrwrEdafOvUwMJUrwtUqoTzBF4mQynS++t21YaXfBNewJYyv9DyNxv5pc7xFpiOKrnMpWRBvr2lB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TN0ktKar; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TN0ktKar"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F3B8339D8;
	Mon,  3 Jun 2024 12:17:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BHnCd27UgaDBY0tujQBzuE9n2SRzwkHquwL2Qn
	8cxyU=; b=TN0ktKarRL7Crwy7dnNHHOTrZLy9L/iJ3beipZv4ylJ8NsZbOPxtcJ
	8fjByFutmOvBb+5LKenYQgxKDeUtgahmZW7TI1avyrMD+oMb84txkPsMyrluPcVd
	ZpzXNdxdjvI7+S15k37uAkfDuTOIA5qkKIF53+dbP6zjaGBMxWkLg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 55F62339D7;
	Mon,  3 Jun 2024 12:17:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA128339D5;
	Mon,  3 Jun 2024 12:17:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Phillip Wood <phillip.wood123@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Dragan Simic <dsimic@manjaro.org>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v4 1/4] docs: introduce document to announce breaking
 changes
In-Reply-To: <Zl2Np9qNcA6Z1q5U@framework> (Patrick Steinhardt's message of
	"Mon, 3 Jun 2024 11:32:23 +0200")
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
	<cover.1717141598.git.ps@pks.im>
	<993b9363484627cd828362e39f15c4905ecaf3e2.1717141598.git.ps@pks.im>
	<xmqqr0dhgc1e.fsf@gitster.g> <Zl2Np9qNcA6Z1q5U@framework>
Date: Mon, 03 Jun 2024 09:17:29 -0700
Message-ID: <xmqq34pu6lwm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C700A2F0-21C4-11EF-88AB-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I would definitely call Git 2.0 a breaking release as the changes to
> git-push(1)'s defaults were quite significant.

Git 1.6.0 was certainly a lot more controversial than the change in
Git 2.0, as the end-users never expected Git will change even with
ample pre-warning.  We originally had all the "git-foo" in $PATH
since 2005 when Git started, and we announced that we'll stop doing
so in the release notes to Git 1.5.4 with instructions on how to
adjust the scripts that use "git-foo" form.  Even then end-users
(back then they were a lot smaller population---we are talking about
Aug 2008) complained quite loudly.

[Readings]

* https://git.github.io/htmldocs/RelNotes/1.5.4.txt
* https://git.github.io/htmldocs/RelNotes/1.6.0.txt
* https://lore.kernel.org/git/7vprnzt7d5.fsf@gitster.siamese.dyndns.org/
