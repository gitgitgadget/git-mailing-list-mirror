Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4960E4F881
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769439162; cv=none; b=ZpQN7tWRLF1WxcuPL6QpkO06xnMZYJRNPKaxZeMo2u/2WEXQWJS9dFyPNZPEqDn4yVw0HidyItc2kg/bQUCPDBXKW5kqBvlI0o3nyQImFYCbbKqMPpX8Pa5mlQt8hyLCbLYFDnM4hYtGv149o6Gq1MOwFvQPVDiggNV4IHd08T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769439162; c=relaxed/simple;
	bh=v6nG50gUKwhcelIvFyccckfbG2v4uOCRg0vWm6Hhejg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zn5jY2SuUN5lbda7D+NbTVpgPF5aYhpU3CctCmEDwHqMGSNg5IWMIAu4yLJXAgq/RFLZHImiOZCsMssWnLJeLhlRm/HnAb5Ka9c+rVRqKC48M0jnPmVlmPpKuNoOWwha9K4No4grMlQQ0sJTFReHFEeCUarVSgNy8f3lVTcbpqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4f0BN62vp0zRpKv;
	Mon, 26 Jan 2026 15:52:38 +0100 (CET)
Message-ID: <5ab10a31-8ee5-48f9-a5fd-63c6d7f4adcf@kdbg.org>
Date: Mon, 26 Jan 2026 15:52:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] diff.tcl: fixed alignment of tabs in git-gui diff by
 using spaces
Content-Language: en-US
To: GitHub Chris Idema <github_chris_idema@proton.me>
Cc: git@vger.kernel.org, Chris Idema via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com>
 <01d0faaf-99fb-42a4-befd-bb7f359809bc@kdbg.org>
 <Lj9kojJwK1ZAtvE5nj6rTq5EXf1-QhsRlmBDM9YntbYeWb3J07mlbM-njNco2XT1pSPXsNVbo9Uc5kJOHihb11odjthYN4YtuhVdNwxSIqk=@proton.me>
 <07014d88-67ed-498a-8cc1-423c77972fd7@kdbg.org>
 <sYbEiapPid30QZ89paQ6hF_v4BjKnAqUTOt_ImBEfFYBlMVU9uoGwZbKqSkk7aZVxGPrqVXbb58Ogppnw0gQEbH1gwRfBmx3HC2AECWjGkY=@proton.me>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <sYbEiapPid30QZ89paQ6hF_v4BjKnAqUTOt_ImBEfFYBlMVU9uoGwZbKqSkk7aZVxGPrqVXbb58Ogppnw0gQEbH1gwRfBmx3HC2AECWjGkY=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 26.01.26 um 15:43 schrieb GitHub Chris Idema:
>> So, you mean that if the tab width is set to 4, then the tab stops
>> are not aligned anymore?
> 
> Indeed. It's probably due to the + character shifting everything by 1 character.

BTW, this isn't a problem with a particular tab width. It happens with
the default width 8 as well.

>> My suspicion is that the patch text does not match the actual file
>> contents, and so the commands fail.
> 
> If you select and copy the text from the window with you mouse it
> won't match the patch. I didn't know people used it that way. I use
> it as a way to review my changes before staging.

I don't mean copy-and-paste. I mean the context menu commands. They stop
working (I suspect). This would be a show-stopper.

> I don't know if there is a way to make it that when you copy it will
> copy the original text and no the modified text. If not then we
> should come up with a better way to align stops.

I am not particularly fond of such a change. Years and years of reading
patch text has trained my brain to expect such misalignment to the
extent that even the absence of misalignment can sometimes indicate a
whitespace error.

-- Hannes

