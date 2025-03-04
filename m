Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84211FC7FF
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 18:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112936; cv=none; b=HYh6j+WRWiuHJGIYfiBsndMhFYu768SulLJejzE+lcAzYqEVsQRkpwpetPCov1sMyUeIJkSME7rA+57EDC4ek/PUuhydtTV84TyYMekA20UAHpYF7YGf9/qQWPEjcvnfJlJyKze+IQvRvRk9BaEFeL8xTHj3W95lTxjBBZIgJfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112936; c=relaxed/simple;
	bh=YFVgx8bH4QhL0BFZhQWisYtd/MzDA4rcesRGXFc4Dao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inmjjjGUUKkQlD1g15ZuAa3kMKKPgBMLymwDN7zfC1iIJnutpAfZhfFnxjSQ/uE6+jkZ00eSJBCZKSXl/2hSW4ifINyk+muRmILUwAwToYwFLR+OrTBxb6RMM3Ialh3Ufjs4lbXmB4uU7Yg71LzFtrAynGFp53XZXWxz/VXNcno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e894ceca36so6791456d6.2
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 10:28:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741112933; x=1741717733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cdNsDirIbebcoh2AtRhXi3ASWpfIe0OEW5wAEfSP4w=;
        b=lphag0zgzswnBoYBoHjmDq9n5k1r2fpEHwRdvDO1eHafIWkMZvY0c/INZ/m7wgzz22
         1+XLxOZf/qbDgKv3Vg/SY8RIQK0VPivWlUv3Qhmn3YlLe8sl/yPIlJYOkdNnTdRtq/a1
         Lv3D1pHYYwIYKJNu441ZZhOJfZhhLb0HJ838Lf5u2AW2XfDsggLld6cWOSWFrBjXKnqS
         oFkokrDl0km3/wv02cqhuPxIF7lPiYyLcPdwI9pQ9ObT9jEbpS9P66vFfS8FI4X9cgcB
         EAQJkMPsUB+4Ac2Fz63yrLtWb+A0T/Wz/ShM5yAwgR10VyKg6x0xU8eWkaDXWPSzJ4XS
         8wWg==
X-Forwarded-Encrypted: i=1; AJvYcCWXr29ognl9cTLtErr5fCBeyZ7bZkFwacxlLc/1X9FmNMY4Cwe76QIqbwq4QQ29PfK944M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyih+Ae82U+Tk7MHaOug6Y6hsxJ2QjQAkLFXuei3q6rEbtJzn1A
	qwGJqykJK07rAlwC3/Fxj1Utrhc7Qcj5HY684M0G7mEWf6WvhKbky7Kfw/F6+7NAYc/DPMlsmiz
	Aav18C2DXdXR/fpVGSycwVFGYFeo=
X-Gm-Gg: ASbGncsGajdeaSk7DIJx5xuyfb98oXbz1PAiHc7KivLBtzeOll/PRrBYc52hmUA/25Q
	bvJGvit8wn24nT86dnraqf5GBRs6w3CPXsyIhAj7KUgGmK9H9SdjS3SfTmjfK1BPz8T1BDhk5Ye
	WrKbVafwTY7Q4P5SE1QiAg8MTxJp7Cp817R8uEFVlXWmxD8+eV8R9plAYjN1s=
X-Google-Smtp-Source: AGHT+IG+PFoLnXT3nUSPJ4hMiLQs37K/l+sCUpDW7aeIxWkp+OZufH+3y0GUdOUpjGSLWwac0w4laFI12jW71CMP+7A=
X-Received: by 2002:ad4:5bc4:0:b0:6e8:9c91:227a with SMTP id
 6a1803df08f44-6e8e6c8cbf8mr1893116d6.0.1741112933396; Tue, 04 Mar 2025
 10:28:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301105838.1481-1-danimahendra0904@gmail.com>
 <20250301105838.1481-2-danimahendra0904@gmail.com> <Z8WD2MeHpOH7Ni8A@pks.im>
 <CABGrwBB1-UiiPEOptN9csVP1WYg2X=SWeMxxiyDfz02VmDp1vA@mail.gmail.com>
 <xmqqldtlt304.fsf@gitster.g> <CAPig+cQ275qBWzaYmMXydiA_8+CTx3FhAAY+o8ro+hD03wzu0g@mail.gmail.com>
 <xmqqcyewr8j7.fsf@gitster.g> <CAPig+cS3QZhZ=W2WfM3T3EngaMOSV37KH4Pqp78QHzOAODtenA@mail.gmail.com>
In-Reply-To: <CAPig+cS3QZhZ=W2WfM3T3EngaMOSV37KH4Pqp78QHzOAODtenA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 4 Mar 2025 13:28:42 -0500
X-Gm-Features: AQ5f1Jp2eF4dDS4bmt3_9RpkzOl6wGfLGCEquZKr29-9-bwjle5voNJNXYl6YY0
Message-ID: <CAPig+cTUMj-QviOuXtdAN8Ao=gbfhXK=J6oEXfdjn1cAocZ3RA@mail.gmail.com>
Subject: Re: [PATCH 1/1] t1403: prefer test_path_exists helper function
To: Junio C Hamano <gitster@pobox.com>
Cc: Mahendra Dani <danimahendra0904@gmail.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 1:07=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
> > >> >> >       remove_object() {
> > >> >> >               file=3D$(sha1_file "$*") &&
> > >> >> > -             test -e "$file" &&
> > >> >> > +             test_path_exists "$file" &&
> > >> >> >               rm -f "$file"
> > >> >> >       } &&
>
> However, it's still not clear to me why this function is making the
> `test -e "$file"` assertion in the first place or why the enclosing
> test should care, especially since that assertion is only checking
> that `git commit` worked correctly, but that's not the intent of this
> particular test[1]. So, `test -e "$file"` seems pointless or at least
> misleading.

Perhaps, I'm falling into the trap of assuming that a lone `git
commit` in a new repository will unconditionally create a loose
object, and that that will always be the case? If, down the road, `git
commit` no longer works that way, then the assumption about the loose
object becomes invalid, in which case I can see how the `test -e
"$file"` assertion is protecting the test against that future.
