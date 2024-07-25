Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CCF19D89E
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921571; cv=none; b=XkjKx73u8v7uCYcd3vyn5tfCNrzl42smTaDsky/h/jFUS+JdUfVLngnRbnzrhzUFDVIiTplayhLSo45RSrpI/AGkvnMvHvCtHoR5FWd5xLYNS1lxFwBrMJC3tZUKF8M3EgZQer2f9EUQaREQ/D6PczrMA09ATKlV4CmeeEMy4qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921571; c=relaxed/simple;
	bh=V5poWj6EMVwyOZTsFLy8tVgh1YCx/rII/1qTSRKjYLY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pv3BXcAWt1GObIfflE3ut9j0VX4RjICSJxKFiFl55DVbeRuE7B29PgyG83XeHLyG6FIrzqEhLtPgl8B7e2VlVV6q7HmK4D1pHZEOGtSuiBba5BcW3cJtNxdJIH8+Oca8n2eoGgazTX1hEDsHpN+JQI27Kf6SSznV56yg8WkzvEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Cr5QAOh5; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cr5QAOh5"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5B882499E;
	Thu, 25 Jul 2024 11:32:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=V5poWj6EMVwy
	OZTsFLy8tVgh1YCx/rII/1qTSRKjYLY=; b=Cr5QAOh50K47EExudojzdKAfHbJk
	Yn1hLyOwS6XeA7AOHINF8krPjcxib/49UTkT6Sk/3yx82E0oWeWqE8cyqr0kixjS
	CxNpUz7BE7u/NzyTWNGKwLTd2kuou6NcfTmDBAnagUJV4+4Roh3lxcBJPXa0iECk
	/ZGbTv5penULF/w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ACED02499D;
	Thu, 25 Jul 2024 11:32:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 268752499B;
	Thu, 25 Jul 2024 11:32:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] doc: introducing synopsis para
In-Reply-To: <13562033.uLZWGnKmhe@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Thu, 25 Jul 2024 14:15:30 +0200")
References: <pull.1766.git.1721774680.gitgitgadget@gmail.com>
	<pull.1766.v2.git.1721855179.gitgitgadget@gmail.com>
	<xmqqcyn2s7ob.fsf@gitster.g> <13562033.uLZWGnKmhe@cayenne>
Date: Thu, 25 Jul 2024 08:32:46 -0700
Message-ID: <xmqqy15pjxlt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 258634EE-4A9B-11EF-8E23-34EEED2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> The form=20
>
>     git cmd  [--foo] [--bar] < <input-file>
>
> is completely acceptable , would render correctly and would remove the =
use of=20
> the pipe.

Nice.  I was afraid that it might be interpreted as a placeholder
whose description is "<input-file" ;-)

> The thing is that this pipe isn't even part of the command. It is=20
> just an example. Maybe it should not appear in the synopsis at all.

Historically the command was designed to read from "git log" as its
upstream and nothing else, which was where that sample command in
the synopsis originated, but it is unusual to spell out the upstream
(or downstream for that matter) of a pipe even when the command is
often used inside a pipeline in the synopsis section.

> For keyword signs that are already used in expressing the grammar, we c=
ould=20
> quote the sign to indicate that it is a keyword : "(" .
