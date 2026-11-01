Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793576793;
	b=0NGiheBpyIxVrhh0U++BQHLqGauY2gKrIKMxtu5OCCNiGnHiX05cQBIZ9QNW1pG+GzjB
	 UYl13t7D4uVg47kERbWE3CTKj9vcDCmlPSw7Pr0tWKi9U3j/EGjDOcIIByT010WoNP42A
	 +0MgX9EpkEG+BOD9UJe/EbD6ynf0ancItgXZEs+R7YnlEW1UOPcuKgPmz2VBXNEPtMZcK
	 fo7olHtAbRGCavz0vFZ3TpEJrCUjoCJCZIUT3zjb0NqrjsrmF7c78/CnDsxgStbyAuKHx
	 IeM/k6pdySJ8DOxuXwHudWrwABgESmaIqYv16udDhBLsRm+6ElZgh8FxY9uIwql3DuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793576793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=CL0xx3I4icA2XhnYO0z7yTbq9dcTX/+PLCUsgrrXSmU=;
	b=Cfuj/MexyiHn5rH0/yI/Jjmfwj4oza9OO+lI+4FImh33mPr4AGWNkozFh64EL5j77YDJ
	 1SsoeVzaWf0gCEYB1VVZi+oHDItK3zqFCEmjsW5x0l0mk278soyNSPO+GB0lWMisc9MjY
	 wn1baHdXdH/HD8EVWaRzK5qXCZRGjVdXDlBVvLtdMmA7Z2BpBClrayFDeh+IeM67v+jOL
	 uJhY4fZ9ZtvWVlT5620qn+fYGhLfKWqMx2SsEb6gsqpEZ3HlEY2W3jUCg8pz1PsYoklb6
	 hHsjHzyCdcZFFonvswXb6vrRdO2K3Pxpf76G6kQxmSz+Qom2k5N8YW/7CaNIHzOkZrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ARVHR++7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243ED606A32C
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 23:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 243ED606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ARVHR++7
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-499f20c7054so1383211fac.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 15:46:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793576792; cv=none;
        d=google.com; s=arc-20260327;
        b=CxOwEcWVxrHwnciqp3z1lwrGTuLZoAfnJX56FFhrlR4J0G1avLE7VqktPuTc9PUz5q
         YM+KrQRwxiJ6Yhhl6pdmC38wyCDawT0bIcxEgxARtDAGCSobMkp5JkltAr7ZHPvJf2iW
         k5Di/sKBmTCKhKDp8B+eLHQLDPhO7P0a/+7TLJ4TwzWCPo4ulFo0WThkq3lz9MxpL+q1
         oUeAY9S9mjIROI2+e5Mb6xaHwgqbPYXYiXVsQJKAmaQU+HYZKldgl2FXG2R+csmUvyi7
         hositbIJmmxbeyJlYNJk8WpkVn10AFZK1Now3DBqdBqAutdElzy651FjjWjFpLwyWTZB
         60KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CL0xx3I4icA2XhnYO0z7yTbq9dcTX/+PLCUsgrrXSmU=;
        fh=+Ve7dG4yAo6b6IJAJcsfAVXuA3IHmj+18im/3KFY0tU=;
        b=US1e/fPcbBXUiXrqc0bDPgaKubM0UUYL4/UIwrjxa37/QT16F/22QVxkDdkM08I9eK
         2W7Eya5EO0N0EmEvtorKJy7RyPdRBwCqu2ElY8xH6FdU38S+48jO+mFUMLegktKeBcNU
         ianOS3kYH1OQXXOecQCwgnO8jRfTlAdQBY2pygmWvcYTCivaJwaxgaKEWggmfUI0t1AF
         PBxilmRB51LP8Y8uXbcmNzTPFdXexSad25DXV8yc+2mIZnQ6xg2MJiv3if43XN0w/TQx
         7siVQRrkTEuVoS+GQpsfoZLE+URVNdyxBjfgVaJW0Ilxwzjam5gkidxtXoBKryfz8FhA
         WO8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793576792; x=1794181592; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CL0xx3I4icA2XhnYO0z7yTbq9dcTX/+PLCUsgrrXSmU=;
        b=ARVHR++7GwZqupIQI2pjZqc25JbHe/CPoxB6dln+JkZa0+SFVEzYjUzoiXHIkGNWmK
         3yACk2adII/CPYZ8jY0qmYpAjJMYi8TcSO7Eg/JLgF1pHi89wiDZB3dYViM2v+VzO1ym
         fsJh1AZYdvOQJ92OV49L5RDpA3BXwVok6bafVXYqjCwBBspYS23D+z6xEnHVJy2ooLoz
         hw04dK429aUIiQR9qhdoYvhveuxyJKdB3oOkJQ6rPgEVNvww27q3OWmpJ+sYxYN+8QQ9
         k8YZsaXTJUKP0tEiiNLXJ0B9VVvTWPqZ6V0RHZc3ny64bJ7drkqXJ98tcFqsuEy3gvRq
         1KxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793576792; x=1794181592;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CL0xx3I4icA2XhnYO0z7yTbq9dcTX/+PLCUsgrrXSmU=;
        b=vd/4bj4ujG+JfXT7Pcl6gA2K1jssCNALneUnT/DFG0MhSdvHVeH19vAGV7BU9/1rU3
         ryZACjP1qTXNb278bOrVoTa6CQcOKqf/x0VRn1/lG/ehzBSGpXbeXYw+GgfDG06rB07j
         EDEVj8I+ffI1SnWDYtSFX+TM5oxWIZN3khKN3+9pTRWDi/ld8SmMigm9piZ27O9eabWP
         zDnocb0uDnXkYMsTyxmAwuGCYRoMc+Sn+MKRPbrtoSeGmZdw/8SLGEqUSEIZ6XGEBpW7
         c88VlkkQ4w0fNIqLy5/QDu0vXNCT+fFeT+Vyy9ZwvDN0Q4A415EGIH8aqdZcs/4+5TIy
         UC0w==
X-Gm-Message-State: AFq9FYIYenlZyy3dN2tXNLkuTOmmsCp393pZVrMUuC46yrU4tmE7hx+U
	+y+4LAWuyjnbuIkyjGMPoirGYk5gjts8STlEkS1+6P3T1n6qufq3HspnynR3KWB3w55FOpAqRka
	9IDYFQEIS8KLDbfceu1SAndMCZ8j1UfU=
X-Gm-Gg: AYBFou1SUebHNd12m/muzTFd/gfZYpXJtH3ndAPg40xTYNhOUTHqwGNRcc5XeuXW+Bx
	3C/xtBibsZWpsMu0fsAXuSYeaj+11RocFzbVU0DrR95dID32epAElodF2P4Nx7EdWTuuWuzRjo8
	Uk4XoiA67PyhY129Pn7vBQLoLWak8w/WvDPze7YNBN6LH2rdt7ruOX3qwmqDaDpyzToZ4YAsMrF
	/YLd6I6PCu8iVeiijLsAnUZTFfm/4CSjQgBBUw9DlZYFxl81VCPgbuZvYZiVAexbNhlskAk98GH
	it3oZ9xNFB7UujZ99RdvcvdmNTAX8PKenWOJ4aFNGjZludfsJ91yXnoUU9SE+I1Wg/qGWaIRkb/
	RKUDuS89rFL2H3PD/qffuL63YLiH3xd9wbqI=
X-Received: by 2002:a05:6871:460e:b0:4a7:c737:5a13 with SMTP id
 586e51a60fabf-4a9072d445fmr4962082fac.4.1793576791971; Sun, 01 Nov 2026
 15:46:31 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022212903.177261-1-andy.koppe@gmail.com> <20261022212903.177261-5-andy.koppe@gmail.com>
 <atsPx0Wn9tyMzpCl@pks.im>
In-Reply-To: <atsPx0Wn9tyMzpCl@pks.im>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Sun, 1 Nov 2026 23:46:20 +0000
X-Gm-Features: AclHuK_jCczbnK1ZU3Pd6djjyvwLOv01kbBOeyVc2Aq78ke8aDax9sqvZnU9bpw
Message-ID: <CAHWeT-bNKp_1draVXjgqVHKLCaa5yS5Fr3agEhdaurXfy4owXg@mail.gmail.com>
Subject: Re: [PATCH 4/5] refs: stop calling root refs pseudorefs
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Oct 2026 at 08:42, Patrick Steinhardt wrote:
> On Thu, Oct 22, 2026 at 10:28:52PM +0100, Andy Koppe wrote:
> > Replace "pseudoref" with "root ref" in the help text for
> > "git for-each-ref --include-root-refs", in comments in refs.h, and in
> > comments in the bash completion script, including the one for
> > __git_pseudoref_exists(), which is also used for root refs.
>
> I feel like this sentence is somewhat pointless, as you basically
> just explain the diff.
>
> > Update the description of pseudorefs in refs.h to match the glossary.
>
> And this is again info that can simply be dropped.

Fair. Dropped in v2.

Andy
