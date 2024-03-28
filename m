Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A11446A5
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647609; cv=none; b=W4jVKN5btk2v5BcuTHYUnfy6obQFIzJzoxCXGLdQ4TQPSOYtsgOsSkvij3T3hwALLIGypueABF4/I6kWf5YQEnp4gjqKfRuEFjM/PpjZbtg3bduRxzbdqehqRFocCb1cjUEnQ+ovIcCW7qHrmNmOkT/IFx09+F6d6evdSOC9+Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647609; c=relaxed/simple;
	bh=UEB4nQVRdn1ITkvQ/Tt38EZdY7cP+N/MunHJqJUSCJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0NHgTqHl7VLND47d62HDeAMj5o5AGwVScpvHh1+E7c9E21T7dBTVSnee6/cHEQM/5jJDpoh1XXCoKPeRLKebYeQfbaxtyU77Gse0asDi/gzp/k3ftXSrGty7ZcZbIFpHn6LDJ+oLN7qoc5baZLlW9P6spy5jUg870cVvh7VAL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fuseenergy.com; spf=pass smtp.mailfrom=fuseenergy.com; dkim=pass (2048-bit key) header.d=fuseenergy-com.20230601.gappssmtp.com header.i=@fuseenergy-com.20230601.gappssmtp.com header.b=FbArcApO; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fuseenergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fuseenergy.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fuseenergy-com.20230601.gappssmtp.com header.i=@fuseenergy-com.20230601.gappssmtp.com header.b="FbArcApO"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a466e53f8c0so160056266b.1
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 10:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fuseenergy-com.20230601.gappssmtp.com; s=20230601; t=1711647606; x=1712252406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlXcMDAELQkEheZ6Be/2sTIrt6379mLH+nyTdad6jDU=;
        b=FbArcApOK+1iru4o5sZpyNHD8BQvWGWRHFAim/lO9k3EL9lJzdtcpCVI11ZbPMpCWo
         5aFqf5WJyWaoP0f1CAIzfMEljvtrAMEFRU1ik5pC8cBa50xD6kvDORpocxvhyELcJmO7
         pXQ2rafopX1NyQuGRkgtv17TynTXEjkI21J1H54r9GPLYBWY+smH6RCjHq3nA7rZ8QcQ
         oQbjhgjlLHHUTDdr5yL2bcGI0aFqnQBwoD6tAhq7CUY2VRq8iQmLqXjIkF3RbrRqb8ZT
         IFpH7drwdzLariPS8OwRp8R1bbu7QDGsdcD0LSCT8Xgh2rki0dGeBseKHJueu7UzDVtu
         8qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711647606; x=1712252406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlXcMDAELQkEheZ6Be/2sTIrt6379mLH+nyTdad6jDU=;
        b=WczJGsLL1GPJNfW7Zk8qEdpZgZtggxGODZD9AmCUvdb8OHxobzyG3cGcUVibiJzuJ9
         R0yVxNSgj61wP+gSuiqohEI4UdSmnVpe0WChIlslwO1StUKPUNXWv+Te26T9egqyAcQR
         tuNiLHnRYqL8DpRKU9i4K/YO0KkIvPb52KPT9UMqixK3JoZAiYT5pto5x9O1LpSJfoBz
         pRo4OXbO2Sv5SDzeCKpoIhESgpiOtlCC493+A+yFde+kEpPojNHoEkBGvuTdnE7D0D5u
         7l9Hk6y4F+KOo5pbQyMLYFs3k/bJTzKbpDdi+r9tJjB+A1nndet16AgqzNbO1tHZulYY
         cwlg==
X-Gm-Message-State: AOJu0YxOCOIayPw7Ceb0nGOQtvSvJdSsUi9wb1c9s4BFbwvDy267ImaU
	E12GH1vVovAIaOKmO74M3zRzvkz5P6bHC9K42dK2fNN0yucehoYrfSUREh9pz4Z2mRzELoBhGnH
	w4e3KyihynBpwKNgX9UQgUxSwzn/3Lr5LJLTpUAPtuDlRaX6m+NrYYw==
X-Google-Smtp-Source: AGHT+IFleAQD7A5cU0UUwHwYbrUeZr2aW0en3am5sdYMe5y0n+LVscUz656l8vYa4fDVIhTyeryHFIku79N0/2PdZ6k=
X-Received: by 2002:a17:906:7315:b0:a4e:c3c:e0d8 with SMTP id
 di21-20020a170906731500b00a4e0c3ce0d8mr3086020ejc.3.1711647606383; Thu, 28
 Mar 2024 10:40:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEYvaskGHYrQgke=gf1sXYhrwbd+SeTpcjGF0fpxK3hQbyPFKg@mail.gmail.com>
 <CAPig+cQWW1sLXyTBvk6D+1h15sZCtQO1opfhtFfiHr_kX0y82g@mail.gmail.com>
In-Reply-To: <CAPig+cQWW1sLXyTBvk6D+1h15sZCtQO1opfhtFfiHr_kX0y82g@mail.gmail.com>
From: Tamir Duberstein <tamird@fuseenergy.com>
Date: Thu, 28 Mar 2024 17:39:55 +0000
Message-ID: <CAEYvaskXRyxNTLNeRPPyawFrBVRgCbSnJiuF7D7cOGiaDq=V2Q@mail.gmail.com>
Subject: Re: bug report: spurious "cannot delete branch '%s' used by worktree"
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, the problem is persistent. The branch is never deleted.


On Thu, Mar 28, 2024 at 5:24=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Thu, Mar 28, 2024 at 10:54=E2=80=AFAM Tamir Duberstein <tamird@fuseene=
rgy.com> wrote:
> > % git branch -d cleanup
> > error: cannot delete branch 'cleanup' used by worktree at '<my source d=
ir>'
> > % git worktree list
> > <my source dir>  dc46f6d5e [main]
> > % git branch
> >   cleanup
> > * main
>
> Is this error persistent once it arises? That is, if you invoke `git
> branch -d cleanup` again immediately after (or a little while after)
> the above sequence, does the problem persist? Or does it "clear up" on
> its own at some point?
