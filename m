Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3D3EADC
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765211655; cv=none; b=UuvCJum5jgUpj07OzC72T9E+z0Fa+XzjT8Zy8uJJLr926W5Hk312IHNNNO+5XYROVJzgOzrmSgn4CAHl40jl/6GbdlUqV9J8iDFVz37i2zwWcbZ9OBEbTYa/T6TVhcuvwb64nFIyANuHKaQE7Zzcf/ADbr2VAnzTnMzS6X5Qqs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765211655; c=relaxed/simple;
	bh=ktXVPAX5d2nAVlVfpsHiqeoqeFy1hODC+yTpgpuWxkI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=P/9TBX11+xnKkMIK5MCYvBQRY88fyklOHbYgkcCHU8m1NcAlJlV9rnoXXWh05ZbbxPlTjU98ZUmTk5nLvESY7LpAjjNUBecR7KJNlC9IlTRa4MpWqrcNTW2Ex29swAucZiHIjJhuuHqyBYcD56ZOonzITnQhVXJnFKzhjbAYCEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8hWVmOk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8hWVmOk"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29853ec5b8cso59579965ad.3
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 08:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765211653; x=1765816453; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UROU3eSBCr8PkHqh0lFNxKYCWf1SsL3GzxJ6/vm17vU=;
        b=F8hWVmOklCFscjsg4XFJRLfdjm0Twtcm+S+YfQQJsnCdYXi/Eph6YroKmbQSlLOQah
         DQK0uIetUOlsl5TOUrJdq3slPkB+++ZrmPrh6sk1gSqkQ2xJJD1fb3cbmDtRyyLKE+W/
         WoNf2xdp7gg+jbx7lyRcNenzMGSZDRS84rwyaMwpHDMeqAbyG7DIvOy7ZsMxIKfY46Jx
         MXir1JNn/ihAZ4a50hBjjLmmUPh8B9/d9l4FyyFP2UD/xDwG9TiuiR29Mi9au8VbMnrp
         OsoPQ166hZKfWdODdV5YglkKKb9FYMEpFZDy8fWKTzFcWYLNUB8+rAyje8ewCGm6BMS0
         qsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765211653; x=1765816453;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UROU3eSBCr8PkHqh0lFNxKYCWf1SsL3GzxJ6/vm17vU=;
        b=lzjfc+uLmhB4KvZBn5o+U7C57vzCgQ2B9e/z3Usu/iYJgmDlJNJGESUh4RbJ2XqamQ
         ryfLc4fWp8/UCelNtFFmV5Cq4ac7QOTXLkwyGhwXhomsmKDtRbY8AZLi7OZDl8EpiNbK
         p8I2cqcOTwYevQh2wyZKE4pk1m5lkjI38+lGDm8KvMpo1+bd9PHFMWcKKz7JreZgEh7j
         CRREvuKP0qYHaL6F1gbzZEUqrr72WxPcgD4CZ+hXb1Ubmn6CygTdQ3FtP0QwhzDeY9rp
         VsG7a1AFEud/tdh5QUc/0kWYgwf7RPCPv4mBXOcXUzBczgZPVRr+6m3g/xEMlAhRDTlU
         2vQQ==
X-Gm-Message-State: AOJu0Ywl2uideQWN0IuW/dVD7HnsMm44S3artx8N5MFSVBmjB7jnp2ZN
	vmdThi0BaJf2m4RXteCruSfzz6KX3SIIUClKUUV9wwVBcWi6ohlogbPs
X-Gm-Gg: ASbGncsR1/SoINpV4L32+lYvohhEc8FEWzWkuuerSD1GI5USfXlcaNTjXo7QJ/soFtb
	aVO7J0WpP/3DcvRagBMEDrblVpBwkQUUoY2zNxS6MyuopWt/bCE4lHeF7o7sdosGAPid5h1eoXn
	2/atTIjPnD5450lCkMbdfggnbf8XnNHYq/yI1avsCZ7heXMW00E77a5qSTm8TRq8Vgisu28S2Ak
	ybo21GohcVlSZwYeUwTLahNKAMtsetVVHPoztYOGHWSxesJaB4stqM4p7nhSr8AILVmhf0uwqio
	U2vgGQvpfKg/hSOCKbaLtWqS9L6D1YDI1hyWF3Mv8W5SITmg3m3mDMkhXZCMXPXBDx1ExicB60x
	R6XkxArgL4kPfI4NitqdE0iG558wSVTePyVzHcbqchgZwUZUwP0C0j2FqmVZB5LOPQEGVQnQqac
	3g+mO844CqvfVuC22O79FtMstb6p2SNhwpXMmgZTzIxVY=
X-Google-Smtp-Source: AGHT+IGjIynw4A6lCWPxH3Fro5ueEeTbkiiUoccpDOEDwA/jMpfal46xkzmfoPHogGleOd8bkNbFqw==
X-Received: by 2002:a05:7022:4285:b0:119:e569:f620 with SMTP id a92af1059eb24-11e032a8639mr6217115c88.25.1765211653398;
        Mon, 08 Dec 2025 08:34:13 -0800 (PST)
Received: from smtpclient.apple ([177.118.148.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm60684699c88.6.2025.12.08.08.34.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2025 08:34:13 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: [PATCH] repo: add new flag --keys to git-repo-info
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqqzt6kkif.fsf@gitster.g>
Date: Mon, 8 Dec 2025 13:33:59 -0300
Cc: git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>
Content-Transfer-Encoding: 7bit
Message-Id: <5A4D4433-FD38-4BB0-81B6-3BAD33A30A74@gmail.com>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <xmqqqzt6kkif.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3864.200.81.1.6)


> We do not need to say "Currently," but other than that the above is
> very well written.  Easy to grok and to the point.

Thanks!

> Shouldn't "--keys" be explicitly marked incompatible with "--all"
> and remaining keys in argc/argv[]?

Yes, I'll work on that.

> While there is no strong reason why anybody must use NUL-terminated
> output format, simply because repo_info_fields[] contains no tokens
> with strange byte values, but just as principle, shouldn't
> 
>    "git repo info --keys -z"
> 
> do what is naturally expected?

Hmmm... Perhaps it's too much for this simple flag. `-z` is tied to
--format here, and if we want to support -z we'll also need to 
support --format.

What about adding a "default" format for --format? This way, it
would translate to:

- keyvalue, when using info without --keys
- table, when using structure
- using puts, when using info with --keys

Another solution, of course, would be aborting when --format, -z or
--all are used with --keys.
