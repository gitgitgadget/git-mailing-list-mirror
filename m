Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792635444;
	b=t7g1m04QHP1jPA6Um1Haj8UArnZZGmiMGchpKGs6+sxxwxKCAP+TYTaEG4ijqXuV1GpE
	 HnqDoZ2kXsvFvJpJClYbCbdP1FrT1ILmFCcKF15ZUcQy593uBWe61KQd+5YbhukzJjeq8
	 Ow3HVkSfbkNDj6QZk1ZFYl80o4RAa7vAdJw2HhFNLUwDsFsWRDxGLx+0q0toys5LZ2aQA
	 PrRKwxFxEbq5TQqAWXulhUx/4mXfj7Yi0/re1LlXZBjmgCMsmmtzsn3bgimFQC8eQtsC9
	 pxoCLfudgFZcdttPDI6dHWaK7L27eadEhLJuX1hocJ6Ui2FwX6CSpfxTibF0NBm61vA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=izhJMzAgtuAm0z2KDZK9IkKGS7FhPtRLUdb++ZPXC4c=;
	b=gDG4htAejNoS8bVeAUUxRoneTuEK7lyyXNyQo0tOOzx5N7bo70mpd0Xege7jbBTR+Pqq
	 2cQ7Zkp61Q4dW1QRD6jUpLrkoE4mgC6CNlH6eEuVYzK+vw8+JKurxYXAeQo+2AG134+38
	 fpSOP8Zbk9AYHGZHLYqh/Hhs578c/cB3lX22RAertT+GwebaRWRunv4Yg9pF/4BxO2S1E
	 rsKTyqypEGGyjmZhYxVXGuxsgKtirJbSebvL4xSMH7DdiU1owdll/5os9j7RtcYT67Te4
	 dzRkian8GdBUtJEsptW6DHa0IKR/EwTQimoc1Tvehxp4UkHFq2kt6xv4P3SRxl+GeJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g0m4AmcW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0570A606A31A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 02:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0570A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g0m4AmcW
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91c1f774e6cso847236d6.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 19:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792635443; cv=none;
        d=google.com; s=arc-20260327;
        b=qY627RVz0WoxEF4Kzw3HlBS5XjJy4LODfP+/icO05BgnPL/5tL3UersdkwMCaPRGEe
         JNFPdLhLqXb5OLoiXLXWEv0UAWQERMLVqvRghy0D+UrsE0c0Rl0M02/RZ3cWf3f+5nwl
         G0CFnIetUtRRgkajKNrvRPmkhm/E4vA8HJmAEKnGdQGRMyAuPlBeRJ5E1qtfHaJ7N/WN
         prn0J2eX6BACIjp6kvM6qCYU8qqADQBK9mP/41TDezL0zcV22fZiNmTjr0Ie9K6shexV
         zECh2j/fkhK1+/Fuf29OQntOM8Uug8OoWv6GRJPt/5E1wDBH9U38Sp6KTu4Qm1S3y1sb
         fX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=izhJMzAgtuAm0z2KDZK9IkKGS7FhPtRLUdb++ZPXC4c=;
        fh=Bf501TvqQawoPyKpevdMZy9mnNV4Q2oC25/+bUqpfS8=;
        b=GUOeizkFEC+hpbq2e0oWSx0pnH0LhIvAjxEb0FjAWg+1ApYg9+rAg3IzjhV1Zzd/42
         HZj3uZq+IxNx10T10qLaCBrnWAHU1Cc+/zEMO8TLGTmEuTWcmuE9H7K1kZ3xzFGIi7zf
         JpTFYQcE0EPQfRCmjNXJJZiKmaB5OvyapxL6sspv0cfUnvBTMfNW5wqH6xEd2efjSEeO
         UkbH2fPqTfsX6MTUcZWoJGRTg79Q17QOGBG02OJdnI10mrJQF0XTGSZ61KZ+ELqs/tmd
         p+2KDo0SpzWS3xNrR1Sri6RWHLu9Khj3id8S3C2wzOsQlqGbqK5o5mQ+0o74L/37Azjr
         PTNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792635443; x=1793240243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=izhJMzAgtuAm0z2KDZK9IkKGS7FhPtRLUdb++ZPXC4c=;
        b=g0m4AmcWvM/slQWwD3A8oLEcfqU0q4RY3Qp2rCnjXkgqBBVBakLF1hxx9c4/zw22Wi
         gLshq7wk0GeOYXw12jGI4M5ItwShJsHkYruwwpZFH37E09Gksp43KVjgl3x3+2WmvN0J
         UCh4ewT86spTXHMTADazErEIgxKjxI1tYg2B4CQrIFGgmcKjk4C+QLZ5ExpaMdBJopQM
         aCxRLPKNHJF72echGwbRgpGaVnpSRuy6Fs9xgaWYxH73rDfzNnxWcMYMwZ2+TcvuZfMs
         Za00gAbAg7wPtq0k0H6whFySGglv8C+BhbO9UhpdUpQc+fguCd/hIpQGbO03Kv6oV71v
         bsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792635443; x=1793240243;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=izhJMzAgtuAm0z2KDZK9IkKGS7FhPtRLUdb++ZPXC4c=;
        b=DtjZVX4iiVI8tCmMXXy6djFciCAud0cCRrEi67x3WtHa3N/R1Y8sWO9nFJR8wG/4J/
         c5EZGV1u3O6qH7TmemnVbxegFsguW6+eCFaW6VklJFpOPu7f9PAOyoC2y+IK/kXJi+zd
         Ykx6MR4ZaVuns1Z9xU4oUpXTVO8Ay7adKPMOeL4Qom0dhmI6sjVMB7aZYcC122L7z0Sq
         6To6IYGYiMMRvI2fSllovMvbYQTfZciX6lEDr4ouo9b9wzoVMj53at0pnTT8pHDKcoJl
         7vF327oSdDoGDhK7y6x1EnkDZo3lc0rtfWO5sPeR4eY2oP2RDrsxlb30GHpcXCLVLfG5
         pldQ==
X-Forwarded-Encrypted: i=1; AKwUvBxB1KHRoGhYJ7WEQGP1jLvahzYGUwBCUXFrtc0b5/fGRqq0dEAFJ4tWd27PGWj96VTepyo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDyX9q0IEYMkJYlVyPg90NTeisC0KXXXl4eKqCXapDtE0laRtS
	ceY35Ok8oTSBwJFUq6JdKYnzovxXYNyjVf0G0VCVZUIh3HHTaszetD81/GPnPKKVA/dUWmMlh9V
	K6MYTEhP16+LwpKEm8nCPoVbX1QLgK3I=
X-Gm-Gg: AYBFou2E5TWXM2achGwicqNRMVzhBWNjcMFfJ9Rt41MDQQLANDdWhOwScx36M942u0q
	TrkW5E6T9xrVMxfgVcikte+G7UlK/yILOpx6jiAqMm/a27s4CgoCmzwbooUXTH+vRFzU2bw/L+l
	G+CyBm3z7vYCqP8DOVz4Jxllx04Aw9wPARWImvVG68P9vrLlkXr1UO0mDdYsJ0w9ZTW+uhnMJV/
	qRA9ZdqlnHpGu56q+gWQc/ePEUdMb3Z4KzxaQK9ko1fs09fMiQ813QCbI4UmC/hkvaoNflNgwwK
	xkco474rz5lKggc7yorepNsq5xkXiXxFmANnocz/JQ42VmEHJEjujc8aeU3LtzyPnH1P/5i8KRp
	r52QLQhmqfmEFnotbCoN+tSYgsnbNQYTPUHs=
X-Received: by 2002:a05:620a:6493:b0:939:9ef4:79eb with SMTP id
 af79cd13be357-93f57ff1ff9mr843820585a.6.1792635442824; Wed, 21 Oct 2026
 19:17:22 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2268.git.1792458904027.gitgitgadget@gmail.com>
 <pull.2268.v2.git.1792618518.gitgitgadget@gmail.com> <xmqq7bjalmpt.fsf@gitster.g>
In-Reply-To: <xmqq7bjalmpt.fsf@gitster.g>
From: =?UTF-8?B?5LqV5LiK5Y+4?= <inoue.tsukasa.4@gmail.com>
Date: Thu, 22 Oct 2026 11:17:12 +0900
X-Gm-Features: AclHuK83JZSjc7iu1yhuZNwlVu5Iu1gP4IIfvoNbX5KernF5uB_aaePTD0jxNFU
Message-ID: <CAP8tz2KOXHLjc5V1o1tZZWSsgOjVrp-ekH7H5KszBGK+hRqwrg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] checkout: finish switch when tracking config
 cannot be written
To: Junio C Hamano <gitster@pobox.com>
Cc: tsukasa-ino via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I am not sure if these two should be part of the same topic as the
> first one, or they should be treated separately.  IOW, if the way
> these two patches implement the fix proves to be contentious, does
> it make sense to hold the change in 1/3 until 2&3/3 are resolved
> (and vice versa), or can they be treated as two separate issues?

Thanks for the question. I checked whether the patches can be split.

- 2/3 applies without 1/3.
- 3/3 conflicts with 1/3 only in t3200, because its new test is placed
  right after the one added by 1/3. The code does not depend on 1/3. The
  hint sentence in the 3/3 commit message assumes the corrected hint, but
  that is only a wording dependency.

So 1/3 can be taken on its own. 2/3 and 3/3 can be discussed separately,
and changes to them do not need to hold up 1/3. I will resend 2/3 and 3/3
as a separate series on top of the current master, so that 1/3 can be
applied first.

2026=E5=B9=B410=E6=9C=8822=E6=97=A5(=E6=9C=A8) 7:20 Junio C Hamano <gitster=
@pobox.com>:
>
> "tsukasa-ino via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > When the tracking config cannot be written (for example, because
> > .git/config.lock exists), git switch -c and checkout -b stop halfway. T=
he
> > worktree, the index and the new branch ref are already updated, but HEA=
D
> > stays on the old branch, and the changes are left staged. The hint prin=
ted
> > at that point was also wrong: it suggested origin/refs/heads/.
> >
> > 1/3 strips refs/heads/ from the hint. 2/3 makes setup_tracking() return=
 an
> > error instead of calling exit(). No behavior change yet. 3/3 makes swit=
ch
> > and checkout finish the switch and exit with status 0, as push -u, clon=
e and
> > fetch already do. git branch still fails.
> >
> > Changes since v1:
> >
> >  * 1/3: the test now compares the whole hint message, as suggested by H=
arald
> >    Nordgren. It also checks that the command in the hint works once the=
 lock
> >    is removed, as suggested by Junio
> >    (https://lore.kernel.org/git/xmqq7bjcup46.fsf@gitster.g/).
>
> OK.
>
> >  * 2/3 and 3/3 are new. They implement the direction agreed on the bug
> >    report thread (https://lore.kernel.org/git/xmqqecdjsryk.fsf@gitster.=
g/).
>
> I am not sure if these two should be part of the same topic as the
> first one, or they should be treated separately.  IOW, if the way
> these two patches implement the fix proves to be contentious, does
> it make sense to hold the change in 1/3 until 2&3/3 are resolved
> (and vice versa), or can they be treated as two separate issues?
>
> > Making the switch fully atomic, so that a failure undoes the worktree, =
the
> > index, the ref and the config, is left for a separate topic.
>
> Sensible.
