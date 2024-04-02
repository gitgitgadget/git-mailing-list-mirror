Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBF61803A
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 05:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712036797; cv=none; b=nLTKclv6qAj3amPlmWdyG2G5Vpq2CV3aEG2osbp4d8/FuURX0GpMQtVHV5miGgzW4H63o9DZUhHzafdyzy944abwFNE+3W1lOklMj5kkm8CmxDENlzpuAw+52PNi2BAxZwgvarybvbToyVRwz3JuybAy4Ch/mCBOZ1rUJtF94io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712036797; c=relaxed/simple;
	bh=OClZmry3ZiwWOwdACy7xP8Etv1teKPaMvOTbpqvbYZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUkHjE5zQH+atYi6n2XL813FhgTfUv+Pmn4ToQ6fCF5UtqNw3eEOf4bvtLyrdtK0fzMS87/8e/Y/L0d0BP52bbARJ/2krFsJnML0otO/k5DYUmfR2zJEpLszyrdQVb55Dbyv1Eg9Ou8O2Vmy5c8wjllLj7lcIhcaKYHH3mI2saY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-789f00aba19so364713385a.0
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 22:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712036794; x=1712641594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yS4XRmQww75EB42bnZ7qTZmFzHXHse/1vcx3tWK1J8=;
        b=LT+m2EvYgz/GFoJAWjDxJGRaCcDSrHYqCabP/MMeqJHiBbPflWQoDACnDgJqYeirvZ
         xkgAoTGZ9BSTOmHK+DcMs9Tcx8RH3jKRulgA0Vg6DWjV3DIY6P4eSb8hjNuY0H32OzjI
         oGp0ZRfT6tByKjKxBuAaQmlsRkcPDv1ofjwMXz1LuQoMaCY+1rIUE+xnwWWpDbR02zTl
         9MeoPek5xYYkVOZ9VZcGo0pZlKHPVOFyq2Sei3xKrY4SZ46htWmEe/v7X1iyCSBn7W7h
         bObvfnAJzXMzN/6iT5acN63bDcuNSD6wB4Ml3PaTYAveEcELidRnMmvUPc+/eoWKVMf9
         kNYA==
X-Forwarded-Encrypted: i=1; AJvYcCW1WeNyn7nNgA8QRTYbnSH12IPhIuSzjNoqh6BhaC3SYJzTAJea6MUGyPh0AhheDbCv+nVXAguInMDCyws48LWxHuFQ
X-Gm-Message-State: AOJu0YxcLPcKhzvjaJWcYzf3lAmaAgeGePCSi6QPaqyOYpdVOa1X2oCY
	pnurfqYouan5ODysu+nytZ3X5MJdu8txI7nVX7/hoUJcrtKsmkP4l+U/HtYuOx6YC2XhaQEX/JC
	NPP5ZBNPIWOuvwW/ApP953r/jaZY=
X-Google-Smtp-Source: AGHT+IFiuuSPvcfy4CdGXWsn9GFqtq+OUeUXrfz/XkXguusM+8muI2hnJe2uxTgqLHhEGisLJzmeXjmRsbDcag2oEsU=
X-Received: by 2002:ad4:4d08:0:b0:696:a266:28dc with SMTP id
 l8-20020ad44d08000000b00696a26628dcmr10909569qvl.62.1712036793828; Mon, 01
 Apr 2024 22:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com>
 <xmqqsf0gvjrg.fsf@gitster.g> <xmqq8r27nhwo.fsf@gitster.g> <ZgPIEgFGVokYWc-H@tanuki>
 <ZgsoOnle3CC8DqUR@nand.local> <xmqqzfuc7muw.fsf@gitster.g> <ZguaLjWGte3zdQGW@tanuki>
In-Reply-To: <ZguaLjWGte3zdQGW@tanuki>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 2 Apr 2024 01:46:22 -0400
Message-ID: <CAPig+cSp=GjQWF1t+O6w+Ad=NUmeAM8ZAQp+CeetERgiSaUe0g@mail.gmail.com>
Subject: Re: [PATCH] RFC: add MAINTAINERS file
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 1:40=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> When it does know about both I also see myself using it more frequently
> in the future. It would be nice if git-send-email(1)/git-format-patch(1)
> had a switch `--cc-command=3D` or similar that you can pass the script to
> so that To/Cc lines would be added automatically. The script then gets
> the commit range as input and can decide based on whatever criteria whom
> to Cc. To the best of my knowledge that is not currently possible.

I may be misunderstanding your statement, but this automated mode was
exactly the original use-case. contrib/contacts/git-contacts.txt says
this:

    This command can be useful for determining the list of people with
    whom to discuss proposed changes, or for finding the list of
    recipients to Cc: when submitting a patch series via `git
    send-email`. For the latter case, `git contacts` can be used as
    the argument to `git send-email`'s `--cc-cmd` option.
