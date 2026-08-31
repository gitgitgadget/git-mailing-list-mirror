Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E95442E40F
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197527; cv=pass; b=p0z0Hs7PbvydikPUdQ2hdfkUkklQw5VcYSglF7k3145Ew+H4JWhI/zBwL8/L7fnuZBttm5CfeJwnJJPrbiEmuvp65P1XrYxayYszkeWfDuVSQnbKGcI5Ye9I1EasocRdzo/N7o/iTlKpM2KHB3HctsYkUCKlvKfIke9sFw41unI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197527; c=relaxed/simple;
	bh=pfyhHEo6qbAqvq+bBns1w5Cb9rEWv3dODZB9bkcQeQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZK1pWeloF8ebB8fACUM0DPOh6pLSUaV+zufsZlYFOp6ijU7utih5jx9lZWpNzfARJkNueD85KV8FIRbCw5wDEgexc6X9yNhNegv+FdT8/4hca4AeTswpG/9kPyemG/94uyACvV3C0BEU/PjN7g+ozmuBkrIfyitykpz6fTM7L1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KC+4wTur; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KC+4wTur"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-46add2afca9so558083fac.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:32:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788197525; cv=none;
        d=google.com; s=arc-20260327;
        b=G/7OSbJ8B25c2Kinkz42OiKdh6I5Xz4DcNDjMUl3wCEl5V8d1ALC5NJuw2oaxiGcCG
         xmPuu5BvebO36+JqSZAugexSZ6giD5dp0Y/zMTwc3YlGuyUx7mcFWsgiQr7KxZqapFWV
         VK5b2sLCHK1PrduXFWCcNgubodWZ19/LQwR6jNldOfd6B2dyRb9m3Evm0iVXbqu0MVdo
         RirZ0CrcC/XE/O5FD8RpAl1xdAhWIUS6gtVeVlmqujCiOhSlon/N+xuQ5Ps9FXU++Kvc
         zVaGNMtA2mgT7cq0vvNNZGGzU2+2SXHvcJBA74EftELESqcTuZ0ChT3Ccpa8o91PvIWr
         5uGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wND3qKLC4u0eg1zeSgNvnmNWVYb4aVaT/tnoG15cjRk=;
        fh=GZ+5LOnPfsFRXrQVhmHffzdXgnF1JGHep7G9YE+h4TU=;
        b=Wj3IkZV7W8tfWACF/m9CQGviaJ9+OMEFI+ZforSOznLkOfLIYlgpApcAV7RcgMDYgs
         un7hsqpsshM5L+mhtL4uYORdM8ihvCVcEhN/t/5yBvO+4IFBlnz2DwthQGBBlxyw74Yz
         MDVj/CJzooOGS/umB+Ia658WtXczZ+UVsMwlVDr4OH6uKY5wGLbRaLlDb2VKJf7iU9AJ
         V3u1IdjmKh/YShR12q/FXTrqukHTLA/btc9o+oqvhBur7gi9aMEuekM20sS0k5BrVhKY
         Yo65gtiiSHxBPkECwfN0sv4Iz8fRlhQqtbQY51i1tLu2Oezf5wk/4Af1gTGp6JiE85rd
         gXvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788197525; x=1788802325; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wND3qKLC4u0eg1zeSgNvnmNWVYb4aVaT/tnoG15cjRk=;
        b=KC+4wTur7qwGreWUT2fOk+EIlMQv0wNkjCWQ2Fj2iRTjbq/SBZOhtmCNS8m/0w5bJg
         2Pz9Gsx94L0sr3JwWm2MXHgffwDnfEDIJc+hjbXQ2SVuP9f8dk4E+LmUDk8FMkymtEpA
         L5piK9XzEZr+O/jxKq9r7GnfQhTAEnHl1vQoieexQw65wlgK8032BRvNqU4D+wTs5Ch7
         3BvMef+wJlGOBhtJXagRNn7ZCfpEB8v+Pw9jSr0N8d4naCtmk0Lkze/HRBcodVbyqnDY
         kpMfqKp5PrGINE4Ncuy0dDjp4IQQw+Ax4RIwMyQaOhYO277yiqgW9u82qNzJTO2reTUx
         IOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788197525; x=1788802325;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wND3qKLC4u0eg1zeSgNvnmNWVYb4aVaT/tnoG15cjRk=;
        b=RbTvPKgR3Nrm4+OPVi9/er4DFov+qwP6jIStKebt4qjhrxkyBHXPUdCEe9PMjF+0kl
         AuIvym5RB0XxfaIfuEl4UCCaJUAcwgeRc0L/fij3XW3CLqhsI2E6Nz1z5gESEAYi/XB/
         9oHNKXmUIMDxQ6jzjUzWt7/QCTFb2uSknEBEqw1JdhmuPPzLc6BdrqlQqWLnEcsOoBs+
         etpBbieohM7elp/UEX5zlvbYpxVsvI4QeR5L0qkPEc3759YYI/Ww715pSEGH6ResglWz
         MutXUDVEm7mNM+ZeUNeqYmTxRb770APHv9dZp9lL83DhfiSeY0Fa/oY0sJ0cBi7yEhJO
         4Zkg==
X-Forwarded-Encrypted: i=1; AHgh+Rp1QTtK1hKUCkoxg5ozNo9yJ/Pawm07furF4kFIKjIQAL8Sl/+POYysEJFWEkkYLea9Czw=@vger.kernel.org
X-Gm-Message-State: AFuF++ngZnXodQshhDZLioLPaREK4JYVxLPonlBmQnIjHTUskzR3AEeO
	P4RYHF9SjRvTH6nHWboIuy2cJtdT62gw4z9ShmVHkHhBrccz+bgt+PnqQRtpxknCayJ6wmkk0tq
	A+NLgJvOASlAD1d1k53W/JkGHWDvzhPQ=
X-Gm-Gg: AR+sD11gvXOrM6XM7LHBu+cc3v2zB8wU7y+NmcU90YsdG3zYDphT30avwLyEcLkLD5Q
	Emt5SDnD9y0EcBx3xt1DW9WwDW8JTxVYyV/7KRhJ6xQwPB4raziuJ1X33gtoPUBuLGDxEtXZaBZ
	Sb7dKChUgDiukj3bDLOfXxZKaxRgFd6IATzd2pL6Ovd60AVfuWSDsrgLgXvoAXKv5hQCSgr7Fc3
	UqcgG6/ENhVJXGITO9orMCS+JfM35F/CYCbWIKJ9JmpHuuEkvT479EvK/YXIW7WS57puTW1i2PW
	+jrIedqolwsykd6Ck+ZyZztb4REmgZACYr+feS0mOWMR5Z9m5HEOKvlxTONFP6L5gne1KGqdUDL
	nl/clwtU/zBSHHa8far+FJiaywEavgFH0xhcVtLhCgln/9RgcSunieOYa4HAFzQ4=
X-Received: by 2002:a05:6870:48e:b0:465:2bde:8b5e with SMTP id
 586e51a60fabf-46835a0974dmr27978297fac.1.1788197525145; Mon, 31 Aug 2026
 10:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
 <pull.2171.v3.git.1786583137.gitgitgadget@gmail.com> <8ed22c02a192e10ab46c7df61e92a3669faaf25a.1786583137.git.gitgitgadget@gmail.com>
 <apUqs8N3EnTFngyQ@pks.im> <xmqq33vuz6lo.fsf@gitster.g>
In-Reply-To: <xmqq33vuz6lo.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Mon, 31 Aug 2026 10:31:53 -0700
X-Gm-Features: AcwNN1VLW3a-X9fmsWZ_rcfKV6bFGhhuAWpXrAnE_xaS7rAjg-WfgEjouAZN-9I
Message-ID: <CAC2QwmJ2AgU0y77tmRhs=Ycx-CuWEzzfKsVMn98Wa1EUvHHsKw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] t/lib-httpd: make http-429 first-request check atomic
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 7:51=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> I too find it disturbing it that the messages from this author tends
> to contain material that triggers "it may not be wrong, but is it
> relevant?" reactions.  More does not mean better.
>

Thank you for this feedback. I agree with it and will avoid relying on AI
as I have to create and edit prose for documentation and cover
letters.

> The above made me curious enough to ask a near-by Gemini to distill
> it down to quarter of the original length without losing essense of
> the original.
>
>     http-429.sh marks that a 429 response was served by creating a
>     state file with "test -f" and "touch".  This check-and-set
>     sequence is not atomic and can race under concurrent Apache
>     requests, causing multiple requests to claim first-arrival
>     status.
>
>     Replace the check and "touch" with an atomic "mkdir", which
>     fails if the directory already exists.  In "permanent" mode,
>     skip the "mkdir" entirely so no state marker is ever created.
>
>     Omit a regression test, as this concurrency window cannot be
>     forced deterministically without artificial synchronization
>     points.
>
> This seems readable enough to me, but may still need some manual
> clean-up, but this experiment told me that "A lot of AI-fluff" is
> not something users cannot avoid without some extra work.
>

I agree, even though I have spent a lot of time trying to "copy-edit" what
is generated, the end result does tend to be verbose and include unnecessar=
y
detail. Compared to what I start with based on my initial idea and generate=
d
rough draft, a lot has been edited away. However, I do think I have regretf=
ully
avoided doing some of that extra work. Apologies for having you all read
unnecessary AI-fluff, I will write prose for documentation and similar from
scratch.
