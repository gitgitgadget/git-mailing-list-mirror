Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793167387;
	b=cUGcl74Bf38XmrFxk5Mu0H0xFqIwznrdjZOBlkpYbBQ3k4U9obx8zot0XUcpd+3T5baZ
	 NHLfgJ9cVQvInp/J5ppM0dFy4XV9R+zL552XKw13P9uZYeP6gOk00XK/2uzwxiB0QQvUe
	 wzsJgt2HmwlvtpJZkYi8gBnoeaTQEZBJT+s/95Q4hnUJ/sIWL33voOYU9lVNzEw2+H2u1
	 FcSK35pkjdjOegXW5Jxt0fSSNXuW/Oa0JPpUSWvZpFeuqaACKVFmkbZ0NZG/HwIFapal+
	 47kdsCsWkEo6W+0LTmQDPGnkiCEb15N60Rx7fYqvZFr2pOCgMSQyjKdAKldWoEF8Ecw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793167387;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=gubt4KhKgtI2K/R1GpM5dFmSs+tRBXWlY4doN44wm4U=;
	b=q1VhtMp1y1KJkPK3VkUbH47hW5BS/41flzuQqI7oqUTMtQuaw7swTIiaD3dnEOeuTsKP
	 XxYTJMnxBYF6ZdpWLrfNUTCAVN3johkd/hu4OiomszExrPALxZ54b989T0NDAIW9ISMFy
	 8D2r/gwx5hTxbFzApKnes2TmaAaUQrl8eaDJVMdeoIrMh3tXz9Gl6eFxvJlMEJoZCmLHw
	 cFLsfYGRlPc7nRkCsi9DqwJwdpTfX8lZn9MwY7COEWu75oReP7Gn3+gTBCo/iZY7Up656
	 ZEfvyfy8hTV4lPPO1bhXgSED5D3yYWhHcK+QqjNdhI/TNNeojupVts11K0ddTAb29WQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=fail header.from=sunshineco.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35444606A323
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 06:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35444606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33c10faf6easo97711eec.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 23:03:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793167386; cv=none;
        d=google.com; s=arc-20260327;
        b=OYMOTYAwFNckfKEDHcgmsyet4bkgVnV9Ml/qNrYPnax/xlU62C6piHjUknqan3ZUcM
         3dBUqSvKPeDxygeHXmwpmLb/1CHIRFa+WLW7ORgGJCfcIejkxccig19KbgZKi38YRcXE
         9/lXyC+grTw0WuCE2ig0SdY+hyqrOd4iwYKN/Ya2nfOKnl9hYngbACopMlpUdj/aBO2H
         qqQXHIst4Y937oSevQdCfqZMizupNtuK+bpKuM0MjxqO68xWikYq8fznp/HfhJWSRSTa
         agCcV6FZJ4dlNpeOkidN5hEliA8a+5W7qsF7tXxFQC4qLQmXmVmL6/r8LNqGlz8TxRvO
         yDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=gubt4KhKgtI2K/R1GpM5dFmSs+tRBXWlY4doN44wm4U=;
        fh=HLdWuAsu3OQx1LuHyCAOW0o1pUgf3OALFgOfJRjqLms=;
        b=Hq2bqzskInrLIO1b/qnihx1BhglbHjrq/FLgK+S6phOHxhQLr7kmvcU7MKsQwekIv0
         fvCA0nPKu0SUbEGPRpEM98AMQ53vdO8LoS8fSop6BjF51NmIsr0HJmjmopQTDhhmc53p
         ScPZbcODNFOerAac+vNVB+j5+pusJZ1qYlx9ipcaFluYq14XsyK2Rf88mlowO8Pxnf9R
         lkmZ7NpxK4PaYeL6Zyh6axrORFQtlgzWXFsGpAQaoRdQXLwyi3FbX/6pluVnI+1iXfQv
         P9zdcmlTLnQzz9EhQSJxxhI8u8d9B+piY/2mUQLlEeJb3h3sFx0+IjOVu0lS8/TR33IS
         E2TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793167386; x=1793772186;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gubt4KhKgtI2K/R1GpM5dFmSs+tRBXWlY4doN44wm4U=;
        b=dKlpgyWtSpwZe46SjlQiL4tTtUF9j6Fn+sMbjwA5nhzsHZJw6fYDZuxq30MBQzAw8l
         3JeEH1cXRCQust0pPcrm7MLQKMDKRixA5iHT2U0esZyQn954WBkSvRxxVGdpyEgQrHYT
         rFtWEs0iXWOJe/8GB8OZ1b1JBAtfSia8Ts176TR/JKHcv1m/RsadbxR2hGHMw2qqiI5f
         jj3nXS45u1ozIOA1JbR89dx/ILKacNcwJ5XXHXxA4dn+OIDQL0uQPWoHpSfQ7U9+KW81
         EEZjFXacndHLqCCLW6IRWojZhKVJzHiQJVZkcLSVSlTc54KPqv+J9TkLnAfgLygIsmhf
         qVWA==
X-Forwarded-Encrypted: i=1; AKwUvBzFyinc0zGOXcMIeWHc6zgkYbmhF3O1L1iKthSGW26WsYGIAUgxwImlxDWuGbm4jlnvR7s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKOS2nL4yatfVFW1TT0lTWJLWL/1HGNhNptQrw7Sxqefy6havm
	GfFhxSPy3FK7HwMRH5QFSK1I24D4CFc1nUgSOnz+1h4RZTA/HppEhBqBgQdQQ7vFYHj04x+Wurj
	qs3vnzVwDVtoHviyKYj84g8YRj+yPYyE=
X-Gm-Gg: AYBFou3CSx5Z8tRfwCYKC3iGNgh7btLEaIoun5EoY74rEBtzhW8P5vNu6Ip1ktGfa0r
	5HKF49MSWz7k7LK2ghl0DgpAcQn1N1vZ3a3rldAABErikCQ5DMyAY4IOfNjUbD4/rgEOoFU5KyZ
	yu8yDFiKNfCzGUHwRf+75KGPDCt8UnsOBaFR2oVmGHG7C29VkvQXY9mmu+v0F9fVJzMkyy/ozqk
	LcpnxIxPG4mwCx+lOP96SPOdeMv0bpa0szaeKt2ViChLuINWycNEMXd0Zichie2T48a4GcUFfT/
	SvNtk+rP4GVWWJXk4SKlzj9VDlOl+qvVmNzMvmvQkzrvKEdJgxdyidREu+qcxYWZZUH/anhfc3P
	4aVsmpfI/PhBF5F1EgF+/bTpPBx4zFmDSEMajbad4kt0ZcLlwelwRKgRmB8LgnszJj/jix7k6jx
	UlVKz5vdnSwA0PRjMP
X-Received: by 2002:a05:7301:e109:b0:368:1f8c:5f23 with SMTP id
 5a478bee46e88-36a1fcb0eebmr3409727eec.0.1793167386265; Tue, 27 Oct 2026
 23:03:06 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAPig+cTZEcn_5TG0iMVJJym8Zhu1KYP+y9Oc1J=JJgDYSzNSdg@mail.gmail.com>
 <20261024165311.57387-1-me@jaspermayone.com> <e08fd267-7017-493f-8f1b-d8dfb568b5fd@gmail.com>
In-Reply-To: <e08fd267-7017-493f-8f1b-d8dfb568b5fd@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 28 Oct 2026 02:02:55 -0400
X-Gm-Features: AclHuK9OE01FDcVpAVQSVBNzWS24seJRMyz-iJY4xv-XNC3riTFMA30AnbYNZ9E
Message-ID: <CAPig+cT6rxKptqSEKuVbi2FafBqh+DfcHAkHfz2-=SH3y2hfyw@mail.gmail.com>
Subject: Re: [PATCH v2] worktree list: add --branch to select worktrees by branch
To: phillip.wood@dunelm.org.uk
Cc: Jasper Mayone <me@jaspermayone.com>, git@vger.kernel.org, gitster@pobox.com, 
	haraldnordgren@gmail.com, ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 10:47=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
> On 24/10/2026 17:53, Jasper Mayone wrote:
> > A worktree that is rebasing or bisecting a branch
> > counts as having it checked out, as it does for "git branch -d" and
> > "git worktree add". <branch> is a branch name, or a full name under
> > refs/heads/.
>
> That's useful because "git worktree list" does not show branch names
> when they're being rebased or bisected. The commit message should spell
> that out.

Aside from Philip's excellent review comments, I have a relatively
minor question:

Rather than naming it `--branch`, under the assumption that users may
eventually want to filter on other worktree properties, should this
new option be given a more generic name, such as
`--filter=3Dbranch:<name>`?

If so, that potentially raises the question about how such filter
options should combine. It's obvious that multiple
`--filter=3Dbranch:<name>` options combine via logical "OR", but a user
might want to combine future filter criteria via other logical
operations (AND, NOT, grouping). Do other Git commands set precedent
regarding filter option naming and logical operations?

Note that I'm not suggesting that this patch should implement such
additional filtering behavior (it should not), or even that all these
questions need to be answered right now. I'm asking only, taking the
above into consideration, whether this option should be given a more
generic name to avoid closing the door to those possible future
enhancements.
