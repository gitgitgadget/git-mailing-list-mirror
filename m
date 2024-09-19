Received: from binarylane-bailey.stuart.id.au (binarylane-bailey.stuart.id.au [203.57.50.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EA413B2B1
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.57.50.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726740995; cv=none; b=iyL700tarocPJAY7xIBrzaPwcpiwxQ7H/KUAPaazTKyFKd0QiXWISE5MKMZ1ac2GpZb84WoHUIOHAEmN8X2KIRcLYeXx/zEkKg/NN3W1UPybheJPr5YextnARoiHfC5HqzN9wCuzCNwO4/6aYgn+cmtH+LQzAEO1YYVmF2kPfUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726740995; c=relaxed/simple;
	bh=EmSkErX9rA1x2b/X1faJfUSkE4v88L3EjtsPuNvIKCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7XO0KCTL0v37MbdSYeNn7F5tsiSWzF0T1idd0cB/pQZnvmgvNXsdO9MTSP5woAdrjLQXCABCHX12BLgesLqB9E2ygLwsbrT1kyitRYJz/BlBHtcKqPM1Jjoc/cQ3rF29UJpdV3Z+iiz3SsvotG5+XTM0OREWRG8XcuFmfAPcwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stuart.id.au; spf=pass smtp.mailfrom=stuart.id.au; dkim=pass (2048-bit key) header.d=stuart.id.au header.i=@stuart.id.au header.b=co630kgS; arc=none smtp.client-ip=203.57.50.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stuart.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stuart.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stuart.id.au header.i=@stuart.id.au header.b="co630kgS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=stuart.id.au; s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=d5BSiGBeme/pIy5PRFBi8UqwFiwBwEJNIdMODikKQ/M=; b=co630kgS6G/Eib83itcjLihMWg
	pjPiM1d7THLvb/jEO3x+vwL9btTu+EzQ3eQCKHHBHgU0GoBWn1F4qSJuuAy2BDS/EcYh7gJ/3FNJJ
	WCiahjP9/slEyRf+rfe/36wKbLzAUI6+4pgK9ntnCSzWE7tWk4ROdh9TBJY6R1oNH4XRkxrNqTisY
	uCPt1kPzYMoKx8dI6Fmd9f1ZFvxJfE4cxZNSBJtpOCIKkxK/lXe9Z1e8lkRLFj/K7T+ibWzsPPQXY
	EM5r3xU0skSu5R9xVrtQSZkClWzQER5U0jLLQezEBxn1uNlqBzTt0eU32pymcig/YBSDiFRKF5nMp
	INXIaywQ==;
Received: from [1.146.104.215] (helo=[172.27.179.148])
	by binarylane-bailey.stuart.id.au with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <russell+git.vger.kernel.org@stuart.id.au>)
	id 1srED6-0005VC-12;
	Thu, 19 Sep 2024 20:16:28 +1000
Message-ID: <3b579ddd-b386-4daa-ad63-1e75522b7462@stuart.id.au>
Date: Thu, 19 Sep 2024 20:16:26 +1000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "git worktree repair" modifies the wrong repository
To: Eric Sunshine <sunshine@sunshineco.com>,
 Russell Stuart <russell+git.vger.kernel.org@stuart.id.au>
Cc: git@vger.kernel.org
References: <E1sr5iF-0007zV-2k@binarylane-bailey.stuart.id.au>
 <CAPig+cQ8=Y6sVvN_dBo_GQ5nLkQ4GJ7AM6mE2kt_2QV7CR0omg@mail.gmail.com>
Content-Language: en-AU
From: Russell Stuart <russell+git.vger.kernel.org@stuart.id.au>
In-Reply-To: <CAPig+cQ8=Y6sVvN_dBo_GQ5nLkQ4GJ7AM6mE2kt_2QV7CR0omg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/9/24 18:58, Eric Sunshine wrote:
> I have a tentative fix implemented which seems to handle this case 
> correctly. Once I've finished polishing it and formalizing the
> related test, I'll send out a patch.

Fantastic.

I noticed repair hadn't changed the directories I thought it had, but
had said it was changing something.  Pondering what on earth could of
happened, my first thought "surely not" - and then checked the
originals.  It caught me totally by surprise.  Everyone I showed it to
expressed the same surprise.

I can't resist pointing out if "git worktree add" had of preserved the
relative paths I gave it, it would not have happened.


-- 
Regards,
Russell Stuart
