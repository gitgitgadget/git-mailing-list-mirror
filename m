Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F7E4F88C
	for <git@vger.kernel.org>; Fri,  3 May 2024 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771459; cv=none; b=DkPpHO+sqNQedhVD5CAtTcdFypbGQltiiKT1EM8ub+He+kZndLKba7QWLhMLMY+p6aG5LGi3sP9Dz+7keZvxp2DcAqZmO2ealMHNRLsXmrHTUrhCjzdyq0DwBiJJ1wL6yD7qCDjJgZH4tZmrf+vBT1wIIlIyLOC+cfsB7Q0BfWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771459; c=relaxed/simple;
	bh=pBiUTNLX4JK1kGnkP6KNOsk16fvxG/S/yWT5cGBJpKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvZOihZvjyg3rPKnICm9AL1BzzrMhFtRI/FNXCDXkdQ8xKGK9JLBQOU4OWB62g1lx16ObjQH9xPaBnnyv5hDIUxZ8E24zlhkPbOyD4vwPJmrlSf3Abg2RvWeRCEKTihB6W7RbAJlURqyMrQarOREcwYPYuHRHt5mcFRofRwl8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6a071595d22so761616d6.3
        for <git@vger.kernel.org>; Fri, 03 May 2024 14:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714771456; x=1715376256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0eGKe0LgcjAdn/vn7WVTa6sZYZ4ONbihmKf5mWDYEk=;
        b=n10SCIq6aUb8S5w/ZYvRQ1xBu8Ync0RNkr8FWuzfAT4Gcr3jFwzcpFmkxat7twS29m
         6qln0pDoDbuRdBJdsFtlfQsgxugoPAR5YD4Uxmnx9O416f5WjHhkfTVb8iXmwfayb0sJ
         ZbgxLXKJt52fnJje+vM8VE0qyNJL3wN/v/WLDFBgzDINCS5l5/iGXV4iJyAgTciLxTsn
         1rB/InmPYha2+xlrsMgX+jvfsJTYEH2sy0YF4riylOOY5T6smvtbhE34MUWdu7/dSLOY
         1bvvpSuRKnIcvm8L5gjWCnuKv8FNTIsYXvxi8tEnUir5GZiNQbMv2WrmyPEXOYWhhrjS
         LzJA==
X-Forwarded-Encrypted: i=1; AJvYcCUhcOQg0eTMXd3VqF9Kyk39aG6uWgIFR32Jyo+YPhI25hOSDYqvne1zf5w6oyzFRwkW9iKtyMs8C8XcluXzvVf5TF8y
X-Gm-Message-State: AOJu0YyLuRTme4ERrQnOHDl+ysI/FD6YaE/RH30xxc6pa/Rx1+mgwXz5
	PEr3Q3W/fjy5FguROlQCiH4geRhKs23xpKf30GNxTXzDPJBQGHiOR4mTCEmUqifK+LL1eiz+0up
	mbnW5H7zEDEOzvbdr8/MvxW34OYc=
X-Google-Smtp-Source: AGHT+IGzkxVanEsz3a5TTVJBUD6OWllOuCblHr4G7dDEeubUXDF6qU4NYSmT7XvK6l2yp3jWBOjHHipXGQ543hgLQEs=
X-Received: by 2002:a05:6214:20a8:b0:6a0:d298:e04e with SMTP id
 8-20020a05621420a800b006a0d298e04emr4378637qvd.43.1714771456284; Fri, 03 May
 2024 14:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430014724.83813-1-james@jamesliu.io> <20240503071706.78109-1-james@jamesliu.io>
 <ab604f4b73eab1d9aae4e2a20ba0630e@manjaro.org> <xmqqjzka7p2t.fsf_-_@gitster.g>
 <CAPig+cRZEQjwhnMYvQ_0BjvXaR=3x=LQeJHzFOxC+ZPyOy9yJQ@mail.gmail.com>
 <xmqqbk5m65i8.fsf@gitster.g> <xmqq4jbe64l9.fsf@gitster.g>
In-Reply-To: <xmqq4jbe64l9.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 3 May 2024 17:24:05 -0400
Message-ID: <CAPig+cT-xk13jGEUmpT5QmwVYTxKNUZsu9xJ=Ph3h4AzKHg6pA@mail.gmail.com>
Subject: Re: Re* [PATCH v4 0/3] advice: add "all" option to disable all hints
To: Junio C Hamano <gitster@pobox.com>
Cc: Dragan Simic <dsimic@manjaro.org>, James Liu <james@jamesliu.io>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 4:08=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> It seems that Dscho was in agreement that format-patch's use case
> should try to be more aggressive at least back then.  In the message
> in the thread you pointed
>
>  https://lore.kernel.org/git/nycvar.QRO.7.76.6.1903211209280.41@tvgsbejva=
qbjf.bet/
>
> he does not give us the exact reason why he does not think the "more
> aggressive" mode is not suitable for other use cases, though.

Having an answer to that question could be helpful.

> A similar thread was raised more recently:
>
>  https://lore.kernel.org/git/rq6919s9-qspp-rn6o-n704-r0400q10747r@tzk.qr/

I think I missed this thread.

> Also, there was an attempt to clarify what the "factor" really
> meant, but we did not get a real conclusion other than the UNIT to
> measure the "factor" is called "percent" (without specifying what
> 100% is relative to, "percent" does not mean much to guide users
> to guess what the right value would be).
>
>  https://lore.kernel.org/git/85snn12q-po05-osqs-n1o0-n6040392q01q@tzk.qr/

I recall this discussion, as well as its followup (in which I
proclaimed my continuing lack of understanding of what creation-factor
really represents):

https://lore.kernel.org/git/CAPig+cRp4N=3D6EktoisKAH09aVAPkPgZfHJYcB5pJFJ-C=
UpBHFA@mail.gmail.com/

> So, yes, --creation-factor=3D<value> is messy, I think a very high
> value, much higher than the hardcoded default of 60, is more
> appropriate for use in format-patch, but we do not know what bad
> effect it would have if we used much higher default everywhere.

At this point in time, I'm not particularly against giving `git
format-patch` its own default creation-factor.

My only worry (and perhaps it's very minor) is that separate default
creation-factors for `git range-diff` and `git format-patch
--range-diff` could catch the unwary off-guard when invoking `git
range-diff` to manually check the difference between an old an new
version of a series before finally invoking `git format-patch
--range-diff` to actually create the patches for sending. (I've done
this myself on a very few occasions, but perhaps not often enough to
warrant the concern(?).)
