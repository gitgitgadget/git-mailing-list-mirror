Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793974535;
	b=YakNCi2UKSr3FgYxG+xn9AL+QU+6XJIS/A2z3eENzJgKAJlmNQeZ1hpka/G5y4ahC6mW
	 751tvJh6Vx9bz6plUc54MQ2wqqG4kWkjoIpxwCApEmMIczq/mcPMz+RnICId2nLAj8JrE
	 CGVB6mDxXSpvUBjuaVQ6MuF34iAdimMov/JuonH45aY+JVhKk+RzDAD8+EST6+LfQvnQ/
	 eYl79QCFOchoOyt07OIaAdtZf6Ko2Eu5CFXRosl+KD+MgrvOQlA1ZX6iPBZEi2lyKtWUk
	 53VnyzGoI0TLb9diE4mdxCGGqBzv/KrGOr0qirG6DkPztoaHvvGi9HWEDtO5oBEHKNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=8HrerOgz/pM+Us8Cn4KUf/RWXE+y2enJTsRHMaVITq8=;
	b=sl4lgcn68cvR69ICupx+1d5hiF6lVgq88SuL+Yo2hD6M/NdKNfRtnhaRPw8K5KcjutkM
	 FvUneQbyeAQvYfOaDPbBS737lxFUk6WZ4LLtUVSmLIOpsX636OmGETPCBc0yC4jzAFxKz
	 3sC69TAOFUs+IEGLsc73DZYbf1ylXUsz8pYwTwzlppXCc9KnMg54cXzkISgRcrlKtZ7ON
	 pl9MrECm0XL/ajjNf7Qt4DAv6J41dIorZlWqB9Y7SNEqHZuhX/M0/dVExxZSpNE4m50bg
	 6/WdLfu/auX91q6ZiakWMUgDjCoYgE4dn11QwuuixL+St44sdEyZJeyB84Ud7WWBg/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rb9eG8fr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E945A606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 14:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E945A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rb9eG8fr
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a07078200fso281179b3a.2
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 06:15:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793974534; cv=none;
        d=google.com; s=arc-20260327;
        b=BDyAGPc7REAunturdCMmJwiE0iSHFzLmUYYC1bA1dkqAibZ4+udpd1ZTlMZPrQBS3Z
         KkMEx5XUaF14b3uSzQH2mqm8Q8UmoyGQOwNB59Xrt4pDeBLR8EzmQT0NXDiSSoqOvYZY
         th4lDfoAOkg3aDLrWnq5mVmUgV9cmOm6g4ZLdAPBQowgfVI1uJ4AaZzA7DkLpDSMwEo2
         jfHDEimG5D13ERxySLDFTjjVk54kzRC2M2V7cXSJejByD4+1fv5G9MqkNCanegiuCZ/f
         sIanM29taeNBc3ZO9uWfx8l+fVz/WPofuaFXUTGSk1FZO3qDOyYyKi96oi1SRo3CmSfE
         d+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8HrerOgz/pM+Us8Cn4KUf/RWXE+y2enJTsRHMaVITq8=;
        fh=ozSzZTRsR0tpagYTcIL6twFTby+b5cy/PyfyqRZDZX8=;
        b=i4QWew83D+zgU3yISEzSqGyfVCads8J7UauGCETAdg2wX2joYX43uMwZFtgO/sFywD
         CoU7bjCQq83fhvKeJHh8qYlMp1oL7gPe0KcP8YsIPjKjqn/f5R2qr6+pAH1UE5FDFN8K
         wJjn7R2FrL4QLXBzgsOgSQ7tcDjypKqX4QfqqI7t3dukp3JZqTqQjTpVMk20TMA9jsnC
         WBNSYhjtd7zDpVegFbSNyXBfryV27wegkFDqLbNUxtcxJshAVVGCUALno/zGPORc6bk5
         HpITU3ghvI5Mv627ADrhsBaFAwsbpzTBqnZli+EhtzI4ZExa2SvTQzAbRuKgJLKi4CLb
         +jDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793974534; x=1794579334; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8HrerOgz/pM+Us8Cn4KUf/RWXE+y2enJTsRHMaVITq8=;
        b=Rb9eG8frf6CeHewkif5rWwUpmj8WB2h3cATZLyAkSNnon1mPSBQnssZicOe5TIAuAW
         1KnSdifZP9RH5fpzC5Mo8DAtPlcWvZeePzInZWhTM+AGG+dnWm3TdNNw50agLDiRV4qC
         lu3dwpEZdhbXXWDRZL9kCs48tO545oJKsTGqjoGUbdKWgyI+ZQiTd5+0+WILczESVcvt
         xnhFa3CsK40Qcwjr3Gj752eu4ogsZnNNvCd0de0XmxQuuwErxGFH6HMf/u4D9a3RunbO
         xabgRSG0GTl45x+l0R5chQgFEFAoeNwKXRL/27TTusVOyHp4oRM0S5MByQiNau8JLQno
         clVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793974534; x=1794579334;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8HrerOgz/pM+Us8Cn4KUf/RWXE+y2enJTsRHMaVITq8=;
        b=QhNZqkCdotK017kYorvz3UEsr63uWjvvrdEHvWhEOqrKmLbDOLM+CQarv1nBECUeOf
         erBsnMCpp2mMfu6rOKm3rt8S3ojnyIONu+SN/oggpoiSIBN+OBsehFBpcZb2GJBaKHeh
         EspRFYkwYEOcVAw5GtNLoZIup9TxCbVHwiSVFZkiCtsy2ThGjzvCT2PmwJgjX2VYCcT+
         sMXP9U+XWnVKz1+CsZpnv7dsZpJ6xjDD72kLzolflS4922+RMit967H8cctc/ZIGBkVj
         Th5UiUN7vWVCMJZQwPyvnFYl52sS2e05lAglpJlrws0MjpYCcGZoE0OHH1RozzFRSAqf
         8qLA==
X-Gm-Message-State: APuU4Z8MSE7FbclGxKLBS32CRb72cev3QILbd5Zs2Mep+b5qAqxlLF0k
	znGMuDdQkOeWCEDmyhklYvj0Npg2kCZ9FGCALVVDlkm4CdxqQMdb4uWMyMxjlxLSFqo14MV6n3T
	iQDAT8ZxD99EeJqouV/yH5LR0pF0whCc=
X-Gm-Gg: AYBFou1NA5XlRDdWaKrsvbyY8IH+78agd/nZeteHIsbd/bgIlm4ISFYn3iBBgXBfaEk
	9JbMOFWpXJP+K3q20tpvC/KjrcGjXh4iN9vc1YG9Gf99vB+naFMOmTDNgLJEQFpMK+vcnzMFPQg
	z+T0Otji2JVhxDXRgxFpSQYmp/kr5KJNcsa87s1Bw/N2AhmsBlEj4N5+r0zAPKHblombVu9IG7X
	K4NeWCYNbcPY2dNd+sUAgRHggxmiNI88LljQ/QcYgPob6121gKBf8KOIQR4HV/Zrv8OG0CkMkIC
	l9OfdWyr3C5S2TWlbuzDP7mTEvlkYu22NaEqbTIZmTWz/EzocrUAbG/8nYen5M3c8VnU7Z06IVy
	nr7FlWXkK5RvvjN7NAmzafVOt3/whHOjwUl6A4OjvaX2unEmvKaVHyAZiThRowRfhfgKKYdLcCh
	/8N3syRa9q0q8PhlNz5dcVyrxThcWVxJ2UBfjOsKNmFMn2XxET3XeMncULokO8C1I+C2Zvxl3Nx
	11UazlEP8pQ0wA=
X-Received: by 2002:a05:6a00:2e13:b0:89e:959:348a with SMTP id
 d2e1a72fcca58-8b37cdf6afemr2768322b3a.55.1793974534134; Fri, 06 Nov 2026
 06:15:34 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <au3Tyaz_LoYDuskn@devuan>
In-Reply-To: <au3Tyaz_LoYDuskn@devuan>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 6 Nov 2026 09:15:22 -0500
X-Gm-Features: AclHuK_5YJ8LP4asn0-1-EaUZH1aSD09FEOpIOYuHcGN852oIBwgie5vX7gO8Yw
Message-ID: <CALnO6CB-b2XuvwkQ9pJp5ENuc12oGMdgbcwz1VKD_i3KWfKuHA@mail.gmail.com>
Subject: Re: git-ls-files(1) avoiding symlinks
To: Alejandro Colomar <alx+git@kernel.org>
Cc: git@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 8:35=E2=80=AFAM Alejandro Colomar <alx+git@kernel.or=
g> wrote:
>
> Hi!
>
> Yesterday, we were discussing alternative methods for grepping source
> code.  Here's a list of similar alternatives:
>
>         $ find . -type f | xargs grep ARRAY_END;
>         $ git ls-files | xargs grep ARRAY_END;
>         $ git grep ARRAY_END;
>
> The version using find(1) has some problems: it is slow, especially
> after having built a kernel, when the directory is full of temporary
> objects.
>
> The version using git-grep(1) without IPC is the fastest, and doesn't
> have any problems, but it is limited to just grep(1).  If we want to use
> sed(1), or any other programs, we're out of luck.
>
> A common program I want to use is grepc(1), which searches source code.
> See for example this code for finding the creat(2) system call:
>
>         $ git ls-files | grep '\.[ch]$' | xargs grepc creat;
>         fs/open.c:SYSCALL_DEFINE2(creat, const char __user *, pathname, u=
mode_t, mode)
>         {
>                 int flags =3D O_CREAT | O_WRONLY | O_TRUNC;
>
>                 if (force_o_largefile())
>                         flags |=3D O_LARGEFILE;
>                 return do_sys_open(AT_FDCWD, pathname, flags, mode);
>         }
>         include/linux/syscalls.h:asmlinkage long sys_creat(const char __u=
ser *pathname, umode_t mode);
>         tools/include/nolibc/fcntl.h:static __attribute__((unused))
>         int creat(const char *path, mode_t mode)
>         {
>                 return open(path, O_CREAT | O_WRONLY | O_TRUNC, mode);
>         }
>
> A problem with git-ls-files(1) is that it doesn't have a way to filter
> files by type.  That is, it will list symlinks, which will affect the
> search.  With find(1), I can control that with '-type f', which makes
> sure I only search in regular files.  I'd like to have some feature in
> git-ls-files(1) that allows me to print files of the specified type.
> Since git(1) knows the type of the files, this should be doable without
> much overhead, right?

Perhaps something with "git ls-files --format=3D'%(objectmode) %(path)'
-z"? Of course, your examples already omit -z, so if you can assume
that it might be simpler.

--=20
D. Ben Knoble
