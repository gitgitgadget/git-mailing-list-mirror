Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF981A7264
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781946283; cv=pass; b=PkyzwvrdejuB29YYTT4PzOhaXeqkM53O1rkf2ZCOjYWIRw7aa3uegO4GgpZWW4qOg/BQC6fa2AWxMiqq82aP8GNttW+tzwZsEH5vr3mdp6SW77oJNOAnxh5WDRq3hflW3rOKEL5oUMSRYAk9+WBSoIwsxFwJVSHnq2/zP7kFQzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781946283; c=relaxed/simple;
	bh=hzKkDPtQ3XxWNse95MtoyU79LnbPGO/PN4utmAfJYeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lifv0JfK7asLQJunFkHJdPpKIf8tL7x0cG8ZFmJYIgOFMKJnT3NknKNpRkwAxikA46ymgpTaXp4I4KYVdMA2AR6d9IwAqsqePMgD6FCPNUGyx0h2J6DX4na2pU9TG1djW4hOsshKHnZNlUxMeSYb58osmuwtIM4w5PhlNVTHUPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1kyZiZT; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1kyZiZT"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69767cb5d4aso1804602a12.3
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 02:04:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781946280; cv=none;
        d=google.com; s=arc-20240605;
        b=IjLku8BJfFc4JZ8AvvVArXYPWH8LGdu44MniXZah5tCGoHRw3uvmylsYRjxePuZwhO
         Yn6ntkQY3uTEXBYJ5ZIPgARGr/IFcv+qPRbouj9LPViz6enhsKXAW+5rkCksqyL/6bpm
         fpuNvjy/cpQPY4N7NHbI8iT1cvsAZnXAsgWtznuXh05yg4n0OowOAIb/szxCJn4JNgPp
         dYINyCbRdA03T5HSr/YuzFHrHgVeKK3adco7tzDWl0Hio+uyX0A3gZ0rU6SZ0bkKtfT+
         Fk3/3NKSsDnAVknmIOnj0O9Ulo6mF6lQB39+7qgWazq3TDEe2/EJB2Y2nBwFvhDHqBFC
         DCnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=u7RF95WR3NDQEGSMzOnm2wkRdcSJmmXRONgc/u8inHM=;
        fh=9uI0BOYUqQn8hTKJVG0io/bb3kjM86DmQUpmQhkBDMc=;
        b=AS8LbdxrtkJZnBkLa20puBg182Vc7yAmR2f2ndVec8iAw7i4b9+kBTeEFnNeRcwjM/
         ANdcLqIG2T0GB0Iy2DDhAqB70OVycOx8xW9oGgEB02XAijjBxn7p3qGM3kDbDzAN9MgJ
         Ja44Db0ZHdD5rvYznOQRi71TCblrA/olMsR43hPS5lolf9KX5LV+s42Cpop8YnP4Xif2
         YOeuS4SAAEmbmPIPNCicj1A7pK2H4Mf2s67PJYjMSdExR9+bW71+09N50pIhisoHKn9E
         n2DAhJDsa8zAiBo5ZuGFx/GAspZePpXBUBOSH9fPhflO+5yqe9aiGPkNdNmqUzTXopfL
         aAvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781946280; x=1782551080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u7RF95WR3NDQEGSMzOnm2wkRdcSJmmXRONgc/u8inHM=;
        b=G1kyZiZThXIqceB095mAREX6ndmotLQn2L2zR3DvjqlCa5w4+llfBBzQZoa/75W8nP
         x6U8UrFEDE1Myu2T19HiYxYlG7uz08BgySfkY88WaOl2ZZRXNsvO4rzy4F02LWubFUzs
         UlA0WolOS+WAeV+LCQ5Q9kYOQzNdxwlochZQO+woP3GC4MDOy+xo8hewtyC2AEnHG2st
         Oe+Ka4Vke9leLAD09hlK0xg0CISy1G7jEV/sG3LC2wxkQ/TqeIocWOSXQ9LQIEaaHv7w
         E6y0NNAqz6PGTij/OMwgquq4U6UZVOyiwdpA1JbhR0anuwvFv6ltss4Oatxq5LqufDAV
         FYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781946280; x=1782551080;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7RF95WR3NDQEGSMzOnm2wkRdcSJmmXRONgc/u8inHM=;
        b=KghG5wyPG5euCv1O4SeWAn/GlYppR6MnbR70fOuNkFnyzC09fOF66TfhCt3zU7M/Kq
         4hOiLOWChhc1Dffdd66HMAFckEyfA70K30zr+w8cAcqX61aiZsKDbN8vcWaUVeQGSwbZ
         FzN4CTZwdNVD0yWN3bUAV4Bgk5rUrx1UUry1e/gTTotjrutBy5rWPqIPSmz2CsIXJnsQ
         UBiMAp0GDdp2TadUl/u7++9Ot6K/NHSJ9//6e5G2U0SVSSsWgV1AFGEhncqc6scKbFvv
         OV9HaQ5eKBBZ7GSlpDJufp9Opinc30gES0VQ3vIt3OKYw/Vg5nroGdPTy9UoXBfrd2fZ
         1F3Q==
X-Forwarded-Encrypted: i=1; AFNElJ/Apw7nUsr1Y5J6j81W672/KmxEZq514ReHLmym7pxTEEL+e4jnV95gqLbOMfn7XjTzc0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWjKumCj3KCF79PfFX673GNcu7hle+3jRO3wzeJ92q0S7b8MVi
	Afehbhh6O0InqzO+wRYz/wX4yppo6m19MibNhvBGUVVpzAAy1YfvHhfe0zk2L0jzOkQB9DkzTCe
	fB4CxAA8JxsavDiCB6Dg6A8wa/zglVPA=
X-Gm-Gg: AfdE7clZnBonIhKvrOHXCLWoCDUFuUu2b0D3NtC7Wp6KPOTKpbzb4EVEekDbC9BXu7u
	NjaZnrUw0XI6IYHUA0ef/xgnerSQCZyCOdrUhXMcnsCbCt81/6y59asNL03najBl02mTwq66h5s
	qP2aqz3qXLwkywAgvn/eLFR+sksDShncNAuAVvAIqw1GvVyarw9ZtUMklcWA7g7tHCRaBCm/l+z
	opZBJzgrJW1OvvJW3RhiZICDHp9rDjpY/9cjAAQ48+vQC5NSXJSaGrR+vq//ISw8XZUdasS
X-Received: by 2002:a05:6402:e0d:b0:691:afc9:f59c with SMTP id
 4fb4d7f45d1cf-696edc5b226mr3584671a12.1.1781946280328; Sat, 20 Jun 2026
 02:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
 <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com> <9924373da0a0598cabe4f08f3bc4200833679171.1780999917.git.gitgitgadget@gmail.com>
 <78b6dfdd-df61-4c44-96eb-b527cb26243c@gmail.com> <CAHwyqnUsjpCHfS=eBphmkdDGYpQZ_LQUJi1mjrxV8ZXi+w4yhg@mail.gmail.com>
 <37f2a483-c8bf-4c24-84de-c6233cc20b25@gmail.com> <xmqqcxxnsufl.fsf@gitster.g>
 <42ffcb36-7fff-4948-9b8d-2c54eb626e66@gmail.com> <xmqqh5mymt8i.fsf@gitster.g> <xmqq33yimsdp.fsf@gitster.g>
In-Reply-To: <xmqq33yimsdp.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 20 Jun 2026 11:04:02 +0200
X-Gm-Features: AVVi8CfWa6T6T97d8LpGFRzOKdcCI2pQxWDf4AMQQq_Zkt0IX8vDedbcpXQUbaE
Message-ID: <CAHwyqnWt59h2HO5EJbFswYr7QEA7oNZKdBt_vTk5axNbWFZbpA@mail.gmail.com>
Subject: Re: [PATCH v14 4/6] branch: add --prune-merged <branch>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

>  - Move the @{upstream} of feature2 to the branch that "merged"
>    feature1 and caused its removal.  Asking feature2@{upstream}
>    would answer origin/master, which feature1 was removed after
>    getting merged.

I think this is a strong option.

As a side note: I was annoyed before when GitHub didn't re-assign base
automatically when doing stacked PR's, so merging in the first branch
caused developers to  merge in the second PR into essentially a dead
feature branch instead of master, if they forgot to manually change
it. But I think GitHub has fixed this now so the second PR gets its
base changed to default branch.

Two caveats:

- How to handle recursion: b1 has b2 as upstream and b2 has b3 as
upstream, and both b2 and b3 have been merged? Not good if it's just
luck which order the branches get walked, but also we don't want to
have to do many passes, two passes is not even guaranteed to be
enough.
- What about when b3 has itself as upstream? I guess then we can just
remove the upstream of b2. Overall, I don't think it's a huge problem
when a branch gets no upstream, so maybe just warn about it.


Harald
