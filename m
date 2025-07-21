Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD122E0403
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109243; cv=none; b=id+IiwQHgQHFQK4Ghs5u+l3M8cd2ChEdIaKHvO7175cTK0yl9EdMPObgrO9DEAdRV0z/P79ld1x7Gpepfcmqvz8Ep2KK7YYB0QDz0uLcg17gYAZ91+B8oBzyLsuItzUOXKQsD9MRNme1YRIh/W1XEz/Uc88SHF2zjFD5TVPPGko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109243; c=relaxed/simple;
	bh=40wD19iSEY8e+5tHJXCzhiScczH0TPmcYFyQuAlsXDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISqxL81doo+2rrCeIwt2keAjUm6mjf27aNYiW8oKCaaBIVAQONtkgINAEck0MDL0sg1pBrUdl4q4jthKKruSDAO3DYsg0DjZvDFDNm1AnDGA5TzenILQ5/cTnh6PBKHe+IBGDnu3NGR6SxevSphr/Y2n1kehVqC5tRJX9yO3Xb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jb0Ca2sA; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb0Ca2sA"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-73e82d2ec21so1886058a34.2
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 07:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753109240; x=1753714040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H6kJ/sDL4V0nWVNgfgDSLbj5zCq2RUNk7J15N1ZKRlI=;
        b=jb0Ca2sANejuiEvt99+bAruzvrf2rcbAGSzuLIwqYqNZpQv2JYtNdxa0Xac3t51kGn
         ik9YiCGtukOGuWfUhzHG1kceBJac1c2AU7eAdRwv7Mj5JL75gajxdGVUsTu7JaQAhBtb
         xS9hxA1TwIIciwEP07zysHgaHN83urhBrVvfvLx2ljD4yVDFNBp2zgoDZKVq7/iPheLB
         rJUtYZKpGpVSBPxaKVkKoMp4ZmRpOZXmRclH7maToIeEwn7LL2VbEcTGnyrUQvKtLhdi
         Zm8rmPboA5onI4q1bsCkp75EE1aIE57iXfyIrXfx8g1MUL+hNA6tOgOVapuAEuHi++EV
         qyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753109240; x=1753714040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6kJ/sDL4V0nWVNgfgDSLbj5zCq2RUNk7J15N1ZKRlI=;
        b=qbb4S0ixuArVl75dFpkC2+piY9L/rw/qgKUflRJcxeJMDLRzzMgy5MFTnkCgE6D/au
         33UmP+JebfAJASqmLnnWuiZRRbFBPnhpzDnKCwcc7IGgFO4Gw3K9p+7/NLuswisGwr1f
         iB6hwAuE/Gga96ZM4n1bcQPJEaKWvS2CFSGjkrvMlp1Cvf5H5o5YPiMqO40cgnKTbZjy
         aWPHbDr3F2yoUBpMr1GSf+SPTnn2mUnmVz6PNvW5Kxmt4Qq/k1lTLuUFLDnEbAD7NXyb
         87PAayzkVF0hIdy+5OJXNKiSvyPqHGOUCkZxIN7U1BmLAZGRiXOt5iC1ZbFa5eWXGOPq
         LGEw==
X-Forwarded-Encrypted: i=1; AJvYcCW8Auv60p5Cvg30vOLahq3cdpI610P8cCX7YojIVoSIWj1VU26giAoH8yLdZ/nAqvHgOQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxguxxob95fnN5WCuduWJHMYYVgsxKL+IbYXTa9MvrLSKbkgYXN
	/iChJg/X0IFml2dG5AX2iN/wZHPtw7ph5g9o9TVVH0FRr6p6d5jM28PF
X-Gm-Gg: ASbGncvupm52AknDdGuO+DeRXe7W7p+byYzUtRfIa6Joka4tGLoB4jWFzAzwrrtQfTS
	wdvYN3OAUXU8DiIABdBA4AhsX7c97u53REM2maSJVQFcRTTXBVPoF/P9xkYmBkUUCVKml6gBuqo
	dE+3LDf+BxJ5AUkeVdSZbkHoZsg9CouAlnKurAz35MEyhX9lBYOq99tAcpP8msfCExL3OmZrM3+
	UQZT6emqm8WhqD6l2vjLNRT7TKUIRB6zDiKKG1duXirziasRfFQuGImi7j6jNnXLtFrwSyRvhWP
	lpBCF4jfzzaLsQfe2hvxTndMhRuMWrjkLVSgxiDyVw8UEYooZ7fAHiMROACP/6TrHNr6RvMkmDL
	tDMFdAW7TlAGYQ9AbP1/Ntk6MNQ==
X-Google-Smtp-Source: AGHT+IG5eOwtwcuBK/SMmA1d/YxtkaOTFmAzEuq4tqYUh2fwflU25syJmeDB7G75NCiKFUp50us7Aw==
X-Received: by 2002:a05:6830:488d:b0:731:cac7:3636 with SMTP id 46e09a7af769-73e751b4cd5mr11591100a34.6.1753109239836;
        Mon, 21 Jul 2025 07:47:19 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73e8a7edab2sm2558343a34.40.2025.07.21.07.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 07:47:19 -0700 (PDT)
Date: Mon, 21 Jul 2025 09:41:31 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com, 
	phillip.wood@dunelm.org.uk
Subject: Re: [GSoC RFC PATCH v4 2/4] repo: add the field references.format
Message-ID: <z3lvhetfvxi5wylqielzydjkqyokwtzgsmwbwiq4xx5nfta6xw@2wfnmp2pzvcu>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-3-lucasseikioshiro@gmail.com>
 <mgdervgp34m6ipfbodsfn7cztcl7gdeggzemfgivzvuyk7qtba@wdijebkuioxg>
 <aHc6y9FGFXjowkU1@pks.im>
 <2v7b6mpufnn6cj7u7tactgu2ibggn4xpuezl2bsfjxv62afrsa@chfrii6vkrx3>
 <aHj0lF5Kbirzv3pZ@pks.im>
 <oir6mpubnuplnjatdhlyljslakmh72wlax4afuqnsiyob65xfh@5rft32ln2zvk>
 <6ED935E8-05CE-4155-B56C-A113926915E6@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ED935E8-05CE-4155-B56C-A113926915E6@gmail.com>

On 25/07/18 05:26PM, Lucas Seiki Oshiro wrote:
> 
> > So maybe we have three different output modes for `--format=<mode>`:
> > `user` (default), `keyvalue`, and `nul`?
> 
> What about `porcelain` (default), `keyvalue` and `null` (being `-z` an
> alias for this last one)?

Sure that also would work.

> 
> > For `git repo info`, I'm not entirely certain how the default
> > user-friendly mode would/should differ from the key-value one
> 
> Even for the "survey" part, would it be useful to have a key-value and
> another human-readable format?

The only use I would see if it a user would want a non-decorated output
that is still user-friendly (ie not nul delimited). There is also no
reason we couldn't add this later in the future if we need it. For now,
we could just focus on the "porcelain" and "nul" formats if we want.

> Another thing that I was thinking (as a future feature): what about
> using by default the user-friendly format and using the null-terminated
> format when piping the output to another command (like git-diff does
> with the colors)?

I don't have a strong opinion, but I'm somewhat of the mindset that the
output format should be an explicit choice. Maybe the user would want to
manipulate the user-friendly ouput is some way.

-Justin
