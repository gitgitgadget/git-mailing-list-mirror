Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D417AD5A
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 03:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774668308; cv=none; b=H/uruAk/6e9v9xZmrZ69AUi+xmjS8wJMi0zYA2TJHtwfncVPevbeWpJ7O1GC1p7GRezAZzIV5wcTfje4yBVUmqi+L9UbD9Qa2GTzM8b9moGT4Ra0BjcifjpJbpZSkSakX/EdXJ30YPW4u3eAR4Cb3+fx2MlhDQJ503dflRK+fe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774668308; c=relaxed/simple;
	bh=0NXpjFN3PVAx/T1KzYLAb0bH02okIpDFBbHWSe0sEt8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=g8yI1UZsTZXx2kg7qMa0GFKe0X1TNuUjpYNer+KJs8q7L4ts/8J+317PFbH0XJ3gkyRXQ3siLHJ5GJM/RqPnRO33/Gbwu2Be3c2Zxihyd9IzU1vDf/eJLSh2UALI4aZGFa5JUmMmm0dOvXPiIt25uldZnVWjswy0lbEm085Cosw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=D47vfrOO; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=mFz8mpk1; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="D47vfrOO";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="mFz8mpk1"
DKIM-Signature: a=rsa-sha256; b=D47vfrOOXI1sBMR7MZDm4JZlYKF70fozx3RXV8QFnTWN018Z5ElGlINt6be4iKVveTrdTPXnnkWq9NTVfHwKHPxhzMIViO/QsjSDnJqpmQMwS3U1qIztsn8R/Oc8l77aBw2Fz+NUKoDjuILAtmJxSCPuoo4cSRmnyLEpgAxvdoO5pbVfhFu/YnOEnd9riLp69vANJczsL81mifpLUswF8Ldy6X6+QCy4ixVnPN0yBaXSe0hKEH1CP6eLrJ8YDQjy31GUeZ1hLd00mzF6WuhRCh7W9FAYZ7HeFNwHPEV769cZfbByzDbLpe7yc1ztA/N54jkBn2k2zB+CFyCMPAi2Gg==; s=purelymail1; d=malon.dev; v=1; bh=0NXpjFN3PVAx/T1KzYLAb0bH02okIpDFBbHWSe0sEt8=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=mFz8mpk17H4Tm0wDaeXVJjV4QbmIypPdyOOLm3jefeHGH5R01LSpdj+3poIij+w93b+2EdoahP5Pho6soOsdr5y1yFI+WcZ/FRW+pwPnXEjaSvOYaQrAF1OSPVJJGzOg/9t8DQFCCwK5AuO3xp5EdINOENPYJYY2Y6Zr4+pc/1IVGNppBWXeKBb8GVACd3+GjCUPQdBrFJayhaMIP4ukeIXOS50s1IUcb4odQJLozoupfvZtEj/bO07MJZTbU+yGrgfOWVN6IxY7Z0HeteP02ep8/cCw6WmNk7mu/w7l6eNDBfjmbP/3cjDopguL6N52SOrLxE8VNGrO3Ve4gXu4+w==; s=purelymail1; d=purelymail.com; v=1; bh=0NXpjFN3PVAx/T1KzYLAb0bH02okIpDFBbHWSe0sEt8=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPA id -1825036035;
          Sat, 28 Mar 2026 03:24:57 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 28 Mar 2026 11:24:57 +0800
From: Tian Yuchen <cat@malon.dev>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v1] replay.c: support replaying root commits
In-Reply-To: <xmqqcy0pje5c.fsf@gitster.g>
References: <20260327180930.104563-1-cat@malon.dev>
 <xmqqh5q1jfdg.fsf@gitster.g> <xmqqcy0pje5c.fsf@gitster.g>
User-Agent: Purely Mail via Roundcube/1.6.14
Message-ID: <283d016a1f109129e462b547e604a724@purelymail.com>
X-Sender: cat@malon.dev
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio,

> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Tian Yuchen <cat@malon.dev> writes:
>> 
>>> 'git replay' does not support replaying root commits, as indicated by
>>> the FIXME comment. If a user attempts to replay a root commit, the 
>>> 'die()'
>>> in 'replay_revisions()' will be called.
>> 
>> Please be aware of your surroundings.  I think there are multiple
>> topics that work on this file and among them there is a topic to
>> address the same issue, if I am not mistaken.
>> 
>> The list archive is your friend, for example, you can try these:
>> 
>>     https://lore.kernel.org/git/?q=replay+root
>>     https://lore.kernel.org/git/?q=dfn%3Areplay.c+%22root+commit%22
>> 
>> Thanks.
> 
> Oops, sent without completing what I needed to say.
> 
> After you find out that other people are working in the vicinity,
> some of them even may be working on the same itch you had, instead
> of silently letting them continue, join the conversation and help
> them polish their work.  You can give reviews, you can supply test
> cases, you can polish their documentation, etc.
> 
> Let's make this a team effort, not authors completing against each
> other, or authors working on their own thing without paying any
> attention to what others are doing.
> 
> Thanks.

Oops, looks like I missed a few threads. Before I started, I actually
searched the mailing list to see if anyone else was working on this,
maybe I used the wrong keywords.

Thanks for pointing out. I'll join the discussion. ;)

Regards, Yuchen
