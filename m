Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5CA1BD9D3
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319382; cv=none; b=V37aJE+xoHNvzOBtRB4/3GEOkRntKmCdsXH+kR2UE0u8vNazN3MwxGYAfE3dkDNokFiZeluvgmEYPckUFTJMM0m8Szbo9IqYQXhl5/yV7tUJoOM0J22QImtB0Jl/PQpMd7Y5+kclvcDyXi5CnsDZEtIniOooEd9iNunNvIp4wNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319382; c=relaxed/simple;
	bh=rTYuhaQIt7Jz7QY7szJvsHdcyFI4OtuhqpYrU29eix4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ah6EmkcSnpcBF7dNhoRQF0Octhk+2n7Dq3Ru0hrhwRa3jzP7ZuaT4SDDR+KX5M5KnQ+S9JehP2OX36WR+sOBzfxOdEx2WCPID4Y3xM9iVSmkkdr+GGCAyvHgX1ze5lfDPAsNq+aUyJdZh2fT2ehF2BnxjKXwwmC7J1bN8zHPg7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=QJBdH17b; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="QJBdH17b"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e59a9496f9so2478507b3.0
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 13:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730319380; x=1730924180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rnh0uWsvGT7lInv4y8sjgXzmTVNJ2lV0vac0j6z27ro=;
        b=QJBdH17b+nfb4lCh5opjzoO8BOcyD4hDJ48trr/3DzdXHx3YPODjem1Fy5T2PatJMg
         BG571eqhdmstM0BZqUCYMMIJOdMoWobIiuRiHPIELgRYc7aUPlAwXVNJEHGpU8uAkbU9
         tVxgoNioWiHMkTyKtumAPDxTbTakm6oHuUK5qTZsRgR4hTD8gGslz8ldGBnOAG9xtQp3
         tdr830Z2llBLrB7BJw++O/9WVRu9IAYoSxFlE6c5AAFjxe80KfCVmgpZNhoeEj3F1NDQ
         3MiEI+V+08lZL2GqU+KbdoQo2eruirdZExrGlHur9VgW6L3NULRYGoOV9gGKVipnjgV9
         +Tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730319380; x=1730924180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rnh0uWsvGT7lInv4y8sjgXzmTVNJ2lV0vac0j6z27ro=;
        b=I9Ahq7RcFpdvUB5SF0DwfTnVgJbr4RgoESI3T/85HCmVW10mHIESBw0QDka4CRE4vY
         jM69qztHIU41E2bibukwpHp/BpvsJweptzghTjQ0FOiubBBrieqKu/Mxmawa6rqV6HgA
         7T22EeKiYYMbFplpy+14YBGNZCYqdOkLiJOXuvfQhhzIyOAC72257JuVaQ1j4Wz83WET
         jHDuedYDaKahN8WVfzyx2oZLN4Zs/c2oA4Y4qISCqi3WpHqXKqdDZOCBfM1jPlGmlStY
         bcZbfrv4txslPqLVydttMgGAvOiirD0hbUkqSPy2ig9StOkRV3yvO10RETqWFOFAMerY
         ahhg==
X-Forwarded-Encrypted: i=1; AJvYcCXg4w0c1YIRoT0ymy8obhw+L8uFQEwDmpI4MVWZaEOX9gE3Zwegt/0ppfG3FO1hk9Yx/FY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3LB373IU952RRC/xh75KFDtY4mQglzvomtPCvhwxBarxIZIg5
	50Doj5QhUF95wEVmXhvTx1HmF7NhColCRwwoVXa5wsEvJ1tVhRkDYTP/JMhmd9k=
X-Google-Smtp-Source: AGHT+IHivuuf+OP8cJmf/sHCBZtvUuNQcYxbfx0xdJEh9PBKtY9TDcz6Aemlrs7IvnqQV3wLrc8UaA==
X-Received: by 2002:a05:690c:4a0f:b0:6d6:aa50:9267 with SMTP id 00721157ae682-6ea52551fa9mr10972737b3.39.1730319379761;
        Wed, 30 Oct 2024 13:16:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9e2953ecdsm21635277b3.1.2024.10.30.13.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:16:19 -0700 (PDT)
Date: Wed, 30 Oct 2024 16:16:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Caleb White <cdwhite3@pm.me>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/5] worktree: add CLI/config options for relative
 path linking
Message-ID: <ZyKUEbXedFuzY9Oz@nand.local>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me>
 <20241028-wt_relative_options-v2-1-33a5021bd7bb@pm.me>
 <0bea06b8-11d0-497f-88e1-153cb61eb06d@gmail.com>
 <D58W4HPIF8VX.2TWFTU2A2VSYY@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D58W4HPIF8VX.2TWFTU2A2VSYY@pm.me>

On Wed, Oct 30, 2024 at 05:27:33AM +0000, Caleb White wrote:
> >> diff --git a/builtin/worktree.c b/builtin/worktree.c
> >> index dae63dedf4cac2621f51f95a39aa456b33acd894..c1130be5890c905c0b648782a834eb8dfcd79ba5 100644
> >> --- a/builtin/worktree.c
> >> +++ b/builtin/worktree.c
> >> @@ -134,6 +134,9 @@ static int git_worktree_config(const char *var, const char *value,
> >>   	if (!strcmp(var, "worktree.guessremote")) {
> >>   		guess_remote = git_config_bool(var, value);
> >>   		return 0;
> >> +	} else if (!strcmp(var, "worktree.userelativepaths")) {
> >> +		use_relative_paths = git_config_bool(var, value);
> >
> > As we're trying to remove global variables from libgit.a as part of the
> > libification effort I'd be much happier if "use_relative_paths" was
> > declared as a "static int" in this file and then passed down to the
> > functions that need it rather than declaring it as a global in "worktree.c".
>
> I can create a getter/setter in the worktree API to handle this, but
> I'd rather not pass it as an argument to every function that needs it as
> that would be a lot of changes. All of these functions would need their
> signatures updated to include the new parameter:
>
> - `add_worktree()`
> - `update_worktree_location()`
> - `repair_worktree_at_path()`
> - `repair_worktrees()`
> - `repair_worktree()`
> - `write_worktree_linking_files()`

There is no reason to have a "getter" and "setter" for a extern'd
variable.

I agree that it would be preferable to have use_relative_paths be a
static int within this compilation unit and to pass it to the above
functions.

Thanks,
Taylor
