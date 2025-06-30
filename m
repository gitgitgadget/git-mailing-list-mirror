Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B454292B36
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303007; cv=none; b=ldUF2yh3AOk5ojm2mVFiDtBTSFeOCpmNCqrLKi14oJj+wH69stGEoNLbAtY5r//LB6rSxJ6LTnfRZLGjnucWm32acj+CXwiR+WLcUx2SKVtKaayHEOw2nF+lH9YsyNxhTXY9RPBIH/0HnPwNl6pk5JK6LLXRF/ZqqvR+gqy3Vfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303007; c=relaxed/simple;
	bh=1L3Gwf5gLTJ6l7wqGGQmxaxH4tihr5n58MPLVp8LOmE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZPN27lzUiBLTorMp/Rc7vXXxqr6WidOL63Z2t2Weamt+GjdMhTevCAFx6Lj48mEkNvYoM2dpExbU5IkxUzNMQgW7zqOrUWI8Xx/J31f2+yIjr7+bnQkuyOw4B42BiFBatpebIvLol6XL++5iRuzelTo6HGS4mn0WJY82omKGyhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlSZMD/r; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlSZMD/r"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22c33677183so38998545ad.2
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 10:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751303005; x=1751907805; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8s8f8Hg+2nLAPTZ/LT4b1X67+ALnE2e+w1Z1BowGIU0=;
        b=XlSZMD/rOQJMUpI5xtI972cwHENL4tVAQBDUVlHTyfFTxAi+h+rrJqeXMFtOvsCOkI
         5U2RRc9cRKG6NpThUyT47HS9kKEA/2PNGS1H0oE4sIrYYrhJUeHN5aAQVuav6HNGUdnp
         5FK6ChASVQg2Ft/N1EvfHKoQHmUoXaDhfNumFkXOQZcH+r6lBYQMOa0C38HrvgevgYEG
         8uO/0mMpMZ36cLbBYnSFPUIu89TVqp3YbDOvfoJzqCBJ54KIbWA5R+gIAHbW7zUobcy+
         du1XiG7bDkDg8YNTcQinNcOqZkRd5Z9RdB9/sPD8DXmfeF0c8LiaepdK4NmYm4k7uDT3
         BIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303005; x=1751907805;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8s8f8Hg+2nLAPTZ/LT4b1X67+ALnE2e+w1Z1BowGIU0=;
        b=a6l9/4rU9KPCIK7Dnd9IG/cspnhFlVvkW3JdvwhSS/+7XKYvPs2eaWfcdjVTr3lwxr
         OUgfserf4jaBigLlNIwu6vAUcdHwz0FDuKTYEeFXX3/Jp+QlqdlHh+kRXEPPwUnR+c5y
         wzvwPg0tacMjpYvaf540sXhbzGvkfhBrebKDN0DDiPXjr45YsxrDhz7fJSciemtCeBnr
         QbRorrAolrylDKF2Lfyta6dDfuyGkEg2kjBbv7ff4OihtDARXKOETFHe+0q9pjgUOZFK
         xHmtmU4gWeH67QJEtPmIvfmomCj0jLOEsRj5rEZ/ZUfq815JcLKVjBVUpWH6ytx2qoSu
         4oRQ==
X-Gm-Message-State: AOJu0Yy4eSGKAdtdtBn16IO+5iE++flW4Mgry5tNl7+OSBie7m0Q+25g
	1AOenq34uYp5f1QZgxPIE/4wfB/d769AKe935+csR8DX2IYZ0MmWIj6d
X-Gm-Gg: ASbGncvDDM0Mc9TERCXsrs93DDyiGssnkyPYYcU4KeTjqQxHCszA5U8Fa1n5OVv8aKX
	Ok5hfnv4bKiQ9bnhn4LBvdXPE7hzqon5zClsiOF6c1iuZ0tIfVp02DLOOlLS1AnCDSjzq7TjUhH
	F/nplHKVsNVBio9tHCEyMTfyE1TmXKggFFN6KbJx/IIaEcVwbwNynTKbL4iccMPejYwxyYkhmYp
	OGt8xZ9t1BaF02wrzN54zW1GxXMPq8w2DbsA5hou3mr10Nz+Qu3g9q/XGcKjVjIKrHLgRAowc2J
	+eWjhvKao+mBfxlULNkGE8kjtioWLbYTDU+Y0x8UCKk8GcJWqE99GGL9Ri7Ld5ECLKx1nNMuSIi
	5EqsladqKFJzo47S0rY5SeeAjt1E=
X-Google-Smtp-Source: AGHT+IG3GAV5y+PDO2exrDrd3D8gTgsa0WRzraq8YCe2LjVLy70dpAMkzPLlQqKNunE4xWS+nCMCzg==
X-Received: by 2002:a17:903:19c6:b0:235:129e:f640 with SMTP id d9443c01a7336-23ac4880298mr221062145ad.38.1751303005376;
        Mon, 30 Jun 2025 10:03:25 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3adc64sm83299825ad.153.2025.06.30.10.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:03:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <christian.couder@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Leon Michalak
 <leonmichalak6@gmail.com>
Subject: Re: [PATCH v3 4/4] add-patch: add diff.context command line overrides
In-Reply-To: <b68c58b667c29c66433b4634ad44ee9ec5257e80.1751128487.git.gitgitgadget@gmail.com>
	(Leon Michalak via GitGitGadget's message of "Sat, 28 Jun 2025
	16:34:46 +0000")
References: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
	<pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
	<b68c58b667c29c66433b4634ad44ee9ec5257e80.1751128487.git.gitgitgadget@gmail.com>
Date: Mon, 30 Jun 2025 10:03:24 -0700
Message-ID: <xmqqplel17s3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Leon Michalak <leonmichalak6@gmail.com>
>
> This patch compliments the previous commit, where builtins that use
> add-patch infrastructure now respect diff.context and
> diff.interHunkContext file configurations.
>
> In particular, this patch helps users who don't want to set persistent
> context configurations or just want a way to override them on a one-time
> basis, by allowing the relevant builtins to accept corresponding command
> line options that override the file configurations.
>
> This mimics commands such as diff and log, which allow for both context
> file configuration and command line overrides.

I skimmed the patch briefly.  I am not sure if it is a good idea to

 * add OPT_DIFF_*() macros to parse-options API, as its utility is
   very narrow, and forces those who are learning parse-options API
   to learn one more thing.

 * validation of the value range to be duplicated for each and every
   users of the new OPT_DIFF_*() macros.

but other than that, looked reasonable to me.

Thanks.
