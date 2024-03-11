Received: from ra.horus-it.com (ra.horus-it.com [65.108.3.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C71405DB
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.3.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710181401; cv=none; b=YJUMHVBwzznQegsjPDNKIqW4zqFwnkZSGylXZab0eXtdiFbuDoROHBK8Cy8i51AxooYbdA93Uni8s0jmssqgnGBSFDsKe94p25q4vvGh7huH/2gcg90MvswuiATzU7exwTSrrD8u+j5omahs5ilnjBbX8qhySbPJkowQYvwauJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710181401; c=relaxed/simple;
	bh=XaDebWazQ5+CaRr9jQ4bWw2/j+NxEf8DQApw4pN5zJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FolAVQpnWZeb3f9Jc1d8NC7TMpD5tauKx7GCZMla/HluFzTF09QXmA5F91QwKm+ud7+yuUHIWTX4eKR5f17RdMkk/LkJFOA46W3ZZnN8x1Er0N9QqKqant/LWE2Oq4HbYx8rXyorc4V6uDaQRAsJbBuHBMrC81kNiQ0V/qTb9nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de; spf=pass smtp.mailfrom=seichter.de; dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b=VvTZcPSG; arc=none smtp.client-ip=65.108.3.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seichter.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b="VvTZcPSG"
Received: from localhost (localhost [127.0.0.1])
	by ra.horus-it.com (Postfix) with ESMTP id C5DF5BE0037;
	Mon, 11 Mar 2024 19:23:10 +0100 (CET)
X-Virus-Scanned: at horus-it.com
Received: from [IPV6:2003:e2:d73d:4900:956c:99cf:bf79:af42] (p200300e2d73d4900956c99cfbf79af42.dip0.t-ipconnect.de [IPv6:2003:e2:d73d:4900:956c:99cf:bf79:af42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "Ralph Seichter", Issuer "HORUS-IT Ralph Seichter - Primary Client CA" (verified OK))
	by ra.horus-it.com (Postfix) with ESMTPSA id 71B62BE002F;
	Mon, 11 Mar 2024 19:23:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seichter.de; s=k23;
	t=1710181390; bh=XaDebWazQ5+CaRr9jQ4bWw2/j+NxEf8DQApw4pN5zJE=;
	h=Message-ID:Date:User-Agent:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type;
	b=VvTZcPSGmkUF+xOcEH0WLY0vVJU+Rqm7Cqsxm8ZpFMDDG3fs6Fcfm9FvkiAZ5GRb/
	 mncoF8uQh8v2CpjDbnviVrgOid6Z1Oa5IdG7r3HcShyT5GeGOTZhthvdsm/LsCkrK7
	 4LZkHnMp1CHE8jXY2OzMHXzFqWs5cGEfmy1ac1iYOmqEdoxRVNREGV1isckrgLF2NF
	 mUsvAcglBWdIYgfnWi3nKapYpcD/rKjZ1owC852f4dwXu4p1SmabyyunTqEpfRGFb7
	 UHRfjWhJZPloIvpCg3ZdmjlAaLqJXkJAEoNURZO33jBrbRXpWoei1JBVCnG0OsP3xo
	 VLtO5ZtimdbwQ==
Message-ID: <ba6d65ca-8ae2-4d93-a5a5-e0b60768c302@seichter.de>
Date: Mon, 11 Mar 2024 19:23:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] config: add --comment option to add a comment
To: Dragan Simic <dsimic@manjaro.org>, Junio C Hamano <gitster@pobox.com>
Cc: Ralph Seichter via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, rsbecker@nexbridge.com
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
 <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
 <xmqqy1apudvv.fsf@gitster.g> <5eff951e815e2fdab3834c4aa4160ed8@manjaro.org>
Content-Language: en-GB
From: Ralph Seichter <github@seichter.de>
In-Reply-To: <5eff951e815e2fdab3834c4aa4160ed8@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

* Dragan Simic:

 > Let me interject... Perhaps also a tab character before the "#
 > comment", instead of a space character. That would result in even
 > better readability.

I'd rather not open /that/ can of worms. Tabs versus spaces, tab size,
and so forth, are too much matters of personal taste for me to want to
spend any time discussing.

-Ralph

