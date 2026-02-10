Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B0827E1DC
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770712817; cv=pass; b=pYxFqB3NBH9E67MOGQ6cQdvu/QKICtzMZ5e7s+ANhpP4EURECVKv2GgfrKNMuvRdq5n9ftkm2TWdrrBKACbJsxW2AikS2dybW8lFi4k7Vo1pV/kvgHj/+Zw8z3etXluRlDj432NFMgFMU62oBCHRe+b5QOURux2L5/SMC34jUZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770712817; c=relaxed/simple;
	bh=wnjeEobwYukPzNI+IjMGT1H8AFYx5XuHR/rF3jlKmB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGAab9+f1s/XBWWi944SxCiCuZnFsC540F+auKXbQPhLZDjnYucakPAkVEk0bMR08c06WZX591pk76JWWM9glgA6Qk+H/rp5UvU5FSffXQkth/SyFqYGzlawlj8dy68pMtGp95jH2D2xaG/FHZ9YLsKhuTwDAQhYk9TiLWF+tKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gU0dG8TR; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gU0dG8TR"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1270be4d125so1874830c88.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 00:40:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770712816; cv=none;
        d=google.com; s=arc-20240605;
        b=QlwzqhKhBd5XJV/NBb4szRoSqpDT/d1Z22AzXJ143RZelXyqPMt5msAFGyRInyLITN
         Q7Y9VFN3yJG03ACgcU/HW49t5Mg1wiF2jBuAYLVfrgneHTgSzw9tJg0a7xZSXW3vGCU5
         4JaHwf27zV6YVbh7/Uo3gKQteiXrNeefU94gz/j4qxGhUh4GyKkxtBYWD4Xc5q59Bu1O
         kvXXTEe/snA3D1xaOoCNNpSw4xZbCQX0+H6uxlJnBZB07/VpTJXNT0/T9/hGJEmT3QmC
         o5lTXs+mXw66AmSaUAjENvA2iiNqCykX0vL76V3WHjUPLHu/n+Y4YA2jV9L83umxrVMJ
         bk7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MwQ8A9wro1rQ+BxfFIFqQDLpRnOwzMEcLhBrRFjxko8=;
        fh=nMyJPDOOkWXHi4NomUE+OLjZftP6uMygnWXJvAYxnBc=;
        b=KoK2NN8YyJEG936oHwNz4AgXwiP+vGXTx6v6vj9edwZUxaaa7aGFN/0lritsR+hr/c
         jMqN6PqGH9l4/SqC6RfbPwu893pEBDKX15mk5q6tDulI4pVHa0bgAlGRzSX598Y9rzTV
         ZYx1N2K3rTexHcys1UiU6+Uy5PHau/A1MlOkN/q53p9t53P4MvrhcxQmfpm6MnoWMjWr
         31o3xwNhAXOQBEGs2poVbowdoFKubzRj1B4aNfe1Wp8o1FxDXxMLp6W5qIMz+Y3z1mmp
         u8pPM8y+mk9l+B3HgT0v5eORgbizYAyPQtd+z0VyGS1AD81un8WNSqZVHemCVQ1/Db6O
         lfKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770712816; x=1771317616; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MwQ8A9wro1rQ+BxfFIFqQDLpRnOwzMEcLhBrRFjxko8=;
        b=gU0dG8TRvsVzZ41F5vKkDlBSFTG1zL3jdWnmR/3Y9V86zZ/y/yRbWE1eoPkff6MvMC
         sLL3fmEcBWDE4TOjXgXj+FK3Sl0UwgkdPZY5LXxjTnjGzn4rpKxpIPguJEXwHyrtb1LO
         Tj5rcg+0D4/Ru40bY6H6UoSFShp/LarJEWdfT7NYzfcupe73kgptLynuCav1fQnwQWXj
         U7NmJzf+QOBtd89EiIkbQfdYx/om4PUlqntS0l53bEgh5bmXGlvTw9A1YGQilxBad2tN
         pd91r5Apahg+FtJjndaPjsAXYGYQT22JfnjGH4mcDoYBk655JWJ45QPo/3V50m9G89Qr
         XNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770712816; x=1771317616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwQ8A9wro1rQ+BxfFIFqQDLpRnOwzMEcLhBrRFjxko8=;
        b=tJQ14gGhWXQN2bBUEtt6T5o6HD/Qjv5iEVK5G1kRjmkpCFfdHRgFwI56R6SwfQMPwC
         nnaQOJ94v1h6fDNOxZQiPt94Wvtvnmju4n2DcHVCYPryh9XqkypOJCFGSErcwfouR0Lg
         VKtZ1sN8FNwUguXOSfrW/5O90Eu30JHxmNzVjXSa9uvMw67H88ZXN0hnn0y9KFBsyh/v
         cowieR0lozeQ4GiazLalQ0es6Uml2Kd1h/zrghTJUqhaDDUCM3Y2yPRb9ExX36CwKpDI
         BXR9dhJC0io+9qCpnyaJK/SRWiaMXZkjlFAPfYGUU3vhcgekwY2Olqhu23/zLnThqa7L
         XOAw==
X-Forwarded-Encrypted: i=1; AJvYcCX4yYbvNb5DUM7T4IygZPqBNoj8wC5jVudn/AhtKpDWKfk7Da4EArFYubYRgNtWhHGAl4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ5CJyE5WgVkSCIwvEItWPE1lxTZWGL5Jy7UOXQajBrFKbVZP7
	RFb1em7QJKCA//n80MF3mJ3bIsxKmpbyCVmTmrIlu3pYjly+mnDNLtUT5qhepxJouHvGQry+aqy
	bFBlontVUCXK7Fkva+/uKtJxpCmJ96pI=
X-Gm-Gg: AZuq6aJTdfILXhHSy8n2csMPf+Ze8Ny0xAVCUZ2nBcEMbd30NHTwBaT6L1eOqSA2MB5
	5mAmZYljb+RVzGBJU0/SFcWXPuZEfSIvZFBORbWVQnSJObnE+mQMbpxiXUnxHLAcV3Wx+wJGKyv
	isOH3HPD0ITlZdwAGnnB56B39oUQBMuDqBWSVds40h6peTF/cRQcYg4risqgZGs1Xn/8G7fIety
	mUWyl6xzaLYp3bsuWFm7DcHy+zP03YHFN+91Z5Ff1eDNS16skdeL5nbGuZ77p5TRwztNMUHCQGt
	gqHY/i0U9Dcly9AkbsgH
X-Received: by 2002:a05:7022:f97:b0:11e:161:c008 with SMTP id
 a92af1059eb24-127040596b1mr6985544c88.26.1770712815633; Tue, 10 Feb 2026
 00:40:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770127568.git.belkid98@gmail.com> <7e3082125df08d3e5fb2195d73698c4c28c6645e.1770127568.git.belkid98@gmail.com>
 <xmqq7bspcq3c.fsf@gitster.g> <88570b6c-2ff3-416f-b63f-2fb7c80c5af8@gmail.com>
In-Reply-To: <88570b6c-2ff3-416f-b63f-2fb7c80c5af8@gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Tue, 10 Feb 2026 09:40:16 +0100
X-Gm-Features: AZwV_QjIJSRukTu9JDd7vts-WtpKj3yaGwcjNaMV2m-kJuhUV_qAYK_izydJpfo
Message-ID: <CAD=f0L8jeLE_Zy-5aW+DZrM6JNgbwRcgWCdW1f7SJ5uG_2R-yA@mail.gmail.com>
Subject: Re: [Outreachy PATCH v6 1/3] environment: stop storing
 `core.attributesFile` globally
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, toon@iotcl.com, 
	christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	kaartic.sivaraam@gmail.com, me@ttaylorr.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Feb 2026 at 12:14, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
>
>
> On 07/02/2026 01:14, Junio C Hamano wrote:
> > Olamide Caleb Bello <belkid98@gmail.com> writes:
> >
> >> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> >> Mentored-by: Christian Couder <christian.couder@gmail.com>
> >> Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> >> Helped-by: Junio C Hamano <gitster@pobox.com>
> >> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> >> ---
> >>   attr.c        |  7 ++++---
> >>   environment.c | 12 +++++++++---
> >>   environment.h | 11 ++++++++++-
> >>   repository.c  | 12 ++++++++++++
> >>   repository.h  |  7 +++++++
> >>   5 files changed, 42 insertions(+), 7 deletions(-)
> >
> > I bisected our recent CI failures that break fuzz smoke test down to
> > this change.
>
> The documentation for the LibFuzzer [1] notes
>
>      * The fuzzing engine will execute the fuzz target many times with
>        different inputs in the same process.
>
> and the first thing that the callback in oss-fuzz/fuzz-commit-graph.c
> does is
>
>         initialize_repository(the_repository);
>
> so I think the problem is that the assumption that a process will only
> initialize "the_repository" once is incompatible with the way LibFuzzer
> works. Maybe we should add
>
>         memset(the_repository, 0, sizeof(*the_repository));
>
> before the call in initialize_repository()?
>
> Thanks
>
> Phillip
>
> [1] https://llvm.org/docs/LibFuzzer.html
>

Hello Phillip,
thank you for your reviews and assistance so far.

So I moved the code
 memset(the_repository, 0, sizeof(*the_repository))
into the fuzz-commit-graph.c Fuzzer test before the call to
initialize_repository().
This made the fuzzer smoke tests pass.

But the line below,
`if (repo != the_repository)
    BUG("trying to read config from wrong repository instance")`,
in the repo_config_values() accessor function
to make sure we are reading the config_values only for the_repository ,
makes many tests fail.

I believe this is because repo_init() calls initialize_repository() and
repo_init() is also called in repo_submodule_init() when creating a
subrepo from a super project, and this subrepo passed to repo_init() is
not the_repository.
