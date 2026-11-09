Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221653;
	b=DmbTlMWE8v4FbQz6ZeJ695LugFP8ie/HRe67jaxoHcmTw/yKzUveoGRsHG8XOMm3Inpc
	 lUGNpiKO0XpeoWlyhk5z18ijwUAwFSaifuKEQan3Nnq45X6Vw0xHIDrVmYR9fqnptkOCw
	 3TYGlfHF393fNp0iq8pKmIR+28Uif6SOJsE59HCn0V9hf7TwA46H7E7UAuOS8p9vi38Hc
	 rO0BpTEsWJCsS4Tg9n7B8uNA/fBECHp2YSmk9bje1hBWIEBcJ8Xk/DHIOjnXJ3xzDiGKK
	 b7QVxwdQMEK9F3mbJIVVD2+ZpyDc8DenaQAxjxt9/F5OB8hJm+xiFsGliQbWj/CEBQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=YR3yumiUmsphQfNG90OKm0CACyQz1KoWJ94gd6zazhI=;
	b=sQQGEBrdmCJKXoExvQ5knYvpCSWEvbOt/EvXFmreuyUfPcyxZcyHQqLDVrW4nZskO/rI
	 pZgMXTyrxdlkyCTtqdtdnHIyMGpwIfGoGjc4x7lG22N3xoaHlLgcXH7Ugko8QxdhiONad
	 GCdATbw5LJkkqgFfSknZwmcdjyz9qaat7HFw4TMWzkm3IrRA6WYSGQV04lXsmVQ4EC7Q2
	 XyjG6iZmLZw0/IDd+EuDXKncgxeLLMyioClm0LlmADBPK6OQW6C+YUvkxhx6Yo5b8+4yW
	 JzRlF4sz2n2umu+7jB376s0drmtgKcUVTgsdvd/6s7yL7oqOARYELgp/TRWV+08Vj3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SqRC5jMR;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BB4606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 10:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18BB4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SqRC5jMR
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso7694965e9.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 02:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794221651; x=1794826451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YR3yumiUmsphQfNG90OKm0CACyQz1KoWJ94gd6zazhI=;
        b=SqRC5jMRNbGxxNYA8CEIjHt/GlSP6FM5eSfKrgThY01qXYKGJZx3UA7BaFSDDmQvAG
         ehHrk9H5R+QvExzRhFf+mMf76zbrqlxfj00uLFtjQpd3zbaH9UoOsxwebXvWuP9N6BEH
         YbM2d8G7fM7oCkNmvuF7fabb0R0JpxP1FkQgP8mVJu7+IWmQ7x0uqo6Wh9rNeB4wA9iD
         FJWR84AYAaZ7euZd7fkFszkyyHw+zk6KVC0tkLdFlfKjTzMfhiyQcNNhDLd/738d044Q
         wbv/SRtqQz7g9lTykt9J3RNMFXj+MqlGbDPQ6UHzy9cuGm/OoI3PwVwd6cvOGt0SKIup
         jGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794221651; x=1794826451;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YR3yumiUmsphQfNG90OKm0CACyQz1KoWJ94gd6zazhI=;
        b=vQXc/ozlJZOIOtwc9nTGtNOCKzUm+/vv9A5YTqjjk1uppYVcLMtbq1CnEA85rrQjuJ
         UdNdkOk+9B497alXGL4nKB0Jgw9JfcnbjQSW6HCMIr9GVrsiHGSXnYjvbcBIxNtuhdXA
         AKXzL7WLusdgt2rFolF23AoDO2kkNtawa/50DaRLIlCqC2Zw3GBIymtXyUxQSyDfRCI6
         Z1D7ew+ypcJ8xM+0C00EsUXX9081XceHO/QhjIYP2989g2lWQioFU1u7s71dWziw6ZBT
         K0zF8NtCEndRlSCswJZz0Q+GzOFFUTAqLCoLKi4PI+2d+6MdLk0IZ6B/SO5Moi/IBSuu
         LgyQ==
X-Forwarded-Encrypted: i=1; AL+hErEO68e88n9KEbsySw8skMMNsTFjcdOnRv5bBxPxypT39M9GnpROtxtNRApZluEm/x1oOC4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/I7WB95juOxIieK5PRd6tjonV8UyCWodSa43goJ41y9gHd32Ks
	xxG7CxjWJBSO5RwP1Z5MFNCTSQ7vPMra2RSKF/XMLKAdo2ZmlL43zvtW
X-Gm-Gg: AYBFou0CwgEyAwKHJClOcewt+b1cMRAXZNi0K8aJ/ZFmhx1OIYKeG77nfTxjiPeO0BG
	3O0SBG176fWQq0VtBQC2jJ9WBwpcJPe2M9ZKe2krAcxjKhWcLn4qO/TVXyvB8M0b/FIR61P9BvW
	1QWlK5OzbMNwMS4qgelSW7qU4kk7l10y/0Xhq6/MJ/efhN1/Mg7CV7Inhq9Yv6RQPo+PsbksnmT
	eDDmXNvcv1MiIQ1x11q1gxlbJT4bvj6sSGrxDfh2LKGOmtoIwB1zaMimMe0kxje7R6qHeqy4882
	izHBUOhG4UKLDkgl7NyJ55wkUJgwI+4uJiFUk0xHJpAb6r5rL+Zqs5Y3j2zciNNKvi+IHfPNwM7
	mdnpvin7D580rL9hYE6AMREP9HwyOl9bQ7mnbocIEVFYknnbVPBt/CcBkfv+nYq1+S+8q8FGaNz
	TpYXuFD+t0M3OMfQ0pPpx0AWAp4IPcpfOA943wYVAvFEes1j/llQuuB6aTjnJ/d636OemK+4xsJ
	Uz2qcVFmUtkplGm9g53MPxqLvLkUNhyMVYpBoVTTCG0uuSPfWNWoHhPquqtD3A8NA9/c7kKvSN+
	wNB5OGSsDPUpwJGtAlwY72K5J8qCUUMstgjTKSfY5bCnzlPYAySY5liGAjJPzBFto+rI9kbvmEt
	JavcsoQ==
X-Received: by 2002:a05:600c:37c3:b0:4a3:d327:6ed with SMTP id 5b1f17b1804b1-4b963c89ef2mr64795625e9.17.1794221651361;
        Mon, 09 Nov 2026 02:54:11 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e32ad610sm526122905e9.3.2026.11.09.02.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 02:54:10 -0800 (PST)
Message-ID: <414a966c-44c5-4715-adba-6868054d33e7@gmail.com>
Date: Mon, 9 Nov 2026 10:54:06 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/2] commit: allow -m/-F/-c/-C for all --fixup
 variations
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org, gitster@pobox.com
References: <cover.1779792311.git.erik@cervined.in>
 <cover.1790082176.git.erik@cervined.in>
 <ba174a25-f7bc-4a5d-918c-87229b2fb5f6@gmail.com> <auyXU7spezFBYohU@mbp>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <auyXU7spezFBYohU@mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Erik

On 05/11/2026 14:51, Erik Cervin-Edin wrote:
> On 26/10/21 04:13PM, Phillip Wood wrote:
> 
> I glanced over your review and from the looks of it, it makes sense -- I
> just haven't had the time to reroll a V4 yet. But I plan to!

I'm glad it was useful, I look forward to reading V4 (hopefully in a 
more timely manner than I managed for V3!)

Phillip

