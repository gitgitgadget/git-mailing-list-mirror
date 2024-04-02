Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00A459151
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053578; cv=none; b=oytOt5qw9XpMKeLaALy//OET5HgiYUP0svhYe/EJ2GLFN2+TUa48Uw+k+7HJzTaEiV2Fe+T9iKL+e5kAevzkW0oAhsC5iv/2fhOz4t2pImSlOJT6vNHze7ddYLg8enElh9rkS5BByMEhROH76J6ZsGSR4k8zCbJRrpbyiuB2S/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053578; c=relaxed/simple;
	bh=dNRq4gMtMFempbGVc1AdYzsdjdmS3DmePZIy3Pj1uys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXdvhWrnvZWzX+skOTBPkB74JniTM1wac9JI19Jj5lJ/rUantU1ABfPo92otzOu8D/acliDlkN2vU0XM5A3l5A8lpPm5U41xF+73n8vxn6+hxToAvHGlpg4/uNs7ARy1Q3etKPR/x7xjBb3oVs+hgGJKmhlM3uaiGdw15Blbw30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fuseenergy.com; spf=pass smtp.mailfrom=fuseenergy.com; dkim=pass (2048-bit key) header.d=fuseenergy-com.20230601.gappssmtp.com header.i=@fuseenergy-com.20230601.gappssmtp.com header.b=U/korkgV; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fuseenergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fuseenergy.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fuseenergy-com.20230601.gappssmtp.com header.i=@fuseenergy-com.20230601.gappssmtp.com header.b="U/korkgV"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4e40fad4fdso371477366b.2
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 03:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fuseenergy-com.20230601.gappssmtp.com; s=20230601; t=1712053574; x=1712658374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wB4I8Ap0aSptwPGCgVM9TNqfjpHBzijGgLRbLWroPb8=;
        b=U/korkgVVmgZAQXmLHYLJqw3NZYnQgpiE+wCqA+7KXcxqp0W3ikJ4G5gX5R43mLpfG
         eVOnRMC2IMss1Vf5RWf5pwLEOkmQAZxTFz6WPF8cKHaEtzjpAcJKx/TMMT96Nbc7nNig
         yTDkcZ1UD1VEKOH5EasST1qLt1V9YBseNleLDpmMeIy1Qq9ZwV7s/BB1H+l8A3sgrJqr
         TF+t7/Omc/J8bVSyxeTc38hxezLh8q7cVjab/MY/J+X01MrFcrEXrRjT7nIbjrS09usb
         kWTmOMRe2USeumBVXiOoVUh6l6azB4CnfqY4Mpda3RA+AiOZOTceVjW7Ndi79PEF2SZT
         +D3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712053574; x=1712658374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wB4I8Ap0aSptwPGCgVM9TNqfjpHBzijGgLRbLWroPb8=;
        b=ulwP3MqCYatN3TnAkYbzf7rPXnnc0ebM9cGbBbqAqr7GScpeK8gDJDEezNH32ogqoz
         9F6rWlBWrDp8RgGbpbe9FG9N9K/wMJPR6uJa639Kz/vna2bx1fczez53/u1A59rAkRtw
         NQ2wqtBzKqGjv3QAmoiPDsd0/kP4Or7k5b0DtLtqevRddEcfWcXUVTQtSVfg1t+hJl1/
         36dQoom43o4rPKExgQR6qr/uwcMijXDvqKs3BA278cTakBBCJyCA4zgqiMEGC4rexega
         acCYUB0IPAh9fMny4uEJcnCW8dVBm26BUgCKsXWqPzydloL3/qf7Sre14M5WfEJfsStj
         +diw==
X-Forwarded-Encrypted: i=1; AJvYcCVqgNECeeu4Xqbmcne3C5RjaQrTgi7UNo/T6S2z2cQ4kfverurzuvRv00rHnSp/XPneFrnxSB1FE2k10TgJKhTeLvHU
X-Gm-Message-State: AOJu0Yy194i6MCVqNhGiaYaL3tzEQg9z23mYXYIhFSNKCIjDz8NkvZiN
	Z/SidkjyaLd28pnUhv4/gKnSrFXxj9bHRz/8XFU57S8sbY3JYRTelbGOk7wrj3651JZLFrnTa4T
	TqEfVbiequHeen+VcjWAeT8Rbj8sS/XcuxwxqwQ==
X-Google-Smtp-Source: AGHT+IEhw1uxE4070KTrM37t0X9Xuq/RAH2ZVdtX8oSUrnTxcqvTnUdncd2p3du6khSRqAAJP36Qu9r0tswcgaAbT9c=
X-Received: by 2002:a17:907:78c:b0:a4e:68bc:a46e with SMTP id
 xd12-20020a170907078c00b00a4e68bca46emr4482270ejb.43.1712053573914; Tue, 02
 Apr 2024 03:26:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEYvaskGHYrQgke=gf1sXYhrwbd+SeTpcjGF0fpxK3hQbyPFKg@mail.gmail.com>
 <CAPig+cQWW1sLXyTBvk6D+1h15sZCtQO1opfhtFfiHr_kX0y82g@mail.gmail.com>
 <CAEYvaskXRyxNTLNeRPPyawFrBVRgCbSnJiuF7D7cOGiaDq=V2Q@mail.gmail.com>
 <CAPig+cQdFi5zBkDQWTEWXCTt5h9gVFNJv7obf=tWCkOvsaEHEA@mail.gmail.com> <4041487e-d8d8-481c-b490-884e31f533a8@gmail.com>
In-Reply-To: <4041487e-d8d8-481c-b490-884e31f533a8@gmail.com>
From: Tamir Duberstein <tamird@fuseenergy.com>
Date: Tue, 2 Apr 2024 11:26:02 +0100
Message-ID: <CAEYvasmb1TjwWpSbfSAogbOiB64sZQiHVoUhxvY+NoLmXnRuHA@mail.gmail.com>
Subject: Re: bug report: spurious "cannot delete branch '%s' used by worktree"
To: phillip.wood@dunelm.org.uk
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip

On Tue, Apr 2, 2024 at 11:10=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Tamir
>
> On 31/03/2024 07:49, Eric Sunshine wrote:
> > [please reply inline rather than top-posting; I've moved your reply
> > inline for this response]
> >
> > On Thu, Mar 28, 2024 at 1:40=E2=80=AFPM Tamir Duberstein <tamird@fuseen=
ergy.com> wrote:
> >> On Thu, Mar 28, 2024 at 5:24=E2=80=AFPM Eric Sunshine <sunshine@sunshi=
neco.com> wrote:
> >>> On Thu, Mar 28, 2024 at 10:54=E2=80=AFAM Tamir Duberstein <tamird@fus=
eenergy.com> wrote:
> >>>> % git branch -d cleanup
> >>>> error: cannot delete branch 'cleanup' used by worktree at '<my sourc=
e dir>'
> >>>> % git worktree list
> >>>> <my source dir>  dc46f6d5e [main]
> >>>> % git branch
> >>>>    cleanup
> >>>> * main
> >>>
> >>> Is this error persistent once it arises? That is, if you invoke `git
> >>> branch -d cleanup` again immediately after (or a little while after)
> >>> the above sequence, does the problem persist? Or does it "clear up" o=
n
> >>> its own at some point?
> >>
> >> Yes, the problem is persistent. The branch is never deleted.
> >
> > I'd guess that there may be some sort of "ref" still pointing at the
> > "cleanup" branch which presumably was, at some point, checked out at
> > "<my source dir>". Digging through the code[1,2,3] suggests that you
> > might have some stale state from a rebase, bisect, or other sequencer
> > operation which still references the "cleanup" branch.
> >
> > [Cc'ing Phillip who is probably much more familiar with this code than =
am I.]
>
> Thanks Eric. I'd have thought that "git worktree list" would say
> something about the branch being rebased if there was enough state lying
> around to prevent the branch being deleted, but lets see. What does
>
>      ls $(git rev-parse --git-path rebase-merge) $(git rev-parse
> --git-path rebase-apply)
>
> show when you run it in <my source dir>? Also is <my source dir> the
> only worktree?

% ls $(git rev-parse --git-path rebase-merge) $(git rev-parse
--git-path rebase-apply)
ls: .git/rebase-apply: No such file or directory
ls: .git/rebase-merge: No such file or directory

Yes, it's the only worktree.

> Best Wishes
>
> Phillip
>
> > By the way, it's not clear from your initial report what you mean when
> > you say "then the remote deleted the branch". Also, did you fetch
> > and/or pull from the remote after that?
> >
> > [1]: https://github.com/git/git/blob/d6fd04375f91/branch.c#L454
> > [2]: https://github.com/git/git/blob/d6fd04375f91/branch.c#L386
> > [3]: https://github.com/git/git/blob/d6fd04375f91/sequencer.c#L6551
