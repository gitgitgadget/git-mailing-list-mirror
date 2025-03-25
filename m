Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9C8254B1B
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.233.160.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742904752; cv=none; b=XS2F2ZWDKdMWjbQj6XoIWZlVjX2pLyYTZ49W6OsIAunux1AZ2UL3NBqtIT8w+MSJfBqhXd2ObAYEqb1LHUk0rL9pebfTWKpdjQfaHYwnkDtj7bXYza8P/YaerkPlABbphyWdSfAUMsamV38glSv4MvawZ2KpsU4GoxtbDbPvgCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742904752; c=relaxed/simple;
	bh=8INNi3Jav/E5xRM2ieXnWHSR/HW+hUlEb/8yf1RUKbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwS3nlRJhemhHFxZ2uTZx1jAkCGbUJXHeq+xspNuoCM0stl8I/gepRCbPSv2sIEsDm5kl05l0VcfnwZGHycBJdFpOVsmmAxn58VkJMgeJu53L6L9/HrPFxfamtAokX9QLOoCpVARmggOSr470jCNETb1aF074Dw7f130kMcHf6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iee.email; spf=pass smtp.mailfrom=iee.email; dkim=pass (1024-bit key) header.d=iee.email header.i=@iee.email header.b=TUyDfE89; arc=none smtp.client-ip=85.233.160.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iee.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iee.email
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iee.email header.i=@iee.email header.b="TUyDfE89"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
	s=2025022500; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=8jqmmwUIh+rMnhbl5MkpA5jDv2uIwV1jQ+xo2P5o3mA=; b=TUyDfE
	89cUtAa6B4AxC3HmWI0i46bpp6VKJD49zAsTxP6cRLeiEPmGRGTnAFp2yahReowbgIUemR1ouDEBG
	r39ROjP6TWDR8uV3h2mAYzVi59i1kAtV3qlO7GjUdUahpyc1EA80v7UinUdHSdfjKwmXuzhluoVSB
	HrNWgWwnuLY=;
Received: from [81.170.127.79] (helo=[192.168.1.112])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <philipoakley@iee.email>)
	id 1tx2f6-000000003rX-8JFN;
	Tue, 25 Mar 2025 11:41:42 +0000
Message-ID: <f30d8ac4-4748-4b73-b86d-6f85c9bac622@iee.email>
Date: Tue, 25 Mar 2025 11:41:40 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Avoid the comma operator
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
Content-Language: en-GB
From: Philip Oakley <philipoakley@iee.email>
In-Reply-To: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2025 08:01, Johannes Schindelin via GitGitGadget wrote:
> The comma operator
> [https://en.cppreference.com/w/c/language/operator_other#Comma_operator] is
> rarely used in C anymore, and typically indicates a typo. Just like in these
> instances, where a semicolon was meant to be used, as there is no need to
> discard the first statement's result here.

Minor aside: How were these 'discovered'?

> 
> Johannes Schindelin (2):
>   remote-curl: avoid using the comma operator unnecessarily
>   rebase: avoid using the comma operator unnecessarily
> 
>  builtin/rebase.c | 2 +-
>  remote-curl.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1889%2Fdscho%2Fcomma-operator-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1889/dscho/comma-operator-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1889

Philip
