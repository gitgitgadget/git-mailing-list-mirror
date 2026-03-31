Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8623363C60
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774920613; cv=pass; b=nXago1DyApPE9b3mV6sLiz+okuK1gc++2qKloQ4uuA0Gym1advqRpS4tAHacNekhFdAXmB4hR6oSeyWqK0iYGMMuNTtT9RaTKolZLaTEpJ+YwQaqDlmSDJD5aMP36T3C9BA1eO422eRqYh4Qjdwa8G1K/cQNH13S4gVod5DoS9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774920613; c=relaxed/simple;
	bh=KRVFbq4O5oA4mujoDrYRSaO26sttwjEcIxYnUXZU360=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U50dB7e50a3Lxh9Vh6eEC4LSr95cMgek99wBdpacWK+E42QzaJseFWD3l1RmOc5tZugveoIj0Jg7w5vhTna5ADbuPTQkv+ZagkpHEyg/MaAwd7iG3LVmUS73R6eD+/HfxPN4my0slQ1sDpB4sOqUasgtD4klQqphZXzFlY2YPEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWUngrZe; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWUngrZe"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-67e00a230adso3217639eaf.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 18:30:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774920610; cv=none;
        d=google.com; s=arc-20240605;
        b=BhFH8kIZMEqDRMXFHLoWMNNbsWPdVFnXqky3DbAT5lo2LmepVplsc54Z09Z11n8eZc
         dom1IbGJ1WHjrL8rgdI6hSuUmBD8/yynGsOkd7wLJpbFhZjJYza/xjGrsii0xWtlWSdW
         mfOqupY8etEpr8c44AFU0Ef66BlXJeL6T2Gz/eT2Tf/6upgv7KTymE9SZM8awtJll5pf
         3g417Jj83eBccjUPoCLesZPWMIs3Mk43/Gn6v1bw+iWxNDpiFFr2VmUTZS+NDTBkdoLX
         Mb3dHUKItLhEzRaZcLk+MBgPQXQCBNo26uIPmZ3DBGsJMhmb74A3SGpTu42S2TpliZVG
         6A6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/Fh4mQaWvWCT2VyGI41pV/qQ2nCcMHEPc4CEm5NM56s=;
        fh=7m/N7ORBm2uFVg7HhGFKK5cKqq5L33hKXdSvGb86aXk=;
        b=SAkJtZ2p2U57boovFJXyB2vE+19ECm4BeJ0YFexodjMSIsJERxBBriJlHWoJXjDFTT
         4NhmfkoZsC4p2wSju7+SQaC7szIi+lxeTJK+5VPXCAAK5KGXOovUBgimiYsOn2EjAjQA
         uyYNxscYw7rL1g5MT9YOz1Sdvlf3uRMh8RI5VhNhxqxKCsGF6z5J3zIcS8/rl0pHwvmJ
         BVnzCd/KvCxGC6IfXdQ5LOK1gwNCXtwGB9Jv+dDu0ITQysb6EsvtXJOMiVikXipavfIb
         8GjGL4oZQdrHue2ffaSdvhN/ApN2y0pprdNFauR+uvgcJv8L23bQPGfJ80lC2fd29TUa
         yfTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774920610; x=1775525410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Fh4mQaWvWCT2VyGI41pV/qQ2nCcMHEPc4CEm5NM56s=;
        b=lWUngrZe2pjKkzQFuU631d6TsclpTwx8kvzQFYUOUj6YgjutXx2W2Ksd7NMG8OKiCE
         tbEYhXrsXrNQDJzvTqwpWoqIM4i/piGNuu8KztK4wY9xjeEIdiKmh4fofess1Hp05JDl
         /k4mt7ZhUwbQidfDBY+6XH2CwGPqyjpm5xDfWQL/2VU76VzXSAC2wZYAx3h0JSNaCzcA
         S41Dkvh+paYcFjTETQCfjoKEiHCvlWqg1i0p5Gq2BRHEB3+Obst+lLeJuyMAIBgFk5Dn
         wuhi5tqng6jY9r8DnlmhJ1tVEfxGaMkvuBK6wDXPipn0kBWu4pwnyMksSEmFXfufUVyu
         osTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774920610; x=1775525410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Fh4mQaWvWCT2VyGI41pV/qQ2nCcMHEPc4CEm5NM56s=;
        b=kU2IGOZZYz5Ofjjvo1SIpdYIZ6wm83TpGZktAaAxK+UowaMD0C3c4Acyzpk0WTqGpI
         z8YmZnrXmaLBxjRLSI5Z7X2y03Z7Bog88MKAgeFJzm6lCO9xNAQ3NVwmyPwuKNjmPQAA
         NPgEE093hJraevSD2j0fi1eby+qYyFx42qlODVgY02vRNYP2lK18rShdDN0Jy6PjPbRa
         CjBFNmgRPlkVsqQV+lKGvm2LF7UiDsVyRt6P4AHDCMifKOlVj/8oC/n3lDFninMsIshF
         wDsuY/gIox7YWGCZrHNjm37+J9iW28yIkR4n1a/UIelXjuSO2W4DTyEnXuglCJpn6vfY
         hTJA==
X-Forwarded-Encrypted: i=1; AJvYcCU1uM4SnXUmNBEytomlRE5LNOjzPcnL422M7UYFqO5f9Qm4j38UZUY2N2/mltNQ6rDzw+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHSX9IyknFU8Mli2Ufhz2Rk4+X5UsVljpBkPhM4aSAmLpxOAaj
	1k9twp2pvsiBKqFPEDRZb8AA42EZuK89WiTIAd3+vGrwiHOONaKqgjXcqw4PTW2vHuf7oKkTB5M
	aqmARBuQir66vYY7FqqiKGLLhFIVqP1M=
X-Gm-Gg: ATEYQzyvylmMTvgjw9f9NA/uoNpltyFOGCFSn3mZjfpt1OFAV4u4+ZsAdPLLySKGnI6
	x5Dfj+LUHcQgYHg1dUmJFJ6cpaMTz7orXpcBqgZeAQaOfbEuLpsJ87w+41vFR7k//CEHDRZcqBa
	yc+y1EqxKdHCEKFpMACh7o7kyNyWer77OmIXVwBHUvkNZlgffA5h5i+u+dYHZRbmTVf8hk/Noxt
	8TIaxdNuTyDuf+pgcrGU9KLAHYdxYvy3Y1NJmNvtRuWo6yRVHzqnTNHoiqS9WR6eJh9FSbZyJO8
	f6Qm
X-Received: by 2002:a05:6820:228e:b0:67e:2960:ee2f with SMTP id
 006d021491bc7-67e2960f1b1mr5040856eaf.22.1774920610338; Mon, 30 Mar 2026
 18:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
 <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com> <86dd98db9b93651b21adaa41ccd44917910fedcc.1774639433.git.gitgitgadget@gmail.com>
 <xmqqy0jdhtd0.fsf@gitster.g> <xmqqcy0oj2s1.fsf@gitster.g> <CAH=ZcbAKwtq9jiv=XWi_P0ZD1hz7XEpEtMPONB9n=_EcOPPSRg@mail.gmail.com>
 <xmqqtstxdr6v.fsf@gitster.g>
In-Reply-To: <xmqqtstxdr6v.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 30 Mar 2026 19:29:57 -0600
X-Gm-Features: AQROBzCz7wKC579JQD359WgeapBsMBZcP1ccgwRP-MhN5RhiouC0KXT_PGi7h7Y
Message-ID: <CAH=ZcbA_1pZYDjg0Q7bEB11vY8-T76o-r-v9g--NUSwbfZigsQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] xdiff/xdl_cleanup_records: make limits more clear
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Yee Cheng Chin <ychin.git@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, Jeff King <peff@peff.net>, 
	"D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 1:59=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Ezekiel Newren <ezekielnewren@gmail.com> writes:
>
> > On Fri, Mar 27, 2026 at 5:01=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
> >> Updated code, when nm is not zero, does something different.  if
> >> need_min is true, mlim1 is set to -1 and presumably nm is a count or
> >> length that is bounded on its lower end with 0, so it is larger than
> >> mlim1 (=3D=3D -1), and we always take INVESTIGATE and never KEEP.
> >>
> >> So the rewritten code is broken when need_min is true?
> >>
> >> I suspect the remainder of the patch is broken exactly the same way,
> >> so the remedy would be similar?
> >
> > Your assessment is correct, PTRDIFF_MAX should be used instead of
> > SIZE_MAX. I realized my mistake a few hours after I pushed. This will
> > be fixed in the next version.
>
> Yeah, using PTRDIFF_MAX is fine.  When I reported the breakage I was
> hinting that everything may want to become unsigned, but since the
> original does use signed quantities and variables, it is far safer
> to stick to signed arithmetic---until a full audit says it is safe
> to switch to size_t of course.

I would prefer to make everything size_t, but dend can be negative if
the number of lines in a file is 0 and that breaks the current code if
unsigned is forced. I can cleanup the code to use unsigned, but I
didn't want to distract from the readability, of this patch series, of
xdl_cleanup_records() with other refactorings.

In fact dstart is never negative, but I thought that it would be more
confusing to change dstart to unsigned and keep dend signed and
explain why there is a discrepancy in types between the 2.
