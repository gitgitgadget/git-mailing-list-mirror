Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BBB1DE3DB
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 20:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754859520; cv=none; b=acvtSGGNYiF6cLvA6A5e4N3RpyT8Gs21UIv8v1r5+LF12vgQRRuTFTVm4vHfMgzimADak0HGqxGpiYAdTZpTJDF+X2Zr5X4WiPgfUbViGzz5lKqy9UxK6NxohQlTyZayso6RFljNv3RLpk2ZNWVG7F9WVXGOHdt85gHHlApUQ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754859520; c=relaxed/simple;
	bh=8SHzBqJMaia6vewTjWX7s4OFgA1MJQ71IKixey1/HYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7Cz9/EDtcytdUS6Baxx4hTO6QaSll0E1hCIJ8YpKjPZrNZRfaB2mcqn8KMrDrZq977Ahe7Cr5YeEv/TZ1cHRpoDl9PJZYZVMl7//mdCpi7wl9d7G2HmWNAZdOI6TbBKVI5fUxE3S84AMnY2d4a51ok6re0Plk/Xs8+BAAxounI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-7096f5c5bc0so9325896d6.1
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 13:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754859516; x=1755464316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feQVMW7PDNSDgWs7ycLbvpbHV6PP52++Sa0EOmcdHYc=;
        b=XnuKNCKp9tI64esJpdW/oMPFmvdBh6RRcahba9P0KYe/1CuTeTf23Lvtl6SA/7nwvI
         vGGWvRrZILCxO9G8gPEqqYLoF94t6fPVmbWuRmhdoCQZc9XiYmkikQkwqtw+OZKo4vsw
         TBCQ/lH6pY+pMlUMGIaLsZa3npb6Q14IFE/GQeQyArJnae+sjlMK92s5witTds4T2Hzf
         w49d963tFp6ac1JSU1au2yyHr6TEu1iPZ6Y5J6BtpyhpWtR1IBpUouc9ip1CQWN2qY4j
         mBQ5aHSPIsdqHOr5SBJDABsG0jB/NkLWCyIEsHeOAW7mVk4ta1loyeLvHEz3QkPPpK1U
         a3VA==
X-Forwarded-Encrypted: i=1; AJvYcCUtTqe9azHN+g5fgSPa24DGglpFNlTz8vcAeu8NI5Hi+4u5p6F6GWkjQFXCr/kIBDXH1ko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8fAvVKmYinRhIG35TFInIHrfn2wGJg3Q6gVdw2RHgteAiW3Ld
	vsVMKvUdg0S7blMiAc87oWFDvFmwup7TcRhS8myAHIDPUSE8KjqBdTi3h0b/RRPPjUHAnKWx6kR
	kkQE/80HF0ld3ev2V9zWKaqBkhaJ8I94=
X-Gm-Gg: ASbGncuvzpaCpSTIpMVkKSaybygLRzsqbZNzLXhjyOX4a8b5zuhc3AyFYWLi8eWHEAx
	8ijwfEfpKJKQWlXyy/blQmluaLbskNo1vrsbAkQiW09ZZfvwFbolngGFqGjfPe74yYL4c4SHEht
	MpNj2lZKXKYhfF8oBOMz2QHPZbAPTq3Vdrued169sYnXvUs1m/sFwt6uOSvEJBY31CeGFz5dMaI
	uLvNSCKIL2r49ZRlcfuwNnv0bdxSOkBJGebarU=
X-Google-Smtp-Source: AGHT+IGAFUjFaiXd8l093/w9b+B4eDjmNftQmoX+HKzpLqJ5fFFF6UNqZ+/PCIdeIwEMLiY1pXV9fgVOgGlvmkKiXKQ=
X-Received: by 2002:a05:6214:5283:b0:707:4daf:62f with SMTP id
 6a1803df08f44-709b08bc074mr38533876d6.7.1754859516360; Sun, 10 Aug 2025
 13:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <144b6ee4-d4b4-4843-841c-93a109e71aa9@gmail.com> <9B179FBA-6695-4F8A-8EE1-A02F1236805E@gmail.com>
In-Reply-To: <9B179FBA-6695-4F8A-8EE1-A02F1236805E@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 10 Aug 2025 16:58:25 -0400
X-Gm-Features: Ac12FXzhA5HBPZhoddjj6vAlrLpDLqm--CA3B6JMmbQ3V6-GBl1AQ2jHlVA2LG4
Message-ID: <CAPig+cQug9-vH5SHHuM6xa-We51td0=JigODjvise0v8XA+eEw@mail.gmail.com>
Subject: Re: [PATCH 2/3] t7005: sanitize test environment for subsequent tests
To: Ben Knoble <ben.knoble@gmail.com>
Cc: phillip.wood@dunelm.org.uk, "D. Ben Knoble" <ben.knoble+github@gmail.com>, 
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 3:54=E2=80=AFPM Ben Knoble <ben.knoble@gmail.com> w=
rote:
> > Le 10 ao=C3=BBt 2025 =C3=A0 15:44, Phillip Wood <phillip.wood123@gmail.=
com> a =C3=A9crit :
> >> +            git show -s --pretty=3Doneline >show &&
> >> +            <show sed -e "s/^[0-9a-f]* //" >actual &&
> >> +            test_cmp expect actual
> >
> > We need to add "|| return 1" to the last line here and in the test belo=
w to reliably error out when test_cmp fails. I'd have thought that our test=
 linting should hove picked this up but maybe it is confused by the subshel=
l
>
> PS I think it=E2=80=99a actually =E2=80=9Cexit 1=E2=80=9D in this case?

Indeed, it should be `|| exit 1` since this is inside a subshell.

(I was just about to respond to Phillip's email but continued reading
the thread and saw that you correctly mentioned `|| exit 1` already.
Thanks.)
