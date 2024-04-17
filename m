Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922D657C3
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 06:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335784; cv=none; b=ILJujL4KGlF5jq5Jkb4bQ4VBJ80FnADrF6fEY0Pg8bki4Jm+TYTdGN1/U+6eMrfe8Bc6do5W7Ofxl2HmrtJTFH6ma4HNRhnn45a+1NbQcozc3Ot0kwYRvrw943JJ9Ni+3/w9IfJ0qMOBo/zfkOL3vZeHjRVrC50g90ihzKgi58k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335784; c=relaxed/simple;
	bh=SSi9cJIKoQieWKY027iqiXirFuUyyWD0iPSNr8kbXY8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=QMu7GjX8u/Lz82iN3BbDjLcN6p0JC4i4VQpoUcr4CHk0sagOaB035+xwLwBwW8fDoXaK015oPV0pVaV/F4bdd1iWO+YSpeguQr0c0doysB/l4rPVSiTQzXZHzkfXxGJimM4Agx3bK6Rjh5W3aC3CHzepy7rwd95w5lTzLPg2Y9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=tLX0H8dv; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="tLX0H8dv"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713335780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Mt/9cEcrQEC++cqJy+zbvQle4cQLEjB66Kt440+9f8=;
	b=tLX0H8dvV4o3WmekO12z79EBZ2cTSdGdlxFpPtEkXyt1WfRCPo0S5U9d7TzQMpTmrJ9zOg
	uudjHEGf/aPdEjFdgNr+a49ym0Tj5MpAWf3uiIpQSt4c+4hrz8vdxqmY9RmytEn1hPE0lX
	ovGGmOVV5s1TRPZU6uZt/JlIC2xXAdRE/rA7kq7pXNslaul+2KE83gMcJ+J57i2s7ApGVJ
	J2h0QGKzXHrlZGarKXz0D72qL6/P9q/icnQ5/m6bkLuX1FvVvbnVPJrcbJfIaFnxZz8T3U
	KYTdZPCbMqJXclvvY3pVJY8pH4y4IIjqfYgNkegIgpC43zg3lISiBsCID9+fGQ==
Date: Wed, 17 Apr 2024 08:36:20 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND"
 to patch subjects
In-Reply-To: <556d4baa-14f9-485a-8db3-0c9a966351a7@app.fastmail.com>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
 <556d4baa-14f9-485a-8db3-0c9a966351a7@app.fastmail.com>
Message-ID: <4aa0754ee62d78ca9300eb709df561b3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Kristoffer,

On 2024-04-17 08:14, Kristoffer Haugsbakk wrote:
> On Wed, Apr 17, 2024, at 05:32, Dragan Simic wrote:
>> Add --resend as the new command-line option for "git format-patch" 
>> that adds
>> "RESEND" as a (sub)suffix to the patch subject prefix, eventually 
>> producing
>> "[PATCH RESEND]" as the default patch subject prefix.
> 
> I think this paragraph is a bit *long*. How about
> 
>   “ --resend adds "RESEND" to the subject prefix (producing "PATCH
>     RESEND" by default).
> 
> (I took this from description of `--rfc`.)
> 
> Probably modified to fit in with the other paragraphs.

Thanks for your feedback!

I also wasn't super happy with that paragraph, because I tried to be
as technically accurate as possible, but that unfortunately made the
wording a bit awkward.  Though, I'm not really sure that your proposed
description is actually better, because the parenthesis should in
general be avoided, because they disrupt the flow.  It also doesn't
use imperative mood.

Of course, I'll see to improve that paragraph.

>> Of course, add the description of the new --resend command-line option 
>> to
>> the documentation for "git format-patch".
> 
> This paragraph can be dropped. ;) Adding documentation along with a new
> feature doesn’t need to be called out.

Makes sense.
