Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2FC2741AC
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643113; cv=none; b=ckSBZcWOnS4ad9/BqkPFpMeRZZBPjKWCx/wHVatzvFOcFvG/4p28JBeL2686z0gAxbBNVqExFIcGSwHBtlMieTDbmkgnXsBvxKrH6pbmhGYJeopMd5jdFGRu6l+1k+dH+MiXceCnFhEcY/2hE98lavIbensRHczHliLT9NuZjW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643113; c=relaxed/simple;
	bh=TwmHK3TKGBLL1whdtFFHVhBaPtz8zshmdkF3JPpQnl0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MZ3vX6E1IXodraN7ISFdUIGUDZr+WT1Xhn4venVKoV/J6nmD3uU/f1B978N4E0zjXp78Z847SCD4XZMLnhCr8zB4+5CB8ZUHuF1SDg8wTEL1Li90kXQcBOI4WUAlH5r9IkO42XmKJDvt8Wa3VunETHkzt63BYtDazxgn2hh/h1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlLlhIu2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlLlhIu2"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso5399791b3a.2
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 08:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744643111; x=1745247911; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xoXtE9LxI1+q5KuzKJgBZ2tYamIJTDmMubd4RHecqo=;
        b=SlLlhIu2sFdGXgreZSjygcUM2viGbKDr1SgbA71zDTqLWePkKlYvz3AtOW6ldRypZ9
         FNur6Ep2+mO9UqywcO1kIKMfRET8FE2lr8IN4I2MdhM2novxBNLe3uIXgLFD1QwzT8YG
         hrs5ViFG2TeRM+49X+InOCxAyTgUSadIClMKuvcWX7rZyZV6183bJROeV7Z60TIor//X
         aWFJzXm/rNNEQgqLaMPfrXhoG8Jzcr1nGu6DO3fPc6/oLTVrxkWccq/gV96LNadd8PKn
         kIHXmvo+g4NWxktYjMLVn8EDs+0IFNkqyLA0+iSQUcQi1Tx0WEO6HeL/LnFZZ3BztjB1
         p+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744643111; x=1745247911;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xoXtE9LxI1+q5KuzKJgBZ2tYamIJTDmMubd4RHecqo=;
        b=YP9H0QLXevrccYoHIi8M46dw3+vSZvQRSMdFF7xAyrDcRrLLrJfUnnYz2VA7WNYC6u
         KjEhoFQcGk4cK+cBVs9CP4qAfG7h/v8Rac9hhtXNaVvkjjtE8MqOFhizJv5x7h4BHi5e
         VyWkw9LzfMHv6VMz88MXln+f3aO4coV0sdscmgK6nADRmWVgUacLUoXytFUXvS/E8eRd
         WEUk79d2G2wGq2LxltYf05wGsjj4gFjrOuj3iMgxaXZ/CTQ8Uhxa8u4wawWcG9NJgw7m
         4iH+Yco2DlV+AhP4UzGgsiVJgi4TtlDrSVkdP4ha1SGF14Wjybf2ugYGPE/95ePVh3lH
         +UdQ==
X-Gm-Message-State: AOJu0YwQNcDxP6uKEtkQ8mVuMzFYYz9Nt9UzgMba2FTkbVbmF47wo0am
	fPERJyLWaMNDopYTLbS2ifp/danrGntwk9QSnD2x5AVNDS9ZOumQ9f0w5w==
X-Gm-Gg: ASbGncsmb2YapLy5L7kKO8yeaUCXdX5koG+t9MxnzgJk6uYs1zDu4P+BbkBT98T+X8o
	CwNZEAx0/EU2bVKgqGv3q+RP8/Of3B4UAm1gQuWqwKBjFmB3We+vwkLEXY0qAvKMKxSozBjI46Q
	oKaqxvOYytQME8IKbIUfbwCT02TFBT5EPAOW7clmty0LqnJgs1Yyh0I2/RJhSHmiXyKKexVoyQB
	HqMpm3eDFvSr5lmffCASGYQCJaVwRyw+DqzttWp5ESniQDz9jFtIgk8rnd6iB5545XkcD5insex
	pVmFvidCAwywJO71KWaMhnItFzxBHiJVdyokyX0H72ONQhHnq1lrsFqRxW4t0PjQ21w70ZSAtCk
	kFZjkFKo=
X-Google-Smtp-Source: AGHT+IGQehWYfse4pQd0Ows1zMDVrj/B2Oq1Klj2bN7sMKNNI6CQCbJG62dek4UA2qo+N1hyMwP0zw==
X-Received: by 2002:a05:6a21:3a4a:b0:1f8:d245:616d with SMTP id adf61e73a8af0-201797ae6a0mr18112703637.21.1744643110396;
        Mon, 14 Apr 2025 08:05:10 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8e7e:85b7:aff:5cfe:b6e5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f833asm6709476b3a.111.2025.04.14.08.05.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Apr 2025 08:05:09 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: Collaborative community interview for Git's 20th anniversary
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <85ea4aa0-c595-4f0b-a2ac-d0113aca464a@gmail.com>
Date: Mon, 14 Apr 2025 12:04:55 -0300
Cc: Git Mailing List <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>,
 Markus Jansen <mja@jansen-preisler.de>,
 =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <AE27429C-97B1-4226-8F30-5B635A050498@gmail.com>
References: <85ea4aa0-c595-4f0b-a2ac-d0113aca464a@gmail.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi!

>  - What's your favorite Git trick or workflow that you wish more people
>    knew about?

Everything related to code archaeology (git grep, `git log -S/-G`, 
`git log -L` and `git bisect`). Those are my primary debugging tools and
every time I explained them to other people they find them mind-blowing
and useful. And they also started loving it :-)

>  - What was your worst Git disaster, and how did you recover from it?

I don't remember something that I did, but I remember a simple and
curious disaster: our deploy workflows stopped working, only leaving a
message like "cannot fetch ambiguous reference `master`". I decided to
investigate what happened and I found out that someone by mistake (I
don't know how) created a tag called `master` and pushed it to GitHub.
By the time we used the `master` branch for deploy, and the workflows
didn't know if they should use the `master` branch or tag. GitHub didn't
have a feature for deleting tags through the web interface, so we
thought "what should we do?".

The solution was to run `git push origin :refs/tags/master`. Simple, but
not obvious. A classic case where it only required a screw to be turned,
but all the hard work was to find which screw should be turned.

>  - If you could go back in time and change one design decision in Git,
>    what would it be?

Perhaps writing a more abstract CLI. After studying Git a little more
deeper it makes sense for me, but I would group the functionality into
more high-level subcommands and would make the flags and options more
consistent across the subcommands.

For example, Docker CLI have all the image operations under
`docker image` and all the network operations under `docker network`.
If I want to delete an image, I use `docker image rm`, if I want to
delete a network, I use `docker network rm`, and so on. I would make
Git CLI work based on that idea, for example:

- git branch add my_branch
- git branch delete my_branch
- git branch list
- git remote add my_remote ...
- git remote delete my_remote
- git remote list
- git tag add my_tag
- git tag delete my_tag
- git tag list

With some shorter alias, just like Docker has `docker rmi` and
`docker rm`.

>  - Which Git feature or improvement over the past 20 years do you think
>    had the biggest impact on your workflow?

Sorry, but I can't answer. I am from a generation that started
programming when Git was already the de facto VCS so I can't compare a
world that has it with a world that doesn't have.

>  - What Git problem that existed 10 years ago has been most
>    successfully solved?

Sorry again, but 10 years ago I was only starting to use Git and when I
started to use more complex features they already were there.

>  - Which Git commands or workflows do you think are still misunderstood
>    or underutilized today?

I think squash merges and submodules are really misunderstood, yet they
are the opposite of being underutilized. Sadly I saw several people
using them in daily basis, based on the wrong idea of what they are and
then using them incorrectly.

What I think it is underutilized is the full power of commits of being
a good source of documentation and good resource for, again, performing
code archaeology that may help understanding what the code does and
debugging it. Several developers treat the commits as just checkpoints.

>  - What's one Git based project, tool, or extension you think deserves
>    more recognition from the community?

Perhaps it would be better to leave this question for other less known
tools. But if want a answer, I think:

- Delta (https://github.com/dandavison/delta) is a really cool to format
  the diff-related outputs;

- Kworkflow (https://kworkflow.org/) is a powerful tool for contributing
  to the Linux kernel source code (I should also try it for contributing
  to the Git source code);

- Merge drivers in general. diff3 works in most cases but it is only
  based on pure diffs, without performing deeper operations based on the
  file format they are merging.

>  - What Git feature or capability surprised you most when you first
>    discovered it?

As you may have noticed, I'm really a fan of Git archaeology :-), so I
would say all that I mentioned in the first answer. But my favorite is
still bisect. It's an egg of Columbus and I everyone that I have shown
it to was equally amazed by it!

>  - What's your boldest prediction about how version control might look
>    in another 20 years?

I still see Git as the dominant VCS in the future, but I think more
Git-based VCSs (like jujutsu) will arise. Just like we have today
programming languages built on top of the stack of the other languages
(e.g. Clojure, Kotlin and Scala on JVM, TypeScript on JS), networking
protocols written on top of other protocols (e.g. QUIC on UDP, gRPC
on HTTP) and so on.

The Git core is simple, flexible, transparent and powerful and there's
still room for people using it directly in several creative ways. Once
I saw a project using it as a backend for a NoSQL database
(https://www.kenneth-truyers.net/2016/10/13/git-nosql-database/), who
knows how many use cases we still have for it.

> Sivaraam for the Git Rev News team.

It was a pleasure to answer that!

PS: can I share your questions in local Git communities?

