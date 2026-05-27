Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D9D223328
	for <git@vger.kernel.org>; Wed, 27 May 2026 03:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779851972; cv=pass; b=siXcS4hGI8AM2AZm6bCjJw4n2IqclgBP/FIPrYiOZerEGIQWUlBQ8JgeDICZAmklb4LOb9HAs9VQEsnByNAPt+i52IihdJZRea3BwJKPkbWmubjoRq7PmeomhsWnV55nEIWVeEQP5tBofS6ldMSV5Y3VVpXnE4oPtQhBQ2xVxKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779851972; c=relaxed/simple;
	bh=SW0I8vXsv2ZUTZm2SzG4udgq0JpQ5Hn5C4dBdKLt6sQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dD51gazTuzSzsCzB1fIrlYWW9sv2wP2aiKz1oZ31VFNNXaIYnNXYIvPOnG/oF10y2IkxQNqwUcSj3PUX2JOH2t9t8Nh2ROVaAplH0Jrc8Hu0aYGKdjYgDiq4SE423Qy02xcI/3D+IIUaXSEnXW0lapdxqEk498a5gH7nUONS4kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKLtvV6C; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKLtvV6C"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a8891febd2so14895050e87.1
        for <git@vger.kernel.org>; Tue, 26 May 2026 20:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779851969; cv=none;
        d=google.com; s=arc-20240605;
        b=jPZj8xAbg5uhABFOGZWR2VGyeUn8aXg4bkfDjAOBqg9l0uV8OOFqZI4Q7OnVIAmqRb
         8LV2u0yw6wglJfLmx/5i5nAp+0bf3WaVD/YC+BYCAz4aYyLMnW3/STplgGhMB4ZDyRpf
         VJNk741v6Q0NnXEPy6CvWoaGkMwy7KrEMsmj2JNenQz89rLBs/LYanXBhInT5FDoPz5r
         0Rkr2G3AGlM/3nMjn9a3HQvZ2618YIs1Qj0KHHdrC4czFURU0OkVW7Gz56xZPv7sE23E
         7OlrOFlM/uhKSdZydMEEDgd6nCQ8KUuqyI8fgusejUtxulwz2qPp5XQYQNuyn8xbM0w5
         JNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gc20RrV9ZQ6XQZqXyzt1szY2Egrna5O/OtjfqwJHBB8=;
        fh=mvlIbxGPxY9ILd06GleNWHQbA/d3d5suhJX8JZHV3JI=;
        b=MNN8WHEVL3KPynJeiwEEmW+ekbCG9ZfaeupMW1E7cH/Rjb/o7c5hS6ltC0eKBI7Ym9
         nwIdoqEoC/eZo3YcII1d7ss6crSevACK+yZcopIDKJL0pcMQSQ8ynMVQkKjY0sRHyNhK
         jvQ5mBsXLvnThltDbzvY8tcm7xDZHEiYWv0hl/GnhK0Ja2Y/6PwF0WSgKrMGGf9BPxP9
         2eHOqURx73/pDxuG3I0wloaUsZFbvuh3SduPZXsNmVmw0mcoyEHstpCOhntoq8SKM8u0
         0/a0jzgKfWm9aWYE1SeTBpZAR1SHuoLICMdUR4Xo0QpdRiN0z4lF+4wm97z3BsJpo6jW
         +eRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779851969; x=1780456769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gc20RrV9ZQ6XQZqXyzt1szY2Egrna5O/OtjfqwJHBB8=;
        b=UKLtvV6CWLjqT5dUlzSN+0zfiqiInaKvsl1j1RrtczW5NB29j7eEw6/lHHD6rqXga7
         qDodAehZE2p+YnsYE2K6QHwQgZh3VtuXJYHp8gnXhomn2ubq+vf34vFhqhP3zF3tXsdW
         VHlUCbyrp7E5DuEJ6UM71DLOCNzXuyy0LUni1ugK2P/SLqU156J8rs+4tR3GjOeuXoiJ
         w/anSEQOJi0ekv3Q9zOoPe2zO0/4v0R5LmGAOhwjd90+kDgfElYv1vLZAmx+t1k811C8
         dKa4XuY2Pe/5j+bbFHOTtoBBfCJtrl2gm85jwjowQesYWYgf0tnsN0fcLanj2OENoW6A
         FOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779851969; x=1780456769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gc20RrV9ZQ6XQZqXyzt1szY2Egrna5O/OtjfqwJHBB8=;
        b=fTCuHrhHFcNK8HayHvXic3DzT9LgCiMU3Z/bvzRB70SooAVHBrT/pl6WeVHmsq1R1P
         qbkGIVdz5iVsnRWixx1CWNhvatWtNVQznd7O4fgLVjC9h/Gq70n2oljG2aZBvhsTSq/N
         BMslO6K1eGwKZvmogJTvyLdrRDMzdY9foH4OK5ryUCPGrtnRn2BL0+Jj6zgPRQgznRm5
         TZgGeVkd1GLmCMcB7xw8SDvJrjBzZ3QayxD+g54NzDLaBN/IeYYRJJSprRyn5ZcWAml9
         qYD/0s5fN3or+YQhO/JmEmzZwUvaWTzQZeHeFnoy8EdRRqvUjGll3rxqMNYVLJvXZUXu
         j0vQ==
X-Forwarded-Encrypted: i=1; AFNElJ9bXJ65snkVYvZ+MyOwZn3wT1GB8UFKIBLwFX1FlG16+1WK0za1Yo4oINQo0MAG6NReHCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsN1ysUXAaqHj3MfCCYbVXDs3y4rFWg97mkRgBtu1gYjEoZKEW
	ykYBnwggBL+mXsfuVOil8YdbxWrJPVB5JMkHnScxg1/XiR4vWorMF86ZU5LvIi/xaghL+PKiol0
	OzOlW+arC/OhzKxRcitieMkzJXNErFKo=
X-Gm-Gg: Acq92OEoKkejLo8clq634bEG1O8K/Pt61ODXFEzU/WbeDwvPHL6GbyX4m7draditI8Y
	pKs+pgVN8Yau5LAdtnoXMdhl5L+YASJk5dRkMbEbgb5HKrUJ5tKBRFarZm7wRAYspDmyhDSkZ9S
	KCWV8lg4fz6WJRtY4vfTOsaXIk1s4VDzR4gGohQGm5Yn0uhCP7HJjllxkbTzJpUxqW9ckQN7Ncl
	B8PMC2S7vKcEqSA4TwqefVFpS0cZdj1Ap8s+Ygi8Us/9dgiOU5UOLGt9Qk89eCvbrl12RgiextX
	VAUAn2EXkjN1cHtU3io=
X-Received: by 2002:a05:6512:6c4:b0:5a3:ff6b:cb5d with SMTP id
 2adb3069b0e04-5aa32397964mr6500487e87.19.1779851968714; Tue, 26 May 2026
 20:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <02663c67-01ad-4dd1-aae6-9e9706f3d040@fhannenheim.net>
 <CAPx1Gvd9+z0th9whCbcA60_bWproPp+kwp3qDmhQOe4G=0=E6A@mail.gmail.com> <xmqqy0h5lfa0.fsf@gitster.g>
In-Reply-To: <xmqqy0h5lfa0.fsf@gitster.g>
From: Chris Torek <chris.torek@gmail.com>
Date: Tue, 26 May 2026 20:19:17 -0700
X-Gm-Features: AVHnY4Jqz8sfn6B2Auur55I0_v92YbwDbtJues5m-_xiRygQvQH1QyznoW37oJc
Message-ID: <CAPx1GvetxY1T7cuFN_xe51EURr-ED2BqW3E82jj90ko3PSYSyg@mail.gmail.com>
Subject: Re: git mv after the fact
To: Junio C Hamano <gitster@pobox.com>
Cc: Frieder Hannenheim <mail@fhannenheim.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Chris Torek <chris.torek@gmail.com> writes:
>> A flag for "git mv" would be convenient (and slightly moreefficient ...
>

On Tue, May 26, 2026 at 8:09=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> May be convenient, but I do not get the "efficient" part.

A normal `git mv` renames the index entry and the file in the working
tree without running `git add` on the *contents*, so there's no new hash
computation.  Presumably a `git mv --after foo bar` would do the same: veri=
fy
that there is no existing `bar` in the index, that there is an existing `fo=
o` in
the index, and that there is no `foo` but there is a `bar` in the working t=
ree,
and then it would rename (add-and-remove, really, because of sorting)
the index entry, without scanning the working tree contents.

In other words, we skip reading the 3 terabyte file, or whatever.

Anyway, comparing to `git rm --cached`:

> I think the requested "feature" is not all that outrageous.  It
> would be a similar value as a morning-after correction measure for
> "oops, I moved the file in the filesystem without telling Git".

I agree, but I also don't see it as valuable enough to bother
writing a proper implementation.

I did write it up as a shell script though, long ago. Adding it here
via gmail would mess with white space so I'll just provide a link
to the file on GitHub:

https://github.com/chris3torek/scripts/blob/master/git-mv-after

Chris
