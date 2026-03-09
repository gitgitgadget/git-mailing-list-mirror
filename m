Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEDB2367D1
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 06:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773038376; cv=none; b=cVz6x6XIU0jkn4Q2HQ86vyzWrLzQiKVPf4HjIxoHqxYJLoAXcrlqjuQxxydyYzN4BB+W01y57P3+ZeQQ7Q1ibu8gODJxEP5ccmz7BSKd/PfyXsZzHhWpvQeLCFQMa+dOpKP9uodchSLqNfYieVr925JbjoUwHIT246n2SS5oHZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773038376; c=relaxed/simple;
	bh=yHHMcyLGDuFDU5eSW8a3auF11AnePOamLa1maBtpb+M=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=REoTiPpsfitreSQKsGyQlcmUsAftZhZAcOlwj9tftecjtcDJHVugFPmmT1cWeL8/t7Rn+xB5JPeGbIELJGDCkU9yuGQOt6YCgy4M0z9UHb2m6lw6iJau+T+MmoRT+51V81QsEQKgPSIvzaBSUz6oT3+233HgZ/O4wjYgoCPnOGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=Oxh+CBN5; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=DV3Zt6ek; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="Oxh+CBN5";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="DV3Zt6ek"
DKIM-Signature: a=rsa-sha256; b=Oxh+CBN5lW62oQRgLsLBRQG9OWAQKBIkwvqC1/k7jlTID5rKxcNLWcs0diGGEZorwRkO8RaVYtwGHPnCnbaVIIJ3GGtzc5udkWxbe/5cip1FDYk4SoNlZVq5Pr8CDdR2E76GJIvQz4Kp8sSs0jV8DE8qMGWT5m3NQv7m25d3codZ4m9xjAhH3BQzavZpKMt90CnF3mEytWnwuZluAYYZ0D9V+vsJQujE/yxgi7sBwewp1v6c7RZFNELIevs7b90P8Hd10dDEvIAb0JUq9m9rx6L48SUZX4kLFr/d2MEINsXnCpWV+nztaq3slRBtl1S3OrrQGp0SndufElHdx2RtKA==; s=purelymail1; d=malon.dev; v=1; bh=yHHMcyLGDuFDU5eSW8a3auF11AnePOamLa1maBtpb+M=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=DV3Zt6ekScl2L64EIlaLW8r1ji+GDXY3v5v2/+w5juVppdKpLMtByMdBmoRj+/3JJtpp48Z8lin4iyMiPLe7qyU9si4zm5YmqbFqodaHIgrX8MgV8H1fJTF1Y8V6sW6H8AaV1KqZX7y9PGXuZn0vIS9RI4mBhRAWR9oRQT7abm5pBbaedhMFqwgkRTk8AbnF2PkEn/j1q8rayS8xxPWS1fH3qzdZPherjXEsp1P8VdEoknc/NyPtuJhX2Jid/Ts+XsU1x0vnrPg5AUcuRZH+9j3/d2TRZBd9KWi/8uZdFYRC+qVMzGhlmwzgh80ebCIyEqvVHO7L96JJ4HZOWBw5Ag==; s=purelymail1; d=purelymail.com; v=1; bh=yHHMcyLGDuFDU5eSW8a3auF11AnePOamLa1maBtpb+M=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPA id -1366529355;
          Mon, 09 Mar 2026 06:39:25 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Mar 2026 14:39:25 +0800
From: cat@malon.dev
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Kevin Willford <Kevin.Willford@microsoft.com>
Subject: Re: [PATCH v2] patch-ids: document intentional const-casting in
 patch_id_neq()
In-Reply-To: <xmqqh5qp97bd.fsf@gitster.g>
References: <20260308043131.77782-1-a3205153416@gmail.com>
 <20260308150203.86299-1-cat@malon.dev> <xmqqh5qp97bd.fsf@gitster.g>
User-Agent: Purely Mail via Roundcube/1.6.11
Message-ID: <4d93dbf55e141460989f21edad24440d@purelymail.com>
X-Sender: cat@malon.dev
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio,

> Is that a "performance regression", I have to wonder?  We would
> regress relative to what by doing what?
> 
> Is the lazy evaluation avoiding unnecessary work?
> 
> If we are going to pass _all_ the objects in the hashmap to this
> comparator function eventually _anyway_, then the total cost of
> computing patch IDs to all of them in the hashmap would not change
> with or without lazy computation, but if we are currently getting
> away without having to compute for all, but only computing for the
> ones we pass to this function, then lazy evaluation is clearly a
> win.  I do not offhand know which of the above two is the case, but
> we need to know that before we can touch the NEEDSWORK comment, I
> think.
> 
> The lazy computation comes from b3dfeebb (rebase: avoid computing
> unnecessary patch IDs, 2016-07-29), even though the "const
> correctness?" comment is a bit newer than that.
> 
> So it seems that we indeed are avoiding unnecessary work without
> this patch.  We'd encounter "performance regression" only if we stop
> avoiding unnecessary work, so I am afraid that the phrasing used in
> the patch is somewhat confusing.

You're right. Avoiding unnecessary work is indeed a more fundamental
reason than preventing performance regression.

>     Even though eptr and entry_or_key are const, we want to lazily
>     compute their .patch_id members; see b3dfeebb (rebase: avoid
>     computing unnecessary patch IDs, 2016-07-29), so cast the
>     constness away with container_of().
> 
> or something, perhaps?
> 
>>  	struct diff_options *opt = (void *)cmpfn_data;
>>  	struct patch_id *a, *b;

I will incorporate your suggested phrasing and reference to the 
historical
commit in v3.

Regards,

Yuchen
