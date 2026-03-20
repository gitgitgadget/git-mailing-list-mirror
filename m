Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ED91D61B7
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773966271; cv=none; b=HL6AXw3XpHQ3FMXchGZtAWdEj/y1SA59SuAkP14tkcrSlft8GJ2NckO/wtLEZf7IHs/BmjqH4OXnV8k0AQVfAaEmNs9Eh/NQtKtf+4D4miP5vUYplSDDJRDWRbRjhA1+FZqgvM3oWKwX353dEn3M9oIInjE3BPl6oVaYM/JpnLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773966271; c=relaxed/simple;
	bh=8wlG2q4nrN5JI1bHYgty9toyJiDJGIjalweo80ndwfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9UXwtO107pYqqxFTXuBV70M6sT65QoAER7GCAC3tQLf1GYvIBknsm5KVEb/Jq9rrkyTtJ0XsT13amfF8/GIMlcJwoLXnsZechC9Uqp9CsJGHSj6pb1VyKt+Dbu6nOBjntWr2hEITRUS34OI2/Q5Z6Zm0juXGWTFa5h11RLVTjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=Ngrj2gLU; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=PZwGXCRW; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="Ngrj2gLU";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="PZwGXCRW"
DKIM-Signature: a=rsa-sha256; b=Ngrj2gLUTzr7MfG4l0z2MSWu/z1Ea6bMZXqStalE7bajmgUmPdmZC9SLRokU9WPssswbSd+vDA1BCVT7I/0cEGfr2V4corDvbXcPVOzgv6JerFQjJ+zkLkcWrjFihAUZq7BD2hzLk7J34uAyiU/7pd7OuseiAxY5IlERL8/wfzXkNf+9Fc/IideVZ5KgW0TpiyJ2+A7uZPEtn7PXHlDDq+baQ5GridQP5e3+tGEKiHS7ltvVben60kQLMSJr9l1JTsTmNUyGSVhvfCKQJkK89OnqmN8nv6am6uev2U45a5AW7BtLYG4SqD+7bXVghIxfMRltCj3N2rZokc9tHN5iGg==; s=purelymail3; d=malon.dev; v=1; bh=8wlG2q4nrN5JI1bHYgty9toyJiDJGIjalweo80ndwfA=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=PZwGXCRWy0ebAu/pjn6SuWseejbp2rfxcejCjrWEKkdBR0hhkyWmL+TQSOYaWil3Deqw3Z1V22BGc8Te9drA9qPeL3tUG1GvmlNIVXkBoA5WlBkhUvRRoPJb78zZQspZPkT7DLaJba6naELKHp6hVb/J0ktLeDnJMLSfejCztfsD5MpqBV/h/ArQxjNuKpQR5wLr3TaICtcyTPJ2tbz+aeQOAe+1PDaYp8t2Rp3vMrVEn06ua8ovdiXyEAInZLLjVbPryNIO5FIp6tiQHPXv1Ezipfh39c7M8uxkxizeAaBE5ArSJ2pe/2/AZHg6+vK9dveHN59vdH/tmo/L4LklKQ==; s=purelymail3; d=purelymail.com; v=1; bh=8wlG2q4nrN5JI1bHYgty9toyJiDJGIjalweo80ndwfA=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1913233344;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 20 Mar 2026 00:24:20 +0000 (UTC)
Message-ID: <00d622d4-cfb8-41ff-b2df-5fb58a492a75@malon.dev>
Date: Fri, 20 Mar 2026 08:24:09 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] check_repository_format_gently() is not
 side-effect-free
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Git <git@vger.kernel.org>
References: <c0bb931a-3ee6-416b-8ceb-9fab013a621e@malon.dev>
 <xmqqfr5vlmlu.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqfr5vlmlu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/26 02:07, Junio C Hamano wrote:
> The verb "check" does not imply side-effect-free.  By checking, each
> of these functions tries to achieve something, and the way the
> result of their work is conveyed back to the caller may not
> necessarily be only by their return values.
> 
> The adverb "gently" in this codebase typically means "the variant
> without gently signals problems by dying.  Instead of dying, return
> to the caller with error code, so that the caller can decide to
> die".

Ah, I see. I guess I took it too literally. Thank you for clarification!

Setting the semantics aside, the problem remains: I still think the 
setup method here isn't quite right. It creates a bottleneck for 
eventually handling multiple repositories in the same process without 
data races.

Do you think this is worth a patch?

Thanks,

Yuchen
