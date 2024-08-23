Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FFE15FD13
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418782; cv=none; b=QJMuy513kBc8ss+ViH8mK99k80shJ4USbO+JVJ98meeHoCOrfpSWkX92nSDcka63ow5CnWbfbdadiwBlu6yjauMXeBcSvetzEl76mCCS0peC4/XPYJdFB/rbCCTJz8aLwFkQXiHKMEPntS7VJTRmH9/OyZO1l/U/X/DxQujSkjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418782; c=relaxed/simple;
	bh=EPOO7hefq4Be5cO8/zFAxk3DfU6XLzysRLAuWuwOvTY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IUYpfuuAJy2kOF5AysR3pDPztFG+LoowrUNyZZM+SdNFptFiODVpfLjD/BVGUJS7AhwVqQ/Hi6soTgtBv57ZIS7uOFS9OQIkYqT9oBwAq3bDbPMzyW9zQbAmuJtwmsrziSjk26TUclllPXTRJ8sApyuD3tmvZTz3BGSQti0hlVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+IdekcB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+IdekcB"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2025031eb60so16577035ad.3
        for <git@vger.kernel.org>; Fri, 23 Aug 2024 06:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724418780; x=1725023580; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQ5LFAMQiVqvvKA9JkgEM1F5AM4JtEbWwvkRPZUT5dk=;
        b=R+IdekcBZ961XCewQv0rwhk31G8479v+CSLwlWmfXdBYP2Gr8C5oUthYmdr6e90hgn
         2yZEGzi0lHX5Y6/edS9FOMbv+qGRlBofWLMOmau5qFz8KiAkLPYRp8hohEt/WpIdWH16
         iuvQslEy06fdPFeT5aWQFfgyXEp1Yela4KvtyJUtQOLGYVnWfuR5/S2i8prZYSIGd+5B
         FBaHEoRGrqvrRvqdTeMp27aAlD7PsWa8/g7UnSYXOxnM85KQd+2pWH9nOmgDH1plj8sR
         w5mybuno7GxIEYwFTaL7rM5Uc5HHsJFpSAUPzDTDl6HrQt8JZk/tWSecfi2SEeaZ3ZbN
         BCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724418780; x=1725023580;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tQ5LFAMQiVqvvKA9JkgEM1F5AM4JtEbWwvkRPZUT5dk=;
        b=eomzoscA/ru27iJrda65Sk6pGsnayRZsPOmyO4rpzY48Y/bcBvuGcCI1rs176b7xAl
         pQfx+b7KSrJoCjzgg/FAof2SggXNpPHfGupo5cjipICEykEy2LXDi+ueFHYP/oavbGkW
         2ZEx6G7bXx2IAl1Dx7lCb2U9+o56zs1v7OWWYz0F29vJizysuPuS7L2kTwQpiWHv9f+L
         vnApJzVItpujGS+q6aj5jp/2bbkK4/8QE5c1GYL3DdcWxpgBtj/Gu1AEP3zzaRR2trRj
         +u318+Z/77RHapzZ6p5w1UcSaLqdFfbUjsGugbQO8DbzYVfasuHu1PWO2KWTZqEgUTc9
         jy6Q==
X-Gm-Message-State: AOJu0YyxaXccSjrsR8/KtU3VNO2mDghyHOuMYJtZX88R+L6RUJvkpmj/
	KI6oltwRQ2xSLLdQQxHZqeBi2pZ1rJMsrKeq50ry4PYj/EIhWFZE
X-Google-Smtp-Source: AGHT+IGLUL/+YyK6RTBHQLdUthqB9spfJYkjye2UaQ19fNmZyMDk2kIjY4ZyE6SwTZc/hM8Cu0eNvw==
X-Received: by 2002:a17:902:ea11:b0:1fd:63d7:5d21 with SMTP id d9443c01a7336-2039e4ef18fmr23287335ad.47.1724418780016;
        Fri, 23 Aug 2024 06:13:00 -0700 (PDT)
Received: from localhost (240.94.125.34.bc.googleusercontent.com. [34.125.94.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e7f4sm28068725ad.70.2024.08.23.06.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 06:12:59 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Celeste Liu <coelacanthushex@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] doc: replace 3 dash with correct 2 dash in
 git-config(1)
In-Reply-To: <20240823-fix-doc-regexp-v2-1-e4eafdd60378@gmail.com> (Celeste
	Liu's message of "Fri, 23 Aug 2024 16:21:08 +0800")
References: <20240823-fix-doc-regexp-v2-1-e4eafdd60378@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 23 Aug 2024 06:12:58 -0700
Message-ID: <xmqqttfbpelh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Celeste Liu <coelacanthushex@gmail.com> writes:

> Commit 4e51389000 (builtin/config: introduce "get" subcommand, 2024-05-06)
> introduced this typo, it uses 3 dash for regexp argument instead of
> correct 2 dash.
>
> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> ---
> Changes in v2:
> - Clarify typo details.
> - Remove Fixes tag because Git doesn't use it.
> - Link to v1: https://lore.kernel.org/git/20240822172042.54065-1-CoelacanthusHex@gmail.com/

Thanks.  I'll do "typo, it" -> "typo. It" while queuing.

I couldn't spot the "regrexp", either, by the way.

> ---
>  Documentation/git-config.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 65c645d461..79360328aa 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -130,7 +130,7 @@ OPTIONS
>  --all::
>  	With `get`, return all values for a multi-valued key.
>  
> ----regexp::
> +--regexp::
>  	With `get`, interpret the name as a regular expression. Regular
>  	expression matching is currently case-sensitive and done against a
>  	canonicalized version of the key in which section and variable names
>
> ---
> base-commit: 3a7362eb9fad0c4838f5cfaa95ed3c51a4c18d93
> change-id: 20240823-fix-doc-regexp-727a82281737
>
> Best regards,
