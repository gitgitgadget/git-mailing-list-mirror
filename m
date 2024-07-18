Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44546D1B4
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721339289; cv=none; b=TEW9BJZCyb69uW6ET2e/dAt7EpIxtCvPD/7vkojmGMgQ9axqz3nKR9JebV54TANs0rsDBrzyKBIpgiS5KCiyXzkfbuTe9yADpIWUylVxZadwpQrb2ANUQ82Sc9JDOnCpYqToRNf6PREmATpF+VewlZWQ44KoiaPO58NNfRYaABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721339289; c=relaxed/simple;
	bh=GRGw1WXDOpJWYVVcI3B+cWQ9ZpCVN2abR/n2kTiB8/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dDDFOpA0TN0Oa+FsbOpx4wIHzgtx21lZLYAHM3CevGf7YOrcp+0s2dRFiiAjdDLfxLwAWfVzocnw1kcBkYiIofcGAJ12SdJmFoZgP+v6TfHEeCuOICoSNSxO6jP6AiP1x5IBYMuFS14j/9P6PCbx4vWwIPs+JFdVroyFUjBtdyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=avVVBxdD; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="avVVBxdD"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EA8482E15E;
	Thu, 18 Jul 2024 17:48:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GRGw1WXDOpJWYVVcI3B+cWQ9ZpCVN2abR/n2kT
	iB8/s=; b=avVVBxdDbnx0OnMJYy5GercyRU7xAFs73cSpovWXgUuu6enzqDFVFB
	PhwEi4uKaw0IfN6JZSIYT1QnbkrIACAPdgwKpHH+DTGEfMSt3LzCUfU45bAVd7pG
	CJFONzoLEzUsBRtyd6cAddbtFwtpimllwbI/SJ6l8Znyk2WnGuKSc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E2FC42E15D;
	Thu, 18 Jul 2024 17:48:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6A9B92E15A;
	Thu, 18 Jul 2024 17:48:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <rsbecker@nexbridge.com>,
  Taylor Blau <me@ttaylorr.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3] Documentation: add platform support policy
In-Reply-To: <CAJoAoZk7qdDnANChseZ295RVDe9yrR75WNQDx8m5tr6MYAEB4Q@mail.gmail.com>
	(Emily Shaffer's message of "Thu, 18 Jul 2024 11:22:03 -0700")
References: <20240711232413.693444-1-emilyshaffer@google.com>
	<20240718173843.2411415-1-emilyshaffer@google.com>
	<CAJoAoZk7qdDnANChseZ295RVDe9yrR75WNQDx8m5tr6MYAEB4Q@mail.gmail.com>
Date: Thu, 18 Jul 2024 14:47:59 -0700
Message-ID: <xmqqplranzhs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 67984468-454F-11EF-8438-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Emily Shaffer <nasamuffin@google.com> writes:

> FYI, the asciidoctor build failed upstream. I won't have a chance to
> fix it til at least the afternoon (if not tomorrow), but I'll prepare
> a scissors fixup when I can, and include it into the reroll if/when
> the next one is needed.

diff --git a/Documentation/technical/platform-support.txt b/Documentation/technical/platform-support.txt
index 981997e635..65c0fa20de 100644
--- a/Documentation/technical/platform-support.txt
+++ b/Documentation/technical/platform-support.txt
@@ -54,8 +54,9 @@ Example: NonStop
 https://lore.kernel.org/git/01bd01da681a$b8d70a70$2a851f50$@nexbridge.com/[reports
 problems] when they're noticed.
 
+
 Compatible on `master` and releases
------------------------------------------
+-----------------------------------
 
 To make sure all stable builds and regular releases work for your platform the
 first time, you can make sure `master` doesn't break for your platform:
