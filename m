Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED08481DA
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuNh5/FC"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e4d64a431so19670585e9.0
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 04:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704890407; x=1705495207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7lXV0afYmrAmO5yHhvNRrFYlEv3MS5MgAmGtqGk7CLQ=;
        b=TuNh5/FCMW0gGL8Et1iXMSnHxATjUFEureduAZSKzNh1ysReEwy6O2g7Z7Ql66Sjln
         6A1aTlbLq2dY1MMzfLeLWXZNO3TJ6u81znIwfNPkEnfqlZnLIGuQThM1buCYK75hKk9s
         HVq6gajaVVvQyGCCsliG/8hs1XRhWjiRoiECUELRN5OXvYHnjH7yEUegI8iGomuwKWiT
         e5w8NjM2r4M4F2oL0R9MctjNiWvVrdNT2Ifh9E+zYrPHfWwfeND+Nq3YioyPlcxDfCrB
         kOS2m+1Q0KtM41XjkeU4qRh6Xm0Fgp4R5w3YXhHct4NZb9Y5S328Ppw32BK6ylhVcSeg
         jllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704890407; x=1705495207;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7lXV0afYmrAmO5yHhvNRrFYlEv3MS5MgAmGtqGk7CLQ=;
        b=g/fFwQNfsGZZU/RGo4sKFGTneoKz14RsMncWByyhcF6xT8xOAv4hCK4dJpwgMX/ftu
         MaXBDwUXgZIPHmASepWLUBcFO5nhwZv03SjUD3FlOhad2nt91KDlsYJGxSpZM2xl6Flh
         XvmDo5nZGxyfHV5rHqez0HwHazJqhTHnNouhsENJjTvFAFUTOicRMi2g/YVdtFehfx9K
         9/tOT5tHZxn6+dB+ngQL8klEGI5m16ZvibYraLRgy7M01WM4Wdr/w/glqZE5Cb/hT8lE
         HuwJqS+deS4F0XozkchCnzj6xEX+nO7CzoER5xsDOqva7JP5U0m4S3o/6o6HhsMP8gpB
         r83g==
X-Gm-Message-State: AOJu0Yzsq1WbuiKx78sq1TjRImDqpGvRsmvIeB4FbnCPR5Mm+dCm6iti
	poUzOaRrWKs1laggqZ2ifUg7w5WfzsE=
X-Google-Smtp-Source: AGHT+IGhong6Ioz+LXC40liAJeA+Fm1RBL2oBgtS0JFCZtLICOz6bbMxU56VCViTfDar3I8rfGAK+A==
X-Received: by 2002:a05:600c:4e89:b0:40e:5947:bcf9 with SMTP id f9-20020a05600c4e8900b0040e5947bcf9mr271404wmq.18.1704890407486;
        Wed, 10 Jan 2024 04:40:07 -0800 (PST)
Received: from gmail.com (166.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.166])
        by smtp.gmail.com with ESMTPSA id t21-20020a05600c451500b0040e3ac9f4c8sm2050539wmo.28.2024.01.10.04.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 04:40:07 -0800 (PST)
Message-ID: <a3f7b606-afef-4cb5-a97c-caf07d3c0d4f@gmail.com>
Date: Wed, 10 Jan 2024 13:40:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] allow disabling the automatic hint in
 advise_if_enabled()
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
 Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
 <ZZ2QafUf/JxXYZU/@nand.local> <xmqq8r4yf897.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqq8r4yf897.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09-ene-2024 14:32:20, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:

> that configuration knob is probably misnamed, as you
> pointed out).

Agree.  Maybe we have a better name: "showDisableInstructions".

> I would understand if the proposed change were to change the
> "advice.<key>" configuration variable from a Boolean to a tristate
> (yes = default, no = disabled, always = give advice without
> instruction), though.  IOW, the message might look like so:
> 
>     hint: use --reapply-cherry-picks to include skipped commits
>     hint: setting advice.skippedCherryPicks to 'false' disables this message
>     hint: and setting it to 'always' removes this additional instruction.

That's an interesting twist ... and intuitive it seems, as Peff also
came up with a similar approach.

But do we need, or want, that fine grain?

Using advise_if_enabled() allows us to display a hint while
automatically adding the option to disable it, _explicitly_ (so far*),
to the user.

But it happens that advise_if_enabled() itself has a hint to give.

My goal in this series is about giving the user the possibility to
disable _that_ hint (in the hint).

The user choosing to disable that hint is telling us: "I know I can
disable a hint, stop telling me so, please".  So I don't think
this opens up a new risk or problem finding how to disable a hint.

    $ git -c advice.showDisableInstructions=1 command_with_a_no_longer_welcomed_hint

Is there a need to make that "hint in the hint" customizable _per hint_?

That probably means that a new "make-it-always-for-all" may be desirable
alongside the new tristate yes-no-always ...

I dunno.


    * perhaps this multi-value possibility could be a path
      to explore what Taylor outlined in another message in this thread:
      the possibility of a "one-shot" hint.
