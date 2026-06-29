Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AC738A718
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782733800; cv=pass; b=rPnwFoyrGbZV+R/T3cx2SMJWj0meglsbOLDjynKIogHC8nGMlmdix5acqRRaSUpqyeQcBhHKefDVxp1MJcGsYM7y4zpLTqXheJMBO8oWX0zLkWmfVrggxkN+2vnq1pZ5Jq4tWH6oiIIJF9qAmwjaKh1jcgybIlUpOwZJhAKbEVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782733800; c=relaxed/simple;
	bh=iYKWXAspyenoP8bMcNmxkf2ZKuYmgUzWy2/UHRGCITg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ft2W5YJV4eJiwAmx+zkzli1iazLiKXyYpOI17BibUxgoUUAaf0YJf3rfwgM+HVn8HxvyGVWeIbuhnK89sF/BzyzI0mHLZ1UMAuFMYR0jP2PGoiwhGLf1YgqzAvrEs4Yt2MHbj0GG5vmOrKmMAGl7wj5kORNQ8t3TmZmv9eSmQ20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dyh6Rofo; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dyh6Rofo"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84592b55832so1526676b3a.3
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 04:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782733799; cv=none;
        d=google.com; s=arc-20260327;
        b=roqPiEgeANAwLPE6KFTZOBNJs/dCz/GToXgh6lju1vmnh8dSr9vOnpF45lniDVUWKv
         rSaAomYpwbhJt0dfPltEQzyoQftb8MEITjQksjKqM0OYKc5vyXuvGovzhtt9A842JH3/
         rGuyWNXWOkTqaXnHw/aJYCjXTSbCM1pI1bIVKZEvRftg02AUOGU2vydSKT4+ZUmyqNhA
         Ok8AIpyWnKp2NYZ86nX2lRIl2LwEmyFS7eYLFoQP1bVrT6IKuWwtmVsylTq1yTV1cHUb
         W2KbVDgmBKmMaKMtuc1FU7NCMq7kvOisBcOt0AxD5uv+PoJNeAkFL8vs9mwYY6sqkQLt
         X3yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iYKWXAspyenoP8bMcNmxkf2ZKuYmgUzWy2/UHRGCITg=;
        fh=xFkGNlwBTIbSQlTAuP7IICOn+9qF32ywGtU2a0gtYq0=;
        b=R+WHcsYBAK7SdlCxHOfm+eK7qF84iCEzKiSNjH4jvWT1x9oGinM91Ii/x4OxfjyUF7
         8JjM4JbE2ECwAaQ+1KfB20pv2XTqDUCRjdT40V8g2OaazPJq5RRVsRnanuzoLehTDXiv
         d4GxyitOtEY7MS/Tur2/SUIz0sI5mcprtd7sD5RMj2YpOKIMMjX7vSlK5vz7aHhciC01
         cPQxVNDNwIfPtM7oTqpI1PPU+J8AqwRy3dqk/4/pwuD05Vv4NfjOr96PV0WjFsAyHkck
         xhGhNAm6JPcM0rz1CHFpiQPQ3Y4BgyyEOFi1vphAuXK575gzShWJouLtxlzO1S4pxtMv
         m6ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782733799; x=1783338599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iYKWXAspyenoP8bMcNmxkf2ZKuYmgUzWy2/UHRGCITg=;
        b=Dyh6RofodhqD/5HVps8p9USXYyGQNHrLBLzwneGTg53ryo5NNKTz5oGt1RwBarwoMK
         DS6DIhxWFcUunhuALqXovrMcxj6I5IdEYHddfS8b+ME9beXz3oALh21hQ0VupC7KwIqU
         PDrJXENpT6tzK0IMMTFVI29TcUBkhs71ISRosb755vRyWf9hrCgDcChNRiL01O5iSWwq
         7yNzzxz0kcBP6QW67gxwqRkecE5JUmMJySPAv/aKRnsoZj4qkwPHo7upDN5ldPkB2j7H
         vOYtZ+tU5nKtCWU4mso/7iu8aeHgJs5cdlmmDykeC5MsKT1fEE64VZNKFBfyHIPeSxMZ
         Z4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782733799; x=1783338599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYKWXAspyenoP8bMcNmxkf2ZKuYmgUzWy2/UHRGCITg=;
        b=qEoZuBj4MVb7wBoadRZHp48F5sM5J8MLeUiatlBvYdOUA43wDMjMDA6qxrmlEdai0a
         lXyeonmt4mSJVXUNZC7H3MWM2buiDqcteb60zTiUEgYGXjJstC4If9b/xQceiyjzVIdb
         /n52ttiiiG02h864lwUgNG6TAbq+F7YEU/L8N4y9F90M8JBjrRkWPQHrRWi4+rIMjtON
         EbzdSOGdPwvs4PQqXGIP0E8+X6bXR7FW2Oety64QvIMdJyu+J7eZEilZM+CNSf1kPAO5
         5zcKoRsaAOZv76UjJFPxbjNMqxIqaH5i4+7IefsKeljw89Wmh/Wk116dsuRC9rr0YBin
         Hc7w==
X-Gm-Message-State: AOJu0Yzaw2wMMe5JXZNdRBy8r7B2HERRdPmqbC5iDZ595SJ/gVBg+JGh
	dSxDRu1f7zdpcdtP1dFR/PufLBQtwEtIFE9UIRbH5Fpo2BHjHkA5z5aCGY5MetOADEqC5LPEPGm
	ovS4qadruhCVRNayEFzpQ58UNtbfL0QAMd0uo
X-Gm-Gg: AfdE7cnWE8s6B336Kkg44npgNHUZL/6K9nsGF/ymuBJO/K/E29nke9hB1Y2LWwPSX1U
	MXXVL4/7lGknnvOy5jgfLsg/RKcnBjkmCHk/wfRrXjm9392za0d5nksyvLWVDrE4WttZ6LiUYrl
	e4dm/EYnbmZwFY9+K9V58OGz1adQ7+NXeKL1zoOhiPxbchnnH/KswLu7wNDzdvLecbfMPCdELuX
	+Jr3Zd0W95Lym1MUrfxkcFjxgc0TWmIffRn4itS8RwxF+WYNkXY+yzw8y756OMfByQLBYIYpiX+
	X5/RwIolgU27yhpIzms3+HjXaoIo2SBvo4rutji9qymepTBx/H1MQGzEvDgpT6HjqJge7FyrhPu
	ftI6ylKs2GVWjR0/N
X-Received: by 2002:a05:6a00:991:b0:847:7ece:3426 with SMTP id
 d2e1a72fcca58-8479b0488c3mr113518b3a.58.1782733798421; Mon, 29 Jun 2026
 04:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGWgyh_WJ2mAgbJ2agp9UQm8iyR=eq0xWjdYT59CC9fZTnAbzA@mail.gmail.com>
In-Reply-To: <CAGWgyh_WJ2mAgbJ2agp9UQm8iyR=eq0xWjdYT59CC9fZTnAbzA@mail.gmail.com>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Mon, 29 Jun 2026 17:19:21 +0530
X-Gm-Features: AVVi8CfL_M5d0ciuAlSm6RggUgEDFG2-YJkzS41CugUVeg-_n7cbxRaSQt5T_oA
Message-ID: <CAGWgyh-Udy9p9yF_8EDnVgK4bxyG9BsX1gio8oKr0G9b-sdQFA@mail.gmail.com>
Subject: Re: [GSoC Blog] Week 5 : Improve Disk Space Recovery for Partial Clones
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

My latest blog post, covering week 5, is now live:
https://siddharth.shrimali.info/#post/7

Please feel free to review my work and share your feedback.
Always open to discussions! :)

Regards,
Siddharth Shrimali
