Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3825F4C8C
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728210095; cv=none; b=L2I7JHXp3iJbrrAKnw5ZUOkvlswy+48AFotUqFgB8kjaQyGtb5rqdEIjnob1h+pVWYtw5dgxr3S24Zlhe0srATTmOQj7xmwPqPQQTsyf6p1qFJkEPK7w/97o1gzIMoecvxpWTA0JaisoOWJm+WzInzeqFjhgS36zW6tMtTJ2b2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728210095; c=relaxed/simple;
	bh=bPdCxIgiRMWalkil9WZJtRiLfKqF3kdUr4JGs86WlrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfCCRDgwmdnALtD293u7aK0s3Q9WPD8iPlL2xVSc1kdnx2kTsY0/ivhwI1AJHZ1DnyS4eA0yxEZ22TUnxG3Q57uuzdQwNlJHG3XSn62AYEtJsFcqydkTCGvZmWdn295zwjsMuXQYjt7HI+EwDu4Z44hL2/qQ8E2IxY78SiiZlTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cb3eb30527so5300956d6.0
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 03:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728210093; x=1728814893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPdCxIgiRMWalkil9WZJtRiLfKqF3kdUr4JGs86WlrI=;
        b=tPVgM4j5PG2UOgJhlTgO79XNiJeB7MKw+05uA5gbYFImjlh09ERlHjgbG2vOYPbSff
         8AWjMYfyRPEcptDV6OWwsLv5jYpSaIZyUzt12LAoRaa3u0f0C1e8leFUoQoCbKx0po4C
         D90UCE9TwsWbB4sbU5H5W5euqEB/NYYOX/iQu2gzKqlMK8Ys5g8C5CiOYjxKQRisGpZy
         GzBnXWgtnLjPanwRBx2HOU+E+s7GmcA2OEE4s/6SJ+pNWS2asGkEtRpv3N9+T4p12hRA
         E9m/cdwEI9uBGSlKgGFUouQBQI4qeJDycVaa53yOIveFPya1z8Vw8sGV6IDzXDY056SM
         cr3g==
X-Forwarded-Encrypted: i=1; AJvYcCVWk42hFWWJLkI9XIzpPxI/ZyyzVuylTnFZBnOgKYJNWZx/5858zwf3HVp6mfktPG+0HOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YynmcaNXUecF5cr4PCXIZD29tZ7SS3p7v519x3PF8YFbM75XgaU
	+hjVoy43eig8G7BZwnehSieuhOdjI/N4Hwts1alWvxBVVGQsJM3Z2Hzje3dHcK1Xkqq6PwGlbg6
	BNHKJIpmwJ79QmYGYfuViOISAQ+ONXQ==
X-Google-Smtp-Source: AGHT+IEl5M/Fci1l4VF8r2prawlmyG3GP74vZNz2dDsnfBeb/QWsC1PQ2cyt4LjnOXOZdNYvWdNPYkrxN0v0hjciKHE=
X-Received: by 2002:a05:6214:1c49:b0:6c3:6282:8d69 with SMTP id
 6a1803df08f44-6cb9a3068f7mr62788396d6.4.1728210093174; Sun, 06 Oct 2024
 03:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
 <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <CAPig+cRePbX6OyE6WhFp1GEZenZyC7HFeA3188F_nErt7Gin6A@mail.gmail.com> <CAPSxiM-=wtsd_XH3FY+C+1V_MwNkiMtRDwOKQH4r+6Cfj5Vydw@mail.gmail.com>
In-Reply-To: <CAPSxiM-=wtsd_XH3FY+C+1V_MwNkiMtRDwOKQH4r+6Cfj5Vydw@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 06:21:19 -0400
Message-ID: <CAPig+cQfoMe2H=1QwnSmGNxcEG0abjfLQAC1W7tYaQiMjYvuOg@mail.gmail.com>
Subject: Re: [PATCH v2] [Outreachy][Patch v1] t3404: avoid losing exit status
 to pipes
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 5:32=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
> On Sun, Oct 6, 2024 at 9:19=E2=80=AFAM Eric Sunshine <sunshine@sunshineco=
.com> wrote:
> > So, I think it makes sense to stop here and consider this microproject
> > successful (unless some other reviewer notices some problem or
> > requests some other change).
>
> Thanks Eric Sunshine, I appreciate your time and review. I am more
> eager to continue working on it after review from the others. And also
> would like to work on the test_line_count also if permitted. Thank you
> very much.

You don't have to ask permission; if you feel like converting the test
to use test_line_count(), you are welcome to do so.
