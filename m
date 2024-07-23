Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06C8157493
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749956; cv=none; b=cCkWnxinBnMyOJDXnvSCPm2ZEh6qsfspCA5iXS0pOIj/93Xi6VYg8WuSGegVR77dqPFYmfw0LuVWc4NKa04bPmAKLoXzbszljmgHKZ3Z3XFd01QoSIF1CKnd632dba/7uZtFhvPxSjMRObgPGbGVpJR6chHb2P3k5pUkzkl6CbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749956; c=relaxed/simple;
	bh=1/4OLjAlEPHPZLWktGzXCCYVGzlz+iiAEdIolLhsYLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c5ixJEIo9kVnuTLl6SyT5FamPtoSxK6VQQoSMqQMZ+ucEx88ftLvts6Wx8GZwX9b/+sGDbQZzBoDMbUU8Ys0gMb+yG0xcwcJFIRAKynxISb6Jw2E3M3I4Yq4oQtZf4lRwDTpS4wcJM6bgKYV61UPajOFua+EwjqC5g2OGToGZmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xqpXpxdV; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xqpXpxdV"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 81F771C1B7;
	Tue, 23 Jul 2024 11:52:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1/4OLjAlEPHP
	ZLWktGzXCCYVGzlz+iiAEdIolLhsYLc=; b=xqpXpxdVnVvZ6vGuhnA7zRHXR6sK
	WRpxEQ7LjXLmQ49ufj+qTS2bGB1B6nXfwsNgr0zIbKZRXjhMu2cnkDgRFACj8e1W
	bxtgw5PmIKO5s11GmmopyRhf/prqm4Tuo7rr8gZejKPwyeIyPaxPxON+GaG4iI1a
	fduy+3xuBnKs100=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 79C401C1B6;
	Tue, 23 Jul 2024 11:52:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D76151C1B5;
	Tue, 23 Jul 2024 11:52:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] doc: git-clone fix discrepancy between asciidoc and
 asciidoctor
In-Reply-To: <89d00235-71db-4087-8ffb-7e93c3f470a0@free.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?Jean-No=C3=ABl?=
	Avila"'s message of "Tue, 23 Jul 2024 13:06:06 +0200")
References: <pull.1765.git.1721496853517.gitgitgadget@gmail.com>
	<xmqq8qxvhcy5.fsf@gitster.g> <8404759.T7Z3S40VBb@cayenne>
	<xmqqplr5e5yk.fsf@gitster.g>
	<89d00235-71db-4087-8ffb-7e93c3f470a0@free.fr>
Date: Tue, 23 Jul 2024 08:52:31 -0700
Message-ID: <xmqqv80w2ji8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 92D98366-490B-11EF-BBC4-BAC1940A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:

> Please hold on this patch. Cranking on your reflections about the ugly
> markup and upon advice from Dan Allen (of asciidoctor) [1], I'd like to
> push another way of managing the files, which would be to define a
> custom  'synopsis' paragraph style which would allow to process
> automatically the grammar.

Sounds good.  Anything that lets documenters write what they mean
without involving an absolute nightmare of a markup sequence is what
we want here.

But I'd like to see such a larger scale work early in the next
cycle, not close to the end of this cycle a few days before -rc2.

In the meantime, I am tempted to

 (1) apply Dscho's CSS change (but with fixes to avoid "make
     distclean" issue) and leaving git-clone as-is.  or

 (2) revert the git-clone and git-init mark-up patches (76880f05
     (doc: git-clone: apply new documentation formatting guidelines,
     2024-03-29) and (5cf7dfe9 (doc: git-init: apply new
     documentation formatting guidelines, 2024-03-29), which suffers
     from the <code> being blocks.  This will allow us not to worry
     about CSS change proposed by Dscho this close to the final.  or

 (3) do nothing.

I'd probably do (1).  Even though chances of unintended regression
might be smaller with (2), which would only affect clone and init
manual pages (as opposed to anything that uses <code> inside <pre>),
it's less work (and more work to validate the result visually, which
may be a pain).

> [1]
> https://asciidoctor.zulipchat.com/#narrow/stream/279642-users/topic/Is.=
20there.20a.20way.20to.20disable.20role.20attributes.3F

I've always felt [verse] was a bad choice (I honestly do not know
where its use came from), and I am glad to finally find somebody
agreeing ;-)


Thanks.
