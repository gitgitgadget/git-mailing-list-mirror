Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76CE3AFCFF
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786355328; cv=pass; b=BxC2zprszKU5lF8NtaGQHyFkAozyJ5CR6RpvfkehKa7zNIsJTKDHcv3lLxW0OPoD/nc+4n4zGN+CvLc+vMT/ZGbQjOIruDRZgC0jZrAnzyx/UcsOUzdzFwRAs9+uoim0BG+pOfAi4PC8k04pTp5rZ4JnHsT/yb0xpEzml+autiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786355328; c=relaxed/simple;
	bh=ccIwK6hkr1IkniBaLG85Dj9qdJZBSIGcb4zkHkRVAHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mElQGX1sDFdRb5+o431RIFHWb0ivArT7clkPAn4qzFldJGv2M7YrOIcLxG/aGnmFyttBUSh+38QUdEl1gDzIUjJeY6f1ASzqENQ8gco9qOKJTu3ZW5WuJ9mpD6oc8VVhEpvoRTRkV7PsHBSFRG0XoByTSxXu8fyX23zQAKhc3Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pgFds/Sn; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgFds/Sn"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a17c04563fso1766434a12.3
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 02:48:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786355325; cv=none;
        d=google.com; s=arc-20260327;
        b=gnY/DrXmPVKFREV/s09YI04Vz/hqOXZus6NC5p6Va8xM+LsJZpf+7K+s4KCJG97Ev6
         VBix2IC4gF8fl55sg6IPnmQ047lWERCfJ6w2XPdgTwL/02skLyA3SY/wQlbSv37Cjx9C
         ZEv2NLZ3jr5QH7YDkAebaXlpdlGuhAebQ7F7Ceg8egZhqwSD/L/PT7gQBlN3UfM3R7dm
         dg4bwgtfJU8N7QOVyxy+u5m/c49zuvBzxS538LfvtFA+BYOQ2ImwiIY1KrTrmJJut3my
         mUHVXvvgBMpu6sb+G4kcRWWGALl8vH73Qe9LYV1J3kqeNBWEimsM3+DP4NFXxWSAdA2G
         hdlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gzpgF0aZAp8gLSiQwISNZ6STjkny3i+AhMotIBM0KtI=;
        fh=BwjL3dnRd6Xt9GSm4xS7LTk8/YtFdaVx5ckRo5St4W0=;
        b=JGS0ebrcFXMi3fxG7+lwGAA2Bn3z5LThZAd5QOQz8ypW7XTWbWyzSK30WCj/5N7BlR
         Hp+8nayf57SkDGhuYUDFxLJbd6EtPdqMdLafO4otvgqYgVxzBS4ZmnFvNJBkS8cjLFNE
         GLlSDAQrHtSe0virgI3V7vmkEjUMr084bS2ynqLeonwGziw8LIuDn0X75drQmJho+b9p
         +Uu5haByWkD12/gYbJqaX+R3fovaVAn5VfQDhgd1jjdCXyuKw1iLnH30T0rL75ao4c62
         rOBSrJIzpDRl+Gr+7qJ0mcNFv+i2VqMPUdas55Ss7X4QA5qd+XN46oIMFhQhbyffy9Q4
         63ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786355325; x=1786960125; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gzpgF0aZAp8gLSiQwISNZ6STjkny3i+AhMotIBM0KtI=;
        b=pgFds/SntzXe+aRlF3fduLhyO7PoXCbs/VeHJVXLgFISpEjLENLD72ZMfa1lQWdhh7
         6UM5o8kHA7fTKGSLYAQeSNZTpIhPM66iiuyVSGEMf4+lD660ACfVVYppOXhvwNG6azP3
         woXhNNxrvbNbdFMthP7MDChoTenFAXUq43oB/rOudacgXf8EqBqk+wMdM2tDN8UeVFke
         p8m8BaknbbMJ6PUY0PQENf4W1y0CYhx2skXG197wJ7ifq3VvxXN2LmEnd6bRJkC/V4nd
         nlBF0gJmoxFklYGsvaemyGJ9VZALpTRwi6+5eo5T900gWD2hbi8sk1mU7th3Ci4l+ufF
         SltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786355325; x=1786960125;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gzpgF0aZAp8gLSiQwISNZ6STjkny3i+AhMotIBM0KtI=;
        b=SS2yonQwzPqhSXu5zo86truEJFc0iybK/p+McMEKMPxFkkwbh76H5+ql+IJQSK7F/6
         vsnOq1yKx6vPWVFUDB4jBhU+8EoPMwejuKb0D6JYkimlJjVY34xUpfhkDKqm32kyMkrJ
         M6trs8cF+nEcD2gLr3+YSwqggwcBFk4jTW3zwmSZqPSn+CyJfXBjShr/cMgtxQyD2Lc8
         rkqyz3cWpocX5knX8gbFcreqSIsIuhlC1Hy8/NT1W4itTQOatk3hVUjgkqTwbJn2Gfwp
         fP3cmwBpriDxpXb2rQJSjg13knLVUcMYIE+4Z/KjCukaX5RqX+f2L51HJEfRZ+p7OWQv
         9IYA==
X-Forwarded-Encrypted: i=1; AHgh+RplPEMFW5MZDy7eB0WwnqmzHOLnjr7dRz0N78DDoktNRehB/ijCBN50aikt7a6ijappogY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw97Z9MX02xJW63GZRZJuZne4X3WuhAjOy5h+XBPbzVqnxspfXO
	lTyhjCwFvwi+wwiRlaO/TFr4H3YwYLzJoIxYKZ0GaBEbbWRHC7xwD743UwVnLpf3IzQsx3uiwim
	tOI0shcub818UoQtEWlim8Dex3ppTaN/UMnrj
X-Gm-Gg: AR+sD11wRPBd3H0vpDvWFBwEp16SwAH8paaAckCDDYoDYOYoRtDG92pdjQrKnpcstN2
	lzrVIvdWrtMsTSYLJzPk2PLm53ANf+ieY+FewBuvGtwW2Wm5MjYoAUJTIhx2dWdULK7hfhPUPWW
	wvZNcHp5GvrpctHh780muad1+YmuM6kuTGi4JNvwQ37/TKtwKcO5/iLEhDjdw9COUfCNLcEbAO7
	vZyDXgcz5BOOGriqRd+dSsP2q8cCyJM5sRpiFUyi+4rA0Fv3Zcz82YrPr4v71w4gFf/9RtTybux
	U15laTCopFVIVrbAC/5uRYG031bBd0xdK6zCKeCyCkOL
X-Received: by 2002:a05:6402:321b:b0:6a1:faf4:eb38 with SMTP id
 4fb4d7f45d1cf-6a1faf4ef69mr6718694a12.2.1786355324670; Mon, 10 Aug 2026
 02:48:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2375.git.git.1786267394375.gitgitgadget@gmail.com> <xmqqo6fb85v7.fsf@gitster.g>
In-Reply-To: <xmqqo6fb85v7.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 10 Aug 2026 11:48:07 +0200
X-Gm-Features: AUfX_my26mj-st0IzNtVTSRnpzR8F6Ap1jlbWDwuCM6B_YgiFXQixHSkF7FMpvw
Message-ID: <CAHwyqnVWgNThSPnPBVwOb11S9MSjD0R3BRg1ci6yEQR+Vn1kXg@mail.gmail.com>
Subject: Re: [PATCH] send-email: clarify missing subject error
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> An input file to the 'git send-email' program is often the output
> of 'git format-patch'.  Such a file begins with a UNIX 'From '
> line, followed by email headers such as 'From:', 'Date:', and
> 'Subject:'.  The 'Subject:' line cannot be the first line of
> the file in this case, yet it is a valid input.
>
> The only condition that this subroutine flags as an error is when
> the file lacks a subject line.  "No 'Subject:' line in '%s'\n" is a
> clear message to display and is an improvement over the original.
>
> However, the fact that the first line does not start with
> "Subject:" is irrelevant to the basis of the subroutine's
> decision to issue an error, I think.

Yeah, that makes sense, so maybe we don't need to focus on it being
the first line, but Subject needs to be there somewhere before the
body.


Harald
