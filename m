Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF91A937
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757747097; cv=none; b=fwXstOSxdMO8AxTvwlAB8bXon+dRDcieWTkx7yqDT5Artal+TniUgLt8ULhcd3UYkLexitvBBC2lUWeoK3o24jASHpVjsnqvPufTO0YyUF/G6gNek5HeDXDdYeYXboEVPqxnOaWh5YHd/ANYak3IXE0xxcxJlhtoLmhrfVcusxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757747097; c=relaxed/simple;
	bh=prH14jtzfoyssAJGUCyzNTOmlgj5DjvTdOBG9BY6yq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=aMLGlejSk7WgYitABN2luySv+3wiE7UfxmjLiTndXcwQDH4PhUW7JVh1onfWGtu29B9slJrED+tadGk9wfHlYB00WTPrNxBCmVS0NyMMOMJHraJVdu78X+ZN1xrKaha3Z+jvxhkmx7+d47/aGDoyCh235T2yvNR/vtB/FlGfZcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4cP2Ng4hR9zRnmF;
	Sat, 13 Sep 2025 09:04:51 +0200 (CEST)
Message-ID: <a5e01f0f-1789-427c-83c3-90644fa234c9@kdbg.org>
Date: Sat, 13 Sep 2025 09:04:50 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] mergetool environment variables
To: rsbecker@nexbridge.com
References: <074901dc2422$2039a910$60acfb30$@nexbridge.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <074901dc2422$2039a910$60acfb30$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 12.09.25 um 22:16 schrieb rsbecker@nexbridge.com:
> I am trying to integrate a custom mergetool with a shell wrapper.
> What I get from the online help is the following description referring
> to the command and environment variables.
> 
> mergetool.<tool>.cmd 
> Specify the command to invoke the specified merge tool.
> The specified command is evaluated in shell with the
> following variables available: BASE is the name of a

Take note: this talks about "variables", not "environment variables".

> temporary file containing the common base of the files
> to be merged, if available; LOCAL is the name of a
> temporary file containing the contents of the file on
> the current branch; REMOTE is the name of a temporary
> file containing the contents of the file from the branch
> being merged; MERGED contains the name of the file
> to which the merge tool should write the results of a
> successful merge.
> 
> When I try to use this from a shell, simply with:
> #!/bin/sh
> env
> exit 1
> 
> the described environment variables: BASE, LOCAL,
> REMOTE, and MERGED, are not present.

Look at the scripts in the directory mergetools/ and note that they are
only (large) shell code fragements without a shbang line. They are not
even executable.

-- Hannes

