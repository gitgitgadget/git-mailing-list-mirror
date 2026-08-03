Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C032DF128
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 01:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785719735; cv=pass; b=tWwosXjdplBVQfmTL1xDTJeNSvbqxHCgass6RexYrjztLdS9Nf69OH1/C2Qyt3+fM3u2wvFE3CaiNpXsefRlUIFeE27nU6Jm/IP0wtChZJS90SUQP7jX5hzyd2qx7BUGPa6gl9P6ntW2EVYtZki2W64LX2+9OkZuTisoa2dsAAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785719735; c=relaxed/simple;
	bh=DnsLGZo2w4xEjSLYqnsFFQzT8Ogh7HxkAawuB8QvRC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRsEqFEI+TmaJWRBbVYOyJVsQQWwknj/UQyr4Jkp6qFA5rMxPaoo7pecR122yrZQyu5KIore0aWSQcqhQJDBYeHdfx7UkXPeF8xyXUNL3/5DgYj+5ZUBd73DMdpH8K2EDXoRKaPw8ApS49j4DiHlWKzDXeMCjwiJBMfmVt0vLfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQkc6OfB; arc=pass smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQkc6OfB"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4ab47c40e7eso881321b6e.3
        for <git@vger.kernel.org>; Sun, 02 Aug 2026 18:15:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785719733; cv=none;
        d=google.com; s=arc-20260327;
        b=O2WxslREZlvrCNlzfHqNWS08l+0N2jlR4OqD1mAe/g2lTVep+tFgqSBbD61DvIKU/+
         pt77adj8v78wYEOUaXjrPgREd7UAp5jvwx/2iSSjAa6n9Qi0K234al80lk+k17oOyIhP
         vqg+Ww9P6dGcMobOomwb7jYr03rk6IhGC6m+zbQpfghKEjf/PdcAfqqaMjeG0bXIR6JZ
         Ehb/paXKLnk2Qr7DlbAZV+vCcTym5WxMSqQlnNzEoWzI8ADxJWfO0jMqHwEE8O+DKSB0
         WBVEhqPTnszXhi3Byj+AXH1p2J/dNbcVPSMXuoGVlmsd/2LVKaR95znYvjBEqtPVoPo8
         aACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OygvHSB6X1wqoNiZpJcbiDax6wHBBF9Xh4zRs9JmXjA=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=Y/a7CtnsX1638H20xvfnXpjGAyNWY7/3M9V+bN4/fvDRO1NiMg6/ZlCs7E8cZVqdDS
         P5MkR2kst7sis9frSiyGbspNTqMh0w43f3OMgG5BBPOf50WdRtTxFuATymyaPROT3gAt
         sR5IMohaJx8EHRQdFsHNQAulp38EKAYeVjL6ia+N31brvLWepSqOzM456UQ0PBDASCnP
         pRUZBAHPUupC9H/iVmSx6YB2+uSs6pHLs1NUZt0F10ZCo6ZTtMyZ9zhawnZPkKMdGE8E
         BaU9JS6BwPKY5K+YjWMCLagFALzpJm8h9dQx7RQn0weSHFwKQdSxT06ILBcD+BvBPkSP
         O47w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785719733; x=1786324533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OygvHSB6X1wqoNiZpJcbiDax6wHBBF9Xh4zRs9JmXjA=;
        b=TQkc6OfBXtutBvl5eiGVzdki/UJhVyGV1Raw/KoISFzuLFLTKob9X240XPFdqbdb1j
         qTVn8X021tD2c5yO3t8gaiMuzOzG67o6BwEuHfDj5VXtkaAPLHEw5M/67GvZ7+tlmgiG
         +jlT+6lIZyV479iHjgAicvbk9Z0IT8R7Iq6Rn8hj6utA2/+wdZokdTKS6FoYu4ddK2Zn
         f7KyVaya1MuTOWao5cRXqZwiQlcmyEfPUqGlxK3BxLniKjj1Ey0CWcoO09AZnrxk9hTl
         pG4zA4wlWfsP6QfkJOFJnkTXX/O9ZjZAp6NieOE/vht0gu9N6Kl1/dLXdKR4m6HMaMas
         5WCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785719733; x=1786324533;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OygvHSB6X1wqoNiZpJcbiDax6wHBBF9Xh4zRs9JmXjA=;
        b=X5HnFpTtMnN8ZEiGepjIEaB/uhNlbiM0vbPDpl5Bp3sSI2PzB5ENz44r6PRLtXiG9z
         p0hVkKMqK+06wRRh8gV37GjUV1F5WjcmzYqj9EkoM6NKWt6XprtPse2LAqt1BLQSS21B
         ICUsZ9Dzqnk/JclRn/r4X31Y6PtZrEmxD9kJL/kSRuDbD+4z0zofbj6I2mgziqIFDpLk
         QCPYRDGcGP8fp+K08pXZvVgisaMb0pKqHHn0Sw1r1rzDjAIA+wBuRX/kC7jjRNoaF5Jp
         It9wt6JaDygxoOnYvs2sLPQzhIms9TQLm0r5SxLm8Ik+0TUgTJSGtXLH+FTQwDv4H6Pj
         9ZIg==
X-Gm-Message-State: AOJu0Yz51mIvy1r5XcAiJQHR1ZcLpMeGTVtZvcg49raFSf3Tj4CEhtTN
	DDMZSvIF7OTmrB7HVR2bEWNl0+Vkr7ikL2efrvby34OWrk96mxe1U5uJ5aA0e6Z8NEXLpvySyif
	y2I9BGApsACQatO2lspF9YD4N41+0ZdsY1EIH
X-Gm-Gg: AR+sD13Ib5TsmHk1e6nXDtpTxCc24RiwaYUbK93Pcvunf1u/Aqm2+NMr6giq4VQtLmg
	8aOEtmmhqyzOaklJhWv/fSicfNqpbIt2lOZ6qlStU02Iqza7aJxsujodLjpTF/LE2gq3Wvu8Qfd
	M5dUn66Me9yyjKMW7+dn0DLOq5LeUjsZMt5kl0gzm01BBhvxmNYJE5ByCMNQMu452VSgBvAiNNa
	plptIy8HZuxcAdkfJuheU4zZhueWJPpCJGczAX+NIBPg3vCNhnKkMdwrOR6wXyqpqbtMni4CHR3
	fcE0ndfvux9hppqkYs23YP4o/SkYupRzuxgd5Rx5m+PwSwgNyCVDm/AUAMnJD4ymRA6kbJghFGN
	+S/kHGQSMvThwGuQTZ7tYkuRJia/3sMVr0WJslb457wjwj9JYvBbniRYGatbmjQk=
X-Received: by 2002:a05:6808:344b:b0:497:e7e2:756e with SMTP id
 5614622812f47-4af5e1d35cbmr12446085b6e.13.1785719732766; Sun, 02 Aug 2026
 18:15:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728215219.753678-1-gitster@pobox.com> <20260728215219.753678-4-gitster@pobox.com>
 <xmqqse51algy.fsf@gitster.g> <CAC2QwmJeohdnWhUbcP6Pc5w1X8yZf3jXvpR8JC=Hb9gqkFF6ig@mail.gmail.com>
 <xmqqfr0w2lnt.fsf@gitster.g>
In-Reply-To: <xmqqfr0w2lnt.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sun, 2 Aug 2026 18:15:20 -0700
X-Gm-Features: AUfX_myb2S5lIPXAw8GF-54IHabQ0lcKn31ALNdhR8Bi8jx0g1RQnRn3gAcfGok
Message-ID: <CAC2Qwm+4qnAdUpinbda+etnFYUaYkycW-0HasHo95MM3rPY3yA@mail.gmail.com>
Subject: Re: [PATCH 3/4] add: introduce '--resolved' option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 3:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
>
> If we misidentify early, that is a desirable outcome, isn't it?
>
> We did not have to scan much and we gave control back to the user as
> soon as we saw "<<<<<<", telling them that we refused to add the path
> to the index, so that the user can inspect the situation more
> deeply.  In this application, false positives are much better than
> false negatives, and failing early is better than failing late.
>

I didn't fully consider the case of the false negative that would come
with switching the order of the checks. I agree false positives are
much better in this scenario.

> So, no, I do not think so, even though in practice I do not think it
> would matter either way.
>
> A question that may have much more impact is whether the attribute
> system should have any say in this code path.  I am somewhat torn on
> this.

I do think something in that direction might make things more clear. When
looking at "has_conflict_markers()" in isolation my instinct was to guard
against the case that the file is binary (among other "easy" checks to
eliminate non-conflict marker paths upfront) and return right away. That re=
sted
on the assumption the check for a binary file had an unambiguous result as
opposed to being a heuristic.

Would it be possible to check the merge driver used and return early if a
non-text driver was used? I tried tracing the path where conflict markers e=
nd
up being generated and it seems like the binary and union drivers cannot
emit conflict markers. That might be conceptually more straightforward and
eliminate the need for a "buffer_is_binary()" check. Not sure if that would=
 be
brittle in the face of new merge drivers being added, but directly relating
this conflict marker check with the drivers that emit those markers seems t=
o
make sense to me.
