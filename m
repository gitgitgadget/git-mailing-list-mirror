Received: from web23.osl1.nordkapp.net (web23.osl1.nordkapp.net [185.114.57.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1542B2D046
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 23:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.114.57.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711667908; cv=none; b=Yz9OPQUt6tg7MyXYJdxNplVBT3Uam4NPE0IzxGfMHqZfIxNSc0zFQqed6empmlzVXzSEiq0SJB5k0MD9+ewDs3etrP8NLQeDWDW38xpH5z7daWlk5dEr5x57VKdCwQd0+tky1TFUXkIaVWtC3/XshzB6vQmAlw99jZI7NY7KCjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711667908; c=relaxed/simple;
	bh=Xt4c5CATFQQAbrnt9OzBd/GCKY3JxyHgEZ3xhmZt79c=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gtp71JF1owFD6WMO9Ps+U0hm4xZKt1IRNwWo9d3Bdgq82p8KT/xHcWRyDRHNzHl41TANuxvQ2JoAb0+DxbDAq29usb6xPkDNTb343KdxpLXpBKUqnZ0m3E4/rH/dnksLXrlky6sAZ+M17MRkp0UzuKJryUQRHsi+9NZcrk4hZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se; spf=pass smtp.mailfrom=softwolves.pp.se; dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b=BLFb1JCM; arc=none smtp.client-ip=185.114.57.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b="BLFb1JCM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=softwolves.pp.se; s=x; h=Content-Transfer-Encoding:Content-Type:Message-ID:
	References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zbVU9NEWRJon3l+LL7xmN333SfQX6eiYtAQDCRL2aXg=; b=BLFb1JCMXmn1DcqwEjhxcWK5xC
	tb0jY7Nq9o0HjBgPeerhjyPHjR3OqVdWS0hOPWWdexGpt4wp8A00ZvhArET4pQoblL6wgryG24lRr
	G5ZWRzHsC4nb2SPKvdivjd/jyCMWPXaoQ3loylol8MUfasoMg6OTlfJzU5alR/aivcRAbZdjkrgHc
	mpsCVHJvahGgwXyHwNppcESISwrQt805leRuo0ZTq1eMtf87OOc5Z9pSnSEz6jnuYHuwFwkdM3kFk
	j7QsQuGO2TmNMwqnlCTfA3bdgnh9eZYDc64fgLrSCYpVuQCyY90hgJ1sPF4RrmYCepG9tZFA76iJw
	jDTb44DQ==;
Received: from mail01.osl1.nordkapp.net ([185.114.57.50]:55872 helo=mail.nordhost.no)
	by web23.osl1.nordkapp.net with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <peter@softwolves.pp.se>)
	id 1rpz0j-00000004EFx-3nKr;
	Fri, 29 Mar 2024 00:18:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 29 Mar 2024 00:18:17 +0100
From: Peter Krefting <peter@softwolves.pp.se>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, "Osipov, Michael (IN IT IN)"
 <michael.osipov@innomotics.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] bisect: Honor log.date
In-Reply-To: <CAPig+cSKbGW57dh13T6p20B_EY_C4K=LiQ3TP59wheMSi4qsQA@mail.gmail.com>
References: <645c8253-f1ef-410f-8284-7d6c8b6db601@siemens.com>
 <xmqq7ci6c7mn.fsf@gitster.g>
 <4e2b22fb-7496-4f67-a89f-9fcbffc73a1a@siemens.com>
 <25d716fa-bd32-4ff0-20f2-05ff51750911@softwolves.pp.se>
 <xmqq1q7ygex1.fsf@gitster.g>
 <4727b78c-e45b-da7c-fa6e-85876b50dcde@softwolves.pp.se>
 <CAPig+cSKbGW57dh13T6p20B_EY_C4K=LiQ3TP59wheMSi4qsQA@mail.gmail.com>
Message-ID: <b3f7c1c7f126a3c0a65f034ed6166d6a@softwolves.pp.se>
X-Sender: peter@softwolves.pp.se
Organization: /universe/earth/europe/norway/oslo
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Relay-Host: 185.114.57.50
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus

2024-03-28 22:38 skrev Eric Sunshine:

> Nit: The comment doesn't tell the reader anything that the code itself
> isn't already clearly telling the reader, thus the comment is
> redundant and unnecessary. Moreover, the comment is likely to become
> outdated when people adjust the code but forget to update the comment.
> As such, I'd recommend dropping the comment altogether.

Yes, that does make sense. I copied the code for invoking "git show" 
from builtin/notes.c, which does have that type of redundant comment.

I'll remove it.

-- 
\\// Peter - http://www.softwolves.pp.se/
