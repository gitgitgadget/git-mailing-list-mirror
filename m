Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1C91BA870
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657433; cv=none; b=aR+YtwpiB8Q75F5TYhuwvACP9sM2tv4TatZ7pACsFXAq5MAlCk+toOPamwEKLrVC4Kd2VsZKPRu3E6HlOoh6saIJfI1qgqU4qfkH5M4K5IIttVUjAelI3GA1S7mDWir3SIVTNykqlF+L8qqiFwvlzVggHj5oaE4kHhqHxYg3DxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657433; c=relaxed/simple;
	bh=oRAqvNfl/Sz8msEn4RmSfjdfVtAOZzA8L8zGwkquOE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6X8hhc1hVgV72gfTMPrcy7M0yhCnDOrcbdtOu0XhUdtakBgxXmR6eObg9kT/JhvRFiftpissp/wRfKiXn5qUwZT+41Jhh3mLLlVtoKuSQhyL0/w4DCkyUPG3AoTzypT7ZqrdVsF9smM9VthA/yDi4hZ4DLfDmjmmSSyIP9d6O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyK0RlAl; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyK0RlAl"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2642cfb2f6aso106757fac.2
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 10:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723657431; x=1724262231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRAqvNfl/Sz8msEn4RmSfjdfVtAOZzA8L8zGwkquOE4=;
        b=jyK0RlAl8oqIWpEPq/o/H/OVRnuBEqDQuvr5pS1kgWkbjCvzj4eQdxaThOseNV1nAO
         zjbuRmIx+9b8BuOX41bBFVnAQRVU/pdkLh2LChAwElAplFOxqnZglAbED1jJIBbF/sXf
         U6JkZlef/OTjz9uJcC3xTxIuDRwVN1EqtvPUfy2ODwvkpLuq1zRZa+ZVQyqNns/O19eM
         D1NQLksu99/wMODqwp9YKBv1cQ2ZeybEEjkR1vHnkFgXUCIGpOXtRZZjVNv5ibWg93BP
         LLNH/uXwySN6iZmPyI8HWH/gTQmkp55CYkInF1gGqSOYZnHsvdp/S/DRNMXA6U9e5vOb
         7FPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723657431; x=1724262231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRAqvNfl/Sz8msEn4RmSfjdfVtAOZzA8L8zGwkquOE4=;
        b=qYQ5czGCr737gp9Z+OUKvffEa8nBoa4hDY5wmhfCFjTN2jEmRbEH2/7LvD65kWCHy+
         jYY3Oo+EK0XnWKb9dRjWhw/7z5zEGGWnhqxtaRAT3IWpd8/3eQVU4LPEneVq27aSfj4Y
         yNnve0ovlUh+ghZX/vvo2SLN34iDCRHYpGcIgnosnhuHbEWCHpHAzJsHTq2iXdDoZgAZ
         4ys0yXEz9wv0lrqX36VZPrdNKteSoaua1GxBVWhpKc+8px7cU6f+pi+FpDweOMnp+IO9
         mDVu8e3g5OmXTF8VnfYCCbM81wTPllupb/KUEpdQU2yTMaVyUs6GZ8FAyD7U0AlvfZtv
         PKjw==
X-Forwarded-Encrypted: i=1; AJvYcCXA5O1obQa9VBHzfHG1w455EOaHP/V8FwfalPfpHH77SY5BNXcRrpTOyC7M9BAmvnnVXNX8W61bAEunbZMdxCFseC0F
X-Gm-Message-State: AOJu0YxP2MUGN4O1yFqBt2yIUAPNBStXjxRYhBaNBCjLWYoamjo2w+Br
	k2igD7y917jAmJLYoNucVkgp9sjFxOmP9KLmDI/x2QbPAl19XM7hBI6F7agdRLql+YqcKFJAZTf
	pxWVdRP/DMycdcxyYAOQtQ4rly6BzDw==
X-Google-Smtp-Source: AGHT+IHKHMIicPdOkmjwvZlCR77BdBwSjhmRkzshFkmU4KRiokdn5SJ+jr74oZ18GzkXCPzBP3j/SIJ1dWR6gLonGfo=
X-Received: by 2002:a05:6871:582c:b0:261:1177:6a5a with SMTP id
 586e51a60fabf-26fe5c2f738mr3865641fac.50.1723657430887; Wed, 14 Aug 2024
 10:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813-jk-support-mailmap-git-format-patch-v1-1-1aea690ea5dd@gmail.com>
 <2mvexuxcaow45ifnqmrvpn2yz2ecxzazsbo5ui7xaiwwpzt7hr@mvl6ehbrhrp6>
 <c0724297-1748-474c-998e-803e6a062a12@intel.com> <20240814072637.GA2077794@coredump.intra.peff.net>
In-Reply-To: <20240814072637.GA2077794@coredump.intra.peff.net>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Wed, 14 Aug 2024 10:43:39 -0700
Message-ID: <CA+P7+xrHDX-=fqJTM7_4cQp5PJz6QKbM78JG5tYtZXJLbiVmDg@mail.gmail.com>
Subject: Re: [PATCH] format-patch: add support for mailmap file
To: Jeff King <peff@peff.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Josh Steadmon <steadmon@google.com>, 
	Git mailing list <git@vger.kernel.org>, Anthony Nguyen <anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024, 12:26=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> On Tue, Aug 13, 2024 at 05:20:41PM -0700, Jacob Keller wrote:
> > The internal tree commits are already baked and can't be changed. We ca=
n
> > of course fix the generated patches from these commits manually. It
> > seemed convenient to get mailmap to do this for us.
>
> I think that makes sense, especially if the caller is specifically
> asking to enable address mapping. I do wonder if the new format.mailmap
> might be surprising for some callers, though. For example, would a
> rebase using the "apply" backend quietly rewrite commit authors using
> the mailmap?
>
> -Peff

Ya, I think the config probably doesn't make sense thinking about it.

I also realized the actual problem we have is that the mail we send is
including a dead address. It would make more sense to just allow
send-email to translate from the old addresses to the canonical ones.

Specifically the issue we had is that an old commit to the internal
repo was prepped for submission by a new owner, and when he sent the
email, it automatically included the address of the original author,
which ofcourse no longer is valid. This resulted in the mail annoying
several people due to bouncing.

So the real problem to solve here is perhaps some way to filter the
mails either via translation or removal so that we don't have it
tagged to or cc a dead email. As I said above, its not like we expect
the original author to actually respond or own the change, but we did
not want to completely remove their name from the change, because they
are the original person who wrote it.

In our case, it may be more useful to have the mailmap not at
format-patch time but instead at email time...

Thanks,
Jake
