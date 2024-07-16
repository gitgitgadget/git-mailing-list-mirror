Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8FC6BFC0
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721164229; cv=none; b=ImS+vJidCLQkXPkwuOUdd1FCx3B2CULIIAnVgJzITjydkm248z1cjfaY1G4bLaSioQHr3HQ77sY9tW0AEt7wYhls/p5XgGGza5eUHScCrGQAcsE9iwkvaEkeEmfE8NeLri8UL4GbLMRGJdg23tLFZx1YgEfmfN7TbeFFFGflPPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721164229; c=relaxed/simple;
	bh=1dJpB6PXnk6xyX2frqwGKQxYj500yMVrOq7u7/aonBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KG5Nb7JqVP/nTAAzGb9W73H8XrrrrgK4W2/SiqZvaMFg2EgI6P3QqAG0jmzTcM5m0cAIs0a6b/mI0vjpUbHkh/Lp+x32Lpdk0Fw4S+SKaB9VIS2YCs2cuyhMKth4N0ixBhW3gPw5M2eR3kDMIBZj70k8REYZBXyORi+QmnT53BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TAG0SWrL; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TAG0SWrL"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B2F83FD77;
	Tue, 16 Jul 2024 17:10:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1dJpB6PXnk6xyX2frqwGKQxYj500yMVrOq7u7/
	aonBA=; b=TAG0SWrLpqmZpvPNPDI0bKIi5Zbs8PGmcHQluBRaL47UiadjSDKNXe
	cExYfMAux/H2uyX5EJozDCx8JPkf6z61So66wwQW1AKThncNuDl/19BBqiEKPDoG
	QmgmOrCkvQhaHnPw9xK+Jxu09ct93gIOlXhF5DwSEq+aEpK+SjfkQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B4D23FD76;
	Tue, 16 Jul 2024 17:10:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EFB293FD75;
	Tue, 16 Jul 2024 17:10:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Matthew Hughes <matthewhughes934@gmail.com>
Cc: Matthew Hughes via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] userdiff: add builtin diff driver for TypeScript language
In-Reply-To: <20240716193344.bjb62zsfnrfw3ngf@archP14s> (Matthew Hughes's
	message of "Tue, 16 Jul 2024 20:33:44 +0100")
References: <pull.1746.git.git.1721061218993.gitgitgadget@gmail.com>
	<20240716122112.zqauqgxmng2tk2j6@archP14s>
	<xmqq5xt5bat7.fsf@gitster.g>
	<20240716193344.bjb62zsfnrfw3ngf@archP14s>
Date: Tue, 16 Jul 2024 14:10:24 -0700
Message-ID: <xmqqjzhl6o1r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D2696B44-43B7-11EF-A8B8-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Matthew Hughes <matthewhughes934@gmail.com> writes:

> I'm leaning towards the former case: that this patch was premature.

OK.  Then let's take sufficient time.  After all, we are never in a
hurry ;-)

Thanks for giving an honest assessment.  Will keep the topic in
'seen' without marking it for 'next' (at least until it gets
replaced with a version that is more suitable to the public).

