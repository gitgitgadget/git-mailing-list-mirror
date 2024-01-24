Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33C3FBFC
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706079065; cv=none; b=RvyiLJ2wElZ03Rhw/jqj+J9yk1706R10fvvSe26A6bk6ta40laV27vARpAbuCUZZyfbGUmhSsOZh+LomwxMer08IGzMg37s8zpk/DLfbWLPG2cPKdWTozuvjodWxgf7Q+3DzGlHxUVrI9nGvkEMZA8f4pX3jXAfeR/T56ZwkqwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706079065; c=relaxed/simple;
	bh=27pwyTnMvbRwjGICghF/CRguHWbfZS/gmYIds3lCezA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSpR9BQJ0GdNttLH1DRpMl/qqMnDES0kaj33jqdtbScq/3gtosOE3cjKA/YWPVhQ0DHs/ZJ9vnembsdb7i72gNCjHxew5KqXH8RAnFO+6cKFZ+p1Ue+kuSGA3BlMGtjg42YP5NTocVF+1cKn4mttZdnbRMv/Dw+kDP/VOD14pWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCuKWRGN; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCuKWRGN"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso6378787e87.2
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 22:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706079062; x=1706683862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiXlBAY01JdJ2qkSWxd7triz1qeIHF28iJql8oMFaDc=;
        b=gCuKWRGNpRvb+HB2uW9BzwJ2TyxWveqIRO0ENFV/tUvbCdsKfGTIPlrhk6nGWB7vn6
         0Dt7iX/NhICzw6cWdyHdklgoFTzEvYvLYllFjAHqV1Utnv6kslfg0LGlWyXOAUY/ZSja
         sd/s3uMU+ItsucVGuaZDBIA5xpO2lW1wBRlePrm+tdQgbjJRgs5tD8jDI8Hwn01okvga
         IqnWBtphkCHvMXNRD/VNcQRAGnkU0y4QZneqS4dqmRHAMH0RgRameZVk1tGszgordl8z
         QwPwLmCJUTUvv3VrqA3Ue7bE84NcQeFOyq5gzxl1At+4rsI92S6DZSQO34Yb0QSSjGDn
         5PJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706079062; x=1706683862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EiXlBAY01JdJ2qkSWxd7triz1qeIHF28iJql8oMFaDc=;
        b=liW39QrirwFg7Vbj4iGuwqLoupjrczlMHdcIIett5RzNtsH7AbcLV4o0lvwgnfWhOt
         2DgNGSoas8tzPxa4Wo7hDjQmRCSAd1DfrUk3MyaHohbMehfYeS5HasApAxaFF3/5lFJa
         0Feq9Pb+RsiUgWzOF9rAUOjmnF4rWlNYIsiPT0ovc+sSRKdiN1mFQmnTSwR92ubFNerZ
         22p911byzVJ4QxRlQmuMgi19EMBnog8Nx9TP+z/lWLOx3veoBJb6GOktjlYAb8rTd0hm
         a/oA1fqhaop8WBhJrUP2zhfcRB7koGnHuacZ5900h/mrEEiIJQEEU6FK2PRUxjcPZlzE
         0+Zw==
X-Gm-Message-State: AOJu0Yx+lIb9Igwy4c7y/wFH4eR72TUDvCyJ9tDBhacV35nwe11RpEEm
	TneDYv7OyrYc6wL7P2tnBtjxqbemCGDOEc3k5pjzrsBQZfd7DeIG58MLw5Lic7lDFfwBPvmNWkf
	JZ6M8Ocs936PWzgii6MWaxxsbdTcytsGm8Lc=
X-Google-Smtp-Source: AGHT+IF76F/WHLQ2bOogH2JAGP+hAGd82HPDtZ9py9nN9BXWYRQZEFnQR36WwxainzsFyYU91ZwMariBACRUQxTzoXs=
X-Received: by 2002:ac2:4d87:0:b0:50e:22df:6b51 with SMTP id
 g7-20020ac24d87000000b0050e22df6b51mr1447564lfe.265.1706079061424; Tue, 23
 Jan 2024 22:51:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1627.git.1703643931314.gitgitgadget@gmail.com>
 <xmqq8r5gfc3j.fsf@gitster.g> <CABPp-BGSTYDUR1oYYXkCSh-1i2zwxBM=-gnoe-ezNbtPi5CV2A@mail.gmail.com>
 <xmqqsf3nl2b3.fsf@gitster.g> <298F7067-D572-433F-A7DD-5256B43B97D7@icloud.com>
 <xmqqwms6qwr3.fsf@gitster.g> <CABPp-BHaUDdtH6igDmOx_wv8xYh-uA=4L9zDDycrZLaa9c9KLQ@mail.gmail.com>
 <7fc35078-a165-4b3c-96e2-37fbe55e109d@gmail.com>
In-Reply-To: <7fc35078-a165-4b3c-96e2-37fbe55e109d@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 23 Jan 2024 22:50:48 -0800
Message-ID: <CABPp-BE1D+ap_0bw-U9353+7hTU4Ybo_BUDQ94wpASkpAcgyRw@mail.gmail.com>
Subject: Re: [PATCH] precious-files.txt: new document proposing new precious
 file type
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, Sebastian Thiel <sebastian.thiel@icloud.com>, 
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Fri, Jan 19, 2024 at 8:53=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
[...]
> >>   * Which one between "'git add .' adds '.config' that users did not
> >>     want to add" and "'git clean -f' removes '.config' together with
> >>     other files" a larger problem to the users, who participate in a
> >>     project that already decided to use the new .gitignore feature to
> >>     mark ".config" as "precious", of older versions of Git that
> >>     predate "precious"?
> >
> > Accidental "git add ." comes with 3 opportunities to correct the
> > problem before it becomes permanent: before commiting, after
> > committing but before pushing, and after publishing for patch review
> > (where it can even be caught by third parties) but before the
> > patch/PR/MR is accepted and included.  At each stage there's a chance
> > to go back and correct the problem.
>
> If you've added a secret then catching it after you've published the
> patch for review is likely to be too late. I agree there are a couple of
> chances to catch it before that though.

Ah, good point.

> > Accidental nuking of a file (via either git clean or git checkout or
> > git merge or whatever), cannot be reviewed or corrected; it's
> > immediately too late.
>
> Indeed, though "git clean" requires the user to pass a flag before it
> will delete anything does have a dry-run mode to check what's going to
> happen so there is an opportunity for users to avoid accidental deletions=
.

Yes, good point again for "git clean"; it does have one level of check
before the operation users can take advantage of.  The same cannot be
said for the files nuked by checkout/merge/rebase/cherry-pick, though.

> > [...]
> > However, on a closely related note, in my response to Sebastian I
> > point out that the '$' syntax permits individual teams to prioritize
> > avoiding either accidental deletions or accidental adds on a filename
> > or glob granularity, so if folks are concerned with handling by older
> > Git versions or are just extra concerned with certain files, they can
> > optimize accordingly.
>
> That is an advantage. I do worry that the '$' syntax is unintuitive and
> will further add to the impression that git is hard to use. I think the
> choice comes down how much we are worried about the way older versions
> of git treat ".gitignore" files with the new syntax.

Interesting, I thought the mixture of '!' as a prefix and '#(keep)' as
a previous-line directive would be somewhat inconsistent and add
further to the impression that git is hard to use, though I can also
see your point that '$' as a prefix can as well.

> While I can see it would be helpful to settle the syntax question I
> think parsing the new syntax is a relatively small part of the work that
> needs to be done to implement precious files.

Oh, I agree it's a small part of the work, but as stated previously,
I'm not doing that work (Sebastian is).  I'm just trying to help avoid
getting unintended consequences in the design, and to me this is an
important edge case to consider, get an agreement on, and document in
some fashion.

Anyway, Junio seems to have weighed in with a tentative path forward,
and everyone has been very good about bringing up additional
considerations around this issue that are worth documenting in the
design document, so I'll try to put together an update soon-ish.
