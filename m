Received: from ra.horus-it.com (ra.horus-it.com [65.108.3.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158264206B
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.3.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183433; cv=none; b=SHCgg+2LvABAWYwQAvybUgTh65YG/tFQlP+pBqDdfqRTeMVS5OmJftp5EgHgdU08Cz8raozL3SA9hc4jVeqTwBpivLE6mzq09n5qFJMWin/W2PhyiYSRo0Ep7g+8O/pS8XuIGtKv8eNVJH88+Dh/eJv3JpEvimDG8l6tm3ZJeNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183433; c=relaxed/simple;
	bh=0H9wzKdi2zXG6vdEyeV2p5LZQqQj4KZSyi7myKri0H4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4wzp9SuR+7jgElSaf6Yt4rsaZ/GgwTO/VYhqqLBBrENXCY6eYU1NC77ME/FPPcTj7aL6d6X4Kqj9H2z27+52zpofBJJszdfpv4uHmEq8IE/ZA0g3HdYzSZ66/lyf1TTmXQAdzm+WCKqyiL60rvAkg7ino+NnqMqj3mZBz9HPg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de; spf=pass smtp.mailfrom=seichter.de; dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b=RfcRdlfs; arc=none smtp.client-ip=65.108.3.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seichter.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b="RfcRdlfs"
Received: from localhost (localhost [127.0.0.1])
	by ra.horus-it.com (Postfix) with ESMTP id 20269BE002F;
	Mon, 11 Mar 2024 19:57:03 +0100 (CET)
X-Virus-Scanned: at horus-it.com
Received: from [IPV6:2003:e2:d73d:4900:956c:99cf:bf79:af42] (p200300e2d73d4900956c99cfbf79af42.dip0.t-ipconnect.de [IPv6:2003:e2:d73d:4900:956c:99cf:bf79:af42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "Ralph Seichter", Issuer "HORUS-IT Ralph Seichter - Primary Client CA" (verified OK))
	by ra.horus-it.com (Postfix) with ESMTPSA id C75F6BE0037;
	Mon, 11 Mar 2024 19:57:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seichter.de; s=k23;
	t=1710183423; bh=0H9wzKdi2zXG6vdEyeV2p5LZQqQj4KZSyi7myKri0H4=;
	h=Message-ID:Date:User-Agent:Subject:Content-Language:To:References:
	 From:In-Reply-To:Content-Type;
	b=RfcRdlfsh0gyvgWrVcsyLYcXQtnLlEG0a1ZFXmv2zqDz0K2qE36kuGpiXOzAlrz1Z
	 x4Yrza5IOW/7k8t+E8KYqZDFItg0S8ChHsA/6o6t6Mz/zjzTHkk7CUXPLVb1Fc+lmJ
	 byHcm97LmO2hYoPisXJEGe07iXPAIJZa+fJUbs6tBKgPcmGUD2FXz9D67wbZV6kLm+
	 RROeBvpVltzC166Geq+No8hmuEYpXD0QZCc/1QK2QosT9Tk9VFcH0ed3AzqvpGZiv/
	 0/25hf3Rf2dfg8vcXW5mdUy4dEhPx6DjHuTMAt8aioYMIcwu+MFa9qHKMCaUDgsPuB
	 mnimBzgnrJOew==
Message-ID: <277b3187-f793-4782-aa18-50bc15febe9a@seichter.de>
Date: Mon, 11 Mar 2024 19:57:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] config: add --comment option to add a comment
Content-Language: en-GB
To: Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>,
 Ralph Seichter via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, rsbecker@nexbridge.com
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
 <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
 <xmqqy1apudvv.fsf@gitster.g> <5eff951e815e2fdab3834c4aa4160ed8@manjaro.org>
 <ba6d65ca-8ae2-4d93-a5a5-e0b60768c302@seichter.de>
 <265e5b2d352c34dfe0625904b3356000@manjaro.org>
From: Ralph Seichter <github@seichter.de>
In-Reply-To: <265e5b2d352c34dfe0625904b3356000@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

* Dragan Simic:

 > I mean, perhaps the whole thing with the tab characters may not be
 > the right example, but I just wanted to point out that the more
 > major an open-source project is, the more discussion is often
 > required.

Oh, I have no qualms discussing things, but over the last 40+ years,
nothing good has ever come from debating the pros and cons of tabs and
spaces. At least that's my personal experience.

-Ralph

