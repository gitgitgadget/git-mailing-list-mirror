Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE1C339853
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773578685; cv=pass; b=I5+7qy4bPQcTmXgFjMLYKx4Yl5rdDjI27KQti1XOuv8/XOTZZ2NsddK2Im/P6iOIWKvP8IG6y/o0pzJSTFUbctKQalzi2CCQEi46QgNTk98U4pep/2E9f9ZAzqWn8aFWeCt70ycCSNfDBg3rV7JtpGaizmzbIT2Nym74gMNFl2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773578685; c=relaxed/simple;
	bh=Aop73yiT+ozKM4wI5mCn8ig8U8LLjXCiOf/n0qnlsds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktlcoBI0XTWGQoHdP+KBI9uhJf8Bo0Gp+YwPi7DblX4yCbpP7nBRUL0rrECbq0MIQ0Tie4ds+cIyNX1N5NGr3QcojglsKNn6L4qYrS3q/xiY96DEjmDCd3j0FtFqDN3Zo7JZxYvqQLZ+85uWyK5ghPa+pt13aifmQo7vEwuufc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6fvmuW1; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6fvmuW1"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-94ddffda372so2893467241.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 05:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773578683; cv=none;
        d=google.com; s=arc-20240605;
        b=jCST0H/Eq/rwOnQIFVliUv3LLMjbKFmjfZ4AOqhVPt0lK2PSkJQ5Syaqy2PywDcs3j
         lHAgRcwawYEADJG6gtydTIYDVXgbG/YxEzt1Feb4Vx+sIbQv53uIKB+TZ1ydcXG9WPCv
         3d4JduHztP9XCReaYm7rnAF+Kyc6la9sJGGnWBQqrDjHDisnykZ8mHvZIwHcisQwHN1h
         INYm5OnC2y4CMQCJKdVUAvWyxTwYTFBeB98mkQcxPTkL7Ys8SBQFMt/g+1ez2CySlHRK
         MrSbVvWm7IN/azXDsoGjnjdjx5uh0tMnlou2ApF5+aVCxAdP9s2FamjEFYwmP6DTHItr
         /MVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Aop73yiT+ozKM4wI5mCn8ig8U8LLjXCiOf/n0qnlsds=;
        fh=zMdzpXACyCg5d4FjsiAnBALTe74J+PxnUmcB8GPZ0IY=;
        b=ELleKk/cxmRiGJom9l5hRzqdcIl+aumAcqhpz48DvVJDrmnDkrcD1tQiqoZ80l1nRl
         MRoFGKCXXg46Wqm4SwuHMWQgyWOu+hC55Oq+ONDvFZh7lGUOStd+LymfViliHGJjs0Y6
         2iimRkG6Bsyl1pNZiShBxI4Vfe34NZ8EkLWVVXzj6Ev3cFayTllecx/DTMNLfoEYkH+S
         5AEwdH73EJMR7ru5pVDffs7o9EkcNaa6yOz2dIx2LwbTZhk0Fa+W3Icp5ZNn+Dc17+UD
         UxTo3yyTD53mpBz1Dg6Vc1vfREGQ7dF44DwVZaUUc2D+hOR4z9KShyqqM/S/NQfem72g
         3B6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773578683; x=1774183483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aop73yiT+ozKM4wI5mCn8ig8U8LLjXCiOf/n0qnlsds=;
        b=S6fvmuW1Zvex2ZeXNhu+xaoW3/T3Ob2i8oRfhUJW5givtK9XYOqWXX8zajvv7t2u8g
         AK+i/a284U6yWTfW77zKHEpul3jUfvVjlI0828oE6RDX69FR6wAJMOzgj16o+xc3i3HO
         QEV531vxMKPhWHwRUYfmIqWLMUJqYKh1+nWR6CuugOA2mXPv97dYyYKXTSmVeaTyFylc
         U3iNVhFPey7P1EpSnab1iw+X+4hWORkMeBiUYfCFum/Q0Gwc7jpTHTJsGpCv9ST6EH6R
         kGUqj57H/HaVdNN0WzKHeUY7L+8i8vHRv56McAdZGSwAKFOZp1ONLNgJqyryvyaM7pZ8
         qPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773578683; x=1774183483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aop73yiT+ozKM4wI5mCn8ig8U8LLjXCiOf/n0qnlsds=;
        b=jR4KeK1mpGpTmQL4/jEKQIGTy0oHbiVddm+lX3jgMbkmIv3cIZBz73u6jm3wjDImWg
         k63Kb2u9FLFwpZ0PdPCYSQ7l0z4yaJpBG8jwdEN+xtl0YtU3SnON9SIa22SAQsgyR6S/
         TlqytxpkVhrozZBpXc5rfEslzVWV65k+gOODgvC2OjRkU37ojgRfNNGaI4FsxlhrLgix
         QFDok/9cHKqnle2QiCxADHjZkq5D07ZA8K7AhSYcyySNDg6aVatKay5zhs7CBm0gYy34
         S/P3z5EmFgqJ8mah1ogKNXwpDDwJPH56zVN/1b08xPHgCVLH6Os3+r/Gz7IHDy2gm6hj
         usbg==
X-Gm-Message-State: AOJu0YwHD3zKVFmsW89GhdjIpoMqxiCFYQL9cA7Qfo9jwMG3TeOF3bIk
	m8VEZRNinPVOYvfu+TonjxL4+IYCHgdru81oxUbQ4LnXd4pbkakbagTbJoFjHpzE1BqSBZKoMnM
	bs5OxY6rfMYrYeuZQ0zZ0PUrMNLS6+PK/zzrNz60=
X-Gm-Gg: ATEYQzzNlrBLg8b5Ouf4DCC8XHfTaX0tj8GHNhP2rO6Z/xDk01OCfW/GmoMB9AszIj+
	0bTaLV722S7REbyA3eRLQWIs2hqGfnUehCoZpWx9hFEFHlpWrhUMKQloq2cQIX87pWY7W4bqmMD
	UX6OyH/bB6CnoAYa1nrq3VMO6AD/a2wIit4H1uEaygeTT1WUAp1QmX4lK4NjMUALrbr/2gYvzEx
	RW8kEOjQpU5C8UBgnJtzQIvmGfUcgP77RtNXhD5YSxinfEyCqnjG8LnO+Auc1ssp+QIi8iD7Q4N
	d89FYumZbFAyRvbQa8RFI/zb81BL1zOPmVwThwOBuAXpzhHHXTxJqHXCLmZ9QU4riu+Yi5IJFDH
	aK5qND9AQw9LTpRisyn7Hv4IH64wSq0CVgHrGZWZNsaBbTygE9FkLDXqRvD4VacsvPhLKxt9fJM
	dbsCjOLA==
X-Received: by 2002:a05:6102:26c7:b0:5ff:11dc:2ed7 with SMTP id
 ada2fe7eead31-6020d4d1d38mr4059918137.16.1773578683330; Sun, 15 Mar 2026
 05:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOAgETOX815iJcsZOjVSYXr+o-uSkkAkEJ3FE2xkt1ODBaOUmg@mail.gmail.com>
 <CALE2CrTWMcMOPoWH8HEN_Z8_H1tdhdN2a6hN9BkJ4xs=0DN3Xw@mail.gmail.com>
In-Reply-To: <CALE2CrTWMcMOPoWH8HEN_Z8_H1tdhdN2a6hN9BkJ4xs=0DN3Xw@mail.gmail.com>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Sun, 15 Mar 2026 18:14:32 +0530
X-Gm-Features: AaiRm51nP_nyLKKLTppe_q2jlfltsFtmmacUt0d-9pZHb1RXSwRt_u7LviZ7TWY
Message-ID: <CAOAgETPhYra3XrevHptFu0x-se8D9ovRtgfomwFbhq9rSTXu6A@mail.gmail.com>
Subject: Re: [GSOC 2026] Proposal Draft: Improving Git Advice Messages
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:

> It would be better to share the proposal in plain text
> That makes it easier for reviewers to read inline and give feedback
> directly on specific parts.

Thank you so much for the quick reply. The draft is as follows:-

Name and Contact Information:-
Preferred Name: Arsh
Full Name: Arsh Srivastava
Email: arshsrivastava00@gmail.com
GitHub: https://github.com/arshsrivastava00
Micro-Project Contribution: https://github.com/git/git/pull/2233

Title:-
Refining Git Advice Messages for Common Error Scenarios

Synopsis :-
Git provides guidance through optional advice messages when
operations fail or when repository states require user attention.
While these hints are
technically accurate, some messages assume familiarity with Git concepts an=
d
may leave users unsure about the safest next step. This project
proposes refining advice messages
across common Git commands such as checkout, push, merge, and rebase.
The goal is to improve clarity while preserving Git=E2=80=99s philosophy of
concise, script-friendly terminal output.

Benefits to the Community:-
- Improve Git=E2=80=99s usability by making advice messages easier to under=
stand.
- Help beginners recover from common errors more confidently and efficientl=
y.
- Maintain concise and safe workflows aligned with Git=E2=80=99s philosophy=
.
- Improve consistency across Git commands so that they don=E2=80=99t look v=
ery long.
- Contribute incremental improvements that can be easily reviewed and
merged upstream

Deliverables:-
- Audit existing advice messages across key Git commands.
- Identify 12=E2=80=9315 scenarios where wording improvements could improve=
 clarity.
- Refine message wording without increasing verbosity.
- Submit a patch series for each improvement.
- Update related tests in the Git test suite.
- Provide documentation updates where needed

Proposed Timeline:-
Weeks 1=E2=80=932: Review advice paths and finalize scenarios.
Weeks 3=E2=80=934: Improve checkout-related advice messages.
Weeks 5=E2=80=936: Improve push-related advice messages.
Weeks 7=E2=80=938: Refine merge and rebase advice.
Weeks 9=E2=80=9310: Address remaining scenarios and ensure consistency.
Week 11: Documentation and cleanup.
Week 12: Address review feedback and finalize patch series.
(if the timeline looks longer I considered Hofstadter's law and gave more s=
pace
so that work is complete on time)

Related Work:-
Git already includes an advice system implemented primarily in advice.c and
controlled through configuration options such as advice.*.
Previous work in the Git project has focused on improving command
consistency and repository integrity checks. This project builds on the
existing advice infrastructure and focuses on refining message wording
rather than introducing new mechanisms which would have complicated the
current git advice system even more.

Biographical Information:-
I am Arsh Srivastava. I am a developer interested in open-source systems an=
d
developer tools. I have also mentored in SWoC and worked on many more open
source projects such as google-deepmind and opencv. I am currently in my 3 =
year
of college where I am studying and I have always been curious and am known =
for
good communication skills and for a creative mind.

On Sun, 15 Mar 2026 at 18:01, Pushkar Singh
<pushkarkumarsingh1970@gmail.com> wrote:
>
> Hi Arsh,
>
> > A rough draft of the proposal is attached below.
> >
> > I would greatly appreciate any feedback on whether this direction
> > would be useful.
>
> It would be better to share the proposal in plain text on the mailing
> list instead of attaching a PDF.
> That makes it easier for reviewers to read inline and give feedback
> directly on specific parts.
>
> Best,
> Pushkar
