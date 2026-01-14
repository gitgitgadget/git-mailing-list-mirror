Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849B2330D32
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414289; cv=none; b=SmHTOAzp12T4reBwKNig8gbETLoBtZ41m8hutHcS0nLG0h67Uf4LYuOBR/68eJ7CdR1RI/2cYLXufOOHoyW0dz3yTByMfYbdHJZ2yteuI71l45GXD0PLC1LZjSznr5ht5HvZsfbQnECPqkty0hwSE92oiEa7W3aJ+CA6Io+vfk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414289; c=relaxed/simple;
	bh=JUwIhQ4nh2mOsm29ZoSisziBgt3+rd+/5A3Jv/aUf8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OgEjF8CPZbGgdGQ/erDQC4wclUb4VMuQaB1QyHde9dlpkKn0WXG2JFEw12HMt5eZhVm60jjRqSBBkPI6DL8P2Hb2QDfLz1q80AUC+awPxcedGzfns/tk/COdwoez7jXIKB5gxIfDVEBm9Qg/MCQ+x303b5B1I92fiQo9Hr4j7ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4drvM01hNCzRnlX;
	Wed, 14 Jan 2026 19:11:24 +0100 (CET)
Message-ID: <f55a85a0-fb57-4911-bd60-cf863da5436c@kdbg.org>
Date: Wed, 14 Jan 2026 19:11:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitk: use config settings for head/tag colors
To: Shannon Barber <sbarber@dataspeedinc.com>
Cc: Shannon Barber <sgbarber@gmail.com>, git@vger.kernel.org,
 Shannon Barber via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2030.git.1768285721660.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2030.git.1768285721660.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thank you for your contribution!

Am 13.01.26 um 07:28 schrieb Shannon Barber via GitGitGadget:
> From: Shannon Barber <sbarber@dataspeedinc.com>
> 
> The drawtags procedure currently uses headfgcolor for all label text,
>  ignoring the tagfgcolor setting.
> 
> The call to create the outline polygon for (non-tag) heads currently
>  has the color for headoutlinecolor hardcoded to black.
> 
> This patch maintains the variables for the non-tag refs so that heads
>  are colored differently from non-head (non-tag) refs.
> 
> The outline and fill colors for the non-head refs remain hardcoded to
>  the prior values, black & #ddddff.
> 
> Signed-off-by: Shannon Barber <sgbarber@gmail.com>

In this project, the author and signer-off should be identical. Please
choose one identity for both.

It was very hard to figure out what the patch attempts to do. The commit
message wasn't very helpful, I am afraid. I would have appreciated if a
short summary of the status quo at a high level had been given. For example:

--- 8< ---
Gitk draws ref names with 4 different styles depending on the type of ref:

  - ...
  ...

The styles use variables that can be set in the configuration file for
..., but hard-codes the style for ... But there do exist configuration
entries for ... but they are not used. Replace the hard-coded values for
these latter ones, but leave the remaining styles unchanged.

...
--- 8< ---

What is also missing is what the implications for users are after the
change. Clearly, the settings stored in the configuration file are now
heeded. But what happens for users who are unaware that there are
settings (since they are not accessible via the UI). Are any observable
changes intentional? If yes, what is the possible impact?

BTW, the paragraph indentation is a bit odd.

The patch text looks good.

-- Hannes

