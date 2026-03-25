Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F141372EF4
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774432833; cv=pass; b=OQn/a+Ga8ZkaH3lMJVogeNVgJomVrUKH/GiLTaQElydfhkuwEIuvZAmXFE7KfQ+YndScQGyaj1POPZ+J47CWdwqwMdvZqa7k/2Cx30S3aWBoAk72pWzcdfa1khvZFBnF88FO+QTPqbkfV45JwMdL0VIVvJDD53c/7Ov4OR0xVg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774432833; c=relaxed/simple;
	bh=3is3DRRWkVA3wailO6vDhllyzeoInzmgniCSIK6Z+SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1mOx1fj5LS0obrphxhBlxs+RpZfmBqtWg8lMft6WA52A3DBFvojvtN2YElH78m1zuI6PvoHI18AaW+b8Y7FmoEsZMLSKHXrN9HDsrkRLs6AusVXxzlJBDPgmftcXq4KBoeUsPOl0WQJo9N8KzjpbR6807Zr5dEa5vv1idWeAnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WX/aWpJo; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX/aWpJo"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-127380532eeso4500146c88.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 03:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774432831; cv=none;
        d=google.com; s=arc-20240605;
        b=Oc8+6QZpvXNnmxsspH3+d0xr/lAh19ezKNKGFEeulfQUErZrpnPT0mYOgItEwTgnub
         YHr9EFqjZ+f6zcf1h0Rmz9K5Pwyn+HHjGj6Fv8Yk9qe5DvEytorGYNEjv4K5hEb0Aoem
         6s/HYyWLWwSz1OT9mUBKWBcWCkegfrTLHWBqb81dF6LfCN7w90+WoY6v5eHCsESiD5y9
         GFIU1KvcgWi/bawjF6Fcbgh3xGhO8EqIx7BbOJBpLdTBg27UCTWI+8HzEnFWZxLZUKhL
         SKRc/kSInqqhTiB/YJ3GW6ZX6sGPmIjbmop6nWyqQuLzslTwTqO/TsTl0MZyk6Xo4ynp
         G2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CUnpyB1oH6pI0qD4nAneiAg4dNAbXVz/Ao203et9Crg=;
        fh=SQKc+ph7pJJpv9aNi2feb4X3gSqpl1f1GQB5E84yAH8=;
        b=D0Ze3bpSrDaoJObblop4gBItLBe85p43CnkeFUuUURk96Yh63jbup0smrTfLwhmpFP
         3PKhkEgr/eXX6drctbCrdkuKrbOfqt1UuoSRLDQqALQJw6BODjUPKaOU9NEDwRwuDHXI
         EXBuN5eza/OLnm8SwKp2n28dbZpO3dcZFYHHmRzdTJcKtvKo2NlcnumCti76JyWGhkPF
         sasnxeDpCU57VbsDsiS7HRQQjewG1ZJej8nGyXZV86UQBE1+XD6p+vlrLxUanFC9SLac
         R8fFFz8cQtats/F3SZD3vKnb6bHdccx2R1h756iNYWdUgJb77Gujj9kLrWPV8LqORbs5
         z7Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774432831; x=1775037631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUnpyB1oH6pI0qD4nAneiAg4dNAbXVz/Ao203et9Crg=;
        b=WX/aWpJoTUU37izygFfyf2FPuV0zKm8kyB9cykR2fxxJiENQKkn7eez3zTJgphmhUf
         /h4nMQ2+x1P9TRCFXyBTmuJMLh3od+67ktzRRSValzN/oSz0HRVvkrfMAufBcBFFgbPO
         Iaf15xv9kD4wzOWEHsVZVbc1KkQl772kBSe1ge+cSU1SEkhTvMu8k8qzHOT5AbBqWQ7R
         egSzFCLZsABme9Xc1E8kMIeDYWIV1K3OitFDd3XWiT4HnGf5BWWP7NoVXNs7YF8wKphf
         BK+cpQIsz3IwQLtVFXp/B3zA7l0lfViIykfVeu5zQMBRQXe9Wlv36GV8n1dNz1ufOFtO
         YxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774432831; x=1775037631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CUnpyB1oH6pI0qD4nAneiAg4dNAbXVz/Ao203et9Crg=;
        b=HpVtxzgFHuz48QeDh3W7FN+c/RMsMXrAus6JhbVgLJpnkO3/PtEbViV1HhI1uhdUAX
         EttyFK3c20bWcv0ejFC2bB1nIyQ5x2bVbo1lQB5vdcVWa4zKTMcEfG1DVRyGgy3gxdC6
         50HdKVjCjfaVVYLLoaq6FvNde5JeekaWwYqse13aCyWqt1Ann/cjO5qBRqVvtRHtQ+NS
         xebAR70rJhLnRfVqquyd01bY0f5/msF5DTMdHD0VKH2ijlt5gE1gwx9KhIJKHp7qMBMP
         kafUAkDKh8mqnGYmvNp7wubBSIKAgclEZr/b+ppnzv0ieqP0o70OX9QCdKkvS2MRwdFC
         piaA==
X-Forwarded-Encrypted: i=1; AJvYcCXMQYBr7KA4CmsIoeAkB7pYy/GKc/mdSwLLjWkEi2rVbI95CzRqvRpkeXFnnDMSlKsaMBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6u+V5/bxcWR4iKMVnMqUhOmH1W8egQa+2FdzZNe66Tcqsz8bA
	cu1NLOofYaOXbrgiRnJU8MfPtwJOWfB+GyM/DMM+sj7v57aAJnME3UEIbRZzXRfQM8T8GJlrYED
	NbOOQMdy7gUGTV6QDDnVRvfNXF9nQ/Kw=
X-Gm-Gg: ATEYQzxiRkC34/4FToHns1u56mPaT76veCVEMItXMJRBnsCtRJwG+5FcBVzQy2oXmZF
	qPx0oZARSty+5Z3oUaGJ//fKK6uDizI1qmLnyMpRq6ks3gHY2kv45k7KtQc9nLwC8gRn/h+BTEm
	9S5CX1uM8DHL3xHsZgIGWaUyWJ002hy7VLaAaBu1+qNHrXJDZXcdmAt1l69xSivjnkZtoWHx5Cn
	Jh2MwxC154elNeqxVXyJ1quqqlIVP4xirRyez09hyoGqDEXw2jkIKxO+wT6m7LgEOyAScU5XGTD
	ZmzJx/2M+J1CW6K6txZ0/fGf5/t8plCjIkZ88I/kd4wRAqwk7e6wA+5v5D7mCphC86I38hKuB7c
	ltXI=
X-Received: by 2002:a05:7022:402:b0:124:abaa:7ff2 with SMTP id
 a92af1059eb24-12a96ed42b2mr1468338c88.24.1774432831155; Wed, 25 Mar 2026
 03:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317-toon-replay-down-to-root-v1-1-cb5c249e15fd@iotcl.com>
 <20260324-toon-replay-down-to-root-v2-1-34e723489f6e@iotcl.com> <xmqqtsu5xaw0.fsf@gitster.g>
In-Reply-To: <xmqqtsu5xaw0.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 25 Mar 2026 11:00:18 +0100
X-Gm-Features: AaiRm50Otokx8JiVYm8U1jY6w88iEBUDw02JEvz7LFAhttSL5diyLVthAaUfyso
Message-ID: <CAP8UFD1zJXnsm7POK32GqEu4xSC+VO5mfzUpM-jn+Nr1qvzEFQ@mail.gmail.com>
Subject: Re: [PATCH v2] replay: support replaying down from root commit
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 8:56=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Toon Claes <toon@iotcl.com> writes:
>
> > git-replay(1) doesn't allow replaying commits all the way down to the
> > root commit. Fix that.
> >
> > Signed-off-by: Toon Claes <toon@iotcl.com>
> > ---
> > These changes might conflict Siddharth's series[1] to add '--revert' to
> > git-replay(1), although resolving that should be trivial.
>
> True.  This round looks great to me.  Will queue.
>
> Shall we mark the topic for 'next' now?

The patch looks good to me, but I wonder if the docs should be updated
somehow, especially to try to avoid confusion in case users don't
properly specify a range.

For example, before this, `git replay --onto main topic` would fail,
but emit "fatal: replaying down from root commit is not supported
yet!". This would likely help users understand that they might need to
properly specify a range like "main..topic" instead of 'topic".

Now it would likely fail without any error message.

Maybe something like the following could help:

--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -23,6 +23,10 @@ instead get update commands that can be piped to
`git update-ref --stdin`

 THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.

+Note that `git replay --onto main topic` replays the topic branch starting
+from the root commit, not from main. What you might want instead is
+`git replay --onto main main..topic`.
+
 OPTIONS
 -------

?

And yeah currently `git replay` is a plumbing command that most
regular users shouldn't likely use, but I think Elijah's goal was to
eventually make it user friendly enough for advanced users with
stacked branches.
