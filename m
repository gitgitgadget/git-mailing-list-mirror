Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DB2270ED7
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743811; cv=none; b=ijzxX+85qfR/AlUPTpaGrLMz6+WqFPt3tFNOHaPsINbcrMdmwd/jcSLUmBYwGS8neKQQwouKFwWqU1lteYd0sIxQ/jQ63a9Mk21s0jQjfoHipEj02DzO5KuQ5KxnIRIOPlb/uYHY8gGkiRRNqwTg68Bd/lLQv+YADJ741QRE4C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743811; c=relaxed/simple;
	bh=daUjAFPkprZPBApQdLKwqHESNLIf+UDDLMNUfCm7Apw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcOn5bVbH0NQ2lygisJS8joE/nghCsxoPF4x6HZtBXuxxZc+bEblLsV55psKr9CItD/EHrfxFpH7CeF9pJW8bbfHaEzKZGUigCdxRS7Ks8u9pzsnAEwYqLheOH+kZx8LmWXvxDm9soGuJGt/rdOflskcsNr9+sCu3prPWbddgNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbkfgRf2; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbkfgRf2"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b28e1b87c31so38123866b.0
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 12:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758743808; x=1759348608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daUjAFPkprZPBApQdLKwqHESNLIf+UDDLMNUfCm7Apw=;
        b=EbkfgRf20OCI0qS/jApqm7Erg9IXHS7C5gsmziGAKP5QAxu/UeACHRNIrxFeDOrz+5
         vrF998EPq4tWQa0RxMck9EiyO9m+Il42cpVwImlXex03qA/Gs0FPlUOepUfHOp2SLQyO
         +JJ5XyeWCXEDc4m76j3DApoBXn3Ugr7PneozHLgvvZQT7lQQZBaQjQfj+4by49Fe9dGV
         RmvNBx40PVxBLXrlqBYBDWDfz0HDGdFrLVqkfWifiyY/s/xZfIQt4+m6EK7hEUz2c8PF
         u/TqTuC9OFbZuy8aa8OnpGKLTJwYEkK2cgHX5TzTzgmhUhxYgqqBJZfzq7X1tRBodkOZ
         sMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758743808; x=1759348608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daUjAFPkprZPBApQdLKwqHESNLIf+UDDLMNUfCm7Apw=;
        b=Vd9ogW4/O/hidQCUdGsikhPP6929IKWUvnLs/TQoUP9NjsdZK3jW26QlvbOy0xNw1N
         qFp9slXZ6ZCuITVj8PgfAXQHIVY3i+q3CJ4O5GCAJQhimX6crLMSJE9BpC+qR9Tsc7X/
         DtrvTnXF3amP7i0LboCx2mqi9sqMmMkOpckUsfKPDTK8C7YjJPD5SYnsdVy4dKKY0BHk
         pWkO/AzDB5a5vn2EVUofofc0vN1iP0Sxf/hYBrYrdgDVCtmklfVBkJsafKXauBQ253fr
         c4g4G2ZcYvirpsEWA9YV7DbDwFuh6M0lNHJt282e7wQ70ORUFGZl0jYzUD0ai8XihAWl
         3irw==
X-Gm-Message-State: AOJu0YyYL3j6WCoUy2KIzH4jf8raquW4bHr2srlecOQqWMPEduCflRuX
	/PrmL7JrlQspungPe+9yBfKTvskfeG48TFSx1LaHcPk3MVD/2njiKakyR/Q/AgPqWgzlk7HgjJm
	PxbuOyrEhDngcrh0hHyawunTV3ulBPhc=
X-Gm-Gg: ASbGnct2hKIgl5MiuPRntDLod1IHLotOm1TZeuoxSzbqSYcvag52hJGtLGjV6fxYGKT
	LEjzTC64lI0248Nlxr2EI0TsfZ3uwDzuJmXhXvoMVkAYhPkUgVZ8ylX7BveVRruhtlMavg/+fxA
	tXU/IDO0Ar5kJXFdAUDIXrGUmFIiiDfZSV3wlt7m8D6GnyrBoQDufiFGWfiNUnLz8Fyge2thz4o
	010MrtsXaMEfwNYCJlS/7Zc0ykbtXwuSg27l4440A==
X-Google-Smtp-Source: AGHT+IHo1yU9Db/q4tSSgjSJQKxRmAkq3F9i9jLlI58+cZqBF62M+4pxK93jUO5Ladk3Pifyc20bhaoa2ck6iiYtyCE=
X-Received: by 2002:a17:907:72ce:b0:b2b:f498:e2f5 with SMTP id
 a640c23a62f3a-b34b9782caamr112835266b.27.1758743808304; Wed, 24 Sep 2025
 12:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
In-Reply-To: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 24 Sep 2025 15:56:36 -0400
X-Gm-Features: AS18NWC16A2qk7yhKdCTja8n9__qqeuk1Z8PkXPfaHp1xTo1__7anh9hZNafGJY
Message-ID: <CALnO6CBh_dcbZuSEebG28eQ+N1KfxzEuOp9uxsWEjBQ3Ci1ZYA@mail.gmail.com>
Subject: Re: [PATCH 0/4] doc: git-pull: clarify DESCRIPTION section
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 3:45=E2=80=AFPM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> I got feedback from 15 Git users on the current git pull man page, using
> this tool: https://text-feedback.wizardzines.com/git-pull.
>
> My goals here are to be clear about the relationship between git pull and
> fetch/merge/rebase etc, make sure users know the current default for git
> pull (--ff-only) since some folks still remember the old default, and to
> help users quickly figure out what command they need to run to
> merge/rebase/squash/etc.

Huh! I thought pull would merge divergent histories by default, and
even now it's hard to extract that info from the manual (the first
paragraph actually mentions reconciliation via --rebase/--no-rebase,
but I thought --no-rebase was still the default). TIL, thanks!

> I've taken a pretty aggressive approach because I think it's possible to
> have a pretty short and focused DESCRIPTION section here while keeping th=
e
> most important info. Open to hearing that I've removed too much.
>
> This references the UPSTREAM BRANCHES section from
> https://lore.kernel.org/git/0ec629d4037bf5d1ccc248ca1bbd87ccc08119a3.1757=
703309.git.gitgitgadget@gmail.com/
> , so if that isn't merged I'll need to revisit the approach here.

A common way to handle this is to build your topic on top of the topic
you depend on, and then mention that in your cover letter. I'm not
sure how GitGitGadget handles that, though, since with format-patch
you could then specify to send patches only from
<other-topic>..<this-topic>. So I think this is probably ok?

--=20
D. Ben Knoble
