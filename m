Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236783FB7E5
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 06:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230238; cv=none; b=f6VS/U5PUjOaNrWAYbjVj65QTV+xYWjEjGvfrOo4F+9JVJgjYLf1jmYAFLZLHiEurhTULPNK6TuhxbH1oAypfsi+Q4jm/61wDU2bppdTmGzhkE2Hu0rESO3XIqgySVfsMhnTClwDsKdL+XmwU9TqZBbaUrNNWlM8lx2o13nbAGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230238; c=relaxed/simple;
	bh=VefASzmbEXACzxVkxc53GBUG9cy7tQtdqd/JVy6IHH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htlFwdxFuB5b/c/Pe//G6kkr6CQFn0bp/HefCsCs1A3ANLWn6G2irQ+FcLOGqKOLLMZ1Dh+ZxpMas78wS17fEzZP12RR3KNph3TZ8fb06kruyFhklGz5UXs8H3So5nbvLEDH4DNV4uNoBPQMuHfz0VosvWGo33Bh3sUm5wbbA3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4hr3NK1DrBzRnlL;
	Thu, 24 Sep 2026 08:10:24 +0200 (CEST)
Message-ID: <6ff9d1ac-ff06-439c-bb0a-ce57742e8ff9@kdbg.org>
Date: Thu, 24 Sep 2026 08:10:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH REGRESSION] builtin/rebase: allow user to amend committed
 conflicts again
To: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
References: <20260923-pks-rebase-conflict-bug-v1-1-3d3ccf5022bc@pks.im>
 <c12d2ac3-5263-4301-aa64-a311a343dd40@gmail.com>
 <24cc4bcc-1d26-46f5-a502-ba673713f4f0@gmail.com> <xmqqik3vc1pc.fsf@gitster.g>
 <CABPp-BENMwiHh=y_RtfY3Y+uyjRvbpPSTRE9sCGvOtpeeMgapw@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CABPp-BENMwiHh=y_RtfY3Y+uyjRvbpPSTRE9sCGvOtpeeMgapw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[Cc: Jiang Xin]

Am 23.09.26 um 19:49 schrieb Elijah Newren:
> Yeah, reverting and retrying after the release probably makes sense
> given how close we are to 2.56.

The reverted series (0f8e75abebff) re-introduced one translatable string
("You are in the middle of a rebase -- cannot amend."), which tranlators
may have removed from *.po files by now.

-- Hannes

