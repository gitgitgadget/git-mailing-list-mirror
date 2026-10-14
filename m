Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17031548578
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988606; cv=pass; b=g0ttWKi80oNoy8BGXGNfyRr/iY+p14ndhNCn1wf+nlNW6fhytDRXGveVab0Hck4NI0ngmOxGBW8R7hMpRSsTCZmTj/bJ70yF5oUSM0+TFDRjR4w+IXsOY2WtMMAdTlfAcb+u+W1VzHR2Ce7zuioog6mxgIutnzjqBOI1P+fp5Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988606; c=relaxed/simple;
	bh=ZW9xAkJQqQILMjXa1RwW9zxFjKMM6LyQ92FxuWc/FlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOr0B+0EUDQp/qXJFeWQSPoEVkvgIQ0C1vJF8y9dyZNwf7AgQptdOqDDiEFaU4SdyonXWRs9P0LxLXU6FGXY4+sQ14emUf3xqtocNp0kLaA57y2U/5yw2SW23JgRl76pH0OhK2HPA1Bv4AAveGtoABsKcu6jimwd6K1pk+LUSAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3BZPbTJ; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3BZPbTJ"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2e3846d1caso679348466b.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 07:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791988603; cv=none;
        d=google.com; s=arc-20260327;
        b=RCN0g0zzvSWghTpJY/65EmJmhe/GkmtZWe0wr+4yPcdQHYKQoD5q7gUMgafInwXOR7
         YNEVoMwNx5EybzKde8IPuive5qjy3VQs9f3+MLQxHmzHxrRl82xw4lFclLCNWm1rTs3P
         pyuAjB7uSichCHq3zpjYXPHYu3izETqhVf1IRoLZW81CjaFEPaN5wxopJeLKcNaB7Wob
         lq3iVwm2MTf4m2AoeMcGr9d9K25u9Bw6WYAbmJiPd0ArUWi9KGJ4RbKUFgxczukfAxxM
         OSsAKzDtUKSY9IqIZBmh6FP8vjLpjVGBk79DFoFCOMIG8hnIyDDAzlot5jLlfMfVJjrA
         rOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2ubB5xpnEvF3U9nJs2kCCvYVkXruabhKPG6/6lG10l0=;
        fh=GmKTMWABzlxAbd0/XaVHd8A5XxjcNba3tHmY2F+YyIk=;
        b=q+qmDS/fk0Im08bC/8E/wlcEqeykmS48lRx8fYgErvrAsddvaC8b8+7xnWq0JZD5oE
         X7w9yPqSmEHPXfjEHMlqtp4FjfwUHYdXeqCrP7gDCU0i5cWrfrMk+I9mtKkV1RI1dLr1
         qW6limqyFBkdgz9ogyMpQEAeJBC/WAx6T0aaP19bal40EdEq1idv0dU3/pL0TJOn+BHm
         SiEytEYLzjnsvjfhpMklN/zoE9LDIEzz+JfSwQS4EShZ2QMUENggH5+Azx4u4b3KypKI
         ewumY6ItrQtzv5LIlB5uimTB8fcMRmy13FFTPCiv+qIST3XlfYWhcwJ+uy2Daix5UPvR
         j4cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791988603; x=1792593403; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ubB5xpnEvF3U9nJs2kCCvYVkXruabhKPG6/6lG10l0=;
        b=O3BZPbTJslsJfcQarY4X4TdxuFgIYTQp36pi9b7zgiGNyd7cumrFWKT/cqgaocFUeA
         VL3+uUCxdZXNDbdz/KzvkFStuIvR2YdJmKjaRFx59HMzbT1JYkXhXtBDjY/YSAbQPSix
         ZpkcpnDQLMnxR6hnrZOvZTp4V4LOKA37cjjwN+aDpH7kk2k0TcS/ogBlKyR1SgsmNBRY
         E3+S+qO+TMDdddXQObOah/Rvl6288WjaU8O5tRuj2Bi3rLPkW/g1deizWPisQZObopH5
         fv+xpM179ClE/On7/x23i909XPphlWeS7IPeLWsGqok0pSrS5cg2PmkzmaQTP8geh6T4
         wDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791988603; x=1792593403;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2ubB5xpnEvF3U9nJs2kCCvYVkXruabhKPG6/6lG10l0=;
        b=FUEWuEtCx8buqSDbMSlcR1+FZ6xFol+EuoYRxmEW3IPN9EmWVpsn1Y4e4u3s/4GI+Z
         K/tv/M4kgCqNuInl2twSMYNAcXFQ0ORDvhK+zNjG/qZ9dTzZAbgAU0bqTrUGSStwAs4d
         6FSUlfWpysvN0fZFaHypori0DCZR7nCioLFbNyZicoeybPVMaIhsjZRrEyLKn9Zx4Vu1
         f425u5G7/OB2vVOtQ0/uHE9fx4gBV9Rxz2k6w8OggKihsszwJhHFMF/ZzaN5XTHbjsIC
         gOUxf9Wp4c+rpJBLmt0MqM5M9YJLhCzB6WoTzbRQCVQFrsYIjPaGItvRlse3wirExY+S
         RiKQ==
X-Gm-Message-State: AFq9FYIum+P5IruIXpX1K1pB9LAphIRzx0TJtlpPhCrbrcd51G32nnrt
	vAjnxlvtsz30P22zmVqNtOpndpi39cysa1KURkeGSra0RFq+PrFHpeEyXlIOWvr4I/zwizSfJ6p
	f0W6KPAKz0jTgj6I6LdBC6JE4zCVOe94=
X-Gm-Gg: AYBFou24BB0yiluhOylHZ9wyglkGss1S856YiqYa2lKg/4uykQAYXMWmx1I/+l43S+u
	0tDh3pVgWXEOypW/Psje/BOYbZntFjq8gjt5CfoSo0qQOeR9sfatitaI3X5KzAT76K4cosT4diF
	u6JnqX1HAal6K91Phec6BtNhuT2g50CrIt6QzdC4d/LFnyLyMMl9PxqIH6IA80nLA1eu0zSEah5
	BBkd5qh4Hpk86kOEm8OMZaNgfn0F9o5jiq6dwDkAbq8wc3pNx7QUtXuGoVim7rIdP+B4BUxfq5F
	q2DQp7LGl8Ae2Ebdj6rHPDOg8KJ5g36LAHBFukYY9+9y1fyaAvmRkpEHNkEH5K0iyDq8AWrL0M0
	BEcY7mhMynlwbiw==
X-Received: by 2002:a17:907:3ea2:b0:c26:1691:b369 with SMTP id
 a640c23a62f3a-c31a9f6ba9dmr1707090366b.34.1791988602694; Wed, 14 Oct 2026
 07:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+ew3JuatNJ_bQkormLgm2O1DVQ4ZBTXnXnJPjOMcfcKZZ+Ang@mail.gmail.com>
In-Reply-To: <CA+ew3JuatNJ_bQkormLgm2O1DVQ4ZBTXnXnJPjOMcfcKZZ+Ang@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 14 Oct 2026 15:36:30 +0100
X-Gm-Features: AclHuK8Bmub7vQj41rHnxsxwF4zyN0frh4ntjapkAZw-wh8DeOCJD3-_iYlyPmU
Message-ID: <CAPSxiM-2=s3rLFVMGWtmj=U2ufQ87NrkEBoWPLsVRjL8iT9vxg@mail.gmail.com>
Subject: Re: : Interested in "Implementing promisor remote fetch ordering" as
 Outreachy Internship
To: Wasswa Edson <edsonwasswa54@gmail.com>
Cc: git@vger.kernel.org, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"

>
> Hi everyone,
Hello Edson,
>
> I'm Edson Wasswa, an Outreachy applicant for the December 2026
> round. I'd like to work on the "Implementation of promisor remote fetch
> ordering" project mentored by Kaartic during this Internship Cohort.
>
Thanks for your interest in the Git project.
> I am a second year technology enthusiast student pursuing a Software
> engineering Degree with an interest in C Programming and Shell usage .
> I have more that enough exposure  in this language  from both Open
> source contributions and  personal projects. I also happen to be one
> of the contributors on the OpenMRS Distro where I have utilized Shell.
>
> I am more that happy to be part of this profound work and ready to
> take on the skills while I learn and from the Community. I am a fast
> learner who loves innovation and science.
>
> I will be glad if I am added or invited to the communication channel
> for introduction and Open questions.
>
Git uses mailing so, you are already here. The link to check all the activities
going on is https://lore.kernel.org/git/. All the emails and patches
which you and
others will be shown on that site. You can also ask any question on
it. It is advisable
to cc'ed the mentors when sending the patches or when asking question.
> I am just a text away from starting my journey to learn and meaningful
> solutions to substantial issues
>
> Thanks,
> Edson Wasswa
Thank you.
>
Usman Akinyemi.
