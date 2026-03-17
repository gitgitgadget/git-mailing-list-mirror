Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE129336EF1
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768020; cv=pass; b=s2eHYLVWg1LHPT2lY5V8HetDK/QpdCc30aCaSRHhOW2z+J2MvGWbAHCDtPp+wkUw9PgA3s3Nm5J5Jqxft8hiR4+tw2NsS5AokvJxsiKh3/Z+ZYz5PVbiqvJf0WtsKUmGf2IX9Zckk653WVnIRgM6OhK2KeFlRpAfpZ+WwuT1+WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768020; c=relaxed/simple;
	bh=kr6ZuPm1hm9F31Q31AgiD++cVQa5rO66O2A+Tj7H7eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3nHZ/c8nXAGdwkyXzCokDxrTKVggDqeW5EtqI3GLXeUW8mVG5HCxRF+GINbL0buQ2XFkbANsAuAHg+lULMuxMmScAu789L7rhVEpPdJxxY6SoN5Ch2mTLIoIgzVbKp31J84p/6/up1Nduc0TD5c4dodJi+jiFELTvCnPfNkuIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpDpU3d6; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpDpU3d6"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ad79dfb6eso6865796d50.0
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 10:20:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773768015; cv=none;
        d=google.com; s=arc-20240605;
        b=Wjc93uf7pvAZa2LXeTO1i8xgO8a9F8oKsWi9Dz7BLQuzun9zr/zcHqvT39e87+oFR9
         2Y8Wsl7L+JVccDBNhCSPRZwRrFo29TcelxFMD+HNfTmclNGIM+VLOknRSELIeO94KOf2
         SNe9WpRIfsBGNH/uUmm+Rwp0eE1Nao6dMUNYxN1gkqRqA0samUzawiTFz8BqbwrqSsiD
         wB1UuOsbkDEZcw6qsLuyxUvYWsvi0Zii0O23Du6eEraLJSS6yfE5CIbQsJevo0vtXLVh
         TpCmBQOZFYwQ+Xjl8tAVy9ZnZWnQtEijyC2ULgCDn8QFM5lp2/U7MHKvRh8rpTkelUog
         2Mvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kr6ZuPm1hm9F31Q31AgiD++cVQa5rO66O2A+Tj7H7eY=;
        fh=H2CiRJ5bdkve3BHBzZ3RWlHKRhQaf2NqPW+jWfuIzc0=;
        b=ZyMoKIeJKOwJBQtqzdmWgr3LK0Zb/QRuZX0rWSY1ukZ7uy+aZGs5DuAtjxiAkGWlrc
         MqygTB4jY2faBic4W4CB1e4uo+rbb7go35ZBas8I7xkFFQOZ5Lt1penXDvaOQ+lXFzMi
         nsSHAmS54JMgPgqjn9BNuboKHFYN6CeUJzbHo9OAUaLdcLXDQHV4rdK6i/sg088LVlDa
         moRZ+He8rv3/FfGE/3dwZOlPWsE0sjlmAgTIK9fBthWTVTNg+35TP7RYyr+njCxE6Opo
         yQAp5QlPhOzdemXbwlnXjw5XBn1PJOPRMx/DyFJ5df/O0QnSxwwkP9IuwnM05SA5fzb7
         CUrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773768015; x=1774372815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kr6ZuPm1hm9F31Q31AgiD++cVQa5rO66O2A+Tj7H7eY=;
        b=EpDpU3d6NB+eUHesAHSuZWRr8EJD5Xb2GYg/gUCTUwG+P69dh7+/CY71fbomwKJTXW
         t0DxZCILn6idqIJeXF8cCys9sf9ubcsX25ISeI3SDVZNJ+HVGtLu/V8UQ0GodgyE83BV
         g1FJzYnBZRCa6CLM3bO8DKqqvOb9F0uM7aOdBRD5bwF1BU0imNz/TuAc+ton3YphSJzq
         IuTZvU3N/BLrP7KtWwvXV7yUM1/UJbDMlxpOSZz9wjaOZhEKIwuJ4Ge+I1kB6FPxI4Ul
         7OrCWV/NKcfQGg0apbdp2gLN7mNCoYIoq8rOqe/bLACphA8ThoeHNAl+J+k4o5ikxUCU
         rhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773768015; x=1774372815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kr6ZuPm1hm9F31Q31AgiD++cVQa5rO66O2A+Tj7H7eY=;
        b=fcrnTz9zosZvDdpxMvcK8JcBqldCftzYY7gYbPF9nshsNGHxIRKej8kCkbbA5D+OoK
         3e7w553HyrAsHqCBPBtutrBAR8XfyG2OU/05XDQDA8eqXIaqcOyXs7vMCIUAXpd9oZTb
         krIXxFGG3hZKSQhiRlkYaadUl7zi9N68KY3wrMS6x3KK4Od3NUpKWUS2m/3aNKv8toHB
         Z31RTe8AlDGbpf48tfdEX7EoF59vJ6TtLdaC6Yam83C3ZiahxFRmWQncdngv/gRu7zW/
         nG1jkkiyRMzCx1o2cbuB8Z2vLEu5bAFhO34+/UL7yzYaNeivKpa096+47XrkxKOPNlZW
         DOHQ==
X-Gm-Message-State: AOJu0Yz2BPqv5lYx5IqQwPV4esQDHuO1CNjPRtYdxuGawHPPQRIUY4cE
	0BGBatDwaGtR+ekW7ZVvtans9KIlxwaUZ2vndeHWS1SZSs/leFkOQK2nHRkfm/oyx/xk2bj3XhY
	iv17x8vZBgibdHEX9pa9LrBogqqZzLuU=
X-Gm-Gg: ATEYQzy3texMxUNxLkOGJanmK9snILZlFWdpn/5Rye9YtAII+LZqSlNignZf0GJXz06
	1XHbharmoFV9tsVlsEpyyvtKNCWu7bUjCVz3zcrxIpmlKMZ1MnjJA+eAoaZcRn8G50L2qozQgO9
	oMDI2OqNiaC95xAzT+VTElnvVXc4616QlOJ1z7OLQjzbJX2ThTme7MWD8Gx/XYj1S9rfGOR9dBe
	7A5oGbAl2ItXrSJUYtjGNPUdFebluHYFt8CGoFqm9JaRd7iQFnYpcXEi8K77yM14NJXB6s79Abd
	QxKMk6WW3+GnmoX0qg==
X-Received: by 2002:a53:a110:0:b0:64a:dfe6:c387 with SMTP id
 956f58d0204a3-64e915f6895mr328443d50.66.1773768014394; Tue, 17 Mar 2026
 10:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316130431.1318-1-pushkarkumarsingh1970@gmail.com> <CAOLa=ZRpRv61Z7bkch53LJjsvZV2T3S+yRKOxYdK6U=oKW10YA@mail.gmail.com>
In-Reply-To: <CAOLa=ZRpRv61Z7bkch53LJjsvZV2T3S+yRKOxYdK6U=oKW10YA@mail.gmail.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Tue, 17 Mar 2026 22:50:00 +0530
X-Gm-Features: AaiRm53lQwp4n-RrsQ-BjvR_0dcL4rLZ8-JZuX8QeyAG8LMBM1YYAz354gbnQLI
Message-ID: <CALE2CrSmPs44Pi5=+s0bir1-ti5UR8xOGUMkrGhi1sRjiTwF-Q@mail.gmail.com>
Subject: Re: [GSoC][RFC v2] Proposal: Improve the new git repo command
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, lucasseikioshiro@gmail.com, jltobler@gmail.com, 
	siddharthasthana31@gmail.com, ayu.chandekar@gmail.com, 
	christian.couder@gmail.com, peff@peff.net, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Karthik,
Thanks for your review, this was very helpful.

> Which existing helpers?

I was referring to helpers used by git rev-parse and related path
resolution logic, such as repo_git_pathv() and repo_common_path().
I=E2=80=99ll make sure to explicitly clarify this and ensure reuse of exist=
ing
helpers instead of introducing new path handling logic.

> It would be nice if you explained a bit about this, what is the current
> condition what are your thoughts and what do you plan to implement.

Makes sense. I=E2=80=99ll expand this section to describe the current ambig=
uity
around absolute vs relative paths, and outline the approaches being
discussed along with what I plan to follow.

> I'd be very interested in what the current test scenario looks like
> and how we'll improve on top of that.

Got it. I=E2=80=99ll include the current coverage in t1900-repo-info.sh and
describe how I plan to extend it across different repository setups.

> I'm not sure what the last sentence here means.

Understood. I=E2=80=99ll rephrase this to make it more concrete.

> In this cycle? IF we do go with category-based queries, isn't that a
> design choice which affects all git repo info keys? Would we need to
> specifically solve for path keys?

That=E2=80=99s a good point. I=E2=80=99ll clarify this and describe categor=
y-based
queries as a general design choice rather than something tied only to
path keys.

> What do you mean by this?

I meant identifying areas in builtin/repo.c where structural changes
may be required while adding new fields. I=E2=80=99ll make this more precis=
e.

I=E2=80=99ll incorporate these changes and send a revised version (v3) shor=
tly.

Regards,
Pushkar
