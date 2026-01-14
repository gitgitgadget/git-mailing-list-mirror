Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02761376BD1
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 06:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373993; cv=none; b=obSDykRrwoU+n1k/xEN5TzVLnPMXer/oRxpImtEZJ189wjmbNt66mqSqoS0jE+PWJ3v/E/ZA200MpkO7l2uuxSJhlUqEKwRQpK0ipRUU/VWGQDWBku4oQ/ysWXbLkMPE2DeQ37rX+hKuotECzOpxoDKHpvTouIrv/kRdLbZVo6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373993; c=relaxed/simple;
	bh=a4vgUA28wiJ1pOJ2lxobrcoTuWx9zGh9uW4Vv50hme8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/CYBNWiQ/05SpeTu4IBCwQ+lFa/kfz0/EJ9edsTi6KY6v/Xpzy3yj63lgfGbaz4UvfpJQ+VfxzdCgmeBzjkPuZABs/EVUoGJfUj70VoLh/nnVSZ9sjE7RW+FVU29n3FEBJOFfYk2CxMJ9kUdDtvNyHgPX4EVj4moz3e8c5nmSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmnNbSPY; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmnNbSPY"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-122008d3936so6370163c88.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 22:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768373973; x=1768978773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oEHMmNFlTu+D3IwUekVnp4BVSfZomKpvhQCVNNnuJrY=;
        b=RmnNbSPYn7L1GFdvqiTHxSDT9sr2RKDKtjiBjBmQXNlT7HhRFArthwWAQVngjXtVdy
         sYFxppeJIy0wrbKw3XkDdBPATVRNRa/HaoU5EIKDdcPpDXHPpZ/FKvFs4rHog+nhGldo
         Lb3jXrOpOW1mXOQlG8eUTnQhFcTPyLBtG0IhU21SCV17bQvCh8Dd/df6ORukmXq+5Wld
         +50S24vFT+CEmC2ZKRhikzqdDAZW3LWORMEBDjcoC6NbuMdBchzZQxFm9S8k8TPbuW02
         YVLeM6Zmk0o3lH0SZPdBaFRwWaGqEEeii9mpykLddrtilDbP+TUQydZP8JVnCyYzdeOw
         j3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768373973; x=1768978773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEHMmNFlTu+D3IwUekVnp4BVSfZomKpvhQCVNNnuJrY=;
        b=gdE9gdkTnGCRU5RZwm/NvfCi5KlyjPks92Uj7LDQiBWLli4k/JZcolgmPClgTVluTB
         31WLab+9ejDbFKJgrSUjTCjBOAACP744HXKoiEqiGKa4LL71miW3/Sk6QVnUP3pEDe7X
         qeysryONlvSAOuDY9H9BdleSTW+3loDM2ihqNGxZkgKPzkjUG20m1TzFAhE+phswigDT
         2a1mSnz7i9BJ61n4Y6FxQOM3SGjyIf7l+mpngHS+S6sw8Zv9HDoQow2WWIAkOFUwHFa4
         YZaqUrfrL1Xa48oIhB4zlE2SSqMHsZjfrE2zlbD9S4Qib6ld4MZyUNMlUDPPVjtLCuRk
         LaqA==
X-Gm-Message-State: AOJu0YxmTb/H1Q0AA6YIN9CXHLe/wDcK/y3O03LbcV13/uHhgYA+laTH
	iljJeE7wr1h6Mo9ZBk3WHmY0O5OQ8L2Qjp2uyeweVRUvVxSpNAeC9dl1kUg5uVP5P4TSQFnGvqW
	WnkEPGVtQ2dciavf/gHjuUVgSv49i6TI=
X-Gm-Gg: AY/fxX4DJgtc+0QB8MA6IKRfbAfUEBoOuFpbVQKjSJaWdvLcdqxYC2RTpi3Sl/E2hdJ
	g+Kqt7fo6A5uptHkvf49NSCMPdiU41gC5IjhPDA20ciqS9Lpds0yxeEU/EmLoAjGqa9Ua8GCYRF
	VJ8S6ujFRdOjuzW4NpYGaGKJd12gjOzBfhqUPTevbh4vT6cCH3bDa9u/HxFhJUKBtxo9gp16msI
	/ttH5HTScgQfcAZs8f9rFQi75pp87+DOYs3lBi94xMvZDKiA5waGCM+76FjvZOm6lRYNxsEbXc=
X-Received: by 2002:a05:7022:6197:b0:11b:9d52:9102 with SMTP id
 a92af1059eb24-12336a23070mr2021494c88.6.1768373973196; Tue, 13 Jan 2026
 22:59:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768318762.git.belkid98@gmail.com> <b6f8deaa405a59812265160fe1d41ad515a9f388.1768318762.git.belkid98@gmail.com>
 <xmqqzf6hiab2.fsf@gitster.g>
In-Reply-To: <xmqqzf6hiab2.fsf@gitster.g>
From: Bello Olamide <belkid98@gmail.com>
Date: Wed, 14 Jan 2026 07:59:34 +0100
X-Gm-Features: AZwV_QjDf_0gYIVvJ_2Efv_Lr39UtAT3RQAyJ53q8IaUrqmlkXY3OPIu7mRYiaI
Message-ID: <CAD=f0L8B9npe_VZpWo6i9V4gn1hq6P0cfYbOvRsxFXQBTS4ckA@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2 1/3] environment: stop storing
 `core.attributesFile` globally
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com, 
	karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Jan 2026 at 20:26, Junio C Hamano <gitster@pobox.com> wrote:
>
> Olamide Caleb Bello <belkid98@gmail.com> writes:
>
> > The config value parsed in git_default_core_config() is loaded eagerly
> > and stored in the global variable `git_attributes_file`.
> > Storing this value in a global variable can lead to unexpected
> > behaviours when more than one Git repository run in the same Git process.
>
> There are quite a many global singleton variables that are accessed
> by git_default_core_config(), and this patch addresses only one of
> them.  Are most of these variables per repository, or are there some
> variables that are inherently just one for a user or for a system?

Hello Junio,
From my understanding of the code in `git_default_config()`, some
config are just one for a user such
as the ones in `git_default_ident_config()`, `git_default_mailmap_config()`.
However a majority of them are repository specific such as the ones in
`git_default_core_config()`,
`git_default_branch_config()`, `git_default_push_config()`.
These are the ones that the movement to struct repo_config_values targets.
