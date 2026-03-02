Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23303282F1A
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 22:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772491776; cv=none; b=twGlS4KpKTICjZgUPTVVNukY8FKwGF7uf9jUFhHbhOYIkO2GOxrtbHj/YBD8HdTZtzbW1AfbRVf9iUmdvEg6WsgWWnHO0YztBzs0K+5CTq6s4u2w8ElOxTilL7aUB5dX8WjEMnLvwdHVA4kRld3tZdIjheNkVARdYNpkrg9di44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772491776; c=relaxed/simple;
	bh=lALZ02ISRiztj70Mo97qM9/AIlTDGdpOkdoToSZGLtY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzFHxeKQ5ccb3UKUYNzabDuNzvFomGuCC/LeJ47Ym17HdeCVH2U13VHZwOO1b5yOwAsiRWVRlmVeT9Vy64PPgaAeGiNTT1x38qpGsYVcvI2wPHYQhIq2slwSUYLDKunV8JLsLTEKOfHiJyoZhk7bFHeR6RO6yEDmStDjm/lRJF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdZNlwun; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdZNlwun"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d4c383f2fcso3312528a34.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 14:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772491774; x=1773096574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8UfvQFU1TdGBFlkMIJuod2gdy8QXRI8rZ0mNbkxOQh4=;
        b=kdZNlwun+jLd2l+me3mhA/VKnVY5eiEft+OLN5JRg4TWfMIvOkThyPxwJpnbK9nnY4
         Y/1L0rl4+pmSoCVSJq7YbyLfGOsAwQrwQfbGv/UQeUWp9Flr5dLLZ0x6Cx0eA4P8fDxY
         ep/gq8rUDLso6ijTlcz9xFDGqvZiscftjYbjQ1BHXqGAJkrjVpSXDIZLNU/1AiZQwJhT
         npTOKSBtRvukP/O/E9eWb38SyE7LRW1A5lhVDC8mFZOJ3CHPK8f1ac3uecAgtR8SXVlG
         D89aAvNlW0YhNIjsv9vTmfmNcGgerdWQr/5ct1RhM/0SCpPpY4Ce2zkVm0qudXhYIzXf
         Gn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772491774; x=1773096574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8UfvQFU1TdGBFlkMIJuod2gdy8QXRI8rZ0mNbkxOQh4=;
        b=tlGDJMIvXQMAFPDYf3KSUgBkeA9SqYn9rKinhg08bOj1vD8nFoOi6cd0pO1w/dWrFk
         8ou8meKNQFZ5BtwF4906BRT25jEE+V6ZVV/yVR8EfnbCUmsu8BOPgD4fPR3pB7Yd11Ag
         Ie8IjiDzZ8auNSNguLGXPB7x07TaVoFnTxF4JVpDtfuYE5xox6HqImrUugwAOiyitzpw
         7SvG1ds8nR94KLj2EX/lJvM0L62/X2J4g2Wp3pVTPavZzL+4hB0VvGoRACrJr0kE4AIk
         gsl2vO2wJdImIoW+Lu4+KEOpLWAys1ESeJ2KZEqKD5KuRIMDQScG9QFzSuzALQGOZ6gi
         lv+A==
X-Forwarded-Encrypted: i=1; AJvYcCXMBBQsrV0XNtnjDU3BhJDobaSfoLO74U242xaNdSTveF4ebJxGVo0lpxr4bY68jDBsQHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4faY/gw3iRhI5j8oMBNZ2J5+ihV5soBqrMQQ3HAannnU1LlIR
	nAB7lCseXAiIShFmwlTJ5ACCG6i+Vlj/yHmcbAxdlnKADvrF8v/VlKzxSj37MA==
X-Gm-Gg: ATEYQzwxSy0Js7/icA+bDbARtXlBoyiDPQ5hrwVVVgB4vjjJrSXtzjuOUGNJtZunk9+
	ur1V/7nz/iYgKhsboh5JxhHpGYFwS49o8fydyPnkDNjPcN9euK1y8WIWnk+mVnALmuD6AZZIti4
	k8Apmb7YKTlKNoaqyc/s1Fqp8fghUtOpRQe4O3ocPjOlVL4dwdVWt/ZzfCzLMrry59Kd9Yw8jFz
	Mv8BnVPM7iZmBKdIH4D8bZzB73osI6XsoQN/wE0GeUY2e82tLHJR05zQseYBnhjr4zYKPMsq/lR
	5NXw+mjRVCQxxeNz07vSKPCNPca4FyokbrWEsOOsYx/nKRroxZtI9QGjyjf9txva0GltwVcGxMX
	jzsic0u3NQBXSMBfbyoEekf58xP1XRmyHcyVoFy43TUl8cCBVxdMWTBY0BT6CvfkvYIgJMkU2av
	9Y0Bf26DxZ3KLqXgKsJsVDpv41gYQ=
X-Received: by 2002:a05:6830:4197:b0:7c7:2c3c:690e with SMTP id 46e09a7af769-7d591c1adb4mr6960271a34.35.1772491774114;
        Mon, 02 Mar 2026 14:49:34 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58647439esm11753354a34.11.2026.03.02.14.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 14:49:33 -0800 (PST)
Date: Mon, 2 Mar 2026 16:49:33 -0600
From: Justin Tobler <jltobler@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	christian.couder@gmail.com
Subject: Re: [PATCH 0/2] fast-import: add mode to re-sign invalid commit
 signatures
Message-ID: <aaYStamdm-LCiaP-@denethor>
References: <20260223194146.3476768-1-jltobler@gmail.com>
 <aZ4pFUJApZosh9Gc@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ4pFUJApZosh9Gc@fruit.crustytoothpaste.net>

On 26/02/24 10:41PM, brian m. carlson wrote:
> If you're _not_ going to implement that in interoperability mode, then
> I'd rather you just die in that case so that the test fails and then I
> or someone else will fix it.  `extensions.compatObjectFormat` is
> presently experimental and the data formats will change, so nobody
> should be relying on it working as it stands right now.  There _will_ be
> more compatibility breakage coming in future series, for instance.

That sounds very sensible. In the next version I'll update to instead
die() as unsupported if we attempt to re-sign commit signatures in
interoperability mode.

> I _would_ recommend regardless that you add a test like in t7004's
> "signed tag with embedded PGP message" if you apply this to tags as well
> as commits.  That requires a special case in our interoperability code
> (since it normally converts things that look like signatures, but when
> we're _generating_ a tag, we don't want to do that since there are no
> signatures yet) and making sure we do the same thing in fast-import will
> avoid corruption in our conversions.

Thanks, I'll look into this. This patch series currently only applies
this new mode to commits, but I plan to tackle tag signatures in a
separate followup series.

Thanks,
-Justin
