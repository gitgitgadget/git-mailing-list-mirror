Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AE7221D87
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 20:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868619; cv=none; b=M/fB58m48rJWQ7QrBSdBg5gwrXcxRUiiLE1677MoHqO1j14Hzu6VyEoKd238DN6JV5caSAeikpDqxi2zIVMRyRNfUoqveAZDfTPH2kbOsPejQC9iowYA49iiQYEHbNMGPeSHIuOAiX+4xTdTErPZhgU9SaqK3yQW2QHmIo+Cnfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868619; c=relaxed/simple;
	bh=BKJ1WQ/RCExcFSUyNuHf+93+whlVACycpgnaFJnJXok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1VGnpudjylannMU2VdUOQPc9VLgzUEMBeDTL7l5NANVZmfVu9wtpV6Q0izavZ88l97pp9Y27nEA1ij74wGIDuG+7iADe7CTjb6C1R5MBPMiI4IIQG9uAbAtuc/XcOr/zSTnqv7tFEAMM5Z4pQpkuZKYAS6YbjGSKP4KARhvr3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=I90MDxNJ; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="I90MDxNJ"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-42e7b22e007so21544375ab.3
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 13:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759868614; x=1760473414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aJuO8hHgSbcR+3MWwFD+Nsjt0O7/eVZzamZ0KR5rJEg=;
        b=I90MDxNJIrsH6BdzojvOgETSieoU6l9uGj1Zfjbmr0vl2hrCGqsuy9SvZQP+La0zcl
         DOVWrdGNb27NculgxSAHVfogJJs45E0ATpjY9XAQW/R3gpr7ELOeq5+H9PERBrKvFbOV
         6cA2wBYznl2hYpRPJ8dvULHvzYgYiRCp+OaTVNtPZjWralXuSh3Z0RgkfN3ciZArWdXD
         NY6Dfz78MwKz7F3MGXJxWpoL2AD0xTQvdIh2yyNMaAjMYq7ZpM+AiwLN/nguaUCyA6ti
         iFA8OMN9aIefhi9xjKwFLg7YhItZ+Sho1cxhRBhMZgQNimKMNFA0Xv76liUvLR9uEKvV
         JoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759868614; x=1760473414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJuO8hHgSbcR+3MWwFD+Nsjt0O7/eVZzamZ0KR5rJEg=;
        b=A675q5rjX5g9T23VpyPvv07UwuycQ54AqoIe5LV410/XKV+nNle6tT5jW+AR/8uGdo
         WrzNk1FqiHEAEt5Px92m2HNMcKbVLJB0fCwLXsN8xWJIAAPl+J+xN2D1kmYut2D1PUks
         f4vl3vcxtkjTD5L0lgZ6NkZ647QhqRFCzTQY3WDPVZZC54zDqKsvzDDDGy2RZkAnsA/2
         jTuERnlhuYAEUNj1GHtGLwRryRP9Q+KMVz0oJGtup+pOkqkQEw5S2i0l0pMOPpxp/v++
         txMaijLukPOJ9oQKlC3vj/yzwFe5g29CBJ/ExLtxyQnfm2ZwffDJ4Z/Pzzd2WcYsGVI5
         LAaQ==
X-Gm-Message-State: AOJu0YwtaWGJGvwsZItz7slRNDHdSwxARR117FX+LtzfRWzg4AcQ6HoU
	OsS6OXzjN8ch7zOlVad6wNANhzNNMY9UFieijRvFDzRxBDr6z4XfSa0D1JjAtpa1QSA=
X-Gm-Gg: ASbGnctBFhU6zo0uljZSvEbrnKbMtwQy6mzIyma8cWWFMGETFRfBNEce6tshgkAzBA0
	KPoO3WJHZEiqjv4NSTfCXcJwOSNtuXlpZsLXf1YrZjv9fze3RKxUzrqGNKzPURs27in6JChP3yI
	CVO61946hFbaG6eqhci4lsj8uEPYcjJ9ewt42iKXbpz1Cneclupeq5wX5RPywMZ+89TNGaBsV6N
	LWHSOF97qkhLl1WpEk+WsZ9KSv03BIGPl/T7tDEsrqxOok3oKFY6n4lG5szWcgom9Yxt0LA/r/q
	0ZVgOpPKzGObCmtYv39l8N6oJo1K62eKs5YldJaAmH/3h+a3HY8yRytPycqF0QQSANyEIHeoaDm
	BYv/I2r0LzRHTxPRnO8c8dmxZIU7RCGQF4Hx+EnY2WuCwaRyZL1dotcfNtDLZkXyI3chAT+sdTR
	n9FIshQDty9oVTJea9IC083+l/ksgnVYWftQLG9aKVltQh2LpYNC34c1CtkwGD
X-Google-Smtp-Source: AGHT+IEvAO7P6kgmDDOtg2PxUwyY37BsnsvECDD+no37IW5ipub89KgAn9lweO2c29o3pB8s2KmD4g==
X-Received: by 2002:a05:6e02:1d94:b0:42e:713c:f3cb with SMTP id e9e14a558f8ab-42f873ec9a1mr6529355ab.16.1759868614070;
        Tue, 07 Oct 2025 13:23:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-42f8147ba17sm7729695ab.35.2025.10.07.13.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 13:23:33 -0700 (PDT)
Date: Tue, 7 Oct 2025 16:23:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 17/49] builtin/repack.c: pass "packdir" when removing
 packs
Message-ID: <aOV2xNDIWGHG2sy/@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <df75c3130bced8d5489dc9184701a0a544617049.1759097191.git.me@ttaylorr.com>
 <aNsUfrE-2Wc8_1Fm@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aNsUfrE-2Wc8_1Fm@pks.im>

On Tue, Sep 30, 2025 at 01:21:34AM +0200, Patrick Steinhardt wrote:
> On Sun, Sep 28, 2025 at 06:08:16PM -0400, Taylor Blau wrote:
> > builtin/repack.c defines a static "packdir" to instruct pack-objects on
> > where to write any new packfiles. This is also the directory scanned
> > when removing any packfiles which were made redundant by the latest
> > repack.
> >
> > Prepare to move the "existing_packs_remove_redundant" function to its
> > own compilation unit by passing in this information as a parameter to
> > that function.
>
> I would have expected that we also get rid of that static variable
> either in this commit or a follow-up. Is there any reason why you
> skipped over this? If so, it would be great to highlight in the commit
> message.

We can't get rid of "packdir" quite yet, because it's used in other
functions (which get a similar treatment as this one does in later
patches).

We could (and probably should) drop this, packtmp_name, and packtmp as
static variables within builtin/repack.c. We could do it as a fiftieth
patch in this series like so:

--- 8< ---
diff --git a/builtin/repack.c b/builtin/repack.c
index ad60c4290d..565538bb24 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -27,7 +27,6 @@ static int pack_everything;
 static int write_bitmaps = -1;
 static int use_delta_islands;
 static int run_update_server_info = 1;
-static char *packdir, *packtmp_name, *packtmp;
 static int midx_must_contain_cruft = 1;

 static const char *const git_repack_usage[] = {
@@ -111,6 +110,7 @@ int cmd_repack(int argc,
 	struct write_pack_opts opts = { 0 };
 	int i, ret;
 	int show_progress;
+	char *packdir, *packtmp_name, *packtmp;

 	/* variables to be filled by option parsing */
 	struct repack_config_ctx config_ctx;
--- >8 ---

But I'd like to err on the side of post-merge followups here to avoid
dumping 49+ more patches on the list. Of course, if there are
showstoppers or other objections, I can easily reroll the series, but
I'd rather avoid doing so on a series this long.

Thanks,
Taylor
