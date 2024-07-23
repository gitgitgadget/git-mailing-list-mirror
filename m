Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E4E13BAD5
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721777831; cv=none; b=o5NBljL4XSsfPRoWu41RWWCIJIYdhVrJ84b+EFhHjO/cyeUIQZsH6znaf3pF+XFAt3ZtRk1EpD+ZzMVSrICn8CzFXrAqJGyP4iwlVsgvePDJaHwvoK1TV/TR1j2vhcYpfEPPeXbMSdyg/7GKr5tv1FC/sNRuRQ+wgWTnxPzRKG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721777831; c=relaxed/simple;
	bh=reZS52DrV5Vrw8r3ltRMETo1COoIUyqzCzORL8O7i0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IaxlWcneDhqWtzAuRvsEHgX/u4jAhxb0NVjZY93SCaAYWUxtEzey+Lsf2SNJYpVjrq9hmK9ztcCBaZw4eKdcCicXhtAIgkDUEMmd82JNSbtwtT7PkfyoQiQTIDUXwy4JHqO7hbdnL2GJYnJ5P5r2oJfRW0XXKbdwq3Tg6FFafdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mkiE9RtH; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mkiE9RtH"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DCEA30E37;
	Tue, 23 Jul 2024 19:37:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=reZS52DrV5Vr
	w8r3ltRMETo1COoIUyqzCzORL8O7i0c=; b=mkiE9RtH9V5CeVXKzhviHcwWd3v1
	v7Ghc2Fk8NN/VRKVLOEXetb8eJe4qoewA8zb1Em9i8LTN9/fOOjil7B3UBRPs45y
	QhilVzu5Uogk5x5K756sp0uynPccNsGl5wTPw97Rub7KhM9tywBTPqb0Hw3zyhkB
	cQqOY+Re7+Z1yd4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3309D30E36;
	Tue, 23 Jul 2024 19:37:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B6FA930E35;
	Tue, 23 Jul 2024 19:37:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 2/3] doc: update the guidelines to reflect the current
 formatting rules
In-Reply-To: <b0547422e5cf31c1141f2b6078a43e5bc60cb652.1721774680.git.gitgitgadget@gmail.com>
	(=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Tue,
 23 Jul 2024
	22:44:39 +0000")
References: <pull.1766.git.1721774680.gitgitgadget@gmail.com>
	<b0547422e5cf31c1141f2b6078a43e5bc60cb652.1721774680.git.gitgitgadget@gmail.com>
Date: Tue, 23 Jul 2024 16:37:05 -0700
Message-ID: <xmqqjzhbznmm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 78F85418-494C-11EF-9C10-34EEED2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  Documentation/CodingGuidelines | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuide=
lines
> index 1d92b2da03e8..4d59e8f89ec8 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -760,56 +760,60 @@ Markup:
> =20
>  Synopsis Syntax
> =20
> - Syntax grammar is formatted neither as literal nor as placeholder.
> + The synopsis (a paragraph with [synopsis] attribute) is automatically
> + formatted by the toolchain and does not need typesetting.

How pleasant ;-)

>   And a somewhat more contrived example:
> -   `--diff-filter=3D[(A|C|D|M|R|T|U|X|B)...[*]]`
> +   --diff-filter=3D[(A|C|D|M|R|T|U|X|B)...[*]]
>     Here "=3D" is outside the brackets, because "--diff-filter=3D" is a
>     valid usage.  "*" has its own pair of brackets, because it can
>     (optionally) be specified only when one or more of the letters is
