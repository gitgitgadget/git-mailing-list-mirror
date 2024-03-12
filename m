Received: from ra.horus-it.com (ra.horus-it.com [65.108.3.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD1B5A104
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 06:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.3.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224381; cv=none; b=S4J99ZQp8v4J811rC5W5d+BysqHKhYfBdZgYcKiv4qgQojU01XfDHMf9ZrvpcFRCyjQw+mhPilU6vsx2DOuJPMBniWlv5PDADyw3gglAhWR6TM2LzrHY2Yeys2PDCVcKhpIT0kGXlSukJ3RzLohGdff5gEnE57dmuBF4cNL6oHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224381; c=relaxed/simple;
	bh=S7XcUk/YKPAjxN37uD+DLL3ZnPRNA13zojbIZ0/01cE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jzmp+waKQDEOlNNEFzoPvN86tckKBbWvESVuF8syGhFqH3/WpB5O59WbtYObVt7NTcDBVdREv8px4BT8qXw88+0fMx7uRqSidkOI5LnjPQ/9SuW7CwERdlFdmhaLkweQlrAdiCqcQEIBRFsX8whAf4Cw1EVDb5t23NZUiAXn9t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de; spf=pass smtp.mailfrom=seichter.de; dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b=K/WmY/w0; arc=none smtp.client-ip=65.108.3.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seichter.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b="K/WmY/w0"
Received: from localhost (localhost [127.0.0.1])
	by ra.horus-it.com (Postfix) with ESMTP id C5233BE003E;
	Tue, 12 Mar 2024 07:19:28 +0100 (CET)
X-Virus-Scanned: at horus-it.com
Received: from [IPV6:2003:e2:d73d:4900:1d67:1a9c:26c0:95ad] (p200300e2d73d49001d671a9c26c095ad.dip0.t-ipconnect.de [IPv6:2003:e2:d73d:4900:1d67:1a9c:26c0:95ad])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "Ralph Seichter", Issuer "HORUS-IT Ralph Seichter - Primary Client CA" (verified OK))
	by ra.horus-it.com (Postfix) with ESMTPSA id 6DF9EBE002A;
	Tue, 12 Mar 2024 07:19:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seichter.de; s=k23;
	t=1710224368; bh=ZSSkc7ewfdxjP66ODzlSXkGg5XlXN2uORjWwTXnkE0M=;
	h=Message-ID:Date:User-Agent:Subject:From:To:References:
	 Content-Language:In-Reply-To:Content-Type;
	b=K/WmY/w0UXp3squyIP5P79QflcU7FDpKuJ59zczrL9wEtN6EsEJRwHJzO27t4QpDV
	 dKjEHUBNV7eqDy1btSStmMsbWlFBbfv4ww3MfVAcL4m4hhbCbybmBMcj9lhG0P0u66
	 rmExcpSdtEt4vE2rWYWfSA31/aXZfM9+AXey539RHYl0xLnMZMQi+tHxpn7Hk+U9JC
	 HgI5St940aubIT+fj1vlKiFhr2J6coxRMHHioAAoqWneuHMkgREVuAlqtTyjrUJMo/
	 OiCA+owxGHmwXxqaEDCXGDjwLpgj4E/nxxjoTTjPI7p70+bpluXTKCzpvs1o33HffJ
	 cCCWLbbMIdHtQ==
Message-ID: <cf21edb2-7681-42a9-8b58-beca5d04c179@seichter.de>
Date: Tue, 12 Mar 2024 07:19:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] config: add --comment option to add a comment
From: Ralph Seichter <github@seichter.de>
To: Junio C Hamano <gitster@pobox.com>,
 Ralph Seichter via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, rsbecker@nexbridge.com
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
 <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
 <xmqqy1apudvv.fsf@gitster.g>
 <9166fa83-4ed5-41fd-83f7-337fd524d0e2@seichter.de>
Content-Language: en-GB
In-Reply-To: <9166fa83-4ed5-41fd-83f7-337fd524d0e2@seichter.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

* Ralph Seichter:

 > LF is a more interesting question. I haven't yet tried actively
 > introducing a linefeed. Does strbuf_addf() have any related
 > filtering logic?

I have now tried several times to inject a LF into a comment string,
and did not manage to break the resulting config file. For example,

   ./git config --comment "foo\012bar" --add section.key value

leads to this entry:

   [section]
       key = value #foo\012bar

Variable expansion with LF="\012" and --comment "foo${LF}bar" did not
introduce a linefeed either. Have you guys perhaps managed to create
an invalid config file?

-Ralph
