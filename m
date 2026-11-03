Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793713613;
	b=xOvbFUfbsxStbveS6WBic2+Vey42wYsrEFgsGRU86jm6VmZ8NYxS5E2G8EneTtBKIjIP
	 gRxiyVgMdajtOh6GaBaf/SvziozNSEysUre9Sqi4iq91ervx8ESxmUAyzR3lc8oKYU581
	 I0efeDbTTTvUWnOZkKV9RyDVFbC/RvZEHN+00X1rmnNIXK4ECtGctg61HS+hoUSPFXj6B
	 BC58ee2LanZIxXN6lT3DkRFlEa6vUz3YqTgluRkmWxHPCisiHb1BoyI4jNnZS0ZFs3eRp
	 3/GfLMf3TEBsUxO4tdu99NEa2zpzmzCh1mgrHO4j2mBPeKk2L6qE9cZvgOtj2G+zuQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=IXWh3d/+dtC5luOt9IRo6MnDU/gjep23XSY7BbKYXwc=;
	b=gbMCgXa48qgSRSRdspcWyjCK1UpA6acP2baMAZWZZO1qq9PwmIWA2jfrFBFfow/c2dAl
	 kQ3VZqU2x2C1zgpIk/myygqvxU89OUF3gAkDVPGAtMhF5luHEornIv9WSE6jfrkdnvLZH
	 /DmgnmnaU08fnG+PZUIbamf87Fb0iOrTTDBTWsZqqoA2gtlKlhSlkKUSJxlaLmR6WZN+K
	 952CCxcKWxESKhAW1NlWhtzUiIPRToLwbydA1fNGblfUZ5Zbg3lePV11Uo8VYAOHeqFSG
	 8hXATBc63IEoMOzkkck/kfKFxKVCeaQ7g6jjQbF/uHfj1p1/sQGHXGf+W98On7IC7ag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KQS2CwrC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1722606A33A
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 13:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1722606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KQS2CwrC
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-70b875f6f1fso3884214eaf.2
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 05:46:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793713611; cv=none;
        d=google.com; s=arc-20260327;
        b=mbpbZDW0EIR5l0ckWMXKtbP5EiATGku7qkI3IFdLi1fqhlm7cLYYWQDBtakRSl1/CX
         LkWleSRYqQoPZxDFSzLDk3lY+n5iW6YHNfe1B5UIz7XK0155Bn4VyeeyNERKsY/iXxtw
         JCGowsLvlY3uLYKBnmW+d00r2VeQ1Jt2nQDMbTpZgDsItBgZJegHfdXVrfsRUpuf9t3x
         kmzCT44qcB/mXkX88deaNOvaPjskALoA+SoWoqOIX0t0daG9vEdtbxZOYYoPXLjhE3gl
         vBpWHeIaHUhVnqxNIgWYyXeRsDhHdrHH2Bdo8a1IDzoBQydsJMfYab8VdtU8aAt94wB/
         qnyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IXWh3d/+dtC5luOt9IRo6MnDU/gjep23XSY7BbKYXwc=;
        fh=M0bpdXiSTXdD+3QsRqpLy8Sf9mfMfWjg6PwNpY05g9c=;
        b=XjT/Qpr2XbdUJyt6JWRJ8zJo3/EAIxTtDuvVZOkUQblpNvrB/BgeM1F3MCkmr5NMre
         tHuF2VVssUxGvP2Wr1+0tySgaFBme7J3mLmZeKt+d7yOI309evF8d0KwyPd2ZtgDUXSe
         EB4WMz/fiHxQC5mPDM285Yw4lHTcoxl839eWa0zoba6aZecRuPkEGIEkI1rtQuPMOBmp
         C0ASMpgUhNl4E38r5sD9nty0X/wv7yaWmPWdeT4579EU/dg3H9uKQ1dyIJY+4h7M/kka
         ylSZqItiDLATH+CdQh7VE6Tz1TA4vjU11qC3YJxeRlqP7Zx5nRK67kO+Y1Pr+hzjyq7v
         T4oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793713611; x=1794318411; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IXWh3d/+dtC5luOt9IRo6MnDU/gjep23XSY7BbKYXwc=;
        b=KQS2CwrCRctAQaJP22jYoRSoGmLmAGAjeBTfBQGB48YJEff4VdZcoyckfPl+pZvnBX
         Dv5Fj3cGmY2UcPUVQW7avveTSvvRSya77i7sag6cpkJz6k/NPCHhzoAOqJP5AMsZXbv/
         HzjezAZT6NzmT8zLnTADg0UB6n2U1ZVhKc0neXPw40LMJg9Jcv3VCqaL89T95EcYOtaC
         Rchdbv579BMf7i92FaQhhtQZacMPVB+i3Zt+XIpuC8QrynUCZ9zd/Q6KlUYoCehhSC2x
         kWLj2nvR1fwFzu4jq0itAFm1h2P7vSC8fz4QR3tZwtTMSaXYCS7APfJRCU+JeItaguTP
         rGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793713611; x=1794318411;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IXWh3d/+dtC5luOt9IRo6MnDU/gjep23XSY7BbKYXwc=;
        b=Fe91JMJsDfBWhuLnt4pO9D1NNIkmXgmjQM77yxk+mpq2OQhpb4DPnKnFnO3a9ib5sg
         Gvdzj92yyYkz5s8fZyMWjQiB0AjgDYKoIgRi4s4CC6TT8QOI5kcIOrPTdnYypMa/oueX
         u3Wx291N14/wqD32LvpQLLk81rjVYUrYluqW4I2D4y66LSfPjNRxUOx9fiYQpVPOqdHW
         5Hbe1sVrQIFlSjdgvO/7YjrT58qW8z7s5OP072FQN3p9LbZx3MYPvDNU5/n1v4FOW7Re
         ARoShydOGTJ/XV1W6meSyfLUELJ6yEa7MA27IOUgvYo/ow3JiAAVkfiMkg+BwAQkwpDX
         OwGg==
X-Gm-Message-State: APuU4Z+rCKo/L90jNZXh9GWHiGieSgfPFopEn/ry2TxlJrOyfKuFQpTk
	kR3My43SFc8lTn6fJ88sNy3BVZR1G4hBfYjqIcE4xh+pWCL5f6YhaHLpZl3Z0sL7y0GKnmgr01Q
	GWDFdRdEsdyY1w4UhciFNO/O+LFMl3qw=
X-Gm-Gg: AYBFou1YoLeqWkx9yAsBzu0JBUl/6AoIk1cRYACEP6vs8iGmRu7IiYu4DCCCe2aitEJ
	lse0H8SP+jjLqV/DOq3+AeTegV8EreZ7RmNsG0BCI4LExKNcGAipaBiTa4LJ5jeEiDA9CCPdpXZ
	AZXnuv9vWJlqjfb7uhgAyNZsg695yrruLdGx5CNnLWAzpgrbmXGsZl5hJv/7HDb7xNAJ/4nf+Zy
	ch9MSbuPuurrfKaCUA1pocJeh8SHTcwS5swmxIwR0QmTYRZM8AiFj+v9SGeR3s49yeuITX7Od7J
	kN3K+mQHFMffmiuWvaES1vt38jZEYBofENHFIix845JJJkzvaHHl+Nstnv4eqNvXow5wulSmYfY
	J6c7ThewyRcwJ9jSQmvyKmxv4lpPj90QOPfVcHhAp4fnM15pGvCJx/73PLOC21m6sjWot6QEhv2
	RGehd0eCRU/cskieWCQTiveaxtMGv/xDRlmtm5nxy5tx6vH1ba/AH441I2yZVO7GmpVsIq1tv1C
	NuCSD68gr4d7MQ7FdWGXHb5
X-Received: by 2002:a05:6820:169f:b0:6b7:46fa:1693 with SMTP id
 006d021491bc7-714f29aecbcmr7213928eaf.40.1793713611413; Tue, 03 Nov 2026
 05:46:51 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029141818.40193-1-okhuomonajayi54@gmail.com>
In-Reply-To: <20261029141818.40193-1-okhuomonajayi54@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 3 Nov 2026 14:46:39 +0100
X-Gm-Features: AclHuK-LOY8rY4xKbWWLQAVOXIKz6YlsnpNC805uDX3EEHgycP_0d6iVEg7WOss
Message-ID: <CAP8UFD1VUCTeXNbb4YKGkZRWY8i56Zms_=qkR2oqF7e1Aagy1Q@mail.gmail.com>
Subject: Re: [Outreachy][Proposal]: Reduce Git's global state to enable Git's libification
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org, usmanakinyemi202@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 29, 2026 at 3:18=E2=80=AFPM Okhuomon Ajayi
<okhuomonajayi54@gmail.com> wrote:
>
> Hello,
>
> This is my proposal for the project "Reduce Git's global state to
> enable Git's libification" for the December 2026 Outreachy internship.

Thanks for your interest in Git.

> Past Experience with Git
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> I have been using Git since I started coding, for my own projects
> and when collaborating with other developers.
>
> This is not my first time on the Git mailing list. I applied to
> Outreachy in October 2025 and sent about ten patches in about a week
> (patch-ids, commit.c comments, builtin/patch-id.c, gpg-interface)
> [10]. None of them were merged. I was sending too fast, my subject
> lines had doubled prefixes like "[PATCH] [PATCH v2]", and my commit
> messages did not follow the project style, as Junio and Christian
> pointed out [11].
>
> This year I slowed down. I read SubmittingPatches properly, wrote
> my commit messages in the present tense, and sent one change at a
> time. The hardest part was still sending new versions: keeping each
> version in sync with the review, the right thread and the notes on
> what changed since the last version. This time my microproject was
> merged to master, and six more topics are in 'seen', some of
> them marked "Will merge to 'next'?" in What's cooking.

Nice.

> Reviews and help to other applicants
> ------------------------------------
> + list-objects-filter-options: pass repository to partial clone
>   helpers (Dorine Tipo)
>   My reply: https://lore.kernel.org/git/CAFpMFfCu6JrUC8i453qBP=3DAktqcG_9=
sGX=3D1-1ekEDCYm_+pkUw@mail.gmail.com/
>   Description: Dorine asked whether USE_THE_REPOSITORY_VARIABLE
>   could be dropped. I applied the patch, removed the define and
>   checked that the file still builds, so it can go in the same
>   patch.
>
> + Microproject idea: modernize a file-existence check in
>   t/t0081-find-pack.sh (Immaculate Mecha)
>   My reply: https://lore.kernel.org/git/CAFpMFfA17dnuLSRt97BrM0u3cHAifJyb=
r_Zc2ahr_zq2nspgsw@mail.gmail.com/
>   Description: Pointed out that Shashank S had already changed that
>   exact line, and suggested searching lore and "What's cooking"
>   before choosing a microproject.

Thanks for helping with reviews.

[...]

> This project reduces that global state step by step:
> - removing the_repository from library code by passing the
>   repository explicitly through the call chain, so files no longer
>   need USE_THE_REPOSITORY_VARIABLE;
> - moving repository-specific settings from environment.c into the
>   repository, mostly struct repo_config_values and struct
>   repo_settings;
> - and, where a value is only used in one place, passing just that
>   value down instead of the whole repository.
>
> A lot of progress has already been made: many settings that used
> to be globals now live in struct repo_config_values, and many files
> no longer need the_repository. But there is still plenty left.
> Over a hundred library files outside builtin/ still define
> USE_THE_REPOSITORY_VARIABLE, and environment.h still has globals
> such as git_commit_encoding, git_log_output_encoding and
> comment_line_str. That remaining library code is where I want to
> focus.

It's a good idea to focus on library code. You might also be
interested in what Junio says about code in "builtin/" in:

https://lore.kernel.org/git/xmqqmru76ybk.fsf_-_@gitster.g/

[...]

> Roadblocks seen in earlier work
> -------------------------------
> - Not every global belongs in struct repository. When Ayush
>   Chandekar tried to move core.attributesfile into repo_settings,
>   Junio questioned whether attribute data belongs to a repository at
>   all, since attributes come from the index and the working tree,
>   and compared it to how index_state is passed around instead of the
>   repository [7]. The config value was later stored in struct
>   repo_config_values instead [5].
> - State used during early startup cannot simply be moved; the setup
>   code has to change first. Patrick did this for
>   is_bare_repository_cfg and git_work_tree_cfg in his "setup: drop
>   global state" series [8]. have_git_dir() is still left, and
>   environment.h says it "should not have to exist at all".
> - builtin/ commands: the "repo" argument of cmd_foo() can be NULL
>   (e.g. "git foo -h" outside a repository), so blindly replacing
>   the_repository there causes crashes. Library code is the safer
>   target.

In the discussion I mentioned above, Junio says that the code in
"builtin/" isn't reusable library code at all, and that it would be
useful work to move that code into library helpers.

[...]

> Blogging
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> I will blog on Medium (https://medium.com/@okhuomonajayi54) and
> post weekly updates on my progress, what I learned and the
> challenges I faced. I will share each post on the mailing list,
> like previous interns did.

I wonder if blog posts on Medium are accessible to everyone.

Thanks.
