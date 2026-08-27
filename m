Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DE53112BD
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 05:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787808006; cv=pass; b=LvJzXwKMbmfVsRADQsr5EklvjJ6wxNYo6I2jk1oCgKlebvoaat8ikaFr9RwRX79uqXv5/Y59BpttmI3NydXX/Z59jAkAoY6sD/Zl+lbDsHBVAjgUTTYI1X517WufbHOHIkjjbFAUFpkZNcAGq3zR+jLcmyApjhjcsGXUHOF7z3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787808006; c=relaxed/simple;
	bh=YJNTs366ZG+e6bRMYjgR3LrpNmK/M8B+2U1h166YG58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rw85CPpc77BcFxY3Tj2L0Y1lC15aZWYMU4BHHGvPYGPn2a+nZJZDrPc72NXvfJMIuibPGkys3lhcsGGnTlyDTyubXoQfGwOn94Td/O87xP1R+AFWh7m+SK+fk6byV9gD+PWRhWoQHkM7R6byph+Tu7j++Wre9hCwhUw7TBTRd/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al44xzrh; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al44xzrh"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4ab47c40e7eso222294b6e.3
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 22:20:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787808003; cv=none;
        d=google.com; s=arc-20260327;
        b=B3ClsdheTtwDQruApdU+EBmCPwyZm4H0AJEvYzQRAKQhGmp6oJRRhgPp2MoytKoPET
         Tlm9jSK1cqZXqToKxSC0dCKRJDggrHKlD5lx40SlJBiAcZV/z9J2mSH6GXQ9tjPDVyXx
         JrNfYPqm5UwxgUax47P9rXz/begzlZ7+WRBQzJYxJyCrHJ59IFtds4Gmmqb9MDqV7T8x
         S4hd3TaoUVbQXtPUnnks316Di7D26MHuZdd/pwxP1u+g5GZX/HVdUuzw+AzmzNYsYZ0F
         b4urrBI8Lw81AQmJK/mTcJhE5m9k2BhvfzdUcYQ2LfXA27NvryF8lsbFZUmS9HYUu9FF
         l1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sR7Riw4eeqE8jniJNHvW9XSHH8+fAWv73gKBfu1YMR8=;
        fh=Ox4D5aCb0Wm3NuWmIZhbrD5IUgm6JPtaEE6xbKungY4=;
        b=UOHsU4qoRoPd2ZAkKeiY4O1XsrtxhirYIsuJc/UYeIdMzq59iI7vOlu4zH8nauWBzU
         BWZpk7SYPFs2B4wS5pgR6AAvPlIYJgbHjdNBoFF3G1UiDAFZdLyYfq+qhAgyrzhWbb5w
         2uIfZOGOvHMtfS+U8u+6WsLfcpbXv84vnlh2h7r1jUUE+aqJDfHmA1JzGC/SELE11lCe
         bc8imvkvg0mVEfJMXJtivcQdRGkh4NdSVPL4NzmhvCdx5CoNDsK0tkqnE09relZEWqyE
         nBi2pnc+2O5S3DTW93xKAI2aHZE2+cVR5Sb/AR6q7G93CCiG3zVUeSYCzMqRlu12MY6p
         CXmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787808003; x=1788412803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sR7Riw4eeqE8jniJNHvW9XSHH8+fAWv73gKBfu1YMR8=;
        b=al44xzrhUV40UFuHxvLI2KTTqihx8atJs5Xil28BGQL5Qdxu/dF0AQw/Mg025q3Se3
         ZAAHVVW34ROehBrgAHx1ZsFMo5uOidteBFfn2LlVhRv8tnddku3+8tebtA8TAYeJllXv
         UTOUqgiNZI8T77PwyXLvTzPjqkAx+JEqDqFD9eiCFfMHPBFcfz0AhhVkhxKEUYw0XLxJ
         cCmxZ5P4DOmu8roQAChzTsB4VUAGYQnJcZr+AafEWz1d7knXYKr92SnwvmfGlkKHvN/9
         UzMrnKR/+vEHrXGLaL3gBMkDNbnHPYOKRg9d+ss4RfKZiup8xtwAWtMFZ0a31jYFC8xI
         FwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787808003; x=1788412803;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sR7Riw4eeqE8jniJNHvW9XSHH8+fAWv73gKBfu1YMR8=;
        b=H+F0QjyaHoGPYlCMLfeDbGCzr4fkh79DsJivPLA/pitvRVMdIgaO0tHKogRUYh2MNI
         Ea6YJv3WSN/dNlkiQhvILvbBtRfTSjFGTVjAW8Sysi7wJbrAJEKnAhzIjf494RoeP6JF
         GsjHgYyuBykpq6/aLuDVVJIn53fAPhRNliu3iRirAJW3aMVPu6nzmvZ0Uxl3y+cwiU9y
         3jwo9Qgrj3UVT0rmpxLAxEbbmVqtkvb8Ewq3ZuX1mHUPRXYCaUbye7n+oY56TRsJHIzw
         p/EI1iBhUI47o/x8/3HWvckNXNdl9wVdsg99qN6Ml0CI7Y44+tiy02W8A3cW79rEMzy5
         F1ng==
X-Gm-Message-State: AFuF++k538hexOQTGRRRxUswIJlCRimSYvPBv50Q2WCiOKclZJq1AwP5
	1vJ7JMhoUTW0i46XrG+zTkvCfDRM9N5t5qIEE6mlo+cqbrEtovpmbBCLgEWQqeBnfIJEKRrluE/
	C1pso+I99mVowCjsM4CSE6gVOxdsawXg=
X-Gm-Gg: AR+sD11wHOENGgr5e0WCWWCmGGzE756GaLDOwnq2uujED0lQoqCshuU//n4/d/x2mWP
	nloKmkxu1dDkei7xiyz6QRCyQSZlHTYxvRnlp7wSA2cc/tkKTZ9CP9n789ORW6PxYfyAF6tWicC
	rnTxSwlVN0d4bCu1q+RjjafWSzf0lLLevjrw7Pv3dloKQ7mjyQWG0DC4D3VhwUbzyybndLSvOP4
	cG8zwpuHoLRZssestWPlYvI+tcBZ1S8N+U6D9zTFs+vRCfWEFydbHimoCv2VYzdSQx3rVPpsD/+
	TrVX5RxT+c7eYFQKUKw2EuNIqafx50wQM1exFO+kg4ee6ELpyoHWpm6ziF5N7bqQYMb++va1ULM
	vTweaioyalawlJ0koPiAaa0cLiRGwl/g3rhei1wVdCzPGRndgMC+4ew0Y+qOYcA==
X-Received: by 2002:a05:6808:17a4:b0:4b2:8dbe:b596 with SMTP id
 5614622812f47-4b3668b9b23mr12069038b6e.2.1787808003388; Wed, 26 Aug 2026
 22:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2365.git.git.1787693117.gitgitgadget@gmail.com> <d3d7a06e3d6f0c7adf9739ca496ed4012e261ac1.1787693117.git.gitgitgadget@gmail.com>
In-Reply-To: <d3d7a06e3d6f0c7adf9739ca496ed4012e261ac1.1787693117.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 26 Aug 2026 22:19:51 -0700
X-Gm-Features: AcwNN1Uk8xcE_M81OIVfy5OyTCW9wGujLJ5lvLlUs1_XDNwDGYhD9f8ADhnH3us
Message-ID: <CABPp-BHQvUwwA6v+5rq9=8iUWavDO1ScMVr-3ok4Zm5r_Bp2hQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] branch: protect local upstreams from -d
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 2:30=E2=80=AFPM Harald Nordgren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> A local branch may be fully merged into its own upstream while still
> serving as the base of a surviving stacked branch. Deleting it with
> "git branch -d" then leaves the surviving branch with a missing
> upstream.
>
> Use the existing stacked-branch protection after checking every
> requested deletion. This makes multi-branch deletion independent of
> argument order: a branch that fails its safety check remains available
> to protect its upstream.
[...]
> diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.ado=
c
> index bfdf459329..5c2a3339b2 100644
> --- a/Documentation/git-branch.adoc
> +++ b/Documentation/git-branch.adoc
> @@ -102,7 +102,9 @@ OPTIONS
>  `--delete`::
>         Delete a branch. The branch must be fully merged in its
>         upstream branch, or in `HEAD` if no upstream was set with
> -       `--track` or `--set-upstream-to`.
> +       `--track` or `--set-upstream-to`, and must not be an upstream,
> +       directly or indirectly, of another local branch that will remain
> +       after the operation.

With this patch applied:

$ git init -q repo && cd repo
$ git commit --allow-empty -m base
[master (root-commit) b9a0882] base
$ git branch A
$ git branch B
$ git branch C
$ git branch --set-upstream-to=3DA B
branch 'B' set up to track 'A'.
$ git branch --set-upstream-to=3DB C
branch 'C' set up to track 'B'.
$ ~/floss/git-review/bin-wrappers/git branch -d A B
error: the branch 'B' is an upstream of another branch
hint: If you are sure you want to delete it, run 'git branch -D B'
hint: Disable this message with "git config set advice.forceDeleteBranch fa=
lse"
Deleted branch A (was b9a0882).

So, C had B as an upstream and git did protect B from being deleted.
That matches the claims above.
However, B had A as an upstream and git didn't protect A; it deleted
it.  That doesn't match the claims above.

Verifying:

$ git config branch.B.merge
refs/heads/A
$ git rev-parse -q --verify refs/heads/A ; echo $?
1
$ git rev-parse -q --verify refs/heads/B ; echo $?
b9a088270710b2494f5fa0668fc7e81a40aebd35
0
