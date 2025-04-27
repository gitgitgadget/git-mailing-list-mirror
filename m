Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D4D18DB01
	for <git@vger.kernel.org>; Sun, 27 Apr 2025 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745790893; cv=none; b=lx88pEOPzj6eMbrSLeXBsVoQRZ1Eb3gEiit3IV2Q5j8BflNidU46kS5M2hIU2Ypw5bXx+aC8LSDvyeHnPa9QprGocGHrFcPXI5Eqo38x7heZ0I6G13eMMFnoIdtYiFdHynn4aPA+7Sa1f2mV38HL2Exx9qqVDZrQw0dGHvPgPjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745790893; c=relaxed/simple;
	bh=jhyzE52eVDXoAkNjMaQi47GE1vt3FHJBay8kwsXpXDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTHd1S+BYvyACp3TTpXC0iBCVazelOgQrOHJ12WukPQ2Y0ap85touRF0zrcF92LS/gkoFLN040CtL+Kn4kpn4HydQD7ooiHC6UyTGYDziLNlpTOydYQyMSVPqdPxT94vBoPjZIoSTN07LSBBODrZMTHolHrV+gJzuVqDnYt2DgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f2b58f0d09so8588666d6.3
        for <git@vger.kernel.org>; Sun, 27 Apr 2025 14:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745790890; x=1746395690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29y4RvDI4VSlJgUYB6PYHGsbVZOik0h0tWRVs+YjiNs=;
        b=xGnX4ZjUFkaH08w43DeSd7UN8/vTY6cC8LrLYPdd8Bq3PqfU+PDK3VnmTiDsfQ54ua
         7+/9FR0rtzuSqkLuSRqxPUKz0/u2Ee24k5TCJA2o6mD5cBejve5yfHdZpwZ2yChGrlje
         c3n68NOoB871HgJUzet3o9EvxeiRcO3sfrI7dhzK/ro509JL8CzttoNDhTyHpIPQsIzc
         OJyQPGFG6g59KIaIKOMdxU39bBkVJolUg32GLeQz65RY6ELl+i3BqqzsH9dVKRZw8/xo
         tFuaFWLpZeK3enhjTJ4Lkc0tSG2VcT2lGOpC2RErl0n9YxAfYtHRgXGW6DmOoPfkcw9U
         L5lQ==
X-Gm-Message-State: AOJu0YwxCt9nFYTqoKZ8q1wqkYThGqskKKyJZ5bGqaCfKm48rMdL7JTz
	fwjpzURGVA86YmnlnTZ2doGj5x9cNn7gLjNK9d1nl7H05b8HDuOTw0LJSFcHp9UypT01cxVufk3
	UdQFI4D5EU0leHosfsBaOhiUScFd+sP8s
X-Gm-Gg: ASbGnctIaHo+NJ6n6Fdb+0aLptFJhIUVcssO4v7QyJsFDbQXGZbN4GmQGVh5PTISmz0
	m4GBJAi4AnplXoKhIKHq1zKYr8kLCeZ2ra+aJYt3KOIoKz6zq+ELaIeZUJVJpRf0R/BsLAe3j9v
	6FEXWSy0wRq4dkpHSzWpIR
X-Google-Smtp-Source: AGHT+IFMjjAZ1SQ/aZwdnmIWk/UBW79rA3QaaG0p0eK7AOdxRIlIJAAs4OCtaCpqexiyp6w1ugTWWZfos1O3V+rOZPs=
X-Received: by 2002:a05:6214:e45:b0:6f4:c8c9:c4df with SMTP id
 6a1803df08f44-6f4cb91bdb1mr61101386d6.0.1745790890164; Sun, 27 Apr 2025
 14:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <15509dd701ace6793f0ae19368e4c0c3@mail.ntua.gr>
In-Reply-To: <15509dd701ace6793f0ae19368e4c0c3@mail.ntua.gr>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 27 Apr 2025 17:54:35 -0400
X-Gm-Features: ATxdqUH9JUIEomhJ-Vu3Bo3OU8XD3cJ66_SFQeuUxxs3Lq0JBvWK8BWgss_Ys-g
Message-ID: <CAPig+cSfbW9zG0Jv_t8QLFz6SPHFk=2g-eDirEpX8D0ytNWpXA@mail.gmail.com>
Subject: Re: Probably typographic error in tutorial 2
To: el24614 <el24614@mail.ntua.gr>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025 at 5:44=E2=80=AFPM el24614 <el24614@mail.ntua.gr> wrot=
e:
> I think in tutorial  2 (https://git.scm.com/docs/gittutorial-2) in the
> first code box the second time that file.txt is edited ($ echo 'hello
> world!' >file.txt) there should be an additional ">" because a single
> one will overwrite the contents. As far as i understand from what
> follows bellow, the text should be appended.

Presumably you're talking about this example?

    $ echo 'hello world' > file.txt
    $ git add .
    $ git commit -a -m "initial commit"
    ...
    $ echo 'hello world!' >file.txt
    $ git commit -a -m "add emphasis"

Note that the initial content of `file.txt` is "hello world", whereas
the updated content is "hello world!" with trailing exclamation point,
so the content of the file does change (indeed, the commit message
"add emphasis" hints at the way in which it changes). As such, the
example appears to be fine as-is and does not need to be changed to
use ">>" instead of ">".

That's not to say the example is ideal since the difference of "!" is
potentially difficult to spot. Had it instead been:

    $ echo 'HELLO WORLD' >file.txt

or some other more obvious change, it probably would have been better.
Please feel free to submit a patch to improve the documentation if you
think such a change would help.
