Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D75D3ACEF6
	for <git@vger.kernel.org>; Thu, 28 May 2026 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960220; cv=pass; b=T4HhCFjuQYWKiPMxDU2r6dBQhmZIQDd/HT9o1YRCj9R12zbVfz1VqMS9S2lC0FxmAGwyAFsjV6Lt9nt6eyJbJLzVIPnfyTs7K/vSIszuKkb9AUXeABA2DuW71RztOKqndgNxjiBN+Xxpt+U/uIW3iSk/4DjtpQeFKNPCU3P/Vz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960220; c=relaxed/simple;
	bh=NI9OENpubvDwWlae9Y10U3gHzdYWJzh4cztZl5iwpfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DTL/Z03VfkWR012W+NuTEbgt+WOTM+77dS5EOxcdm8ccRYq+1JBaueCHSTeIca7RAzmbIZDejcTpS+7g86+1MQ7muKZdBe9MHkeWgc963fDhBF8y3q3pwhlP2j2sDeQRZBsYPSjQhbwar3zI/bj8PKTLBM5WGCVWuhOORruRc/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qej0Ukd1; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qej0Ukd1"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1363e78746eso8624805c88.1
        for <git@vger.kernel.org>; Thu, 28 May 2026 02:23:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779960217; cv=none;
        d=google.com; s=arc-20240605;
        b=NDHSFdHPVuCjXqQ1PhUqARX4R5WFkXq9GUXsiMSWWTP9wWvezROrtdGUyZ/Hp5KJ1Z
         y+fhUjqH2wUghDt5cBQmZMwVkmxMI7hPt1RAuc4/1mw1ULP80PRNXVzrKFiKxIm4S91v
         /4/nEK8e9V4LtowmvpNoRF/bz+FMw5vVTlW49bKst8qBm9PoSl8GKbWzDprL4uGJAUF6
         vJXhloVTh3SX8Bcuen9tRv1Ek82OQHJqGouPFXcMxLh99HBQQoVWhDwzEcXww4O8HFDX
         pzXoT/ihpqZddowNwQJ9rI7Va6M+OvGotECPv1IKRyt9PA3AVBdnqdRGBRw8Ds2UaVVF
         UGvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1KZQt2UHJplDXs8GFJ70K/DEbPunP6CL3So5E5rC0NE=;
        fh=sIJhQ321fhC6D7H6+P1gj2drfdspi883By/CGh2fjOw=;
        b=gEgZkn2r4ydWpIhfflAUCSAINpxEPA95SSfiwUT56i+0O+fcfOJq5kccBHg+rGtr+2
         AWHpGcZ5Mibbcw9kIFmrDQ/fGo4Bo+4AAkCIqG2i6rHtKWfElb+vLt7ibGPYp9YxZJ1l
         DTCFUYqRbWmV0ZxELVvGU5N8V1OzkVRhx+Rsplz7698sPiBBrYw+9o3rlxc8VhmwJFyG
         Uz/mKgmWfxtamFzwy6Hs3QKSBerhcMuCX1EU/2M1dpUjzyzRkyWT+SnWvb4OQEEtAWEA
         MiBuTPDv07EErnicP7Emxh1885gEJIS43YhZz1wxeDrszGx8zI3w4r4/U0GOWwbbgxuM
         9jZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779960217; x=1780565017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KZQt2UHJplDXs8GFJ70K/DEbPunP6CL3So5E5rC0NE=;
        b=Qej0Ukd1Iq8u22z62bwOx/nHWMPG29zVMynJ9T1Z2mKk4kFXTfor8+gzlZzMSrYv9B
         rM02VRHvGGGzDZJgnGzrQj6N9IRHy4SQVSEe6D+ueQPTnxqBjRdzpJ3EaDSTCLjHbR/8
         I09vj28coLLcrSHgcL/shnAy8A+BLM38WSs7BhKftcIhybmrYcbbZk5UJs6xdlgCLlCr
         EGhKGmMR2dG9/HEwZQFLLCMKUj3GYotkMLK2IATu0fMkAy7kSFfOnBEi8Aljs7x9g9C5
         BGYzNXbOy1gH6XZTehK72Y66WEZ6Mqxe/7SSFVA7DsVk1S57X+vUt/g4DTe5SX3L2AqS
         k/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779960217; x=1780565017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1KZQt2UHJplDXs8GFJ70K/DEbPunP6CL3So5E5rC0NE=;
        b=cbyKlc+Cg5gOPCZzKITW5DrNXGakLwwKSwbn21CK/kz8jB7lQeJotrJ00tRRtvvxV8
         8TJiu37FQYdSZWv52p8NfVrnYpEjb/VEuk/HTi/hW2kdoDWxejwvgjTrNE6ch6LdQqJy
         hmlWEYZF1DDklLdVGz5fW/EsYHdagKtgUuWBG9e+WHjrJljqVTelsJFM3M8yKg4HyPiv
         hz8ZPQu0eODy0xP4PomsceXNAeu6Ucf2PjcJ68zQjkwrqvWepZVgs5R4ip18L0VEsgtM
         2WuiBXUb9maivEhd3OTf4diLS+bcGoMWE3Mbcq49aX5AdbHdEte+7eneiC+kZuNrWd1C
         A29w==
X-Gm-Message-State: AOJu0YydwTtFRwOaX3pb9e/RDYF2YJ/z4tlpwBZ3Nup7NcZvbJwvH4fM
	KrpGyCx73Xt/AMfZxv2wCbBRoO2xDtspjlT93dr5l8XagoyVUR6DnZ4TFOnD+x1znl0JLq0Fjjz
	wRc1GksBbZWLzSmkjgXkexZO5W+wz2ABLfJVi
X-Gm-Gg: Acq92OGUR5aP5/9pdwdLGTj/2zals6lvYsGzfNM+QI0sViPD1NR5i4J2Jg37HPeDNr7
	FRLFn3gOQcsuWwFofNM/6jtlh6OC4dUCkK2xDARvhWOm/OjpxWF/NNbVhERfO6p3BxQQCFYCWx1
	4X6v97hFsu6A5D8m2npZcdZ4a33rC4sGRnBHU8H5MJyyJy67Nom823pWuS3g53dlWcgWl7FAba1
	w+lAjd+Rs86PnIzIzzuLzEBt3f0R81GFDK91TJ/zpdAnaZc761pZO7i4gRAFYsD7KT/2D/nh4ZL
	4VZXJBTaRwp9Jqp+vWfE+pwKvWwELglo9yKoFJ016n+kPx46Zf5dew7kQEH7xWv94yEvRXMHlHT
	VmafqB5Y6ELjdOQ==
X-Received: by 2002:a05:7022:b042:20b0:136:73ec:922d with SMTP id
 a92af1059eb24-13673ec94e7mr6264443c88.36.1779960217435; Thu, 28 May 2026
 02:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_530FD5EC0E2FA9A005AB4725@qq.com>
In-Reply-To: <tencent_530FD5EC0E2FA9A005AB4725@qq.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 28 May 2026 11:23:24 +0200
X-Gm-Features: AVHnY4JNHvEKGY5DbJyewd3srkVYM2V22-nMBz72Xy2YxhxNg8CVZMS357Eg2vA
Message-ID: <CAP8UFD1TyE6bx8uhJ-hZuSv5t6D7rwRZ8m448-rVepNnyN1=CA@mail.gmail.com>
Subject: Re: Suggestion: Real-time or Conflict-Reducing Collaboration Support
 for Specific Directories
To: =?UTF-8?B?6IOh6ZSm?= <hujin2@sunline.cn>
Cc: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hujin,

On Thu, May 28, 2026 at 7:16=E2=80=AFAM =E8=83=A1=E9=94=A6 <hujin2@sunline.=
cn> wrote:
>
> Dear Git Team,
>
> My name is Hujin, and I am an IT engineer from China. I have been using G=
it for more than 10 years.
>
> First of all, I would like to express my appreciation for Git. In my expe=
rience, Git remains one of the best and most reliable version control syste=
ms in modern software development. It has played an important role in many =
projects I have worked on.

Thanks.

> However, I have also encountered a recurring difficulty in daily use. For=
 certain types of files, especially files under script directories or other=
 frequently modified directories, conflicts happen quite often because upda=
tes are not synchronized in real time. In some project scenarios, multiple =
engineers may edit related scripts at the same time, and this can lead to r=
epeated merge conflicts and extra coordination costs.
>
> I wonder whether Git could provide, in future versions, some optional fea=
tures similar to online collaborative documents, or directory-level collabo=
ration mechanisms for specific files or folders. For example, users could e=
nable special real-time update, lock, notification, or conflict-reduction b=
ehavior for selected directories such as scripts. This could help reduce co=
nflicts and make Git even more convenient for teams working on highly share=
d files.
>
> I understand that Git is designed as a distributed version control system=
, and such functionality may not be simple to implement. Still, I believe a=
n optional feature in this direction could be very helpful for many enginee=
ring teams.

First I don't think it's Git's role to provide a full collaborative
editor, but you are right that it could provide mechanisms that could
help.

Then there are a number of features/mechanisms that other SCMs or
tools provide that could perhaps help:

- Jujutsu's working copy as a commit
(https://docs.jj-vcs.dev/latest/working-copy/)

It could help write a background script that constantly pushes and
rebases the current commit to a shared server as the user types,
mimicking a real-time sync.

Jujutsu's first-class conflicts could perhaps help too.

- Pijul's CRDTs and the Theory of Patches (https://pijul.org/manual/theory.=
html)

To seamlessly merge real-time changes without locking the file or
constantly throwing conflict errors, modern collaborative editors
abandon SCM snapshot merging entirely. Instead, they use one of two
mathematical models:

  - Operational Transformation (OT): Used by Google Docs.
  - Conflict-free Replicated Data Types (CRDTs): Used by newer tools
like Figma, Zed, and Apple Notes.

Pijul's underlying Rust library (libpijul) which already uses CRDTs
could be wrapped and adapted to fit a real-time context.

- Michael Haggerty=E2=80=99s `git-imerge`
(https://softwareswirl.blogspot.com/2013/05/git-imerge-practical-introducti=
on.html)

I think this is the right way to simplify complex merges and rebases
as much as possible, which is useful if a lot of such operations have
to be made.

- CRDT AST (https://github.com/aaronmunsters/AST_CRDT)

- Automerge (https://automerge.org/docs/hello/)

- Yjs (https://github.com/yjs/yjs)

It would be indeed complex to implement any of these in Git.

The nice thing if someone would want to implement backend
collaborative editing features is that these days an AI could perhaps
resolve merge conflicts automatically. (But of course users should
have a way to override the AI's decisions if they think it's wrong.)
There are already a number of tools out there doing that for regular
development.

Best,
Christian.
