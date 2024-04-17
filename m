Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2B9524C3
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335002; cv=none; b=KoEaSPkbzsQFj4XdW23Ciol72ArmpKzdL9exW84aRYS8I68g7glBxqIZ7SBsLQRfZ2a8YJo4FjWcKwB6ONsSg0X60NId1Wz5HNv3G2KnHdr6WPqCqkc1MiNaiP7ROVguDIY0svwgj1igrzUaG5Cx+en0E1uB+dgMF7AkDJzJ3ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335002; c=relaxed/simple;
	bh=SQlQ68NJR8E5qlEc/KrBUotpyMrTgDr3j1Fn5n+E3ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItJBzaKmCDd1K8qDSZyH84dml7Da42Uce64E7osw2LbToIFrpaKLhN33wJ1kC550HXXCOPHfPiQIYrBk3a/BC2CTIBCjD92d4uG+zmd7Ir0TNtoOOtN5bRchw8f06rq/Uf1yhAGcTGglmIGrTUnl5y/E5T/IO0GKUafF2EOuFbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-696609f5cf2so29914556d6.3
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 23:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713334999; x=1713939799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQlQ68NJR8E5qlEc/KrBUotpyMrTgDr3j1Fn5n+E3ps=;
        b=sQ+f3mJBQlqLISyECSTvoaFOreNLaPs8BFZyJy+xjTMuuS3/jp4OQDmHjq1PPteRFK
         ItwbERGm5e2F+uPj5rn/MsSekn/ZmygYrd+X4ECJyt1jDARMpbQ7PXHbGRVpqsnewdHK
         BLVHF0VVTMlV56X6juA4A3pPtHZFXBQ/VdC5QSpt8Xzju8DSFWDuAhqeqRB/DtXu6Ocm
         18DeDSw4XQxfC62yoxJ0FhT08ftMqpgnsxDJ2uQXwrDI6FMWdwblljn41JBnBfVcYX2u
         R1SboVBHyMRC7G8yEThVKc0u5iMnfLuU4SqaIoUzL+DSW6KQHBwytu+nY7X3Fv/qmAy9
         pgWw==
X-Gm-Message-State: AOJu0Yx4a7vY37P11dQSAIA2+GxebvXASHI5FMzQji7llqRn+XFKRyGw
	/8vXJmwvfNLNxx/NVSww1aKsDWz4hD28APxuUyG3o1eNeTegUwoT7toEEQKqlERrYKVr0X3Xb5X
	XbsNVzEQ4snjPlc8aRCJcCEF3QQ8=
X-Google-Smtp-Source: AGHT+IEGob8uj9iTxrN6EKFmU/esOFEABafORuNgW1o1CWjAQ3tWO5S1uGwiiX5blayocJY5F0XNA9eBINTK++tURDE=
X-Received: by 2002:a05:6214:182:b0:6a0:3f71:ccbd with SMTP id
 q2-20020a056214018200b006a03f71ccbdmr2704686qvr.7.1713334999168; Tue, 16 Apr
 2024 23:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713324598.git.dsimic@manjaro.org> <CAPig+cRkrMDkQKnwaTGY4djwgC6mGqngB-4HfGQm1TNCq4Q4+w@mail.gmail.com>
 <36c4a1e23653c2844a52fd994501287d@manjaro.org>
In-Reply-To: <36c4a1e23653c2844a52fd994501287d@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Apr 2024 02:23:08 -0400
Message-ID: <CAPig+cRzCSO_4r02Vc-OpH3Cyz0iTWv+q4oTRg30H5Qvzz=X7g@mail.gmail.com>
Subject: Re: [PATCH 0/4] format-patch: fix an option coexistence bug and add
 new --resend option
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 2:07=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
> On 2024-04-17 08:02, Eric Sunshine wrote:
> > [*] For instance, my knee-jerk reaction is that we don't want to keep
> > piling on these special-case flags each time someone wants their new
> > favorite word as a lead-in to "PATCH". In addition to --rfc, and
> > --resend, the next person might want --rfd or --tbd, etc. More
> > palatable would be a general-purpose option which lets you specify the
> > prefix which appears in front of "PATCH", but even that can be argued
> > as unnecessary since we already have --subject-prefix.
>
> Makes sense, but in that case accepting the --rfc option, back at the
> time, was actually some kind of a mistake, if you agree.

Possibly. It does happen that, in retrospect, some changes come to be
viewed as mistakes. On the other hand, if --rfc existed before
--subject-prefix was introduced, then --rfc would just be historic
accretion rather than a mistake. (I didn't check which option came
first.)

At any rate, we probably want to be careful about piling on more
special-cases without considering general-purpose solutions.
