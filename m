Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9D739ACC
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728743677; cv=none; b=ughj5ED4rXgiXK0GYS5BRm9bo8YQR43nXSLwa/i3+cVwFTcrLY55epCNdtTVEk5r339xsu6nr/AjPkvlJ5GNRJ0Z3dZKJ7v9NNhNSCdvCnRPHF9o9rWwZ4KaMssvQ+8cmptKVutop/Iqw3Q6ERjYuOc2/5OoLjlXyUa6exZqnys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728743677; c=relaxed/simple;
	bh=hnJJmKSf0TYMK+Oc7Slyn+illLlHd/KFXfD/RcERQXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+koQVohnjCiMs6WEdvddts5aODWRapKUs7m4M81x4+tYuR1FeWkvEBmfOWLEkSW9/aT8Jjcs3FwSpLmzq7i4xEHXUBH/ITCjhlKh7JZ37DAr6UQMSpRvolzarVvgE9gwyC34IbIp/u/n74g3G7Qa0HkfTBI06wPl5jtFgpEXgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e290582301fso3315100276.1
        for <git@vger.kernel.org>; Sat, 12 Oct 2024 07:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728743675; x=1729348475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8d4CAuu6gNvDYTkiMw27HVnLP99hTxn3Lmm9xkyLZCc=;
        b=Lystpet0u/patiWrYb8sb+TLezdbr4A/xBORjlsr/nRg+rFFRl96w0e/+x1a8QtKoP
         rTaA3Srq2a/D55sc0cno+KpUp2ULBsS4fyO+QA1TGkmweMhyzIJ1KOulCQU7WJXn0PIy
         Ytevf+fXJvz9lpBIkPutoXbXNV7tJjI8IrVaj+TU0QYWDD6RdzcAQDke4HyTvVGXaI5/
         VVAIFTZZUO8aTZBgL1qzdVSlpHjcy1IR2FkXqkjSXZ6XWMDpwF4/P7Zc8HcSK5DTvl9+
         c8RQ/cfx/gAkDV58gYnnqpPpSyEyh8dnLMbQwscaKRAkpPLMQN6c2OO/22xkYB3bUcKR
         52MA==
X-Gm-Message-State: AOJu0YzqMPOnCZLDQhjs33YwJ6nz1G7fUsytupsbKa1eoYfRgvMEj48Y
	FtT+5Jbf9n5ksDhaU+iXPJw6AVtWHs/+SO1O2sxlDYXPMqyXUesYfdVcSYIL2Xnge9I0rZmHNmk
	45snnCEBi4+vA+SeMRBFN+FnD5Yu05V9Z
X-Google-Smtp-Source: AGHT+IHrKFCIKhlRAUEhT+VHxu7k7BNIPmpvMcPmDR7nuC1Bp6OWwAlV1LO0lX/57RRR3danoL6ZU+03D+hsXFC3/oc=
X-Received: by 2002:a05:6902:2789:b0:e28:6bc3:3e51 with SMTP id
 3f1490d57ef6-e2919da6cc9mr5728078276.27.1728743674590; Sat, 12 Oct 2024
 07:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <ZwoxHYD-e4qo7OyW@pks.im>
In-Reply-To: <ZwoxHYD-e4qo7OyW@pks.im>
From: =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Date: Sat, 12 Oct 2024 10:34:18 -0400
Message-ID: <CAOO-Oz0+sOpF6YQHSu0ytCO5TL+Anpr1k_9vQx6hebr624WjMA@mail.gmail.com>
Subject: Re: git no longer builds on SunOS 5.10, a report
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 4:20=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Oct 11, 2024 at 10:10:26PM -0400, Alejandro R. Sede=C3=B1o wrote:
> > First, clar.suite was generated as broken because clar-decls.h was
> > generated as empty. Tweaking the sed one-liner in Makefile that is
> > used to generate clar-decls.h fixed that (move the end-of-line marker
> > outside of the capture group, `$$\)` -> `\)$$`), which I would submit
> > as a patch, but (a) that only fixed part of the problem and (b) I'm
> > not entirely sure why it helped. If someone else wants to apply this
> > change, which would align the end-of-line marker placement with the
> > start-of-line marker placement, have at it.
>
> I'd still appreciate it if you could show me the diff. From thereon I
> can handle the rest.

diff --git a/Makefile b/Makefile
index 2dde1fd2b8..87c1f9e220 100644
--- a/Makefile
+++ b/Makefile
@@ -3906,7 +3906,7 @@ GIT-TEST-SUITES: FORCE

 $(UNIT_TEST_DIR)/clar-decls.h: $(patsubst
%,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUITES)) GIT-TEST-SUITES
        $(QUIET_GEN)for suite in $(CLAR_TEST_SUITES); do \
-               sed -ne "s/^\(void
test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$$\)/extern \1;/p"
$(UNIT_TEST_DIR)/$$suite.c; \
+               sed -ne "s/^\(void
test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)\)$$/extern \1;/p"
$(UNIT_TEST_DIR)/$$suite.c; \
        done >$@
 $(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
        $(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/clar-generate.awk $<
>$(UNIT_TEST_DIR)/clar.suite

Or feel free to grab the entire commit from here:
https://asedeno.scripts.mit.edu/gitweb/?p=3Dgit.git;a=3Dshortlog;h=3Drefs/h=
eads/clar_sed_tweak

> > The next issue was that clar/sandbox.h uses mkdtemp, which I don't
> > have here. Git has solved this in compat/mkdtemp.c via
> > git-compat-util.h, but clar is not using it. Adding git-compat-util.h
> > to clar/sandbox.h feels weird, but does get us further along. That
> > change introduced banned.h into clar, which exposed the use of strncpy
> > and localtime, both otherwise banned in git.
>
> Yeah, we don't want to pull in that header. The clar is from upstream,
> so ideally we shouldn't have to modify it with non-upstreamable bits.
>
> In any case, I've got a similar report yesterday where some functions
> weren't available. The root cause is that we don't set `_POSIX_C_SOURCE`
> in "clar.c", so with the below patch things started to work. Does that
> patch work for you, too? At least I think it should, as [1] mentions
> that the function is available on SunOS when those defines exist.
>
> In any case, the patch has already been merged upstream [2], and I'll
> send a patch early next week that updates our bundled version of clar.
>
> [1]: https://www.unix.com/man-page/sunos/3/MKDTEMP/
> [2]: https://github.com/clar-test/clar/pull/106

The listed man page is from the Linux Programmer's Manual, regardless of
the url path. It won't be enough here as mkdtemp is nowhere to be found
in /usr/include or any other /usr/**/include.

For what it's worth, the compat objects are being linked in, so perhaps a
smaller compat shim for clar that brings in definitions for mkdtemp, mkdir,
and whatever else might be handy without the weight of git-compat-util.h
would be a reasonable compromise. Maybe not. I don't know.

> [snip]
> > Please note that this should not be read as opposition to the new
> > unit-testing framework in any way. Building git (and curl, and gmake,
> > and zlib, and openssl, and perl, all for git) for SunOS was a hobby
> > for me, and not anything I personally need, and besides, it's not like
> > my previous builds have disappeared.
>
> Sure. But if the fix is easy enough I don't see a reason why we
> shouldn't try to support your platform. It would be great to get earlier
> feedback such that we can fix issues like this before we create the
> release (see also our Documentation/technical/platform-support.txt,
> which we have released recently.). But I'll take what I can get, so
> thanks a lot for sending the report in the first place!

I appreciate that. Builds here are very slow, which is why I usually only
build releases. The effort that went into this report would have taken
maybe an hour or two on any other platform I use.

Oh, and for the sake of future readers of the thread, git v2.46.2 did build=
.

Thanks,
-Alejandro
