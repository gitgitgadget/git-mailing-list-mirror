Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B448346ACC
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399787; cv=pass; b=KFdN7x/Nc+C+5n9yeYt44vvpNc6Y57PowOlQ9uqvfN7X7FwVT6AI/E3OWxXFPf4mmZTpSuT5DrjtOjy/+SWAwiyEDA2PYyDb4Hz3rQTTak2Vt2aVdSvpwHrR6sbJqn8nUtayUQ8rZ/2+bVqKxC/wlt/fKTL4XJ1mjKRxaOjYhgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399787; c=relaxed/simple;
	bh=JJV4AlyN5309bMiA1y8NIkUdjVvi6iNr2r4D6rLw63o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEVG0LsTt65VdxrwKRShoLcO3g7gbUTCaR6pd3Mq+pTai6gAI21mlyVlB22JbLvebMFOLvgOxpc5WMdF2v1BMEK+F8/OBtAHb4Eh3VCYg6DfsVz8D6uizDVXrnhA4MvzFDclMPddr912tS7Vduui5652+t+52ntyALb6tpVO8g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOMwsciT; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOMwsciT"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5fff77ff6ddso424987137.1
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 04:03:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773399784; cv=none;
        d=google.com; s=arc-20240605;
        b=ia5hXGL9NXZ3L10PXp5lF+3y1rfPqV9s+iJIk6YDkbsUWr23QvOOUmy9RbBGQrNzW+
         VGuxEoan9D6fM1kkdpRYQ3T8B70pYhrwzBIFbRN5HzfkVjz/yKYVXhicIYv3LDhioSOj
         7LUyDotadfKKYyyKUDSKtYR6y288NSLsjwezW8rJUDM13o9ZM1u8PUaX3p822euHAX6e
         ZphbYWRSeBMrKPi2Ub5qzxRMUE/V9e9BKzhGI+R2zXOFm0JNvp6gm5E1wSh4NPOb9Z/w
         3TMFv5v42ohp5xhTVFWFyNuOPr+BaO0SsHf2h+C5UEb0Iv9YBcn/TSa+ml7TmAYIXYvl
         fsqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2lR2FA8wsJdw9oHUdo6JypXO2NiEKg/R9yoO2fr8Vls=;
        fh=3x1lxuwP2AOrrTJGqlTXXn0ycGoZzXJtolRZdEVh2Zw=;
        b=UiH7JCssfp3oR5gC8xl/yu9U0T5N8rNB7XjF91tDrSnwWQ8zvvR9tPWZerMFS3hK3N
         xWVFhhSYs0xPFiZtjBT5LfVC1yBLM1yDM1VYQyijo4aOliIjZQ3m7GOQvnc+V3sYbpE1
         ZwtLlV1pfuJNG1E2bJnyug9yWiP83IasA0KLm6NTiSjIKte1jY0lwiBXNRZBsf5PI2OL
         /1o78lGQ2ztcWe/lmsvIROMAatUC531CmOAM1GgQSVV2/LmRs4E30zjmTWdcbH6j/ErO
         IiwE7/l6rvJPzzNptkpcmmjPoix15h6F5kgZtBq0IMTUsx5J+vNKdq9Oji6PCW8kWQiz
         RcPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773399784; x=1774004584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lR2FA8wsJdw9oHUdo6JypXO2NiEKg/R9yoO2fr8Vls=;
        b=iOMwsciTlzE4q+HGaSqVmoEJb2cUVrOHMt81M3CmTJ8yNWXfI7xeUAeE/63wSpbICn
         i83B97PDGVLe7P6Ko3xabTzPlzdyUk76QTNVcHPyNISXcHfvLvNz1rKUf4HMauB+POCM
         BiJyhCM6ofHL7pcqWQYQ+rMsRk87Yr7rZPQKDFTEuzx5AFQJnFW3PqdzbsLon5QVP8VN
         eZNkHMA3fiUwVson1mlAru6vXWXIlA3lEAkEmEpoWX3wzoftJY7aedaluRNuGnWiPflK
         25b44vgXqFV5UgcAWDCgTlCsqNlkE9OixFkGrWe3BvCLJhSNuSqpLwFxLoPlqfTzGlxS
         rbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773399784; x=1774004584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2lR2FA8wsJdw9oHUdo6JypXO2NiEKg/R9yoO2fr8Vls=;
        b=EGhqQD5sUDG2PgmZVv84prkQ9TNBp6b7rCntf18P96yF9ByI5y0AeYwKWrWBRpJpLK
         EQEZUT9FiKpMDbuYGiRL2dspEtMWOesI93PlUpTjX+K3xijJVADVPC+O64TV+vwuU+Lo
         MwI/bs+NWR0x8B8K+j7mMXqLbfJoHqrkxgOJeWO1LolCcyD32XnVftpGS6c5OI+tcz+5
         fvSlWwLsf0pKsYua9e/ItukKk+SBBGZgDJ1eu7ILDQ6DRr18VyqcRENaoiu+09YsqBid
         yxPkQo6En4515uQp1Ht5FM5qtNe0oDG+ZndmNV7FFFeSCaj5vZw4E0uYsSotFVPStRlD
         kzow==
X-Forwarded-Encrypted: i=1; AJvYcCU9ZIPPd3HGuL6yveuAHrjgDpT7xXvV/R7bOB6g5YKtG15rUolcuTVi2wUUxwO0Of5nm0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjQFgp2YuEWGXXz2KvmRFhtMmJi4EtIHtSvz/McA/H1bUQ+PNa
	2Se9PI+Hnsu5FEU+Dx9BN5KubvmYngMBxgLSCyzu3ZOXlNPGi5ksFoMMH7OyI6qnjppPuaQcreX
	nN4cxzrK1ScsB+D5zUzQQuTiKvSo+XXI=
X-Gm-Gg: ATEYQzy1FhibIehbx+eNl3XMkXDACR9nFnBoNGHSHEfbkV/LIZLjo5++nxIUM9KYA2f
	Sefr2xkBsPNqLuFccHEQQfr8V/Zl1TZbC8vQhldvZRDXYMEn9Wc2wLxGNQvBOxUj7IqD/elVa85
	D+cMitlXKRmDt/SpIGFbkKbvSTi+20/M6hNW26BsHAH4FEr48R6Y2BjG6NGoSpXrxO0ywAauwlP
	EfRBPFPvQYujaOH0erRjC7nCjRb1zbA0Gl87c7POa+M6BTgSsU735eyiYMtEA11WFZbEGJstvdb
	MY1AZKc8qqWiwJ+fxZek3b1ZGo5506ME1n290livD0/N4ktNHn+WuAJQibs0OCU+r7K62IpEd/9
	IL76oJvU3vA63GdPhS/CXTVlbyjsmdL+A2x9/0CqpJcBd0nhbzqSyxeG1mSibocCxVH7VgE+X70
	0zTWDP
X-Received: by 2002:a05:6102:38ca:b0:5ff:1130:bdad with SMTP id
 ada2fe7eead31-6020e212d86mr1048387137.6.1773399783984; Fri, 13 Mar 2026
 04:03:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2233.v6.git.git.1773288013936.gitgitgadget@gmail.com>
 <pull.2233.v7.git.git.1773345901659.gitgitgadget@gmail.com>
 <xmqqldfwacyw.fsf@gitster.g> <CAOAgETMCb++MnOC9YEN+y0TE9NeVC+-=Zez7UOVY3kt8vv7dRQ@mail.gmail.com>
 <CAOLa=ZTJ1u+cyVZyOGQbdOniK+U3CGrYSJRaeecYsT9+D8gWFQ@mail.gmail.com>
In-Reply-To: <CAOLa=ZTJ1u+cyVZyOGQbdOniK+U3CGrYSJRaeecYsT9+D8gWFQ@mail.gmail.com>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Fri, 13 Mar 2026 16:32:50 +0530
X-Gm-Features: AaiRm52ll9U2XRxUdXYeR3u7rjxbjI3ANFDpYNpkhDT3muQC6ooi4f5a8_Xzo9A
Message-ID: <CAOAgETNZ4HJrhDnc70k1RzCaGaajHDK-esqN+kwLj4xkRbaddQ@mail.gmail.com>
Subject: Re: [PATCH v7] unpack-trees: suggest using 'git stash' when checkout fails
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Karthik Nayak <karthik.188@gmail.com> writes :

>  We don=E2=80=99t require that your patch be accepted into the
>  =E2=80=9Cmaster=E2=80=9D branch by the time of your formal application

Understandable

> we mostly want to see that you have a basic level of
> competence and especially the
> ability to interact with the other Git developers.

Truly this is something that is very important in any
organization.

> As such and seeing Junio's previous response, I would say that no
> further work is required here.

Thank you so much for your valuable guidance, I will now
draft a formal proposal for GSoC and I look forward to working
with you in the future too. :)

On Fri, 13 Mar 2026 at 16:13, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> Arsh Srivastava <arshsrivastava00@gmail.com> writes:
>
> > Junio C Hamano <gitster@pobox.com> writes :
> >
> >> The first paragraph is a bit of a run-on and has a misplaced "and";
> >> I cannot quite read and understand this overly long single sentence.
> >> Perhaps the early part can become a bit easier to read with
> > punctuations, and cutting the sentence into two, e.g.,
> >
> > In my future commits I will remember to make it as easy to read as poss=
ible.
> > With less punctuations and shorter sentences which will in turn make it=
 more
> > concise.
> >
> >> Also it is misleading to say "previous" error message.  We talk
> >> about the current code in the present tense, to highlight what the
> >> problem in the current code is.
> >
> > Understood I will in future not use previous because it is the
> > _current_ code.
> >
> >> You may view it as a weakness (which
> >> may motivate this patch to be written).  But I personally am not so
> >> sure that adding words to the existing message would necessarily
> >> make it more clear.
> >
> > I understand, git wants people to not explore the available
> > change options and help them make logical decisions rather
> > than pushing them with some unneeded commands.
> >
> >> As Documentation/SubmittingPatches says, let's instruct the code to
> >> "be like so" in imperative mood.  E.g., "Enhance the error
> >> message..." instead of "This patch enhances...".
> >
> > Understood that makes sense because nevertheless
> > it is given that I am writing the changes for this patch only.
> >
> >> These were already overly long, but the updated one is way too long
> >> to be read on end-user's terminal.  The source lines are overly
> >> long, too.
> >
> > That makes total sense.
> >
> >> to those users who decline the advice, we now show "Please
> >> commit...".  That is not what !advice_enabled() should trigger, is
> >> it?
> >
> > Thank you so much for your guidance the advice should not
> > trigger to those who have opted not to see.
> > My code might have misjudged this paradigm.
> >
> >> Also "To move you" -> "To move your".
> >
> > I thought I had fixed this typo. Seems like I didn't.
> > I will remember to be more cautious next time.
> >
> >> Also the advice lost the other possiblity of first committing the
> >> work in progress on the original branch before switching, yet the
> >> new advice message is quite wordy.
> >
> > Absolutely correct this commit does narrow the users vision
> > for exploring.
> >
> >> Also, using "for safe merge" when the user is performing a
> >> "checkout" might be slightly confusing, even if 'stash pop' involves
> >> a merge under the hood.
> >
> > I don't want to sound like a programmed robot but I absolutely
> > agree with the recommendations.
> >
> >> But as I already said, I think the current text may already strike
> >> the right balance between being clear and being concise.
> >
> > Thank you so much for your valuable guidance.
> > If it's possible I want some guidance over the questions written below,
> > As it is well stated by you that the current
> > text is clear enough.
> > Should I still work on this PR from a purely GSoC
> > perspective. Or should I start making my proposal or
> > still work on this PR until my micro project is merged?
> > Because I have already shown I can navigate git project which
> > was the goal of micro projects in the first place.
> >
>
> From the micro-project information [1] for GSoC we have:
>
>   The coding part of the microproject should be very small (say, 10-30
>   minutes). We don=E2=80=99t require that your patch be accepted into the
>   =E2=80=9Cmaster=E2=80=9D branch by the time of your formal application;=
 we mostly want
>   to see that you have a basic level of competence and especially the
>   ability to interact with the other Git developers.
>
> As such and seeing Junio's previous response, I would say that no
> further work is required here.
>
> [1]: https://git.github.io/General-Microproject-Information/
>
> [snip]
