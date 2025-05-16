Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80127257D
	for <git@vger.kernel.org>; Fri, 16 May 2025 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747415925; cv=none; b=tOxfzoCenzMnAJUPUFLrgs/2TTOLp73YMJqscSZyYI1ccQj6UUL8ukOyFEG8x9dNFeaZ9wrbyWrXivuw7fqYe2Wy3CqijtFkUYrq7NdXnw0+T42f19a9hTIa/lTVlTUVWYJrXoMGMo932JOVGpUWiNGgQivJ2oRGHSO7xmKtmiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747415925; c=relaxed/simple;
	bh=e8EgVwE+wrbPRIAZ4JYXDHv20QCG8AWdCiu6R9CzdDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sl2g6rMwgkfmdihCLehIGQhgaZlEpCBtxOn5HAkkOPx9BxSTfYHb/FPmuepgFRNVEj2DcMpnrKi5x9/cf5O3VUNrQs+bvyOq56wPnB2wvwTtw6LyCFacXvJJKH9Wx2JfHLA70GF2tWY86dcCOBkNDhl3e2TyrRabJ2cpMDUP1W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLJPtfZL; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLJPtfZL"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4769f3e19a9so16726501cf.0
        for <git@vger.kernel.org>; Fri, 16 May 2025 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747415922; x=1748020722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zX+qkwerbqw275/W26Rg23pWmu0woJxq9d5XPDJWnR4=;
        b=gLJPtfZLar0G7wuM036sa/NbdFGu47f87UWkbALogm/nHp2x0EUcGOJgg3l+UTrNHg
         Bu5Hz2RY+UyJYL8A1e64aHBu3k50hJSSql2UGVMUolMs9hj3eNk6pDOYFHLcyusm0niP
         9Pja9oC1sWhJiELAuSTDgT7ba2INGcLBM+/XrtOX8ToKvYAtkOoZBVNZKYl7dWCGghZN
         sgN28Do5G01lYjmLfNg+WYl/Z212t5IUJyCwr7NfYbyj9ZVl0V1fjGj3JpmRu4HsDwLN
         JnWiJ40Q5ws7zpwMpogFF1YMzw7o+MPakKi1/4zD8owGkUEsQDqji7w9EhyyyrAMKXwG
         QUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747415922; x=1748020722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zX+qkwerbqw275/W26Rg23pWmu0woJxq9d5XPDJWnR4=;
        b=GU2nxbwUMM5WbX4slsAaaxEq7emrtFSg6VUQMK8TAArVEXE1gElPjdEz0TeHDz1XCk
         v9TsH+ibbV9hsS3KqHmDPB25HI6pPXn4HcZu53OpaI6chvC6JKgSGk9JnQFsMeaZtW8A
         WiQfGFRu2HS/CNfVI1Iq7ZlmwdsaIMYUDWyCemvJi0B/zuuYXMzvkin8rcatbqhXR+5Y
         ySLxY/xzbc69xS/rGXgWaKWI+ZHdu4qTdEXCAPLHKvxILFpjUDKQytLFasioUpQi3Nz1
         DQgm2sqj1v93bFXwZaqq+f6KCB/1sOmfhEMIAuqQfr9pvXq6bYSpFM0GBtOl1bXSzYKG
         +FYA==
X-Forwarded-Encrypted: i=1; AJvYcCVhXSpXsF8XTLCggH4Mp6R7dbb9SKg/sdxMJUmJNeCDx9+1BzelxsnQFokuJF7p/A2Ag4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Y/WMYsTi1bwi2HG2fyHhxAxIrIzlqKtB913mLuZMvCS6vKIN
	g+Ux8BuS5ZDkehPxlDUC+o5TIeJdEawfwuwf37YSqivFTiPbnGDJWFjLfIS529SeFEcVcBwFqsk
	qNH1Zcl2cnVZe5cdEVcHjHtrXCT0NJVs=
X-Gm-Gg: ASbGncuRezh5XyvjCK3pYYFa6NdHPQ5x9LDyAHJADvOhsH33nxQy57OPI9nwxf1u+ma
	t0AFn9u5F2cLdbzTfgUi8zG7FXIRXJOv/fFXaHZoJd/oKd6oDylJz3WsJddwfpO+q8HuWgVXE7a
	Gtqkg7af9WyoVpPyC8W9cSV9IdEnvOkA4jGxBwXd66NgEcX11nZmQr+NKbWqLbZFiE
X-Google-Smtp-Source: AGHT+IFBwq4r6s36fOqrLBxnbV3QVBWljQgVk4ORRsnn+gcZNyvBaRTO6Sm/Uj/mkDJ/D2gYOPUzjNYi037XX4sc0FY=
X-Received: by 2002:a05:622a:2619:b0:476:ac73:c3f3 with SMTP id
 d75a77b69052e-494ae350226mr79781871cf.1.1747415922112; Fri, 16 May 2025
 10:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
 <xmqqr01si441.fsf@gitster.g> <CA+rGoLfbshrkPvvQorMq4n1RkVnyL8XfJ9UjMFRA-6dG4QKdcw@mail.gmail.com>
 <xmqqtt5ncq87.fsf@gitster.g> <CA+rGoLfcJ2r8S515msG5L-59=0nOBvdOX2TTn+-iaHw8v6Ndtw@mail.gmail.com>
 <CAJoAoZnYOjqgeW8Stuj5T9qcxmUBE=_j_ufO8Hdbn3GV8LmMzA@mail.gmail.com>
 <CA+rGoLf7jf5r3C2mN7X84HNrWqsA9mMueEkCowm7Ftsgcd5EbQ@mail.gmail.com> <xmqqmsbcwn6t.fsf@gitster.g>
In-Reply-To: <xmqqmsbcwn6t.fsf@gitster.g>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Fri, 16 May 2025 22:48:30 +0530
X-Gm-Features: AX0GCFtPfuHmUKtYFnrAWg5MKXLhFcuXHCUiMXhvRwDD9gztGmdgDUQ6__vEGl0
Message-ID: <CA+rGoLfFVcUFctoEx6wshovGnRW8pTW--ZB42ntd01VHMJm_Rw@mail.gmail.com>
Subject: Re: [PATCH 0/4] update MyFirstContribution with current code base
To: Junio C Hamano <gitster@pobox.com>
Cc: Emily Shaffer <nasamuffin@google.com>, git@vger.kernel.org, 
	levraiphilippeblain@gmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Eric Sunshine <sunshine@sunshineco.com>, Todd Zullinger <tmz@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 9:41=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:
>
> > On Fri, May 16, 2025 at 4:09=E2=80=AFAM Emily Shaffer <nasamuffin@googl=
e.com> wrote:
> >
> >> Mostly I lurk these days :) I do still keep an eye on the list. Will
> >> happily take a look at your series tomorrow, I'm out of time for
> >> today. But per what I mention below, if you don't hear from me, please
> >> don't feel blocked by the review, as I think the MyFirstContribution
> >> doc is comfortably maintained by the whole project by now.
> >>
> >
> > Understood!! thanks for letting me know
> >
> >> > So for now I will cc Philippe
> >>
> >> For what it's worth, I don't think it is harmful to CC people even if
> >> they will be inactive. CCing someone is not necessarily the same thing
> >> as saying that person needs to approve your code change, right? So I
> >> don't see the harm in CCing with low expectations - in fact, in my
> >> case it would help make the email stand out, so you'd be more likely
> >> to get a review from me (I missed this thread going by initially).
> >>
> >>
> >
> > Oh, ok I will keep that in mind next time.
> >
> >>  - Emily
> >
> > Thank you,
>
> Thanks for a pleasant conversation; others can also learn from this
> exchange, hopefully.  In Documentation/SubmittingPatches we have
> "Choosing your reviewers" section lacks anything more concrete than
> "who are involved in the area you are touching", and those who use
> common sense may say, just like you did, "ah, most of the text I am
> replacing was written N years ago by person X, whom I no longer see
> on the list very often" and decide to omit it.  Perhaps we would
> want to enhance the text there somewhat?  I dunno.
>

Agreed even a single practical example in the "Choosing your
reviewers" section of SubmittingPatches could guide contributors
better.
I'd be happy to draft a patch that adds such a line, based on this
thread=E2=80=99s discussion.

> Since there were discussions on contrib/contacts recently (a few of
> the participants there added to CC), I tried it and unfortunately I
> was not very impressed by its output [*].
>
> After applying the four patches on top of 'master', you'd run the
> tool like so:
>
>     $ contrib/contacts/git-contacts master..
>     Jonathan Nieder <jrnieder@gmail.com>
>     Jacob Stopak <jacob@initialcommit.io>
>     Jeff King <peff@peff.net>
>     Jean-No=C3=ABl Avila <jn.avila@free.fr>
>     Emily Shaffer <nasamuffin@google.com>
>     Atharva Raykar <raykar.ath@gmail.com>
>     Junio C Hamano <gitster@pobox.com>
>     Todd Zullinger <tmz@pobox.com>
>     Kyle Lippincott <spectral@google.com>
>
> The tool gave output in a different order every time it was run.  It
> wasn't obvious what the ordering meant.
>
> By looking at its source, I can tell that the names and addresses
> are collected from trailers like reported-by, which are counted with
> the same importance as the authorship, that the reason why the
> output is different each time it is run is due to use of keys %hash
> in a Perl script, etc., but counting sign-off would mean that I'd be
> summoned for each and every change related in this project, which
> would not be very productive use of everybody's time.
>

Agreed, but I don't know if there are any projects where there are no
authorship names
and direct commit details.
Or maybe there are two commits where it must create more confusion.

> And it of course is not clear who are still active in the recent
> past and why the name was in the list (it would not be as productive
> to ask for a review from somebody who was listed for reporting many
> problems in the area affected by the proposed patch than those who
> wrote the original) from this output.  There may want an "explain"
> mode that lets you feed a patch and get observations like:
>
>     The majority of lines you are touching haven't changed much
>     since person X wrote commit W 5 years ago, and the text turned
>     into current shape with contributions by person Y and Z.  Here
>     are the URLs into the lore archive for the discussion that you
>     can see how X, Y, and Z participated in the original before you
>     touched.  You may also want to look at commit V and U as well.
>
>     Last time we saw person X, Y, and Z on the list were ..., here
>     are the URLs into the lore archive.
>
> Perhaps some AI minded folks can write such a service for us ;-)?
>

If we're talking about AI approaches, I do think this could be
feasible with LLMs. I imagine a pipeline where:
A patch is parsed and matched to the line-level history (via git blame
or log -L)

The commit history is summarized to extract contributor roles
Activity is cross-checked on lore.kernel.org
An LLM generates human-readable explanations with references and
confidence indicators

Of course, the risk of hallucinations is real but with a properly
curated context (e.g., logs and emails as input, strict templates), I
think we can keep it grounded.
I'd like to prototype such a tool and would value the list's feedback
on this idea.

Also I think this idea would only make sense as a seperated solution
and not adding in Git
because it would cost a lot of compute to run LLMs locally, or perhaps like
email the way we add config on the before hand, (if we are combining
with git) giving people an option to add an API to their LLM would
work
But this is just a vague idea.

Thanks again and truly find this thread constructive.


>
> [Footnote]
>
>  * I didn't try other alternatives which I didn't have, and the
>    other thread there was a mention of "git related" with "seems
>    like rather more work".
>
>    cf. https://lore.kernel.org/git/aBr9bwNQ1J46NNXI@pks.im/



-Jayatheerth
