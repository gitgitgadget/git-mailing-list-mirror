Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BAB20EA2D
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407981; cv=none; b=Ss6eDgf5qaPRQ2Y+L1uDoK71hfDgylUJ57oKCc3BAo58EYktFQgAwozqmPcPwdOnM5wNKRNOr9gic390fkf2mPECGfThv3Bak1G+/OuHk9mBONMMKiY+M9wJCV2mx1c+TR34xK/2b5EbwI3nAlRE4qyX62UD8fe2vm9d6uLx0Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407981; c=relaxed/simple;
	bh=b4qS+UIgY2Vmo1YzP54PbYNHGNohJ1J3aV9G0AINGoI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHLUPQWY3OMPgNXCpuCn2KtF56y8Y9ZGGNQVemr+go6WbWU/07XtA9ddidA8y8UPxmAKBTRBsP0DYIJa1sC4fKQiRnhc6QRZZsLfgcy8o1sMCF76NG8Xi3LDklgxNZP/4iGU/lwD/tanLp4IvXTNHKhR6IPk13ba9ra7EPuvb7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ucla.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b=h8km5Gjs; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b="h8km5Gjs"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so4675318b3a.1
        for <git@vger.kernel.org>; Tue, 12 Nov 2024 02:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail-com.20230601.gappssmtp.com; s=20230601; t=1731407979; x=1732012779; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=b4qS+UIgY2Vmo1YzP54PbYNHGNohJ1J3aV9G0AINGoI=;
        b=h8km5GjsJMeu55qd18cl0+AyS07Wdqg8GHUPyK6AULxc14RsXzOjYi2zruZQpJMUue
         PGm9h9b8/k5Bz/oikrDC8B3R5naZP+5cRoDqKuSw1q+gAwERWlbNx0REibZeUyH6YYsM
         FMpSDLTDxWYwoT29RLDz0GEz89blA2O/syRb8DgJThHzolIEiidgNR8mdRR2guCdu626
         hB3ozagQ+hkNkKvxzQ5hgM6gYJc0wj2hmoCU/CY3Yx50JEH4uKtO+VFonfcPRSUM0h+S
         tj7uFS/r7LQigUB9hFTfihV6kauJVoOeJEYjLKYbG0LrQRgo/cM0XzZSBRGa+AsSfhMx
         x33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731407979; x=1732012779;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4qS+UIgY2Vmo1YzP54PbYNHGNohJ1J3aV9G0AINGoI=;
        b=ffAWc+oLzDdbVfMlLL/3khzKKOJTryDN2mrXvqGFRkqIqFD5X+Fkirz2DF+ndqO6Pn
         S5wOb4/BXptDcUuevvG1G8hMFRY9yVMMPN6m8P8lMo9JPBnDHa7CkeOgGFY66BxWCTGC
         btrucTQqMDRCXVidbh48aVW64t4Wc9PEk3AwaGtAvycplRibp9HuhmgranHrFQZ2MUxp
         esT3H9XBXzFs5RpVZdw1MikURev1INjYhk7nQxX59mjXaAZPUZvZlmdTIzXE+zwvIMuL
         ZIBeCtpIqbDc3lDTDQ7J10e0sQEY/hY3Arz0vmvW0AVrgI82gLxtfG9S3LID/UkSmXl7
         8crQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV9CW/i+p9UXzxEATpk/Dh27DBor33j16v/WPGQI8vcpsVBm4NtgpaKuKp+H0cOkxDgu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQg7sK1yKdpoMC0P0GPvWi+kik4V4owwNvcqyEi9uLjhQupW5Q
	Yj5JZiOPLNJYJ0ObEoZaV6lGY95S25NwxlpidDv2CXaALjQQ/IHj1rHhKPvra0KxpreuZn/Dn0J
	iUSY2MRzNjHbfipMAPo60dQrIMFE=
X-Google-Smtp-Source: AGHT+IGrSy6OEIVm1T7hx+eKHDZ2zu75ai8G3eJzOCJtgNmLHFT2Kbdr24B4Y/tt+EVgtlv2fzn46GA96HipafMC9OU=
X-Received: by 2002:a05:6a00:b41:b0:71e:7046:c0f8 with SMTP id
 d2e1a72fcca58-7241338f0b9mr18960068b3a.26.1731407978770; Tue, 12 Nov 2024
 02:39:38 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Nov 2024 02:39:38 -0800
From: Linus Arver <linus@ucla.edu>
In-Reply-To: <9ddc7555-9459-72ac-81a6-84166baf7570@gmx.de>
References: <pull.1811.git.git.1728820722580.gitgitgadget@gmail.com>
 <CAMo6p=Fo0gp6Vgq73E6k=Q+tV0g8EB3L_AEWq_4e85G86QUc1Q@mail.gmail.com> <9ddc7555-9459-72ac-81a6-84166baf7570@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 12 Nov 2024 02:39:38 -0800
Message-ID: <CAMo6p=GMfz-2QYqqAM_2W4g+hRi50T9LJhT21L0mJcXOtWi2Fg@mail.gmail.com>
Subject: Re: [PATCH] trailer: spread usage of "trailer_block" language
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Linus,
>
> On Tue, 15 Oct 2024, Linus Arver wrote:
>
>> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > From: Linus Arver <linusa@google.com>
>> >
>>
>> Hmm. I just noticed that GGG (?) is somehow inferring my defunct
>> @google.com address. Not sure how to fix this... any tips?
>
> This email address is apparently part of the commit object, see
> https://github.com/git/git/commit/a556a5c05c44e521b572d595d5d32cc4158612c0.patch
>
> (you can also see it locally if you call `git show --no-mailmap
> a556a5c05c44e521b572d595d5d32cc4158612c0`, but not if you omit
> `--no-mailmap`)

Ah, thanks! So the commit's Author field is actually set to the google
email, but tig and other Git subcommands were using the .mailmap file to
replace it with the proper (ucla) one. I didn't realize this was
happening, and didn't bother updating the commit itself to use the
email.
