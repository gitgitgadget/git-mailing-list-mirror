Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECB135C190
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166407; cv=pass; b=dGzxwlp6Yn5FZy1D+jp6hTkyjxIJY0Y+1NLZ41ivSNjUzqHQYjsXoNWONn63DkPi8iqIiAJYb6LqTRvcFiHJj190Z80yef/Uv9jeJlIDAJH11NI6lQO7ay0aL3jATe/sFcxpbroh8C2G+aQdKUMDSiEGDN+FClP7K5hjKdBRo1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166407; c=relaxed/simple;
	bh=O8mbmEojRKGwJlJ4qM7C9yJQAItDzyEkhw2XWuuwU8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2qQW6RhKxOBkSpLkyisaCtl7+xPAf49ADsZftaxDqrC0XE0VL4qzjw9B1NLfHpRd1OBGPUcv7ZIDOx1mXEwFPX2mnGpbj0QCPwWSLJ8GChEkHW7SraKb/T1iFILz8wJ6UgPdUrRIVlhh3/GZO+GejlGE9B5vc1GYHU/ne5uqVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6d15QW3; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6d15QW3"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68ced97b6eeso10365590a12.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 01:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781166404; cv=none;
        d=google.com; s=arc-20240605;
        b=L1KwATDh9AfnNYKqs9Whmiz1Ugb6L/5TMsEqzE37YaqQ8kqpzoinsnvsp+qTqq59Dm
         IMmL6jE+/gxN4EifL1VBB9hK+lepnxHSnGD2CWFbKtoqyc9n16rdfUlbUftUiOAnGB8m
         HuS+A9koFYrBpaBYD+TetLOaufKQltFmjEw7XMQrnM8tZPxKljE86D+3zdMBTq9DgQlp
         E5KNu166jJ2Efnji6dBc3+Omms0B4ctMe05e5c4LJD/wg73Tz7l1zCq67nh1zu8Ynx6j
         R7JCShd5UOORn4QN3pgzZrzwj8NSmVhANUJTF4MTBs2X/63bUyB+9laQFl5GxOHXjLF2
         ksag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O8mbmEojRKGwJlJ4qM7C9yJQAItDzyEkhw2XWuuwU8M=;
        fh=mZixHP2Ewss2SFJr0NJjUylVjNy0qV/BrWHw1aJTsFw=;
        b=W+7ls050zuau9+grXoPeLQ2ZYlAy0YCxUjEO4eGWO67gvZkRxm0hSRzQi8MLhNQpiu
         pxt2nhP3WzkRbQ5/LmvuCvI7OMmXctFY4fUqaXgFv32IdvYF6yv2wmbRQaWF4JTlPjtT
         Ine4zW3XmhY8bsrJaH1xD4iT1L4jZxB0uRD6j7Z4t6AEOjVnKKc4568ZSWxNi+tFZjH6
         +mYYFjNw9FliCFulqP4MgKYiOJC4RYnvDDet7LVqhyVt1tkaHZeK7oL9cDhJuip8QzM8
         89eN70TFaBi0+0Che/1meyv79TAd0Jc+wXICar1r5ulrgSoiY12ZOUbCNV5i0jFh9bHX
         bKxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781166404; x=1781771204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8mbmEojRKGwJlJ4qM7C9yJQAItDzyEkhw2XWuuwU8M=;
        b=B6d15QW3TX0y4DrCTqqURCNN2ya3BaaRXgoWuNHQOcSQzAVuvXDIC7K5VDJHbqjhFV
         SCs0Gau7YVwN/YqdUfTYHS2/AIcOo1CqD0r/473v5lnq68na0z9L8I90gxuQKEgajKBr
         TVAnSVAaYUksHdKOLYv12zHjekDSvkd0mMTQ3ubxkf/6ZnzwgCnGUoigkAzyv2hU7wIa
         Pud2BGPBjLM2ZdmFQumnHIaT3VcIwalAljjfxlmXgYcuWV1J+YY17nTMk/vhZnp3ttIQ
         IQKcUYBHNHIKp07d2TK8wytsiFPVvh1TOowQBLpf+elfUJdCjvvRVfVD/DptCrTtaFOv
         jC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781166404; x=1781771204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O8mbmEojRKGwJlJ4qM7C9yJQAItDzyEkhw2XWuuwU8M=;
        b=fwS1chDbRBUrusUpjNPd+3baDwYdxh2/t4UC5DV+MWz4wLuVzr1ebR55DJyp7RxyZd
         5LClu8QNSaGA35NMvCyu3vXJ+i2bI8jpuleYqirDTo5xb4FtJ3XedJgeesPLaAa/pDI8
         tVdCIETUtPeyNvJnckuFgatGYJWMrdU8KeyN0/EC0Bg13LuDGefBCUCTQIco7jz2xN9F
         gCYGNGfdhrUFv5e9Co8PL9TKfJlJs2MciMB4hGr4ENp3QEZFXgsLU4mMOIZS7Tq7mUSt
         xfViHYwyAaJIIhp9wouiurjiTPb6isHQnmvp9NlAP90kZZUAqnQbpGzkK91pJMPWL9fn
         tQ2A==
X-Gm-Message-State: AOJu0YxoH+uoNWDyQldSSFvufVp6N0N24EzDuVKhABf1NzGvPZT3JXQ2
	5p4TowOqOi1/rthX7EMnUmrrQyo32ERJbN51zfYgZyRBFMXZsUAIfuigrBGPjyootwizOSgriGq
	9KFB8MMpvrlI30ywPVmyx5u/sKhb9794=
X-Gm-Gg: Acq92OEQgFVVhwsaf79LJ5yG9qeGOD5qM6G3ZhTGk8rKLmz16OOPIrsEI4iP6imhh6e
	OGMO3zLlxolQzBrALjtoHhbOu2QnYKUj0kPrAqOb4Lf9BkUVoKWErtu+n31gzjuEsTNz0bK8XT9
	LB4FxW3WEhvjFcwXNB1Qmwm+32NThlHS6KciguTNWFXAgNTuODmqy74q2yc3ev3N7a6bd2tTO7v
	iNJWpu+rtp4NITDm5yNmIGneA+Ybrzo8H15Tz3KczXI7rnfnGvHQ/Cjq4s99QtxyfBt9D8axEW3
	QZ2YosBISQFqL4W8h86JHZjm1GMR
X-Received: by 2002:a05:6402:2b8b:b0:683:e394:cc0c with SMTP id
 4fb4d7f45d1cf-6930e2aea62mr703218a12.4.1781166404321; Thu, 11 Jun 2026
 01:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2318.v3.git.git.1780555730228.gitgitgadget@gmail.com>
 <pull.2318.v4.git.git.1780742303298.gitgitgadget@gmail.com>
 <950f70ea-1615-402f-9cd4-3317bf177c5c@kdbg.org> <CAHwyqnUpiWmXo0SVr=7L-+cwA+qhVyqodpV-O4C46w=kLqaLMg@mail.gmail.com>
 <fdf7f988-d345-4107-845f-e089d7829c16@kdbg.org>
In-Reply-To: <fdf7f988-d345-4107-845f-e089d7829c16@kdbg.org>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 11 Jun 2026 10:26:07 +0200
X-Gm-Features: AVVi8Ccyqw5hHGL8-UDlp5KmBKTZTZpXkGouJvjJtryO8-od5bLg74kmFKFpGTA
Message-ID: <CAHwyqnVSnf9K50xgUjeHFM395Rvj_uTVvZ1U8EZayNDZeMP4Bg@mail.gmail.com>
Subject: Re: [PATCH v4] git-gui: silence install recipes under "make -s"
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 7:37=E2=80=AFAM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 10.06.26 um 15:19 schrieb Harald Nordgren:
> > What does it mean for it to be queued here, should I expect it to show
> > up on seen or next?
> It means that I'll arrange that it will appear in the next Git release.
> Until then you can find the commit in
> https://github.com/j6t/git-gui/tree/hn/silence-make-s .

Thanks! So does that mean that 'seen' and 'next' are branches that are
added to only by Junio Hamano?


Harald
