Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274B048CFC
	for <git@vger.kernel.org>; Sat, 22 Mar 2025 18:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742667985; cv=none; b=ZrKmnv4p2AKLeY4fhFYTi7IP1Har3DxeE0nlzUX4HcsLjP/+kcMSFufGXNN4DqUzlAu2+F3dNozsULSrS4o94TzpyTYDlPYeFMhLGKhQmOPHCkZgktQaJU1mexw8BQqIjMZdbFv0vAqenBeBdw0wBvgRQwILYhe2aQk4kNBeT+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742667985; c=relaxed/simple;
	bh=7BPl9AkXvPw6IkMoCz1aMNGvMJIr1ksEMSGSRV01KXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ax+7S+lfQ5zzY8oQ2zPTlTH9AQcv3ZsZfR4inA7kQa5k8/5EAkvcqt55AfnhMei/KFUxMVFP9eLkc3yD8sIONlmeTqzzrEaH14VXzJwoTKezULJwvIpk4JBnPoBLSVHIl9oXpTN6qLFWqI/jFTPoXKlFD+Ca2RUGUMoIXRg2dM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWE/ONRN; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWE/ONRN"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso18019065ab.1
        for <git@vger.kernel.org>; Sat, 22 Mar 2025 11:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742667983; x=1743272783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BPl9AkXvPw6IkMoCz1aMNGvMJIr1ksEMSGSRV01KXY=;
        b=fWE/ONRNN7jstOWOuZEwMrVVubqKXUofZfeLCn0bPdQFfnOys7Y+SOorqH9f3DKs3h
         MQLKUp2m7Y5gbTVJ9gjXEv4QAeEn2wTHRltQIjHwTKJxJtYLO54ifNJDXkBHNS/IhxCT
         rC7tY2BbyXyxxE4czLaXHhQ3s7xyOAfRsjenI17LCdo8sJB/jUbknUPo8qjz/UAtdnPz
         bNTRkf+gGsslMvt3TW89tbffM5w1gyH+7l50mgVWMOpUB1GG9aOBSSwJ21v1lFFELi9e
         FD3RV0ULLfkjDeYGbPB82pJR4XCnmvDF6oC9RwiZ9okGDVgpPw4a/jdwdPkupIJ/87N0
         SR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742667983; x=1743272783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BPl9AkXvPw6IkMoCz1aMNGvMJIr1ksEMSGSRV01KXY=;
        b=JBdbJ8E/NQFoGfqHYg9k3fGgd8HLVs1sArgcDA8I2H4GT4C7jkQQ0kfXazPSF0JB57
         4srotSA+dpIgFRUPcrwwEPfmr8f/Fkz+ieU73yGjDUqFeSLkKve4JPYycydvRI5+iOPU
         WtKKFlKsa1FKrTwGOaYJgUPGweyPpB1gAf/wJbYQwr45fxRaL8cbHwvRcc1i064pflrV
         zP75D+UACoZmWZ2pmzaFdMBm6D0FrrHquRA74fHXw7Sm1yASEFlqbhj4tCnOcJCE9wT/
         wxSIShaiJJCEoq7okZSfT8AtOt0kqfuDOpi3Ej8BSDCf4LAoGX9vQMWe+7TGr4HOLizo
         V3aA==
X-Forwarded-Encrypted: i=1; AJvYcCVKNglDAFoue9Gq5f7i4Aavhdf/5Q3uoBvWkf+qdzT/JgL7/KoItLkki5BYv74U7LCLNZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEuZbglt/OtZYy9iU/ke4Mu7hZVus82oTQ3wlNU+8glI/aBVD+
	MOvg9yvCiUkWURsglkS5XyGNsnZATdb+bazchlAUF/MXaHizUCevJwH8l1h9Qa36M3JwSDYiq7a
	l7IpwnTaEB5r8exlsSiL650Cbg1sCsg==
X-Gm-Gg: ASbGncsfWxloYnF4tfXiVzqvwB45sNTL7Rz0VRK6HdS2OzybfEmnV1zrE2R6XSQRCiC
	wNqfW5VKMeTHugl+Yf0DecKBRBepaCXICBM5nGIXXB8/67Fw278QohXqkfM0kcu5C6Pm54n0Y+T
	M9IhG3Dgwd6Ze5k8FXIv+1LZ5Cvpgx
X-Google-Smtp-Source: AGHT+IEo8kSjVDf86tPRC6x26omQEcAxatvxTWfV04d+kpIs8jYs/xrh7fkBXmJ2DTrT4Aub919/N3ZVU2N7ZYMatUs=
X-Received: by 2002:a05:6602:4c05:b0:85b:46d7:1886 with SMTP id
 ca18e2360f4ac-85e2ca5962fmr820079339f.7.1742667983015; Sat, 22 Mar 2025
 11:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1930.git.git.1742637713157.gitgitgadget@gmail.com>
 <CABPp-BH9ia_GRNYx+zRCht3n0V=X-uLq2Zg+QWTWCyJfMkeznA@mail.gmail.com> <9A950A71-8847-4F1C-A691-5A9CD461FE6C@gmail.com>
In-Reply-To: <9A950A71-8847-4F1C-A691-5A9CD461FE6C@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 22 Mar 2025 11:26:11 -0700
X-Gm-Features: AQ5f1JrWG46uBt2ZgsBhdEC6p0Hsp6lvdYG86KF7Rvbc9QNSIvwoSTTQOc96m0s
Message-ID: <CABPp-BHDF9ufzP6e-YfFbom6XG_QUxr5s=ZGVS-6+zSYm0bBFQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] shell: allow overriding built-in commands
To: Ayman Bagabas <ayman.bagabas@gmail.com>
Cc: Ayman Bagabas via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 11:02=E2=80=AFAM Ayman Bagabas <ayman.bagabas@gmail=
.com> wrote:
>
> > On Mar 22, 2025, at 8:39=E2=80=AFPM, Elijah Newren <newren@gmail.com> w=
rote:
> >
> > On Sat, Mar 22, 2025 at 3:02=E2=80=AFAM Ayman Bagabas via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Ayman Bagabas <ayman.bagabas@gmail.com>
> >>
> >> This patch allows overriding built-in commands by placing a script
> >> with the same name under git-shell-commands directory.
> >>
> >> This is useful for users who want to extend the built-in commands
> >> without replacing the original command binary. For instance, a user
> >> wanting to allow only a subset of users to run the git-receive-pack
> >> can override the command with a script that checks the user and
> >> calls the original command if the user is allowed.
> >
> > Sounds like it'd open a window to generating numerous security
> > vulnerabilities, break git's own commands that exec another git
> > subprocess (e.g. git-stash), make debugging git bug reports harder,
> > and likely break programs that use plumbing commands.
>
> How so? The security implications are the same as any script
> defined under git-shell-commands. Git does not handle authentication
> nor authorization and it shouldn't do so, and this can allow repository
> based authorization to happen using git-shell.
>
> Forgive my limited knowledge about git internals but how would this
> break git's own commands that exec another git subprocess and
> plumbing commands?

Sorry, I wasn't reading closely enough and missed the part where this
was specific to `git shell` as opposed to a general ability to
override built-ins.
