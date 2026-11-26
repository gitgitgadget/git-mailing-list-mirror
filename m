Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705657;
	b=N9e7vBTtMuA9PMQuoY/MFiuVgjx/YyeDpOy32bhxdpmDX1QTyQYkwPpEi5mazV03p0Lw
	 vKjegolyOYTgntBSRLatNDe50e1wFsca+8PQTloFHTV5qHphi0hvYIpIVaSd9ypSnHr/l
	 QKFURz1v0+vH23Xof9686HK9zEQ+zfF64WdJ2S+lydcjRjQ5LcDoHcm11Mu0sXv1PHhOd
	 uMbZdUhYt9rfXphgwP075hs08ABFk74DXwu8OxF9r/wuBFhDl0JxTb4nV//TqLNVabOWX
	 ObxAmpboGegOxEJ8wTRdDWcU5Bev1QSUc2nDANM66ho94uYu9BJeLRI2bpE/jsICBiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=gPKYxexrLO4Xkz7H30pHIeaMq9h6qxFfs8jsn34NhIY=;
	b=Rod7S/EUiW9ffX2fNAtSAsLefLGUQLjW7jS9Wv1hNK06dpkuIDWiYTm+99veNn377qYE
	 yeeOA21Fjm3AkZ6uOU0FJXERftUBgioxQoWx3Z3F05CaJkiyiQ88xrS1wqSQCf4DWgTMT
	 EiYbQvllT413uFr/L17bSmMzGl4eSNimxDqMnOZ69/uo1siOEMrPQsQLvBF1Fn4Vay5m8
	 7E3qL2uWfLlpNjkoVycma4J4lCTUOIEJqaJ1W6Pt8GDNyaqvhgdfmYnNJsKnUE5uEomb0
	 dqUnIBCGYsvBKEj4Gjw8/9d7LShrwRPSR/lwa00A8x3YTWpba2meMJ0XvH2pcNeLPRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="DYaXe9i/";
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC981606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 15:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC981606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DYaXe9i/
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4ac08f4a0b2so5051423f8f.3
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 07:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795705655; x=1796310455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gPKYxexrLO4Xkz7H30pHIeaMq9h6qxFfs8jsn34NhIY=;
        b=DYaXe9i/Uo0CsgGLaOl9bdNkYllMKXdEztPP3fuFysRyGfallZkYf4AOxYNuxUnm3f
         hGLwU+hM21Ht80zC78EFekVx+h/02hcDiMGuc4hnJtU+2CnnNt/I3qUnmYSYfHkbVgDt
         weHWh/rvKOim+usqfvIltpCARst0+xYtF1LmWKYUaPvVuDFjzhXPEiWaScX5oUjEXXFZ
         q8f0weXekXfJZv0RKTAzq/Nk0k8lwUDrm8XQtkEXSYQz0x0KIFMpM2sRZSzJp5HqkSsF
         UFi8/Ex0+TRr5MP8CJ2uvXGsLcq++vh77quYpdTrXitGD3Ip8JmOS0c3oUwGE5fkOlfl
         CsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795705655; x=1796310455;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gPKYxexrLO4Xkz7H30pHIeaMq9h6qxFfs8jsn34NhIY=;
        b=nmywrLvPQv0vMYE9JUZ/qruc2t1U8NpUS0NiN6DinEWI0AZAlDMEDJ9KjZ7SV2D7YC
         1nyY2z5jeGm94tx/zSZpFeT3yqJssSOdZMrR5RpUquo9CxEycN6MNsdEi/FpBKHK2/si
         wIUyeFm2hAf5rwTCenEj2ajTHIc0GmsBMW4hVHF0JWx0er66N8Lp2MUpsu1N5RuQbXUn
         mI1wyIGPM0OVdm5sBUPYSk+DMs8V4hNl3LXhkYi+6hldYdO5Cpsy94YnLWKnUieK2XCp
         ILuFHHPaV5gcqFCRkRUj4/TzvVHZthpygkJ1XHksIos4SyaUJ0W1hpgujP0QxQJ0KqDl
         qmhw==
X-Forwarded-Encrypted: i=1; AL+hErHw2EwNZ7k4xUk9+x/n0Owg3s+ES6g6vmJ5hDzAGKG0P37l5RNnW1eomGHrwlmAPUEZdXQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8IzIF0jv42aB62Ijo9vuAULWyIn3DdkTSqcixZo1wmNegxtWci
	3Oxs1J1359YgDQSqPh2h5pmuioeXsfub83OQH/48wvZDbRKSnjYm1MHm
X-Gm-Gg: AZFdTZd7T7baBGvDb/H8z9be2SrhjmBdZgzT6Isx6dY1RMeTEpzOActk2nviSNLKIaN
	bhfm81BzJtBwySL0XaZF2JFR6r3e7hJHiZ0PgsiumJnMUnBqeF95HI8ALKvr0sjX+iqegJ1/Gzn
	AyCrDXfMnel6n6Wfbfr32peUPJ87uN7zQAAmj+6a6oC7C6InQqy1oPYUHozQnDDsE1UhQ/lrrk+
	bzl+b/s1Dfs7X7loChRFyADde3rLErePO58Ae/T9p4/5fI3r4WOLptch3GJtEvNpD4U3OucMqJH
	/1l4bmWqcF7OZzzHcwr8/en9l0snGNjwtWGvZ2LsRA5Zpi9C21SWaxV8I96BNt7N64khJXaEveb
	Wv98j77RnIIF2wVOeLoMm+7JcJqVAoDurB4Ywp0P/aGEtOMHtDMhgz1KB0QfVfW+7rGRAhJeG+L
	rXKbepsanWaHJnDlNgDrHjFEOonwHaVxteg3SBTAQe1flB0I8SNtnzgwI4zWbwhB0f6PO9dqLWS
	I6kvLlA1+j8Ss+Fk/9ePVVhtbFwsDu4+1r5s8r4uVt8ndKojNtEtQyfn+Drx4QAsMp2hbSPMHGv
	C36IkamYpxXkCk5X6zp/PHr3hJ//fYDSkY3iuOVsQXGABeQyZjgiCat+1r70YHSiBHeLsJ9yESn
	vvvp2N5Q=
X-Received: by 2002:a05:6000:2082:b0:4aa:ba0f:c24 with SMTP id ffacd0b85a97d-4abb3956754mr42004560f8f.40.1795705654934;
        Thu, 26 Nov 2026 07:07:34 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6ae2dcf9sm40652229f8f.32.2026.11.26.07.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 07:07:34 -0800 (PST)
Message-ID: <6a4e6ee3-cdeb-4766-ae3d-088a322ab015@gmail.com>
Date: Thu, 26 Nov 2026 15:07:30 +0000
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
Subject: Re: [PATCH v4 0/3] commit: allow -m/-F/-c/-C for all --fixup variants
To: erik88 <erik88@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Erik Cervin-Edin <erik@cervined.in>, git@vger.kernel.org,
 gitster@pobox.com
References: <cover.1790082176.git.erik@cervined.in>
 <cover.1795562078.git.erik@cervined.in>
 <bfb8aad3-7cab-4394-a16c-be743562eced@gmail.com> <awfzGjPqQaaCSRd8@vader>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <awfzGjPqQaaCSRd8@vader>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Erik

On 26/11/2026 09:17, erik88 wrote:
> On 25/11/26 14:37, Phillip Wood wrote:
 >>
>> I'm happy with everything apart from
>>
>>      Plain --fixup never opens an editor, so -c there behaves like -C.
>>
>> in patch 3. It would be much nicer if we didn't change the meaning of "-c"
>> when it is combined with "--fixup". Users who do not want to edit the
>> message can use "-C". I've not looked at how easy it would be to fix that.
>> If it turns out to be tricky then I'm happy to merge this as is and leave it
>> as #leftoverbits.
> 
> That's fair. I suspect nobody will use plain --fixup with -c but it's
> inconsistent if all of a sudden it means -C just because the --fixup is
> plain. What should work under v4s patch 3 is --fixup -c --edit, but
> forcing that is a bit weird.
> 
>> I've not looked at how easy it would be to fix that.
> 
> Looks easy enough, -c sets edit_message in cmd_commit()
> 
>      OPT_STRING('c', "reedit-message", &edit_message, N_("commit"),
>      N_("reuse and edit message from specified commit")),
> 
> so it's already set when we reach
> 
>      if (fixup_message) {
> 
> in parse_and_validate_options(), and we could probably change
> 
>        } else {
>          fixup_commit = fixup_message;
>          fixup_prefix = "fixup";
>          use_editor = 0;
>        }
> 
> to
> 
>        } else {
>          fixup_commit = fixup_message;
>          fixup_prefix = "fixup";
>          if (!edit_message)
>            use_editor = 0;
>        }

Oh, that's easier than I feared it might be

> I can reroll with something like that if that seems better.
> 
> Given that the rest of the series tries to get rid of some of the
> somewhat arbitrary restrictions on which options can be interchanged with
> the other ones, it doesn't make much sense to me to introduce a new
> "by the way, if you use -c with --fixup we'll assume you meant -C"
> caveat.
> 
> To me it makes sense to keep the meaning of -c consistent.

I agree that keeping the meaning of -c consistent would be preferable if 
you're happy to re-roll

Thanks

Phillip

