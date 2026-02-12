Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8D0261B92
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770934848; cv=pass; b=jT3uah/yjsxwMddkuCgJsmmKSWVgSIRaFfX4K9WAZQ9QQfsShgxWWIwfnIHk0aYc5GJJqzRfq0aE5MCdTLRLH5iYQSxIs0DCPYRMHYN/e75gIAkNcTOKi3abze0DbOfdaDWgZ1nCVaz8vxcMpQHiHqya7NPgCrJTrMAm5ALxpYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770934848; c=relaxed/simple;
	bh=GgsOwnhyW47UYPKBKi6/fq9WKvc7xnx0DdR53La5PR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipS/PZcZESjaAVlI4upkD9yGjwF0B1WX0ErnZJEOnkk3o3uUIQrp5GvdodjQ79tQiiHvjamoS653FqS2+eQlTFY5NZsNoo6p+NOidgMmRzIcz+0kzaur1+l7efE4xsTAGQER2Stid5aB2LYeCLt/ZG8YGGXqA5mD6uW3C31F9fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnXr9/Go; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnXr9/Go"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-94ac3958788so204797241.0
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 14:20:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770934846; cv=none;
        d=google.com; s=arc-20240605;
        b=f4GfQRUaQGQvCquFkoEXd7KnIjG3eNSFQq3Wo5NHLAEstMIujQUKAm/2oF0wfnvQEV
         lvysj3iCfzD3d82V/8RuqDjPbnoax1ZDtRRB1yLePmk6iH+Mqwb7chKRJ2yYUxn4WUcP
         4BJEv3CPNgplv7yiaOtbMVkv7LxtV+BXSzq5SBuyec8R2FaGoRK0C31zX2NyD5MuicXy
         D7wWgYVJQB2k7fPetKvpe1QtFRtMi1W2K1Vknrun/NyoFwYd5OxFoVSjwE7YDokLZe7L
         0raCIWSiyCBGQ2jYrDWj7cKQ5bLPAuGE8uJS7OIz8NicFyqOCiIbtKh6Q6O/4t+cpzwA
         G6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=10pvNhIHsmhPaKE9pRvo41XcsXT+OWETrpvShTxMU6E=;
        fh=392ryK1TiLXjQymH8YuTlaSLgmX4+VbMxfQfkGuHyGc=;
        b=V42cdlIekObsH63ISFzwLkMXu7FQbL3UWOmlmam1UkOMl8xNgG4Ti5sMfK8jszyI5Z
         CkpM4DFKca7gtx67VXSPzC2/PbRspXXNoDjwR2SbQYh/VW/jmiJ4xUR76LG3oG4kVMPb
         SIQ+ArTLPItYPICscX9yWfTsjrVXUED2VZPaYiTwCaplFDkpbz2hQAkAiczcATmIkA0I
         MUrOUfmOQv9tqS0z5p2R0ee2D83Sw+CKsqaInQ9sKQFG+CNyPPhAgmNL9NYf6ab0A9qa
         YytIcNcpX+6bWTCid/wDt1X6Dl16KaOY2KOtl6X/3zjoiZNwKr8MEiJm4GFSjSdkMkIk
         J+cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770934846; x=1771539646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10pvNhIHsmhPaKE9pRvo41XcsXT+OWETrpvShTxMU6E=;
        b=SnXr9/GoonBvdybujwITHgMll2dYcQkUf8C84a9YDwHNtgcKahbEPza+ngZ0tjsh5Z
         FW2olOs2N5VQgzXKJPAo4cNkJkKHChmdxX6PsCJXCSoleNIo4TMSyMeBXlgBLKQ6k+VG
         lPuGC9ZuhiSdQ/wm8XiWIV8UzQwHMc0puYbsJsgCTDSKEuBR5t64gHmzFSA2Z6CASm5V
         QNC0qYFrwBg5KzXGBUQyhBnkk/2k7pfc4dQ8VJrH3jHSY2+jm06U7Laz9cPeB151Rmfr
         ClEYoum9y20ZixbDaFDCqvjEir18EAmNrxzSum3ZzuU/p38WHokGIafqi5/G5gzP095g
         CF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770934846; x=1771539646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=10pvNhIHsmhPaKE9pRvo41XcsXT+OWETrpvShTxMU6E=;
        b=azYy3s9BB9pVognZwe167H4Gp2q1mxrBgd/ov6bVLh8eHFSKWDu4b9wIVLBey8Pl6h
         HzSbvxWGxYWdkYyfqxtjQKlhr5i2iaetV41idQChxNk221m9+GW9Tx5nqUQmMN0uVr+l
         ZhLnzTqImz98yiHyFJhBAw7l7YfXm+BlbFERfnfzr79KNlQO5zZsSn/3O+I4LHXajpZz
         L+oG1+e/ht9ZYQBJYCAfBnrl9NXXUgQYKaIuLkFbfUJaK8eiyviaqSzWmmo8NsWMEkak
         ghe1ks/+E4JE9qrckGe7wB3TlB8ZvtJDylmv87oNvF2w2xw373HhAv2BD9aYJA06zQ9R
         DJ+g==
X-Gm-Message-State: AOJu0Yx9+RiMzCMjLa8sMmZdMdUkk+89vtAEfLN1Koz5AcHmnsfTxhAc
	djME4GnbLmK5/b5G7UbTzYiEi04x1fgSwF51eIHVnlz4bcI4IZbCWNCg9tjJm/jjUJIorwYWwO1
	0nvL8GHuNPM4AUqI6CLRYEPUb6Lgbc1k=
X-Gm-Gg: AZuq6aIMXipaOMr5qpCBaUZba7cqsMRw33WxR9IsYAQD1EkKi4H9+TzYRaw+xW8JECe
	4lIEbBHixXPIDw/v3xwDRPscXY//8dQKJN3dxUF5/3Ns9m3ylADg9zFUTVXeKc7Evr6u1hi6WFv
	eI/4rUizhM62+9mcCswyuZppWz6ulhoVWo4jEuuiI8JVe+g3baiTSUr6lTzJI2s3V5uv1L/xCQ4
	+YR1NzpD5Ybap6p1HzU9C2zZ0DcMOZYjb0o5IxY4+90pfdCt6kXf7k4qGvq3TFUBtSUaobEZexW
	mw6PRk/SkCjF
X-Received: by 2002:a05:6102:c89:b0:5f8:e41e:e5cc with SMTP id
 ada2fe7eead31-5fe16765c5amr135731137.9.1770934845894; Thu, 12 Feb 2026
 14:20:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770390576.git.abrahamadekunle50@gmail.com>
 <24692afa3f0a67d3f3eba776cc745287c5d71e94.1770390576.git.abrahamadekunle50@gmail.com>
 <xmqqikc9ekzz.fsf@gitster.g> <CADYq+fa81Uki0ZVta80VO=-UG-f+Z8GAyzom-FLNXULartwwXA@mail.gmail.com>
 <xmqqtsvlq3gr.fsf@gitster.g> <CADYq+fab0FKncE8VFJcaHA5VmrTJbrSo79jxA6x+Y5dkZP+2RQ@mail.gmail.com>
 <xmqqh5rlmywp.fsf@gitster.g>
In-Reply-To: <xmqqh5rlmywp.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Thu, 12 Feb 2026 23:20:47 +0100
X-Gm-Features: AZwV_QiNllqlNnrRLmNP-kKR2UPwYK1zBLOv3buZncF_pZcGkLfRT93rcv_Nfjk
Message-ID: <CADYq+fZ3b-bEBt_7B-KvGi9vyCOc6=pxVgx+Wbod-TM4oMaKog@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] add-patch: Allow interfile navigation when
 selecting hunks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 10:31=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Samuel Abraham <abrahamadekunle50@gmail.com> writes:
>
> >> There was a separate topic that added "(was: [yn])" to the prompt
> >> when the prompt asks about a hunk that already has been decided on.
> >> As we only need a single bit "all hunks decided", can we do
> >> something similar, I wonder?  At the beginning of the main prompt,
> >> we show which of the N available hunks we are currently at, e.g.,
> >>
> >>  (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?
> >>
> >> Perhaps we can add a third number to indicate how many of the
> >> available hunks the user has already decided, or something, that can
> >> be used to avoid this wasted line?  Or is it a good thing that we
> >> are loud in this case using a whole line to remind the user that it
> >> may be time to move on?  I dunno.
> >
> > I thought of a suggestion where after deciding on all hunks in the
> > file, the user
> > will be able to see the "what now prompt", the options for the current =
hunk and
> > also the previous decision on the hunk since at this point, all the
> > hunks would have been decided on.
> >
> > I tried something like
> >
> > What now? (was: n) [y,n,q,a,d,s,e,>,<,p,P,?]?
> >
> > This does not show the number of the hunk we are currently at and the
> > "Stage this hunk" since the decision had been made initially but the "w=
hatnow"
> > prompt still provides a chance to change the decision, while showing
> > the previous
> > decision on the hunk by asking "What now?" instead.
> > The options have the default [y,n,q,a,d] and the remaining options are =
populated
> > from the permit set for the hunk. SO the user can still carry out the
> > normal actions on
> > the hunk.
>
> I like the compactness of that myself, but I have to say that the
> end-users may feel lost and utterly confused with the distinction,
> if they are left without being explained why we switch between
> "Stage this" (which by the way changes phrasing depending on what
> you are doing) and "What now".

Yes I agree.

>
> Is it so important to indicate that everything in the hunk has been
> decided?  They'd lose 'j' 'k' when there no longer remains undecided
> ones, and every hunk they revisit with 'J' or 'K' would say (was: X),
> which may be a clue enough that they are done with the file, and
> when they really really wanted to make sure, perhaps they can type
> '?' and that help can spend a line to say "Out of 8 hunks, you have
> already decided to use 3 hunks, and skip 5 hunks" or something?
>
> I dunno.

Yes I also think this works.
It is not so important to indicate that everything has been decided.
The (was: X) shows that the hunk has been decided on and it
should be enough.
I will add the information to the help_patch section.
Thanks

Abraham
