Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA881F9ED1
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731583809; cv=none; b=lOwQWEpXOAhXCszul9ta7UbNZQWCvX3pDvfSQUwq/afzlyWxdlea3RmmEZGYoBDrodxUJ/DZHRycvhgY7IzXeX6rRcnAunpnzzZtBzY/A/DjNfEx7RBv9J5dH9i8tLA3S5y3XLBSBUcnuCLhSSvCxsV46RP1sKvqL7V7+WM8C6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731583809; c=relaxed/simple;
	bh=+npuu+N4x5tnnvQ09js1WMqO/IrDDlwZUMWEYyzu03c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0NAJUcHHwrAUl7O9/VRhbnf/Xj9nUUqk7pHJWWsAu/FE5FYg4SbZzXVUwUfmhsvJDtk4vlKAtFoFPbrgWCLltmM/aLWdBwfv0Qvq8x/W6ljQQDrZSSJbwjB96cp0hHk8dyM/1Y2dtFfn8U8d4ZIxx5mflbMsiWq5Wh1X/nhWoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlY9fO3o; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlY9fO3o"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-84fd50f2117so241198241.1
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 03:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731583806; x=1732188606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfwKF7J7C8oFhkbZNaUDs3sk1gTW1d04siAz01Fg7Iw=;
        b=XlY9fO3okD6mimbGVJmUxczUuEhoyTa+aF2RVv1vBtNKdYJJoqcW9Wz2ZMWGMwpKnR
         x4cSRcmZ4zxKS3+37BIXzDrp/8daFrZOhcSAdZb4c/4BBvPi+EaJL8J6kJ4dnynSAgLw
         XTlwzdBQXgOgIR7in5inV28WjX+gNQuIh1NNHz7lgRT9QEHmezo7OukmhvGZ9bUu6jx6
         YfoVra0jkXHw7CUS4tKO4NeE6VYmB7jJAugv2e2hauI0SP4PS3UW6TnBT9AOmlYMgjOV
         RNSDUxdFbjJDSPVQ1aNIuBdN5w2lN8nw3p4a+K+7jN//CqzcIy8bP+R+EkG99yaD+Ou9
         dIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731583806; x=1732188606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfwKF7J7C8oFhkbZNaUDs3sk1gTW1d04siAz01Fg7Iw=;
        b=P+/Yq/jVA9Prw+JU1g7HSzlTtekhKjV5i+09DJM4sRK/1GR86u3MXGi1ZHiMsBLGRb
         c4TiI5fcLf7xmCmJpSH+l+HTIeZw4dU/efMo/B3SWrMrZFi854kHsZ9c2zt8Vxyb5AWC
         ZZ98SsPq0WLXOVdK/Zu7jM3Ok9dVIEZJfhFaKnVbkVredUEjnFLIPtmHvMs0VWjWm9xo
         nO3fzq+uGpel7E+SowPRa2UekzQCu1NfcDJnrGAW/UnFJrPV4/NZhBGMQkffpu3gee9G
         c1vnz44EEsfhSPOH6UCHE3Ms5H5gP7FO4TQsiba4xrf+BfRxf6ixoVojKaezZNKegfky
         zlCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8DZtmnEMhlXeHO26KEDbAoSBPTkdeputBvDpePXEysPx3oH7OoiEodquhDull7qtcxH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrzyhfoNAr/p9zmhXE7yTlip0ob/xnDi0veC1sNkdfeP8mZjvm
	JVcIyEgbEbEbh2On4TbwnfqMoEJB3oxvg41q0lys+sB+R52M5ow+P1UAnTK9EJX3pbmghUhuUdT
	lTD5VTQ+CgD4JxLlCWcS0lrVuCaNi3yWo
X-Google-Smtp-Source: AGHT+IHZ7mCMqOd9n/TN1MKLNsdA1DCYyuzbduCMN1EwCoUpe7ZiiSg8eenGW9ZfqGLMMe6aWmPIgeh4jIwQOq7Qj/U=
X-Received: by 2002:a05:6102:3f03:b0:4a5:6f41:2143 with SMTP id
 ada2fe7eead31-4aae134d3a5mr24940181137.4.1731583806359; Thu, 14 Nov 2024
 03:30:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1828.git.git.1731347396097.gitgitgadget@gmail.com>
 <pull.1828.v2.git.git.1731524467045.gitgitgadget@gmail.com>
 <xmqq4j4a8srw.fsf@gitster.g> <29c81cbc-3678-4b70-9e0e-c500186d159f@gmail.com>
In-Reply-To: <29c81cbc-3678-4b70-9e0e-c500186d159f@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 14 Nov 2024 06:29:55 -0500
Message-ID: <CAPSxiM9ejv-ZHHu3UkB-ktokae9w7HiUxmByMRUVMSbG1u5Nxg@mail.gmail.com>
Subject: Re: [PATCH v2] diff: update conflict handling for whitespace to issue
 a warning
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, 
	Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 5:06=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 14/11/2024 02:15, Junio C Hamano wrote:
> > "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > [jc: As Phillip is blamed for suggesting this addition, I added him
> > to the recipient of this message.]
>
> Thanks
Hi Philip and Junio,

>
> >> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> >>
> >> Modify the conflict resolution between tab-in-indent and
> >> indent-with-non-tab to issue a warning instead of terminating
> >> the operation with `die()`. Update the `git diff --check` test to
> >> capture and verify the warning message output.
>
> Usman - when you're writing a commit message it is important to explain
> the reason for making the changes contained in the patch so others can
> understand why it is a good idea. In this case the idea is to avoid
> breaking "git diff" for everyone who clones a repository containing a
> .gitattributes file with bad whitespace attributes [1]. As I mentioned
> in [2] I think we only want to change the behavior when parsing
> whitespace attributes - we still want the other callers of
> parse_whitespace_rule() to die() so the user can fix their config or
> commandline. We can do that by adding a boolean parameter called
> "gentle" that determines whether we call warning() or die().

I am very sorry for the confusion. I will take this into consideration
next time and always give more explanation
in commit messages.

I will make the necessary changes.

Thank you very much.
Usman.

>
> Best Wishes
>
> Phillip
>
> [1]
> https://lore.kernel.org/git/e4a70501-af2d-450a-a232-4c7952196a74@gmail.co=
m
> [2]
> https://lore.kernel.org/git/3c081d3c-3f6f-45ff-b254-09f1cd6b7de5@gmail.co=
m
>
> >> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> >> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> >> ---
> >
> > If the settings requires an impossible way to use whitespaces, the
> > settings is buggy, and it generally would be better to correct the
> > setting before moving on.
> >
> > I am curious to know in what situations this new behaviour can be
> > seen as an improvement.  It may allow you to go on _without_ fixing
> > such a broken setting, but how would it help the end user?  If the
> > user set both of these mutually-incompatible options A and B by
> > mistake, but what the user really wanted to check for was A, picking
> > just one of A or B arbitrarily and disabling it would not help, and
> > disabling both would not help, either.  But wouldn't the real source
> > of the problem be that we are trying to demote die() to force the
> > user to correct contradictiong setting into warning()?
> >
> > Thanks.
>
