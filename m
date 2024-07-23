Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A8813B5B4
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721757846; cv=none; b=qAh8rRs6YQIJdHEGL42bseCfN2RstQvH+b6zsn2CWY+clCGDzSsW/AtK8nO3KM0qEneNtwcr1y6G3Jj7SRwQuVqen0AoQ4A7Qi3Bb41EVnFB5dLpf/xExhp5hMLraAZJ+d+/GQ6Q/3laRa+LU2lwvuav0vtrMRaBX2Jbbk3Ti5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721757846; c=relaxed/simple;
	bh=vw/9ExAahyi88srcMrjHKPSw30sBJ6UqICLrSmE684k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MLgm18kTaNa2PMDA0vqf/t0fg0LlxOAQjMP92XOx5tp7KczaDnnpN5QWcnHoCLqECyBo11l41e/2gR0b2UtrcRz8x8g6AGUXvDO7HsPt/R+dzN4LH0SZ3UyFDHLoBx6kt59sKUoNt+5VIwSHSZsRDbPIp/Thx15/DBw2owxIaZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gXkS48ZF; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gXkS48ZF"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CFEE1D62A;
	Tue, 23 Jul 2024 14:04:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vw/9ExAahyi8
	8srcMrjHKPSw30sBJ6UqICLrSmE684k=; b=gXkS48ZFswUmpluS+TzUuT7VAPTu
	WRuW4IFqi/m/JhF9GNyD4gwJm3/E39URTjYsBdz/pX6kdvGNYtHPwjKBHJpGLkDS
	PqAV26W905sU5FK5m9BvXrCdt78PBDTrNyFiBRGN0BlXzXgHJ25mpBj6V3u7jro4
	LzkMLY0EMVtyJkk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 513301D629;
	Tue, 23 Jul 2024 14:04:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ADD8C1D621;
	Tue, 23 Jul 2024 14:04:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,  Johannes
 Schindelin
 <Johannes.Schindelin@gmx.de>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila via
 GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] doc: git-clone fix discrepancy between asciidoc and
 asciidoctor
In-Reply-To: <CAPig+cQK17Xt6p7PSO4Mn1CLx_ayceQdj8ZY1zBVG6-c33OvsQ@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 23 Jul 2024 13:47:47 -0400")
References: <pull.1765.git.1721496853517.gitgitgadget@gmail.com>
	<xmqq8qxvhcy5.fsf@gitster.g> <8404759.T7Z3S40VBb@cayenne>
	<xmqqplr5e5yk.fsf@gitster.g>
	<89d00235-71db-4087-8ffb-7e93c3f470a0@free.fr>
	<xmqqv80w2ji8.fsf@gitster.g> <xmqqv80w0zrx.fsf@gitster.g>
	<CAPig+cQK17Xt6p7PSO4Mn1CLx_ayceQdj8ZY1zBVG6-c33OvsQ@mail.gmail.com>
Date: Tue, 23 Jul 2024 11:04:00 -0700
Message-ID: <xmqqr0bk0yun.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F18EF7EE-491D-11EF-8ECF-BAC1940A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Jul 23, 2024 at 1:44=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
>> Subject: [PATCH] Doc: fix Asciidoctor css workaround
>>
>> The previous step introduced docinfo.html to be used to tweak the
>> CSS used by the asciidoctor, that by default renders <code> inside
>> <pre> as a block element, breaking the SYNOPSIS section of a few
>> pages that adopted a new convention we use since Git 2.45.
>>
>> But in this project, HTML files are all generated.  We do not force
>> any human to write HTML by hand, which is an unusual and cruel
>> punishment.  "*.html" is in the .gitignore file, and "make clean"
>> removes them.  Having a tracked .html file makes "make clean" make
>> the tree dirty by removing the tracked docinfo.html file.
>>
>> Let's do an obvious, minimum and stupid workaround to generate that
>> file at runtime instead.  The mark-up is being rethought in a major
>> way for the next development cycle, so what the CSS workaround we
>
> Perhaps? s/what/that/

Thanks, I ended up doing "so what" -> "and".

>> added in the previous step may have to adjusted, possibly in a large
>> way, anyway.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
