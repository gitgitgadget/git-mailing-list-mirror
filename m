Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2099212FBE
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279066; cv=none; b=Pour1TO32d4NuJC8WdtThLctUXOoROAXBB/45faJmEpfz8OEFqWxWPUD+q5nD+WxHYCFkhqLELWeAJKeYEwtKzwpAq6XeY4rf5S0S9DFoEjUuPfP5Fvt68rjt9+nI1W4iOHUe7ksgkhgFi056SkGNwV+Shu81nrT1lNcM5NJngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279066; c=relaxed/simple;
	bh=oGMCRrlQy83AQTAeSzEnbTwP3llnQS99ArAP6OeNpLI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j4QDCVpghnEWEJMOZ/Qf+VWG8SJnepVHyQ8wA2qLF/TKE+IdYDbU6Gvg74IgPQxKDzpc7CQ2ol7ariVPQIeQ93QtnyG7lqVjTQgu1TXvbe4GYzCJSHkr8sHykh6jh4mR24xws8dqHQgF97LzY0gKF0EpMXGyGZCMjvBsmscpolc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9cy5sIC; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9cy5sIC"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b2f0faeb994so165289a12.0
        for <git@vger.kernel.org>; Wed, 18 Jun 2025 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750279064; x=1750883864; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2p0Kuf+2jXdJj1Lrq53JC8GpffvRwpUvZ/woQ5KkN3M=;
        b=T9cy5sICkmCXMgTlRzrE/33BB0AkufXTWveBIBoflId06JiwyRztCQfBxEKHLKBn5P
         LuviUkFHR29If5wKdhCL4dWZUozbVYAb+TRF7/K9fqMG8M9IYBUaOA9E4VhRxp9JthqM
         aadfBfkUZM2P9vs9D9gsDIP5EVo0Uc6dX4M7a0qYWMpr1PPE3S9Oa64Rw07L58JTWPiT
         5KGvCwfGUmdHlce9hH2ZuHPWboctQfHaIfpTCiGTAFA7wJ+kqYIEfyytTdfwK7y809LC
         OwMPAldX8IKxvNSMWKBqYoSx82l9EcG8CC8iCdlKOnME91DIVvfQ75P7c9nikujtJ9m+
         8cCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750279064; x=1750883864;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2p0Kuf+2jXdJj1Lrq53JC8GpffvRwpUvZ/woQ5KkN3M=;
        b=vytqEqejhKlYsyLK3Y/xrc1fhIEPAKsZcEQJhvPAU8xFeCHM76pFVvE7TY48KcGBdk
         wun0bVVGYIrabgJZBf9j0qhuOfryteyPNSWESle50b9GY39YG7rEAHg8adfTFf9uJK58
         Dgg+jxmSExXMIc/8bmINriACnRtSOPE15Ienwb9BZMCMJJNFtRU8aFYgP6u9pj3Jnj6B
         6+XjG/SkZ0xDQn1CpqgSx8LOh6hVtf5/kKYHVs0vZqjlXFgGICrYHTVWQd+crZH52PrC
         JxEjjlFAoI3RZ+4IsrgsuhxYl1PBzPhf81Jp5xDKIo8/RfVzP9Eb4B1UZZpUfdolQahY
         mV2A==
X-Gm-Message-State: AOJu0Yyz/+lB7OdU+5qVwH1RVN4RwBN0cSXErCMA5U35Rnp0JLAgexqW
	FXxrZWvdOODWksVv3amHZBp41JLLfKXBK9k/LEPboBO/sanJ6ImVtYjG
X-Gm-Gg: ASbGncvFi4DSkb/LIcq3ux1rK/wlg1/zrrMEIy/Db/nyCZzDeGI1txh0bVpCn/lliwN
	lEVqNRnSj0c0YktBOz58Sr2FV6VKrxJaQNGsEi1geWpup1mrKk/+g6m3OZAkwe4lVzcoeW0fzI2
	NPtOykWdvseFA4AzDuXXt6Us9PnnK+gT73Cxz28o5nthL5Mzl+/1v6jQkjXSyi0SQ5T+GP4gPtH
	6EIrCg4NoVQdRyP/dcxGl77AAsrJIgseqWep8WEn4nyHWsSwBjAN4ruRGbYyDUDfT9KoP8KLkxh
	6rtkVffa7h/4P6i+zIeIBgxkPebVT2wLyxYUzWzUOVQ=
X-Google-Smtp-Source: AGHT+IEPb0pkeBph4tzR2vTe81swkcdjHSfbEXxBE2B/7k+KdWkPcaWmAm8060MA+F6muaqmI9z4cw==
X-Received: by 2002:a05:6a20:158b:b0:215:da29:149f with SMTP id adf61e73a8af0-21fbd65e1f6mr29471699637.25.1750279063921;
        Wed, 18 Jun 2025 13:37:43 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::de7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe168ccafsm9663539a12.55.2025.06.18.13.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 13:37:43 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>,  Carlo
 Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Subject: Re: [PATCH] diff-no-index: do not reference .d_type member of
 struct dirent
In-Reply-To: <xmqqh60ces03.fsf@gitster.g>
References: <xmqqh60ces03.fsf@gitster.g>
Date: Wed, 18 Jun 2025 13:37:42 -0700
Message-ID: <874iwcss4p.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Some platforms like AIX lack .d_type member in "struct dirent"; use
> the DTYPE(e) macro instead of a direct reference to e->d_type and
> when it yields DT_UNKNOWN, find the real type with get_dtype().
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * get_dtype() was designed for a typical
>
>     - prepare the path in a strbuf B
>     - opendir(B)
>     - loop over readdir(B)
>       - do things to path (B + e->d_name)
>
>    code structure, but because this code path does not use a strbuf
>    (instead the path given to opendir is a "const char *"), the
>    entire thing becomes messier than necessary.  get_dtype() has a
>    short-cut to avoid having to concatenate path+e->d_name and run
>    (l)stat() when e->d_type exists and known, but we need to open
>    code it here.
>
>  diff-no-index.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Tested on AIX 7.3 like the previous patch just to be safe and it works
as expected.

Reviewed-by: Collin Funk <collin.funk1@gmail.com>
Tested-by: Collin Funk <collin.funk1@gmail.com>

Thanks,
Collin
