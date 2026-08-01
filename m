Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73831145B27
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785620430; cv=none; b=st0amGUtmAszuEgp1swGvDFO8kIksZqltQ/eCzc5uz2SRpD3L795k5LxNLqgiwrpMV3brt9IN6cgoIKg+3oMfVIwRUtD/JJ6o2eoeDiLgcu90xrk2KPIOR+69gimWnhCEITDTzgpl5C9uFphhBJjx4JeL2HjVcR+Wg4bZzvfE+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785620430; c=relaxed/simple;
	bh=KLkQTku/x8sQhSOJMzZt0yMbt0l/vBKLxubQAKsd/Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=IM2AfxHSDEw1Buapo0DreWoSlV7YVFn+fQ88ZbrZtQB6mCBnowqPI/p2JzipAM/niqPH875yYjAqW8jBaKXq0wixVBeDN0xkGuQFUUeRdwHN78XUY9bX0oxBIm07T3Sr6eytQjxB83wcPZMzfVfqaRx8E6zUYQBWoVkSmjZYBAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4hCFpH6C0mz7QgGY
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 23:05:43 +0200 (CEST)
Received: from [192.168.1.102] (213-225-9-246.nat.highway.a1.net [213.225.9.246])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4hCFp628RhzRnlV;
	Sat,  1 Aug 2026 23:05:34 +0200 (CEST)
Message-ID: <48771457-9f10-4176-897a-f8af2606bf2d@kdbg.org>
Date: Sat, 1 Aug 2026 23:05:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git trailing blank lines feature configuration
To: Thomas Nemeth <tnemeth@free.fr>
References: <5097209.GXAFRqVoOG@cixi>
 <06230920-FCA6-495C-BFE5-04DF1CC2A426@gmail.com> <3433010.aeNJFYEL58@cixi>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: Ben Knoble <ben.knoble@gmail.com>, git@vger.kernel.org
In-Reply-To: <3433010.aeNJFYEL58@cixi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 01.08.26 um 10:48 schrieb Thomas Nemeth:
>     If I need to move a previously static function at the end of the
>     public functions section, I switch to VISUAL, select the function
>     to be moved with the blank lines above (I like having neatly spaced
>     code) _and_ including the eol of the function last line.
>     Then I delete it (d), I move to EOF (:$). As the line is blank I
>     just have to paste (p) it back there. The function is moved. The last
>     blank line is kept for other code movements.

Sounds like you are using character-wise visual mode (v) instead of
line-wise mode (V). Use line-wise operations, and these problems are gone.

Oh, and BTW, just use G instead of :$<Enter>

-- Hannes

