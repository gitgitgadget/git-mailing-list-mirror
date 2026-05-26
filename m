Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA4C3BE646
	for <git@vger.kernel.org>; Tue, 26 May 2026 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779831207; cv=none; b=VcFAmWufSPEvyUYHVp9wLhSlRbwWk9AOl+0HN8GUI62vQb4uNzqBjGWh5E+3829wEktfFbgIaImeQwR2nn8t8GveEalET+n7O8fesw7M/NUuAZutRVkEBiyP46lOL9FqGUEMohbcCYKZSX/2bqby2qGen/S0YYElr6j8MzVSmlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779831207; c=relaxed/simple;
	bh=vRoI+DQ+CW1kANRr+zeLI8vfcJulL0I6B7RmbH+SczY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0XqB0CBujOBQSwNagvsH+kfBSGtkojKnaxaWiv8Im1CP7yDMvbWt5+UQrECiM2Hn0t4o4ahu8xSyrywcj6ED6WR+oZX+QI9vLax8a8omHqFXRZDFzD6TRH7FyIsA+XZdum2xjZuDnlKy1K592Qb8xbNPtoA3mxWViId/Pw/ELQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3MXR2cP; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3MXR2cP"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a40502e63bso11055217e87.0
        for <git@vger.kernel.org>; Tue, 26 May 2026 14:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779831204; x=1780436004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1Qw4Lmoqz+1a20UZ50BlKDNJptWxgL+yx22SBUM4tk=;
        b=m3MXR2cPsOg+0yuZmA44nzIxcZOAcAcnfU1R+A0tXcelGsU9lhEnMF6n06s+dZAqCE
         xjPmaNy+7ij6a8WbTC6/FCsXEWpIZLMFBy5j9hf1uEw72YgBXPN9LRrXOWLRjlLXMAwU
         0U8BrcewQ5FZtpCMl19LZeJ9Uu5qKCIsqIcaw/bQub6r/oGLgxr+etmonA59ld0PLC2p
         rvLg7Bx1ODlaS74YEnmOsHK0ydqQDjxuEMRcH7tA01vP9+pS2fMdyLDHEswDgxdYtY6J
         yhLr4eyDd14t2whUIgIK/+3CYTuFg5EA4pgyP7HyS+HzoPgz2cOJqScnCfLO/eDgWeVv
         4nhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779831204; x=1780436004;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1Qw4Lmoqz+1a20UZ50BlKDNJptWxgL+yx22SBUM4tk=;
        b=G2pKTm/RAbfXd7b3DyxJzCfLC9K9odtfncZl2agWIdnIUaLYWoC3JgfC3hocimfegQ
         uBflTf1gS5uZJlaNFwr67HD24zkn5p1pcoXothRIbm9gSqScdZ7izb7rXs2g5FifninI
         Y/vL/hvMOfbmT7xX+/exBo1Qk2Upmcbmly9tR/KsX9KhludcLqQLpptYS6dpWM05IZzw
         zpdjBhkmSaWMS87BFjJ/qUQI2V4NiTPFImPAGdaJ1Ii8Jp9PD4yZ0DU5o98NLGcJuR+A
         1LUasZLge49TtCNA+WJ5eBu6YmKtQ+OI0mJO9hVQE+JEDbTcratdTTRWG23zILHaprpl
         tlig==
X-Gm-Message-State: AOJu0YxUSSSwv5uLJzBvSdLKxcsI+xlvFio4TwvF23cKOOoqb8NOGR4d
	bN4tTVznNzh9oxSTg+0h58l3C/8RT4zHLlddF5BVa8O6t/UV8py1AyhRAo2NbQ==
X-Gm-Gg: Acq92OHOllZ+BhHkyDtyC+DWMcuGWzBB+trAyYUrah9beQakHFnHUdNG6sTt1HIzDPA
	T0W7iMy5s6g9HJ6djIcPDW4Tfprz3Md8lbbA9yUdUZ+d9e9f9pHUI3/1aW2j+RpWHNqAGMk5+K+
	DHRGz8N8IkpXAHzFDS+NddZlF/UTPo2IE7ulxd1OV8QDC1vvGifXRy+4p+mhM2bI6F8WCQomtd1
	FRyyQNiXruDyld6nY3zxzVECYuQu/SaOdm3v2A3jIp7EOZ4/9vHiEWLmTsedLvDOJhiecX2MP1B
	TgN+EdIoBiu6QxhEGSXXk4nvD4M1HrHhcmUjOP5zPLIF4uKgiro8JI764q4SGDcGms5Y+IcCZKh
	TOrhC3pols5FTmhRlgdzV65xwu1bg9c2HC4DyBWTsNXLdtVvOo0X62P7TVjw5Bajh2OngfMvCVR
	NyyKEuv8BIOXQAHiJ+u0fNY1TdItRN9yk1//NX37Op1glFhxR+vJ2eOOGmDTwHxEhR4+nGmuK9z
	Z+LqDp5OSwjLIRHTduzrwt4rhGE5sRY0D5UgMlEpPEHOSNC+Av4YcYs0RQ3BeF7M+eH9IV1E7Q=
X-Received: by 2002:a05:6512:1244:b0:5a8:63e0:971b with SMTP id 2adb3069b0e04-5aa323a9bc6mr6020651e87.35.1779831203697;
        Tue, 26 May 2026 14:33:23 -0700 (PDT)
Received: from localhost ([2001:2043:be0a:d700:954c:d0e6:555c:211f])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa462d98e5sm682270e87.21.2026.05.26.14.33.23
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 14:33:23 -0700 (PDT)
Sender: Erik <erik88@gmail.com>
Date: Tue, 26 May 2026 23:33:21 +0200
From: Erik Cervin Edin <erik@cervined.in>
To: git@vger.kernel.org
Subject: Re: [PATCH v3] git-jump: pick a mode automatically when invoked
 without arguments
Message-ID: <ahYN_FeSileUJLGl@mbp>
Mail-Followup-To: git@vger.kernel.org
References: <pull.2108.v2.git.1779280307112.gitgitgadget@gmail.com>
 <pull.2108.v3.git.1779371110195.gitgitgadget@gmail.com>
 <20260522052821.GC861761@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522052821.GC861761@coredump.intra.peff.net>

On 26/05/22 01:28AM, Jeff King wrote:
> On Thu, May 21, 2026 at 01:45:09PM +0000, Greg Hurrell via GitGitGadget wrote:
> 
> >      * Don't both teaching "auto" to select "ws" mode, because it is always
> >        subsumed by "diff".
> 
> Dropping the "ws" mode from auto makes sense to me. It could be slotted
> in between "merge" and "diff" (a whitespace problem always implies a
> diff, but a diff does not always imply a whitespace problem). But would
> that actually be useful?

When I originally proposed the idea of a third branch, there was a
subtle difference -- it was a git diff --cached --check.

On 26/05/14 05:40PM, Erik Cervin Edin wrote:
> If we're going to teach git-jump how to be more clever about where to jump,
> does it also make sense to bake `git jump ws` into this?
> 
>         elif ! git diff --cached --check >/dev/null 2>&1; then
>             mode_ws --cached "$@"

Ever so often I come across file with a diff --check offending
white-space (often a missing newline at the end of some file) and
because I have a commit hook set up, I have to go looking for where that
error is. In this particular case it's always a staged change, and then
a *staged* white space problem doesn't imply a diff.

This happens rarely enough that I haven't internalized that I can use
"git jump diff --check --cached" and it takes me a while to navigate to
the offending files.

But the main suggestion was really considering the possibility to
expand this beyond these two auto jumps in the future -- I'm not sure
an auto jump that goes looking for staged white spaces issues would be
useful to anyone in practise and at this stage I thinks it's best to
drop it.
