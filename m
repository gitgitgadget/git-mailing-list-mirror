Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6DD21FF4D
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771351552; cv=pass; b=LjPWHhbcsbsjXjaB2jUN0ZSNrWyyfcqZ02NMLvKPje8Hgs/7X1uvUpJThV3T1omxC9yEjQ33ynAsTRBBHGyclvmGYZ+4NqF1Nwaeq6H9nm2a5YYWPA+5jJ//peWxdDCiCb2Kdn6RCvnhUWS1f5AQXgwuXA9w9GOvi183HBYhv0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771351552; c=relaxed/simple;
	bh=Ev2kWu9++HqV8In5A8l7Sk6kqwfMSjFl1go6NL5Tlvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EiDPJBNTxj5fC4Dpk/15HsQt2rZ93SF1MepBEt6ewk9e3M3J8izftEQaMw07EELSrq285WzRMIlClpo/pBVyi+2n1A4mvxAnRSkeBLNHzsumLgai7TVglq7kGUh+hf5l/Y/FsJmmreAXRxtu4gAQQPWUp/XRi1J5+Pkxr+CWlis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b=rSYkNxb4; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b="rSYkNxb4"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bab70f8c8aso4705518eec.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 10:05:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771351550; cv=none;
        d=google.com; s=arc-20240605;
        b=Mg2MHofF2k38mjKcJgi1oz0NjHj9NUPefIcIlRq0/k2Bb9EX39XTCSzza+8iTi8W86
         l22AzCEJn5FKqxR4OdPdPLvgmWJkkwIOSKf+qflPiyJNaEnx1b3dLkw4pEO67hte0JsV
         qtQuuz4A9damjd0xiHZuhdtoLRdofnM0Lafu8eCl8z5GXdW/sOpVz4EeoFB8/NPssKiT
         0zAkRdastOZIfPAZP3K/ij5LAQ46cSnpQfvclHYVYlz5u4B8+T5Z7EEiiA9GdDP77d1/
         8cmSbR7/UlaSOy/GF87nkZXbezQ53g6gHl2Iyl46TtHYBkh192A1Ov1k2EteEDU5lcc1
         HKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ol2Jc7bDSqfb4gVu8VG5O5cqWc92mcJ1T3qq5OBkehQ=;
        fh=SFyqynFdcvvjQTVaSzkULTFS3zYkkwmGK0VZD1XuzI8=;
        b=CnO1hyfoo27FF6I38rBEA1J5IIdVWGOoyXmgGIsGv3jm+shhiydGvRHGL7AfO56Ykz
         3J/GdKT4N/CT8uH8HSv13mrDugM/6olRkwyDZ9absSTk/aT7OpCvAqZHBlP2b7wzBjrL
         OSW6GmyRNh3B7z4tzctTjbV79pMHVPrJXTAZhnVfsFVa+rBXloPon3oSxLzXSlJmxvvO
         UhA8d7meSQGCkNoqEZHVw4WFZG7mXwbUNyFQMr5cg6JkhyeVi+aCR2WC3HpJ3JsbD+2v
         mG/y7x/tHSbmInL+U3n6OFE3XrLx1o1oxltjVOFtZn0XN65xIx5x1DJ5uCMrMcwgc7hs
         yMzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree.net; s=google; t=1771351550; x=1771956350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ol2Jc7bDSqfb4gVu8VG5O5cqWc92mcJ1T3qq5OBkehQ=;
        b=rSYkNxb42f5hzgkxOvWy9IMGNHda/txnFmYv0tyk/iUL1Yh7S08P1I9F49pC4Boe1F
         JKjyjn7Q47iY3wtEu69yOAubFHfNxIlfLlXslX4SxQLfx/kAujJ7xDsy0FtO2H53UyLy
         HMt1Mqg+okoDb2IhsikNPormwM2j1Ivv9qlEokjC8mLTpntY4CZJmJm+ox6Y23eIftAD
         z8O1gesf/+jKfrw9k69/9U9+Zk+Rx0v3uTkZCKz8LaUQ6cjl+06k5EsadeCNHPdIXcNb
         rcsWPq1mJkMmQBd/Ca14h25PXghpZfgEIeTBEronMFXdlVCBbYGid+vG53Y70K4D2IEQ
         buiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771351550; x=1771956350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ol2Jc7bDSqfb4gVu8VG5O5cqWc92mcJ1T3qq5OBkehQ=;
        b=N9ez35m4ANycjCu6+FWmQTd6d4oOw1l/tU9WQGAiBsdfQEvxNirDPkewDp9qXkGko7
         3E42rx08vXYJBOoguwYel+qZbH+JtZ+AUUr2tE4aDLrHTxH/CylriIm5R0xLMNn0ae/k
         Ks9bDRBa4vK42xoDgREqD1FqSiilJ6s5+4OEsY0SAaZ5RIZebmuN9pmnUekq183Joawg
         /LP3GwEkO292O6RPVt9gnuJWq1u/ybNgdrYvESBrxh7NwITD3QX7O9m4GnznuYX7/dkl
         uA39EQ7e8YOe0r7r7TO81Z1T3v8iYvlRd5s2evYA2oPiELdeL2XNtLYhl4oX60NS3E2M
         05kg==
X-Forwarded-Encrypted: i=1; AJvYcCVHpAALQk2r/VmlZapl6dE9J4YECAEgbUcD+FQ+Q0etXMNmBIMSUqVPPECBEtcPuVr66Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNXnTHW6Vb7zzJo3nKQcjn/pui8L8Q8sUgBKNxFr0sJROWS1is
	nqfOOlzmuPhDemRG7aBVtRzUS/wV4KUuBCwWPMxVECWttKveVj5r/xMHkJE+i3wbpV1T/IFKm3k
	bYAv8LP8RM9E8lUPXLHfqt/f7ZVfNeY5qI2NResfF5+eTt8nb0U3v5V1JrBFacsHtKn3tYkbzUZ
	xINYeA+g+Vil5R3LsxXuFphW4b75DZgq6RUxv3+DeGGfomfDze+35rExeVgfxv9m64f7HSnuH+F
	fCEtCCuQ2Gqg63l7VL0JZQ27xoBMH9731AbdQUO+sNEvG/z6VnznHMH5KrGL+SDRdgpO5jL5Mgn
	gUtw8KhWqFA1xGc=
X-Gm-Gg: AZuq6aKQGD6FaA7ZoJjrIQRqES8nrPbrFkU8Lx2MukzZR4d2U8uak+zpCAB/17rQZ8/
	u48RkBlCXCJCfwJO+ysYp9l7MQSlg43oSpJI82KDcSh02psOy6KIOSNeE6Hx8n7iSw905XPabfY
	TA+56bFLkgp0uwhMq0wk+i/MeoXw4RcePuglIk21goB0xHbdQ4dorcDgiuDk0ZZTURAq1OIJ0w8
	KxbFlz1vva+IaWLPhEIzG+0/AurKbQDcqqgszeydic9PVp8waxYiZJl3IfDApIc9AgkD9tjduBG
	koVO9F8o
X-Received: by 2002:a05:7301:129b:b0:2ba:933d:d5c7 with SMTP id
 5a478bee46e88-2babc57ff91mr5760961eec.32.1771351549212; Tue, 17 Feb 2026
 10:05:49 -0800 (PST)
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
 <CALnO6CCYorpEzmZwLrb7O-ucKLTOCLp6zXxZr0Qv73tOBqKKig@mail.gmail.com> <CALnO6CCys8hDtSe4=gFjaz7x410TH-7LFGRs0UU5e7XCSWuOQQ@mail.gmail.com>
In-Reply-To: <CALnO6CCys8hDtSe4=gFjaz7x410TH-7LFGRs0UU5e7XCSWuOQQ@mail.gmail.com>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Wed, 18 Feb 2026 03:05:38 +0900
X-Gm-Features: AaiRm50o3b6d44T8lHxAWBRqay1QuAdML-VTveuJZWo87i9jU7a5nOSCkKymOXE
Message-ID: <CAOTNsDySo-t-qS5+_bm1Z+c_zRKcrS62vVtxURf9bBax0h8DAQ@mail.gmail.com>
Subject: Re: [PATCH v2] osxkeychain: define build targets in the top-level Makefile.
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 10:12=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.co=
m> wrote:
>
> On Tue, Feb 17, 2026 at 8:10=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.c=
om> wrote:
> >
> > On Mon, Feb 16, 2026 at 8:09=E2=80=AFPM Koji Nakamaru <koji.nakamaru@gr=
ee.net> wrote:
> > >
> > > On Tue, Feb 17, 2026 at 8:45=E2=80=AFAM D. Ben Knoble <ben.knoble@gma=
il.com> wrote:
> > > > ...
> > > >
> > > > Homebrew picked this patch on top of 2.53.0, and on a recent build =
on
> > > > older macOS I needed to
> > > >
> > > >     mkdir contrib/credential/osxkeychain/.depend
> > > >
> > > > in order to make their build work, since otherwise:
> > > >
> > > >     error: error opening
> > > > 'contrib/credential/osxkeychain/.depend/git-credential-osxkeychain.=
o.d':
> > > > No such file or directory
> > > >     1 error generated.
> > > >     make[1]: ***
> > > > [contrib/credential/osxkeychain/git-credential-osxkeychain.o] Error=
 1
> > >
> > > I tried to reproduce this using the current Homebrew formula for git =
[1]
> > > on macOS 15.7.4 and 14.8.4 (both relatively newer) with the following
> > > steps:
> > >
> > >   brew tap --force homebrew/core
> > >   cd "$(brew --repository homebrew/core)"
> > >   git checkout -B main origin/main
> > >   git pull
> > >   HOMEBREW_NO_INSTALL_FROM_API=3D1 brew reinstall --build-from-source=
 git
> > >
> > > In my environment, the build finished successfully. The patch doesn't
> > > seem to trigger any issues during a local "make" either. How exactly =
are
> > > you performing your build?
> > >
> > > [1] https://github.com/Homebrew/homebrew-core/blob/9ec3da0dcd3ccd1cd4=
d892a71377b251770212d7/Formula/g/git.rb
> >
> > macOS 12.7.6 ;) hence tier 3 Homebrew support + all packages build
> > from source. So just
> >
> >     brew upgrade git
> >
> > built 2.53.0 + patches from source. "brew --version" says I have
> > "Homebrew 5.0.14-59-g45db1ce"; it doesn't print a homebrew-core line,
> > so I'm not sure off-hand if that includes the core tap version or not
> > anymore.
>
> To rule out differing versions, I also diff'd the Homebrew formula
> from GitHub against "brew edit git", and the only difference is the
> bottle stanza on GitHub.
>
> > I ended up having to use `brew upgrade --debug git`, fix the build
> > error ("mkdir =E2=80=A6") and manually perform a few steps when it aros=
e, etc.

Thank you for the details. The current Makefile rule performs the
following to generate dependency files

  contrib/credential/osxkeychain/git-credential-osxkeychain.o:
contrib/credential/osxkeychain/git-credential-osxkeychain.c GIT-CFLAGS
          $(QUIET_CC)$(CC) -o $@ -c $(dep_args) $(compdb_args)
$(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<

where the compiler implicitly creates
contrib/credential/osxkeychain/.depend/ if it doesn't exist. This
behavior seems to be supported at least since Apple clang 15.0.0. The
following should work for older versions of clang that might not support
this behavior.

  contrib/credential/osxkeychain/git-credential-osxkeychain.o:
contrib/credential/osxkeychain/git-credential-osxkeychain.c GIT-CFLAGS
          @mkdir -p contrib/credential/osxkeychain/.depend
          $(QUIET_CC)$(CC) -o $@ -c $(dep_args) $(compdb_args)
$(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<

Can you try this modification in your environment? You can confirm
whether this works as below.

  git clone https://github.com/git/git.git
  cd git
  git checkout v2.53.0
  curl https://raw.githubusercontent.com/Homebrew/homebrew-core/46d746f9216=
7fd0559af22f4ccb79c9ff35fbe33/Patches/git/2.53.0-osxkeychain-top-level-make=
file.patch
| patch

  # The next should fail in your environment.
  make contrib/credential/osxkeychain/git-credential-osxkeychain

  # Please edit Makefile as described and try again. This should
  # succeed.
  make contrib/credential/osxkeychain/git-credential-osxkeychain

--
Koji Nakamaru
