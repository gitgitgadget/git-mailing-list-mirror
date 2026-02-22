Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F5AE555
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771785257; cv=pass; b=RxaCJLKILiG0D7IbqQCOtiKi71HhiJWruOEIksb1ur8ZA/t5MGFkIwEqyZRnTKACV+CDiG/kShPZQs3z8Z5Bk2gJn2uId+PV6MEbZVXmCIniDRhvH7/IqA8JAueUTPIypuR1Dy1AdKBbDoIkzsGw//pd2QUZxloe4Bw+bzHmNHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771785257; c=relaxed/simple;
	bh=EK1Y9vc3COqAIBO798HGd9XFZT3WHhfMMhjT5VPvBc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MlUqH3VSbvaBbAwE5Qi4kBMyPnZThWlHNHarYbsIZsWsbG9H9rDK0Z0PIS3Wm09dTgZDF4k23TjerJVMUNSpGn2Scl590cg8uEPdjx29L2ukWstgDJg1W3/QO09By9yZFUVzSlgBCJC47bBackpprh+/lXJiq9uUt1ldHjxw/88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGu0U8p8; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGu0U8p8"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5f5418c40daso4285903137.0
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 10:34:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771785255; cv=none;
        d=google.com; s=arc-20240605;
        b=SFzn/V5HfabDGDRJl28Ol821sfNRlbdumLcVEcjI7wKuJSUlkFcF+7WaFWQd8iAKmG
         tSIe7LkeibebuNgwIqBPOhJJapfvayC4wocFUzTy9swWP9WdAoYk/rAKW1PPB00eztHw
         XmYP5QLhysTBPnjTd9gf9BWC3PuJwxaudr4/AZpDB268ohMqKTpJQ6U7MlmOKvswEI9V
         7nYMZ5YVUFaJZd+9iCHVbiIJwrw9PdQebslQdfeCq0EbBNoB9be8y8i6iF+pybXQdvM1
         EIt2jgDHT7eXgNyDworVHAmU9FEIhxSO1LqZk7Khu6pP+WrAAlUIYtMbAtBIGH9OaMYW
         HghA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EK1Y9vc3COqAIBO798HGd9XFZT3WHhfMMhjT5VPvBc0=;
        fh=XeDXraPVs7A9ac3VLZPyyuV4JPfhQ157OBXcK++VJAU=;
        b=USVGVvG19g2I4GEDVGSCXtT7jzwsIY6fX/JW5/gg20MhLO2+d2mPY7uugwhTuytgMT
         1NshfpfoNBtp8S/L9PldnD/YCDvurLnwjwPCdoFRIbmGQuc5InKxXglry279/mNgniux
         5fNJZd3wLW+fPBDEQF+7KMt1pnr5BLMfOctAd6Gg7bCp9gYteCs4n9YqMyTiMow7R4kk
         SMMjZn2Dr6/3VIND4+dkOrQqktgQY/yjJSTtKk4z3RNxiIjj+kpZi58xRofYrGnfN8AC
         cZrzueVZfokqx210/yB6XkZkgxjN2sp2ho3Ay+piD8q44OrUIM/wbJDFtYTJfv/ETNDI
         z/MA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771785255; x=1772390055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EK1Y9vc3COqAIBO798HGd9XFZT3WHhfMMhjT5VPvBc0=;
        b=ZGu0U8p8PG8+hQP11wfwOV1WROaYcIYUPHAlQSA7jjol00JK+t7OXUtXT8YlhZM6vc
         vBW69JLkPk2KblfV7WXAiZY+LKZcaGZjUTFm7pKHeEFWLKnOg5X0ksBi14gQWIxJYdc/
         AkHh8+NzGJ2+VdqcWhkCGRbzd42Turxtzv8gDrjOBqj5hoxpiVafVgXYdJ4YL90Fv4Dd
         uci4Su5In2XqfSTGzZlJp131ZRE4KDg3nEDluMMICAFTSq5ceuSW+D/ZzbEIhIY7h1pp
         OPR0H37wz2CfZ8KYT4YxJOif6KaxlriOCRIGFEoit52kCRg9KXhuMtikiHNM5baMEPN8
         Ih2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771785255; x=1772390055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EK1Y9vc3COqAIBO798HGd9XFZT3WHhfMMhjT5VPvBc0=;
        b=DTq5R9YAra1VKCNe3/zEuMJcLIMqZ6inoAOea9tKcPPBu7msk/NwOmz8BCaGDXPCM/
         YPOaQJtqM/KeKI203Idu8YdPxtXwIQBkUXsxrfugC5qvSPEt/4tuPTNbpQ3QytvH9OgK
         rVAkd+bsKoXw0ZV1T1t/jvX4QGG8tttw6nhJpxeBTVSPU3OaKmz2BtjCMDTURgfWWVKo
         97yUWzy/43LZ38GXxqgje4sRmMOrsFsXpFTPcgEZaBSOA3ILIPPcnb2k8lSbi9bJ/9Ci
         +5tuSYrtSgmOyAnRIFZ6axGSa0bRQc4HE/QffJf8r78GVSTalIdrrhQzEv2J5pH1/E5I
         Mo2g==
X-Gm-Message-State: AOJu0YzOwpVG8hGCXwZwB9BUmiBx1iUhC45dqujBgu6Jln1Gznm9CEY4
	bi5Df/OZyRmn0Eos8doWbacyTz1M8npsZN1XQ1H8Rx5vE7DAo9DLMTbs6GIX/5ugtZHDwIREPCY
	Wj64AMArzMaRSdmYnQSSZmDCmyF9vdyE=
X-Gm-Gg: AZuq6aKh0hcBYLoWvxr/Yoboxn6ube3JPed+IUQGZJ6mARfY6yckMTR64I21stw+i32
	LtZPPprPIyWC/8UblmjYBispbsLx7Oi8pJdpuoYoy+CzWtJMHb32m8dijrH/GTTUpl9xdCbpd7R
	vUSyoYsf/A8q1MfKjpASMkdYBTntp7W0mmLJNo/jL21T60EGqENii7Be+vZyPL8GMkGTyZawzim
	I2HVykOz9+9j+iwNc9Xg68rCuumoqU2vRyr+LWJozcPGshEpr+1+4sQJQ3bVOc/bCEtD/zx04wU
	5NFdLS0Rq7vaJjOQpt62O9Yp9JFWG3xBEOIra+Q=
X-Received: by 2002:a05:6102:38cb:b0:5ef:233e:6b25 with SMTP id
 ada2fe7eead31-5fe90bebbecmr6635292137.13.1771785255192; Sun, 22 Feb 2026
 10:34:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ab45758c-fbcf-42b2-96df-030eef8526c3@gmail.com>
In-Reply-To: <ab45758c-fbcf-42b2-96df-030eef8526c3@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 23 Feb 2026 00:04:02 +0530
X-Gm-Features: AaiRm50Bpyx0OFlWZoVzCLcimInoMNMxr67O1p_xkSXo_XA9xmDREOsfuT3d3tM
Message-ID: <CAPSxiM-f1nQiFAW=dDCCqr1Yce=ZrVrMYE0YHc+-cFAjx+5m8A@mail.gmail.com>
Subject: Re: [GSoC][Draft Proposal] Refactoring in order to reduce Git's
 global state
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2026 at 11:29=E2=80=AFPM Tian Yuchen <a3205153416@gmail.com=
> wrote:
>
> Hi everyone,
>
> I'm Tian Yuchen and I'm planning to apply for GSoC this year!
>
> Instead of pasting a giant wall of text into this email, I have
> drafted my proposal in Google Doc. I thought it might be easier for
> everyone to leave inline comments and suggestions there. (Of course, if
> you're more accustomed to email replies, you can also quote the content
> from the doc in your response. Thank you.)
I believe that a giant wall of text is the appropriate way to send a
proposal to the
Git community. I will advise you to send that giant of text actually.
It is easier for the
community to review and give feedback. Also future gsoc participants
can also learn
from it. By telling the reviewer to go through the link to the docs
and then copy it on the
to the email just to reply is giving them an extra lot of work to do.
So send it through text
and make it easy for people to review.
>
>
Thank you.
