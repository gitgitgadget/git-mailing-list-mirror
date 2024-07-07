Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E620D2263A
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720363654; cv=none; b=Zan0t3RPGRR7iPab9UjutKTAprSd3H3HOfFPgn1vYquz2veL5b1IrlvS0O7pfSxa8w3DcZ6r1G7gjftG2s7XUVEjjojXdTXM+hT6LE7Zn2MU+1T92j0uR1FMXSqDZekK0f0iMyMN+0ezzvYFtWF/f0gynmGPykCI3E3QQtfjjQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720363654; c=relaxed/simple;
	bh=MTg9c30x2uRztB7qsmd7NyKEiz1Dc5U3OXhw+5bI7sA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ut57OVx1gvD0dVkJqxetYQYsUJK1LIWpDTThdUrfSJ5VIylQBbSZEBcvDPVEXp+Q1BK9SH0nFDqEzVGwvufS42YV4GigNm7Ncm5095HpaLxD9OdCKnbLcZkBRj1SHUjc55Gc6IFfn295Xon2bW1NntrmelhuWGuIb9mWhNjwvTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNtoqUuS; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNtoqUuS"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52e9944764fso3520603e87.3
        for <git@vger.kernel.org>; Sun, 07 Jul 2024 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720363650; x=1720968450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LxD3qtlc3eTsglKkAFP8qIP1/oI8s+jVYnfJ8rAPfVs=;
        b=NNtoqUuSsVS1x4Ju1nNOtAIPeDPC6pyb/ktDPN3ItsGIKbp0HjLE4fZMajb6XNFENA
         /lo2kyjbQKOAUPm1ytXZSitvisC0S3gDGdeUV/WqcEVJOoFMQJ4XPB/czkEDK8AztCgC
         W5W/7IrLiWRx0gHkNl1RdX63srWm1G9/M5SbdRw3pe/XFjN6lTOq3vUUMGIuFN1VkMXc
         DStlOphu1n6D9hNUnMJjvx0p+ZV5KdCcR+jvZGgn7FhPKGWf1VTI8Z75MfrV8kFW2Dtj
         X2U4Oy/c4vJpD2bc8rOL9sCwRbKuyhJqWVzEhd5CNfcbcTlvgPq0FOuGqOCFkX9m0Qd6
         C0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720363650; x=1720968450;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LxD3qtlc3eTsglKkAFP8qIP1/oI8s+jVYnfJ8rAPfVs=;
        b=MndAFO+uVl79G2H4dtt7mLJ+da0lkDTQqw+lv3bvtbkXXqkf8XV43oSpVPKTzPQ72n
         ge0g/QKxs0BWxbm+8dgYkf9FYcqlGjDO7vMlfdUeGf6zEbYx2C6jTlx+/YLguQ9a2oBD
         PtBG8rugu38YdOYOSs7bvE5Y9f1Kjaa8nwE3GuimHIx7JGAj2BWoTIFy6RVnI4l4QJSC
         e+gJSN5s9jtQ3xgxeX/Bkm6OWbgYF3glzePlrnUl343ZcnGiSD+C76HYuW/i687GJCOW
         bJQ8dBmn58U47YNPy/6S3grZhXbUD3H3IrfeBCWMtrYzGgFCa0ISVJvHiv3ScaQ4cNme
         VMfA==
X-Gm-Message-State: AOJu0Yy1VkV+MrE87yoYtwg6YJ/Xxbcplo8oLi6BSNHfSG0WszkjwLwY
	/5yXHDaweMuXwyxZhMuDDOGsuhOW41wxmJy7X1MfOP2YL+1RnGXvSMFz+w==
X-Google-Smtp-Source: AGHT+IHZCZA5PBSU+zM30fr+Y3iHlrSdqZZCyCMjMitPbsIrbMsmJiV1oNbentG3Plnjmi3UqgxJ/g==
X-Received: by 2002:a05:6512:484e:b0:52e:9df2:7de0 with SMTP id 2adb3069b0e04-52ea063a83amr6847525e87.40.1720363649912;
        Sun, 07 Jul 2024 07:47:29 -0700 (PDT)
Received: from localhost (85-250-79-206.bb.netvision.net.il. [85.250.79.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d69d8sm130275335e9.19.2024.07.07.07.47.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 07:47:28 -0700 (PDT)
Date: Sun, 7 Jul 2024 17:47:06 +0300
From: Doron Behar <doron.behar@gmail.com>
To: git@vger.kernel.org
Subject: Re: Re: Remove your ZSH completion in favor of the completion script
 distributed and maintained by ZSH
Message-ID: <e4ylt2rihvm2uc22irsxbeid57ijblioekit3o4xpufflrqwal@5t67kr2a5ahq>
Mail-Followup-To: git@vger.kernel.org
References: <mrn75pj663u6ikkwfnoq6c342l7w5plfeju4ji7norsmlzx4jn@3se3fmuqes4p>
 <87cynpnv8m.fsf@igel.home>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cynpnv8m.fsf@igel.home>

They don't perform any version checks as far as I can see in their
implementation.

Almost all commands that the ZSH team maintains completions for, don't
perform version checks and the maintainers of the commands themselves
don't bother taking responsibility for that and usually users don't
complain. If a ZSH user notices a new command or new option missing from
such a completion function, they can submit a patch to the ZSH project,
and setup a workaround until there is a new ZSH release with their patch
included.

Besides the option of living with this potential version mismatch
imperfection, you could also ask the ZSH team to remove their
implementation and start maintain their implementation here. However,
they might object because not all distributions will accommodate to this
change in both projects...

I personally think that Git is a stable enough project that the commands
and options don't deviate enough between the different versions of it,
So it'd be easier for you and for the distributions if you'd let go of
your implementation.

On Sun, Jul 07, 2024 at 04:15:53PM +0200, Andreas Schwab wrote:
> On Jul 07 2024, Doron Behar wrote:
> 
> > ZSH completion is almost always distributed with every distribution of
> > ZSH, so there is no need for the two projects to maintain two completion
> > functions for the same program :).
> 
> How do they keep it in sync with the particular version of git installed
> in the system?
> 
> -- 
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
> 
