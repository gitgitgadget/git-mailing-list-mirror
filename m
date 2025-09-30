Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA740221FC6
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759227095; cv=none; b=UwNYEZh+d9NLU6JC0ViCW/o7CQMxuujIlkVn8oyavP/JO1rE/q4TONIGl5GMN412ttawyvj7zLWA72vw1cpF2nSNn1w2+OraHB2MKWNhE10ADIgY8Ce2XaBDLN0wJnR1rwld8XRMO0gxQS0RWez4u55G7UKspDSdyJuhZQuXx68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759227095; c=relaxed/simple;
	bh=yP5bsb/TJE/OFz2+x2WcZiFBfGpftjf6SjmNQrI8XWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O17QkKBGnpWFWw8NlTLb8eEEk3fap8Ej5h5T5lOYF2Ule3iHfwoGfxMKWw6QwFNJTwJkj2llmnTt0Pgyrvt5NZY7csT6O9Br1EHcUPz3jONiSRYntbwiu6AhoVv3yfUbgPUqq1tRwmc+KbwwLegfBNfOsK/KdsnBuvwdP4Y5ElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=bOH78GC9; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="bOH78GC9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759227090; x=1759831890;
	i=oswald.buddenhagen@gmx.de;
	bh=yP5bsb/TJE/OFz2+x2WcZiFBfGpftjf6SjmNQrI8XWs=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bOH78GC9IK2yo7FFoKRQrKjlYceEGroL6cA9KRvTQq66D3AuBXaYfl/mB7JfPvot
	 KtvMJM6udTTAkZS/rfZHBvNZayby1QSjjzfDtyzmQ1jdmstGEGvClgzp3cWgBxd0n
	 z7szBi9xopWrL5uxncqo+pkJekvYfVW36/LkCgCw2Gr8u/ZFxmaL0Sb+PoByhaBp4
	 dc5flKwbs0GMwkHChyGk6qNcBmgFS5hhBVAMWymAxibRH1Z25eGaDRyZ4dr3AReAo
	 RHs63ZsSEU0ptH/7E07X6iicWboiSb8u22apbeiAvW8ZgzAhEEpXEe2UIQhrIpLHF
	 ShBpR/PYiyBRsSjtuw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.120]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWih0-1uoBFC2Vrs-00T0zI; Tue, 30
 Sep 2025 12:11:30 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1v3XKU-C6P-00; Tue, 30 Sep 2025 12:11:30 +0200
Date: Tue, 30 Sep 2025 12:11:30 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: git@vger.kernel.org
Subject: Re: customizing "cherry picked from commit abcd" comment
Message-ID: <aNus0ulSTb4rAYdF@ugly.lan>
References: <87v7l18nnt.fsf@prevas.dk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87v7l18nnt.fsf@prevas.dk>
X-Provags-ID: V03:K1:64JXZFpoy83URnL64V/rPMWPA3O4TCA7L996Cdr4M+w1CUNLtnb
 Z+NcvJU3Nnz7R8/6qqwAP21nvhOqN50fdC+/IjdaIE5wMnP0IJfCiqwykAAiXBRgN/GtAyg
 qefpFaSkp5GdI6vSVKllAbtcYz+cu5FfF4hSkMcgFwlF7R2RRkg7LJROgb3XkCG/HPITSag
 XutGDepqNDmWD9AVKdmLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SZJYXLUdqXA=;7BG0PwHsI1RjbzPqc5ZQKrkuZt6
 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
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 02:10:30PM +0200, Rasmus Villemoes wrote:
>This makes it easier, when porting to v+1, to know if that commit still
>needs to be cherry-picked or is already included, and also makes it
>obvious to anyone reading the current history to know the "upstream
>status" of that commit.
>
i sometimes customize this pseudo-footer as well, but it's usually=20
things like "(partially cherry-picked ...)" or "(... from=20
<repo>/<sha1>)", etc.

your particular use case would imo be better addressed by implementing=20
bi-directional linking between picked commits via a standardized=20
git-notes namespace.

the pseudo-trailer is really just a hack in the first place, and afaict=20
that status quo results from an ideological commitment against=20
cherry-picks during the early history of git. but it's really kinda=20
silly that subversion and perforce have better tracking of cherry-picks=20
to this date, even when it's their only way to do merges.
