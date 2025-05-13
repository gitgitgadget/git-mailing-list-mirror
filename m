Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29441E5210
	for <git@vger.kernel.org>; Tue, 13 May 2025 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747161142; cv=none; b=hAKyVIgUvvUANEovBcoghogEpzYgtutIA3SYeP4Y5l9G+GYXlFdWeo5Fv4vFyAIIV2r1JWKDi/NWUceulTy6A2LY742+eyrYGM3iMO2fmBuogWM9XZg5EH8VZN7QK2Totoyz3bHk3qkQAjB12aUtun20z3v6ccqF2boLiksN9Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747161142; c=relaxed/simple;
	bh=XXBKtJ24Jm9sCX2yuJOUXRtgVT03yhfQpTI1acU7w/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c74XCDTlzCejN3pu4EdPIJxEJIKKcScmeYtITnPeCWOcwyipeZ7bibRanyfc6+goSSehSit2o1/GhTDZGl8+PD9nraZNqF7ThjhhmgCf2au2EGrnonNhRT4Odeu97z8Lk+o+XKStfZwToliMs6uOr9zeuohkaYpR9/kIE2FOb1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6f53e612fa1so8375676d6.1
        for <git@vger.kernel.org>; Tue, 13 May 2025 11:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747161139; x=1747765939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXBKtJ24Jm9sCX2yuJOUXRtgVT03yhfQpTI1acU7w/g=;
        b=w/y4R8B24FZx3+/KsDb0iP0MLRXVfnKrKfYHmBQpNILuZd98OIY2FCgZvaWzbgKlHM
         bQ3fsV5kiEsVy4/4YJ/4VvrM5RhaZULFQL+0PnlzKG2cEnHip7gQNKFFo+PMr5Rv/6+q
         g6qR65nx+dwiCj//ojx2EUa7KM99w/KhJN3YWKnH53XC2VI4SuCNbmBGGARp7N8Rb+Ob
         QNbLduruVnZIt12pg58s79YOeAg3UkMi8Yl2m9MuA7zO8WubJp15SB2Dl/FvSNp5HXDB
         n1IcKJLuPKR5IWn+6sS7J89Jol3RS/+mw/NidKuhxR/PetPqo9ftRSyprNiHGhXfRobl
         BlhA==
X-Gm-Message-State: AOJu0YwbSkfaLvjuWcj4aEpfwNChlh22Fz7Bvq99hjhCpOagdTd8kPdp
	d/mf4myM2CKl51VfM5ycMJkIxCC427M4Mexo5anpGDYIROJkeV4sBxBZcRqdajetGclcawmwUEb
	DNdQepVKUHr94OXESE2LKLT6b7C5IVYRc
X-Gm-Gg: ASbGnctqUJEpUHf2ql4T6MRNpDwxT1E8+wJZpLmsmwmWxqq9/Kt4EM3WCpPTRuuGIMU
	KYBQc5I3BMGl32xxiQQHbF3ONyUbZxDU/fBYf06gBWQJFHh8UiqGWfjkH3z5ATXiCF/u+C3L5zW
	QMUzcHW/TH76y6QATxEQhNxOJeUx21aFM=
X-Google-Smtp-Source: AGHT+IHQm/FmUF3w9y7yevcmSQG/n0TMgOLcKyNVsqblxNlIiNsxfI6t/VFvxWvcGULkuZy/YZ1tVpg35tEUUv01RhE=
X-Received: by 2002:a05:6214:20af:b0:6f6:e431:4af4 with SMTP id
 6a1803df08f44-6f896ec2d9amr2052976d6.8.1747161138535; Tue, 13 May 2025
 11:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AS8P191MB2174CB58B1A29D1492EE7842FAB42@AS8P191MB2174.EURP191.PROD.OUTLOOK.COM>
 <CAPig+cTK+jz_kF7zd85nVRCn-6sqbH0o7N_ZDtDZDVjYbYgQtQ@mail.gmail.com> <AS8P191MB2174A636B81F92212F4B0C03FA96A@AS8P191MB2174.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <AS8P191MB2174A636B81F92212F4B0C03FA96A@AS8P191MB2174.EURP191.PROD.OUTLOOK.COM>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 13 May 2025 14:32:06 -0400
X-Gm-Features: AX0GCFvjPWj6KCFEpMlSV3-Xx51HjISkqw_7ctWB5JtIMY___Cd_9E8h_sycSv8
Message-ID: <CAPig+cR4Jb0w=McwobCrtySD1nH8sF6rv7MGduQ-yVsRUHHSBg@mail.gmail.com>
Subject: Re: Possible git-gui bug
To: Lauri Reilson <Lauri.Reilson@proekspert.ee>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 2:09=E2=80=AFPM Lauri Reilson
<Lauri.Reilson@proekspert.ee> wrote:
> > From: Eric Sunshine <sunshine@sunshineco.com>
> > On Wed, Apr 9, 2025 at 7:11=E2=80=AFAM Lauri Reilson <Lauri.Reilson@pro=
ekspert.ee> wrote:
> > > I have a small issue with git-gui. I added the git-bugreport to the a=
ttachement.
> > > Expected to commit using git-gui. Commit message was in the format <#=
task-id message>. I use ";" instead of comment symbol as "#" is used as a m=
eans to track task id.
> > >
> > > > What happened instead? (Actual behavior)
> > > Git-gui gave error message, that I need to provide commit message. Tr=
ied one line, folled the error message (first line, blank line, remaining l=
ines).
> >
> > This sounds like the problem addressed by [1].
> >
> > [1]: https://lore.kernel.org/git/20250315140913.577422-1-oswald.buddenh=
agen@gmx.de/
>
> Sorry for this long response. Thank you for the information.
> Unfortunately, I don't follow quite well. Is this thing going to be
> fixed or not?

It appears that the maintainer of git-gui, Johannes Sixt, applied the
patch mentioned above to his git-gui tree[*] and that Junio already
pulled the fix from Johannes's tree into the Git tree. Although the
fix hasn't yet made it into a Git release, Junio has already promoted
the fix to his "main" branch which means it will likely be part of the
next Git release.

> It has become quite annoying that I cannot make commits with git-gui
> and there hasn't been any updates.

It would be helpful if you could try applying the patch mentioned
above to your local git-gui installation and report back here whether
it indeed fixes the problem you are experiencing. If it does not fix
the problem, then my supposition was wrong about the mentioned patch
being related to the problem you reported. If you're not in a position
to try the patch locally before the next Git release, then perhaps the
best you can do is wait for the next Git release and report back
whether it fixes the problem you're experiencing.

[*] https://github.com/j6t/git-gui/commit/6b43a57dfce1e5acd85f7a8365c080b6f=
c4f8645
