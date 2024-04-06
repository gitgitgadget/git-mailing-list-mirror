Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFC7A38
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 01:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712365878; cv=none; b=gmglCu+SHJGGiCZFI5R8lYHyOgh8gJEbZCsefDnjwrUyX9dc8Y+8eWZyk6Xx1CRMMLF2lwHBy63OclnlUq9WMe2CuAgSwh3vs7GDmCVbSZdm7WVw2zoLqjRguMbsagAbCix+9ryUEbxIlHAFAOB3nwV+RuNRFsHuazMrzIshNLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712365878; c=relaxed/simple;
	bh=18sV/X2dRCI0tSkJ/e1laCycCag667AGAEGsNitIZHY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=RI7E+IYpGV0asPpsfrZO/utP5T57c6y3owhHLzqM97fZcVOl+Iqhen8IL/47hTVJyh2OGtgR65R8MGGMrRGia78RJYOhopyLHhY48h2KINKfRnp51c13pMgYnby511CbOqNaPx7gOUfxgati8K16wCvC7s3QCh/ATAh4pFLyxKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=iWcrGczc; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="iWcrGczc"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712365874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzqhJlZbJlYR8EcWV9W3UV1VoLjhoa0PRCnvpABH1K4=;
	b=iWcrGczctPD9xHq5SUXghNnqw8ocO8IAfdKSH0peFwK3+M6n4CirR8ZEj0nuiBHsSRWbzu
	tyfr8VgsOj3mhANGQwSJ3OiGRdMKQFOYQ9A3pvC7Ja53t+PlpRhEDkXipCdXTdzhnkk11a
	0e7bp78SvA3bcLd8wKlDS1Bs+buy0aEltT9fu62Jg64nfQ9yRPd3l+WLdDC33HTPTiBfT8
	vRskLSofILEyJqJnloUwPPIkm2srRT1r6SmebEp8tJyoWx1Fl8y0W6zsv4c+Ovu1GL70j3
	qyFtZMcclm7/s9DC7hnKtjgb+Crik9D/j0hLZrKWznPKzmD70ajjHG6vDNLQZA==
Date: Sat, 06 Apr 2024 03:11:14 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2024, #03; Fri, 5)
In-Reply-To: <xmqqy19rtygr.fsf@gitster.g>
References: <xmqqy19rtygr.fsf@gitster.g>
Message-ID: <36f7e1b7122b0bdeb2e8b70f69abd331@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-05 21:13, Junio C Hamano wrote:
> * ds/send-email-per-message-block (2024-04-05) 2 commits
>  - SQUASH??? switch to separator semantics
>  - send-email: make it easy to discern the messages for each patch
> 
>  "git send-email" learned to separate its reports on each message it
>  sends out with an extra blank line in between.
> 
>  Expecting a reroll.
>  cf. <8d47bd687f2ad80bbc1e1c86ae337327@manjaro.org>
>  source: 
> <0e087ed992def0746f3d437253248904c2126464.1712262791.git.dsimic@manjaro.org>

Done, the v3 is on the mailing list. [1]

[1] 
https://lore.kernel.org/git/e3212c0a4ad331685c68c13afcdbced20982ab32.1712364420.git.dsimic@manjaro.org/

> * ds/fetch-config-parse-microfix (2024-04-05) 1 commit
>  - fetch: return when parsing submodule.recurse
> 
>  A config parser callback function fell through instead of returning
>  after recognising and processing a variable, wasting cycles, which
>  has been corrected.
> 
>  Will merge to 'next'.
>  source: <pull.1709.git.1712285542303.gitgitgadget@gmail.com>

Isn't this an example of a prefix collision, i.e. "ds/" points
to two different contributors?
