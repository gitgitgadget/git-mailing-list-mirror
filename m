Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A982E20D500
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525668; cv=none; b=K2SZQuZzp4oFulqkSL1rvGYeTPrvd6dKfjcAPS71EI/JcSw37dUWZ/G+zVOL2uLsZag+pHpNz7UVlxa96LqPbZM2e4FbXAsA9MLqhqinLjOfdNjKFsr9tbabO674u+voZOCYPB8fmoCNkYh05HMgXNffjWO9Y8vrlkY79c98FUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525668; c=relaxed/simple;
	bh=iYTOupbdLPdqyo1bG2njiEIKawAkP5pRx6f+M3i6/Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZ+spenddepVXCJyvFKY2c+FblWlrvBPZO0vmZkRldbMtCODT9HctXu5W9Y75Zh/UHxUXEqq8RxqL0JQutHkppIb5QPloHIueMby5+qKVhlr4bVjtiGZqI+s/EVVZzHX+pcTrYaS0eSrwRF906quJ7Kb6zKfL5bE+EsZHCRu4jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.106])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4ZRtzb4sPfz7QhTm
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 18:40:59 +0200 (CEST)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4ZRtzR4f2yzRnmM;
	Tue,  1 Apr 2025 18:40:51 +0200 (CEST)
Message-ID: <fb2e237f-c458-4dfe-a1e9-48b981402ab5@kdbg.org>
Date: Tue, 1 Apr 2025 18:40:51 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] gitk: override PATH search only on Windows
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
References: <5b09f1c2-be58-43a2-9908-7243b5207251@gmail.com>
 <20250401030102.297272-1-mlevedahl@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250401030102.297272-1-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 01.04.25 um 05:00 schrieb Mark Levedahl:
> Restrict overrides of exec/open to Windows only, as
> the need for this is Tcl adding the current working directory
> to $PATH on Windows. Recent modifications to this render
> gitk unusable on Cygwin, isolating these overrides to Windows only
> both fixes that breakage andk reduces the liklihood of similar
> issues in the future.
> 
> patch summary:
> 	1 - modifies the existing code to restrict the overrides
> 	   to Windows, restoring other platorms to native exec/open.
> 	2 - remove now superflous variable _search_exe.
> 	3 - fix the override code to avoid path search given a
> 	    relative path like foo/bar.
> 
> ---
> Changes since v1 - fixed commit ID reference for git-gui, otherwise
>                    improved commit message in patch 1.
> 		   Added patches 2 and 3.
> 
> Mark Levedahl (3):
>   gitk: override $PATH search only on Windows
>   gitk: _search_exe is no longer needed
>   gitk: limit PATH search to bare executable names

Thank you for following up. These all look good. Patch 3 is a good find!

I've inserted a patch 0.5/3 that replaces the existing TAB characters
with four SP in the indentation.

Thanks,
-- Hannes

