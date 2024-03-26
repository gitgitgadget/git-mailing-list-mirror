Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D19128387
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 02:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711421969; cv=none; b=TLNSXe7RbNkvOVMUkocMRiW4N9/TIDkkXl6dF/dxMLetxhgpCS2X9/bF331RzyN1UY+1LfYdJ2DDYp6Ikt+2389NOsx1rS39lVRIt1HRK1WFjCC2+HoNizekwMafrM4ZjJ4IHkzAJ2O+dyYABDYzQTocD/R4bGE/fLM4nKq3m8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711421969; c=relaxed/simple;
	bh=QCgteMDE1EgDVxstEvFdM7b1QLG9wqFPf0FUVSaooio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rs58LgVsq143IyMrkvlvCFnt3gRJR2NDXwlv5+mu4gq2Ht8YWkLmLmDAEx4b06cJJS0qYezTHrBywhoXTLVmEm9teGAwppeIPdUe72HtNywGoVSkEogrlNe/B3oc/GMl3sIdZMGq++VwJvuBkSSc869DIE43+qoqzw8Z43IbYgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69107859bedso33366536d6.2
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 19:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711421966; x=1712026766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpkhaUIkmGfX9QU2lecfOyaEDQRNqpZ5vKu2L2cazLg=;
        b=s3kfLSzuSvmCfqEAUJeTqye+1sB3u/aUMRXXmmP63zuyVdwKrV8Iab0j+76TMkSQs+
         L+rYwGhKfhf7lVhTWlPW1A6buiLTlybCqeE42pdWvHt/iYVtd5ra7+XOPUcdkm1uGsio
         JO7uO7ycKyxLKrQs2fl/nkIiB1AucK2jfWE3v1Lg4l4qXdkiUnAZXjcA8btf8fbkQgYb
         wz4j/SPwd0PBeA9flNDYoOYY2EVhhASgjcAtvbFwNEiM4Pl7andz9uTjFiwZXOaAV5B7
         vvbIpDtohL+LIvah17C0KomMVzAFXte77fLYHg1IzOf/LIZSdu87QJo9QeEPoSesHwcC
         f+9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8ZRNpnwlh3ddGq+DUjB279cdzmz9oF23ZFYPr38GJttGX83b8GRgTp/bX+7oTE/ieWj/wqhRlEfOmbPIq/7VoH33m
X-Gm-Message-State: AOJu0YyJcCCPY7g+6jdQEQ2krcHrPj5JOqVDvPMMy/S8sm2038NZAzx+
	FGpsWW13dUr6Wus0t99wrFAVa3TzSpmCE2rxMgeut9iBomqcPEadKTVidL7qPZdy+qe9qvcYDF0
	d9z5y9afEfpBUPze1RF9Ui4D2I+0=
X-Google-Smtp-Source: AGHT+IFs7litGi7QDGXvlrvbi8KB1qml7anqBapWsJWECUfCBspz4Hwf6z16f6xU7ojz/NqmhBQq7bxe4qT0nQsDkg4=
X-Received: by 2002:a0c:9c01:0:b0:696:9cef:4d51 with SMTP id
 v1-20020a0c9c01000000b006969cef4d51mr397387qve.33.1711421966100; Mon, 25 Mar
 2024 19:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <51647635a10e31e800f87e8bd4a2e62c@vkabc.me> <CAPig+cRLUra6RObK82nvm1S_goK8q2CXe3A7EeCFA7xqhJCdMg@mail.gmail.com>
 <xmqq1q7yhupa.fsf@gitster.g> <CAPig+cQAoK1UkgADFrnJfY4xw0kP6BypPAPe3aLoeFFGT_r2fQ@mail.gmail.com>
 <xmqqv85aezxe.fsf@gitster.g>
In-Reply-To: <xmqqv85aezxe.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 25 Mar 2024 22:59:14 -0400
Message-ID: <CAPig+cSGWMDXh8FQXH=Qca8g61BMOdVJnsirnL4zUJHvSrAfAw@mail.gmail.com>
Subject: Re: [GSoC] Microproject help
To: Junio C Hamano <gitster@pobox.com>
Cc: vk <g@vkabc.me>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 5:58=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> During today's discussion, we came up another interesting one.
>
>     Follow one of our three tutorial documents to the letter to see
>     if they need adjusting, and come up with a set of patches to
>     adjust them.
>
> This kills a few birds with a stone.
>
>  - The student has to be familiar with the codebase and MyFirst
>    tutorials are meant as a gentle "dip your toes in the water"
>    introduction.  Following the examples and copy-pasting code
>    snippet and trying to build would be useful exercise for GSoC
>    candidates by itself.
>
>  - These tutorials, unfortunately, haven't been maintained as well
>    as they should have been, and some do not compile any longer due
>    to API changes, header shuffling, etc.  Identifying such breakages
>    and reporting them as bugs is already useful by itself, even if
>    the student does not manage to fix them.
>
>  - But if the GSoC student can learn to address such a bug (which
>    requires use of "git log" and "git blame" to spelunk where the
>    breakage happened, after which it would be obvious what the right
>    fix would be), that is valuable exercise by itself, even if it
>    does not reach the "patch submission" stage.
>
>  - And of course, the result of such a work can go through the usual
>    patch review cycle, which would serve as a microproject.
>
> Hmm?

That sounds like a reasonable project, as well.
