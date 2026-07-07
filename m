Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C605E43849F
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446194; cv=pass; b=gLaM9lULEMJ9LqdMDK53wV1RH97sTok1asUkKDLW6dFiahtJK4mM4Kh3a7J3R1sGqJA9ihrlsvgFHML6LhK3uLYznsHFHBsC90ZsN96eC5AXeeqY8nYBVuVB6DRfwDd+ZS+o9yHTtFMO4YDWPSTDc3ulpHiZa8CWi7j4yjNrLR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446194; c=relaxed/simple;
	bh=W2CU+HjcViRPI6bkw1teN9ZmGWmpkSbCP9O2R6Hew+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odBss58X3AnqTGLT4WcRpmGba4c6bzg5lq7P/A8K6HLuCMJXPMPv5ENHkS37hhGt2GV/E8l2ZR+skZ1qyUQ4HbSjVnFyjgZziwf+I/W0I2ZCjknFvaDlGqj1kdNvzBA3DIA/ZZj0Z020dzWMQMQYbPWiI/1bMPt2bJo8Ot6JR2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=T3fjk4P9; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="T3fjk4P9"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-664bb15d05dso6283510d50.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 10:43:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783446184; cv=none;
        d=google.com; s=arc-20260327;
        b=Hq0j45nh+ugGI9XXoLiq4IRWAZLqa0ptHqC3r/G8fZPNBqAUnsemcdWoBfcj4NQgGr
         HMoxVC2Qr7jgeZ5t/CYd5ZArBpyFgC0r7uniO4QbfSWNgwfuYqLvBjj0GE4PqkTcXuuh
         GvnHxjsN/BNyYktzS2TPcm65b6qD8OeNhBrdWCP4hV3HfBb587geD1Lq7VY5BwRafLpF
         oLeUEZfqIhTsnJaVZL0v2dqiSSSx0QAM2KXwW3BIDumEjk8gCeRczmrvsyz+DpZ53BAg
         id4udZU/RRtViI/4KhPkjhmEB3H4+OPNmREczicgP5QC7w8Ih3XmBL/0kfqz68fvPJDo
         X0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZrLRWXgKqq0y9KXy5tBQm8tzTB7mdYiRPi29oiWYu58=;
        fh=4gXc9BJO3jFv1yaG3QkI8701/Lh5WAnRCXGLO5MdbRE=;
        b=O8PjdOHG3VyF38T1wudkxNLSQxvZXs4WgwYpm7QIpCilo9lip87/y5ExLrGG318FU6
         iiYBym0ojHB/FnS9sXqiVXAA+oFC210+Y9B74+xpiWvhwNOu+gPdKpCMwnfJ1u6GGgOU
         VY34sc0oTr86FKj6vhK/iv0tHa267hJ9sHITaL6kzv4P48QCdt9UqTJVqNBEV9aRL/Bh
         Be0YBWDbFyPxYDf1xFzg86YJPl/BwujcCzonxOkm3oWMs4qWvf5V+v2gE9Yt8eAHnOz6
         c9k0I6uF4g7DdTNcrVkt9XK0edJAgggkX+1dLimI2Fyy4KHTzJEe8gsNcCYqupwXf2Aj
         4R4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783446184; x=1784050984; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZrLRWXgKqq0y9KXy5tBQm8tzTB7mdYiRPi29oiWYu58=;
        b=T3fjk4P9l+i/m+Kr1rNsoqOzkW7xnihHNjNPsZL8f/ZiPQg2IFq0253D0IG9Q/8Sy/
         SgLXKHjXgyzxdAW9IvvN+dY/QbDtvZWAF2uth5093CQUMMSallRIIdl4gjg7ZJf/lT7c
         BnOBp5sHcufHUOaeAUH86/yN9AkqguEchlA7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783446184; x=1784050984;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZrLRWXgKqq0y9KXy5tBQm8tzTB7mdYiRPi29oiWYu58=;
        b=T37eRJRm30hP0B+TFHDnJQCtj4jaelIEekD0Ak+K8HfTmhG/JJ/7FzXnD/Md6tUt3B
         Z0bS1hQxglb1zMV5m4LLmCRb6ppkNyJnFgeOLY6RNyfkdO33mLs3CzvWeDfMnrkIMKr2
         WhhYjH+tdPN5QU3P3ijRHql6xZeDQdaWK6OQYzsH9aaFBvEcwdq5f/u3fe12pJrdzp9E
         OVJfHxodNhdh2LWDzZSu4d+LO0YdJFQZFFkvByszlSAZ68cQIUSy8G5xgnv1cERvEEyX
         OVBom/8ZGtBWlOD2I5CUOk5+fITCCvUUZtXEfIvMFKG6cn6cazjaIpv/sBUH09xdaFWc
         0Q+A==
X-Forwarded-Encrypted: i=1; AHgh+RpcR7XqKK4EgwWs/voucyqvzTI7dccB6aTTm+Miq+6sXp0fn21yv9pD3k3irzLRKjPpCF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDrkwoerG43OlHaSwyAfgigXzAuL84AsJhakNADhc9X9kh6Kv3
	1sUyotBhXq0aooHKjkXXHQgpdPmlPr9D3KVST28yQJ6iCJREGQUmYqeqom7nvKKawES++R8rnjC
	8uHbrR3mIFbGN4Z41XHDFAFa3WCCj9/nRKA8WLz/I57wkBlpMMaIOfo8=
X-Gm-Gg: AfdE7ckiF5480wS3OvNSG4CWnowh8Cb9H0BCYfHA9lv9hlmAMiY3YiNZP//MedLLNB8
	vozHhCE7FDYafkgILSRokCBHcxKUv/rRG1ciacTTWbLkPLodI8gIgTvtamBCXwKkpdxeiIxznhG
	6lORaRYXrroQuYKXfPOgBwT+fVsgcm6yHCsJGwq1RcRYNCfUSatVSFI53jLLbF6S3XMuKDXhfDx
	sS+9H9SlsdHm5mtxXNVm4y4O4srcPLTBzluASTsOyBuxvLfH5SzyOSFiy3FkECa5hxmXBlAoQ==
X-Received: by 2002:a05:690e:13c8:b0:666:3b1e:4554 with SMTP id
 956f58d0204a3-6677faec518mr4632709d50.4.1783446184183; Tue, 07 Jul 2026
 10:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
 <f9c1482a76493520b948a2e918de7a5481fa1043.1783418384.git.gitgitgadget@gmail.com>
 <xmqqo6gi68go.fsf@gitster.g>
In-Reply-To: <xmqqo6gi68go.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 7 Jul 2026 19:42:52 +0200
X-Gm-Features: AVVi8CdrR-s_8604jo_RDR8uzvhDxaYKnTGlMTcHyv0WmXcy_zCPHTN5_O3hFPw
Message-ID: <CAL71e4NXPAitqQtCnwLCyXvigD5KjOCSj5em+3v4WSUaYQKHRg@mail.gmail.com>
Subject: Re: [PATCH 2/2] commit-graph: propagate topo_levels slab to all chain layers
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jul 2026 at 19:00, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Fix a regression introduced in 199d452758 (commit-graph: fix
> > "filling in" topological levels, 2025-04-07) where the loop
>
> I guess the same comment from [1/2] applies.  We might be chasing
> ghosts here.  Is that elusive commit a total hallucination?

Oops! The commit exists but the date there is indeed wrong.
Will fix (or just remove it, I am starting to regret trying to make
the commit reference too detailed in the first place).

Thanks,
Kristofer
