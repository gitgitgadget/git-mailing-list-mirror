Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78BB2417D9
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788171529; cv=pass; b=WKPQOn5M9KvjVD05RwhJFWLf5J9BRkUrIles9nOCZwJq6Qv3TAc+Cmi9TIXs6uhOiAlgTSUN3qU92o2ouhgbBIvRhZW7+6XQD7PfzqvRVxlELdXLmNpFKHesysQZh4MRMUdp8AimcKcA3yrJzHvOYnDrkB8IsmCKLkKVwUR784w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788171529; c=relaxed/simple;
	bh=EzrCg4VaNKqOY7pjhc22LAi6Jo7e7lkHTPMQ2tGM+h8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNt6OTafC+K9dD7AJ663shKwJGa74lrQ2mse7GaXHN8P1Hwxd8EITCX9WCLmoYIIX+s454L0sYe4mWY+V70yxkbVVwJ2xs6CS9arzuDcUg/GRCXn9QSGbJAzGQlpokD58AKFVTpRWEzL2admlVY7kaASmyVvJlHgK0fOW3VutD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7BTUQDW; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7BTUQDW"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2020421077so489289666b.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 03:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788171526; cv=none;
        d=google.com; s=arc-20260327;
        b=hOhqKZl5YP1u81cvR0WWcQ18+bGTgGEhnJI1OWaKKWNka19QD4YSsRxcCSzvU8Ajhd
         cD7J2W0uWI+8WnvZblv+5T9PUC+t3Ee0kT7JbWj7JtZOUmpeLRCr6nyweZTLwTfGGidS
         m61QVsdRH+mPxrbrI55FZU1NtlVcBNTQztmdL5L2xSslLtMwrntCyZd4X7mzkhg5TI+i
         hxUQTr7RmUWOUDqmaL2y/+9WhiZOsAZK2l2GAtW8PPHs8RW7EF4L3dM/4JK7AcENvgaG
         803t/JJd0CD7iiAdT4w5NISVKD+NbiRUra/HBSdQ9r42OlccbCajw7kzTrqxf22VxTG0
         O7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PPzYH5yv654LhZVjm4g82P/mci2u2wjCJMyA9TrA7dA=;
        fh=Iad+4t4GZg0+eEIlESPO3Y37PW9NSAbpO9QzqoimOSQ=;
        b=AEFDU0fKi/cpqFeZHYbR0NvSOc+42xhf/GUqfAhy+2zSukXoldvsh0D2NJjAkpTa85
         5k6GLOGEBWuOafEf6L9/mNfAcsu8UbMqdnJFi9LuCFJVVW+2BmjI9+XTdgx49wJ3/Xx0
         Pz8pWEUXG86Eh5Oat4d2Ldb9P6Lz3alRqPvs5ZijnkMPh1p/qlWE3Fq0q/DPmJvF/Jzt
         H1X5BWndPw0dLwunRdCcxQljbrFWmZIbgygUZ0NjLJ/Oij6X8L/dsCf6/P31MsYFOotu
         ME4RbMB3my83OS57gWrQQ8tJESH5anFqDxTNWtCXpA/iqjYiWsUVpalZKKj6y7c2qzOY
         I+aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788171526; x=1788776326; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PPzYH5yv654LhZVjm4g82P/mci2u2wjCJMyA9TrA7dA=;
        b=G7BTUQDWmHd9B/0ZB263JQV+1FHvOkzlq4QrkzDAroKD1L8x5y8ngRCZSBe+fpJQ9x
         x4lnyiZ/4lDAcZCz/fcpLrnPNr7zpTraGsCtV2loXp1ZhdS431eRegO703jxpsdw42EQ
         CHMO0Kdcsf1LdUy99D3iliLxmXEjN9Z2geN5Sm6MITrLjrLb/fbxJ6zqYB/vgb5aGfRd
         GOxXLLt6y9M++CtVuTL1GT1sXKc94Vr9NvngTZo3vOwjSOZ4GB+Nc5OABruJwfZddFXc
         T2ptPejXmw3JOLlSG2TUDlGehQhK84+v0gvZ5fOlME0b65ebGJJjkSpRqzZI8AnlsmG1
         yqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788171526; x=1788776326;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PPzYH5yv654LhZVjm4g82P/mci2u2wjCJMyA9TrA7dA=;
        b=NQWokZcLLfAq6ECYc+q2QxBB594rUiFH0C5iIg7Xfmq7xnEiIOnf1YjxTvbuYLNGj1
         eSCcmTkIgSoqgx5BxHwhnU2fiwlVMLemfDRDhdSGuCrX7mE0SqW8gWUtt/PQQTHW4orC
         vkl0JJk0J5P6jfE29/cmDngRp1pjfVKeifN47ACuYYMFsamZpxqEsmb46NCYWe0FI5uM
         eIaAl+8ww5MBgXuuqqo69my2nQiT+r89FCDlwwxJTpxyF3oC/onnb3+sx2RlHNkCW/6N
         TojEe3RPKky7RZ+XKmilvw85haRTPqs64DMUD8fHS5W69vqj0IhS29JKKQq7v9NAlvsb
         3mCQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpe1BSU4sdHEpxeWjCgBqzGOCM8VZdl3aMeP3hp1mouWhZb+iXxHfgOw9zRDzO0tlAUbb0=@vger.kernel.org
X-Gm-Message-State: AFuF++nWPu0lEjEQZW3RENnyntdsRiY8IKdQgaKRN0HlvPpH6JNqXXwU
	gRvDwG8iBZv/UDN752+JBkGG7Ag5cecpfDye+ogJBz6V1/a2FNk6O4C7vWKY2CmSmDin5zACMzh
	fD6oCqvsP8dPxncBzXvZVwW9eJRdhDdA=
X-Gm-Gg: AR+sD10qBehb7Ac+P5ShKXVPs/LUdChTW5DQQgM3Stl8HdtK5jNbns0CLgRAXR2g48s
	8Oq8JoyNUODr7lzUOaL0zJaShZURHwUOJceQuiSctT+3n5d6sYPWUEX8mBrF5sBWCIk+AXst3DB
	zLVRgyJreTD/H9dY2jHjvlwkoowiqyWS91ag4nZc11EaxjiI5hIsgPpHVoyQWEoQ4OlaPJAjWmG
	ZTuV5LxThNYlgw7xv3Z+oZSHWpJdW30CBJ+yObb+fS5xRDlWju3h5gWD+nvGvpv1xICZBSEFXWo
	ol9/MC6Q5f+lgCHs19Ve+D99gvCLy4kUGogmc2hXSxj3czEH2IHIAxM=
X-Received: by 2002:a17:907:94c1:b0:c25:6230:dfcd with SMTP id
 a640c23a62f3a-c256230e4d2mr1235241266b.15.1788171525632; Mon, 31 Aug 2026
 03:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
 <b501b5fcd0b9dde65c1ce358e2f4014dfa340c37.1784993669.git.gitgitgadget@gmail.com>
 <ec6c3986-94ab-4692-a4c2-47569b77e9ca@gmail.com>
In-Reply-To: <ec6c3986-94ab-4692-a4c2-47569b77e9ca@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 31 Aug 2026 12:18:08 +0200
X-Gm-Features: AcwNN1U59mYMBibVwqOoD1hPHkmEAGhkTPGZpnghqOvPVznDQjfbvcIXJK6Nypw
Message-ID: <CAHwyqnVDBihNE8+tbJheO3R5TgfBUgqLHRx=zDxwT3btUi2NZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] sequencer: teach autostash apply to report conflicts
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

> > Add a conflicted parameter to apply_save_autostash_oid() and
> > apply_save_autostash_ref() so callers can learn whether applying the
> > stash resulted in conflicts.  Thread the parameter through
> > apply_autostash_ref() and update existing callers to pass NULL.
>
> It would be nicer to use the return value to indicate
> success/error/conflicts rather than adding yet another parameter. Apart
> from that this looks good.

Is the int flexible enough to separate autostash conflict from other
errors? Or should we introduce an enum here?


Harald
