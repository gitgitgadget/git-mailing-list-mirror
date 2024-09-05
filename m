Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2F217BD6
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725554370; cv=none; b=I3Ex/Eq525gxJ9VQs3q8qxP47jedORzkJemsikc2N33RWkRZXjTi7WNfS4zVn5JS4ux3cs9Zb3LFQgS6XR/bTmKjjNErAThI9eyII0fzb1NKCLiRyb6PzESXtNlEY4HtdgHSVpO7yLuMr8u55HpkM+2oxwLihKocUIbVRf4+QT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725554370; c=relaxed/simple;
	bh=ryIUlJck50zIOfLHT3+C6OtcqC6zaQPNSjq8oDyDYsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=E9PhY/n6eYflm09M6ox9roQ2+jsB7/rJrb98oJM361pbZgUIalvLfq7uVZIfg06NAznj6MNs+5zJ/dRNDXcN2QzohWtFiEwXV40yz7fxcokjeUXaJLn8DxWy5kac+mHc5MACPfiSyXBFV7+FzGld4SGZGI/pCcfcIqtUNkW2uTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4X04nn22XXzRnmN;
	Thu,  5 Sep 2024 18:39:24 +0200 (CEST)
Message-ID: <cbc0019a-682a-4cec-8a06-24b12060a692@kdbg.org>
Date: Thu, 5 Sep 2024 18:39:23 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How do git recognize conflicts?
To: KwonHyun Kim <kwonhyun.kim@gmail.com>
References: <CADLV-7K-D8ydFfeojv7EuhxBqKWsVYLofXJji+Y5rUTA8JEQ7w@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <CADLV-7K-D8ydFfeojv7EuhxBqKWsVYLofXJji+Y5rUTA8JEQ7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 05.09.24 um 16:10 schrieb KwonHyun Kim:
>  Hi, there.
> 
>  At first, I thought it's determined by line.
> 
>  But as I experimented, it does not look so.
> 
>  Here's what I experimented
> 
>  merge-base ====
> 
>  hi all
> 
>  branch BrA ===
> 
>  hi everyone
> 
>  branch BrB ===
> 
>  hi all
>  good to see you
> 
>  when I merge BrB from BrA, I get conflicts.
> 
>  but the first line is only changed in BrA,
>  and BrB added a line so there is no reason to have a conflict...
>  that's what i think

If the changes in the two branches are in adjacent lines, then that is
considered a conflict as well.

-- Hannes

