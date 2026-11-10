Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794335633;
	b=BanZahYTLVmlWi0JLG62yOTFJsMk7r4BT+XvuCjj/3gtEbUR9Niv2KPmK5CcbKXYXsg/
	 wgwiU0cEG7oE7gK+sBX8YPWK96kUyCK/sysTh7HbMZX5r0pqNPoQcfVL6/9xzuS8ecDEi
	 UlXtI2+aHjQtUPmHSXOhsxSNkbU6fwA/hkK7Rj98XXXkh3H9NnQIYN6D9+SJAZZv7Mdb+
	 Y4Xl0r90ziU3vk0OiB9BFd6HRmcfNB0tYKC2CJaduo3JBgZcpjkacdSsZYVh83jgGMPNQ
	 JWva7GT/N5bS+xGEFekHQYqAbaebJkFH42udVFuoUMMSIUovGKXQ501bQY0MWivFLWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+lz0yDqol1vUTM14pFA1/0q3g7ZLl+HZabvD6Giw/ac=;
	b=EivUUZgejFnxlwHzHvyDhgN4pOQUHMEj9rJyj+MZKQ1bazG3u+CceeyuEznqpDoeLmKP
	 9StToiibVKA83Uw5JHf+HcBG6glE3oguJ8fuw2RZPfHCTcGBXIbD3FrftGOPtcmbiQXiI
	 Ai9Pz/6SsWCoAmKt1jPh0U0IEoKaWrybH+lzr8oPNWxLHFaBbpXD4Vkof2Mdmw0ZSBXkd
	 ObpuRKtVVZ3pgT21vBaG2ghQSTNJysO00L+IWRefkNiUlg9d8Lz/Cef6y4RVswUr4oYwr
	 gOuDW97OKEMxnM33kAyhNR1gCvuJLIXsRv9n7jRRksvVr3RTwJ5uiB8C1be28Bf2Tog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="CvEtq/9t";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB80F606A321
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 18:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB80F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CvEtq/9t
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5366463571cso27594471cf.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 10:33:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794335632; cv=none;
        d=google.com; s=arc-20260327;
        b=nbTH6RT5sxBvJSQAe8Qtlp2zE/v0BcQNx016oRCLXY9py9Yw9pSXxY1M/7SCdzSEDY
         BEpdQC4oCcnuybWxgXoKBacnkwh0MB994jkQpkZVvFhDltZH6O8t0Kx35jkB1nUBxxYO
         Jh2sXL1EXknmu85pMggDdAHA2nijyVLbs76/k2d/yzg6RYQpInVDJvENLOrqu1hopj4L
         Jjt705dW5/YFRbOnPSsR9wnzNm8AOZjUN/suHz+jcejYc8dV7J3dtkYRElklE0Icf2Ei
         U8nArxnY8r1pKC8rRomTLCd3iv7amEr0FN0bjcwadXt13lHcGHJy6MyguGWVcXQXBfoK
         nfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+lz0yDqol1vUTM14pFA1/0q3g7ZLl+HZabvD6Giw/ac=;
        fh=Xlze59Nd/SwGe4/B3XFNmvM9qhqJlVOrxtNFkUMhqDY=;
        b=VpKJwRY0/ThC2VBsHzSQSYeRIhY9wq19FWcBKOudaPefQeyheApES0lZKPjKNK9bMD
         gv30C8uinIgdW2G64GsGQUc6LTpUpnYUTcU2FU+b9jmlCp5f+nMN4ZMa2SVxjmFgWSuc
         syBatlDOVRg1YIiGzpqT3is/9/ielZmoEFx/dVkCpVkhWRww+lBgrbTzy9acyyNHcgjx
         Sv56M51sEMbiyKlsa1mJApN7IZVLHIjNeRe49Hhod35GbiGqrkXLxcihGXeFng0WZGn+
         EmC00ubenVkuAxm4nKCSg65u5WMknXcldGsV1urtHu8Q8ir6QkuUvfH0BX/RwmOCCIT0
         4Nhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794335632; x=1794940432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+lz0yDqol1vUTM14pFA1/0q3g7ZLl+HZabvD6Giw/ac=;
        b=CvEtq/9tA8m/MsJ/tKmlmpw492rs0VWbOUIVQUsYHMdizLlYhLkljOO9c7g96luAET
         7oxCxnNjhf3bH9hgE7fAdR4w5TMudHLIYuEhz5sAqnzFQrsq+xKrmXCJYP0ftW9WsXk6
         ZHcvqPc/3RpNuZLFUd9X0XAPoUi6kygLEHCwWdFKXLwRwSUC6TIsYcs7cUIeb+aTu5BL
         lr75LPT8ILdcOwAwJCQIpih0+Jkb5mXvLKlCKZfAsu5b4wi3U41ts2l9IH4S/y8u/dTj
         PJ6Ewb17RzoxklpPg6EZTh/7s5NdtTW8nWs+Nt3/OYvdKMcPMFDpnoTmdNNivVqNdmuX
         AslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794335632; x=1794940432;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+lz0yDqol1vUTM14pFA1/0q3g7ZLl+HZabvD6Giw/ac=;
        b=jSiUAStf7dXHpd5N4kibmExbY5603mWlwIoGb7ivs1VdMDmVvmRvFp8zb5kIUIFEvT
         216lwwZEhNxDgdJx33R5MVQu3KLdY47FYejikSl/Bc1C2HPU0/lhCNAdVKYNYGg+YUld
         Qnz3Rzs1tP+k7nY690htKUZHJrw+4saaBYy0fRVr1xffGLWiRs8qOZSFc1TYIWIa4fP9
         QnP6eBhb2WPX7KlPudczap31l0PPAIk38PWwkRqYM8pe0GF3cx5WLPWr7X/E1p9CcLnK
         Ts9aCQCeXP6pmkIS2L+PVyRfRdtGWmsZkEm8S9dfXmgEJdDNqfLXHxJhybjlL4wetHB8
         KJDQ==
X-Forwarded-Encrypted: i=1; AL+hErG/Aii/2Vg5f/dTk/VNED6LEjkwVBhaW2K1cxcmSNZvAZC+kX0mVelux5YXLK9gweOYbgs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xjjmBJztoamM28dM+RmWL7or5+EuQ42MRBBE2eniJdWIXMgol
	mDdnoVIniCtj5CjD93Vhiz0VVVdyKI7p99g4UhsdclQ7/F4gYj/d1fTimNC5wkn1tW2NTPC4j9P
	8+YiN4Kum5NpYS/AagVtiCB7o++hOuGY=
X-Gm-Gg: AYBFou0KRsZPw0GjWBj7khAUasGSzDZS7EzCNqEyO6J0XodsdxV70xss1559BRkN+uo
	LzJuAYoFX5snGGtSHTO+2xZ1nzkg3Essg3+CAksEBtIpw9vyVyR8iehITa/Jruq77atAwJg1D2B
	VuqtBjAYYUBF1YiY5SMQZxXWUJK+JkbGxscAJYTUiQWGrm5vm7AXrz1acx2M+PLHY0T46il+buN
	FBxefksqzRAcothJmblhNUZs568SvBHtaMOaJFo8D+VpmTyavqnopmID1v54O2Ydt/Jyd8YjQx8
	POvRESp4ZPPM0FjTxZS4y3tqbecEZKXtHW6NxCpi6cv3dK0hFgPrx7CZkVyuTuhOD/LvXEzOReL
	YuBwyD6UlGnYRvkVx72qtfsKAKov2xESiSd6KuglFjFQ+GuoR2TC0n+FePSItrmcBcXDlztNmUe
	LQ4GycLt6w/an1MQr2jUQ/Zmto8f8wxVyp+jAcejseBIB+CsXkl/UxJBIP
X-Received: by 2002:a05:622a:2587:b0:533:4da1:b5d1 with SMTP id
 d75a77b69052e-555292bc4f5mr52865101cf.23.1794335631459; Tue, 10 Nov 2026
 10:33:51 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
 <pull.2305.v2.git.1794290598.gitgitgadget@gmail.com> <3d8d9a9261a1f4fcb883ab9afd236f254a494430.1794290598.git.gitgitgadget@gmail.com>
 <xmqq1p8svfdv.fsf@gitster.g>
In-Reply-To: <xmqq1p8svfdv.fsf@gitster.g>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Wed, 11 Nov 2026 00:03:41 +0530
X-Gm-Features: AclHuK8WtUX9jjLzj39O7fZH9LMvPXff8g-JtuNQOYMnFV2RwxznM6clGzkZ1oQ
Message-ID: <CABh_KWi8Ci2_EcWfX56ajRvYeh3JEztLpb46i0hAEhBGUwgmbQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] archive: remove USE_THE_REPOSITORY_VARIABLE from
 archival modules
To: Junio C Hamano <gitster@pobox.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 9:37=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Srujith A Poojary <poojarysrujith@gmail.com>
> >
> > Refactor archival modules (archive-tar.c, archive-zip.c, archive.c,
> > builtin/archive.c, builtin/upload-archive.c, and diagnose.c) to accept
> > and pass explicit struct repository * pointers instead of relying on
> > global repository state.
> >
> > Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
> > ---
> >  archive-tar.c     | 5 ++---
> >  builtin/archive.c | 1 +
> >  2 files changed, 3 insertions(+), 3 deletions(-)
>
> Is the description above really for the change in this message?  It
> does not seem to match at all to me.
>
> >
> > diff --git a/archive-tar.c b/archive-tar.c
> > index a1c66024d4..642a3ddfc3 100644
> > --- a/archive-tar.c
> > +++ b/archive-tar.c
> > @@ -3,7 +3,6 @@
> >   */
> >
> >  #define USE_THE_REPOSITORY_VARIABLE
> > -
> >  #include "git-compat-util.h"
> >  #include "config.h"
> >  #include "gettext.h"
> > @@ -337,7 +336,7 @@ static void write_global_extended_header(struct arc=
hiver_args *args)
> >       if (oid)
> >               strbuf_append_ext_header(&ext_header, "comment",
> >                                        oid_to_hex(oid),
> > -                                      the_hash_algo->hexsz);
> > +                                      args->repo->hash_algo->hexsz);
> >       if (args->time > USTAR_MAX_MTIME) {
> >               strbuf_append_ext_header_uint(&ext_header, "mtime",
> >                                             args->time);
> > @@ -529,13 +528,13 @@ static struct archiver tar_archiver =3D {
> >  void init_tar_archiver(void)
> >  {
> >       int i;
> > +     repo_config(the_repository, git_tar_config, NULL);
> >       register_archiver(&tar_archiver);
> >
> >       tar_filter_config("tar.tgz.command", internal_gzip_command, NULL)=
;
> >       tar_filter_config("tar.tgz.remote", "true", NULL);
> >       tar_filter_config("tar.tar.gz.command", internal_gzip_command, NU=
LL);
> >       tar_filter_config("tar.tar.gz.remote", "true", NULL);
> > -     repo_config(the_repository, git_tar_config, NULL);
> >       for (i =3D 0; i < nr_tar_filters; i++) {
> >               /* omit any filters that never had a command configured *=
/
> >               if (tar_filters[i]->filter_command)
> > diff --git a/builtin/archive.c b/builtin/archive.c
> > index 3c1288a123..8b7d56f8cb 100644
> > --- a/builtin/archive.c
> > +++ b/builtin/archive.c
> > @@ -2,6 +2,7 @@
> >   * Copyright (c) 2006 Franck Bui-Huu
> >   * Copyright (c) 2006 Rene Scharfe
> >   */
> > +#define USE_THE_REPOSITORY_VARIABLE
> >  #include "builtin.h"
> >  #include "archive.h"
> >  #include "gettext.h"

Hi Junio,

Good catch=E2=80=94thanks! You're completely right. In adjusting the patch =
to
keep `init_tar_archiver()` and `init_zip_archiver()` using
`the_repository` based on your earlier feedback, I left the commit
message referring to the earlier full refactor approach instead of
describing the actual scoped change.
I've updated the commit message to accurately reflect the changes in
this version and pushed the updated branch.

Thanks,

Srujith
