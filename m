Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702931355D
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781804939; cv=none; b=VNqxo5arnvG2GRn1MT06rjh9hCyFyBbBD2dsGXaauTIp2tEKn4ksViUgiZ2HcHT2f29IXvpTWuS22L+Ra+ZGOI3uJMu6tpMJv78jak0fr0uc7VHxDmH2FVQRGRYoSGuVj2ju04Pgu5u2mTFHZIcCP25RHcPVboF6jLcY3ljdFpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781804939; c=relaxed/simple;
	bh=p3I1SglmKO4Z9guCA2iQdEjzebKXMqgAUWoRdmUxIlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLdSXCqiweIgUSAj7YEE1kSTG9Iy6gLUI8g3Aggx6cKqkKMnHaKEnVoMt4CmDnE4r5fxQbjJIqroArcXpKIDFh5z9ofkmAWxPYlKZ3TqoeeL+LmGOZtEqbG5hrp8KS69s4z+9SRvV/FTGquaQL+YIpgf9oPGvsR6YvWVO7Sdmkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZOzLY70; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZOzLY70"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-69ed219d3ecso966923eaf.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 10:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781804937; x=1782409737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8vrBqIhhq5Y/oceVBXjvwerX8lZCYI9hegcgtMbzSU=;
        b=cZOzLY7000UoBlii+iGDMDxicaQiWeZOhIW3iaF4kwQK8UcC7uxkwB2vPKWZBA2/tm
         hp3+1apNsAQ5UIrfdK5RnYjUpit06Jmy9Dp/34aAgLs812dC9e50z4OADJIL6Xy/Gz7f
         kM3GBTrdTEyCrYSSxd5bjd26RfB+QHzR9rrQJWeYEqJP2EqZq/C1wyZUj5tLEkuH2Bh0
         BkkFgoW0pfXKK/Kuy9bmwmwZaypnhr/bxvUjljD1hBZnJhXOPWV+y8AM/O7RJMzPxSeJ
         5CbVZbO9Tr6Gmg0hQTv2jK2gdbBkA3i9Os79B24L6A8pm8aFEdVjnupCF0nsfokFKeHg
         T3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781804937; x=1782409737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8vrBqIhhq5Y/oceVBXjvwerX8lZCYI9hegcgtMbzSU=;
        b=ScwH6TL7u4OOV6YiSs8mo8Nz+BAyfRLjH9yFyikrT85RXUNbCx91ov9nctB/EPtNBG
         WNhno1M0LStQlLKi9JCUKFm7j/vcjymSb71b0DAT9fF5Y5a9BLBxuZvmILKdqVi+Ue9J
         yeSolTzTOTfp7fbNHCAQIaWpyI6iJoq1h7MiMIRqdZ3xpDJg49eoJmFrHqEWUSk+9KOT
         jrheXkAC41PZxXTHc8hwv/KHjJd8rjgf+YlYT2Voc49bUJ4j0JzuAMft28+/WRYItL2n
         wTZ3XvrjvPS9/YxmzJ3beqUUd36aFqtPCXjbt/hi1yvk6FXDRU5z5z0ID3VPFKpm4n7I
         SEKQ==
X-Gm-Message-State: AOJu0YzHQqFKFVLFekMTcSOTbWcSy4RVZjwDPwkvUu6DZGtfvfa+A0nC
	XHDVtLiPqmIu6cm4+GYhCvrawCA9CvAy6qvV9ANoc4y+41srqLjW02Xp
X-Gm-Gg: AfdE7cnJWh0Cfh1q143vHf7Wb86Axuxyzd6hErL61UO2tgr2dG7d5+M0r32/2lFvFwv
	8qexDAqadky7JxE33bcpR/6deTpeKNBBPb8k4MfeCPKR6RyrFz2sI9DBAgbwIUVSNsWHFtKZiGA
	V01F3FRjrtRecJ+d45dW42OPfEzxjkEQ7iebZuyZn8FsBSLdXOU2YbWIRXPh1af3aRW5J3/Ajqy
	CGHaNJHrJRtCAWuqFCMPrCEAQTkshbnGg+DVLbMWGyK+aYQgMhdzsRBTJt3ZSsjX2x7OBZXgmj1
	P7ly0239RaNBocC1h17HLvxm/BTskWN+CjeFfjCMoRxCTDVJl/YJxJLMjKK1XuBqXyuIIzyYcdV
	clf/Fka7o6mq0wkGaSevak/bxcPKGQdY86IPUUxjLCUWEjcejlOVg2gRg2NQWBm0LwizRXSgTT1
	31Wn/lgQahMxCMd0I7
X-Received: by 2002:a4a:ec49:0:b0:69d:cfb6:4f53 with SMTP id 006d021491bc7-6a0d8bd96b9mr332803eaf.9.1781804937168;
        Thu, 18 Jun 2026 10:48:57 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44709d24619sm60990fac.8.2026.06.18.10.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 10:48:56 -0700 (PDT)
Date: Thu, 18 Jun 2026 12:48:55 -0500
From: Justin Tobler <jltobler@gmail.com>
To: calicomills <jishnuck26@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] help: prompt user to run corrected command on typo
Message-ID: <ajQuqTB580gqNP8D@denethor>
References: <6a340006.60da1a74.20db39.8f57@mx.google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a340006.60da1a74.20db39.8f57@mx.google.com>

On 26/06/18 07:26AM, calicomills wrote:
> From 0dc9e5c4593611b75e7003e8fdbea9370524c05b Mon Sep 17 00:00:00 2001
> From: calicomills <jishnuck26@gmail.com>
> Date: Thu, 18 Jun 2026 19:47:12 +0530
> Subject: [PATCH] help: prompt user to run corrected command on typo
> 
> When a user mistypes a git command and there is exactly one similar
> command, git currently prints a suggestion but exits, requiring the
> user to retype the corrected command manually.
> 
> Instead, when stdin and stderr are both connected to a terminal and
> there is a single best match, prompt the user with:
> 
>   Did you mean 'git checkout neo'? [y/N]
> 
> The full corrected invocation (command + original arguments) is shown
> in the prompt so the user knows exactly what will run. Answering 'y'
> re-executes git with the corrected command and all original arguments.
> Answering anything else exits as before.

Isn't this already possible via setting `help.autoCorrect=prompt` in the
config? For example:

  git -c help.autoCorrect=prompt comit --allow-empty -m init

seems to already do exactly what is proposed here.

-Justin
