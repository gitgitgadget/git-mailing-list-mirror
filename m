Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8159133987
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742142109; cv=none; b=LSE5KvATq8uT6NHl082jgTiVYwG5Yyag9IbF2bJEzBU4yCpxwSoHadc3SYMOroUL2AQ6FgfkdDU6KHyoYkrKrVrvrL5E1O2A8tAaxM9OIUUiA8P5NgrL8IiB5MzPak0/VoXf1dV3YRVPUda1w3Opa5ipL7hJLIoG9NER2p6H1EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742142109; c=relaxed/simple;
	bh=QTbLtqDKezZXG9QdJUXHnpb4pPi5NBPfgbz7x5aTu0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZfqvtr2bpAsjPPBGUeXYjxd3GD8wassCwLgv2yh0EmBQfkcpU2OpsAvM9xdIzAnai448troGBZVi0RYyDPqaFHq7cq9Nwuf06t0Jc2G45nRFlK1EGEC2Fh3tOUhuUFUsA9TFdx5uxoYq58Cc8Bal9l2QzyVn7QLvcZq7MkMUG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4ZG3Jm4CkTzRnlK;
	Sun, 16 Mar 2025 17:21:44 +0100 (CET)
Message-ID: <53c5aed4-ce4f-4ad7-8e90-a97fd3c973cd@kdbg.org>
Date: Sun, 16 Mar 2025 17:21:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] gitk: added external diff file rename detection
Content-Language: en-US
To: ToBoMi <tobias.boesch@miele.com>
Cc: git@vger.kernel.org, ToBoMi via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1774.v2.git.1725607698680.gitgitgadget@gmail.com>
 <pull.1774.v3.git.1741093275742.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1774.v3.git.1741093275742.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 04.03.25 um 14:01 schrieb ToBoMi via GitGitGadget:
> From: Tobias Boesch <tobias.boesch@miele.com>
> 
> * If a file was renamed between commits and an external diff is started
>   through gitk on the original or the renamed file name,
>   gitk was unable to open the renamed file in the external diff editor.
>   It failed to fetch the renamed file from git, because it fetched it
>   using its original path in contrast to using the renamed path of the
>   file.
> * With this change gitk detects the rename and opens the external diff
>   with the original and the renamed file instead of no file (it is able
>   to fetch the renamed file path and name now from git).
> * Since git doesn't destinguish between move or rename this also works
>   for moved files.
> * Showing the external diff with the original and the renamed file
>   works when either of the files is selected in gitk.
> 
> Signed-off-by: Tobias Boesch <tobias.boesch@miele.com>
> ---

I've picked up this patch, but haven't found time to look at it in
detail. It will take some time. Please bear with me.

The commit message would need to be rewritten to match our usual style:

- We do not use bullet points for normal text paragraphs.
- We describe the status quo in present tense,
- and then the changes in imperative mood. (Like, "code, become so!")
- The subject is not in past tense, but usually also imperative.

-- Hannes

