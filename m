Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD30A158A00
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728200727; cv=none; b=odqKGvGfQ9J5x8R0QxHf13ycNNOLctu4A3yK25CjwdpWXGkmg8kVQXCnyg2/niONC5JoBrk09P7HerzesaEIhIYNhovPu13DW2UGsQQ+yaez1V1lqz/qQFEvGETTuQIn6Lx9G3oVSQo3T7YK4aCbfntH9FxLixRA60k9kSwy9WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728200727; c=relaxed/simple;
	bh=W05NitfDNWS99oPF1yRVoPqm2H3MU0AFOfB/64BLBgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEg2IN4TNnh3O1oJWgf+6nEVt20RhnQ4YdyaHHGmB5zVLz4PID7ByUU9g7SgzoH99pJa4s9TN99UQyEd2GgVYeBI6oeQecY/h3i4/WXqDRw4Df1EdbPp+JN4DroG9A26CqzPBB5SgYLC+2OiitV85fKPUiim6A4jMOLgVC2iUzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-45826942f3cso6063601cf.1
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 00:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728200724; x=1728805524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeeKwL4ZyQ9u/fzgqDbZvYDFTr4WqR0jJv1bMKNt5MM=;
        b=K6sKUrVVZxTSMXvrkdT2W9KzFeMf3tIp6Td9Oc9CXJ9ITSp7oDr2nr36wJzUNQ9FXG
         iK4TNJg7L9ijIPzsrxI9DFvd5dCioOIvKcoTL7S9fGRF3UFiPLDy3gQY6cq1CxFym//r
         +AtqsgDoBFJL5t0R61N1oXOmcUAHzowdsfR5Wyn2ufm4mBuTfhOoLRiNie23hNko9gVh
         z26m00JRvtJFNN3uP9n9Ib8oMZsCXgb8oIs5eh2wN8Trg5FGVh13qZCyitwVZFBMsz9c
         dRo9+mziscckySBlMDXmhoKdZmcguD5pi4+BNbUuN+0n/PY5ri9LATC+O4ilYKnbr52x
         WmSw==
X-Gm-Message-State: AOJu0YyUChelK9cViJzFxEL/J9z4cOls6WKhf/AhEm5GT2XWPmct3fr/
	zHnBR4VMTLFU3YSUNiXCdXoUU/tQvecrBH8DvgJHPLQo6jXUpJzCRTEgEZ8RNx9lHNWYncu+GsB
	x+nVbniiornYySlJrMvVeffSHC9s=
X-Google-Smtp-Source: AGHT+IHQ96+ZPQLdje5yMx7Sr0/GncLnbSzN+AeAOd45R2YTj3BiN+D9aNH939/Ygrx0HamZfUU0EBQJ202kkxmqVes=
X-Received: by 2002:ad4:5761:0:b0:6cb:480f:cd27 with SMTP id
 6a1803df08f44-6cb9a30c061mr60244566d6.5.1728200724519; Sun, 06 Oct 2024
 00:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006045847.159937-1-cdwhite3@pm.me> <CAPig+cT6LALKjEappB7QkB7oc88NyMcr40T_qJGL2mPA77K7XQ@mail.gmail.com>
 <CAPig+cT7CEnb6cQmAOMbD82wxkg=7T0MMW=QNUSPU62a0rEGLA@mail.gmail.com>
 <TEfKiit-RYyr0ZuiQszaKaM64iSonfaQwWRqExOgXyPR1tVWyAzR3kVKmCd3aREZwDGuS5VXcHjCvneY-gCg2OuZyv2N2EkfARlZu4AVSsU=@pm.me>
 <CAPig+cTE0gaD=7dwSqY4S+7AqRoU9yOrS4sdBoybj0Pfyk9vxA@mail.gmail.com>
 <K1lpl_AWj4xpiHLG9AloFDP7hkJ7Ysf-LA5H-OeP6suaBcES3WS6NTYZGX96oQuNQ3x36eEOxGdqlj3fG3ybrn5y3LRPfCNqC7yqTyvqVrk=@pm.me>
 <CAPig+cQE0RNLhktuja-BbF8WwZmKC3cox_GUC-o4w87PadDpgw@mail.gmail.com>
 <gX8RNUg1e1FCYFS1vP-uT4rbMpg21Ax07CZm5Ha7Dsk93EN6CTuXiLr3boTaoNEi71O1rDoUxhTs6KQt7Cvfz7B3KlbpZzis5b05KW7ARls=@pm.me>
 <CAPig+cR4FXsGDE9Uu04EjK+vOo-Pi_VwOub8+Dy3r9t7z8GdkQ@mail.gmail.com> <AtSpzKynOkmMPZ3bR4qx-eA93Xo-1miPCIQSxIKP534tD-qpDU1AI74vqB78RsukQ0XP5eKdvzHcwy_lf8lpL9wAoHoom-koo5GKcbrcuX0=@pm.me>
In-Reply-To: <AtSpzKynOkmMPZ3bR4qx-eA93Xo-1miPCIQSxIKP534tD-qpDU1AI74vqB78RsukQ0XP5eKdvzHcwy_lf8lpL9wAoHoom-koo5GKcbrcuX0=@pm.me>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 03:45:13 -0400
Message-ID: <CAPig+cQZmEdx1Th9VAHbEkJ=zm73TP7Wuda_G5CzFw7j9HTFQQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Link worktrees with relative paths
To: Caleb White <cdwhite3@pm.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 2:23=E2=80=AFAM Caleb White <cdwhite3@pm.me> wrote:
> On 10/6/24 01:16, Eric Sunshine <sunshine@sunshineco.com> wrote:
> >  Indeed, I'm seeing the same line-wrapping breakage in the mailing list
> >  archive and in my Inbox for v2.
> >
> >  I presume that you've verified that the raw patches are not broken
> >  like that, and that the problem is happening at email time?
>
> Yes, I've checked the patch files and they are good. I'm also not seeing =
any breakages in my inbox which is strange.

I've been trying to hand-edit v2 to fix the breakage in order to get
it applied, but I'm not having much success. I did manage to get patch
[1/4] applied, but patch [2/4] is base64-encoded for some reason (you
can see it here[*]), so I haven't been able to edit it easily in order
to fix the breakage. `git am` isn't particularly happy with it either;
it complains:

    % git am PATCH-v2-0-4-Link-worktrees-with-relative-paths.mbox
    Applying: worktree: refactor infer_backlink() to use *strbuf
    warning: quoted CRLF detected
    Applying: worktree: link worktrees with relative paths
    .git/rebase-apply/patch:60: trailing whitespace.
    #!/bin/sh
    .git/rebase-apply/patch:61: trailing whitespace.
    .git/rebase-apply/patch:62: trailing whitespace.
    test_description=3D'test worktrees linked with relative paths'
    .git/rebase-apply/patch:63: trailing whitespace.
    .git/rebase-apply/patch:64: trailing whitespace.
    TEST_PASSES_SANITIZE_LEAK=3Dtrue
    error: patch failed: builtin/worktree.c:414
    error: builtin/worktree.c: patch does not apply
    error: patch failed: worktree.c:110
    error: worktree.c: patch does not apply
    Patch failed at 0002 worktree: link worktrees with relative paths

Can you try GitGitGadget instead (preferable) or perhaps publish this
series somewhere (less preferable).

[*]: https://lore.kernel.org/git/20241006060017.171788-3-cdwhite3@pm.me/raw
