Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E5B4595D
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720303270; cv=none; b=QrVnjyZxkPO0rnbiPMC7DVMGrJ0dKoE+pWNRLe5n0fjDYaq4mehspIVP7v5xlme0cDmU4hQYh0ZcKo2yhI/vTmRpJu/en7MExV6pcdnt+ut5tYscOVsQkq+3UMNaGQTFjMKvVkEiCDQld3HIr6wEe8bG0XspSYdr3HubKAFhMRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720303270; c=relaxed/simple;
	bh=NLF3lPrFkvHyd3oTOW8nF6KdoA4YYzMOXK8X2xM8ryo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iwxWliMyti13wRyBuecFRQts1FoEPzQKE/MZauKBAtDs17pq64xCfaBZBvziZZAF9MsdBiFIdJSvMIYwR8MTgjZ2Gwlx2FvBaYCET1Gyv5g6kPjI9uFlt2og2hCNJ+x5ApaPkKmFPbv9jTYq2C8g4meXlI2CyxHlkkLQ8wO/p/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z388tGUA; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z388tGUA"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A73E01C9EA;
	Sat,  6 Jul 2024 18:01:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NLF3lPrFkvHy
	d3oTOW8nF6KdoA4YYzMOXK8X2xM8ryo=; b=Z388tGUAGn8R9GQ60pLoeKzwshCN
	nAzu99fu3mRL0jo9LyTe0cJiBWSXIXeKoRcorx31OzeJixLn1pWQSmJsGOijTDi4
	hbQf53CPJuP082Ck5cqXS1jilRRzao0SmJ7kAjcK5czSvJTe4s+BLAjQ5t/oDZ0t
	I9PFyNaGKY5Le/c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FFCA1C9E9;
	Sat,  6 Jul 2024 18:01:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9A371C9E7;
	Sat,  6 Jul 2024 18:01:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ariel Cabello Mateos <080ariel@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] gitweb: rss/atom change published/updated date to
 committer date
In-Reply-To: <CALRJROB7gGWok-YPGTjPe+TXkU5Y_MhqcPSiCGoPDzJ=WGHoKA@mail.gmail.com>
	(Ariel Cabello Mateos's message of "Sat, 6 Jul 2024 16:16:15 +0000")
References: <20240704164547.94341-1-080ariel@gmail.com>
	<CALRJROB7gGWok-YPGTjPe+TXkU5Y_MhqcPSiCGoPDzJ=WGHoKA@mail.gmail.com>
Date: Sat, 06 Jul 2024 15:01:00 -0700
Message-ID: <xmqq8qyenpsz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3BDD9122-3BE3-11EF-9449-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Ariel Cabello Mateos <080ariel@gmail.com> writes:

> Currently the value used is the author date. Change it to the
> committer date that betters reflect the "published/updated" definition
> and makes rss/atom feeds more linear. Gitlab/Github rss/atom feeds use
> the committer date.
>
> The committer date is already used to determine if more items should be=
 fetched.
>
> Signed-off-by: Jes=C3=BAs Ariel Cabello Mateos <080ariel@gmail.com>
> ---
> Changes since v1:
> - Typo fix in the commit message.
> - Semantic fixes in the commit message.

error: corrupt patch at line 20



> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ccd14e0e30..0ef5707557 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -8329,7 +8329,7 @@ sub git_feed {
>                 if (($i >=3D 20) && ((time - $co{'author_epoch'}) > 48*=
60*60)) {
>                         last;
>                 }
> -               my %cd =3D parse_date($co{'author_epoch'}
> , $co{'author_tz'});
> +               my %cd =3D parse_date($co{'committer_epoch'},
> $co{'committer_tz'});
>
>                 # get list of changed files
>                 open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_=
opts,
