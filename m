Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD931771E
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756290608; cv=none; b=WPoVKVOMoMZw+X8gPfn61RIKHbZ82Z8MgJbPWBD1yAakVrWEqDk4lf/M/m6aj6KEFGMGecG9HO7tS/SLzRKEzJrcOGPdarucxpAnCVsdfqO7HKO06rqahpj+d3hGvIW+MyNrvG6Wn6uapgxyeFfqy1dFnpawIUV7HIJl43CaPPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756290608; c=relaxed/simple;
	bh=0LwDn6QdAmmzQvuifWOZgAOzkTZY9ng+FDJylqyuS1o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GrCmkMGLt0L00epbEJqOoZz4KrHTA6NT3H6LvpO51inp9JVHRkJC/RL3CEW2GY7kH1/fJBk4yl49ss9enHGiIiVkUskciW9ajhpHNdPuY0yyT/urzpvdmw4RQuH0HOV306KM1CZicvdpMecW1dXuX13HYOVcKiV1oe1BI9H1Wnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=abtion.com; spf=pass smtp.mailfrom=abtion.com; dkim=pass (2048-bit key) header.d=abtion.com header.i=@abtion.com header.b=l7A3ZSHf; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=abtion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abtion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=abtion.com header.i=@abtion.com header.b="l7A3ZSHf"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61c1a0cd60aso7219085a12.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 03:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=abtion.com; s=google; t=1756290605; x=1756895405; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0LwDn6QdAmmzQvuifWOZgAOzkTZY9ng+FDJylqyuS1o=;
        b=l7A3ZSHfob96M1DBT7hJk9m9E8uqFuVziQr//6iALadRrM4rs8Axrj07YoLXLNZ7BL
         pbM0hqgscaIcYWjhSqADAD0JSYe2pQjCibSi5ldHnSJKoLWZVdDu2WkhDxhYvEl2pZqP
         8+hC2DSreRmnga9/U5iTF6hosjskFQiJa3QEDjBIuoZfEpulI5mme/gvY6V/vKKpdLVF
         siqa8qGkQ3bs+8J6MIlkb4YWZ7+fIQSmaW4JPhSXsiKi2hgj23Z/X7Rsw3icmBPi6mD1
         BhOi2wkPsNQw+cOC8bVk3xyM7L03nC7CsTb1pwg7yo8aKAb3v6CfdcR6xhUJQeCQsgpe
         SJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756290605; x=1756895405;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0LwDn6QdAmmzQvuifWOZgAOzkTZY9ng+FDJylqyuS1o=;
        b=FmhGYpMrLUMwHkGUXBPP8HLecFxv1YE83OZatTSvpfzrO1mg+j7mQCStBtS14J0zZB
         9fwGlYsLbYGsJc1v/AGqEK3qGYo/4A0/oWWcucRWXxAu1Yyf6ZUu85NyrlZf2O8CkFPX
         t6VxyJhe9eGggAatKmmc2MBS0ynYtGgAxoMdPbn0UXeIEpAoRr+bn1XPSs6EZKCfdoNS
         XL1M8G7mVn3yEhX1F1uipIVrq0Pq0Cy9oiiP3D/NK8YxeSnpDKRzzcUqRYKO/KUXSeyb
         7dU1TnVk9+Y//rMnI8W4UcTuKFgvtA4+5pmiT6+GET7PtHMNpI1/68Nd7I7aET8GkWHl
         n4fQ==
X-Gm-Message-State: AOJu0YxBAsNdxf+Sl6HnODPJNi78nhdifViP+xb9yLiD30CSX/hr5lAR
	d1CO+V/YLHJYMBTHDXo9lxJgOlBvg1OWjX5elVW9S5O7rLFazyR0ZhT80JKltLvFLRfsKPdrvdz
	JuYRbYp0thXdrJSilNBgVXSXClxiiO03h+IMO0d2CAYMV3BI0qSBj/oDyBk3QFsbNoBjVxOOmjg
	WZB6kAVnVQaivoQlcA0qddEFP3IsGe4KKX
X-Gm-Gg: ASbGncsftDQUUELyIuaPKbY72lAkhAKkTT9LXo0iHmKTdwh1TX/UaRG4FMOsjBae2Ft
	gVrkAievj7BSoIwrA8pNVpvySXaOT/Ge1rMgtlDA5sotU6JdjGGD/zmfTWqltSFUCfTfygucIgV
	J1sRwG4Ggw5Rfv+F6LRdeWr1byVY7W4PM+Wv+tRTfeGOXxUU2nCANjCqiHZ2XR8xSoTbOTlG0Hx
	VxZ
X-Google-Smtp-Source: AGHT+IFIiF0YjAtMhmZCiDayEdILL0SpUn0ewDkwZmSVlEFln7VgkkAyi9L8V59/K21QI0Yyrbe2SzR8nTIpq/hRKRA=
X-Received: by 2002:a05:6402:50c8:b0:61c:bfa8:57f with SMTP id
 4fb4d7f45d1cf-61cbfa8067fmr142465a12.19.1756290604826; Wed, 27 Aug 2025
 03:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rune Philosof <rp@abtion.com>
Date: Wed, 27 Aug 2025 12:29:54 +0200
X-Gm-Features: Ac12FXxBEXZGHNdPqPQsegoebsUtvU9Yl3DJCmKYcKX9QknCHwNXJyMUExe8Pyo
Message-ID: <CAL8J5gbKu7qB8Byg82CGqtrYK0gm4gf5V=qrc7npzAoF+kAXJA@mail.gmail.com>
Subject: Feature Request: Add comments to commits
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Git commit messages quality is very important when you investigate your his=
tory.
Often it would be useful to be able to attach comments to commits
messages for instance to add forgotten information.
Those comments should be shown when `git show`ing a commit.
Could be implemented as commits that use a new field to link to the
commit they should be shown with, along with some index to make it
performant.

Services like Github that already have comments on commits and PRs,
could integrate with this to make comments made on the platform part
of git.

--=20
Med venlig hilsen / Best regards

Rune Philosof
Software developer

+45 28 45 64 08
rp@abtion.com


Vesterbrogade 15, 3
1620 K=C3=B8benhavn V

Sverigesgade 18
5000 Odense C

https://abtion.com

--=20








Vesterbrogade 40 - 2th

1620 K=C3=B8benhavn V



Sverigesgade 18

5000=20
Odense




abtion.com <http://abtion.com/>
