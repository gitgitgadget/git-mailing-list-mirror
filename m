Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C3513C802
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 06:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950378; cv=none; b=VYCheNU2yKrLr18JP1dVamETIttHTAdUmod5xE9a9zcotXpihwr6/xMjX1WjOiz+Fl76bmi+2zCa+nnYREbGlUhKu9D9lqVwHr2NNVLaQDbskhx2nwpegcJix/NCJ/8EVkNMkSpUywh/Ib29YJ2IBca0OxqXhj8uZLAunTlvOq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950378; c=relaxed/simple;
	bh=o8P0YsHF/34X7FAfLWSjjQVfE4VncO4G21mFyb8J31U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9kG+Ifz7NqXS2OC0lY/7Fxs1sDQnrCvbfVG7wF9YXLCnuO9AwCemTTUasMajw4WNEki5rkF9TLmraj13RFB87rrYISsRGOj7M9SgiRyEBNwMD502aOCSF9pnj76aB/aaREv5TKlzzEIbnYUewE1DLMpD197A9cWZjSXn82BoBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=DEnUfRQA; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="DEnUfRQA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202402191026; t=1718950372;
	bh=lF9IRqxE6/mHXbmZ2+6RBQXT7HFE9E0d2GwszRDbdqE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DEnUfRQAAAOFKjiU/8YtcmTEEBgsIdIgLIxSvBoxrj5Hn4cl3eqPew/IuvCqRfNcC
	 eztnzvFJBtrgQA/LwslvQcE7Q+7t1qpKvj5zxFQFvNCfsYpOAkSNuiJUHYE1plQjBr
	 fUN/bsNY2+9PaoDUTljVeCnK3iOxijuzZ9VmwtEIO6+DlMj0ax8WQC1fo4+QKO6f8O
	 o38YbWiqYVLdrWvRPRmcMAJMj3qzN5gskox8yiY9/CEVTirbhKVMqz1FCVSu4t8yfU
	 vCbklNJ3/mc/70wLx5IUJv3RZ4/O6jV/lZnEkXGIL6gZl6V22koSRwZwXXg6cV4eDI
	 /5JrrYkzoXrSQ==
Received: from [192.168.42.22] (i5C74DC1D.versanet.de [92.116.220.29])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 4C6A23C1193;
	Fri, 21 Jun 2024 08:12:52 +0200 (CEST)
Message-ID: <8fcf1aa4-6c80-4d66-ba95-0cbbfd67540a@haller-berlin.de>
Date: Fri, 21 Jun 2024 08:12:51 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git-gui: Visualize * History does nothing on macOS
Content-Language: de-DE, en-US
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Ilya Kulakov <kulakov.ilya@gmail.com>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
References: <38A18180-3CC9-411B-B5D3-36C5C32B6EE9@gmail.com>
 <CAPig+cS1o5bqK2Ph1fFt2wi6QaOO2=83xwoqoTLifA6z3NssXA@mail.gmail.com>
 <41408b88-2938-4112-a02c-53876e20f5b1@haller-berlin.de>
 <CAPig+cTaBxoJbsVsZLYLZueZpSkmt2zRJzgE=HOO30FvxpUUnA@mail.gmail.com>
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <CAPig+cTaBxoJbsVsZLYLZueZpSkmt2zRJzgE=HOO30FvxpUUnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: +

On 21.06.24 06:35, Eric Sunshine wrote:
> Unfortunately, it seems unlikely that either my 2018 patch or your
> suggestion will be applied since the Gitk maintainer seems to have
> disappeared(?)[*].
> 
> [*] Interestingly, I just checked git://ozlabs.org/~paulus/gitk and
> noticed that changes were applied as recently as 2022-02-20, however,
> the patch I submitted was not one of them.

In 2022, Paul said [1] that he would be willing to pass maintainership
to somebody else. Johannes, now that you volunteered to take on git-gui,
could you imagine doing the same for gitk? This would be awesome.

-Stefan


[1] https://public-inbox.org/git/YntxL%2FfTplFm8lr6@cleo/
