Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11CF27466A
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668362; cv=pass; b=Yye4g0hnWNEQEWlZWadT16CBFwb5o6cgTsOPXnHMEcps/RD73zSAoZUgiJvgCWicnyHiuTTFW90D3skAKCCxdtsC4U6MALw7bmhC8cqgdSqi5kjiuOAI/R6fpOLaVOWLGiX1ozfScGNLFke8p7fNvBo357wMEvEXNwXYetohJ7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668362; c=relaxed/simple;
	bh=PvcVdSd2uPSmgj4AZPJvCgd+Bi+XoYQZTUTZkKYeH/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+dPiFvbXo7PA1taSaJ2pq5dxpEYEUIudZc8EEOIdnF7r+LZtSJ6eyZRIRmGwunp1QYhz+r40DsmoFwi2Rrt4VdzVqm6GXZwSVmDH4b7MNEDrLWTZwxDNUpVxtqQjeLOAWNKbKGVzzRK1tlyFFlbcegJzeqmr1p1cu3a6KfDRGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1BYmQix; arc=pass smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1BYmQix"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ac62c88c7cso4320915a12.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 00:52:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790668359; cv=none;
        d=google.com; s=arc-20260327;
        b=VXcwdbAJ1hUSE3MUlF7Wnusu61GNzczoylKmts4wj1K3OMNhr4VQbrcnte6T3AQ0gp
         ssnaqVyiZgoEcfzzHz+WWdPMaeI68Kv2/EuEZ3dcyRT6n+lDgiBTuHGa1Rnt4JawHqZ/
         POK+E3U8Zw66XazWh43rW8hXb7zlbcSb8yhyo5PaV5T4n3owi3IlPEaHgIbSvEY0CgXH
         IxHxGuq8RL/HzSeWlg4Fg2NWwdH7g0OpG6kqD2PRG/mXPFCqfaW8Fd8EZvaiu3v5vzEP
         qO+B5f9wmY9TSB0E2XmcB1mN6a/nJoULbAgr1IxKC5RiqPYPBt/js6knfmKmXAUc9OVE
         dlqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XkJ3125sK79nEFKnZQqCXRgH/KVgvdyMZevsTAheF7A=;
        fh=sTyOJR0EytWr9XSwjU7s9N1OpKqEcrFpOe/q4Y4Z/hc=;
        b=ZySyH92CDtrux3I9pNp1VCliZ3av1cFl4aOrEMBGYF8uFAOoZbe+n8eH0Sxf0j7MtJ
         3sK0AqyMUZG++ES7/037jCcLCVJsmo9Mbg/qxtB9iKfzRGVx5LgHSCXM4ulMhJglukXZ
         TrOzMogIiWNS46L0HIF7oYCm9pHrOVT3FceXWAqzz6uaV5T2Yiw0ATtbrOj3YQyhze6W
         HzwQwXekGx3qEN3Vb8HLUi1XDItwd03ORjXAolrK5QKpDAh3zkuoL+IhbnLS0mpr/Eb2
         oft60brhu4INfkNAcFfDjuNmUOmOmzmSpeH1GgMQldgC7ld1b+BzNHN9QFGECg0mVX5p
         Dp7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790668359; x=1791273159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XkJ3125sK79nEFKnZQqCXRgH/KVgvdyMZevsTAheF7A=;
        b=e1BYmQixso+VrdJli3uVqCn8wvb1Dnq1veSTsXh9rWGsEYtMDDuSZBHUYHAYZaEptY
         MFTPYjx7uVq6itGFmntrHsaeWla6neKmHeOGZZDFRMMX/LGIqaWy37dhR8NA51cuap/H
         OYJcqZorURWM3vV27xaCWBR+5IHv5aS/54/9e3xLYnmp3HUrq4ORhuqFh7cy+L1bHhtu
         my71Cc09ARR2gtdzwDJJPkoSThS5dOtCl+l1pbPBlKSV/vW51oB7Q7oW/bayGzkSBZ+B
         9h/HFroxpzTL8WNPDVj0/4CcHiSi+dupB80USoZIKZeKngJUTLbdiCXRUe8t7VrYs3Lo
         oyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790668359; x=1791273159;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XkJ3125sK79nEFKnZQqCXRgH/KVgvdyMZevsTAheF7A=;
        b=RzeeHIMDWOwIIcEEXT4E4y8JHh//ajqldn0mzmPVc+z2IRCmZ8Ma1RrRZGxBeVChMw
         mLWe6xukc5V5Z4l1C1H+U+pz5INQXdHB8pPGRY3eEY4VoaN9MbYUyIdnte6ljA1RWlMi
         uG//XM6fN9QewRBcjqaltGPwQsrhCNp657lWa/E54XoffUvMW9U74HR3HkDit3uRbmqb
         fSOlZ2ASVuQK2pR98fbmDDbPsvE7BiKmKKXDC4lx0vIrAGYIG53ZHxBAafqtc4GYGOOk
         j7tABVvOd2InUBJ3t3FXrTc4oWbNsgIzIvI3cZHR9YcYYVHFYfhYYjpk6kf1r2eA7I+4
         /wTA==
X-Gm-Message-State: AFq9FYJQxc8gyC6v1KN5IwEF6ak5xpF5LTwRxd4tk2lkaCOLxDP5kIHX
	6olSn3rNHrzwaSg/X9zfvD8iP9GQKFCeoan3Mcelc61NJTv9AzBvr58xwohlGVZ3VBY60+mMbqN
	jXJ5RFTti/BI2/uMiRU0ZRT4KYn2Lm3M=
X-Gm-Gg: AYBFou3kyfu5C7O76KGdqEUg4LysTZKfeB2tsEcG3+Amzpxlq/0/r0cghN9Oma29r0g
	zKJwbav3KxHmizUk/x5FzTlxZURGGT3KXXthBKd9Hvwxjrl0hv8Cv/hoNBV3Hcknk/Jg5Ws60aL
	4EfW/n+nWWzB6oyH9l5HSFktP1u4BkJjLSy95Lnnx7OIl25j4wf51qcgpswVOUotixyffaUnne3
	2q4UzhhXfu4iB90T1KmBAMFnV/3tX2FlFBy/Tlxmnd42TeGTAkFSdEMax4wg4pUiAPtTOafi/VL
	PtvBiwKiyLykDHbucHYV/lhNQLjjjVVKLbPBiv/a+FYfkMAzJnz809E=
X-Received: by 2002:a05:6402:42cc:b0:6a9:dfd4:811f with SMTP id
 4fb4d7f45d1cf-6aae8f70169mr9188186a12.42.1790668358762; Tue, 29 Sep 2026
 00:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com> <9a6bfc3c-8759-4fbe-9e90-5dec9d00e278@app.fastmail.com>
In-Reply-To: <9a6bfc3c-8759-4fbe-9e90-5dec9d00e278@app.fastmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 29 Sep 2026 09:52:01 +0200
X-Gm-Features: AclHuK9GJhygw2DmdTr4uYb5n60cGR9fs5l2Uv1eAteE8FIOQwPAh1XdzTlpOHI
Message-ID: <CAHwyqnVf_D3qV1OVYiCnLz2tVteRXdWYTGBaNTJpkVtDwCC1vg@mail.gmail.com>
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, GITGITGADGET <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 9:47=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Tue, Sep 29, 2026, at 09:30, Harald Nordgren via GitGitGadget wrote:
> > From: Harald Nordgren <haraldnordgren@gmail.com>
> >
> > Branches merged on GitHub with "Squash and merge" or "Rebase and
> > merge" are never deleted by "git branch --delete-merged". The upstream
> > holds a rewritten copy of their work, so their tips are not reachable
> > from it and they look unmerged forever.
>
> An example closer to git(1)=E2=80=99s home:
>
>     git merge --squash
>     git commit

True. But likely it opens up the question of _why_ would anyone on
upstream be doing such destructive actions? Well, then the answer is
of course that millions of users (including) me do that via GitHub all
the time.

Maybe I should include both examples in my text.


Harald
