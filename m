Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795760154;
	b=xOrhhkWKB0KF8bVtTopDxr4c1DdIzsp7BnO2EI8etXOBSKyycK4Rb4LYsJTCmojHxZWR
	 +7NhDygsnlEnLDzo6cXUJj/W6SO8Iegw2NwcEyWY0AXf1FZcTYBG0xDY/sekuphCOyUA2
	 6lWp499HWg5CMV48qTE1+ewxujIkCHbgOV3Wy36qNWFLMy028CE6HARGOh8UAEJ7Jf5Hp
	 HxTlXkcpApDd6FE2cGQ+9KwDcUD6TH0Jpb1FbCNtsetJ4mi/ZkrG+fRHHXhQCt7MYtKtJ
	 QIVvknBDYARxeyfj31We4PtGsTxDfjZUto7nUrqrnGyx+O4MMe06P82JSfvIyAczd3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795760154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8h0aimgLaC2MQsEQ43x/tCgZTY2ycZ6QbIoEGdJwlYo=;
	b=jXsSc9u9K3W1Z5EDvhWKT96Nr6bPYuDfkbb2N9TSenU8Rut1mY4M0RzYludtqU22cYG+
	 rqGuUEeBWfndelPVGfTHrfeY74AU+beN2ReT2JzQGqUgrCmuZVOLoW5gkvdoEshb6lnfB
	 3oP4vk1VHyHHC3y2vDN1HkcPKWJd/eDu/2Xe7mD5572bL2IZEH65TVRSZMPSWV89B/um6
	 z+Fj6Si6dy0WU506iSS1ktt2ZtYn/7oLBxqD/U0k7N+mq94jBK29d5um51aPJvN/+t9y4
	 fxZoN1lqrYMLBQuKkehCn9bY+B31nUJ95PGToSYq6wUynK0KyUXRMaZNeNvIE4jCH7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cqDYkQZE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5878606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 06:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5878606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cqDYkQZE
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-9212dac247aso78511896d6.1
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 22:15:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795760153; cv=none;
        d=google.com; s=arc-20260327;
        b=fJUNmcMBr4aUgZeCApxULhMTKqZUaYfVWdGxEg+UHCoIzRHym+1uhp1JU1VCQLo9Ay
         fyrBrfI1M7CB4ZjlHN4I/lP5e/CzN0gozEGX/62qEnXp2CCcdS0ckd5mVYaQDuk5RcuA
         xp65lq6AmaexMWZhHq1UVpf18A9ExrGTzDeu1vU3FNp2wI/q+u9/aAAiGPf3nE0rKxOX
         L18io6yxIivTtKDlMRTg/FL7S9GZppRrHWBOpES/fy3UtHNMhffqlnJitKI4qTCoB2e0
         bvcacsIG6+a5TV0bTcmxcL2iSBZD5QsmUSxruWxmZNdbnJU5wCJESbnubVtHOCCiQQoc
         PXzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8h0aimgLaC2MQsEQ43x/tCgZTY2ycZ6QbIoEGdJwlYo=;
        fh=+1EtFqsKhPI27NL3/lYLVmBD7Hm5XLwDbDggbW83/uY=;
        b=hnOe2jykwLN0BleRuHWq9WWNbtyEuQoO9VVcXlwqWOYq4Dg51MPOrZV8QJU5voZBL8
         nK++2XtvvWtYbRJQTl3j7QSEDcfyubt6bl25Z2vfO93L+MiORQhVtXfkTl55+MkwrtVo
         bGKWWbj2o3XEyy/npyschq40+JYlHCr4DQUN3mQm4rFkMHX/YAwKeDaTgXgrRSoqSRdL
         cQI0RWYBJpo81kKbiFtyXAc7V7CbzkS+JgKkUjVKcGWoZw7NXr5eLE0/qkMtIjUvS0gb
         wAYmEfM5xJwGfcUcOIyaANfSCrne3LcMjyRtfbf32HLX5rBibYsnlAsdSJKzGb1P+Rm/
         MrbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795760153; x=1796364953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8h0aimgLaC2MQsEQ43x/tCgZTY2ycZ6QbIoEGdJwlYo=;
        b=cqDYkQZEsHewJ70Kxu9bOegVl9RNLtXQWxjkZ1R/6tdPse6gE6kL3t9pFLKJvm66ap
         xY2IQO35IPQXVGVMH3YMlHYNzS+WW43MjEYHrsmEd+tV4LseLd4H9VIa7l6eIE2aE5tF
         3+sVr4GZtMl8xyZCmBzoaYDdu0TUQU86YAbSNMxFpV9ri9F8sRtm8hLg0CBeqk6Q0sAP
         RH13ZwzPZsxJyAyqCYwVEnP+vRUghTIFXaBhEDJbc+UxSEop9FwhAObUkHAH4iewC6W0
         n8ZgkUGUpmvO7pTu1ELjM42P1BDH3uEJWgR3v45edh+On1QVcoonxnsIsHa4DRs3QTvx
         S6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795760153; x=1796364953;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8h0aimgLaC2MQsEQ43x/tCgZTY2ycZ6QbIoEGdJwlYo=;
        b=ZTgVyyWcB3SoWUEosvgOwnEdgrAE71ZevMBYAIY01VHyLvw+D91BA9Zsi1TvttxDk/
         Kweh349F56msYfLCQkxcR6mayutAx2adrZLdbX56Ta2ICrL8g9qsV9VswzHJOmhX1Jry
         9wTaPmrdCJk3WN4UpFiLfaoD9xSEwpRMsOsoS/HX/Qsj6maqxoABMBlQp4BA/uSRVfea
         CGNAsWPvIJeQ5aNQNWbymoMAsYNjbxbKVq8jeqgTgGFIqqfdzHQTmhJ87fiybSZFRigX
         uTz2lvPbrysptCPfAqYwqfaUIDbvTBh63bqxswe38JGZY8Yu0+kEde/mnUebtQrI7Kd6
         Qu1Q==
X-Forwarded-Encrypted: i=1; AL+hErHDweY9HAytoNfdhp6NWQo/VFDwCbBUb+CctYT3j7AIlzfne0bIXkQi/xJ4jVv4uZX+BAs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/r3qTA+I6ZAbc9NKJXRn47XyRpkmHE8wIzQBrD5ZzkDmfRQxvH
	zCWKWJKwZeho1DXGxeTLKvzbVZUgTWE/g9P3AptNxjRI5k5e8V6mvtjAjhs/AB/Tb5eO4YwaoUf
	okdpZfQ48U5LRt4bWXBfRDJsi/24+R3o=
X-Gm-Gg: AZFdTZcqTG5FKt/VzGOqYl8LErWjN5GwWbRnJzBvga2aTQKtE5awRLfvFBwzoza0Mi9
	Naztr1SBw69ehHJxwVKlMoC5PJWhEPnYKCgL0jHkXt/VvTerIAJn4FCchQBB5LBQxoklFGuOcXE
	d4BRcqQ+gmka5zmFCXy8pKtE3cABriRNq8326KwfLjhIkY07TFoYVILwnb5tUmyv7vvWkKUuNDf
	gqWpTElNLr3FgsktbH80aMSVxcX1oqDyghMQOsFkm8t7uJ/j1Dfv58mAxayKmaEuY/Ffd6gxHt1
	02YxQYml4AW5AXuezOZtbIiKZD/r9rH6nKyIC9PWp96GhKYm4eQmVsy8jBhgVTJoHhHAgmV0xIY
	CNhESX9nC/ozeMFSQgaxLSXix14p2BfpBmaqC1CvJXmCHNx2D304lVDP4GgWRLOGH3cBdLQ==
X-Received: by 2002:a05:6214:1242:b0:91c:6d30:7c2c with SMTP id
 6a1803df08f44-92134af091bmr406955296d6.52.1795760152841; Thu, 26 Nov 2026
 22:15:52 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2306.git.1794484985.gitgitgadget@gmail.com>
 <pull.2306.v2.git.1795273853.gitgitgadget@gmail.com> <435ca42ec99d0eed613621186306cb68def30e6c.1795273853.git.gitgitgadget@gmail.com>
 <xmqq4id6qakd.fsf@gitster.g> <CAF5D8-ve1dtYWUMDeiYYa0FpDOv3c=V4MAS49Awy4e-9iZy-xA@mail.gmail.com>
 <xmqqik1ietjq.fsf@gitster.g>
In-Reply-To: <xmqqik1ietjq.fsf@gitster.g>
From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Date: Fri, 27 Nov 2026 15:15:41 +0900
X-Gm-Features: Aa3M54oHiItIFkD08bZVJglZRIRXQd-7gc0qIHabbvGGVDWpR86Djj9_1h_Pxa8
Message-ID: <CAF5D8-tw61fNjXi=mx9eOMWgyde54UTeBT8v7anRKi_aWXyR=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] submodule: make submodule.<name>.gitdir relative
 for worktrees
To: Junio C Hamano <gitster@pobox.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026 at 2:23=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Yoichi NAKAYAMA <yoichi.nakayama@gmail.com> writes:
>
> > I'll update the commit message body as follows:
> >
> >   Currently, repo_git_path_append() can produce an absolute path
> >   even when worktree.useRelativePaths is enabled, such as when
> >   running in a linked worktree or when GIT_DIR is set to an
> >   absolute path. As a result, `submodule.<name>.gitdir` can be
> >   stored as an absolute path.
> >
> >   Always store `submodule.<name>.gitdir` as a relative path to ensure
> >   that it continues to work when the worktree is moved along with the
> >   main worktree. (This benefit also requires worktree.useRelativePaths
> >   to be set to true.)
>
> "Always store"?
>
> I am not a heavy user of submodule & secondary worktree user, but if
> worktree.useRelativePaths configuration exists, should relativifying the
> gitdir still be done unconditionally, or should it be done only when the
> configuration variable is set to true?

My understanding is that the expected behavior-regarding the
interlinking between a submodule and its management directory,
as well as the `submodule.<name>.gitdir` configuration-is for these
to be recorded using relative paths, regardless of specific configuration
settings. This is, in fact, the current behavior for submodules belonging
to the main worktree.
With this change, `submodule.<name>.gitdir` will now always be
stored as a relative path, even for submodules that belong to a worktree.

The `worktree.useRelativePaths` configuration does govern the links
between a worktree=E2=80=99s own `.git` file and its administrative directo=
ry (i.e.
`$GIT_DIR/worktrees/{id}`).
This configuration does not directly affect the behavior of submodule
links contained within a worktree.
I mentioned `worktree.useRelativePaths` because, even if submodule
links are set to use relative paths, Git=E2=80=99s behavior after a directo=
ry move
would still become problematic if the links for the worktree itself were
absolute paths (the default behavior, where `worktree.useRelativePaths=3Dfa=
lse`).

Thanks,
--=20
Yoichi NAKAYAMA
