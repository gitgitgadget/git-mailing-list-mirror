Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC711991C9
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 23:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732923882; cv=none; b=p09Dy+io906SkiKQyUo70C76s5grrSTqqX8cXNtwKG6wHGauPGQkwEgLt87D8XrSYHiCg+xvd5mtn5w5e4Llu9JepzrZi12B5RT1KLAY8D1L1KG+AkImaw0HhaIzH9uu0eyVTgQferxsxcu6v9xInXC/0/eaZF7Fn/GDv+mb/fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732923882; c=relaxed/simple;
	bh=gC+8FRDUNPY4/3gZxN14xDwF8swqa9pP7tKt1kwO7ys=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=M9ShDxcvFylMlBnc/z5nqbh2s23pYqcLJNzMp4jY0TeR5gAxXjcop075hYdwN8W2tSxQfcKc34jw3054Ny7ueOplELlbTiH8lU9Qqz7ndxUQEedkRlhgOfeUkfVbmApIfCGIY0KJ2/Hawork6DxmSg4xZWd1SYx/mt+dLKEkCHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4ATNiPKC2433773
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 23:44:26 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Caleb White'" <cdwhite3@pm.me>, <git@vger.kernel.org>
Cc: "'shejialuo'" <shejialuo@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me> <00c401db42b1$99c4d5a0$cd4e80e0$@nexbridge.com> <D5Z1L479JERN.80KZ7NA9BWNJ@pm.me> <00c501db42b4$ea97e050$bfc7a0f0$@nexbridge.com> <D5Z1X36NVZ28.1FPA05CU9GFRL@pm.me>
In-Reply-To: <D5Z1X36NVZ28.1FPA05CU9GFRL@pm.me>
Subject: RE: [PATCH v2 0/3] Ensure unique worktree ids across repositories
Date: Fri, 29 Nov 2024 18:44:20 -0500
Organization: Nexbridge Inc.
Message-ID: <00c801db42b8$a03539a0$e09face0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHZQR+UqnR1y6U5HdhCIquXTuJIeQHx0ACsAfNKDdECDlEqNwJOncQospDeV8A=
Content-Language: en-ca

On November 29, 2024 6:29 PM, Caleb White wrote:
>On Fri Nov 29, 2024 at 5:17 PM CST, rsbecker wrote:
>> On November 29, 2024 6:14 PM, Caleb White writes:
>>>On Fri Nov 29, 2024 at 4:54 PM CST, rsbecker wrote:
>>>> General comment on this series: Is there a mechanism of preserving
>>>> existing functionality for those of us who have existing scripts
>>>> that depend on the existing branch and worktree naming?
>>>
>>>Existing worktrees will continue to work as they do now. The only
>>>change is the worktree id for new worktrees. However, there's not an
>>>option to preserve the existing behavior for new worktrees (nor do I =
think there
>should be).
>>
>> I do not agree. Companies that have existing scripts should have some
>> way to preserve their investment. Just saying "No more worktrees for
>> you" is not really considerate.
>
>How exactly are your scripts depending on the worktree id? There are =
very few
>reasons a script might need to know the worktree id, and I suspect that =
there's
>some confusion here. The worktree name is still used with the `git =
worktree`
>commands, so there no change on that front.

The graphic describing this showed the id in addition to the worktree =
name.
During cleanup detection, the directory of the worktree is significant. =
If that
Observation is wrong, I retract all this.

