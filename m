Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02E852759D
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 13:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984922; cv=pass; b=rZIWovjJsnTmltngKHn5DYJXjAT34uBmIeJ5aBIyfOoU787QnpvokbhEVIgmSl9hnulhtY2gQGTBEVAbTWljItoVec6uQozTEhJULk8SKR1RnW61lccwBazQfulSDOYAc6cIVa8iRCxCrRqYgNhXHspxXE+6l518WS9AFX5+jCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984922; c=relaxed/simple;
	bh=P6lAbYCDCMOVAtO6cGswod+AavK9A9knQY1myXdO8q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqBQGo2krq4ESU4tJssy6e6Z9qQxeWuBys+6V6VyGRJBsdP3wlY5UD/FdKBq3RzB/3f+KNiQTkgeu6tFchGnw/19s8i1VjnYzIus8rgclrpO+XAeqe75eUTB4his0qx22vSOlgSBipWfHayeu2FaGXnm9IiTYqtusswGoCwU8wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1UDqW0F; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1UDqW0F"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8ad549a2119so29989137b3.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 06:35:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791984915; cv=none;
        d=google.com; s=arc-20260327;
        b=TTV7N66vjjd6DIk34EfWWyDFK5+QAFV5nxtgUV4FzHIL98kY/fFdBeIF8gVirsreix
         Uk2yPJS5TGbM2J4F0LilQV5t6LRs9HIcsHK/E8WpA9LADIhUtPnM1nubVPPjETK+KMdL
         DtLZf/S6LNXlFeP/sTLFkwjCXxTJY37L+0GHxvS/7n4Z1bYSlCakttZhiu3wrxbe4bnb
         XE+CKMR5tySawMQ6xIvv7bLA+pkdKUlSxnVZ+2OIdmoy9YQF2X2e2IO8iV8raofeWMKL
         98P/CGAZKZBgWsVFJaqtyqO7djNLH2lN8qZLh3d/XcWkXXfNJFoDD8IzegboxEBdTUao
         WUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P6lAbYCDCMOVAtO6cGswod+AavK9A9knQY1myXdO8q8=;
        fh=GmKTMWABzlxAbd0/XaVHd8A5XxjcNba3tHmY2F+YyIk=;
        b=SM64fMb7arFN318CXMBNi3+TS4hohsfdj+Tr3AU/zKWLhaVi1M9cPWM0tlRhr/JPYA
         ELIZYrKkyAZ4LW9TjGoC23sJ4QxX+l5Sza5qNXrOoNyydhlNfz5epRGVmF5JCaDcU6ck
         5D9sxvhe98fzgPGfC1yes5EObVzVzTfEl1tKrx6h7hwiRTF4KqMyuFSY/dH3OsN9QjDl
         aOrNW/inJLwX8ZvyliC37MypO1oea/8f/ZzA2QoZS9usZKfRh8+bHDnTfFlWtctwGG00
         il6A7C7VaRfb17kS1HUkOstVjjtAFfw/mQ967KRqy0OQgXvW2Sraw5NkXFUrP9C4mf13
         0/SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791984915; x=1792589715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P6lAbYCDCMOVAtO6cGswod+AavK9A9knQY1myXdO8q8=;
        b=U1UDqW0F6dgNn2IUG4fro83RrjLPJfZtKEHlZqlZqrBPqVuOBhTypzq0hx8KhzJM3R
         tGzqRDo0h+Q0CNdL117QdU5GXSa0UqLup2y+24ZEMhbiNtsBigYTdGPV3ho7bjGTe8m1
         UpgxINpN80tfBDIzaAv1BJYjsBe6po8HdLaKI83w8HKjyOs66Xtx/2U5si7DoudzCExd
         QjyVbJW/PczhM0XA+kxrUhW/oZqAPu6ZTQntBzMg5Arf/9t3cT0StxttPc3d9ueDVLvG
         M1m23JKliai2q1M5Iu9yjYClOdx/NaS0AMd/DKb0odwipCaVnVn5BqyhanDg2lWuHjaJ
         aRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791984915; x=1792589715;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P6lAbYCDCMOVAtO6cGswod+AavK9A9knQY1myXdO8q8=;
        b=ximminnm6ZCDk7LAewPDiZa6yg/BvI+Kyf39UeqCieSfwYQGGwjrofD1Iu8USEuDvu
         F2REtfrz6lQpeV7unDaqYCmy4/lDTDMe99YLmV7EAYDa3f9ubgP6xecv//RgDccKe3Wa
         vrndYXYGsqzd7LtZgEX20iWz1IqeA6TSjFJKxv9SW9TcGHtQIz32DSS1BZ+36ZNyF1Fz
         3O7uz3nw4+ZCR0bvEdctI7fSaHkpn9Q92MsPoce7XSZicGZxLD8+XLxzKK83kcLWDqwd
         jEfL+PU+Q/5Zl1/WVU6c2LR1720KBInVVsrH0EpdQDMY1mT0p15fGaLK3FjuIshcScl0
         J/tQ==
X-Gm-Message-State: AFq9FYJRrABZf47TNYYQOPDp8bDKRCDiBoT/Ium40rehLVP0mHG1bdue
	f4cBzIVLU9hChc4ZFBgVZgU6J461lNSWUNZJQuh5S2KZsmvnPF0dyfPTyB1V82pezR2pYd4YeoQ
	2kpl1OQ3mC9ljuj9uPCWhQdNsFjnkLuhxhQL78hmqXEJH4es=
X-Gm-Gg: AYBFou28n/SXco3L03t/8qqmRDD4FKcFaBqGE6tqMI0+uKLDyrGef6hakP6CK4ohzhE
	pQ3OqZ+aWgsfB2aYXLj1yrK8XyYdT4CE0E0GmrhV7G/658Y5dsEe0F1wSVrelFVVF8rnOcSjv1B
	Y8yogqCoaZvpUfDqioZ6FQg//j48xv0dX1IVNqDlhAu95xTPm5scY8ZvS7HDOn62pG4e6ckyW7z
	h2UZ6xhPgGBf++zXC6LOMLt3iLo2VR2APCoBFW/YFzWZiroIQ7fWAaoSmolnoVsjluJ5ykyyD8k
	+3RwbFLSK/dZilOa/BNxTMMa4dnm1g6rR1Dljf9VjPEdlF4RszAhhn5uLoCcpUBUXF7W306pCPZ
	8Os+F6aGXZbB1MQOoLDBJmbgAtReTjYy+qJTjg2gc2aNRgDv11UWpEUzkZo4I3IMq83KPto9zCM
	CBVu7CHoNoPpUmEs0tcuNchemA+dQn6z4YKRudztZhLk9kh9Qw93ci
X-Received: by 2002:a05:690c:a750:b0:8ae:87e7:9ab0 with SMTP id
 00721157ae682-8b07ee062b1mr36592327b3.60.1791984914833; Wed, 14 Oct 2026
 06:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+ew3JuatNJ_bQkormLgm2O1DVQ4ZBTXnXnJPjOMcfcKZZ+Ang@mail.gmail.com>
In-Reply-To: <CA+ew3JuatNJ_bQkormLgm2O1DVQ4ZBTXnXnJPjOMcfcKZZ+Ang@mail.gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Wed, 14 Oct 2026 14:35:01 +0100
X-Gm-Features: AclHuK-4m3Fj0RgaVJRBvOTDsgzeVykxjZ9BzIZ_Qm3p6279R26eAmZW9nzurLk
Message-ID: <CAFpMFfAanhfXo62tF_jm15CWo5Pdi8-B_vEZi5NXztb8uppPKQ@mail.gmail.com>
Subject: Re: : Interested in "Implementing promisor remote fetch ordering" as
 Outreachy Internship
To: Wasswa Edson <edsonwasswa54@gmail.com>
Cc: git@vger.kernel.org, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 1:26=E2=80=AFPM Wasswa Edson <edsonwasswa54@gmail.c=
om> wrote:
> I will be glad if I am added or invited to the communication channel
> for introduction and Open questions.


Hi Edson,
Welcome to the Git community! You are already in the communication channel
You can pick a micro project and get started.

Okhuomon
