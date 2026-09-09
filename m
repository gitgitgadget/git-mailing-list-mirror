Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDD9400987
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945137; cv=pass; b=aDjqwP4Cltr/Zd5Z7lmAMpDWWUJA+EItgFCuvlGtx97NWfu9ZiBrE4FM2dhDT6XwX3tHV4IJoym2WX0A6MB1HBQz2/7p51RePkYyTvu9namAwi/hpe7rH91OMwVlr2CH7kuv61Kpvb0S9/5pn4Z9pz4gJR+wSijV6L8Su3aiOdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945137; c=relaxed/simple;
	bh=d361SIOAXT+FFiqODMd4KPKBboTjnNYy3tdxH3YsAM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJbDIAtmmiPO9G+Z+Qt20JasdxnajHSN+GuhrL3UdwwFz3CvLhUPwx4jCt9ahie96OvTJTg/7YCMqAs/8ZJhTwtSJJkqjDKDr6FSvNlOd0wKBWD1/wqM+DdMdeq8lV2uUH0wBmy8fUeYWJU//8xagQj7aY37gC/vr/4nR3NQk5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNn/UaO7; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNn/UaO7"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c96c92c0980so3060424a12.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 02:12:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788945136; cv=none;
        d=google.com; s=arc-20260327;
        b=MfgcZk3NILorScR9DjoOcvbHXqWWI+4Qi6hTKrPO0RsTcM3iG9rYepbmD4c1h6EvH8
         svmBzlkxamOBxfrl4KjdH5vTxCP01PD6TW/T767SIqwnS04OsKyTVWuBl2pj864JNQbR
         kRYQS6NUhH+fYKWzGgZ4NtsVEG/5uuWwK2DsHtbytVTmf7/vOC4V8r/GOq/vtAlbpN9v
         vOOIEkS1x8xF6m7AwaaLKK6hWA/Qo4MeS7giOKiwDoRqIqu6sPKYStgwkZ/EI39kBs2E
         bEMJAuqz6oDvsZ4SBOJIpdbr1/m9/HaiMCWwTpzsyzDRZrRnso2D0tXxEhf1s0AoK9gC
         bSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d361SIOAXT+FFiqODMd4KPKBboTjnNYy3tdxH3YsAM8=;
        fh=0hZOEHH7Fi06O787RjWtj3trnEAT4KH+3GeYzCEcIzc=;
        b=Ji+u/8MGh77WozsSdY9tXaBIbC6sIah6KG0QqROOB7onhLc7jwdDUk/gbGts9Ch0QN
         4SBpVGRgsWQLntPFTshxfOmA4nvXyeKTNtKYeUeRNlIQ20ozinb/3siJJ0pdNRssbbJu
         zqMR/tK83R1RGpN4AuY+qeOx4rbnQPpWZ3j8gQnjlQWUdLLGFwpn+mLgZeqsnVT+jBxW
         Uyd4f4OpS9uIr6G3Gg62kKwkLN8EDHXolUX5jht6NWqK5AlE78CVlAhwPQ7X/spX/gZX
         qf7eu+9GogX1p2sLoooCuuni1sqshL07DJ3iLqjUqNRxXbr6Ws7qqghf6k3g4njU1AFg
         X5xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788945136; x=1789549936; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d361SIOAXT+FFiqODMd4KPKBboTjnNYy3tdxH3YsAM8=;
        b=NNn/UaO7BTpUVmpVUrEBhReiSSvlg9iaZ1yVgzVTqwYrpU2v0xMz0eVKXW6TEXsjoA
         jDRBter5ZM/W0uQ0QEFDj0/d5tCTBqs5Vj/CAn2pGpcOolrFwuBffkOUwfMQQe14td6T
         TYfb/e6XAfic3lZJQ/AwzfZEOE0kHjCXIiOb0zUy7PPk5pfK4vHXxG+7N3aBP6GT+jpG
         Ktf8rBwqCvWXOhVFkJX7EvHX4I+oKvFvJnDXId8DdOvN4e84NsqaHVzHl2eYKZgn5qWm
         DfXt/rMi8eviwSHFxBATG7d4yhB/nlFI3V4DT9Yr3+yWqE5pe7Enxb4ABfEtzfYG3zSj
         PUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788945136; x=1789549936;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d361SIOAXT+FFiqODMd4KPKBboTjnNYy3tdxH3YsAM8=;
        b=r6vFYSdDQS5cz8l5tS+k5iGNYNZBAyDA8CUGTzcrAY0bVrr1HSazYYMfXVGWvbmyR1
         l58O5fT7ZinnNsJKrhpqHTGCDxa5Yf1kybNXyRwOmDy1OO3XF7oalzQra8YDrTNFrzmN
         U4mzUIof7exAFHTBFhqiUPKma7wY/mFQSFnc4Aea3Fhc8fXUhj61ZDrgKcZ0p8lXdctD
         3GaR/y/aAtk9pmemBsn+9glZVjcbqb95LU77HHNbuLM2vhJMx7Nk7YHPxRMADUCPAmgk
         JnwWf0IpX4QxJsBIEizJbEmtm6Gy83pzVuBQ6CyeomsnPDyYOUFPtRGxEb2UjRI83138
         aZow==
X-Gm-Message-State: AFuF++nK06dWUnjdS7Jq+DbfiwKgcYHyZnQNQaBktxviHeJ2U1kiLRSb
	PN7xNq8zHx4ayIwlCnxWgeNSgetMVdCaoHBscmgbbFRwXTEli1ov9MLt4Qq/oPHVFHSwHPb2Zqo
	ke7P3cxz0GPs6NP7+xcJiXjAyIk7hAUOvW67CspU=
X-Gm-Gg: AYBFou3qeQIsuhNWr3bZSJVEyWiWhbbg9w/m+IASu3Ybg8ProaHpR9Rd+aVtkY48CzW
	8g5SoPSQRKX+tplp5qfrfnKO70S1/sO3PXnWWhKkuWheiLgo3BB6djDRvDuTjNEYuIsYZzaqzBn
	sGRW8Uit26LdpfZe/FyrdmJO9nbAue+i0Whk5YHR3nmpW9iGCQaNk5Qenh7FNBOOG4xamtSRwk6
	ZzPdIGOWlF7YwuSH5QGPYiJJk1ns5AsiMr6LikOouGLyNXN86JSPPWWQobr8xoJyHeoe9zvwTXx
	bx5k7xGHfvmRoTShpkhrVaJAJgqt2Z6tGSFqvcpe8wqWN1qKz4Fgzsdx/+4U8XeY7fw6MMVeDW0
	R02xVfbfpuzr7Z/+YK5Dlc1pzsXzmHCZwiL+mdylxpX9IP0zqYLHbvitmdBH44QQHWsPd8pLNGX
	lGfcFjNt0N4HQaesUz99ZMFh6TMRHJ5CL1a5H14eQ=
X-Received: by 2002:a17:90b:4cce:b0:38f:240d:b857 with SMTP id
 98e67ed59e1d1-39b260dd4e9mr54723196a91.2.1788945135450; Wed, 09 Sep 2026
 02:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD367UD=AomNVHEBnhY-2DQmqTNRcBX6NW7YZywWgOmxTQ@mail.gmail.com>
 <CAP8UFD0oYnoXgQ84wHbGg3+QhX78Ucn_CXXYOe8uFpReb7X1Ng@mail.gmail.com>
In-Reply-To: <CAP8UFD0oYnoXgQ84wHbGg3+QhX78Ucn_CXXYOe8uFpReb7X1Ng@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 9 Sep 2026 11:12:03 +0200
X-Gm-Features: AcwNN1X2Kh9pWTmWnr0FsEW_IF7l9Xg0tTXyR9QcUJwvxXlytsuSxNgGzh0MGUw
Message-ID: <CAP8UFD1hAjtPuWL8asZ2LzEMJKHGh2oO73n_tsUSADtEHh9b-g@mail.gmail.com>
Subject: Re: Participating in Outreachy's December 2026 cohort
To: git <git@vger.kernel.org>
Cc: Git at SFC <git@sfconservancy.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Pablo <pabloosabaterr@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Tian Yuchen <cat@malon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 10:26=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:

> Thank you Usman, Kaartic and Pablo for volunteering to co-mentor!
>
> As no one objected to Git participating in Outreachy, I will submit a
> Community Application for Git very soon.

I have submitted a Community Application for Git, see:

https://www.outreachy.org/communities/cfp/git/

It says that we are willing to mentor and sponsor 2 interns. Hopefully
we can have two (co-)mentors for each intern.

> We will still have to sign up as mentors and find and submit projects
> for interns to work on soon. We have until September 11, 2026, at 4 pm
> UTC, which is less than one week from now.
>
> I have been thinking about the following projects:
>
> 1. Continue removing global state (and perhaps start libifying some
> parts of the code base).
>
> I think Tian Yuchen said there is not much work left related to
> "environment.{c,h}". So maybe we need to adjust the project compared
> to its previous description or maybe make it about actually libifying
> some parts of the code base.
>
> 2. Improve how command arguments and options are scanned and parsed.
>
> There are still a number of places in the code base where command
> arguments are scanned or parsed using ad hoc hand-rolled code instead
> of an existing API like the parse-options API or the early-scan API I
> recently proposed in
> https://lore.kernel.org/git/20260902161047.476753-1-christian.couder@gmai=
l.com/.
> Those pieces of ad hoc parsing or scanning code are often buggy and
> difficult to maintain. I think porting them to an API while improving
> that API if necessary can be an interesting project and bring a lot of
> long term benefits to the project. As the parse-options API is already
> quite feature-full, there are likely some areas where porting the
> parsing code to it should be relatively easy which is newcomer
> friendly.
>
> Let me know your opinion about these and if you have other project ideas.

As no other project ideas were suggested, I submitted the project
ideas I mentioned above. You can see them in the "Approved Projects
for Git" section of the above mentioned page
(https://www.outreachy.org/communities/cfp/git/) as:

- Improve how command arguments and options are scanned and parsed
(https://www.outreachy.org/outreachy-dec-2026-internship-cohort/communities=
/git/#improve-how-command-arguments-and-options-are-scan)
- Reduce Git=E2=80=99s global state to enable Git's libification
(https://www.outreachy.org/outreachy-dec-2026-internship-cohort/communities=
/git/#reduce-gits-global-state-to-enable-gits-libificati)

The links to these projects are currently only available to approved
mentors and coordinators. I applied to mentor both of these projects
as this was required to submit the projects, but I am very much
willing to remove myself from mentoring one of these projects.

So please apply to (co-)mentor one of these projects, or submit other
projects you are willing to mentor if you prefer.

Also let me know if you see things that could be improved in these
projects or the Community Application for Git.

> > Last year the Git community mentored a single intern. For a long time
> > GitHub or GitLab used to sponsor Outreachy interns working on Git, but
> > last year both declined to do it, so the intern was sponsored by the
> > Git project itself.
>
> I will start poking people at GitLab about this, but it would be nice
> if we could get some kind of help with this regarding other companies
> too.

I have mentioned GitLab, GitHub and OpenAI as organizations that could
potentially sponsor Outreachy interns. I have also proposed an
"Outreachy sponsoring" topic to be discussed at the Git Contributor's
Summit 2026 next week.

Thanks.
