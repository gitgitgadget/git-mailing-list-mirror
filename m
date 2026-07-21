Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9801739EF0F
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644131; cv=pass; b=nhZJYFj76Gvm6FGKPm7FxmH+fE2sykVsIIeb60/qP+WmLo1hf6ZUCnxR6+57qxHOnAWXDCJdh6mEMM3oJvKHl1ui2k8xx2llT/MmokRJ2sfmIZBQqi3KGjj11oDt8AdhpNvLQsMIyGrSEdD9dRH/TE/4V8bY12y1z+vLXUaXyeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644131; c=relaxed/simple;
	bh=CY/sa/r5tB2+rhiXZriFA0cTY2vqQHcTHyDQhHi3u8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eokyjgIEuFUdpQ/YrmCvzMK90MRdY38S5AWKmoKNMRt2SQg7TduXystR11M6yZXK5n8bmMEEbTjLV4XUsVD9/Q4TXN7UBPN/T7Uq+4OYw6iNxfE/KjsxFdmCydbO/aLplUjkCSTlwj6MJ3bi67s+6qxr95S1yNIWtZGourg+Ego=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTBWufqx; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTBWufqx"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e58034d05so3451734a91.2
        for <git@vger.kernel.org>; Tue, 21 Jul 2026 07:28:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784644130; cv=none;
        d=google.com; s=arc-20260327;
        b=Wty1NiqpQcSuMwQFbyw4TVh1ARkocP7rGl3If2rBEKEGRFRqwRChSykoK85ld1pvpa
         qEJj5ylHxEzGObeb23av1E8wlXPp5BkflqU+19r5/1MWBA+Qok/C1v3OUSswxOyUjRY3
         GHEXMXdT2BzpL/r6/asGH5uH8UCzkhnFkmvwTwhjhdyHfPrxflVsW/yIjrcM2p81SJhU
         MUc7SkSmOd2bHRV4WtFIs0tE35PgTDoyQamJiKF4VVqLMbivXIcYZfrdyc0P882VoyDU
         5rnXguHnVqGmWYmeOZJm93Axr4MP0kLjL7rguINuQcnaZ2+DWDY9WkhfcFjLI/sfy1/c
         8SBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/e+hdiRb0i/dbSh4cpURzc/r1mn6pdjsf67zGuUfJW8=;
        fh=Ox4D5aCb0Wm3NuWmIZhbrD5IUgm6JPtaEE6xbKungY4=;
        b=Z1SS30BjJv5XdEfqyCcmmyFn8avXNLLWaZFAHLKCJjogVlTe4uZ4BJbmjqqbzDeeEA
         vyAg7r4525Ci7V+QGXvu+166PWKOI71iTxFRLgfAf09cIzjdjUwc8E7XVkyZFUOE8i/y
         wS34NMdThP2b38rE5WRUUsvTdTHoeHYrRmyg6cl3dTKmG1lVyIRH4JecgE/dPQaof8wA
         UBJAmqIk57I+tuXrZUeGF4BOk28l2pAvk1Q7AG73UpriF1xsg8PvnEkvIgAgpKhn9bax
         VMQVhEKbiLA8lLgtPHKXZ95ORm8MiXORCgI0cnL1v/NLlf4QJBVFMBR67n/2bxwEZ/8V
         ajEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784644130; x=1785248930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/e+hdiRb0i/dbSh4cpURzc/r1mn6pdjsf67zGuUfJW8=;
        b=dTBWufqxbpYLps2f2FhzZB8fz2l6kvrJ0xUX0jM6fCTovBI59RhR/2iTtDDygrtmIm
         VxOMOt6jmiNiVTDEyXPg1z+gMWGsn9BfSXRyrcK8YUwczKZh2dRNEfsUOgncTleU8eN0
         RyNpVU3HzldLtJnzwzkjeoTXZFTTJuZYiYlfarpnRqaguoVDYtMzx+ubjPikyutQQPg0
         nBhPSN0IwCEGIA/ugv+JcfEIzp5dFbTtp3Ggu2uKxtJTSNcyAq8THUoethxqY/uOgvek
         7NQLAcb8wA1U0Z8ahwYWfLxPvq/XSJwiWVj4xX2FmHNTH9bZtE+BjG4TBemruDGGMRf6
         5tIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784644130; x=1785248930;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/e+hdiRb0i/dbSh4cpURzc/r1mn6pdjsf67zGuUfJW8=;
        b=LpVtF+cSQoge1DSGYbcQ/gulEUgmIvpqEiKPMHhXVONxIHe8Pcqy3nSzFOg2Byof9p
         vSHHgkYzSqsI0ui7i+uReYhJ8l/5gS+YpO6l0/QFPy1zhyZ0BIV6BgSLQAxMsct49HDx
         IhQW5+rCiap1eSLf6nV2vplflMsdOyUOBee9AFd1b+T9gvj6avK2wUZCj6jroNRtRf2Y
         gHddsUHloKahDY2D3GDgNQSzpGzsvem12VhXMtmIWFQEXUZRb5qKCTyVhCcne4Qt/e6e
         JPFkUhLIIR6WTJoAG2LDj7NFkw/INAkL+cxwex19xHiYsxJqlZz/ahWXrqlAeSlEyVLt
         Zf8Q==
X-Gm-Message-State: AOJu0YxJNedMCoQ8jvFAEE7Hr198Nvh+WmSDycbjKK0Qx+o0IrgrugLn
	G8XnHVKTCCG09MMYsMtz2eHDyBRc8WX3WW07so8fRb4B87MzXOYSKxf0ALby4taf3aJhCVKDBL+
	ajzUmZe5Anu75Jcrua8ekw0Zi31Rg1eE=
X-Gm-Gg: AR+sD12NA6EFGxwnY2tz6vMVZkreSbpN4HeZKvTXOr76oAgBCnLYIDDPjWZJ7ErCUs1
	sb3WCbR3Q1KGo3P5EvpSQelgYXTKWHnkzVpZaZNv3km40zbmvWwhVH6p1410gphanXHnSTGeL3W
	WHwWIZEyrok8xVZKisrKDq5ZwHK5u7L4fPGInr1CJzFJLvOi5JZB+8Dnwsyo40ajoRbb/9UPmO3
	CQEgTzfgrDMyLeO3pONUZa/XeMVCsA0USTyCdYeaBTtf0zavAuRcnA2dXTdiP0ixAXej3tMKrmK
	gYWJR2HCNMKh0/hi+Ur9yDWejNsa0wjdv+IgtiFgEXlqOs9qRTo5JWXxgkLFogMh2S4zcEcYAlg
	q/Bu9mRuolzK5cPErPkiWtICx4NKvcU1KlM9U
X-Received: by 2002:a17:90b:1d0a:b0:38e:895f:25fc with SMTP id
 98e67ed59e1d1-38e895f2bf9mr6130671a91.38.1784644129875; Tue, 21 Jul 2026
 07:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2358.git.git.1784538618.gitgitgadget@gmail.com> <pull.2358.v2.git.git.1784624306.gitgitgadget@gmail.com>
In-Reply-To: <pull.2358.v2.git.git.1784624306.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 21 Jul 2026 10:28:37 -0400
X-Gm-Features: AUfX_mxx7Ejl_DAQuQK_5FIQNm90I5APNhIiVQNpkccZSpdHmn7sj8YZ2fyPCXA
Message-ID: <CALnO6CAY2x-adAxSXW1f_+OHjV_tVhLmkN7D+wE39rj3wc8LEQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] remote: renamed remote push tracking
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Harald,

On Tue, Jul 21, 2026 at 5:08=E2=80=AFAM Harald Nordgren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Keep git status showing the push branch after remotes are renamed by find=
ing
> the configured remote with the same URL.
>
> Changes in v3:
>
>  * Revamp commit messages to clarify motivation.
>
> Changes in v2:
>
>  * Clarify that URL push destinations already work and that this change o=
nly
>    restores their tracking information.
>  * Document URL values for branch.<name>.pushRemote and their @{push}
>    behavior.
>
> Harald Nordgren (2):
>   remote: pass repository to push tracking helper
>   remote: find tracking branches for URL push destinations
>
>  Documentation/config/branch.adoc |   2 +
>  Documentation/revisions.adoc     |   3 +
>  remote.c                         |  36 +++++++++--
>  remote.h                         |   2 +
>  t/t5505-remote.sh                | 104 +++++++++++++++++++++++++++++++
>  transport.c                      |   5 +-
>  6 files changed, 146 insertions(+), 6 deletions(-)
>
>
> base-commit: 48bbf81c29ca9a4479ec7850fe206518682cdb2f
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-235=
8%2FHaraldNordgren%2Fremote-resolve-url-push-tracking-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2358/H=
araldNordgren/remote-resolve-url-push-tracking-v2
> Pull-Request: https://github.com/git/git/pull/2358
>
> Range-diff vs v1:
>
>  1:  fc70895732 ! 1:  b1ac49de87 remote: pass repository to push tracking=
 helper
>      @@ Metadata
>        ## Commit message ##
>           remote: pass repository to push tracking helper
>
>      -    The push tracking helper currently only needs the push remote. =
However,
>      -    resolving a URL-valued remote requires access to the repository=
's list
>      -    of configured remotes.
>      +    The next commit needs tracking_for_push_dest() to inspect the
>      +    repository's configured remotes. Pass the repository through th=
e
>      +    existing callers and mark the new parameter as unused.
>
>      -    Pass the repository through the existing callers and mark the p=
arameter
>      -    as unused for now. This prepares the helper for that lookup wit=
hout
>      -    changing its behavior.
>      +    No change in behavior.
>
>           Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>
>  2:  ff645b2159 ! 2:  6e924a7fec remote: resolve URL-valued push tracking=
 remotes
>      @@ Metadata
>       Author: Harald Nordgren <haraldnordgren@gmail.com>
>
>        ## Commit message ##
>      -    remote: resolve URL-valued push tracking remotes
>      +    remote: find tracking branches for URL push destinations
>
>      -    A branch may name its push destination with a URL instead of a
>      -    configured remote. This is useful in fork workflows, where the =
original
>      -    remote is renamed to "upstream", the fork is added as "origin",=
 and an
>      -    existing branch.<name>.pushRemote continues to contain the fork=
 URL.
>      +    Git already accepts a repository URL as branch.<name>.pushRemot=
e and
>      +    can push to it. When a configured remote has the same URL, howe=
ver,
>      +    "git status" cannot show that remote's push branch.
>
>      -    Git can still push through the anonymous remote created for tha=
t URL.
>      -    However, the anonymous remote has no fetch refspec. Git therefo=
re cannot
>      -    resolve @{push} to origin/<branch> or update that remote-tracki=
ng branch
>      -    after a push. The push can succeed, or report that everything i=
s up to
>      -    date, while status continues to compare against a stale trackin=
g ref or
>      -    cannot show the push branch at all.
>      +    This can happen in fork workflows when the original remote is r=
enamed
>      +    to "upstream", the fork is added as "origin", and an existing
>      +    pushRemote value still contains the fork URL. The URL still poi=
nts to
>      +    the right repository, so pushing works. However, @{push} is una=
vailable
>      +    because Git does not connect the URL to "origin". As a result,
>      +    "git status" cannot show the push branch, and an up-to-date pus=
h can
>      +    leave its local tracking information stale.

I'm a bit confused about the problem scenario here: if the pushRemote
value contains a URL, then renaming a remote has nothing to do with
it, right?

And if the pushRemote value contains a remote name, then renaming the
remote should propagate there as well, right? (At least, that's my
recollection of renaming; when I have used the GitHub CLI in the past
it has worked pretty well in that case, but maybe they've changed
things recently?)

I do think the URL<->remote matching for user display is a nice touch,
so I'm not against the series! Just want to understand the problem
statement well. Maybe I should read over the test cases, or you could
suggest a "how I hit this in the real world" recipe? (Explicit
commands are easier for me than natural language in that case.)

--=20
D. Ben Knoble
