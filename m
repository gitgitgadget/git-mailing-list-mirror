Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1540B15B13A
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722874092; cv=none; b=YIhUcdypWGh3Ms/mWLpH+VzZcUiSxMuaGpIthHApIThFQnUseUZA1UyChHWJGuI4PQa2FamrknFcLmbC/UJb4q2G40iqeejCPLuJeWTjYSUVARUuQAAqq3wjq2UxR3Rlxqk7febdaeaJ9SfA4G1weio7rLjPWI0fIffWbwPrZyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722874092; c=relaxed/simple;
	bh=1NajqPcyLRLGojS1fv5Ts1lWRbTpJSzXag82hDqSg+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=osHAF6dGmiKvqWb9WuUnw3QgmvaEjx6SWs+jlLM7ayeQloXeta42uOUyIcx6+doAnmlwv9DqInI8XcpMihGE76Gm4HSlqZtI0+W8vpJRvaoGZfcduGNyB0wWlDmyKA07c4Me0w9Vxnb9viWAbvFSQO6ARaaUW/V/Amgvsy/KnyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vax81uR6; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vax81uR6"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E022D35C14;
	Mon,  5 Aug 2024 12:08:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1NajqPcyLRLGojS1fv5Ts1lWRbTpJSzXag82hD
	qSg+c=; b=vax81uR677nrV3RK+VQnuJLCxeiPNBdiyJb8FhBvX04/0QB0uTIXzb
	JqL5+oZrCngVxT4GmzkmZjlfvk7MUydWf7vHmKYziehdggrJr/S+R3vow/EcXhHx
	gTiWugLnLlg0Y4hM2G6th40vUfuXb422yz5ELfju4Ev4JWFD2jCxo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D2BA735C13;
	Mon,  5 Aug 2024 12:08:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 03E6235C12;
	Mon,  5 Aug 2024 12:08:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,  =?utf-8?Q?Jean-N?=
 =?utf-8?Q?o=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 4/5] doc: git-diff: apply format changes to
 diff-generate-patch
In-Reply-To: <5ef4a7bd-3b9f-4e71-9a22-e22012f815ce@kdbg.org> (Johannes Sixt's
	message of "Mon, 5 Aug 2024 07:53:19 +0200")
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
	<3c475a2ee4ecfb79a1174fa693b592ebafdbf5f9.1722801936.git.gitgitgadget@gmail.com>
	<5ef4a7bd-3b9f-4e71-9a22-e22012f815ce@kdbg.org>
Date: Mon, 05 Aug 2024 09:08:07 -0700
Message-ID: <xmqqcymn3qc8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E8362DC6-5344-11EF-926F-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Johannes Sixt <j6t@kdbg.org> writes:

> I've a strong aversion to the formatting that this series applies,
> because it introduces many (IMHO) unnecessary punctuation that
> vandalizes the perfectly readable plain text. And this hunk now shows
> where it goes too far. These lines under the new [synopsis] header just
> aren't syopsis; they are comamnd output. The updated version abuses a
> semantic token to achieve syntactic highlighting.
>
> To me this series looks too much like "we must adapt to the tool" when
> the correct stance should be "the tool must adapt to us". If the tool
> (one of asciidoc and asciidoctor, I presume) does not cooperate well
> with out documents, then it is the tool that must be changed, not our
> documents.
>
> I understand that some compromises are needed, but with this extent of
> changes we give in to a sub-par tool too far.

Thanks for placing this into words a lot better than how I could
have done.  I share the same feeling.
