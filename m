Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A7F535A4
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 06:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713333743; cv=none; b=NeKt7Vr3+AC1NWuXMspD5xd2HtQphlVZTueFjX/+gO1WTdUejgDZBQTSmRKdsQ0jKNAicfADUHIh+1n0wtnANfTa2gN4thtqks7myYodeUXmqrtlrNP+pCArW2/jH7o3wDFVP9LEOSb8EwJpIbsHvjWy9k4PhygZxti+svGcDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713333743; c=relaxed/simple;
	bh=AMuB+57MR91ND9QtmkFyJqDLVbAiTVXNWcqId7y4pGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rm7NIVkHOCCCrzJRs5PJoYWw9iM4Hn5IMvq8gYcNtWV6fNDnbRKD5TYqR/t/Vj+Y1Ho4qdfott4Su2ADUnCoSTBP1C+Kf1dH/Iutp9J4T1JDdJINCptWp8iVlxJpjX8hoHInIS8tr8C2OXI8stkKaorcSJp0FcOAg9xxr+maSFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78ef9ce897bso62347485a.0
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 23:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713333739; x=1713938539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhSVAOsSNGQM6gtp3e3UDkedYu0sTjB9bZ8rfhCQenk=;
        b=mIkLQkHGuGnu9a5rSr7+EDFIfUdFHZQc0XnZL6S9hRj+/bItkfVy80E7f8NNU5QFPw
         Qt1px8tlVA0Glvrjtwb98MFogfFqKWUHr/9l7Zl1VJnvDqoenCPIzU4Fxt3JSoVpQmKL
         ZyC+9HBgaKpd8GUr3AuUGeJL6RgQLgTtkr8grvly5S4nKWUs2emeSB+0KUlQNnnrpFgI
         n8T1AAUcvN2QoHcnRh58U7ERJh4BPyYl0DfVLuh89YcnbfuXEPX573Lk9TflzOTf4gwB
         mnQbJC4HFfpywLI+9UaomADOUDAFc9b/DIFftS3WwtrfSooTzyIMVQOTn+tsptKbDiYk
         pfbA==
X-Gm-Message-State: AOJu0YzA17QWvgiJGZduiDLb1JuGm+9dPfAFOXWOYFYiA3pvpNuUQ9cZ
	tJMiQlp++b8YcS8sgwBW1HSR4xNHWMpDJmXKqxFFNrqTu6YESWrbAFG1+c04apUpi/HtGu5ZcI/
	Un1bum8GnlqFjrE2R7hcziYgxl0eUlfBV
X-Google-Smtp-Source: AGHT+IE7Ye6rdO3BjJ9TtvnW10HPKYyCwWl8fewAvC3FtuT3KqZhzOhIUxBj8ZgKITZ8Luzu4GNXCBVLp5BdN/gF0K8=
X-Received: by 2002:a05:6214:9ac:b0:69b:7361:dc08 with SMTP id
 du12-20020a05621409ac00b0069b7361dc08mr8764180qvb.20.1713333738684; Tue, 16
 Apr 2024 23:02:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713324598.git.dsimic@manjaro.org>
In-Reply-To: <cover.1713324598.git.dsimic@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Apr 2024 02:02:07 -0400
Message-ID: <CAPig+cRkrMDkQKnwaTGY4djwgC6mGqngB-4HfGQm1TNCq4Q4+w@mail.gmail.com>
Subject: Re: [PATCH 0/4] format-patch: fix an option coexistence bug and add
 new --resend option
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:33=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> =
wrote:
> This series fixes a bug that allows --rfc and -k options to be specified
> together when running "git format-patch".  This bug was introduced about
> eight months ago, but it has remained undetected, presumably because of
> lacking test coverage.  While fixing this bug, also add a test that cover=
s
> this mutual exclusion, for future coverage.
>
> This series also adds --resend as the new option for "git format-patch"
> that adds "RESEND" as a (sub)suffix to the patch subject prefix, which
> eventually produces "[PATCH RESEND]" as the default patch subject prefix.
> This subject prefix is commonly used on mailing lists to denote patches
> resent after they had attracted no attention for a while.

I'd recommend splitting this into two series, one which fixes the bug,
and one which introduces the new feature. Otherwise, the bug fix is
likely to be held hostage as reviewers bikeshed over the new feature
and opine about whether such a feature is even desirable[*]. As a
result, the bug fix may take much longer to get applied than if
submitted as a standalone series.

[*] For instance, my knee-jerk reaction is that we don't want to keep
piling on these special-case flags each time someone wants their new
favorite word as a lead-in to "PATCH". In addition to --rfc, and
--resend, the next person might want --rfd or --tbd, etc. More
palatable would be a general-purpose option which lets you specify the
prefix which appears in front of "PATCH", but even that can be argued
as unnecessary since we already have --subject-prefix.
