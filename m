Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFF02BD0B
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781367387; cv=pass; b=maIQfki4/geIlFIQXI62kPd75CXzU61A+fVy/ij+Twp1NrV4mZsNdV7MqfWdt4AyL6SRd8Y+q7mhZBYF5kzr+N6/k6J0uYblq2tNlNinjyp0XHReakVpuUjSugmU5aPQOYiva9X0LDb/F0KyRFcIPfJ55NI3yekaamtFkS2jTQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781367387; c=relaxed/simple;
	bh=y4y7np+3KUNiqsgIb/kwtbirMgVLU3nm2d2AzUp5VW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpECUKi4Vvh4BkJfdRZGBj6A1sp16+nfR85uLQGTNZjtnaiUHe6kdfKiX+YchMXf/gTK2WrXQsdJwZ1YwI3xYWv9Oap89Ib2SCz3qF02VEYuYtEiM+ttkVd20BSeSUnR5biCYel8jn62SjaGnyIK9v5IEwRmTMRELv/bC2mlWOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObMHqZbT; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObMHqZbT"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68ced97b6eeso3117282a12.0
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 09:16:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781367385; cv=none;
        d=google.com; s=arc-20240605;
        b=FuvkbRZISCkN2EYe+arDrViRhDaRjMmqa/7ZyB40nFDfG54JXEIXbngh+Mc/EgctSQ
         ndjtKShi1OVfEd3daMOjT9yTxJiRuGQKk+d90Mq0sL0lh9xFKzTqlRRGstGfgQER/Gjk
         K620/o2/cdduOaOBgp6dx4qIMdIVxdvsJrk2Sim7Q0X/XRtnrvPLJOPUlqXS/HVUtxk1
         rzG+YYLIeI0ElrYEYgL9k9KHOk7XwkLJiib59lAGO/2o2cI3hiqjfCFTCWbxGlRRD/U6
         Lu9VkdG0/gEfcSbcYSh9cyXQ1ruvJ3rL5bXAC9VsxPqVBtWqK0EEcJpW8DOugKBIZoBV
         pUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=n9ckloW1l8AZoEGRF9Ff0UCDHKfMzriYKeCLb8FEX88=;
        fh=K9cQWNBh/e07nBksvF4Bc5jlEgFgNN/Y0tN6RRoZ8PE=;
        b=a9+pEm+DQ6Gs7JsQFZpoVY60N2SnigPIQUQXI9QRLowZXgdOKnJqWRsV/QbM5K+rVm
         M1Vo1z3+w9EIyQpxwK59hLv4ro06jrDwP3KQLBlm6QjYv30uq3hSpaHsnvFTC0vjfnwe
         scJIuOot4Xc12TO0msou/Sx6lEChxe8grJRTC35xIFm+p+xcvaIQx2jW3MujN4hywVtl
         5MT3M6mo7gAN6UTSIDo5fgOTq1DAme2dJlmSnsCHPi//IifYnNiNikOn3Qc/LhcHeztq
         7wp7v0cMKGmHXlOVImTSUhOjs8QBepK9LZh3apfJMrwPhBhh/juxw3uphwRAmQPDB95V
         8hAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781367385; x=1781972185; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n9ckloW1l8AZoEGRF9Ff0UCDHKfMzriYKeCLb8FEX88=;
        b=ObMHqZbT6VHmVpDrhsnKiR+Qtw47PJSxYzcKzreVWGF+aYv0ahOX+bFaZeroGSxrKx
         tGN5x5oFUfm0pQ4BMp+rfMZNSY1LYTjv65cTz74Ry14cL04LrFRA90qehQnARbbKHPGb
         MHmKeRcYwnMDdDXkVivypIO54fc84Zedwgy+hL6oZiVEW5d/uvY2sN/zpz2CBK2Py+Gn
         k0qklN7Q0UnIlZeGgKHEhfxnFKyMvTZ4CZRaQcMhNv+J0XQdHROYYFLsTELSG5KHRQBp
         BwdVtQwohXO71IOZcM8S8+W31PBmcFNibgtrnSycZ89QFvhHKcNrPlP0wQOWci5Z8l88
         RwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781367385; x=1781972185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9ckloW1l8AZoEGRF9Ff0UCDHKfMzriYKeCLb8FEX88=;
        b=UbPaDxjWxPKoM7RtWep0nVe6zWwEZIXSXZa/U1l57JsXHtkTubj9QILiCg47ouGnCl
         Wdh3qX7InRK65tR0gz+7i4mORhPWhIGIsDCOpCuxnNIWtk5pzlyFZeb+J0EOfDnNlKkf
         p/5tS0iGlg9gAABleupWpSBx6gZ+2nx10dOj/RhisSvTeQw84a2Ti5iHYwL4YGtgLYSr
         IXw7AS0tpYqv67zF1op6d0s6mpAm+OKBOjYOzvYG6NkSZ7K995Y/dT4ur8jQYhfXuf+g
         tGH+3zZ7pP81VfByd9f1QSp+UTuSfqp55LCRB0kmeZ1KheBj5GI4PXmqo0nkxH/fkqP9
         48mA==
X-Forwarded-Encrypted: i=1; AFNElJ/awBFcNqtP5mbvNaH+BxRbvzlYaOep+iIBVNuNfM5gCotHAeZQyXR+cI54SNSH1gkeKA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRFNuXxRpfRBuEdoHzNge2Hfwa4pGmRRpf/JWSVvy/kO1sBjIq
	U6taNwb7DjnMGju1cJqjB5HaIzV6UGWPebQz1n+CWLuQZXbJ6LQB1ls8AVYU0HscnieQdu/eAZF
	QXkX8dN7gzK8zxxMImiloUbkgkUg5Oew=
X-Gm-Gg: Acq92OE7sAo747o5oonocVrLt12BTT3Z2n6Nrolrvirjgaln4VlcX4JhJ6JTQcyIkMg
	RATXt+TkNZBir2cZt1tiAmjNGJDYcC8aHHsY0Gtl2SzHTUmY88UAQ2Q3Q4bhAh3SpOuCbtfhDVo
	tQI6I71hMdnPqfO0jEr6RhUY/05zP0kKFtU6tE3tgPhxBoiqj+l8SRoHQyaBWSNt0SmmClH/QXo
	X+x2QsICQAxDDB+Udelmhj2BoAQNGoSxW5AWcj363C2hXPp8TAOo8aPX0UbMX3SlgYSxO88ppwC
	8wnyg/I=
X-Received: by 2002:a05:6402:40c9:b0:67c:6836:7b0a with SMTP id
 4fb4d7f45d1cf-69378a2f837mr3563059a12.23.1781367384640; Sat, 13 Jun 2026
 09:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2334.git.git.1781342189.gitgitgadget@gmail.com> <xmqq33yqfnsa.fsf@gitster.g>
In-Reply-To: <xmqq33yqfnsa.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 13 Jun 2026 18:15:48 +0200
X-Gm-Features: AVVi8CeIGrlDGC0_SLQl22zik3hBDDUxZNp0m_d6x6hbR2Lv52R7cAPpvi718Qs
Message-ID: <CAHwyqnXDa96+NiVanYyJb7R+XyOz6ooS+SW+b2OdKx979gUNaw@mail.gmail.com>
Subject: Re: [PATCH 0/2] commit: preserve commit hash on a no-op amend
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Interesting discussions! This sounds like showstopper, seems more
reasonable to leave this topic for now.

I just want to share that I've been running this for years to
re-trigger CI (because up until a few days ago I didn't realize that
the hash did indeed change even when nothing had changed), I had the
wrong mental model for commit hashes:

    git commit --amend --no-edit --date="now"


Harald
