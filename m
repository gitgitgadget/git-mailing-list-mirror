Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E061DC47F
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724098104; cv=none; b=XnemXzg2F3ONSuDuH4UuJZAW4p4tDOmdrEL5ZsmSL5MdLo4DyVJ6FUE8A113nR667FCBVj2J+eswLgwrI4/cQgqL9kt1/huwv+2gDE5IybB7i8SgnRKwSJz2sGH6Qerf4FiNlgYur+7ig+EDM7aPS05xdmuY7Iaqv51pMI5p3E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724098104; c=relaxed/simple;
	bh=P6y1FYC46Rb8chSEjAyISpoAFUiSOWhpaIq1/4ltuD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YT8Tacq2hfjdPW4jmVR6xtrHwWCNNOAhd2Rrpdst0romJvDtnMHVn0NdExXcyVO8/UfSIYmyyHLOuHm0MELPBvrEj4YDSPShtiUmN6M1fm8OVBoYcht8f7h/5JxnPK0Cz0/jEhkEFjP/STFbCEyXmlFEUF2Uf2aw+Xs9OvxQlE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rWBL98uj; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rWBL98uj"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6AA012F494;
	Mon, 19 Aug 2024 16:08:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=P6y1FYC46Rb8
	chSEjAyISpoAFUiSOWhpaIq1/4ltuD8=; b=rWBL98ujC5HFZZEhkw+XNd25TizN
	vQaz6wzV22t3TJ8DFFHahJDYrxUoHsEcAEzljlhntky/kBxqNOON2Oh6lpSqaok5
	anlgkuZeZaYCzCzAXl7k8Svc5SMCc/ookqdLvxsxZ6jUL8dCZyXY9OP44BED3bnG
	52DwC43mOqWQ2cY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 627312F493;
	Mon, 19 Aug 2024 16:08:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C05C02F492;
	Mon, 19 Aug 2024 16:08:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, =?utf-8?Q?Jean-No=C3=ABl?=
 Avila <jn.avila@free.fr>,
    Johannes Sixt <j6t@kdbg.org>,
    Patrick Steinhardt <ps@pks.im>,
    Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/3] doc: introducing synopsis para
In-Reply-To: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila via GitGitGadget"'s message of "Sun, 11 Aug 2024 15:20:09
	+0000")
References: <pull.1766.v2.git.1721855179.gitgitgadget@gmail.com>
	<pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
Date: Mon, 19 Aug 2024 13:08:19 -0700
Message-ID: <xmqqzfp8cm30.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 C811C46A-5E66-11EF-B449-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

"Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Jean-No=C3=ABl Avila (3):
>   doc: introduce a synopsis custom paragraph attribute
>   doc: update the guidelines to reflect the current formatting rules
>   doc: apply synopsis simplification on git-clone and git-init

This topic has become quiet.  I still find s:["someything you really
want to say"] notation a bit annoying to my eyes, but its may be the
best compromise we can come up with.

So unless we have a strong objection, or (even better) an objection
with an alternative that is less yucky, perhaps it is time to
declare that this is the variant of AsciiDoc/Asciidoctor that we'd
adopt for our documentation.  Comments?

Thanks.
