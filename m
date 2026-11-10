Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322998;
	b=skptNscUFD/UT2DMUi1ZPuIxHeBOIk7o7RDwty2OLKnLOb8PHVGPVxNba9xaz5OUPB+z
	 hd9Ep7hHknpZoQ85OShQ+i3AaAsL61CcrK4n7BpJ2Ff1P7uUDRuIFYjvVzb0JIoKgkUj/
	 HzsBfra+XY/ANVG0VwtWAYbCGCEovXDVTDEDF8sqOW6EbYsijztY4VUt42iEZHnI7a2ub
	 DFaV14ARcZgO+1BHxPOr0atxf0Jk1RDIbp8HeldHstvgzH9V/g4qa93yBS4iy2voqevDl
	 hLLcU0YUQL2r3HriZnZ17kMDBYWUrXevVhco9urmb6NAu5yxeJrPkja/liVH1IHhMqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322998;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=cGYu4ORWbIQsI/72oHrY39W77jWv6Ef+jfIEoKx+8Ns=;
	b=IorCzwxx+8tm0oLsHFx6tIe2ihazrrfGILPduz4mucRhfz6sHL8n+F0ptGEqORaGUlEs
	 X0Pk+1/V0Cxt/wgnzz6W61f/fM5Ng6VcFku++LXV4M7AzfwJ/BG28cqOqVtXVKlY2KeSs
	 ARy3sS+Ob2rFpq77sw4nQbE0v0l8kcChtGuvsJ7czOEoTbAAEn/SvLnC1Bb1GUuByLevl
	 uNRMPlOUG8mjvea/r0Mbg7L80RB6/ZYdaazLpvEUH+hlSaJnvkDxrOZJqma6CauzBch4Z
	 cUa+N6cNjJ07T2j6GdjsDQ0Af3FlJbWVauE4sdNtzdBMbm7VI/xZzHoB82WydH1PeLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N51UqnkN;
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86CB60A260B
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 15:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D86CB60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N51UqnkN
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-98fea7e52b7so1155566241.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 07:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794322997; x=1794927797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cGYu4ORWbIQsI/72oHrY39W77jWv6Ef+jfIEoKx+8Ns=;
        b=N51UqnkNlGTRDPaUHthgBiI7fItGLkox7ppDoTLkTZnZ10gi1NymOn70JOjbz3x6Xp
         vQPV/suDNs8kSrHoIEgatbcWD6/8B47+fzi80TQsJpmt9WW9ukNPy6AGe8uDkORI/CXy
         IV2o3m5SoS8Y++P+xBvFNmWN+iBZkb7siaHwYQybfcTsN5X7HQQ/NqIyd8HZV62mt+3w
         BZx9UoeHjpZx4kq73jg0kDEqRwq6/LXMC190sVAm1iwztPTkGLCOYFYI9qu2qxN0cdag
         dBGKnAimd7yxU1Mdte4jUzunRcgcoKlEEAKmQPtZa7mukkMlDwaIFWYgIRSqwkzmgF2x
         aCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794322997; x=1794927797;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cGYu4ORWbIQsI/72oHrY39W77jWv6Ef+jfIEoKx+8Ns=;
        b=ei53k+TU7R2hC+ypuivLpTKekDwv6aIas9vi7bYT7hG/jNChb+K//ku/2NElllqACg
         lfhMzAAhPEJB0CCO7OJMepMk3BjDos4uMplbV+tn/g92Zjcc/9rhqnTUFLBpbaMhjsKM
         IVca0ixAvSD5bboKwbA8hzBT82AXXmP2kZw13dhP44qowAXReFgCFE2RwrOf6fZxkQaC
         H49FpR7q0jSOJ+aXeh1kqCt9KCQmTBBRSm16vYEfvJnhOzxyVCHF+0nqKdPLH7s+a5Oa
         k86TsiJ0qpgqkjToUThXlzQksx/mj1Iljy3V8NytDV7M0w39tckwCP3kSE8HpTG0RWU2
         vsSQ==
X-Forwarded-Encrypted: i=1; AL+hErGoc6mMR+bi1qMu+ACVvX7BSEGPFiCAlEBgt8N1r+grcbgVKJ2FjygWG8/51xfgY7+gop0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xiqq2edGJ+YSPieCrwFs/t/zB7Qghim3mfaHfrcbN/k0l6V4z
	stt9D6SlF3aRUflPBTb9AziatuwZJbmcJaLkCBCV0LmQmiwFneEEj1JiSkgzHkUe
X-Gm-Gg: AYBFou1j+59TssxT+eN6MGu+e8pmEo0yMTtwqMr9d3TWvnTjYE8Htnoqge561ZNXUXP
	oU4BIcIqj4xhYMa2ysqYABODRgi3hoagusfdwcfWiMPd4jBEL0yq9ZuuIL3MHHeB+w0iFBc+Csp
	MpysYyOvVxUSTuU4UdklnGhcqr+0dNl5u/m6Tk0p9S8Ub9OHLncABIronw/C1Z74FW23vOB95V2
	/KT+nor684FN3j9f44AbneWYvn5HOPhDrazZ38YPd9if2FU9STJO31YtPhGoKsxq40+51Uy7bC5
	OK9pABPUlhsNy5c2djN4M3GO3adrwdKa3rQL7RlWb1vi++dm95Y5blKhbRGcPwq2f6YDaI7KBWJ
	4Z3wh0dhgmqlzbzH7pSGyiWXoZF59zRXlU526Q+nMCNsPhLAQwMembmSObifdwzvJ66ia66Gk1Z
	8x8u0g0GDub6RvVgXm9HqsoDUbnXpNg9FA8Yws2gwJOEXptFlMx3nzqXJp7F6w0RhNtra5jmqf4
	Cj7O+SESF/j4ERIlk5+Mo4Ds/sTkFGMqMn5uP0ZOjUPjaL8XdTYIbIbPHk1gF4C9J3dFVt1szXR
	yOK+cST+MTPk04OxWlWzsGKIXJ2zuz9M4+bZN9gDoQAQDsOvvuYRPMl0cHu/yzm+bu6Jk4FnPKi
	hUf3idFFym6hQiYocOMOYh7wTYIphmIad86ti15itaqapxqZlZ++JW8dGLUWbAaBwE/4G1qdaAM
	hShOpSG9H/PXkZjxZAv2YPA2SUr2CbgTWvjhXELePdKX8ZfxcRWnJsEzE=
X-Received: by 2002:a05:6102:6e88:b0:7cc:24e1:77b with SMTP id ada2fe7eead31-7d301ac0a17mr793592137.4.1794322996388;
        Tue, 10 Nov 2026 07:03:16 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f0199c41bsm738666d6.34.2026.11.10.07.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:03:15 -0800 (PST)
Message-ID: <aec316e9-9840-4874-a78e-3ff79c6cd903@gmail.com>
Date: Tue, 10 Nov 2026 10:03:12 -0500
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
Subject: Re: [PATCH v2 14/15] bundle-uri: handle NULL values in bundle lists
To: phillip.wood@dunelm.org.uk,
 Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
 Patrick Steinhardt <ps@pks.im>, Colin Hinton <colinlewishinton@gmail.com>,
 Matt Hunter <m@lfurio.us>, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Miklos Vajna <vmiklos@collabora.com>, Junio C Hamano <gitster@pobox.com>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
 <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
 <fb9e63541bd42aff0fb8b51ba79781e0d80e8531.1794296205.git.gitgitgadget@gmail.com>
 <ac00d92c-bf67-4629-bdd5-41c80d548354@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ac00d92c-bf67-4629-bdd5-41c80d548354@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/10/2026 6:11 AM, Phillip Wood wrote:
> I'll defer to Stolee on what's the best behavior here, but it seems that in a couple of places we're erroring out on a NULL value when we would ignore an invalid value.
> 
> On 10/11/2026 07:36, Thomas Bachem via GitGitGadget wrote:
>> From: Thomas Bachem <mail@thomasbachem.com>

>> +            if (!value)
>> +                return config_error_nonbool(key);
> 
> Adding a bit more context below shows we ignore unknown heuristics, so do we really want to return an error here?

>>         if (!strcmp(subkey, "creationtoken")) {
>> +        if (!value)
>> +            return config_error_nonbool(key);
>>           if (sscanf(value, "%"PRIu64, &bundle->creationToken) != 1)
>>               warning(_("could not parse bundle list key %s with value '%s'"),
>>                   "creationToken", value);
>         return 0;
>     }
> 
> Here we ignore parse errors, so should we be returning an error on a NULL value?

I think that the bundle URI feature could be hardened to halt (safely,
with good error messages) instead of continuing in a best-effort way.
The cost to being so flexible is that a user can download partial
bundles that don't even fully install and then fetches too much data
from the Git remote.

But I also think that this series isn't the right place to do that.

You're right that this method becomes inconsistent with how it handles
certain parsing errors versus others, but we are upgrading from SEGFAULT
to error.

Thanks,
-Stolee

