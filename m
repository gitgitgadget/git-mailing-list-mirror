Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A737613B59B
	for <git@vger.kernel.org>; Thu, 23 May 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460231; cv=none; b=h7gxAnn0sVbJEFevMiUIZeWB/x73uAscuubUhUjl61vbqgi7BpN73Ez6SMlyxDUJkFjG8CKUhU+jwwxp/GR1VbFqKgxhpFkpd4D4NKbODKBJMe1L2yZ0FCg7cCZpmazTRThQpdf1Ho4b7E+Q6ISZWQXGBv1dDqhhHDKblQ6TAp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460231; c=relaxed/simple;
	bh=BJgknyTwpVJZeWN8oNxIF5q4U8w/jUPIz+sVVBhPVuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qM0ZEvhaPKDiEtL+myFlXRH6Ez+7IsYvDmffXUz/cMNw8TKU+3B9wy4Tmo2mdAsBrMLhyb6g7kl7a9uHlR9aEwR4mdp1DHkwmLHFKKlWsf1+n6bGVrGY1sdyJpzfe46on8LYMqB7B6IhRIrsooMTpAUMRabKLNPxg4tVCvL0oVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqmZdLfI; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqmZdLfI"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5a5cce2ce6so997858166b.3
        for <git@vger.kernel.org>; Thu, 23 May 2024 03:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716460228; x=1717065028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJgknyTwpVJZeWN8oNxIF5q4U8w/jUPIz+sVVBhPVuw=;
        b=dqmZdLfItokcgtMXHALVC+vq3YfiHL70Wt+qb2Yi+4TM2AmXtcjsieB753HzkGFaSR
         5Ka+d+AOtuC0xfIimbxitlsfenw7YUD51F4zEz8yn2dmbR7nRAYM4G3jiGlR+wBS6Sfl
         IIYadJzwhLj/mQQg1ARGvGMu3PYJUy+Hz7YcQZ3V7kFMDW34Mibduw1uNNivEeGmk8lr
         nHoTVhKc62mKWgxPRtP7+lAvAGR9Aqcqezcv1hOnskCq85iBigVhgcQAVVRciSxxyXaK
         WBdKrwm7WzWsqGGL/v4ISHaSyKKgbr2vz+K+/Rp3KkVsvBRaSTNWenArczrXcb3WJN5B
         tpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716460228; x=1717065028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJgknyTwpVJZeWN8oNxIF5q4U8w/jUPIz+sVVBhPVuw=;
        b=F9ZgfIV4NF8waVurXsKjrEh9fDQmB/x+XNl3UctG97Y1I8rksWypfxBr1cAE+jLt+R
         c0dnC3iJdXBtVEs6QhX7sUIlk8P6lDWmI/2u6rsiQ/R2I38HhtxK43cpreFawa3nZut5
         CH2Tol3OfAPBEnf8oIH27PAmVCMGDX+uvuePx1083yRyNdeW3Zemcpvtsv2lmycKnZMx
         Lb+4D1kva4yKNfJWXydoktTY3NWgNJh32/539mn4OEZS2SlFkaHyOFRneFTGCQMyuKyR
         Jh+L5h8tkbuFUBMzYmwycSDPfNT3tewmExMUZ7ibPuJojbxHqIrHbK9l4QFixlIDwA41
         fKBg==
X-Forwarded-Encrypted: i=1; AJvYcCVRAzppPjInJG1AjMtPy93C7xtSW0T+5dmP82mdEtcjDnHeUhOkWjuSiz9SpHvkAevaApj4Fh42yzYW8IVt7oKVjGTi
X-Gm-Message-State: AOJu0Ywfr2r4XmsbtQ0awV79YNj6W8Uelayg4DR/ZcGtLrjFY8QsOMe/
	bccQx+DO0mf961/2Sw7IYoCHcfVXyQZcqKGJKOA4iHv1BUSCgF7HFMLpwUppXxmzmz+2sSM0+xw
	wviiU5bDkxzbZholrUpLGGWEqWpx7rNJT
X-Google-Smtp-Source: AGHT+IE1IlDKZtTZ0or2d1ul8m1DKa7RYxneiGskVWlcnbs1qCtJg0R6d0iB0JF3f+EckiMXaPSxF2i9LluPUe1Y2w4=
X-Received: by 2002:a17:907:7817:b0:a59:9a28:f1bd with SMTP id
 a640c23a62f3a-a6228170d2cmr287824066b.66.1716460227770; Thu, 23 May 2024
 03:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <406aa31f-4ea0-496c-aeb6-443be86385c0@gmail.com>
 <CAP8UFD0u01mrjRfqrmv=ztv0-ek9yUebZNm-GmQyacLiynFxJg@mail.gmail.com> <ZkSIywwX20fJo-91@ArchLinux>
In-Reply-To: <ZkSIywwX20fJo-91@ArchLinux>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 23 May 2024 12:30:15 +0200
Message-ID: <CAP8UFD0ogL3v8LtC=DA+UBsVE2BS-ycwOjjg4wS43KsnOV5eFQ@mail.gmail.com>
Subject: [ANNOUNCE] GSoC Call on June 7th at 12:00 UTC and Slack channel (was:
 Re: [GSoC] Welcoming our 2024 contributors and thanking our applicants)
To: shejialuo <shejialuo@gmail.com>, Ghanshyam Thakkar <shyamthakkar001@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>, git <git@vger.kernel.org>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

On Wed, May 15, 2024 at 12:05=E2=80=AFPM shejialuo <shejialuo@gmail.com> wr=
ote:
> On Wed, May 15, 2024 at 11:19:34AM +0200, Christian Couder wrote:

> > Please let us know if you would like a call or some other kind of
> > meeting with only your mentors or with the wider Git community. It
> > could be on a regular schedule (like every few weeks) or not. It could
> > be a special Slack channel with us and perhaps others who would ask us
> > to be invited in it. We could also use this thread or other emails
> > threads either with or without the mailing list in Cc to discuss
> > things if you prefer.
>
> I've had meetings with my mentors Patrick and Karthik this week. We've
> set up bi-weekly video meetings for syncing. I think it's good to create
> a Slack channel where we could help each other for some general problems
> thus improving the productivity and also establishing a good
> relationship.

Thanks for your reply.

Chandra, Ghanshyam also agreed privately to have such a Slack channel
with all the mentors, contributors and everyone else who would be
interested in discussing or just watching what happens. So we will
create the channel and, please everyone, let us (Karthik, Patrick,
Kaartic and me) know if you want to be part of it.

> > We are suggesting this because the GSoC docs
> > (https://developers.google.com/open-source/gsoc/help/oa-tips) have the
> > following:

[...]

> I think it's nice to have a virtual introductory meeting with all of the
> accepted GSoC contributors and mentors thus we could know each other
> more.

We are also going to have such a call on Friday June 7th at 12:00 UTC
(2 PM CEST, 5:30 PM IST, 8 AM EDT). Everyone else is also welcome,
please just let us know and we will invite you.

Thanks!
