Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ADC33C9
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 03:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744426814; cv=none; b=jKdWG8vN4F3a3v5Qbl0kle2fMwYSScBJ+/6jHhfUf8ZIS6ttVtI44buIBVCmQLET2o9tynZQbGa6Tp/AeJldL8mwtwx8O+vxEYHyNI/xy2840e1Ovne53uj1T9UIozETthlYoQCbJPaz6Imvwz+T+1v/8STCDADIyxESuJW8oO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744426814; c=relaxed/simple;
	bh=cdDhKZ7GVtXcscadjhr1d7aG12MiW0S+3kkktNTt0n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3YCy0aI7Rcrw9GDGHOc+AFfK4s6BLbRmIGCEoSUG9iIfT2CHIQ3ZqPewgLcTNsbV+wsQg01YiXLpU3TnrrZy/d7ZAKbuxCcmsvbM6VOnvrA9fE9sHYg5xRjR5pfMaMXO1YJRXy0s+NxVythnHWcwZcDx+7o47ljuYFk4XLMEog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyozA8Mh; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyozA8Mh"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c592764e54so330695185a.3
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 20:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744426811; x=1745031611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdDhKZ7GVtXcscadjhr1d7aG12MiW0S+3kkktNTt0n8=;
        b=LyozA8Mhb1OMcu4s3uqfItTRm0HB+ozb2EGnbyz2cBiQsSKhQjlHejMgWQ0keug7H3
         du5GCV4CpvRPQev1YCnkFbYRgeWK73BjdlLPEp8Y/TQXG03gyYut4kFrTUsGa/hqnguD
         jFwkk4DXRsagT6KOurAhhSuMTtxVH8YVC3a1hdOY2QllQ/Qn4dJh37wcT5zJZd7AB7X7
         l8WGwRQoDB/xbRRrQCcnDI4hTfsMVlO2GRPqxsjCTv157Y31yneMCCCk1vpf3fasawM6
         KV8eE3VyVIQOGe8M8UeIuFyXphvh6xoyVqUSRymhaCT78scN2eZJotGE4yeKTWSGqAy/
         /DvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744426811; x=1745031611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdDhKZ7GVtXcscadjhr1d7aG12MiW0S+3kkktNTt0n8=;
        b=jYn3sWhUECWBsTfY5X3/0dTrfUfb2C4WrCtP7kcutsBfDz23oZD7pbAE7Q9Z0FYL0W
         T9NVQqUL2Oj04kqaStzmIQGEwG0zisbXhHyb0f1MKhOg9BhFqqXyrqh+f7PQtkdQjD3o
         184WcsSsQBHa/4dWnbFf+IRBuHy2dOD/aw5yqmhEWSnCPXk02AJkzP9RdysOXfHVgL+B
         2kkhmMZ+zqBPikIjXu5aE2ic9zwYs9vPT2P8G3dr88GTOToAmE233FsW7Fg7voisI7v5
         7u66wsbxxQBbIy6u1k2dFDlazHGkCGZE4T0jd5KohK6ds+M26vm2IpP9EsZ+mXsO57Gy
         Yutw==
X-Gm-Message-State: AOJu0Yw0uq9k8UVrptps1pLzvUpAQbbSucMQ//jzagLaozhGFHFy26o9
	wDu/z3frGCrlQ/dAD3dRLLaace45iyvbJtn1YYQaNVJWLgLG1g0wWUREUgKqq4+6wr/W7/sjiQn
	YuYQ9sa+WugmEhP4pq2VzLcCVzTs=
X-Gm-Gg: ASbGnctkCrJMcoC1tw2NySlsJ5CWUUms/pEUagNNAD3n4cvkrvMrN675rFVeo5Ljy2m
	+DM069w31QMUi47AmAfoUX+6MWV7l8jnOX+oefLRMgRczSAMb4dh4qqnFZVExJQTZJD6ZzE1cAE
	qeg7HybnbBDsUzFT36AXQAmDKtYD5vSugzScmyeivEStOOFPu9D/EKglo=
X-Google-Smtp-Source: AGHT+IFnxwoI4F6gsTIr1hEDiRMxVa5G789K3OT/MlhF9TLPPjsH6iGI9sxzWA14MMqK/LM4JA0Y9IQwL4gEN2s6tgE=
X-Received: by 2002:a05:620a:4310:b0:7c5:4738:8a0f with SMTP id
 af79cd13be357-7c7af10c12fmr653469485a.15.1744426811149; Fri, 11 Apr 2025
 20:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM0=yBnaXojeC9WkHg08deR-VpjaVQwyrqt8mk+54qLXqSaAQ@mail.gmail.com>
 <20250412015748.7177-1-jayatheerthkulkarni2005@gmail.com>
In-Reply-To: <20250412015748.7177-1-jayatheerthkulkarni2005@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sat, 12 Apr 2025 08:30:00 +0530
X-Gm-Features: ATxdqUG33As83cKZ-vJkPo7z412MiVlcvCuRVDVSQLdb38-4-C87I6qtKPgluk4
Message-ID: <CA+rGoLd-bSbaqfswD+qVrCv1fvG69QX+3BO1htbPJtinFkEQAA@mail.gmail.com>
Subject: Re: Bug: Git sometimes disregards wildcards in pathspecs if a file
 name matches exactly
To: piotrsiupa@gmail.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Upon a much closer look into the Git source code, specifically
init_pathspec_item within pathspec.c, my previous hypothesis regarding
the optimization check in do_match_pathspec appears to be incorrect,
or at least not the root cause.

The debugging output confirmed that the core issue seems to originate
earlier, during the pathspec parsing phase. It revealed that when
processing the input string 'f*' (without any explicit magic like
:(glob)), the resulting pathspec_item.magic field does not have the ,
even though the string clearly contains the * glob metacharacter. (To
clarify I did multiple fprintf checks in the do_match_pathspec fun)

Looking at the logic in init_pathspec_item, it seems the PATHSPEC_GLOB
flag is generally only added to item->magic if:
a) The user explicitly uses a magic prefix like :(glob)f*.
b) A global setting like GIT_GLOB_PATHSPECS_ENVIRONMENT is active.

The code does not appear to automatically set PATHSPEC_GLOB on
item->magic simply based on scanning the content of the path string
for unescaped *, ?, or [ characters if no explicit magic prefix is
present.

This explains why the fix attempted in do_match_pathspec (which relied
on checking the PATHSPEC_GLOB flag) was ineffective =E2=80=93 the flag wasn=
't
set in the first place for the 'f*' input. It also explains the
original inconsistent behavior: because the pathspec lacks the
PATHSPEC_GLOB magic flag, parts of Git relying on these flags treat it
as literal by default, even if lower-level matching functions might
still perform some wildcard expansion based on the string content
itself.

So, this seems less like a bug in a specific conditional check and
more like a consequence of the current design where the magic flags
indicating glob behavior are opt-in (via prefixes or environment
variables) rather than implicitly inferred from the pathspec string's
content.

-Jayatheerth
