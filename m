Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4CD3BBA05
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791143502; cv=pass; b=kXUCX0JVP/RszsFLMyrDT41HYzZD+GaFobjQ7YerpmiEt7liytifactsDMjYxLXBdqLSdgBCm8DeI13JAbLqpLqXrUpg6q8PBkg8fg6oDXOIoH0nalivQ2U3ObD3A9rryP0B7Edf+hRv6kCLReGEcWG8M/SJJc9SGQYJFPaKLUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791143502; c=relaxed/simple;
	bh=DJZELg6SO/ds0TlHosg4ObdfE5CWcovwZqEpW+Rjicg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5xKbEQ3Yndv3E77J1xB8K7WgFRcikySV6JkmTafYy5kpnwfYN1pv+sUmT/LqPfelPY+SCZwT3w9YSVbJwuK4JISCBdLj3icngISCd06rNTbZsirXZKO+Cg11Sztbqej5FyeGfp4Vh6/qrGQz333X5uZQDwtW27qdNVZFd+mbx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kb2Vb5Ca; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kb2Vb5Ca"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a601ba6870so1888275a12.0
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 12:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791143498; cv=none;
        d=google.com; s=arc-20260327;
        b=ltCtmlzLUjpdgKbGc4uZ/bXW6qFOfwHIgHsBETLcNl5J7aewwKTYX873i3qszGw25z
         246XEFWQSED2uPswTE/ppMEMuGGu6AjpKCIIdHA5NCIf644lpTxea9EaCAj8oZClW3QN
         Qc4BOl289UzYE7nciD7UXd8cLpYvNYN3AG4WiFTmpKkrERkFZM0oCW+awgtd1taLhqFY
         Jrdm/4fWNdD1ANUQM1r5Fh8Xb2wlebZwFzZn/m9TGacifuXIoRoDvw30QzW1vkJ+Y1BE
         LnvSnw5kZvAmDZZLiLczMiLNNNPO1fLITLlawg6vDMFzUxQHOnBhj8Zzos7A2p+5f5uf
         Shmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OeOBas5F3FvXaZKNHF8Zj+yIw0rfGvEOEkzm90kyOek=;
        fh=xZShEvow9qxUO44NBA4Xyr4XAgTO+13GNAkDQ56kCSc=;
        b=hoIVAK6rxOh7a+H46d/sjC5CE9NH9m2ayfdn+9ldA4u5HozzAOuwxfLbvkrbn/ZH//
         fbtXu4BIDHguBlIHBpusNMG1W6v1iPvnhSe9kSqusEYYUqPYk/Jx/F64LfoGoUK9QM/9
         MMEk/tmaijocW56qrNwUWgJq7suawKutWNgJxUtX+5fTfPKJSDPPfZ4U8Thdoqm3F5jP
         ToP0Ud3a1IL0naNwcqLa61leJjJS6hiGFh7sUMfid5wc12h4MOrYjwouVWhvGz2PssrN
         y+29eUMnJCP8Z6lYkmx4AD0RVeyQxnkeAJvOpwpY4gVvIgub/Z9lNYvHV2pI66FupCZh
         oRBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791143498; x=1791748298; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OeOBas5F3FvXaZKNHF8Zj+yIw0rfGvEOEkzm90kyOek=;
        b=kb2Vb5Capd5FldZ45RqYr+DKUnkW69x19IEgO1/aTV8nawDGrxqz90K7FRaa533BjO
         XJ3Qi+qzgZbFowUgAF30Ofjj7uChPvlQnrPPMcpVNlZx5Moyr8vKCE7+yipPF/P1YBgz
         z1yL1yvTs3s3ygTUUkyg2s1Dw31zAcrwlvk6+KAzPkpJ5TfoCMGKEVwFqQzgzkeDznos
         2EfG+c2pVDa0lyEb5JMKcXwojZ/Hu26r5rXgbEBN8WP3Wvmh0hI1Dh7a8Yx3ota7UJiO
         qqZmtP4Puonq2QqW1zeeAZxFaFC3+EwYFnalZjRuz0Qt8bWE7BPXVhTUOhHIAOQd4Om5
         cAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791143498; x=1791748298;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OeOBas5F3FvXaZKNHF8Zj+yIw0rfGvEOEkzm90kyOek=;
        b=KnaSo3eSbIv7VQ/51EbJAWj4pALImCfdTKxi8+s1gVYyxKUWz/P0PM+ztTrAmWT6aQ
         rqe6etKmRD1mdQbRHMEhVUZXNIozX1UFrAQMew1Cv1j3RHyB9FTY3qJKlZTuYM1X8M1o
         NqfpyNp8SJCaB7+xujCqM5xZYm7G3GfxDtxwETE1Kl1irjDOTpjbw6yrhQH+E97ftLpd
         8T/BsDoqnCwh55PoRpd94IvN85pIdLH13KPZhV8qeh6aPGxHlZmspTVNSU/OzBlKbKfq
         78BC/TrbsHX5nOEqTXreSoYYKiP3jIDwJo5mD1LNgTuCVA+kd0WdU2OcVkeUYjEZag8w
         WFWQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPR46TRDDoRZ6pnVMJMACOST/uaFytFB7SaKvqsYiEPu4bbR82IgpLsMoQFpi4uQcyMjU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+Wi00BSe4adWDrKVxBn74afRktq5PUxYbJtuS9kYAiXIQkn+6
	pS/KHZhqQYZ4ZUdMK+tn8O2qDRiqi0abuIF9/JM0FoSYzH7nhOAYFzKZri1NV9rLGGB0Kt067tW
	91hHPgZEk2zwFJZC0+UEo1LOyt5Un1Cc=
X-Gm-Gg: AYBFou2uEUMeDPPNFO8rxCRRsPeNnFeMyiJL+QVNmRE9fF1kKI56HAKXZ08H2CsyEA6
	1Sb8EwC+B4G/HVhiPjdTQtlxT21kNZTE+KgtgkGGGXfBT/slU2RRklC3/MgWsoeo1JF510SAlof
	gkAl2WrFVFfJUsKiq01XRp1UtGSIpn+c4fsCWApaA4+5cmvBWJTdhPIPCdpeVyxr6wOvR0czA/p
	RuyiIeg8uAgXD4q2wAr90hLg+ZyyRx6QiTfDB/pi0sbpM+gbtqwqahkpuiLJOlUMzZOwJOLYuJp
	8iiNrCWTNq1NKijPj2IIGswgIDmBwrK7ByX0gYKz/CgbdCqIQgrjqDQ=
X-Received: by 2002:a05:6402:20ce:20b0:6af:bc82:e126 with SMTP id
 4fb4d7f45d1cf-6afca043e6dmr570539a12.44.1791143498586; Sun, 04 Oct 2026
 12:51:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v6.git.git.1791102684.gitgitgadget@gmail.com> <xmqqv77hs7ut.fsf@gitster.g>
In-Reply-To: <xmqqv77hs7ut.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sun, 4 Oct 2026 21:51:01 +0200
X-Gm-Features: AclHuK-ft1xNfDM5d5bR5dpFNKa5vGdGgdiK-1ULyurPyJ87nYWGHB7DzDWi17Y
Message-ID: <CAHwyqnXz+acRBytu9tWL+RzsKnzTZyZCnzzQQhEFjvWT5cgoww@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] fetch: avoid fetching every branch of a new remote
 in a shallow repo
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> If you try to run this with [1/4] alone, however, it errors out with
> "fatal: --refmap option is only meaningful with command-line
> refspec", which is suboptimal when triggered by a configuration
> variable.  Even though our design says that remote.*.refmap makes
> the command behave as if the user gave '--refmap' on the command
> line, applying that rule here is a bit too strict.

Thanks for pointing that out. How did you find that?

> Then there is the last part, where the desired behavior is unclear.
> What should happen if the remote.origin.* configuration defines both
> fetch and refmap?  How would we explain our choice to the users?  I
> do not have a good answer to this design question.

I think that when both `remote.<name>.fetch` and
`remote.<name>.refmap` are configured, remote.<name>.fetch can win.

> +test_expect_success 'remote.<name>.refmap without tracking (baseline)' '
> +       test_when_finished "rm -fr fetch-refmap-baseline" &&
> +       git init fetch-refmap-baseline &&
> +       (
> +               cd fetch-refmap-baseline &&
> +               git remote add origin ../ &&
> +
> +               # without fetch refspec, but with fetch refmap
> +               git config --unset-all remote.origin.fetch &&
> +               git config remote.origin.refmap "+refs/heads/*:refs/remotes/origin/*" &&
> +
> +               # nothing tracked, nothing fetched, no error
> +               git fetch origin 2>error &&
> +               test_grep ! "fatal: --refmap option is only meaningful" error &&
> +               git for-each-ref --format="%(refname)" refs/remotes/ >actual &&
> +               test_line_count = 0 actual &&
> +
> +               # nothing tracked, explicit ref on the command line
> +               git fetch origin main &&
> +               git for-each-ref --format="%(refname)" refs/remotes/ >actual &&
> +               echo refs/remotes/origin/main >expect &&
> +               test_cmp expect actual &&
> +
> +               # what should happen when we have both refmap and refspec?
> +               git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" &&
> +               git fetch origin
> +       )

Thanks for providing this!



Harald
