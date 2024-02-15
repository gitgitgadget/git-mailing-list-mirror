Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080A1474AD
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 22:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708035216; cv=none; b=FfW/nX1Y7qutu26YWMnKuo2uVFtuLQ1jthgoNfYJBIKLxuH/bMedv+gtkAhDgB2jcU20MbcmTlcb2QvBuEGKm0SkRTK1S9CEJb2cZGWAMwRneeM5XsgvzhFRSwovG4/GD/odYXkBjlq8WDEvxNFEkc/NaYltHEJL3lfKbWoTVcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708035216; c=relaxed/simple;
	bh=7X3r35hVjKQOkv7PX632tAku9LrvV+CtjMy5KvOYagQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SvJNpFjtFbdVXeXLmagmnZXLI9JtFdyPDFPzxBwWoKrtEsQW3NHtTGdoLzDj6aCaG5vC4U/gZwzXAgnelLWuY0m/Ygoc3URq1Cag/0ozkXM4F7bUKcR+s15OJ9IUQ/PXlD/rUFNTDFa/1lKaOxLSdsEtdFYYMDirKzbXnvuo7zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZPJWuzac; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZPJWuzac"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BC0EF1DE6DA;
	Thu, 15 Feb 2024 17:13:33 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7X3r35hVjKQO
	kv7PX632tAku9LrvV+CtjMy5KvOYagQ=; b=ZPJWuzacAx5dDXuNgtyDHZAwAuZ6
	u19L1i8mM6/qupaDOUSKZ6ytqlOFJEZHx5oIe2vziwcTDqRtOEJBC0Rij1d9Ul6I
	Hg+4RbXqDS4ODhArXfY/iRTUl6i9/HkhxAcUKglZo+kkWiBx7bUpnP2s7t9By9ti
	d3DMLxFWSm9hoAo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B26621DE6D9;
	Thu, 15 Feb 2024 17:13:33 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2466D1DE6D8;
	Thu, 15 Feb 2024 17:13:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>,  git@vger.kernel.org
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy
 operations
In-Reply-To: <e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Thu, 15 Feb 2024 22:52:36 +0100")
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
	<e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com>
Date: Thu, 15 Feb 2024 14:13:31 -0800
Message-ID: <xmqq8r3lnzp0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 74F304AA-CC4F-11EE-9528-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> On 15-feb-2024 19:42:32, Dragan Simic wrote:
>
>> Move the descriptions of the <oldbranch> and <newbranch> arguments to =
the
>> descriptions of the branch rename and copy operations, where they natu=
rally
>> belong.
>
> Thank you Dragan for working on this.
>
> Let me chime in just to say that maybe another terms could be considere=
d
> here;  like: "<branchname>" and "<newbranchname>" (maybe too long...) o=
r
> so.
>
> I have no problem with the current terms, but "<branchname>" can be a
> sensible choice here as it is already being used for other commands
> where, and this may help overall, the consideration: "if ommited, the
> current branch is considered" also applies.

Actually, we should go in the opposite direction.  When the use of
names are localized in a narrower context, they can be shortened
without losing clarity.  For example:

    -m [<old>] <new>::
	rename the <old> branch (defaults to the current one) to
	<new>.

is just as clear as the same description with <oldbranch> and
<newbranch>.  With the original text without any of the suggested
changes, <oldbranch> and <newbranch> appeared very far from the
context they are used in (i.e. the description for -m and -c), and
it may have helped readers to tell that these are names of branches.
But if the context is clear that we are talking about "renaming"
branches, there is not as much added benefit to say "branch" in
these names as in the current text.


