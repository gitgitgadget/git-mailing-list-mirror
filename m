Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4889418FC84
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 02:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742263498; cv=none; b=AhhfRnHxwPLiwUIrGnCiwgqACIuPL1Za0XF4sdwN4ExezZMIwSicMILyWuCGfaKPCQxgOZpxAAixaFZhDwSZbcP9gh0zapLIxcWUxGpOgJMI9RtBVF1YgXVmcbjuzTg/d+jvCPv433XZXIU3Z9qvO6NF/+HrjNIqsEh5C5rMLJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742263498; c=relaxed/simple;
	bh=t7UwZhtcqQpB3IFv2pWMCWmz4B8X+jzUi8JWqKjFdws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=tQtT+tbXQLWKESuyr3elJCyij7ZHpAzy952E1ntG1syZTeU7KWyn0xGthco8e/Wf3qs11DOzK9NNQYR0bNr3jNyEP8H4rH1uctcNi4xQZ9A2+3ilDY+bhAMrjWEaUC/qTnLg2h90tfj8p8tfkNSJ1ll6PFSlChmbMAKnHEnb9C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=block.xyz; spf=pass smtp.mailfrom=block.xyz; dkim=pass (1024-bit key) header.d=block.xyz header.i=@block.xyz header.b=P3DwRtV8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=block.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=block.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=block.xyz header.i=@block.xyz header.b="P3DwRtV8"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390f5f48eafso3191023f8f.0
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 19:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=block.xyz; s=google; t=1742263494; x=1742868294; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7UwZhtcqQpB3IFv2pWMCWmz4B8X+jzUi8JWqKjFdws=;
        b=P3DwRtV8ZndXLQ3Yt56JYtiwDF43uHpF5cl3cItyHEorKUkpB9TduyOy7rHIU2rx5L
         Hi/LqjEb+NVQ117oGLj7VXaFa2tw0mh0UlfiKAZl0p3JFyHBDOfLXGvIZRJSwA4dv8vn
         3B1Px8NqHWxP7iFJDU2DZUSI1Pi9+4gurjNNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742263494; x=1742868294;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7UwZhtcqQpB3IFv2pWMCWmz4B8X+jzUi8JWqKjFdws=;
        b=kC638isP2nXuXbBABR9bgXPAev0cerk0HydhAb1MGysTf8s5rG9fy/9QehWmxmx+Oy
         gYfknv5LDdp4Z5fjK4NvDXcI74O+ZZToCtWD1Sn15xRZSebFvqDKlC7Yi0pfD5A+e32n
         MoegXkylNeSrvbzbPeLFNa0R8ub9SXFpGtKtrTdJNJZ2hvOl2L3ve2jEOb6C6WbXc7Yz
         q4ALN9hO9RZnK/jFy49yCslnCM70d0LElxerXhIPmylZG7DloTpQRKkwP/TSN0mQfDqD
         +oja5Q+SM2nmLTY9F/kvCSi/ZDeOAundOVGGP6TjFhafQ4JtcbuOPP6mMHhPwEfYiae9
         heNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoulyB80ZHNu01iZH3sQkvNeQ0UT8RdEyuYIujjRCI3fYRULR9TMPp3jxfbET530TAN3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzuVd/tFSvBLaeTVLhzvEvVlLIJcnrNMDRoy4tM7C0MglLuaL+
	3xbVOkkw4BeSnYSVsMqmVFTuxNANexrlr97/0xBSPEIoKcnh24S3xPhvs0UMbdxwt88w0RIJvn7
	wtdNRmNRKYCnJVDejbIjUkN9UwboM08bhpddTwIS0Q0vTZmD5BNzSXQ==
X-Gm-Gg: ASbGncvbDMrDwloA69IOm5T+EUNfF91Auq192r6GC4jW9waOsWPboH843cpl6/juGyw
	xv/fj/XZZayTMr4Ncy+9CWFi2vswRlnjWDEo0LwWEtJogouGANzWsHV8xIodKuRIlFiMrj0xPBL
	TMVX9MHp8AgHsw21ANcHKLKPel8aNyvfpOOSsomTQ=
X-Google-Smtp-Source: AGHT+IHQcljiHB4oNA30pYLIVphcmeYaD7dN1vpX1GuOJrIFUa9GicGbDq7hS5ZFWtkpEdG3pkmzROMf7DF0gRp8m9o=
X-Received: by 2002:a05:6000:1acd:b0:38f:3e39:20ae with SMTP id
 ffacd0b85a97d-3996b4999b2mr1539216f8f.43.1742263494575; Mon, 17 Mar 2025
 19:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOHNGAW7ucD+xqvEuvq2GHMc42+WdKJX44XGguadK_y=pMf0Vg@mail.gmail.com>
 <Z9ipn_-J-ZKbnVQh@tapette.crustytoothpaste.net>
In-Reply-To: <Z9ipn_-J-ZKbnVQh@tapette.crustytoothpaste.net>
From: Yissachar Radcliffe <yissachar@block.xyz>
Date: Mon, 17 Mar 2025 22:04:43 -0400
X-Gm-Features: AQ5f1Jq7SCdCEbshisHOnohQEW5-WDWxR29TycbOy0TBTOXTTQG86oh_1bQJic8
Message-ID: <CAOHNGAUWR0K4RtEMU7WjQUhw9=rNekKfQ-1_rLNniiLKRgVzaA@mail.gmail.com>
Subject: Re: Slow git add . performance in large repo
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Yissachar Radcliffe <yissachar@block.xyz>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> When you pipe the results of `git status` to `git add`, you are
> effectively using the `-u` option, since that will only ever list files
> that are tracked.

I'm not sure what you mean by this; `git status` lists untracked
files. For instance, if I `touch foo.txt` and `git add -u .` then
foo.txt will not be staged. But if I pipe the changes from `git
status` into `git add` then it will be added.

> The untracked cache is not used when you specify
> a pathspec on the command line because in the general case, it doesn't
> have to be just `.` and it could be something like a match on an
> attribute or a glob pattern, which would make the code very complex in
> dealing with that case.
Is there a reason `git add .` couldn't use the untracked cache even if
other pathspecs didn't? I have to imagine that `.` is by far the most
common pathspec used and there would be value in speeding that up.

> You can, of course, continue to use it, but you
> can't expect them to perform identically.
I wouldn't expect them to perform identically, but given how much
faster it runs when piping in the data from `git status` I think it's
reasonable to expect it to run much faster than it does today.
