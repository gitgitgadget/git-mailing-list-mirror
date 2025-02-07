Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725501F4183
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936916; cv=none; b=JQfD03PEJxYL6xTn1hxPD49SrI2xisp2Mf00IPcZkw/R4gyqMvW44nwps+99Gufvp2AXPF/n2wzdzOQ4cWpZ83eJFyf+8sLWkF1uuv7SbpyVUkqaL8806yKwuEvV6UvMpg4LPIZ97H9pf3qNiJj4vKRxTDo9D/BIxia6JsSpnyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936916; c=relaxed/simple;
	bh=qntkBsQ4AvxNt5UoHE+kRgE1OW/wRDXs36LIUbErbFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spL2gKG5Gp8ZjGDCCZIX1vWHKPdxItnULwIAERtd317T3aMjbX1CzH8SmjdRpBK7YftnmBQfeMc7A9eQpiS0awB2c+6qglstixuOxVQQYtMoRWJTFHVRTIYdbkYTTY0jt2MnoGDlEuPfqT4Pqsq6Kl1iulM/rVRzdUXI3KmU6lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAOFsfBp; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAOFsfBp"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d14811cabfso746285ab.1
        for <git@vger.kernel.org>; Fri, 07 Feb 2025 06:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738936914; x=1739541714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puStE1tu7cNtjImrqIEvv4KJXAK1Uc14wmQdfIAcqss=;
        b=NAOFsfBp1NU+LCUrCtRYt/j/UxFVTt8sjAW5AsFiay8Kk8DR/WG5MRn7gRlZdSxhH7
         Ip8z7Fk1Q+0DTHgKysCTTCY+Ddyo1EEmQE+e5HKaq7sBsCDCbXEgRpl5hPziLPKRgh/o
         kleEwBW4hxfvBpgvbVUy3+nlv2akK8Q0CGfFi7bvgx+gj+Asc8Skjc32RgzWMYh76sG5
         7jCdGrZIV2sft08fDF6tL0dxOzpdIFLx66H2EAXyxG247STr33X12agn3teYP5nKhWQd
         RWd07dQeP8icTdIajqdCI0m+rurVrEJxlmJWRV3hCLxp3TioAJBL07CUeFajGbrMfrWq
         k+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738936914; x=1739541714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puStE1tu7cNtjImrqIEvv4KJXAK1Uc14wmQdfIAcqss=;
        b=QiTULJUfOv4PVevNq2vZasdxd/yF3CL1/PGLMVtM1hEFY+58gBq74xKzp4ZSbDUa++
         oWrr/d3yMrYhFFbNCkZ/08yVsJUJ9dMl3hbWdd+4iYerbxr/op7uRPTgvbpivWBe/AyT
         LgphUwJJBB+D4v3k670RHeIkVlqoTzswN/o9dJmc6POL5BpxXpiscMTkpRByiItr2SJ8
         nRbpXs3xeOrWctT/SajxvUAnD3rSWtpZw5Q+yeHjl2fbpRffnHMgqQUh4Ff3rEwm+pwO
         EAaZfNpnZ0KCy8DovFzmUOeyy/DcHHJNMbLGKTuxvBzWZVNN0IDbyIZbQbSg+/I92673
         XNvA==
X-Forwarded-Encrypted: i=1; AJvYcCXk26Vlh0aiwC0PMh+RhNDSPw32ddRB0zIOZ1Af3yibNoibIoU3/+h1K7LSc7fV5zXeSoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDN0ZdOwZ8OX57NU9XlsyZ9Um3mkQ74ioKa1V9ox4JNQ5hiFa4
	IxIu72NWa+9DiS160dDoRFi71VvI3nISdyP8HZql79srXpsruLz0Uha7b8uAt+K14RGaX4//zZG
	Ds4BGU/mvO50hIgtBuw89UX4WnKfC+ypo
X-Gm-Gg: ASbGnct8Dldkw9DxPOF63hwic3Yg5j1KxRySktnAoVHqXTSb+u7kIDIMTeKQK8lN9LF
	8XYS3d2rnhwDzgRlVRiy01A7jRR+8EQGPYdDhZ/uhz7aVPWrYEtP0tAs2oDuCD6O0Hvy6bEteNO
	hGEYr7kA0RM9JylYEkQqIiiDUBcrRK
X-Google-Smtp-Source: AGHT+IFNsF+wAL3ui9KsZs9bk1UsIyVeI+VdagIDY03esd+XahyRYncFQoZmtEgVl3QGhYSD5at5lPpTsdnXurDvHko=
X-Received: by 2002:a05:6e02:1cad:b0:3d0:fe8:6076 with SMTP id
 e9e14a558f8ab-3d13df1be70mr30367565ab.21.1738936914289; Fri, 07 Feb 2025
 06:01:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205214726.GA30202@raven.inka.de> <Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
 <20250205235931.GB30202@raven.inka.de> <Z6QCX1QZxxwC7RVQ@tapette.crustytoothpaste.net>
 <CABPp-BFZ3oyKiryKMPph+nfokC=sFa7wn1wdas863273bzy7pA@mail.gmail.com>
 <20250206134006.GC30202@raven.inka.de> <20250206200418.GD30202@raven.inka.de>
 <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
 <20250207104510.GE30202@raven.inka.de> <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
In-Reply-To: <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 7 Feb 2025 06:01:43 -0800
X-Gm-Features: AWEUYZki_oiuTgAiPXB1nbzJKgkRdaN5p0UOD-0ZvuJHbHikfq5n_-NFZ2u1N-o
Message-ID: <CABPp-BFnx2m75jsa3_kTPet97HY+xwb_6JmPiKM5+OARPy=mGA@mail.gmail.com>
Subject: Re: renormalize histroy with smudge/clean-filter
To: Chris Torek <chris.torek@gmail.com>
Cc: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 3:13=E2=80=AFAM Chris Torek <chris.torek@gmail.com> =
wrote:
>
> > and (in the case of cherry-pick) there is not even any way to
> > renormalize before picking.
>
> That's mostly correct. The problem here is that while `git merge`
> (both recursive and the new ort) has a renormalize option
> internally, it's not exposed to cherry-pick.

Perhaps not as a config option, but it can be selected via -Xrenormalize .

However, whether it is exposed or used doesn't matter.
Renormalization in the merge machinery (this is the same for both the
recursive and ort backends) is something passed to xdiff[1], for doing
3-way content merges of individual files. If a
merge/rebase/cherry-pick/revert doesn't need to do a 3-way content
merge for some file, then no normalization will be done for it.  This
could happen, for example, if one side of history being merged
modified a file and the other side of history being merged didn't
touch that file.  And as a special case, that includes when one side
of history adds the file and the other side of history doesn't have
the file.

In particular, for the cherry-picks or rebasing that Josef is doing
going back to the root of history, that is simply doing merges against
a side of history that hasn't modified any of his files, so there
isn't going to be any automatic renormalization.

The rest of what you write about optimizations is spot on, though.
This isn't a bug in cherry-pick (or merge or rebase); renormalizing
all files proactively in the merge machinery whenever a merge or
cherry-pick is done would be orders of magnitude slower for any
decently sized repository; it's simply out of the question.  I think
Phillip's suggestion elsewhere in this thread (git rebase --root -x
'git add --renormalize . && { git diff --quiet --cached || git commit
--amend --no-edit; }') would be what Josef needs to run, ASSUMING the
history Josef is operating on is linear.

Hope that helps,
Elijah

[1] Okay, technically renormalization is also used to turn
modify/delete conflicts into simple deletes, when the only
modification was a normalization of the file contents.  I don't think
that's relevant to Josef's case, though, so I elided it in the
explanation.
