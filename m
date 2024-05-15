Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2568322F03
	for <git@vger.kernel.org>; Wed, 15 May 2024 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791942; cv=none; b=r5qKJzjaQhFcXgLrMs9dri3Vaf/BcKlAcghBoOQydRhmVCZhbsecA3X4EzcV+o5nj+bHnrqb8J2ugZPlpi2qot0YFvB01cKhDhJwznbJHKYamLeAbjRxIBRqaTKPxFNnBT+lPbzBIeAvhjXq+8d5zJjIqA6pgJnf6fX7Vlm7IBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791942; c=relaxed/simple;
	bh=iPDQXgHCboBaUYwCNICB+ocnRFqgZ1ZdA6Fr86Cy8Yw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HCHrTiC41fJ8MSdPBQqHwB/enRQhAQ04ZTgqUHTOai42nBQmyWHrIE/pWF4GP2SHUeHb3cDZA4hjJKy/mi472eghuniUx2HFKrg43OrOPTZIp17zj10wo0m92jVmQv4xNKebHP/DBOh7zPQIIDivPJUpFUb1BT5swROVOsdaFGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bfy9MijA; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bfy9MijA"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A068A1E68F;
	Wed, 15 May 2024 12:52:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iPDQXgHCboBaUYwCNICB+ocnRFqgZ1ZdA6Fr86
	Cy8Yw=; b=bfy9MijACKXVxYIM/6TizyaXs/kLb1mbyrdnVopfI1ljru5Tr+UIYp
	PFCjJ1Lp4mgTE/3KQ05e/DVFGWZugwX1t4H+/kVewcFEReQzQ98vNrwxSXZK7Lu3
	BvNC2IfQYkOWuLvWE3OOEtDizvZbK39KSiPnXUJk1UeIvpDPcgObk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 987BF1E68E;
	Wed, 15 May 2024 12:52:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0FD341E68D;
	Wed, 15 May 2024 12:52:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marcel Telka <marcel@telka.sk>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: t0211-trace2-perf.sh: typo patern -> pattern
In-Reply-To: <ZkTIPlTS4jcQ-rHX@telcontar> (Marcel Telka's message of "Wed, 15
	May 2024 16:35:42 +0200")
References: <ZkTIPlTS4jcQ-rHX@telcontar>
Date: Wed, 15 May 2024 09:52:15 -0700
Message-ID: <xmqqjzjvxbk0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7CAFE104-12DB-11EF-B1EF-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Marcel Telka <marcel@telka.sk> writes:

> Hi,
>
> There seems to be apparent typo in the t/t0211-trace2-perf.sh file:
>
>
> --- a/t/t0211-trace2-perf.sh
> +++ b/t/t0211-trace2-perf.sh
> @@ -233,7 +233,7 @@ have_counter_event () {
>  
>         pattern="d0|${thread}|${event}||||${category}|name:${name} value:${value}" &&
>  
> -       grep "${patern}" ${file}
> +       grep "${pattern}" ${file}
>  }
>  
>  test_expect_success 'global counter test/test1' '

Ah, indeed, there is no assignment to the variable $patern so this
grep matches by looking for all the empty strings in the file X-<.

