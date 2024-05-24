Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1099050263
	for <git@vger.kernel.org>; Fri, 24 May 2024 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716578961; cv=none; b=Y1K7S99rN5P0vzJf2ukhvV1rKDO1nw3z1iPMZoouf5pzFuIA/LNn/8YEic4AEoIPhBEvsBZE+/TPPtpsDnq2Bm/1/usgXsb4HdjTvzKl46w4271EhFJ+a6fmcOdHxN2KI8bEfRnOhGBszvx8bX7Hj8BrtoMHRlE/5WsmyAVJPro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716578961; c=relaxed/simple;
	bh=epTqUa4T2CU5u8l4/g8VhsuQL6UXdaVK+JKXMGwrnFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxQWmM0KeAJPjYkvkwEx9or0EOsRUg+Z5Sl2zwXA+J20ZNfHBeFAUyFZcGYxW4vqrIv8wJ+TKmC8IMgpcShOYJFNqGECoYVgTivXm0wA1xt1pS3z2QUFmf9X6FtI90ej+48Vo1Z1NR3xeZ48g/joTIrTprkeIgkxE6WySqoUPNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-794b0080137so37847585a.0
        for <git@vger.kernel.org>; Fri, 24 May 2024 12:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716578958; x=1717183758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xccHkEgPriv2lGkg7Nvohbipk4NokWdTO1wjviLM0Eg=;
        b=Ia7BYOovtnX6o2MV4ph4kj89tZsiYnpC35waPpIscPqx0uyg/w/kn6hABNDbopp+gx
         Zo3gYPaGgAHi293Vpd8BqbU/dPD/Zc5y4yDvOJJ3lVAG0wVWyBNJKvd/LNFZC9jeqshF
         iT0TAes6gpdARHwkw/u0TUj0MxTHj5evc1kHqYq0NyLBlCXGphnoA52Y/2ET5CCPALia
         Ze7VecVPwqLCzxjv4mps9NS89Liv3ovnKoy0rkBg0uu4BF67YU5l9Ro74G5fJUYSYaGv
         iZ4f4zZ+ATMa5mT4UypvZFYAHbjlm5LeYcpJh5uKu1YiOKwK5tHTFl0rJQN32e13neqd
         5Z1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjj27+Y9kpQFSwfR+BH+e4UFMcUwJKONEoKjBzdDkhxDKyp4KWx1UmxDYYghv+P8JzaqH7VJzVZ/Vb+Z8BmrpTWaRj
X-Gm-Message-State: AOJu0YxI2d6w3KJZWdSrRq25Dvo9AhqOkfet6BofOCYU9/x1msrUvewA
	JNYst5gtozglhHwKPpT+5LFGmheI1vWAqsDhi4KU3tFJTJ21PQOF75cisaSHc8r+kjRqiv7Mebo
	be4t9e3PxvXB52kWkbDzwIiPv024=
X-Google-Smtp-Source: AGHT+IF9WlXE5pmdMs/XgNoCsdct9dtY2q5LXwyPTPfGY81ln5cECkNQOtasuACHbEbXP5I65QXl+MFAMcq1lZ3LvK4=
X-Received: by 2002:a05:6214:5987:b0:6ab:7270:fcbb with SMTP id
 6a1803df08f44-6abcdaa7fdemr41416506d6.54.1716578957749; Fri, 24 May 2024
 12:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716451672.git.ps@pks.im> <cover.1716545235.git.ps@pks.im>
 <0df17a51b43e1e9d007328aad6457363876b2e1d.1716545235.git.ps@pks.im> <54110fa9-02ba-4c9d-9ec2-c26e98a42730@ramsayjones.plus.com>
In-Reply-To: <54110fa9-02ba-4c9d-9ec2-c26e98a42730@ramsayjones.plus.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 24 May 2024 15:29:06 -0400
Message-ID: <CAPig+cTV8eXHyFjG3gS+veQb_zUrdfz1zvNNE-aKMsaHoyG6hg@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] builtin/refs: new command to migrate ref storage formats
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 2:24=E2=80=AFPM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
> On 24/05/2024 11:15, Patrick Steinhardt wrote:
> > +--dry-run::
> > +     Perform the migration, but do not modify the repository. The migr=
ated
> > +     refs will be written into a separate directory that can be inspec=
ted
> > +     separately. The name of the directory will be reported on stdout.=
 This
> > +     can be used to double check that the migration works as expected =
doing
> > +     performing the actual migration.
>
> s/expected doing performing/expected before performing/ ?

The "doing performing" bit was noticed earlier[1]. I suppose in trying
to fix it, Patrick accidentally removed "before" rather than removing
either "doing" or "performing".

[1] https://lore.kernel.org/git/xmqqv833maxu.fsf@gitster.g/T/#m2c3eced90c6c=
d61bf3acda1acc354b4ab76011d3
