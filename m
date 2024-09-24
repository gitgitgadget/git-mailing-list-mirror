Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F4413342F
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727187555; cv=none; b=gtsJchyxudux6XDS38oTWInI/KSOxYPBhseDbu0BsZc8NPoo421xeEsN/71M68BXPiZLUMocLw2qUoHthvDIDBvrRYPNrKo0Kax95JqsNf0EQIWo1jfzcpNGQRtyzEgMRZh9Tvll+bEloroGBF4MCtNbcoSOxv+smQaZXNHTfSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727187555; c=relaxed/simple;
	bh=M93nN2nJxZdsfIKG1qe8Zu8Y6ASqLsifnIAlBw9C4UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sansPG812tNWkJtx6L0dj0N+578e8uLd29ZepdSkRBvWpi9XYLG48CxlfLoOOACnEH5ga5nqu43U/DEBjPS4nZzu+IlSEIzByAfgRenM5XzNILxztRNT6YjUpuoZmRutpcGa102M1UbRY8QckBAhaEnDagKamhxmARjZiHKkdfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLYmPw6U; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLYmPw6U"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6bce380eb96so3582653a12.0
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 07:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727187554; x=1727792354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PrdIcETUROTGpNN1yRssGqBFiu54Tkc0LkE182LCH6Q=;
        b=mLYmPw6UdhuPZVCAn6aEmhV54quoDX+pPZ6AUHOF/0Y4kfrZ7IG5PGrw/vknSHU6M/
         cuUHlODET1V0ip1pgAKw09QVI1rajUalocnagjnGExOBQyHaCDrfUIZil+3suqILzENB
         H/Vyvrwzz/lZYrijPUZJYhk1SMAp6RZzac3Gt343rKcelCKRVx0HaVWycdiwZd1RjrZz
         m4r3LO5TYhiUeVSH//sMUL8atQOVmyVW+7nN/YNrH5s6XP0wmM55mp7w9lDWGkE4/kMU
         6n3m3yQ6+hWEofolVyhpoQjAt7bVhh9jc0PCorWDAsUOXNrwHYdrDsNyyNuygGeRK1HP
         PTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727187554; x=1727792354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrdIcETUROTGpNN1yRssGqBFiu54Tkc0LkE182LCH6Q=;
        b=jiOPdCjX5FE9bQQyYUvtNuTn1YYgjkGgvNAHxylAJURkMxj0TYrbKotuYQn8gv9WcA
         xIqLlbXCn2hFA7pTYLB1F+U62kSWBjY/is9asCIPLdpAonc5IdLIksb7BqjexVC/j1ZZ
         29mqKeSpJV3wFpQ2fpIgFjzKhmYSJ4YL6sMk58+nWNWdce4rP+K3xnNQ3IXYuFYtXFoB
         7Rps4q9Yycxeemz2btJINleRN5xWTSApYuEtANCoywiayMqNHxox0if/IgyeE8L+4Vxc
         Bu+AU4Xqw8Lg+F19L0LasnGsC5TEXQoO0GKURHWRTLYmGN9Q18MxyxDN3jGr/v8xy9Mb
         J+JQ==
X-Gm-Message-State: AOJu0Yz2Pfde+JrSZFUceODr1knTHipnKhMhPXcauTjTaMT/xgqwMcj+
	xWd4XrQMrOiX6cOFHWE5uq3ro4Rm6FXfbw3q29bAyJvLTGgwEk3u
X-Google-Smtp-Source: AGHT+IGhK4ojTYH2Ewn+QusnlxyShXE2z7zsfzcOZTfK+CLb7awCwy0tA0Q/nKmvHujp4StWrlbqsA==
X-Received: by 2002:a05:6a20:9f93:b0:1d2:e8f6:818 with SMTP id adf61e73a8af0-1d30c9da4e5mr20089152637.17.1727187553644;
        Tue, 24 Sep 2024 07:19:13 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9c79c9sm1249716b3a.202.2024.09.24.07.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 07:19:12 -0700 (PDT)
Date: Tue, 24 Sep 2024 22:20:26 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ronan Pigott <ronan@rjp.ie>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 0/2] config: fix evaluating "onbranch" with nonexistent
 git dir
Message-ID: <ZvLKqujqfDFxCtBp@ArchLinux>
References: <1b9fb3f3fde62594b9ac999ffb69e6c4fb9f6fd6@rjp.ie>
 <cover.1727171197.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727171197.git.ps@pks.im>

On Tue, Sep 24, 2024 at 12:05:37PM +0200, Patrick Steinhardt wrote:
> Hi,
> 
> this small patch series fixes evaluating "includeIf.onbranch" conditions
> when running outside of a repository with an invalid gitdir.
> 
> Thanks!
> 
> Patrick
> 
> Patrick Steinhardt (2):
>   t1305: exercise edge cases of "onbranch" includes
>   config: fix evaluating "onbranch" with nonexistent git dir
> 
>  config.c                  | 15 +++++++++------
>  t/t1305-config-include.sh | 40 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 6 deletions(-)
> 
> -- 
> 2.46.0.551.gc5ee8f2d1c.dirty
> 

Although I comment a lot in [PATCH 2/2], I think this series is good
enough. The reason why I comment on [PATCH 2/2] is I think we should
enhance this behavior in the future.

Thanks,
Jialuo
