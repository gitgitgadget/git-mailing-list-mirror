Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DDC2561A7
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 06:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772345650; cv=pass; b=a+2xnzcTQmfWJLj7j/kS0fZD/0peJHle8Ri1nIl56/8U5FmwfiKpJE23FGjzl8cTEhjg7VWsKszU3x0qTqGomjt/gieuDKtdFXmWsnfmEFWzjRRjptm/1K+wTzPtamHShp0MhnYUiMaq4FLuquEgwv6719fbVoaJTcGBHAfZR/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772345650; c=relaxed/simple;
	bh=/5GuTwJ/dWDwJhqxfL0eZlN8azyUiPW9ZyHZw6pgplw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Up1yGeEHmBHVYdrqU6Ct4zZi3lsBCFB9Tb6Gcwqm/8uDoxSJJRzvT4gxjOsFo6H+f0WJs8VpgJEhdfTlHDg7bf9IcxbXdnrrWZUqsq2xJiCZYQ4AXk7fuLJyfcXtrNhdTj2gMqEKnMFZYI/cL16hK1ecCnFKoLLnraICXxDJQfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flESVuPr; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flESVuPr"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-389f173b91fso52684671fa.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 22:14:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772345647; cv=none;
        d=google.com; s=arc-20240605;
        b=iGvLlTF6ey04l0U6S8N1naCNzp/9BcQObZ4+5MPKoJm7kPoq7JafSgps8jjsRJg+ZN
         5dN43fjs6ddOahjpY023rnIG5f2DPFNGl07/h0puTKt4LLG0c0x06vsjf6BtBK5xz0sg
         qltmr9MfFkzFZKLSgTgyBHCyJjPr7b/YJq4KNDEo0qSg6bSX8lBW5J0MUDPL+gwSx8Oi
         C3xDNJ1MtBUmJIYvGckJS1+HKmgUXzg1Da/gOwJFGm+BEEJVK2mekeSx00MCNx5jsTQS
         dbC7teIwUguDRwkko8/RpCf/Np8rrRZ4DX4eD8fjQznxq80WbNneis+9t+SUY9ILhTix
         0RsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/5GuTwJ/dWDwJhqxfL0eZlN8azyUiPW9ZyHZw6pgplw=;
        fh=vjWiuwtWY/bbMdr/dGFQVRlox5zvvaMnt63AkuuMFPU=;
        b=XJnEhuMtBgS3yDa0cAT0G4Er8YZ7I5M+FptQ9YhFD9jgnRnkqs7BSXdnRuaQc0Sx79
         XGpvQ7eZJeK1XZ6Kj6nXFb8rKpJkovxCnekX/lPuso4P94GGAlTCyLEmSbzicH2XfK1L
         8H5eLPANMUj0SBdyNa1oGz7XfbxKvV681gNyTR589y7KPmnHTZ3F524ChyV/Sna8M+XT
         MVFTyYANT5nGYS7FqAOdRGAfxiVyZR/82O05OQlBtuDsqc0sqN62ud+LYxAAZBPqizRo
         pdfYYgbot0QGpJ1pTzkC40Z4cxQQk/rKIr9nH0+UivMcVO4Xg+TLRPAfehogttEFpeh9
         sGbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772345647; x=1772950447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5GuTwJ/dWDwJhqxfL0eZlN8azyUiPW9ZyHZw6pgplw=;
        b=flESVuPrNIKwOLOvzoVgCOFYBGiGLu8RQOisDctlVh032blnudJoroIW304LRZNXcI
         GAeZ5AxwVOeyE1nCM77CeUbiU3EbK1lAuu2ouGvXofhwza9n7mxHcoSPs2V6JhrYZpL3
         ifmXCxov99KuAmfbLuSAmdkJuUv3FVGyN899lauTgf9Z+yiI1RpZv5qrRQnTnpdX5B0X
         M3GjbCr8Iirc/B0LgIE3vxZmFV+JFH3SW73sPXnm0aX6T5Fr+0lZ13dmR/9tAQ1/jHwM
         QpnILIqta5Bfh2rhp11BxQ+IdpAoLk/E50j/Yk5UvgdNj38f6CbPyhNgCoC8uVN6Cy+Q
         BfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772345647; x=1772950447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/5GuTwJ/dWDwJhqxfL0eZlN8azyUiPW9ZyHZw6pgplw=;
        b=NOhb2kGv2DwzfmiCg1IwXo5KDVJiC/his5YcC6iyLrEz+N1kw4hDvQnvPxjwJZnkt7
         QsVkzEURMxp8aYTWlAEHL8dP7s+riK23vC/I2BavGDNN2f5HC18VcydBukVt1D1T80xz
         VDyh461FxPDyqERi16KYghTDuRH+kuePIpSl+vpmdqWUKPhB7liaFhsAA/l+mUmN7Pao
         apEgILC98DYMnkAXUZFPBIvrytt12tsDeydMWiYECnnXEbqRh522oXaRKSxhMmj92r76
         GEXIlXp/uGXu66PQj75qz1wGzsmhV0Zqr1Z2W5r3epYlMzxX8GPGkzoJ8y4x2TjXWOYK
         dWQw==
X-Gm-Message-State: AOJu0Ywa0XFMNQM6ivCHo0Glvvrc//2shDe2YGgBKB/crkK3RKkqCI7Z
	F2VKW5QajJoelt/nFDwzXTZcVHIWGdjkoDwbmxfon8697dw2gdVUDOyXkZ2JMczq/0frvr7G5vc
	EykI0ayDmMreA7KlHlF0xVmnsY66M2mU=
X-Gm-Gg: ATEYQzxcP/FJCCRj3B1BjGlO+h4pU3sV9PVXFJxvzSLZftwbEIhm8uhH1jhIa+mqEBX
	Tcn6vIvAw18yZNe1Bu6Nzea13MinS6DKGO54gAXR9QTt1gOop/2czTQDVbcQF/1UATtjxAjbUQS
	OHwbIwlPRv1N8ey4bzhvObSa8338zSZqv68j4bewS+VW8LfCLSgQVTWdRz3HRm3tg4X4j3FH+RS
	PRaYpJiEVNla4/rvXmFE16xAgzjyDFAeRpo7z8RP3cABvpAnX8q7P78MUCRFESz+GEMijn5MmZG
	YG4/sytVcw==
X-Received: by 2002:a2e:3219:0:b0:383:1b75:b9bf with SMTP id
 38308e7fff4ca-389ff356090mr43234421fa.28.1772345647085; Sat, 28 Feb 2026
 22:14:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFNBzOc=tuph7ecqt9TAY-aCWUkPyQ84DYjwMp3QS4-0J-wF_Q@mail.gmail.com>
 <B8697AB9-9C9B-41C9-A2D8-1848CD966137@gmail.com>
In-Reply-To: <B8697AB9-9C9B-41C9-A2D8-1848CD966137@gmail.com>
From: Ayush Jha <kumarayushjha123@gmail.com>
Date: Sun, 1 Mar 2026 11:43:56 +0530
X-Gm-Features: AaiRm51-M5ET4WjXZoaGoOG26GAke1COYcXgRzOuGbV_NN4MpxcuJLio6fjnSfQ
Message-ID: <CAFNBzOe8_GbXFTmL5UuLWa+5xa=D04jJkmqMumerajeYGkVwaA@mail.gmail.com>
Subject: Re: [GSoC][PROPOSAL] Improving and Extending the git repo command
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, karthik nayak <karthik.188@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

Thank you for this feedback and for pointing out commit fac60b8925!

You are completely right=E2=80=94assuming a blanket "relative by default"
expectation ignores the historical nuance of how git rev-parse handles
different path options. I have updated my proposal draft to remove
that assumption and properly acknowledge the complexity of path
formatting for repo-info.

I also just left my thoughts on your new repo-info --path-format patch
series addressing this exact issue over on that thread! Let me know if
that direction seems correct.

(Also, apologies if my reply to that patch series looks a bit strange
in your inbox=E2=80=94I accidentally put Jayatheerth in the 'To' field and =
you
in 'CC' when replying!)

Thanks again for the guidance,
Ayush

On Sun, Mar 1, 2026 at 4:28=E2=80=AFAM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
>
>
> > Hi everyone,
>
> Hi, Ayush!
>
> > Note to reviewers: I'd like to hear your thoughts on whether these
> > paths should default to relative or absolute. My initial thought is
> > relative by default with an `--absolute` flag, as that seems to match
> > user expectations for CLI tools like `git rev-parse`.
>
> I've just sent the path (trying to) add support for paths (the one
> you mentioned). I don't know if it's the best approach. I CC'ed you
> and the other GSoC applicants that are interested in git-repo-info.
>
> I wouldn't say that the user's expectations is to retrieve absolute
> paths by default, we need to check each one of the "options for
> files" modified by --path-format and see what makes more sense.
> See [1].
>
> [1] fac60b8925 (rev-parse: add option for absolute or relative path forma=
tting, 2020-12-13)
