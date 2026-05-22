Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834C335E956
	for <git@vger.kernel.org>; Fri, 22 May 2026 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470390; cv=pass; b=eSOZGGoMq8ylD8nE/TVzCjWuQ6dwjnN/cFFHWjasYlaNYpP/PtABx5JbvwPBID/7wqrRm+3rSYRgP8/WhzGT3kwtgH83i4AbiibS7boA1J45r55kojVtM6qF/noZ5RO4gzEZhJDnODch9drLlKoK9+aWVudKYggiPWUXmDFQDxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470390; c=relaxed/simple;
	bh=ndoaCBUP+4jWI1X5x53E+PVC+UPc5Iu9uyZoXoeEcd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e68tMfwrqBACVII1jcA+yZQcehiVSzRcaLCI7dO2c4UMX9R5p3ITsisWn1FvrcTmDYS1O3qrTmfRdIDp4sS46h3scXOTSBFi6ScgJVTlyZC0cAR7frOT6L/8XjNaT/YM6EMODHuRFcokyT5TZe4icMVVQqK6L1mDFfieLZMTgeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzAj7ANv; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzAj7ANv"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e5fd39cf11so1210877a34.0
        for <git@vger.kernel.org>; Fri, 22 May 2026 10:19:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779470388; cv=none;
        d=google.com; s=arc-20240605;
        b=jU9VkqQY14sh73vCP1qQkfTO7qGsOX0dSnw7c6EfRVCa2+wfVO7zAdq99t4s/r58YT
         OBWJZAVw2Yns82NQc9s8sIezpKe5E0OayOIC6pIZlQeJ+RzWj0uheS4sOMsxuanFDjFk
         ouzs+QQy2bkbnatPgAYa4K7teod3aNuV269HG+rKMMDX+AiPMaXB7mNxrTKjRODum2bW
         QgO+yPXplKM06Wwhnsli5z2KJ8SUxJLSK86z7Ht34tKhGbuHLe9NEsilCkjE5zZUjtQ2
         ySxiNJqNy6vwmsN+lOh/MMnFvmKP+1s5ExPTQ5mnbVz4rRltQSCUHByjcMMK2o065WNZ
         l2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2SAYvHKvORqWIkKkOAYTRyA/XqM5o7P5zyzxJJih24c=;
        fh=jRCRWpioP80TaZgmcl1MXYevjzSmp61hSiN2MuMM/1k=;
        b=MVdpwfI6/mluSTvWOv4VmALz+b+FRO4JS2zhysakvfzvTRvyh8a7Mc88fnmqGDhiY5
         2oHW/ELOuhZGAjVBJODLfIhoAdz5WUYwraPmFFmwKnZ5so6ZAWWrzRe7659x6lI9mmaM
         Phba7PY1+DEvrX268H14S/eors9TBxinhXf73OIJzhXdW352JRGQasv8EWBWaq5U6cQr
         aU2/KmYZXBe7DKK0TD40AAh9eeABl4184p6Yp2lCCAlYxNVOziBeYcxOHA1FriXxreeL
         9Zk6RcvFbldzy3fA09hzNIPX7ckfRASpd+e6+lU4NO9tObcJY0WNXEWQo+wgXEmvZezH
         oSRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779470388; x=1780075188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SAYvHKvORqWIkKkOAYTRyA/XqM5o7P5zyzxJJih24c=;
        b=PzAj7ANvG6PIkCsRCBzYPgATS6UHkchW4isodFM1Yhrfok90xHmREd5zRL4WXxXlDk
         MiZFiVEAmmZ+YDlR0aOi/kV8/7DvIRrr0GS7Uyh6uMHjJY5tkiRTxg706SJ2YoK903Vy
         h6kFhrj2c2MDzZtEB1Y541luhCTa5rERgjKUxmNmTxFYB+Zk+vwg5T124fE95SjRoSv8
         z2yMPTJmENBo9YpV6FnpAqErjd9Fj1s4rnkCnsG6UDI+e5Jsf7Ad1gR6s0vJVcmmZAR3
         6lHfhGe4tjQmPBKdYFHTf0vH5UUNwEBd09+vyf16vJIhgfmPP19t9ZKmHnj3D3MpKIvX
         iI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779470388; x=1780075188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2SAYvHKvORqWIkKkOAYTRyA/XqM5o7P5zyzxJJih24c=;
        b=EFgns68XUcOBx6LGw+1wV/QwFu1mOZ3DTmQff/cq6CwXXmH6UGTQS2evahOT4xLO3r
         Ua+rweMubun+Ww9qlRjR5hNQOW4QiJIRsylxdjZYq6oSbChgpTTcUCXmerzLc+tzDrHx
         ZV5no/u1ytC6H1vQj6gNysFkEwt8D5/4oSE1aWtjOAKub9fHNtRi0v57oOjh/ef1teXG
         2J4jILGlt+TtGoC/C3Dwu0JxUy+O0hcf/hG/rIxB6Kgy7cnQVeq4t4d7AM+0EiFjUrKS
         HWkrhfrvbthqV1m5AjvDsWSeJ2ZmpPnQ52uRMkVlKCcEMEb+D3qpmPXQNB06jnTc/feZ
         TMPQ==
X-Forwarded-Encrypted: i=1; AFNElJ8yyvVKeRnok8S+RtUEU/i3jX5PXNAc097gZFoCjtj4vI26GS3EPoYbOK14rCLzCMRq2us=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ8ODQ3mT+uYFaskmWZcJguXQ+6XjQ1El9HghOjHTYsENNINVU
	Nf7Va0ERCaBzPz8hz4AeNhDiXVTZorvdRTrisMS9PALznxeNdG1KRBNT0jj6FoXtPYx0Mph8wQ9
	3JaNe7wjl0WUN+l7EPyHMmRnlx8bydB0=
X-Gm-Gg: Acq92OEy9Z+e7A66aQKf6xTm6uqPdi2Ky50UB21t9mb9iEwAr+tiJwgn6qLIZOJTvCB
	FmVZcQGnjt1QJc12IWQnxmC2dsnenXvF7W+j8znqK8ge901YWWHWLvbOmskA4QKBKwhKyJkSoNk
	au4xov6XB0+Uc4/i2CysMBq/J4FSfBVJtWcxWIaehoQDHrs2Rb9Ev8V3Dd2JmnJyOzR56UF0aco
	PFhpopVY5UoUujf2Qb5PJ0hVmiutR9AzSst5+Vp9m5dy/dx7A4SsZP/sXUWmFutepWiG5kqppem
	vM1be7Ub2y4rHinrbbi2dutrhXQNkZWuI6iA0X8Uj/DjU+/3MO8=
X-Received: by 2002:a05:6808:4707:b0:467:14c7:a8b5 with SMTP id
 5614622812f47-4854a0df7damr2669369b6e.10.1779470388243; Fri, 22 May 2026
 10:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2120.git.1779415884.gitgitgadget@gmail.com> <xmqq8q9cui5c.fsf@gitster.g>
In-Reply-To: <xmqq8q9cui5c.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Fri, 22 May 2026 10:19:36 -0700
X-Gm-Features: AVHnY4KuXZTCywvfCLFb01MHg1AMY9oJTumHQE8bV86kvA7mGk6AezjeH8tuV3Q
Message-ID: <CAC2QwmL3uEo=kpCMYOnCJK-XbkUqOWAMA4MxdnL-F3VzH_ayog@mail.gmail.com>
Subject: Re: [PATCH 0/5] [RFC] diff: add diff.<driver>.process for external
 hunk providers
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 10:29=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This series adds diff.<driver>.process, a long-running subprocess proto=
col
> > that lets external tools provide hunks to git's diff and blame pipeline=
s.
> >
> > Over the past 18 years, git's diff pipeline accumulated many features t=
hat
> > operate on hunks: word diff, function context, color-moved, indent
> > heuristic, blame. External tools can replace the pipeline entirely
> > (diff.<driver>.command) or select among builtin algorithms
> > (diff.<driver>.algorithm), but there is no way for a tool to provide
> > line-change information into the pipeline. Tools that understand code
> > structure (tree-sitter parsers, format-aware analyzers, tools like
> > Difftastic and Mergiraf) must bypass git's pipeline and lose access to
> > everything downstream.
> >
> > The protocol follows filter.<driver>.process: pkt-line over stdin/stdou=
t,
> > capability negotiation, one tool invocation per git command. The tool
> > receives file pairs and returns hunk descriptors that git feeds into th=
e
> > standard xdiff pipeline. All output features work normally.
> >
> > Zero hunks with status=3Dsuccess means the tool considers the files
> > equivalent. git diff shows no output for the file, and git blame skips =
the
> > commit, attributing lines to earlier commits.
> >
> > On error or tool crash, git falls back silently to the builtin diff
> > algorithm. The feature is opt-in via diff.<driver>.process and
> > .gitattributes; unconfigured files are unaffected.
> >
> > The series includes git diff-process-normalize, a built-in tool that
> > compares files line by line ignoring whitespace (same logic as "git dif=
f -w"
> > via xdiff_compare_lines):
>
> Interesting.
>
> If the goal is purely to normalize content before comparison
> (e.g. stripping comments or canonicalizing formatting), we already
> have the `textconv` mechanism.  While `textconv` is a "one-shot"
> per-file process, it is significantly simpler.
>
> I suspect, however, that the primary focus here is to allow external
> tools to provide structural alignment (e.g. for AST- aware diffs
> like Difftastic or Mergiraf) without losing the original content in
> the display.  Unlike `textconv`, which transforms the text the user
> sees, this protocol lets the display remain identical to the source
> while using a custom engine for the line-matching logic.
>
> If that is the intent, it should be stated more explicitly in the
> documentation and commit messages.  The "whitespace-normalize"
> demonstration in [PATCH 5/5] is misleading because it's exactly the
> case where `textconv` would be sufficient.
>

Thank you for looking at this.

Yes, you have correctly identified the primary focus. My intention with the
whitespace normalization example was to provide a kind of "hello world"
diff process that would showcase how such a tool could interact with
the pipeline further down (i.e., blame vs diff output). However, I do agree
that it is a confusing example because it seems to clash with something
`textconv` already provides. I will update messaging across the series to
make the true intention of these changes more clear.

> I am afraid that the use of a long-running subprocess for every
> diff/blame invocation adds significant complexity and overhead.  In
> particular, wouldn't the `blame` implementation performs a
> round-trip to the subprocess for every commit in the history?  Even
> with a persistent process, the overhead of serializing and
> deserializing the entire file content twice (old and new) for every
> commit could be prohibitive for large files or deep histories.
>
> So, I dunno.

I hear you on this point. Anecdotally, my measurement of running blame
on diff.c:

Performance:
  without process:  0.57s
  with process:       0.67s

Blame attribution:
  without process:  726 unique commits
  with process:     721 unique commits (5 whitespace-only skipped)

Skipped commits:
  0ea7d5b6f8 diff.c: fix some recent whitespace style violations
  2775d92c53 diff.c: stylefix
  4b25d091ba Fix a bunch of pointer declarations (codestyle)
  a6080a0a44 War on whitespace
  eeefa7c90e Style fixes, add a space after if/for/while.

I was imagining we could potentially optimize performance by extending the
protocol to enable passing OIDs as a capability so tools could read objects
directly without needing any serialization/deserialization.
