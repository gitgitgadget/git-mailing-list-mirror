Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A38C2D739A
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 06:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762497472; cv=none; b=hHZ8YH4aqRRvIGzJBYC0q+h+k86m8kNsjwtciLg0M7SeG+ves+x/Nvi5ClwbtUmgU2mzR7ncAex9A9ulXxPIcPDwxAfAQuHM7hJUSEvsuC5CIJqI5k4KVX1Gk4OiA7bkhVUx0GedN0Xx76B6N88WjJppKNFbqSRBb75oKzFYOEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762497472; c=relaxed/simple;
	bh=jJJWLDG0RsNL+tUw42nvcTEem7+qQlJPQYlgXmTnVo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Elw9GhRW0LO0SD0g/EjDNA811G5zc5sZd5Bk1JpAV3S04bomxnOkbKFP8NrNkRomELxnlWPomV9Hl9snqusZXee0gCPHPtu5N9iCB1pyQ3LDFLj8WMjDQn8+Czf7bxoVe3EpemlXLyhC6qVxsoT4TD18Bj9jiVWNTWi0P0oq7no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4d2qB24dnqzRpKv;
	Fri,  7 Nov 2025 07:37:46 +0100 (CET)
Message-ID: <e1fede83-bed0-49e9-84a0-f026b9df6039@kdbg.org>
Date: Fri, 7 Nov 2025 07:37:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug report] git cherry-pick silently ignores error whereas git
 apply fails for hunk apply
To: bhavikdbavishi@gmail.com
References: <CAEyHQXWd77_jJachC6FYbWMJ+L=KkKoUqiACQ7z8r-ZwYq8JYw@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <CAEyHQXWd77_jJachC6FYbWMJ+L=KkKoUqiACQ7z8r-ZwYq8JYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 07.11.25 um 05:39 schrieb Bhavik Bavishi:
> What did you do before the bug happened? (Steps to reproduce your issue)
>> ran git cherry-pick command, which went fine without any error, but missed to apply change
>> created patch with 'git fromat-patch' and applied with 'git apply --verbose', which error for the issue
> 
> What did you expect to happen? (Expected behavior)
>> git cherry-pick should fail, since it failed to apply hunk
> 
> What happened instead? (Actual behavior)
>> git cherry-pick completed successfully without any error
> 
> What's different between what you expected and what actually happened?
>> git apply --verbose, failed with error about the issue, whereas git cherry-pick didn't fail for the same


If you use `git apply --3way`, does it still fail, or does it succeed
and does it produce the same result as `git cherry-pick` or a different
result?

-- Hannes

