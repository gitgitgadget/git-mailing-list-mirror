Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F083043DA
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765569634; cv=none; b=Lj8zA/1Yt5wP0F+izmwdLI30g998rp1vR771NOYlDQxchNl61/C+ZhD5MME/L+42zllm8K9azs8XuMiKVl/kX+w+3Wm+J5/21UNb5WEaVDD8/Zc0TEustM9DdPMOJr4bBB/oNpYSqFO9G9AK9FKXdxCaEFw5NxzI/Wr4zMf6o9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765569634; c=relaxed/simple;
	bh=kLReX8qqv/swP0LDCSPd1qjQfln40UteWchiIoJPzig=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZEAtJZYFsXvX6y0jBhqP1ZpLIS56Wn5MMFiiIsAfdpCkloKe4ovR6YrO3z01N1oYlYNh222CJ893k40Cc3tdmZD9uHAjDtwqn6GDQ/wT9o433LG4LXnyWYyZxvnJyJ9dlzw6EyFGZL12ziRiXVawrCKgEIFlpBfqC2G+iO8WO50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXyS8yul; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXyS8yul"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2956d816c10so19232135ad.1
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 12:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765569631; x=1766174431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9TwUzWNBWgmI5y+2T3+S4yjRQndWiAr8bfNhfMJV19A=;
        b=EXyS8yulG48eX/LUsoK2CB8yz9wi2PqqGVFajObruHeSS/zJJo3aP+UKVD9qQBYFWe
         tm40hiKKFEMjGZrx0HAUt9gIjSbB2ZKLIwSAZykUrATR3mX5/w/JizuTiGHliQc/gHTO
         4IdQrZhASCC9tXm0MBF7uW7DZj+KY0LezX+jI9/e8Szfa4P1dNHgKaZBN/rOYeFPVHpX
         OgyFoG2WrBL11befccdM/QqYWLkl9B2W+9TPvjfdYCKbM9S5ly0WHbWf4Ww6n+A2omci
         Sj4LoWdlqqlL99bQ1nCwuUaNVNtutYPJp3S0emBdl8kVAqR2rSTpMDjl5pVBlIMnmoEf
         1sOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765569631; x=1766174431;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9TwUzWNBWgmI5y+2T3+S4yjRQndWiAr8bfNhfMJV19A=;
        b=UmBfg5UliOBj/YfhdOnUd2nVb+rl/5RNcF/6n9mvR/ayJwNnBaGy5GUXjHkLQt9nIJ
         980382NuaCzHdgSh7SJA1DYzVzPbv35eTYKxNrt6mZ5Q2iZkemvwAJhxSwU/OzaUnR9c
         O6vfL3ozftZ1h5/KSh4+bvtho9JDBSj6orK9o04C0UioNxSwVg8JM+QZbGDAr/x6EW+/
         q7LyrqS70UBzvqS22gTZ6bIv4uprWcFc582CIGI9rs7mPZ5E3TcdUPCnKqwRzAzohDZY
         AVuDiE+Y+rxoVr7oKgVLbSaS33z7umRviiimhNHOk0QNkUgJ6Fjuil19B7vXti7Gv03p
         5lFg==
X-Gm-Message-State: AOJu0YybzVy781Y/eveuqqnFgVNnruzUlvbXW0RW8rlvQa8MzDyEWE9y
	UZ1gPwkk2pZuYtxkCEy+1Dc1IWWWlM7I7PeSvcmJgubzg7e7thnsCatERbSy/BVfhktnPdh5WDF
	JBCmWDiNUedRm6B339gx4Lgy0BU+wU2xtWDgi
X-Gm-Gg: AY/fxX5oS0vA5hAV72sfYqoeU36iPwM+FHc6kGTFwMZBwEeflvvowEeUEYx88TByaLt
	KKKYJcHgp6VZ9/2JUMkSKUs1gKa4Kg4scc5zcJjSlvS9ZvTg87VlI/KsjbJOq088w7WqeY5a2js
	tvyHau8OiiclfKIdo380gOzWLCRTOSnx14MLsRsKK9sG82519z7Xe3KT+WYtFe+9MBfvXptqErc
	/Ft2L5+GZG3Vlz/qF+NCdTecSal5/MdlO3fwVxznNLFUQXWP0gZI8wzfoIaKX5LhhnslAgKpzRJ
	JurHv/MFN9vFSLdopIu3GnUSiuxC/Q==
X-Google-Smtp-Source: AGHT+IH7r/lmDSaaCRFm0gnhrf1oJ+g9WsD9y2g0+nPfoSdr64dq/DX2pP3DWmLvWiZiVNBAG7FCDUXwxzGy9eL9sbY=
X-Received: by 2002:a17:902:ccc9:b0:295:5864:8009 with SMTP id
 d9443c01a7336-29f23cbcceamr34224975ad.44.1765569630978; Fri, 12 Dec 2025
 12:00:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Fri, 12 Dec 2025 15:00:18 -0500
X-Gm-Features: AQt7F2rFEFUVaLUAL6kiqXqfnZY6_fDcsVwTkMaOOm8AqR2_aUuDgdQPpvIAAMA
Message-ID: <CALnO6CCu7A7mkLy==K9a-u-z0kYBKLiyBz+Qq8c7PWLHO-YuNw@mail.gmail.com>
Subject: meson -Drust=enabled fails on macOS without GNU sed
To: Git <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Ezekiel Newren <ezekielnewren@gmail.com>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"

I think it's due to e509b5b8be (rust: support for Windows, 2025-10-15)
[relevant folks CC'd], where we assume sed can take "-s" (which AFAICT
is a GNU extension). But perhaps "-n" was intended with a "p" flag on
the substitution?

I've been building with Rust enabled on Gentoo now for a minute and
haven't hit any issues, but that's perhaps because the command is
running with "-s" and not working as intended (yet still producing the
expected results).

The relevant snippet is this (reformatted slightly by GMail, apologies):

case "$(cargo -vV | sed -s 's/^host: \(.*\)$/\1/')" in
  *-windows-*) LIBNAME=gitcore.lib;;
  *) LIBNAME=libgitcore.a;;
esac

but "cargo -vV" produces something like

cargo 1.89.0 (c24e10642 2025-06-23)
release: 1.89.0
commit-hash: c24e1064277fe51ab72011e2612e556ac56addf7
commit-date: 2025-06-23
host: x86_64-apple-darwin
libgit2: 1.9.0 (sys:0.20.2 vendored)
libcurl: 8.7.1 (sys:0.4.80+curl-8.12.1 system ssl:(SecureTransport)
LibreSSL/3.3.6)
ssl: OpenSSL 3.5.0 8 Apr 2025
os: Mac OS 12.7.6 [64-bit]

(on my older system, on which I haven't tried the build; the failure
is on my newer system with close-enough-to-the-same output). I'm sure
you can see why I don't understand why we need GNU's "-s" ("consider
files as separate rather than as a single, continuous long stream")
here?
