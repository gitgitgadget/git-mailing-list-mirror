Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793717735;
	b=aNW3r7HeAcdQXh3gWSG4mf/yifoW6rMMJmE2kcd+XOdD+PG9mq+7L8aGXEBj4Qjq95Ha
	 JvEDyvSTX8lEJrVu7BllpKM0cV04yHk6dvPucF0NNHWW+Q+ZAov8sXEfhXKKV7QN9pJ8I
	 8Gg8UpfQ25mkw+hZw7ObuIRSMcOaDGFcDbaGeyH0i47xZ0QsNYIaJltJOO0fhu4nvT9d5
	 6KNO9bBinRbV2Ua0oXiKge6SFWwMYovoGgmhszp9+HDYNZWpGOzzqSTDk+5P9QJhq0OwN
	 U1+xQVOFrJ8nFdtUvTshr/E+rH0Dvg412UBhloTSJU3ixclzvhreSZoUQzR8Tqj1B6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=cxoCh3dYSr613wafseK373M/7cuzF55kUjSHjpqEaFM=;
	b=G0CPKHAV+68gCF/M8E3hPIcQ5MviFdzoCwTAhSWl+7LKln2u2r9aYm9MU5tPAQG8dWfh
	 na85tV3o990/MMNJV+Sv7mGv5n8/5lZWU8coXL5xTR7FqOk4xlayg7pWCs2uJB/N7UiPQ
	 R6HPuNxOVacI/1A3H7Sz9h22ECVm7ElsksrnDDaQwuepEjOi9n+Om/vpOlAyloSQFzW7z
	 cxtg2gHP93noCcBnSLVLBPB/PwrwtAG3PyIC07YdMsyX3+HOJVZfZ94xBXY2vlnhlGOtr
	 GTYxeZpL5nvu8Bs7ljc5BkMHr/d+E2ZnFCiUZNvjZl+AJf72U6fX5mxt+X1oE9yzXjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hkQVIIQp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEB0606D807
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 14:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DEB0606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hkQVIIQp
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b0f59a5fdaso39043397b3.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 06:55:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793717734; cv=none;
        d=google.com; s=arc-20260327;
        b=BXg8MiiRlzK5aStxaiRQoZCOo3S3WzqUVqA+tk2558eVOpsDRqXd07l229RceoFKb7
         U0iKAaOa+AeN/YyFG6gxEM80Eyj3ELZorWOwr/E6ivrtFKT0C7uyVJ24ugs9n+CsDRUd
         8X3RiBsp2zpOlSRSdN53pGjM/e9e5B/j5XRwjOClSrxF2fldH+VuTRrIqMni5kgFzgdZ
         BcmZfrB9lCAc92L6/W2sasnSFRqQX+3Q+9ZOei9wN/IY0IhDFe1myC/Oo6IBDTBfwSIp
         A7YYVk07bTMqcfm+W3gxhBG3dPBGPqe7fsDsiVE5jZUqM3rc5H02HsY0Zl4spzR7auhj
         DMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cxoCh3dYSr613wafseK373M/7cuzF55kUjSHjpqEaFM=;
        fh=PAjj1C9K1hPPM4TqmxTyFadGtAoFxDNtbjsyY4NMbPQ=;
        b=LsSmvCqFVvlwKyUDKN7+dWrbAxYwZsESEMgbBo/Wvc02Bo33Ko1HfA79aTbpxBj2qO
         bve8j6jLC0FhbW6jvoVr8/C8XOchB9A205XQQo0IBDz/w7Kbd+N2le50SuUYcejdjvZb
         BhimbZBEYS5oczzbSxgwZT8Qyhl/wa2SlQn8b2nQwP9WgPfrQcNR/cCmeatf2nQ6wHf6
         FQBG2jqwz2nfbMdzTcBEIFWezaPggFgUhfnkl4uNe5JuoQg9VmfWbXAhmV1RyQkw/GjA
         39JRX4b5J/TW9a1VsN2Qke0sM6DCLrASYBKzmpImvfidHpktuHtUXXJYgn5cqzb+hNiS
         q6FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793717734; x=1794322534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cxoCh3dYSr613wafseK373M/7cuzF55kUjSHjpqEaFM=;
        b=hkQVIIQpQ15SnhWTudDP7Z+Pgb6sgGmx5cC9s8G0GOl50tqbjOe6TYycFDJ+OoY47t
         odn1VxI8QTdFtYp2KC3sKebZDzWikT5mdSncBhQ84ePreK004Xr6EfTM+lWalDLmKs2X
         Uzvh8GGoIQ+YiUMHP9YI6MUSzDLCS1H8BnIMvvslFvbfszRUjcwUl/ZXpaUl6xoD+Zqt
         Eu35BCwlo7Xpitqqxyr7TbC0CUKfUaKIqh10I5yU8kOkDNTtPrAFmN4R4lSGcwGmablw
         ZfIMAIzN0dK9nP9xjQxXKm8/yPz9fj10GM0UE+OwdjKL0DS1T5XwJSlkxsaio/O09mNH
         QvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793717734; x=1794322534;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cxoCh3dYSr613wafseK373M/7cuzF55kUjSHjpqEaFM=;
        b=yLZDZRXTRBlRzI60b7jQZU9zmcDoKCkDvkcMN2+r4Q/+xf0M0oul5dmcSWLI2/4obs
         tKkmiA8y28unY3mV+w7nyIi7FuqCtXOjLyxdfFDHIWSkZqE4yfTbvf3c8eLsopdpyWXJ
         g2IcgnyzS4KsK9h/QdwP2wGbdFV1UTbVuNvgqKuRnMcBL8WuVFsufbT6jz3sg+I6D93i
         fHwiNavYV02h0umlCR/rhvQsIChjhVQV7kSQXeQrRk0byban7rzfyiXVK3KBOeCDl8TU
         2+DjHaoUjdnCCKse1pUnZfuRAwkrXZeiOqqpDzSu9aAATT0Khy9C5reeJCVx34mMwtG1
         fVHg==
X-Gm-Message-State: APuU4Z/yfXuBCPO+WAdtGZnABeHAEvxCSEgRvjV6FscW2mqixpfbNTTY
	pIaHfRtQzvgfylWtBAz2qWZKoJujVr//U3UerZui6jON4eyMBTeigZ03ROrB+8MI5C5Q32bKt2s
	TUvDlHmMd/TgUg0GV1CspheZk+GGlrniP0jR9r+Ju8TS6
X-Gm-Gg: AYBFou0+cbEdIrpVs2LJQATwjLN3WlKxhtxd2lcEcHs+QQVzjhflc4vyCjeecJIt9NY
	wLCfrmHUjWUEIUEqfR6gOSGCepejHq7XFlTsiRO3279HSwNBFvLkfhWnrc8lxHka7/ggc3EoLBn
	4rqwmQMJ/cWxOuLDAyJCSJMdceusGFBkplelx/JYaML8mzoO1Mjv3GLJ74Um8vUUB41EQyFzzRE
	3yh6QB4zSbOWZiucgGbgP8xayrQvr/m30ELwuQ3KDT9+WPxxAirIMEoltlIZ9yxkPUPABqONOVW
	wcZXzvbXbHZH5P57e0Pd3Dx7sLAAgpdL+ImLVoRuDOztzAxreD8cs2ltEbczJwoeIy/yWJeGg28
	aaV2ERJIn6BA3Sek6hDaatV9nnmiTnh9fI2VHl2NUgLXSYUe51Srw0QgRHLfGUvlOLoVzZtxdHH
	i1d/OTd6d5bqwNHPa4Z2D3/y4DWymUBH7zNzyy00exvAik/+jcmZaIw5SNr/XIOks5JD3L64tqP
	1p3F99GUZscaSULsl/Unjx02keyp7pCaFT8Wg==
X-Received: by 2002:a05:690c:d91:b0:8b0:cee8:53cf with SMTP id
 00721157ae682-8b2b6597d49mr96154627b3.3.1793717734135; Tue, 03 Nov 2026
 06:55:34 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029141818.40193-1-okhuomonajayi54@gmail.com> <CAP8UFD1VUCTeXNbb4YKGkZRWY8i56Zms_=qkR2oqF7e1Aagy1Q@mail.gmail.com>
In-Reply-To: <CAP8UFD1VUCTeXNbb4YKGkZRWY8i56Zms_=qkR2oqF7e1Aagy1Q@mail.gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Tue, 3 Nov 2026 15:55:22 +0100
X-Gm-Features: AclHuK9VazGFofGx-_3cwnIDPxbqFp2OR-cV4w0Wev8m3G6ekuy-KbXyk1RaXsQ
Message-ID: <CAFpMFfCX_VcBhyivh2f7vppYC4xLoYvUywAviW_73_nmOEkaeQ@mail.gmail.com>
Subject: Re: [Outreachy][Proposal]: Reduce Git's global state to enable Git's libification
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, usmanakinyemi202@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Tue, Nov 3, 2026 at 2:46 PM Christian Couder
<christian.couder@gmail.com> wrote:
> It's a good idea to focus on library code. You might also be
> interested in what Junio says about code in "builtin/" in:
>
> https://lore.kernel.org/git/xmqqmru76ybk.fsf_-_@gitster.g/
[...]
> In the discussion I mentioned above, Junio says that the code in
> "builtin/" isn't reusable library code at all, and that it would be
> useful work to move that code into library helpers.

Thanks, I'll read that discussion and add moving code from builtin/
into library helpers to the plan in v2 of my proposal.

> I wonder if blog posts on Medium are accessible to everyone.

Good point, Medium can ask readers to sign in. I'll move my blog to
Hashnode / GitHub Pages so that anyone can read it without an
account.

Thanks for the review.

Okhuomon

On Tue, Nov 3, 2026 at 2:46=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> On Thu, Oct 29, 2026 at 3:18=E2=80=AFPM Okhuomon Ajayi
> <okhuomonajayi54@gmail.com> wrote:
> >
> > Hello,
> >
> > This is my proposal for the project "Reduce Git's global state to
> > enable Git's libification" for the December 2026 Outreachy internship.
>
> Thanks for your interest in Git.
>
> > Past Experience with Git
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >
> > I have been using Git since I started coding, for my own projects
> > and when collaborating with other developers.
> >
> > This is not my first time on the Git mailing list. I applied to
> > Outreachy in October 2025 and sent about ten patches in about a week
> > (patch-ids, commit.c comments, builtin/patch-id.c, gpg-interface)
> > [10]. None of them were merged. I was sending too fast, my subject
> > lines had doubled prefixes like "[PATCH] [PATCH v2]", and my commit
> > messages did not follow the project style, as Junio and Christian
> > pointed out [11].
> >
> > This year I slowed down. I read SubmittingPatches properly, wrote
> > my commit messages in the present tense, and sent one change at a
> > time. The hardest part was still sending new versions: keeping each
> > version in sync with the review, the right thread and the notes on
> > what changed since the last version. This time my microproject was
> > merged to master, and six more topics are in 'seen', some of
> > them marked "Will merge to 'next'?" in What's cooking.
>
> Nice.
>
> > Reviews and help to other applicants
> > ------------------------------------
> > + list-objects-filter-options: pass repository to partial clone
> >   helpers (Dorine Tipo)
> >   My reply: https://lore.kernel.org/git/CAFpMFfCu6JrUC8i453qBP=3DAktqcG=
_9sGX=3D1-1ekEDCYm_+pkUw@mail.gmail.com/
> >   Description: Dorine asked whether USE_THE_REPOSITORY_VARIABLE
> >   could be dropped. I applied the patch, removed the define and
> >   checked that the file still builds, so it can go in the same
> >   patch.
> >
> > + Microproject idea: modernize a file-existence check in
> >   t/t0081-find-pack.sh (Immaculate Mecha)
> >   My reply: https://lore.kernel.org/git/CAFpMFfA17dnuLSRt97BrM0u3cHAifJ=
ybr_Zc2ahr_zq2nspgsw@mail.gmail.com/
> >   Description: Pointed out that Shashank S had already changed that
> >   exact line, and suggested searching lore and "What's cooking"
> >   before choosing a microproject.
>
> Thanks for helping with reviews.
>
> [...]
>
> > This project reduces that global state step by step:
> > - removing the_repository from library code by passing the
> >   repository explicitly through the call chain, so files no longer
> >   need USE_THE_REPOSITORY_VARIABLE;
> > - moving repository-specific settings from environment.c into the
> >   repository, mostly struct repo_config_values and struct
> >   repo_settings;
> > - and, where a value is only used in one place, passing just that
> >   value down instead of the whole repository.
> >
> > A lot of progress has already been made: many settings that used
> > to be globals now live in struct repo_config_values, and many files
> > no longer need the_repository. But there is still plenty left.
> > Over a hundred library files outside builtin/ still define
> > USE_THE_REPOSITORY_VARIABLE, and environment.h still has globals
> > such as git_commit_encoding, git_log_output_encoding and
> > comment_line_str. That remaining library code is where I want to
> > focus.
>
> It's a good idea to focus on library code. You might also be
> interested in what Junio says about code in "builtin/" in:
>
> https://lore.kernel.org/git/xmqqmru76ybk.fsf_-_@gitster.g/
>
> [...]
>
> > Roadblocks seen in earlier work
> > -------------------------------
> > - Not every global belongs in struct repository. When Ayush
> >   Chandekar tried to move core.attributesfile into repo_settings,
> >   Junio questioned whether attribute data belongs to a repository at
> >   all, since attributes come from the index and the working tree,
> >   and compared it to how index_state is passed around instead of the
> >   repository [7]. The config value was later stored in struct
> >   repo_config_values instead [5].
> > - State used during early startup cannot simply be moved; the setup
> >   code has to change first. Patrick did this for
> >   is_bare_repository_cfg and git_work_tree_cfg in his "setup: drop
> >   global state" series [8]. have_git_dir() is still left, and
> >   environment.h says it "should not have to exist at all".
> > - builtin/ commands: the "repo" argument of cmd_foo() can be NULL
> >   (e.g. "git foo -h" outside a repository), so blindly replacing
> >   the_repository there causes crashes. Library code is the safer
> >   target.
>
> In the discussion I mentioned above, Junio says that the code in
> "builtin/" isn't reusable library code at all, and that it would be
> useful work to move that code into library helpers.
>
> [...]
>
> > Blogging
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >
> > I will blog on Medium (https://medium.com/@okhuomonajayi54) and
> > post weekly updates on my progress, what I learned and the
> > challenges I faced. I will share each post on the mailing list,
> > like previous interns did.
>
> I wonder if blog posts on Medium are accessible to everyone.
>
> Thanks.
