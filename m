Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D766D2D6415
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073712; cv=none; b=ul1mpsc0/ggyBqaLLxo9NqCbvr3B5QEZqiimB84JKt06Xyv6lE+WDDQs8rDBQbml8x8x4+XHSsN+WoQbA5JbkSjzngYyjN7bat/CxbUkxZlMVi7Ay92X2GIHhGf0P33Z7OpcRT7c8IywtvAjVvolWzx1TScsv+sOFl7gRKQyNtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073712; c=relaxed/simple;
	bh=FJCh6UugJEbixnlByIyDaImdcrJToFwOhnIoP/ySmns=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=hPvvRhdJZFpgvUh0EMjUkZQxW2a4T6WxhDR4SCvdWFZomZWoc3B/75FJ7kudLTJvWvaxoFvBKgVwcloiaRfCCkxxRHdPedO/bT+ThAx+hjO47K8Z8OobEnAHrJAjs3Zg0S1wu+b4LgFdyuX14olmrm7kcP7kOieAnnQhTA30dzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.101])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4bchF86WpDz7QhKK
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 17:08:28 +0200 (CEST)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4bchF05BVTzRnPp;
	Wed,  9 Jul 2025 17:08:20 +0200 (CEST)
Message-ID: <a6c5d181-5cdb-4070-96a6-cf88c3a5c838@kdbg.org>
Date: Wed, 9 Jul 2025 17:08:20 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with gitk
Content-Language: en-US
To: Nicolas Ratier <nicolas.ratier@femto-st.fr>
References: <d3ab5bcc-6f71-455c-933a-a63a9b39e8b9@femto-st.fr>
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <d3ab5bcc-6f71-455c-933a-a63a9b39e8b9@femto-st.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 09.07.25 um 12:23 schrieb Nicolas Ratier:
> I have this error with gitk :
> 
> $ gitk
> 
> and inside the window of gitk :
> 
> Erreur à l'exécution de git log :
> 
> wrong # args: should be
> 
> "safe_open_command_redirect cmd redir"

You are suffering from an incorrect backport of the recent security
fixes to a Git version before 2.43.7. Tell your maintainer to look into
this. I can help if necessary.

For example, see here:
https://bugs.launchpad.net/ubuntu/+source/git/+bug/2116253

-- Hannes

