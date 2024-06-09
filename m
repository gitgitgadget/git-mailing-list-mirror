Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F320517997
	for <git@vger.kernel.org>; Sun,  9 Jun 2024 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717919105; cv=none; b=tFhluxH0uUScpPvE/QNnf74Dt+2GMPLuQewp3v8Yd+iMy6vo4Yuo3pVmrbFwN0bpN528L5Aq4ihrCT4MnwxEqXhHwwoeH8raIfZI8M4Vi2bypr4n8sI5QPPqZyS8QtcIngjsEk72/K9Y4jbFRTiQ0/EyBxGoy4EUZI//efUwRcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717919105; c=relaxed/simple;
	bh=rpTCNHsHyHgkydur6NHwnLpbAFJpGUmh1GnKq4ZvUjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lon445ZgSdMwYs7uguEvxzP2hUBuheOmOBngHIFwM4zRNekX3emrbFelhqWkhfbb1QGLesMwMxBgDrMhkzzsM6q+DMpKtacNdVu0yaHqZQEftwXDTNILgxozmcWZ4v05JMfXSQ494RE+jRgqOOrvPLVLNOzS5uTfg2Nt+5rQ6eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvip1r8/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvip1r8/"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5295e488248so3888712e87.2
        for <git@vger.kernel.org>; Sun, 09 Jun 2024 00:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717919102; x=1718523902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWqsK0I6xK4tKMYG9Z0Xj5ikQukhOh6WwaVcbUzfc/0=;
        b=lvip1r8/a9InSJHqPBea40BG/N5kQ3/HxOQD5QRvw/PzhDeGOD9fTYN+NEmwZyRNM9
         h50MgN1MYoIPERDlDtb6l3GGyP4M6TqdWGJOw/tCoCRj+iv66Wiv5+oP235gNkH1ENwu
         mgWgq1uE8yoP3ney3CkL1S/tg6fi7NLkpJnURlM2CQOvJZrEDbpUQy8VwWOTBXStBYtB
         Zh6asTxcQrPQwfEQsafVMloH3M1vDHwizJ50QZ99/Yx9FOKnz+J/HRuAIfMWEn1f7QmO
         Dw8KK0Rh+LTpXXh5uuLGXoE6w6ZXrX4NsxwiWi1mckQLmS1lwv+INQIOySbil6Kwm37p
         kY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717919102; x=1718523902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWqsK0I6xK4tKMYG9Z0Xj5ikQukhOh6WwaVcbUzfc/0=;
        b=wN43gGDl73XC4B1vnFGOxmUsaOzcNsNE2BPiRHY98h85Tdbed18ZjJX3ojo6eZyCrL
         M09IhAbcl5kk7NHYyw+Jha8H8VhuIYY4KcjNtlBiWL7CMnoVhTssAoZqybvItc6Vnw66
         nnIZCKRF8vF42vI8i8WaMOn7E2JHFGPDWxFgYdK2Ef1St+1w2y8LFOPhJMpGF4cFMjgD
         zgvINpw/cIEJpblrMVcgrEnJYf6+vSPqrcrxSCPLjqqXCwKhNX7AgTpGKcwRqvoahmJi
         wuCFMdZdFR3pQTq0iFk4e4poAwbOjxUMItp5uitbKneZohcn+rCeQk2yMAlaVz/iOR79
         pmtw==
X-Forwarded-Encrypted: i=1; AJvYcCXbejhy4peyzR0y8dc5hz1ZdbMR5lOA0E6cPLOH0ZrwDxKd9Axm3+e7eM8cqcryQbVhMTuGWquA5/BCc/ObF9ngpWhW
X-Gm-Message-State: AOJu0YzhWgu8p7tDQVkbWdRK12S+kct4kodcYbUa0SqKMIde+oaA5DpE
	psdhncLmcj80UZm4KXMo82DHhPRmbteuWKnWyyAfdU2ov8rOrrdo
X-Google-Smtp-Source: AGHT+IGrQfRhWTzjNv0MReNyMYKJN/x0YTsDpa2eIvtKFcvxmzQ71ojDCLq1O9j/Rcrw8B51T5GN1g==
X-Received: by 2002:a05:6512:5cd:b0:52c:893c:6c2c with SMTP id 2adb3069b0e04-52c893c6cecmr160237e87.40.1717919101767;
        Sun, 09 Jun 2024 00:45:01 -0700 (PDT)
Received: from gmail.com (62.red-88-14-48.dynamicip.rima-tde.net. [88.14.48.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4217f6f329dsm29868665e9.29.2024.06.09.00.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 00:45:01 -0700 (PDT)
Message-ID: <219a195c-74d0-4c21-bf54-0752bb5b01df@gmail.com>
Date: Sun, 9 Jun 2024 09:44:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>, phillip.wood@dunelm.org.uk
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 Git List <git@vger.kernel.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <20240604101700.GA1781455@coredump.intra.peff.net>
 <xmqqikyo207f.fsf@gitster.g>
 <20240605090935.GF2345232@coredump.intra.peff.net>
 <6056d585-6380-43e7-adf1-9f9aadd2a7db@gmail.com>
 <a8d3415e3913e3a0798a748ed7f7a093@manjaro.org>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <a8d3415e3913e3a0798a748ed7f7a093@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sat, Jun 08, 2024 at 07:54:34AM +0200, Dragan Simic wrote:

> When "|xyz" is used instead, the version of the hunk with no coloring
> escape sequences should be piped to xyz.

That is a sane and conservative approach, and I'm not opposed.  However,
giving the colorful version though a custom pager is a good thing to
have, I think, i.e: allowing a simple "head" without losing the
coloring.

Let's recap a bit.

Initially, this series aimed to enable sending chunks to the pager
during "add -p" sessions.

To reduce the blast radius of spawning a pager for each chunk, we
introduced a new command "P".

Junio suggested opening up the command to allow specifying a custom
pager, in the form of "P<program>".

The "P" command started to resemble a lot to the common pipe operator.
Thus, we shifted to "|<program>".

Some concerns were raised about controlling when to send coloring escape
sequences.  Several ideas were discussed to address this, including
introducing a new command ">", a modifier for "|": "||", and others.
Alternatively, we could leave it up to the user to filter as needed.
Or, simply, do not send escape codes at all.

So, looking back at the ideas discussed in the thread, perhaps a
reasonable next step might be to reintroduce the 'P<program>' command
and let '|<program>' be the way to send raw, uncolored, chunks.

This approach makes sense to me.  I'll wait a bit before sending a
reroll to gather feedback, though.

Thanks.
