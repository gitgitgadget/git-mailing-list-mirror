Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F463CB2E1
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063671; cv=pass; b=D7IIp8f/KCy09yVUn84qLKhZt1yjd8/29jWcVq/Bzdf2VuQ1dfkTcWgXFdSu3TuUnznt8cTmRuPfJLQqE4MHXC45iOMYoMgXgyEv/6tUv+AWhbSMIIsK2EiG3maUf4BefqimSNBQ4kL8X5H3SvAe635olFYbl32B68uUb3z9gHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063671; c=relaxed/simple;
	bh=yaLpePfudIylC4WIIADkVzEKZmpk++95OSBoBhr4Cac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UujgaxbxfltqILMLBCr4z1HQTPGssj5XqSceUwoI7xPVVOL0BQBTcnbuahsb3vYKiDjWcClCv42JQOItPK4wmEeF9kjsOJMRQBS+5uF1QpyXh0eZCc9pRPWOvH2w+q17AvBKsPW22rbgDJ8UUkBWrO+PBw5Woej+HXLoxMlabew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzbQyrfr; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzbQyrfr"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d756f2a06dso181825a34.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 06:40:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773063654; cv=none;
        d=google.com; s=arc-20240605;
        b=TXeLfEHar216eu2i2mlQEEe7cZ/GDaSSpA/0CcPRJv00wk/nMK8fOYiLlayPxs5tSv
         h80jLb6aSelltAF0WIbDmTZLmGFoa8U3trR6mndw7PuxvSxqOzC3qC9gPa5zY2YQQFgm
         CdoJA+GtZ+BO/EtoJEpeLq0yNE9Jy5YxhTPl3Qz8jkWupjVjHSROqydWWm12wPFLeTWq
         fEBLWJh1FrYyqFWDmz5FgpQYfdcAAuZWvvd2AfntuFgKLoL8gCz+6UfW3owIxdB0IGOy
         hah13nuHCj3dQiNiTktEFXsJ1Z94tqEte0tkGkFL/B660FmdP0DDdW5Z73OPGiwrypOM
         GPhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SzyOxLhYUBSiTnsxIAFmN5qlyAk7o8/hyZ3RIq8waEY=;
        fh=asi59c9VfdKo4Rf1HsCg02tSuyGwUhLZilakXMs8gTs=;
        b=boXUX4Fp7m5xLXvKd1Cp4o+EwUHbs+qG+g5mEoCS4nxKnVPLwKw3XxJzhylKMFcSQq
         /quYVq8T4Fds1dI5Wa+salBnKfWnBVn1ESsu+yx5ySMDd0yClQWCf/1iSCfVzN1q+q5D
         PJGwx9enBzpiDEdDmexCPgupeSqpoMthndX+HW8v2bbuDxwcZS6+fqUGzCkfq+x0THHw
         S9uXzFa4NIlf9o1IkrwYNWsgkfzUldgDOlDZjkGld58fcD2PeFkA80iAOenSAT7zvdDg
         oEkJO5pUG0AxzZYFeNLtpiyXz15n2CwyJXr8spoUPCcUzAk7OaE20qIPVmlHJZVD4coJ
         7zHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773063654; x=1773668454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzyOxLhYUBSiTnsxIAFmN5qlyAk7o8/hyZ3RIq8waEY=;
        b=RzbQyrfrLPOZohSpTEClpSHPHh6MvC8a77VqAVdElVjZjn/fEnudBm0vtTPH5F+yVy
         WXYuPRPMCHJnvJCJ/8WvG/JcXa2AiCrWWVSOTM29byPs+BiA5HzlNJrhAu1WZ8K/6EiT
         T7pbZhbxPTdYycVWMZ0M6OhtemKISuk0aKxIPwlrsc47zb74G+Dz05eay4kVxH6YDiHL
         LCPRAUHiFRNn/LNNxhXkG/yyj+JTsKe1iKfR26HPMWIp9GzTxT1cU+i3n+VZZFohmZs/
         xEJaCdA5Psi+y7Kq09rn4HJydwr+yc/xgYn2/uLy3t4qrg5ki4jCzYy4hUALbQE3FvIE
         W0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773063654; x=1773668454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SzyOxLhYUBSiTnsxIAFmN5qlyAk7o8/hyZ3RIq8waEY=;
        b=oeK8x5RqcVUkNIcWrZ83WWG9TxPpMLV701KFQcJ4/j99tXaZKPRL1YGrSTD8JUgwtF
         kfiDWkHdN/psfxKdQKVi0/1IhYEkCXUcjTy4xR9Poas2LWXw0wj4nVDLtAxtzmB1pi07
         JtfTTK4b8gKCerF90fkclwHEL9S8uNhY+R80GhSdTXQiversuQWQIy5cK7G4Ifz0IqA8
         QkZuv/pXEzYF8ZKVFMMqGwAxwe6GqFR1zO/bb1W8Hepfpr+l4lq73kniNZf4bkS9PJH0
         Z7DrJzhahtmwRIqdyPTqiHrmxOZrzopyMLIapDJZwhyYhNngBNndgSSh+5w2DZlt+S2D
         g0Vw==
X-Gm-Message-State: AOJu0Yyp67Ikrf9k4ng8N9IwaxqVD/0eOHstgmhtDEdJ0Npd91Bth9+X
	kKw+w2nA1/tH2uT9QeqFterQQRvd1mgt1bni+PjW6c/V6IHi0ekEymfY9abk6A6L/XMCEpSR2kU
	0+19O0LKpDeIqBvzdo1N17bwPjL5NkxYznKKt
X-Gm-Gg: ATEYQzy74WmGL2+yohlSAeGfXAzmKky1NBSZQ2Kq7iSnsPMpZmD5xuncgJIHOjIoayW
	jU5BCoGNverdg/j8xbRhz3fvIJGwC8jTDEK6REoPIF2YFVkOWMOGPVG862yn9dqRtt9wNwv8KQH
	XB/sHOl/FdK/OqrGLVWHaKJbux5wzWBV43YynniBzc+R+Bpq3u6uBVT4TLQI8Q2I7rtAL+WXLXq
	tiLDTISr9KPpE6kJoEeXYx6VJ/9ZsAWM0TChxeuu/nXEHYEU+qEt6IbcwH0Z9vaNzWTBK3pEWYV
	Bao3Y6Z1SICozHXNYjGKKEEEXkhu+r8t0m1u9mYXK+KltnJbEyKFKJW3mvnYm3Wdnc1M
X-Received: by 2002:a9d:6acc:0:b0:7d7:49bc:2dae with SMTP id
 46e09a7af769-7d749bc2f3bmr1567107a34.17.1773063654458; Mon, 09 Mar 2026
 06:40:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aavvwfZllMWUwIl3@lorenzo-VM>
In-Reply-To: <aavvwfZllMWUwIl3@lorenzo-VM>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 9 Mar 2026 14:40:42 +0100
X-Gm-Features: AaiRm50Ucl2XINmfOlN3hPBH4ug4qFjTmQDn3u4tO6B8z0KcuI3j67ajVExsZw4
Message-ID: <CAP8UFD1cQHUzxu0cWjVWBfBWh8qOy2+oOb0rwo5CmgJ2qKRFDA@mail.gmail.com>
Subject: Re: [GSoC] extensions.partialClone and promisor remote fetch order
To: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

On Sat, Mar 7, 2026 at 10:28=E2=80=AFAM Lorenzo Pegorari
<lorenzo.pegorari2002@gmail.com> wrote:
>
> Hi everyone. In the past weeks I deeply studied the documentation
> regarding the GSoC'26 idea "Implement promisor remote fetch ordering". I
> am preparing a proposal that is as detailed as possible, and that tries
> to answer to as many questions as possible. I am also experimenting a
> lot with multiple promisor remotes configurations, and creating some
> examples that I will showcase in my proposal.

Thanks for your interest in Git and this project.

> I have a question regarding the interaction between the config
> "extensions.partialClone" and a possible fetch ordering mechanism:
>  * from my understanding, and from my personal tests, it looks like
>    "extensions.partialClone" is not essential when working with multiple
>    promisor remotes. Having these promisor remotes setted up with
>    "remote.<name>.promisor" and "remote.<name>.partialCloneFilter" seems
>    sufficient. In this case, the promisor remotes will be tried one
>    after the other, in the order in which they appear in the config.
>  * if "extensions.partialClone" is present, then the promisor remote
>    configured using the "extensions.partialClone" config var will be the
>    last one tried when fetching an object.
>
> 1. is what I explained correct?

Yes, I think so. The "Using many promisor remotes" section of
"Documentation/technical/partial-clone.adoc" seems to agree with what
you say.

> 2. when the fetch ordering mechanism will be added, this config var will
>    not be useful anymore. How should it be handled? It probably can't
>    just be removed, so the fetch ordering mechanism should be flexible
>    enough to handle a situation where "extensions.partialClone" is
>    present, correct?

Yes, for backward compatibility, it's better to have things work as
they used to when the new ordering mechanism is not used.
