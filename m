Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2410826AEC
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 03:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728444917; cv=none; b=XwQI4xI7iaByY3f0m+6+lzX3YEkoq79UOLAKqSYXMx8YzSG8R2AMlT5BUTQtypcy0JTuYz215yyiS7CF5gZUaDFVDbSQVewnQWNgFN3/KI2F5SisqsR1JXiRICdjEZRa55+W6RG/PnkRkJMr9xAl9Dwkg6x8D2++3VZiky8glEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728444917; c=relaxed/simple;
	bh=Bg+vYBg4pIp5RuPBvNMRBlC680sF1dCdAzzUFAsEcdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkvoBmBWk+p33C+fikqdvra+Rb1+v3UbPuITiuff9R1bTuy8x7ObzeHY67OsNwRddQRMSPlktzb/A2mTE5u4K2mRFfJeee67xCdlPsNUJojNGFEZ6JY5/L7SdK5UZYBOAC7p8AhIsqiC541Rnv1tqZaO5RLm0Zv2ztvReP13WUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbwVH31B; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbwVH31B"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cbc22e1c4so50922775e9.2
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 20:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728444914; x=1729049714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31QsAWYFV8mcedhCILB6nIeEcQK6Zr9sT/+X3Zgj9QM=;
        b=TbwVH31BVl7yWiO9i5k7jx7h2sJhPB4CGVXz1mNWcQx5xPqQMsr1F0V0brYJs76C1Y
         D5bgZzF3WjknO0yP9z7m+gQDs0Su2Elt64h0GTNnclJCn69QEdlmL7Zq07g4NMF0LO7q
         oP5yqEsTRpJEe0mQ/Noz+ZFF66pVVntSZo1PQznwAiXPQojGb6XEwuqb/4MVOC+4elTT
         XvWojmfGTiiR+2Zv8ZcH9v5H+0NYBYyTjgf7/ikQYuHWmfnTwLuUjuUv0+KBfjp6eT+n
         4+EOogC9BRv1z/3/qvntPbxVCZCNLN5GVbotm/mvBHfwDSF6a8LDM3zxc2auCeou8Ml7
         +VbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728444914; x=1729049714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31QsAWYFV8mcedhCILB6nIeEcQK6Zr9sT/+X3Zgj9QM=;
        b=av7rL/urzbfjc9xfB57FZMlUdBhxBs8UlQu/Ea0nPBcFMyIm0/WTAitg9XQDuh3Hyl
         Mutlc+RZnYJgL+amKbBIqCViLGFsueN6KBM3aaX1xA8Z0DDw8Tfm791iVWPeF/XW/G+j
         +oZ07pzgcC5FoMiPhxaJFJ+uISZkzXtgeJnyouOkhSnvbPSEmCI6WcBV625srJAiTktC
         NlpczOErYYLfIDhYBNlc5vEAEE2zU6xpOn1HMpYe17q8gviYpDLFqQ3jUtrHr50fMG/k
         KxnKQ1OdQ1f2zLYsEchNJCAYmkH7sodej5eOADeb2qi6KsS883quo2A+agVhv4zMMobi
         Hoyw==
X-Forwarded-Encrypted: i=1; AJvYcCWFWRZrcKeDUes+9oPc7sAQjk3sWytXJzRWAiu2cT+VLJseH/Bjmivn9CxsAv2eSiJGsjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZvsoS0zdsGI2YT5MHA3utNYuJGXV5/zPR2tL58pKGJZgUdfQT
	uOds/b0fDgk3LBJS1RuHJn2gYeTJmhqQfOyeWKRcBla5OGLerpeZuEOSJjd5bQ3rEDXwp6buQH8
	A/RFiIcTt3JEMaUnjkQgmquiwgHQ=
X-Google-Smtp-Source: AGHT+IHHEQ2I82w+fNsIgkZOrtDJlCZ/l9dVISaQLsElR+U/vk4Lm0NUDmFJhQyokwkbb1WnNjRGs/RRHkzD+s/9wdY=
X-Received: by 2002:a05:600c:468a:b0:42b:a7c7:5667 with SMTP id
 5b1f17b1804b1-430d729f2c0mr5515005e9.25.1728444914083; Tue, 08 Oct 2024
 20:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1811.git.1728328755490.gitgitgadget@gmail.com>
 <xmqq34l75pr7.fsf@gitster.g> <CADYq+fYZSGBTnO+dM+MtHj=oUMqDWt+6wu-wEzwfWQJkSomkWA@mail.gmail.com>
 <xmqqo73u1n0k.fsf@gitster.g>
In-Reply-To: <xmqqo73u1n0k.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Wed, 9 Oct 2024 04:35:04 +0100
Message-ID: <CADYq+fb9ux6K+m-8y0owopt_zKJmXXYLh6Rswot3r7UNX30LAQ@mail.gmail.com>
Subject: Re: [PATCH] t7300-clean.sh: use test_path_* helper functions
To: Junio C Hamano <gitster@pobox.com>
Cc: Samuel Adekunle Abraham via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	phillip.wood@dunelm.org.uk, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 7:13=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Samuel Abraham <abrahamadekunle50@gmail.com> writes:
>
> > ...
> >  This was the reason for replacing "test ! -[df]" with
> > "test_path_is_missing" where I think is appropriate.
>
> Telling that concisely in the proposed log message will help those
> who are reviewing the patch and those who are reading "git log -p"
> later, and that is what I would want to see after a review exchange
> like this.
>
> Thanks.
Hi, Junio
I want to express my gratitude to you and every member for your time,
 guidance and patience and to my Outreachy mentors Patrick and Phillip.
It has been a great learning experience.  I can see the patch has been
integrated into seen.
I look forward to working on #leftoverbits projects to enhance my understan=
ding
of the git codebase. Thank you very much once again.
