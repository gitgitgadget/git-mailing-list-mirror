Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0A92D9EC4
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447223; cv=pass; b=dpAYFqw4q9zS67FIqq5jr07oolIvnyBB0BS8HjmQ4qHVQe2cZpUTvWOuWVcFwVMJRMFN5keEzOW7sSjK0Jo6QmqMRR5hndgiZIIfPZDW85KvysL6CnSSJwACTfe2gXXaaMqlIM5Kf67Uaw9C+12K/uCxE/G5bISX3PhPvCzL7oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447223; c=relaxed/simple;
	bh=fz2n0DugFf8ROS7QtPeGop96kX85dqVfM7wC5GvFOOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rImAJ/pwNnjWcZ//la+0vwgLcEggGX59ifhXJUaxRrkdEvkLFxaZLBGGuNfTCnkQE+VRi6ZSKoOoLk+Ky89bF0uk250c/F0E+KhHTHrsFA0/eMV0ubm6Jhqw/DUexW4eX6S8juWIns+Y4mDP7Ce0O5ZjUh36i0fQJbdNFI5DpWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4iDZaZd; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4iDZaZd"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8719f5a2b5so63488866b.3
        for <git@vger.kernel.org>; Mon, 26 Jan 2026 09:07:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769447220; cv=none;
        d=google.com; s=arc-20240605;
        b=CgqWoWqYYQcgl6vst2aVTOorv/Y2ESxkRa0S/UkDLbtGr57b2Cn0xLRjE+3Uf7tWPL
         ZCIbV6QhPgBjdngBO0DIrm4oeLvOcXCWcGg5m7o4fEFbnMvEGD4tcWZrkOT5PO2XUfqH
         rXQcO60bqNhorNxr2TiJCTIZGLQ1heCrydkO7GAL+p9k41LVPa2JkFKWqFpis5HPyEAa
         6PrKUKbouCh272M8pB52q5wOQ8UkdLzSiJqXABt4e6OibQirr7RJBVWvaVFQht96k4mW
         /7YAqe3VDN1YkM3vp+ZsM5mBe/7I7k3+DqHV7up+z7nO4/GbV9LiJCym9By4D5CERSew
         vUmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fz2n0DugFf8ROS7QtPeGop96kX85dqVfM7wC5GvFOOg=;
        fh=mKKDE1BltftIrVGBfZkLs5NTy7eSiPHLeuQL/NjyPzM=;
        b=Usr3hGbBPzekZfpBGokHsId+f34lvQdjgqBLT0PMa6yA3ciHSiRXgLq5CwD5LFf/Ei
         HILenDx2Sd18bmvXXJXVwq6Ei9m5gCjWAN5TDs4CDs192lOTvx0pOyU/hkGfFEmb+Qlg
         UGuCZgDsHEwZTfCgFbojoLpZc5O6AlpLInPHOmFkEHkubTN9xfaCy32rhc3bi6VMleBu
         z0+UYlVZx33iAmXd6o04mLkSRqGx/q41KSJQz3G4QHWHap9HlRybwiv55t91WY0KaXXU
         Cm1snuUkYZUdjEbnKQnY4Z1GSK/YCqjxAl1KQDue+EQ+T4u+G21RJv8hVxqmH4MgJLP0
         d0nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769447220; x=1770052020; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fz2n0DugFf8ROS7QtPeGop96kX85dqVfM7wC5GvFOOg=;
        b=C4iDZaZdVvJEZuUNYigpYjDiM5nYorXbg85/n8ibsiHTFfV/A0ejxuk7B+SZvXhHTs
         oPZgApX8byIGr6YoVdPf50RV8cnkyIV0tEai1q9NnFaQ1p/kC7En1SXBcoYu8IunHZ3S
         f7CvBcvGl3b/iefS9tQ+45o9j0M8jvJBgYKwrhfkN0i85DnNhPGAtgwfKxRw78085B4C
         MToDQ9g9wKhdi/6suCIIQq/ThHxJhGUPNcDBKu7w3Alrr8PSov0GtpvRUbTKZNFmC3dk
         l7nRWzpQyfL52qAr6SRGZtnZb4EcLqkw7FahhEi1Z3E8jZhLFGsPnZAYj3Cci7oCVXpK
         JCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769447220; x=1770052020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fz2n0DugFf8ROS7QtPeGop96kX85dqVfM7wC5GvFOOg=;
        b=E2jWmK67qH+146KL03KM7EE6e7ovYIsI2IbB0ROrHHeCcbQKVn1WreoWT2Q0PZHHs0
         A77Cv8hhOI6HaaUl3QBDTyryC8QTFDPhRfA2Eh6PN9UGcyen5bSs1Z0T0UrR+wgSF+yl
         PWuRxoRC28OK/waxlNRkqDkYmwqFV9YJseWhdTz0RDFMmvk3dbvPqdQrbGZXZfOlaxAw
         EeciT7znIBOda91wWYyXlnI5BSImazGSffReZuFRb6xVc74+hO07x3B+5HpoM8IRcZmR
         aeh7uytZtqOdZeu4PJqTpFdDz9AeMrIFyJS1bTvpVFaJvdEHSjLneuO5U82v+uFIs5Il
         sHhA==
X-Gm-Message-State: AOJu0Yys9Ym5+q3Kipn61Jg1TP/85S097VSnwSYWgZNr++LynAqRfYdL
	pz5+nyxRtuWK7JPGwh4fbhiJFb6y8UcXHKWlq5doOvZv6aBB5wnaz/Ui21iJ6QsRaPYOO0PRl92
	AunyIl6AA6eVhS6ZTBbBgo20JLP4/UV/2EcNibhlt6g==
X-Gm-Gg: AZuq6aIr+ZTb/NhQV+zSDXPxPRNc98JkzvuL6DUvlWMQvb4eWEsQzAljS5f0fEYT/IF
	BhvNkx88X8phVcub61MPjSJsxCJC8lZ0VuZWJNceGMDlQaOyO5BHpzrUW2P9V/InLYXSrJbdxy0
	tm1M9BPeOWeb2Nw048Dsibfmkd9VOLfqITMEFz11HAJP1jjoo8qvzcrbG8CXobiK+/1vUrUpssv
	NCnop2jfuzHdnPoHwCVAHbQkU9IJZLn2cJAwBQE5XI+RsTv7oyhB8vQG4xu0eYbYqSziw==
X-Received: by 2002:a17:907:96a5:b0:b86:feb2:543 with SMTP id
 a640c23a62f3a-b8d4f709bd2mr171329666b.8.1769447220059; Mon, 26 Jan 2026
 09:07:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126165618.596944-1-a3205153416@gmail.com>
In-Reply-To: <20260126165618.596944-1-a3205153416@gmail.com>
From: Tian Yuchen <a3205153416@gmail.com>
Date: Tue, 27 Jan 2026 01:06:46 +0800
X-Gm-Features: AZwV_QhdK975hhG0EZm9nfuj45K4hweFyhq1GDL0dzVmF4JtEcSDbuhVBF2MOBE
Message-ID: <CA+rU_o5pzpHvvo=PwMV1-JUUa37Qp=B+-X3QqeXh-VRdNdA9DA@mail.gmail.com>
Subject: Re: [PATCH V1][RFC] t/perf/p3400: speed up setup using fast-import
To: git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

I noticed that while the setup phase is much faster (as shown in the commit
message), the actual rebase performance test regressed slightly by about 3
seconds (from ~2s to ~5s). I don't quite understand what led to this outcome.

Additionally, I haven't delved deeply into the technical details of
`git fast-import`,
and I'm not entirely sure if my approach is reasonable and compliant with the
specifications.

I would greatly appreciate any guidance from those knowledgeable in these
area!

Regards,
Yuchen
