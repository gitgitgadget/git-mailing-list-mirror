Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E09230216D
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093037; cv=pass; b=fmJCMtOv2g4o4ivD/KFKAvhvwCVY8nZDYXn38Q5OgRB9N5j3lbX5nuHVLTyurYj4NkCqGO23PDn/68HTEBp7j1AYG7KNQ+mQg+cTLwyYyycKVXj/SK3lEmXOCk6kDDVoroHA4AzjV82UY/PpZysE3JH26SZNCWvxg6FW/wLca9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093037; c=relaxed/simple;
	bh=fHZ9nBB1YU5E3SIIvfP34z8IEAmuGP1nEFU8suw8XoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCSndKIyCZlCeB/Q1MOUiw+nl6ZfHha5f0g/6HB61yMsrCIJLN2x+uoijZqNGOUkhKqXSq9WHqGnHXfHxuPxTEkXLmQgl+V4kbIednJmX4TXgJ5W4Gm0f+DbpwO00gi58qaH9kGv9D6jRVfEXWFb6b6yTsdI/Zs0jKRXUrXb+zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8KpaUFV; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8KpaUFV"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65801ce918eso2253035a12.2
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 06:43:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769093034; cv=none;
        d=google.com; s=arc-20240605;
        b=c1un5OcSMg27NaX+hCN/cH9eU46Bc9m6ORu+gPWABe2gGKN0Mbb6x73gk4mUczNTBR
         0Sjllu6m3WBowDCQQc9nWXk+I+Cr5nWvhIPBz707j9TUIcDOiNCGtWUC4fo9awP6MOtD
         jCAV5lBVV39ida80FtLROgFqDKiBUfMfsjd761wZPFt7Rizer1cBhHxZz3+778vL0kzE
         bDsknXCWivoBnvkNyZWAs+Q0/wPcrKhUgvIlNc79tVf+iwZcKcrBghV14w1SV0VeZW9i
         M75+9S5mOvD34Ugf0daIhXmfM9B9jdc6YXH+qZ0L/ltN03PjZ+hBV07hcRruWbSh97ex
         vJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fHZ9nBB1YU5E3SIIvfP34z8IEAmuGP1nEFU8suw8XoQ=;
        fh=8vHLGEEesstCVeANqzMibFIFhcPnxtHULMQMsolPErc=;
        b=UztjrS5oz7b0hFl9sTb5QXRIH5ld5JXtLwGT7+h81kSX4vv8Y8RD2m6VsFDQ9VR0MC
         rObKRNUfV/4q5PiI39AZnDuGe583kFKRrRX3csj6un3JtV4QKDEBIgV1IRBKQ9cIDf04
         CfbKXxeMKD1Q1d1p9VJmK1utdVVXbTluKjGyR7homlW/s5xglH+7VNtT0x73ZpKZFdYq
         M9C52SPxblYDfhocgQafryF5FB6V77lwuguv8ICMGcvPim+8V+po7sb4s9dEL1nL5dbP
         XF7Q9HsgRzu6kVgalBg7vDVpfYsHEH4GhT2RXasRRwo2OLR+eDH0Iij7KokeSzgbKQX+
         Ue8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769093034; x=1769697834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fHZ9nBB1YU5E3SIIvfP34z8IEAmuGP1nEFU8suw8XoQ=;
        b=E8KpaUFVlUkCMXQwI+EKw5QJbX1vf+mDZO2LjvB+6n17p7SOaTOflebZXkJcAZ481V
         klTetPxSAdgMNjVszg6YBgSuX1F8yg1ZbvRKUKkKcbIU4afC0pm1smUvLzqz6bnOM5Lr
         lYu6bLAtHyEEa3rAFJcAyvlLu715R3B+XHi2hBKPtP+OENEfWdiJUksva+xA8zXKXQjr
         3c2jqmaYLwvPhcsj0O//pyJ9QXcvSauQAEIA2y+NrNBr+sXDNmZTP77xil+HEE3oHPvu
         qBbZmcZADAzq1pngSOsVzhRw+LzY6G5A7gRzEvcdlu6V3u/3AqL0wOPt/Y5c9d7RF0Ee
         13Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769093034; x=1769697834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHZ9nBB1YU5E3SIIvfP34z8IEAmuGP1nEFU8suw8XoQ=;
        b=LAfg9hD6QYfv7yyE49VtoiVnZISTXFoafPDOWYpZJQZBLl9LKHcFt5Whgl26L71/Mn
         vpRGrJsU+o4P1sgwa7VXwzKAigLE4hFSdcJD3a7d5ka2yqD4quwbjECWiG5O/JL7JhNe
         pFT9kAW6NrpArUdq6iJOREh36k6D09tvIBIWuUzWL/lLiEk59XzXIK/Aa7Zoqi2MSFi+
         bxxfQz5cMiC/bKo98VYOf4+oFMcyQfTPBNR+jNXD6Rc9RbKmBTRFlNX4C+XkW0/dOYCL
         D1OVH4Q5YUKLmQi9DI4xK4B8/8smXKtKVJZdv5zP3/CQdGD7SIKKa+gAHtQROpmhTA9j
         C4IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbnqwC8AOQQNMFN66Efbc5T2IrB8gI2GplgwuTgaL3kC4tWBMWf6fAWhfdkn1Q4dap/gE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2C+GoiAPdI8GgcBpS79UB9v/MBJ2roSNUANQwGic6Ax9QDw8B
	JODSfeku4h4GJnqq8S2f/OOfMHXZXLlb8ReSZGji1+0k64aWDWCoLh0AdBlbqC6RAt0kClYitva
	7fExKtNHo7x9zUXpYtvEjcnKZI/QcNiA=
X-Gm-Gg: AZuq6aKulIe2Iljo2bToo6fqO4AP2UBnJcYj5WATrzzWvC5DYDYgtjTcXxO9UaIPdDD
	Djt9sl6+DpdsFsPmkcVjSCTzHSVBaH0P1oIMeCguutnbMMQaEMe71m3wRXGl9UGz7lKtTRanZGG
	u51X1hructEOQa2DFcb5vohptJXyYNW2nNqQoj3MygMJlX95FLD/16u2QYsoDBqPxKxyEJxjLB8
	pUKxvQyAhXuRaeKo4qqkt3PLyc/PssybFeYv3GVsbzrsVtNqbYsoOg4jzrE0+Y9BcEtknfLB5xm
	HRi+bBCPC+KRpGVLwkiA056SSmUt
X-Received: by 2002:a17:907:3fa5:b0:b87:1d71:f44d with SMTP id
 a640c23a62f3a-b8792d27463mr1830134366b.11.1769093033271; Thu, 22 Jan 2026
 06:43:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com>
 <35E56A79-FD65-4CBF-9A35-BCFB9A169BFA@gmail.com>
In-Reply-To: <35E56A79-FD65-4CBF-9A35-BCFB9A169BFA@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Thu, 22 Jan 2026 20:13:27 +0530
X-Gm-Features: AZwV_QjgW1ex9UtjnsQGSZsx_nQbg-7JxTAdEWkIQo0JpVfhIpCY2G_By3DuuAw
Message-ID: <CA+J6zkSo1LuFUdTU8m6z4vANrJ2r88EV6RDDC_0ZW3bWec2v2Q@mail.gmail.com>
Subject: Re: Git project and GSoC 2026
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>, git <git@vger.kernel.org>, 
	karthik nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Meet Soni <meetsoni3017@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	Bello Olamide <belkid98@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hey all!

On Thu, 22 Jan 2026, 10:38 Kaartic Sivaraam, <kaartic.sivaraam@gmail.com> wrote:
>
> Hi Christian,
>
> Thank you for initiating the discussion.
>
> On 16/01/26 16:36, Christian Couder wrote:
> >
> > The application period for mentoring organizations to participate in
> > GSoC 2026 is from January 19 to February 3. Let's try to anticipate a
> > bit and decide soon if the Git project wants to participate.
> >
>
> Indeed.
>
> > If we want to participate, we need (co-)mentors, org-admins, projects
> > and micro-projects ideas, and we need to update existing pages or
> > create new ones on the Git Developer Pages (git.github.io) website (or
> > on git-scm.org if we want to switch this to it now). Please chime in
> > if you are interested.
> >
>
> I would be glad to help as an org-Admin this year too. I could act as a fallback mentor in case any mentor / co-mentor becomes unavailable during a particular period of the program.
>
> I also Cc-ed Chandra Pratap as they expressed interest to be a co-mentor before.

I'd be glad to help as a co-mentor. I think I'd be able to best help
with project ideas related to reftable or testing, seeing how I worked
on reftable tests in my GSoC project, but please let me know if I can
help with anything else as well!
