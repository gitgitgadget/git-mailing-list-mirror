Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9751946DF
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763244090; cv=none; b=sMwwj6Yxt+N/oqcCJZcBSnycqM1fuCSedovMh+5dj9gsXHIMZv4H4XLe3FdqRLy2MC59f3p11WFRr/ar46bSgSlLfBpb6yxqJa6KWrZ0c/BmTMZrL6Jp8XkpbVZfrLbKMZg7+5rUB57Kg8I9V0zStolWZ4IIAWZsRwKpK+gvJy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763244090; c=relaxed/simple;
	bh=gSsrTUqWqfS5/fVhyTL2Su+t8TlYyA4asHJr0Wn72m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=oar/2hI2mApevXIwue1Y0HKrQcbK1cvpFJFKJagdc5nrBFvdWnZQ0OLU4MA8u8pCRvf30fQVNuR6/W0fzNp/Jq8QsYY/5aYTu0zt94V1wV91ANcP2X3jN6sYhqj1eghxEAgu6ndF+6MfXK6dLQmIjFglBdaAQ+2JYIcZKlw5poY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4d87J557bKz7QZM9
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 23:01:25 +0100 (CET)
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4d87Hw4bLpzRnlK;
	Sat, 15 Nov 2025 23:01:16 +0100 (CET)
Message-ID: <c70c4605-8c14-46b1-89c4-736165432d07@kdbg.org>
Date: Sat, 15 Nov 2025 23:01:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ref list fails to load in gitk when stale tracking reference
 exists
Content-Language: en-US
To: BhaaL <bhaalsen@gmail.com>
References: <CAJESqkrv9RmimXn+6SUhRhih3qEsp_MQk0+BH2FZsFX-_uD1oA@mail.gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <CAJESqkrv9RmimXn+6SUhRhih3qEsp_MQk0+BH2FZsFX-_uD1oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 15.11.25 um 13:33 schrieb BhaaL:
> This error message:
> ---------
> can't read "headids(remotes/origin/testing)": no such element in array
> can't read "headids(remotes/origin/testing)": no such element in array
>     while executing
> "commitinview $headids($upstreamofref($n)) $curview"
>     (procedure "refill_reflist" line 16)
>     invoked from within
> "refill_reflist"
>     (procedure "showrefs" line 44)
>     invoked from within
> "showrefs"
>     (command bound to event)
> ---------
> 
> remotes/origin/testing is a branch that existed upstream, but was
> since merged and deleted.
> The local one still exists (pending deletion/cleanup), but has a
> tracking reference
> in .git/config:

This is fixed in the gitk that is included in Git v2.52.0.

-- Hannes

