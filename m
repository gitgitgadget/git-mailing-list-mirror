Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4771134BA45
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 00:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760402489; cv=none; b=X7s4l/wKTkGvThAj2q1QM1x7QUer97w8YyN+JuGWVSfvnxy6mE7l8iWbbPCMFOfIIGRPfnc6kh0tVRiDAOZH+1TAWqtoIgso2d1/jletrY6A7Vo1h2OhkywWQ2BQoCQr2GNOk0mTojMF+loMAhAbMNebV8GlPbtEUD193yXfUpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760402489; c=relaxed/simple;
	bh=RIHJeZdwenJ8LDldki18oaO6GB37ZANTPLP+acqS+b8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTMuFJHtl4vF+0W9Zba6LVma8h3CjA/PbaCEtgHCk7u+GBeWAtEt+actuXMvluCARFEeJKe8b1c5yXFzyF6t5CLrqDobyUD/ZOlJeVFuuRofufq/BO54Q851UpUIxKM/ZdEKf74eKarTXyBnaiEW0i3OJtYPSmoo0KCInPWBZFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaFKG8tL; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaFKG8tL"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-854585036e8so664270085a.1
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 17:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760402487; x=1761007287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIHJeZdwenJ8LDldki18oaO6GB37ZANTPLP+acqS+b8=;
        b=DaFKG8tLDilr9H7A7bvehAx44XbOCk+C6pRHrLr6gSF9sfWdnVehvRnsjdChXSjRTR
         3ZtYB6qrrUgYIZOXf98g6YUYWbnhjA3FOs0g9zopn2zzjaBmE1PLZTkmdnos2tHw2mNl
         LI6lsJKR2Zns4rz0JUpuRH2T6mDfpJA/KRrxHX6YhLcod4SfPlZeEqJOtwG3OLcGNLDO
         THO0bDoZohzo1j1ZnjVn9F2xWqZine43yle3KvryC7OOIDwE8EdnwK0Xqb4fcqdRDnMj
         Psko/ST8wxpmMUUi00eO00eNw/ZvO653kr1DBI2UQ68sx9dXveF8bxERJEjk6Qucx/5T
         ms8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760402487; x=1761007287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIHJeZdwenJ8LDldki18oaO6GB37ZANTPLP+acqS+b8=;
        b=BOvIZnE/KrGVVZmE8YD00BLEJfJYgon9RQVRuyrhRsCxAi+9rvb15qShVkbhVNvIiC
         TpAp9PkFL9xD0XBQGLzhVeIxpI9zsCOo1A549hMEgvi3WZOjPVO4jOfFG2NGZDzegv50
         Ddt1tutzqqRu9xzQwfRRAOBBwYxBlct45WKsgka+2hlNkwahH4TJuyiEA9Ny84UQxksV
         jRoyqMLW1R6tzTvp1ZHwYYTANDaqJ6yAfYWdiP8hvwYGd6yLY1NBudZC8IEdHsjYspZk
         FMnUeF6PDG5qWRFUOkNQvWLt2TQ+XmXKB4Tm6WRKbUBMULeMSbWj2Feh/lW65WMtAXAW
         mF5A==
X-Gm-Message-State: AOJu0Yx8gbK26pIdkuWX8AU1sxgFk8aanrO3wz7IhR706Z9MniXhz+yo
	FD0Dna07Oq0sDdfp2em0czQlLCOF4PfTGvEIKqheWyurnED1SWf7+sLtkQvUfz337KV/AHLSpeR
	YQRSlPv89H5CNAS4oj36RBts4zEhhXzk=
X-Gm-Gg: ASbGncsFGJWj51SkgMVdcQu1jPdAyg7OIy1qMFNvcRtHoU1+k7UHoxy0v96Jd/HShoX
	Cyd4dNZblKmsCVDP89Z/Boh6TjlxQEuikEewJJ5jIioe1lfA5EoOFvQFfefoOICAuKZtMBm6pJ/
	LymeoRfqP0LhNbCoDtXafyQBaoJGOy8YCfP2pp1U5wLu66IN9HhAtMPT4+d8K6DWNLPZEBXrE9N
	VXWnB1Afvd4DXD0MUxtLhm9aid0tRA+NjttW9UBoUsF9x7qGg8vrkk9waQ0h2Q=
X-Google-Smtp-Source: AGHT+IFGyOM2zxVyYcYsT72zbqcifAa/X+Jl2j278SJza/oeuKYcxbRKong0rAWRFkDlBXtIZqslLD38GYREDRg3TH4=
X-Received: by 2002:ac8:5d08:0:b0:4e7:2dac:a7b1 with SMTP id
 d75a77b69052e-4e72dacab0cmr47830151cf.61.1760402487140; Mon, 13 Oct 2025
 17:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011093611.62937-1-okhuomonajayi54@gmail.com> <20251014003508.GD1507@coredump.intra.peff.net>
In-Reply-To: <20251014003508.GD1507@coredump.intra.peff.net>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Tue, 14 Oct 2025 01:41:16 +0100
X-Gm-Features: AS18NWAU4uEqtIn9t5yxkA4e78aADqs-Vxu4kjQGZIytX1JUgvusKhxUeicfI6U
Message-ID: <CAFpMFfCKimM9zWODGgEnA962C+i4nCBL41JcRcX48yqwY+jtcQ@mail.gmail.com>
Subject: Re: [PATCH v2] [Outreachy] commit.c: clarify comment describing
 commit re-parse behavior
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks a lot for the feedback, Christian and Jeff!
I=E2=80=99ll reword the commit message to use the imperative mood and add a
short changelog with a link to the previous versions below the =E2=80=98---=
=E2=80=99
line.

On Tue, Oct 14, 2025 at 1:35=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Sat, Oct 11, 2025 at 10:36:11AM +0100, Okhuomon Ajayi wrote:
>
> > The existing comment in `parse_commit_buffer()` mentioned a "leftover
> > from an earlier failed parse", which could be confusing to new readers.
> > It implied an error state rather than the intended cleanup before
> > re-parsing a commit.
> >
> > Clarifying the comment makes it explicit that we reset the parent list
> > to ensure a clean state before re-parsing, which improves readability
> > and avoids misunderstanding during future maintenance.
>
> As the original author of this comment, I think what you've written
> retains the intent but is easier to understand. So looks good to me.
>
> -Peff
