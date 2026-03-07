Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79711359A73
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772878686; cv=pass; b=okfLHWlprTM0N3LYqnTmypZwAYyyFK3tU+t7C8egEz241sZh/kqYRzqEb0tYB8CFAU5ENXTo1iRZAlFkdPvaXdNrsmPVS8nDgEAyNDvz25/5SsOpcA5Tlp4qItEiSVpgk6UCg0JOatdA65ByVzNefrguGxA959AvG5bqWg9/HQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772878686; c=relaxed/simple;
	bh=fAxb4JfxdEBCYgt6/TRp+juzduUfW1qWCTDtUXw8Gww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTbY/ZGLFNqFNfvtAz0bWbJr3KTf7qUaTNiFw78YPRV8/gMlLSPAqc0lO+o5+wZDKlDj/9qxqmyw1cYCgrZt3yT9M4r8Hhsv3pi1CBwcDTJODAj5HLwYUC3HpNCNG3OnbKdibXg8Gn5XHJMVcGRXx/6VY2OzrScktnt+19EhWdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnC4TSyo; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnC4TSyo"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899fc9853b7so88127136d6.2
        for <git@vger.kernel.org>; Sat, 07 Mar 2026 02:18:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772878683; cv=none;
        d=google.com; s=arc-20240605;
        b=N70/5MOxvWqRCvL44B1ryNWfCeZAIP58MOLPsYeA/6h8RkZmLoc4CiCwnx3+1tqEHc
         ru8CyZ47Y6YUuPmJjwkarKN1hQ97/JQIf7VgTVcmDfbkTF7VSvyVqNq/i103JDejtGYy
         uqzhAUCirZnLu8N3T72XRZGsNZGwkzpkDeyQk1UNyq09wyzDnyld67CpmxalysewD9lI
         I/AizqUanhWU1WyGx5ABzrXC1a2VYcShn8srNMF/JVupt2SK8gvOyik7okjzlgBRSpG+
         5Jxk5A1y5VeLqFRfxAaP5XlN5o8F0lRrDiPzbS6XtKYnI5Iu+NIVc5zLXBN4dCEruod8
         wzVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Pb6G0rfaPKFbKU0UP0bcHKJnzp4G8Ml+Mm2tcX9c9vw=;
        fh=lEc7zA6btl/ctnwuIjxhF5ZdygHqJgX4YOKBUxG0F9s=;
        b=JU0XpMVruscvzyYoK8QKGDate3D+fNIyGP3a0UdYktCgxJqWgu00kJdbeVpeBddr9f
         MrsRtKssmJqUOS1B+4gBhjpLwdxLBawd7rGOLVZ3Xe2iz0v5hSm8qY5EHawXobrci87t
         4i5OEfLJdY2F1z8MQgaWDgRGD+q2soEkbVCRet19bZgHEc6UTcc64FAKvrbh7SLZKnpd
         c+FzeD4jbMwSbbce2T1cV5WEOE78KyXMC6/FZEDontWH86ciALZO2Nkkxuc05PB5x6FK
         2ShddHvO2lLeR67RXvPV98Cta0sKLscGCM4OEmKChhpPnsosJilmPcxRVS4rG378bZ8k
         k0Aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772878683; x=1773483483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pb6G0rfaPKFbKU0UP0bcHKJnzp4G8Ml+Mm2tcX9c9vw=;
        b=CnC4TSyo5qBs+q2278S2jnAX7EdHWskNtCNLO9XWwiUeeFFQRcOViGiHT2ESgBWEsW
         lXtgKnEJmkzM8Ow0QuXJ9SGwUUxTyJqeuGNlVM8+ktbh5GyPCCIK4lY4L+TStAQgjGrN
         HseaUtX4wvE4F9Ke8CsI6sc1lY05k/IP6eB36SgZzJMPnMgmFVaZp0l/JoPSMEjFtB8h
         y8xUMxtuE4HyNnweZ83AYuxW+DTi7e3key+y5WudfzSTyN4ZADTUkeIU+n9jEwHAkvD8
         5lgU37PAXNFh/Q/ogLd5YsEfsC6T0FruffbwkIs7Ae9bIFv4AfDS1OBcKRXK13VAsKqv
         ezNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772878683; x=1773483483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pb6G0rfaPKFbKU0UP0bcHKJnzp4G8Ml+Mm2tcX9c9vw=;
        b=G5oXNfM7NYbAl3KG59UWKHp1VxUbQXkWpjRzenxwvGoe1h9RPp/xh/w78wLzrv0wFd
         G0YzH05DyJe02l5SAZZyvWJoQe3sZeB41bUPONJkv4+UgwlVVO3IpqfQRi06u76hqAvs
         XW/S+u/8iNEVqn+iCOlLGMe3ykNyIKMTRVeGWxolXHjOK6cjmckTxmpqvI9Ks3ngeyxT
         fbJ5TF7P01qQYMRmbomHcG2dibc46NdEXV8/abrndwHOvg8jPIMFbRGmyEt2fOtIYNfz
         +pElvsGgcruZz//YIiPVld+tF7w4wqamEycBrPV4BOKqjztiAebxk8i/jgAQfXg+rqmM
         CSXg==
X-Gm-Message-State: AOJu0YxFS8wPPXIXqIYKGCU9nDz5YKOaLaH1Zxn6mrLhj7KH/0KtPOwk
	W0lOS1jkmcs041PUEwLnryUnbf8j5lInPkfR4CkmiBGZmxebuY36QKJR6Vd4ZGxbskb9nLDnBWS
	XLx9Ya0w26QRaA4zMvMbMHlDWbSontA==
X-Gm-Gg: ATEYQzwYiHjf6LwmwW4gSSOLclt+JBzepVwU370EzUvVjDpoBgfzVE0t+nVP1NfgHd/
	zccqbHXPg1rsWxmwLr6vp8u8CdZKzo5OkjA3f+fba80FqnD5nsFBmBYz2FaCqRY0BE9R4KLrVqS
	9ntBQx5+2pW0aeXjlgZijwMCqGLqK3QwhhRbHOB5cEOJwwBwjNQPHvvJUduLxOkBDJKnyLuaXEx
	KeEq+Sz4U3/pEGHQ5VjPl4dJVRFe1yOP0SEOS8EJbSKHKvNfgfzB10yIe0+LrxfzNhstjIVbz2Z
	byNpof7L0e6gCs/eAIKtYPartg4qTWo++/hV1w==
X-Received: by 2002:a05:6214:2522:b0:89a:98:ff1d with SMTP id
 6a1803df08f44-89a30a5df7bmr71725076d6.20.1772878683080; Sat, 07 Mar 2026
 02:18:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEaT9_-h2MEshMHoyoW9kWQgt_EfQJXcxWSn+cXTSL4mKME=5w@mail.gmail.com>
 <20260305225128.54283-1-francescopaparatto@gmail.com> <CAPig+cQWCK48GJEnGX7bP6exu847WR8HU3Y8sna525w6NEhmmw@mail.gmail.com>
In-Reply-To: <CAPig+cQWCK48GJEnGX7bP6exu847WR8HU3Y8sna525w6NEhmmw@mail.gmail.com>
From: Francesco Paparatto <francescopaparatto@gmail.com>
Date: Sat, 7 Mar 2026 11:17:51 +0100
X-Gm-Features: AaiRm52WoVB5JmpF4cS9xnPAmsrk2kp_661ja-XJWq45xoo8Xnxs52_tEmXrsyg
Message-ID: <CAEaT9_9_F_kcPbTrisX_At6RANJ9MHCEGka6M=WRezTO+-3A-g@mail.gmail.com>
Subject: Re: [PATCH v3] t3310: avoid hiding failures from rev-parse in command substitutions
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Eric Sunshine <sunshine@sunshineco.com> writes:

> > diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
> > @@ -569,13 +578,15 @@ EOF
> >         test_grep -q "refs/notes/m" output &&
> > -       test_grep -q "$(git rev-parse refs/notes/m)" output &&
> > -       test_grep -q "$(git rev-parse NOTES_MERGE_PARTIAL^1)" output &&
> > +       git rev-parse refs/notes/m >actual &&
> > +       test_grep -q "$(cat actual)" output &&
> > +       git rev-parse NOTES_MERGE_PARTIAL^1 >actual &&
> > +       test_grep -q "$(cat actual)" output &&
>
> Storing the output of git-rev-parse in a file only to read it back out
> of that file a moment later is unnecessarily roundabout. It would
> instead be cleaner to do it this way:
>
>     oid=$(git rev-parse refs/notes/m) &&
>     test_grep -q "$oid" output &&
>     oid=$(git rev-parse NOTES_MERGE_PARTIAL^1) &&
>     test_grep -q "$oid" output &&
>
> Unlike this original in which git-rev-parse's exit code was lost due
> to being embedded in the test_grep invocation, this rewrite is safe
> because the exit code of git-rev-parse becomes the exit code of the
> variable assignment, thus correctly aborts the test (due to the
> &&-chain) if git-rev-parse fails.
>
> > @@ -606,8 +617,9 @@ test_expect_success 'switch cwd before committing notes merge' '
> >         test_must_fail git notes merge refs/notes/other &&
> >         (
> >                 cd .git/NOTES_MERGE_WORKTREE &&
> > -               echo "foo" > $(git rev-parse HEAD) &&
> > -               echo "bar" >> $(git rev-parse HEAD) &&
> > +               oid=$(git rev-parse HEAD) &&
> > +               echo "foo" >"$oid" &&
> > +               echo "bar" >>"$oid" &&
>
> This is purely subjective and you don't have to take the suggestion,
> but although yours is a faithful rewrite (which is good), I probably
> would have simplified this to:
>
>     oid=$(git rev-parse HEAD) &&
>     test_write_lines foo bar >"$oid" &&

Thanks for the review. Both suggestions make sense. I'll use the
variable assignment for the rev-parse cases and test_write_lines for
the foo/bar case. I will send v4 shortly.
