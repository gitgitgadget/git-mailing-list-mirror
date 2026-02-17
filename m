Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E119301486
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 21:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365270; cv=pass; b=VcwilcK/p1fgZZ9ymAmzEz/zbTBNsPn6w2N7rtl9SiZR/NV/QvKNsQ1ZqcXaIFw90OkMTWwItSIbo3unD5WNp3Z4PiRsXzK96QPDd+1fa/vgVRErt9B4ybhq/it2HMkPZY3Y2TxUJ9g0gzslhDSACiEiIQju55kpx0N5iaTo3xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365270; c=relaxed/simple;
	bh=VJZReV4bpLvHRLsZi08g7Z/SpzQuc5YtmMjNx4Dk+K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJCBzfX26Bkg6m3hd+kn/ORrb7ARKe7CFxua1jWigu2874LoqOknM76xyiu3W1lc6ITJhlNDbW7IrFVWVpBUGxCYzsGblK850USAt5gLhwo80NcWzEn4IvpeeUaBwKfTxhUOW+DwNpdoMZ7YV7MHlKM3k5wXrBh+YkMlsXPn3Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1tAIVav; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1tAIVav"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c6e191c4b8fso1615983a12.0
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 13:54:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771365265; cv=none;
        d=google.com; s=arc-20240605;
        b=lLlzRZKqftjeLhxRg+w/z+ukJHpHVSv/CcirYPmpQEqY0gNKahPhTCp1lo/2OBqFYn
         6CZsI+sgkDfE+ay8io4SC1v66fWlCKVSrzKIlOnzDDr0YWfBm58ZsQyrGyVajm8tA48X
         mmsTCKTgB8D35w6XzIveWdI1YiZ0FO4SZ8nBaGdXefGWsgLZMdvUaVKQZP8ZvbQ0GeZl
         cnJDriUJw2CH5xhcC/iYXy4qdRltA7x7mULnPi/6U0rNPp0VyQE9qu13XCtxlKkfI6iq
         +VBw08+nInOg5di8fCXzfcASTuLSoJEbb+vuWO2Ep8g/1d+dipJe8MXoEbcdDwsyaVxT
         hkaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tL1pv+5iMKyD+hEyPxHqSG2XuMrMcFU/+/a861rrMWs=;
        fh=ur2+dQ5WahDD4rvP9KyIuqGZjBa87/C1ltWV3KmHb5w=;
        b=K0v3grgi7Q0bX84ZybJFh9HW5edOpYdGDQkoqJ5/bq2YkNlQxYFWhXJI0gh1rALj7U
         MmWoy/UbFHPimBaouo7dZ/cCa6CUX3NiGh+yfXLQnKMxNQBl/lv5gAoeDGy5a3lPHf8U
         /tF5M+p5vCrB7Uri0x+ofWa0LzIF2lgN86OyJqFCWJ4jKZh2HysDqIC6Jx7E8TdIRiTz
         3bJrN3NV4fUlpn+4W7fUNkgzb2cu1cEddNao8JCOzbk0DDUZfUGpq+LGBT6j4uh9dEOP
         o6PCFuqbWbyV75WgKitlFs61gdp73K4uN+ZXuaKr3dRRPFc7oyLp3ZKO7Gasmq+OX49E
         zKCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771365265; x=1771970065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tL1pv+5iMKyD+hEyPxHqSG2XuMrMcFU/+/a861rrMWs=;
        b=U1tAIVavePZn7FfEiVR4cdDsw3Wt5y8tqtw+/MLU1/PGWWDg2WafRgae2XZfnDwmnk
         qy95sT+xr0r58TzFnVxVRRgt+GOjIIMxIHuPjcyCK07sVkGgJ35qoMNtXR4zhHz7pFYM
         1J/S+GDQb4wun4tYoUg2j05FyZeKFr1PXoecw+ZX271z4x2//Kknb3mWhr+Ik1vdAfFu
         mSFYuZag4lxIY5LMhhCJt1rFtwn4eAyRuZ+50VJtxYOGMVTdnkkHAOl0fOrWQzKxCJ6k
         gOrwQboi2i7DFupPOzOWG/lX80tt6zYxtmZZmxDL8FdxuSy1fyPeqZ9X/x+OeuGSCmJj
         p5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771365265; x=1771970065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tL1pv+5iMKyD+hEyPxHqSG2XuMrMcFU/+/a861rrMWs=;
        b=xUYxQO1GREtK8nEwvu20mnH6m6wue74hIXHp0lk43voww7G9V8+BS1Ijr5s79CKn8I
         WkulIMUwu9Cfalz95G+CIANhUEIcklSMkSNmd6o6rjVt4dWNHP1bgE0uRTrmeKuo1c4W
         bAXpVu2ibrq5NgjhyzAuBQguTjR77PR98hdF/50sQVp8j2wzm4nG1P3P1Mp2DaNbpdku
         3yajFIBSM+lcsrWv4I+QjDtKBkZX288wqFpLHUQUqkOwPOoBZ0puygoNrzzADNI0Jo9l
         Mzejl//J027sPgBpUzjp2VXq5gk4z2t7Jddg8/5ce5b+ypD0h3AO9Li27mC2JacFrHCX
         DxYw==
X-Forwarded-Encrypted: i=1; AJvYcCXWZWxyLAdqm/Ml8uMHurXk7IaZmqu1+j+Hrea+Q8C9l9t6VFuVv6MzcD6kRSnf6thkw0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrVTmH/qxLapXFA9Rlp8gdDouyJkUI6W6mKWJDTmXArJPhGFur
	yKD1hKY/QRLrZKkQw5+iojK5b3CFz0jrAvST/g9GfpqChO0HOZmZ6UIFl6Xg2BPPxNuMP1h+5MQ
	G62qxAm20F87GjuLBPow2ZteS1RnivhU=
X-Gm-Gg: AZuq6aI+KlbWLWLWpCvUhwwPVtPbZYEoTX0oCbmltNXwCBkxJbnIPSJEoB+6huqFCAV
	92M8v0en5jFDPDGg9U94cuTqThpFeBWFU4GpWHFuBnOImGrTfoM9e5IQN2q9Imqllv63t3lGicU
	gbhljB0YYk7yzFCyeFdxe+bfheaajDV4aB9gUxCcdTUDwpOPkOftrZffitANOV2klnV97Un3xr9
	TXn/txWlKZNoH+BcRHG9KfzNXr9ABNIcll6ke3Bz9+23mIyI04gRxkQEJIr0vDEYNzMqPUlV7ly
	OTOOb8Oh0Bqnh4QbxC66wosMQ9KeIrkfv7IE2tWRWm54vYVb/0Yp6hBmBQLi88P55pO5b2Fy5HK
	7oOXU9nEVqbT4z8mzhBfz1W5ibw==
X-Received: by 2002:a17:90b:4a52:b0:340:d578:f2a2 with SMTP id
 98e67ed59e1d1-3584481e5a0mr13874162a91.6.1771365265425; Tue, 17 Feb 2026
 13:54:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2046.git.1770746461307.gitgitgadget@gmail.com>
 <pull.2046.v2.git.1770775169908.gitgitgadget@gmail.com> <xmqqms1fwasx.fsf@gitster.g>
 <CAOTNsDz0ZtdsM8Z2NW0WBMGs8xyWz5ROS6pf8DKQAx26LU4xRA@mail.gmail.com>
 <CALnO6CARu8HSYh9=z6FAF=84q1qA4Oan7_DLMbcK+1rth8B7cA@mail.gmail.com>
 <CAOTNsDwMeszCC6wunkkx_vhKYx9OvRWXB4VxedypOTQJ6Qs2sA@mail.gmail.com>
 <CALnO6CCYorpEzmZwLrb7O-ucKLTOCLp6zXxZr0Qv73tOBqKKig@mail.gmail.com>
 <CALnO6CCys8hDtSe4=gFjaz7x410TH-7LFGRs0UU5e7XCSWuOQQ@mail.gmail.com> <CAOTNsDySo-t-qS5+_bm1Z+c_zRKcrS62vVtxURf9bBax0h8DAQ@mail.gmail.com>
In-Reply-To: <CAOTNsDySo-t-qS5+_bm1Z+c_zRKcrS62vVtxURf9bBax0h8DAQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 17 Feb 2026 16:54:14 -0500
X-Gm-Features: AaiRm50S8fq5hdAx_0Krvgf4fDrM05QuHjBQRizYYSYqRhOwUKHTId4NuWvBEsA
Message-ID: <CALnO6CAC3Vpdt34fZ0PLjmZOPazU3hDJiPnZy9reoyJJg-zU3A@mail.gmail.com>
Subject: Re: [PATCH v2] osxkeychain: define build targets in the top-level Makefile.
To: Koji Nakamaru <koji.nakamaru@gree.net>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 1:05=E2=80=AFPM Koji Nakamaru <koji.nakamaru@gree.n=
et> wrote:
>
> On Tue, Feb 17, 2026 at 10:12=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.=
com> wrote:
> >
> > On Tue, Feb 17, 2026 at 8:10=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail=
.com> wrote:
> > >
> > > On Mon, Feb 16, 2026 at 8:09=E2=80=AFPM Koji Nakamaru <koji.nakamaru@=
gree.net> wrote:
> > > >
> > > > On Tue, Feb 17, 2026 at 8:45=E2=80=AFAM D. Ben Knoble <ben.knoble@g=
mail.com> wrote:
> > > > > ...
> > > > >
> > > > > Homebrew picked this patch on top of 2.53.0, and on a recent buil=
d on
> > > > > older macOS I needed to
> > > > >
> > > > >     mkdir contrib/credential/osxkeychain/.depend
> > > > >
> > > > > in order to make their build work, since otherwise:
> > > > >
> > > > >     error: error opening
> > > > > 'contrib/credential/osxkeychain/.depend/git-credential-osxkeychai=
n.o.d':
> > > > > No such file or directory
> > > > >     1 error generated.
> > > > >     make[1]: ***
> > > > > [contrib/credential/osxkeychain/git-credential-osxkeychain.o] Err=
or 1
> > > >
> > > > I tried to reproduce this using the current Homebrew formula for gi=
t [1]
> > > > on macOS 15.7.4 and 14.8.4 (both relatively newer) with the followi=
ng
> > > > steps:
> > > >
> > > >   brew tap --force homebrew/core
> > > >   cd "$(brew --repository homebrew/core)"
> > > >   git checkout -B main origin/main
> > > >   git pull
> > > >   HOMEBREW_NO_INSTALL_FROM_API=3D1 brew reinstall --build-from-sour=
ce git
> > > >
> > > > In my environment, the build finished successfully. The patch doesn=
't
> > > > seem to trigger any issues during a local "make" either. How exactl=
y are
> > > > you performing your build?
> > > >
> > > > [1] https://github.com/Homebrew/homebrew-core/blob/9ec3da0dcd3ccd1c=
d4d892a71377b251770212d7/Formula/g/git.rb
> > >
> > > macOS 12.7.6 ;) hence tier 3 Homebrew support + all packages build
> > > from source. So just
> > >
> > >     brew upgrade git
> > >
> > > built 2.53.0 + patches from source. "brew --version" says I have
> > > "Homebrew 5.0.14-59-g45db1ce"; it doesn't print a homebrew-core line,
> > > so I'm not sure off-hand if that includes the core tap version or not
> > > anymore.
> >
> > To rule out differing versions, I also diff'd the Homebrew formula
> > from GitHub against "brew edit git", and the only difference is the
> > bottle stanza on GitHub.
> >
> > > I ended up having to use `brew upgrade --debug git`, fix the build
> > > error ("mkdir =E2=80=A6") and manually perform a few steps when it ar=
ose, etc.
>
> Thank you for the details. The current Makefile rule performs the
> following to generate dependency files
>
>   contrib/credential/osxkeychain/git-credential-osxkeychain.o:
> contrib/credential/osxkeychain/git-credential-osxkeychain.c GIT-CFLAGS
>           $(QUIET_CC)$(CC) -o $@ -c $(dep_args) $(compdb_args)
> $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
>
> where the compiler implicitly creates
> contrib/credential/osxkeychain/.depend/ if it doesn't exist. This
> behavior seems to be supported at least since Apple clang 15.0.0.

Aha! I have clang 13. That probably explains it.

> The
> following should work for older versions of clang that might not support
> this behavior.
>
>   contrib/credential/osxkeychain/git-credential-osxkeychain.o:
> contrib/credential/osxkeychain/git-credential-osxkeychain.c GIT-CFLAGS
>           @mkdir -p contrib/credential/osxkeychain/.depend
>           $(QUIET_CC)$(CC) -o $@ -c $(dep_args) $(compdb_args)
> $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
>
> Can you try this modification in your environment? You can confirm
> whether this works as below.
>
>   git clone https://github.com/git/git.git
>   cd git
>   git checkout v2.53.0
>   curl https://raw.githubusercontent.com/Homebrew/homebrew-core/46d746f92=
167fd0559af22f4ccb79c9ff35fbe33/Patches/git/2.53.0-osxkeychain-top-level-ma=
kefile.patch
> | patch

Using git-am worked (patch doesn't apply it)

>   # The next should fail in your environment.
>   make contrib/credential/osxkeychain/git-credential-osxkeychain

Fails as stated.

>   # Please edit Makefile as described and try again. This should
>   # succeed.
>   make contrib/credential/osxkeychain/git-credential-osxkeychain

With the (now obvious!) proposal, indeed succeeds.

Thanks!

--=20
D. Ben Knoble
