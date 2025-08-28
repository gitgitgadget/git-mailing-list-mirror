Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7934422538F
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756416772; cv=none; b=m4Lh5ngwj9NHcYjB1xdAaexdWbV7Y5A9dIIlFluFEj/WG0dT/SxXXxBG2BbQl80V2jPd2JvRpBRimjU7VDU4VUvXIZeKNGeI1v9N+iHh0sYQXY+JYD9ClkszdkfkpSK9YdQLqvfhmtCQf/8n6nkfZCSBmHqhBdfpVZN1xxZTFWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756416772; c=relaxed/simple;
	bh=YhE+CQfNkRVPgSAm1e0RypFobEXjh2lNdSLG3ky7Owo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=bKssyqJy+NyrZRnhJZo6EKuftyTqXA5xbwoEirIMp+3RiEBEDswzfUwQspbbSmjTEJE5dnI0Bbd+od+0Z4c//nPba7krsmn1UeN/0IcS7OLiQwGwEydn3jpuz6hmJN+grW0jhqN6C4/0fbjdq6Hwg4E4dHE+VK+SRUxfeKw/juA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4cCZPW1SlRzRpL2;
	Thu, 28 Aug 2025 23:32:46 +0200 (CEST)
Message-ID: <2005fae0-5991-41e3-a1f2-4625086de7b3@kdbg.org>
Date: Thu, 28 Aug 2025 23:32:46 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: gitk bug: Disabling "Themed widgets" breaks preferences dialogue
Content-Language: en-US
To: Mark Hills <mark@xwax.org>
References: <075a1389-c5d6-18f4-ed19-13b0041dbbd0@xwax.org>
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <075a1389-c5d6-18f4-ed19-13b0041dbbd0@xwax.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 28.08.25 um 16:02 schrieb Mark Hills:
> I use Alpine Linux 3.22 (latest).
> 
> Recently gitk's preferences window refuses to open.
> 
> This seems to be a direct result of switching off the "Themed widgets" 
> setting, which is my preferred choice.
> 
> Error message:
> 
> invalid command name "::combobox"
> invalid command name "::combobox"
>     while executing
> "${NS}::combobox $page.wrapcomment -values {none char word} -state 
> readonly  -textvariable wrapcomment"
>     (procedure "prefspage_general" line 41)
This bug was introduced by 904b36b815ff, which is in Git 2.48.0 and was
fixed by daa364cfb7a1, available since Git 2.50.0.

-- Hannes

