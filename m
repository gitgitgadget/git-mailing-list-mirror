Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0F831ED7C
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771421573; cv=pass; b=YANB2pfdP2HBYUNOE+pkxKezNQxnf+sAAz5OgfMol12NZBMc88kshT8hH0cx0bUQim817OFGyeJMZh+vJJoQW2/G/ihrZfreNoJ1/sPGoSAZCKSUKld7ZHfL+kzlWOsaR/mR3rhBcCIrDUbNtYdSK8KDWlwdELXuNdb3sh9Vuf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771421573; c=relaxed/simple;
	bh=oucZCiDJqkKxvz99URysGQH1pKP/0vXXgVz8eRYQWRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBME/9vFVokqdjBvy4Bd8g4I2Ht/UlqTmF2SDry9THkd+ZalNxNAkLipkaPchFwXPnhNYflnxqFNKM4LaDEDJm9aq+XOfZRJypWiUlwTupqi89NBG2IyJ4lEindMHe15JRDh2FPGhoy39+gnj0QRPiZWAIACXO4UDP5TlyTI+As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeUB/RZB; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeUB/RZB"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-948bff012f0so1317365241.2
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 05:32:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771421571; cv=none;
        d=google.com; s=arc-20240605;
        b=R2x8vGaGJZJdyOlJt19kDZsM8UD72dRK77YBJ5ry5tihZwMFyJbAtLW+QClBvBhCBL
         QwjP2apid1/A35w+tojUlMsFrgeQWJh7UZWY0F1kv2FUfrwJlSGCy+QBDWYtLBknOLgW
         XjlySUEzjzy0FhbTcS1RcsB9/1khS357F+FTAaDZPOqUHOMnPiASaIOoWY2xgfiAEXbG
         M9pS50d72vpAV44yNQAJk+g2c7YBhP7Zyd2PRpH3Ee8sXU/zSl0rzZWtSrBNFlMvuz+A
         C1vrtXy3fZO0SfYirsGyON1tu5KMexzVvfGJwHuOPfPyXV7a1kdEgBUmB56+g4RupmxG
         K0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rK1ap7H9+fDLyXyuDywvmfSE5F17SapeJvI8m76f43k=;
        fh=nZ7AwcQB774YPW8HuUxIWUYZ0mAEzqVhEgrGoYVASPg=;
        b=RLZfq5vqMp3kMJ5gnTm35NrX7rh9mxaAQeoSQQQ7SAkB7GOgAqAgHavn4aKcVZGGTW
         jQcbN5tG4ubKbw8lyayhM4kD6KxSFG5u9v1uap740r8llj4COLj5LABL2Fl6FwapkGPi
         uQpI8eoqyvQNvzzf+fXbp49zkbGzRx8A8y1oKBB4hFax5Fm0xuZPqJFFovZ03AesImjZ
         8MHiouy8/TIDhWDSAqqxqtKZ8R3V6z4zTJg6eHeqZ7gj4GRtFEz7/ePox1qnp05cRJth
         r+iPgUH0guIGXwg3AkdcmkMhcOiz8yubwJosELJ2kz56dNdoJ8S044TNVALn71STnWMh
         I20Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771421571; x=1772026371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rK1ap7H9+fDLyXyuDywvmfSE5F17SapeJvI8m76f43k=;
        b=DeUB/RZBi9AOw5x0qPnUd5lJmNWRkzdPvODfLwax2FYBGzPACeHIn17rvePRzuAQOa
         dCjGrd7rsfQ/xSDEWpm8X5xRa+mZpbcZz+aJkhr0vNrpA/UC9FKiLPdQKueKSUTssASC
         cza2K66mwMgXjBrQJC16p+/ePGW4q7MWRhgd4GrmrCZlBnkYuEO5VT7gAPbsP56atC70
         /waxovFoID70xULko2C0QP/iChIAD1FzWYzKXFpr6wU0fC4PQRCqckRfENXbyJDtIxu9
         6PWJE7k2kO0CI2SIsOvYc5T4awoUH/2onP2v1ZwRKZc3Hfd51bhlEpnQcUh64SShxNBb
         0ISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771421571; x=1772026371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rK1ap7H9+fDLyXyuDywvmfSE5F17SapeJvI8m76f43k=;
        b=VU2fGHIdcjiyiKKfENjsEva/qmqEOBRE/HmxRW1GSljfirDMFpwLsX0+G9gb3+eVq6
         VR2HK2tw1bXehT7ggN+yW9QNi1pmQtf37/pztFPaIp8PCqycFRSKXcANr3LuhFQAMx6r
         FR5SooS63RhkBESbnKeYdXN6gl8OWzFwCSMlMEmShbxmS5i3PPJE6Xt54f6LedlgXGd4
         qQfXrKU7ltLmp3ZgozGdEZf6MLftDDDbF4jshUJ9w5q39G2tPkoaWg7/StEJVOHf0upf
         SfHnogBiDFNGfbzxHdRPLYYl0Qya+SHXeXNc8Y7j1S6WX275Ao9QDwssSnayx8gzavqk
         ADKA==
X-Gm-Message-State: AOJu0YxQt2d5d6/enYGpTT1vinTB/rTjECQVWgJtFeuSTClfQC0cBUrc
	sTF9g1ofNwXxLKpc9I/WFggSflhqcvMOcG/LijnGCQKgbsjoPp5IEnab3yBkb4Dbk1tcJdu7v92
	G24jxpmM095YY3Gq5NN5H3iBRoOaqU7Y=
X-Gm-Gg: AZuq6aJD3d6Rd36l+ny4oujNITGc8rN8Z3Woo5DBfsff9E8qbUxYLiyh6O4h2N2kI/D
	xfgefklsHf8X/BKS5WWOPDZuxkHTuJaXXFX87V+9SQzHWgecuJlceDjlYl2iDG7hnBYmedmOuNx
	2xkmUowy6oHr5+PTb7Z7FmcOLlyYu2iN1KXWiPFeqFSZs1QGu9YtN+r31GQ3oFnQJ4ynyBehqzd
	SAlHRxxrAUlIN2cKJr0BJNL2GfcZkRI3wSrxxoq1T7R0wlKiDHQ567DyEU5IO185kzIdzdEdhqa
	Sdtii5p+8oH6Q1QCznWKbGpUo7k/+fP7m5ikmcvgB5psTVcAnKiCqbwvfAiZ7EW3tfzV5HvuoaE
	tpB/mi6Xv
X-Received: by 2002:a05:6102:3584:b0:5f5:7723:28ee with SMTP id
 ada2fe7eead31-5fe2ad77756mr5335662137.11.1771421571236; Wed, 18 Feb 2026
 05:32:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALT4vkh_t35eJ8oWkSokVzt4mj+cZYxPQCr=gtU5hEuA0v1baA@mail.gmail.com>
 <ec016470-ecd6-49c4-b9cd-95cc89112050@app.fastmail.com>
In-Reply-To: <ec016470-ecd6-49c4-b9cd-95cc89112050@app.fastmail.com>
From: Cary Reams <cary.reams@gmail.com>
Date: Wed, 18 Feb 2026 08:32:39 -0500
X-Gm-Features: AaiRm51Zs6u2fezMzUCgihe9XQnN5xtVmxvwO_db8WVNad9PuulUNi7qhzq_2r4
Message-ID: <CALT4vkiciQP1AYs7m9cwrqJMGtvm128gnog52Z1XjrG9xrzTUQ@mail.gmail.com>
Subject: Re: rebase --abort had issues
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.8.0-94-generic #96~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC
Fri Jan 16 13:19:05 UTC 2 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
post-checkout
pre-push

On Wed, Feb 18, 2026 at 8:30=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Wed, Feb 18, 2026, at 13:05, Cary Reams wrote:
> > wont be a lot to go on, but here goes. Apologies, I don't have a
> > precise timeline for you,
> > as its all running together mixed with a nontrivial amount of adrenalin=
e.
> >
> > while attempting a rebase, made it to commit 7 of 18, when received mes=
sage
> > about segmentation fault and inability to parse the file experiencing
> > the merge conflict
> >
> > fixed the file as per normal
> > added the file
> > rebase --continue failed
> > rebase --abort failed
> > repo seemed to be stuck in the middle of the commit
> > would permit checkout of other branches, but still displayed the
> > interim rebase status report
> >
> > At more than one juncture I received this message:
> >
> > fatal: Unable to create '...MERGE_RR.lock': File exists.
> >
> > Another git process seems to be running in this repository, e.g.
> > an editor opened by 'git commit'. Please make sure all processes
> > are terminated then try again. If it still fails, a git process
> > may have crashed in this repository earlier:
> >
> > However, after removing MERGE_RR.lock and attempting rebase --continue
> > or --abort (I don't recall which), I received the simple segmentation f=
ault
> > response with no other messaging.
> >
> >
> > w/r/t to state of the compromised repo, I have been able to checkout
> > multiple branches
> > I have under development and move them to a fresh repo clone (init
> > from backup). However, every
> > status command responds as if the rebase is still in play, regardless o=
f branch:
> >
> > On branch <any>
> > Last commands done (7 commands done):
> >    pick 6c706e0f5 refactors endpoints to include element-delimiting com=
ma
> >    pick 0373d1796 #1680 interim save to do research
> >   (see more in file .git/rebase-merge/done)
> > Next commands to do (11 remaining commands):
> >    drop 5e3a99f46 fixes 0-day enabling facilitator to edit their org da=
ta
> >    drop 428947142 #1680 creates facGroupInvoiceCreate template
> >   (use "git rebase --edit-todo" to view and edit)
> > You are currently editing a commit while rebasing branch
> > 'wip_i1680_pass1' on '85bcb9270'.
> >   (use "git commit --amend" to amend the current commit)
> >   (use "git rebase --continue" once you are satisfied with your changes=
)
> >
> > nothing to commit, working tree clean
> >
> > Began rebuilding a new copy of my repo. Once I finished getting my
> > files transferred,
> > I attempted to get precise error messages and detail for this report.
> >
> > the status message is as above
> > checked out the branch I was attempting to rebase
> > rebase --continue failed,
> > rebase --abort did not fail
> > and status no longer displays the interim rebase update messages
> >
> > not sure what to think, now.
> >
> > self-healing ??
>
> What Git version?
>
> You can also run `git bugreport` and just use the generated information
> at the end.
