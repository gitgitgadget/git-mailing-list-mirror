Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641E52DD5F6
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785712794; cv=pass; b=HU5ocOqPp/BYtatqaE9jqf1UPcwBtG5l8u1fALXBJyaYUlweRCqBoXBSWJUbFiO47b97ZXl6Lcqd1ZhkCr0Ck8cddLBbiSjPep7kn7bEbYqIpStH6T2YXsk/ErWN7LmIGFM2rGVCKvNwhV9952k8UnnF8sF/47w9T8CnXNDewms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785712794; c=relaxed/simple;
	bh=e200azBGxuoz9y+vdALieTiH6se/VLbglXd89mSVlfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GO+VbLWRoDRaNqsPWhIPIPrOCAIjDIsB/NbANaZBnUh+EKl/QEYxHnBKe3n76FoThhitAYXFG+T0gosRkZ2VA8J2aAtDPhEqIxzjusA5NZVxheopoRDnVRY7C2oWn9Mpx+o6oMHstUeNtdOMh362sC5e+gHH8PvTJac8AvoWJVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=effectiveailabs.com; spf=pass smtp.mailfrom=effectiveailabs.com; dkim=pass (2048-bit key) header.d=effectiveailabs.com header.i=@effectiveailabs.com header.b=Dtp/5tY3; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=effectiveailabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=effectiveailabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=effectiveailabs.com header.i=@effectiveailabs.com header.b="Dtp/5tY3"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6681e7911b0so3628422d50.0
        for <git@vger.kernel.org>; Sun, 02 Aug 2026 16:19:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785712792; cv=none;
        d=google.com; s=arc-20260327;
        b=S0x0NyD32nrOET+36Jl337HnO3JQf0YHExL1wtPL7tKv+PW8gZIE4rJCut0vgLe13E
         nCR4aiInF+7UIbkTPsW6TxNR11JsA/d1uE9uE+FGz+7Lw/MNrsIT3yeHuue0b8mLMxFL
         T+KNx82iaSsyNolZ4QSuBrD0CrWIICxB9s6GUXgRjbeoPyIWjKXkeY1y2YboZTg6Onm+
         6+rgfsKHVSaMhAC8Kg+wXD64cSTUs5paeyn0EZEcNwmVnIF+cgUQX/U9wkz/mCXXOeb3
         alUB1uo1s9Ii/IDXn665OoLNGzKXgedKictMpHB7NJyjfQ549cZLrQxxr06vcBkRftoD
         C7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kcicJ/AH5FTvyCCgO+dNpI4WLn0ZGz7DYqMO8xem5Rg=;
        fh=y3d5jStpK+HmzyKcb3ZDzLIQc7exl04L205RvXtLNv8=;
        b=UwMzIXqfmhMs6MkvPdTS4IOL1eAE828mh9yy41Gr4OBRigzf/p8WtpopyRKu9hHv6d
         BknVrq1vyeCrsJgOWgdMQBu7b37T0hivgUYETBlyXDSQU1/p5+I7YV1m+G7BHlyXFHLZ
         /i7bZrMoD9vLoZoOReOWl85gkmpYt9S32q2ysWLcbvvAD7H2+tmZ1/LOsRKb/0aqqTv/
         BVjBEarO/F++alBJ87Y3bjpjuBIaPa4m2PYbMRpE8jfk2Jvhp/34/9zA1TDaXYcJz578
         Y7GzVfEWmIJ3zfHFlhkyp9RrEM8UUWqa5wDXeRnIdwUPAzUHDjOl38v4ywD2rS+oFeLb
         8vaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=effectiveailabs.com; s=google; t=1785712792; x=1786317592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kcicJ/AH5FTvyCCgO+dNpI4WLn0ZGz7DYqMO8xem5Rg=;
        b=Dtp/5tY3/qIvr7csTTohyJ4BLlzAToO49ZanRJrZ5Nn7kz85am7Sd26XzZKIOhkSAL
         He/J1xui04GKI53SNlibRQjClEKZbkXlcuLCeMRGLr240iry+bhe9JYulnyuCWzcPyOC
         aXu0WCTl9eNditaiAl+CeJ2+LMw/yo39gzavZKRWIS2mHRjMWEmoPDSpPpiNAxRvfqDq
         PRURxGxFCgTFFKaQRFYELMPURz/HpRZbprdeyj4Sn4Bgp/ZN2gtdW1mJhwW0ipsp7oq5
         Jht5q+JOhrq2iBmOWk8j8AyxCyxWAIuhg8FIAKWm5NlBXjmrHrXDGIXCdDPP8NsWKP7a
         +QLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785712792; x=1786317592;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kcicJ/AH5FTvyCCgO+dNpI4WLn0ZGz7DYqMO8xem5Rg=;
        b=grhwQlWNUE5DjCZs5o5dteePbRfZnPIaT8E0fBH4tehZ6rdkBYdZP2UbijENCqD4Qp
         +aUgEnnSMJ6Txe+1ZOya2jtREOfN5la/zk9L9atzPe4eDNzuFK3UAPI2SJ+16VQVl+fX
         V/SIC6Mv2OK5KtAO8PMJkM5xEL9XMVYqmBwBg2MAnwV10ppyrQ0fUujvvDF5z46cSBnu
         9kPiJw29diLg1GaRUjXLoboUn14GvCxv3ODzmBXXfZ0cy1/os1Cgkry53LnnTe64KV+y
         y0doghCp8AKd8bpScInSGWEx3E9BDCNwrfTUGf0wR1HPnnTodccoD3YiSuNpN9ctDr5q
         DZNQ==
X-Forwarded-Encrypted: i=1; AHgh+RrwuQCJtOiu0FCvI+Y24CGAJWnpFux5sZoM6bNr0Q5GZ2UiDxnbKOL78G0RspVF5lSUlZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIKDhUNZMHCPSUHnbJlBVdi2NKnRSzbuJ3iGEEKAb6SyoF9zHu
	7kRyNVDQdUe0NiNmpUDidn7FxobxFKT4Z2xx/nnfZlis586PXdydSleDG6r0OuznjCiVhEMrVw3
	4NJI+8D+c0zwC0kYFpj6EQ+arX0ceeCKs/vg+gJ4dzrY=
X-Gm-Gg: AR+sD13s2AB4svEwoarGoY8lKiXcK1xeH/JOG27MVhbvluwQqdd2IYdZGMohOXKAifm
	5ooFIQLKLcqQBVuF4c7cPwqkSnpdUIwnnEwGZOe91sHbjhu2VZZlrtg+jYRw0Lh7smmrEqWjT5z
	vLakkOruJEWvsEWRJXelz+xcwcGrYZMZ4WnNwaxq2ebkVpE0M8qmGCxRIJlw4bWSb3UyfdJ8byz
	ozl1Up7eImMpnt5NfTG/xE2hZ1RGnvb/Rf7Fg6NMKZaJ/MiEkylsVzQIiBHCuNv8UFZyx9OfpO7
	NAhF4PRMKaaVyUp09KQERmoTO77sRcoA7dEbgWZAmk2kDqlQ4y+NlmbVrJKCNmfq12UVZ+HvEB4
	Wi5glrgbjVOvylhnt0C4z7SGYJN2raCeyWvzSOktHrZ85GKwZSfetiyhKpPU55RbIXAfVuSyHqq
	gwnePv1N3tt3UlTIU=
X-Received: by 2002:a05:690e:118e:b0:668:161f:c7a4 with SMTP id
 956f58d0204a3-6694f0c012amr9991015d50.23.1785712791909; Sun, 02 Aug 2026
 16:19:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2191.git.1785706396130.gitgitgadget@gmail.com>
 <am-7_wSb-GNefKlB@fruit.crustytoothpaste.net> <CAFwoC-7wUzce_XvuviXZe=5eTxJ5yyCpz=vsOheWKPCnz9Kr4A@mail.gmail.com>
 <am_Fb79hCnwmRzjL@fruit.crustytoothpaste.net> <xmqq7bm82l05.fsf@gitster.g>
In-Reply-To: <xmqq7bm82l05.fsf@gitster.g>
From: Arijit Banerjee <arijit@effectiveailabs.com>
Date: Sun, 2 Aug 2026 16:19:41 -0700
X-Gm-Features: AUfX_mwrgZoQb9pR-7OGG2eUMvgMxlDv8ofTaRTaSfqE_OEfoBX41KMJZWcC6v8
Message-ID: <CAFwoC-6eJNX4H7AeOcTdSbFRqkoqAOb2Js9Qj+93kHJWG7OkUQ@mail.gmail.com>
Subject: Re: [PATCH] index-pack: speed up promisor link recording
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Arijit Banerjee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Jonathan Tan <jonathantanmy@fastmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Arijit Banerjee <arijit91@gmail.com>, ttaylorr@openai.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Two suggestions:
- Maybe a karma system?
- A special release train that is more indulgent towards AI generated
code? Brave users can try out features and they get baked into stable
releases after enough soak time

Definitely not trying to be extractive, this one appears to be a
decent size perf improvement!

Still holding on to a SHA1-DC hardware acceleration change, that one
would admittedly be much harder to review ;)


On Sun, Aug 2, 2026 at 3:52=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > I understand that the SubmittingPatches documentation is a bit long, bu=
t
> > I do suggest giving it at least a glance so you know what to expect.  I
> > think reading this sort of contributing documentation is more important
> > than ever since, in the era of LLMs, projects tend to have strong
> > opinions on what is and is not acceptable, not only just in terms of LL=
M
> > usage, but in how code and documentation are to be written and
> > formatted.
>
> Amen.
>
> Since we seem to be drawn into the AI policy discussion, are there
> things that we should consider borrowing from policies battle-tested
> by other projects?  I kind of like what LLVM has as "extractive
> contributions are rejected (whether it is AI or not AI)", as we are
> severely review-bandwidth limited these days.
>
