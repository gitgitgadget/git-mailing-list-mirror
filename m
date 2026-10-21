Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792565561;
	b=2HDhIaO5AW9GG4aVldRH0NVg1unoa5/XRkmkvq7HSINJfuUrdyBEpPqs8THad0teCBKF
	 wb8CSkSEjUN/5xSzyEAv8cKjdqifprsFRxqPUJjQPQ4jLctC82yTnUiMQaVCFBqdt7lHp
	 bwQm8QI89rPoEv/Vcr0nVnATBOaj5L3hqRjL07pQT/0FcZoT4gcNX5bInXgsHfA8Z/fm5
	 UiIhbowp2ViWlQb8yAswR8WnwDgYXIHN0o+4KPXgCmQoybF7zoNoxotVHyCH4svyuCrPM
	 aAnzbtm/+pd73FisQa40jBgabPKcIOjOF/3gGu+Xc/p4UdKnnDjsM3VMJx+yh046C9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565561;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=D6OdElzL/s1qqpa4PBtrKfekHHALk78gt6STag272+A=;
	b=rvvma0qpOUKxFTAz0prJOvGdcGtkxVYuBsT7Lty4V8BML2tFFsjLS4Bo6x0AWdQSMDHO
	 g3ELq2f7ckreRqqzCdUDg7QJStTq2Db+G3aaLeVxWK0ksYMZZyIak7IdYOjVGjJ6b7PYo
	 tc3JwUEAoMfdjJz80rdJ0lbVWtBf4w0csoDgipAZbHPBSCl3DHrmRelIXo5mabEBHR3yx
	 50v+ucEW1lLUpBq3OMnVFcpwrLatEixD4JkB7CclxXjeyqwFco7+4NHHs8tAStPen4Srw
	 JGO6hYGe2ui1U4B4wW4eDhD/sHheKx9ldzICg+OaN7/xIcBbscMRizWeKDZzYK1vRXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=fail header.from=sunshineco.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4926606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 06:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4926606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-313bab9cfe7so54910eec.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 23:52:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792565560; cv=none;
        d=google.com; s=arc-20260327;
        b=Za+UuS7cHTTUDamYzh9hOa1nRXLjrLpsDxx54M6HoaGq42W+sn7Dl8SAiBcBIFjBka
         3I6E6GNj/dKTyLxq7bJr5hhUcfQR3TIkBohJwojbTIRlxEwgIxLD9c5DoxD+m13jj8XP
         LR8GkJKMnSPz98MPRWfTuJ33Vg0uYXwr36KtbhN17pBhLBoyvlkly/bwKLGl5pd7XDQG
         /He2MWzuv1BQEDP08AtvriIeKjoIxpdM2RHc9q0sXzzaPfoKfnWRI+bLu2i8D/iaf9FU
         RWzgDJY70n4rdfI6/4kaqU9tHuFsA+53lY0edEPb9B4p6vw3XvNjYk8QDgt+BHz9t6tu
         ChRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=D6OdElzL/s1qqpa4PBtrKfekHHALk78gt6STag272+A=;
        fh=0hnH2vYDv6vpcFd43UT7oWMkEdVCy5eROOyZeipDsQk=;
        b=A8SLitiSzxGk5UDAYT7kKETmQ/OpzBg2BWva0mqlTUrB33HniUEt54u0fstkx7K6LT
         IpSlWKrk2bWapxl1Byl4rbo/hR9kBMQBsCO6m59msfL1dFtai+aEobuRClN2PHq1C+ch
         uv0Xaly6MjiXqIpDnLB+v7ny2senq3F01wv5JrUjFdP7I40PGNmwVDvbSPOfQEHetRmD
         qFB/qnhCwHOI6+XZrVK29jrgs2dicCkKuGy8KSUXvwaA0u0WkckagdE75BRdqiSA/56e
         Pj6oai5Y7DlWmBoeTdpwEsTPlmiQnv1dOdX1J2SvS++oTMIsSqlIA9B7zfEkvRjSTGex
         vw8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792565560; x=1793170360;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D6OdElzL/s1qqpa4PBtrKfekHHALk78gt6STag272+A=;
        b=h7De5pjsYaMKc9ntTucXC95ohumQgXdmXMozHTNGvkj+T8KAC9qCkX3ZAvCJ0XKmSO
         /jhNoZpfkNq2vyVjL59g/IISO4FBQVxwS4yETmubpWLzS57wHsSjFcFcCJQqjwRxa7ju
         Hr0/eVlt2egsJSFziDWmP0bzQ3rMyDHmfqe+pAy4yR24iFzH+jDdR0beZJxv7od45N7c
         cgA0dNvxhldbzgmATEnojFqLX8NxVseytWJ6/LPcLJWGGZSx0i7jv+7JsXWlxggrzQcI
         za30pO4xFoFZUAaeX/b7Sq/fHNLGZi+O05jfBr7edSXjrzG9hGXkJl39XY4/h3Aa/ehG
         ajxA==
X-Gm-Message-State: AFq9FYJZhUC/GbhOiL7jhwgLJLM89GeGI+7L9450SASEYPdAeceZh5zk
	27FBC/4gtOlFEsmDGZGHAJx6UPrqgQf41/z+k6UpUpcvMuMwmzR3C3kyTTQCJ5kQRgZoeY+jJpF
	0WUK+XZbNmHH86Bbb5K+wf9FUoCMBEAE=
X-Gm-Gg: AYBFou1RClAR3GFdr6BD6rGPO1eCIj//E/7Ow4q9QEOtk9EFypg+cIW948QU/TzN0VA
	gZD54xdhxK2jrBD08hQtliyvS0nSikof5zm+PXraFkXHNnIRLpsGCGpwXXyTCeFi7HK8iJkoUXW
	o5nb5Fhdl9EWnkPFaW5vq+PvbIIRhrSM+uJdbz8jV6EjHQ4/EKtuEXUiO1uwzhu7aNg19kvgcJt
	kF/9feLVM9e5QfeoWh4WNxU5OulHG5r8l07lI+ZorWOcsfQTCMTWfxuchtrEUa9DSKWBGgiePzw
	UMUpolLRsnyUQ39Jd40DLkoFEzXorYk5iiEPlj+iei/+Ic/7VCO4GV9Nx8RcDtdbr50rI4/m4St
	KFN++FyGxGE2ng34LKSS//aErLpqDmTCV+VDbhwE3+h0T2Iybt+YRwBb3TP33B2Z1VWss8Q==
X-Received: by 2002:a05:7300:e9d3:10b0:35e:d21c:f33e with SMTP id
 5a478bee46e88-3674ba26154mr3728542eec.1.1792565559985; Tue, 20 Oct 2026
 23:52:39 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
 <pull.2317.v2.git.git.1792512249.gitgitgadget@gmail.com> <6e2acdc5e2578da4e915fd2ac541a776349fb23e.1792512249.git.gitgitgadget@gmail.com>
In-Reply-To: <6e2acdc5e2578da4e915fd2ac541a776349fb23e.1792512249.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 21 Oct 2026 02:52:28 -0400
X-Gm-Features: AclHuK-0wzdlfjAPS29g1qhVzmFnunVL8uJgOSRkiHIhHjIElfQ2U0Kmp6DsU0Q
Message-ID: <CAPig+cRsSN9gY405MGsCQzLuxzBKcfHo2Oc8Z4WB-U3BGd6m_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] worktree: reap ephemeral branches created by
 "worktree add"
To: Jason Newton via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Jason Newton <nevion@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 12:09=E2=80=AFPM Jason Newton via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> When "git worktree add <path>" is given no branch to check out, it
> auto-creates one named after the path. Such a branch exists only to back
> the new worktree, yet it outlives it: removing the worktree leaves the
> branch behind, so a fleet of throwaway worktrees fills refs/heads/ with
> dead branches that have to be cleaned up by hand.
>
> Treat an auto-created branch as owned by the worktree. Record it in the
> worktree's administrative directory (worktrees/<id>/owned-branch) at
> creation time -- the one moment we can know for certain the branch is
> worktree-private, since we are the one that created it. "git worktree
> remove" then deletes the owned branch once the worktree is gone and it
> is no longer checked out.
>
> Ownership is recorded only when "worktree add" itself creates the branch
> via DWIM auto-naming; a branch named explicitly with -b/-B, or one that
> already existed, is never owned and never reaped. Deletion is
> unconditional (even for unmerged commits) because an ephemeral branch is
> disposable by contract: to keep the work, pass --keep-branch, or anchor
> the commits with an ordinary branch beforehand -- a normal branch can
> point at the same commits, after which reaping the ephemeral ref loses
> nothing. "git branch -m" updates the marker so ownership follows a
> rename, and the branch stays ephemeral.
>
> The marker is just another per-worktree administrative file, so older
> versions of Git simply ignore it (they keep the branch on removal, as
> today).
>
> Signed-off-by: Jason Newton <nevion@gmail.com>

Sorry, I may be missing something obvious, but this message never
explains why we should add all this additional complexity for a
use-case already directly supported by `git worktree add -d <path>`.
Specifically, worktree's --detach option is exactly what you want when
creating throwaway worktrees, even "fleets" of them (using terminology
from this apparently fully or partially LLM-generated message). If
your tooling or agent is not using -d/--detach for throwaway
worktrees, then the problem is fixable by modifying the tooling or by
teaching the agent about --detach, without bulking up the git-worktree
implementation unnecessarily.

Moreover, a change like this which makes the new behavior
unconditional is certainly going to break existing tooling and
workflows, thus it will not go over well, even with the --keep-branch
escape-hatch. At minimum, to be acceptable, assuming such new
functionality is even desirable, to avoid breaking existing setups, it
would have to be opt-in, not opt-out (via --keep-branch). But if it's
going to be opt-in, then you may as well just use --detach to achieve
the same effect.
