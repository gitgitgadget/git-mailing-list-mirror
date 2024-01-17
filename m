Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F7025560
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 21:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705526374; cv=none; b=EvCsbqS9k/53BmO4uZRCXEV/A+b1k9U+zjzVKOa7c1Okuy85AcUAxKS8o/LtGcfkdt47ujsTUN6oBhUw8Oz+lJguO9BJoqlhyKFjH+cGfoJcvehh6nNunkEotShO36WV+aRRJawbUAOgiH5GnBKvP9Lqz0o38mj1wg479pwsum4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705526374; c=relaxed/simple;
	bh=/meaglQ7umyLzjg1hnLBnnrVNYDyZaJ6u6wYXyIngPA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=WwCZHPzwEbfgvEMGKBkEzlU35jVrk220+l0FV6yEx5sFSSb7OXfhykOPOVCEP2DQ5lF4rLf5hjDJ5mqx+5/98Q3lHv9jr9eRkioU3j4GU5WWd3gNoVErOwZCkokF6fm2ZKxMLK3BgaGNQqMVP1ijQzUMm2YMaqJfPkOJTPT38xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=OiHLPL/3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="OiHLPL/3"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d5f1e0e32eso13680435ad.3
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 13:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1705526372; x=1706131172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72m9B1OT83bJgmZlFyIm74zs879syuiFsSOa3LiLR8g=;
        b=OiHLPL/3Ywaj2+x+TVa8udGGiU8O5ww4I1zyfLLRpdGZVsMzijhCHiXPBYsSvomUMJ
         KGlhbohVdsZ3FsAfdzekDHTX5JUCupJUVWek2dJR+II41+HwaB2D3TXXlfT2KOznPC7t
         h1lZdjoJQwKR2dC2WYZGNOxs8Dm5dtMcWZBy4ZifvH6qrRO1fqEoVt1/+FFH0Drts7KN
         mILNP/tKc9PYmbqH1AciMhhHQ4TpU3QVYOn0W9MP2KvJSo2VRFrM4O2G6UD56okOSk0W
         jZXOyG6M0+t143+qp1u5okXgOMZK/XAALYwK2qTG+UuiTY/vuq421jJoXN/PbrZvQ7Jn
         MNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705526372; x=1706131172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72m9B1OT83bJgmZlFyIm74zs879syuiFsSOa3LiLR8g=;
        b=rNiEyOWvta3HOvR5jS018KIRph+IH/EUzRTgDt5LEY3KIstU63oDLAbmm85lZDJKZg
         dmrusq4qLNta2p16HimKlWE7sMfaLM22nTlLdz1DxOGMI40Zlh0yrF5x1I0EWbDMdUmO
         CeSZyN8pcMPxVaAmqggQ0Tj4/dKd3oH0lMPW3cTIUUAmBITbM4xXoSq0/VkkZWNu+8ZB
         hV78/zFUEZgvMbrZ5srife/MoJG2Qh26xAjokyTMoYW8nyo8JJBmn+zBnr1CyqTaDjY6
         Ntbc4I8Ajb2BA3ImqcJ7Js6wX9WlGGa9MZAuCUiZsv8hhmoBN9sLHtZJVljvsBvSvEgz
         1M9Q==
X-Gm-Message-State: AOJu0YyJ3pMIgZYhWLAyJyPjzt2IOlvGwwr04QfZnxGZKb6KnYI7ItYK
	TUcISecPV5FXFEqntf7y1g/ew/nHRma2t2fbP2icZ+pp
X-Google-Smtp-Source: AGHT+IH4Tk/Alj51VQV8MZ9UB+Rv2p6Oq+8quqZc9OjoQYMB64qM8bjB2fWXdlcoHRd/rMpCATUExw==
X-Received: by 2002:a17:903:2651:b0:1d5:4e05:a66a with SMTP id je17-20020a170903265100b001d54e05a66amr5176799plb.9.1705526372140;
        Wed, 17 Jan 2024 13:19:32 -0800 (PST)
Received: from [192.168.50.41] (172-091-184-234.res.spectrum.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id r18-20020a170903411200b001d58ed4c58asm101456pld.63.2024.01.17.13.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 13:19:31 -0800 (PST)
Message-ID: <08276422-3af8-40df-85dd-65ec4e891507@github.com>
Date: Wed, 17 Jan 2024 13:19:30 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] submodule-config.c: strengthen URL fsck check
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>,
 Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
 <893071530d3b77d6b72b7f69a6dfb9947579865e.1704822817.git.gitgitgadget@gmail.com>
 <ZZ46MrjSocJl-kpU@tanuki>
From: Victoria Dye <vdye@github.com>
In-Reply-To: <ZZ46MrjSocJl-kpU@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patrick Steinhardt wrote:
> On Tue, Jan 09, 2024 at 05:53:37PM +0000, Victoria Dye via GitGitGadget wrote:
>> From: Victoria Dye <vdye@github.com>
>>
>> Update the validation of "curl URL" submodule URLs (i.e. those that specify
>> an "http[s]" or "ftp[s]" protocol) in 'check_submodule_url()' to catch more
>> invalid URLs. The existing validation using 'credential_from_url_gently()'
>> parses certain URLs incorrectly, leading to invalid submodule URLs passing
>> 'git fsck' checks. Conversely, 'url_normalize()' - used to validate remote
>> URLs in 'remote_get()' - correctly identifies the invalid URLs missed by
>> 'credential_from_url_gently()'.
> 
> Okay, so we retain the wrong behavior of `credential_from_url_gently()`,
> right? I wonder whether this can be abused in any way, doubly so because
> the function gets invoked with untrusted input from the remote server
> when we handle redirects in `http_request_reauth()`. But the redirect
> URL we end up passing to `credential_from_url_gently()` would have to
> contain a non-numeric port, and curl seemingly does not know to handle
> those either.

Correct, nothing about 'credential_from_url_gently()' changes here. As for
whether it could be abused - I don't *think* so, but I'm definitely not a
security expert. If it helps, here's a more detailed breakdown of the issue:

In 'credential_from_url_1()', suppose we have URL
"http://example.com:test/repo.git". Stepping through the variables:

- 'cp' is "example.com:test/repo.git"
- 'at' is NULL
- 'colon' is ":test/repo.git"
- 'slash' is "/repo.git"

Because 'at' is NULL, we set 'host = cp'. Later, because 'slash - host > 0',
we call 'url_decode_mem()' on "example.com:test" (which, in this case,
doesn't change anything) and the result 'host' to "example.com:test".

The issue for the fsck check is that 'credential_from_url_gently()' doesn't
validate the hostname it extracts (e.g. whether ':' precedes a valid port,
or if the hostname contains a '%'-escaped sequence). I don't *think* that
could be abused since, like you said, cURL should just reject the invalid
URL altogether.

> 
> Other callsites include fsck (which you're fixing) and the credential
> store (which is entirely user-controlled). It would be great regardless
> to fix the underlying bug in `credential_from_url_gently()` eventually
> though. But I do not think that this has to be part this patch series
> here, which is a strict improvement.

Agreed! I think normalizing the URL before trying to extract the credentials
may be all that's needed to avoid surprise URL errors, but that probably
warrants a separate patch submission (with appropriately thorough testing).

> 
> Thanks!
> 
> Patrick

