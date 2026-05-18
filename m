Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7413D3D47C8
	for <git@vger.kernel.org>; Mon, 18 May 2026 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110822; cv=pass; b=MY78T7eM60Cam4Y+kAhWz/8eDt2FXbvdpH4fWnVjvIbyvIhhGnjo3imBvcvxvPd3/1IQtwsMqn2S+c7DVsIW7BFdDaogusCbKZEDpXBQZj4VYc+KqM56K7T30OU0fUozo4AH6/ttiICyxxZXIe5+od7OS8XFK8fZWSdYaFsiNZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110822; c=relaxed/simple;
	bh=NYixwFaWFYpuQAzv+2rbFWPcol22HCy9YqiStmGSTYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GnV6OHcQiuScKo/Pk7Do8qCeU4Lx4b6dOvDYddbmHtK5edCCMWkjeNSu12Nfre7DCwIFGduyZgP8Kwc1PKOIrafpk3FuOyH6v1RL5TvkSEUCibO7Pg1vebGslM9GRa4rryK2HsmsuN7/bFcHEqHGQJ9hYlzFsKy0XTRT6sjMMAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXS1WlQ0; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXS1WlQ0"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7bdc947aaa3so14452787b3.0
        for <git@vger.kernel.org>; Mon, 18 May 2026 06:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779110820; cv=none;
        d=google.com; s=arc-20240605;
        b=XbvUhXhzG/1VVq0/vF2ImMlFucv0t/m2GE2xQXNNmYzU0Mfqmzo03fjh0H9fl8dQxV
         +bi+gDtDr2Fu09Fg/AxOT1xbGgyB30dR+QhPKujJRW52wCQuqCGEMSkoZOuY0RrX0zGd
         HD4MD3cePpg1vriXqWhYDpzTYrA7skMO1QHwxwO2Q13ewk/x0jG7o+noOz8ezoxmEODd
         gg0SBvNee3r1+RK3rOJq1bQbNM3JN0MYnrWtpPN1AyeszzMMZGkq5cwBsdmmLOK2npYM
         Aoh46ofcbuKAjgSvv91bpeJSQEZzY8hY49vJQLrOBvte92lKXkxBWDOWLybKotkumheD
         thCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pZAQCUyZBk+29ln/NK8x2jbQVG95sLDBb65Gie74aXs=;
        fh=9ZSRY4/U94RF9Hs0vB3HfgEra5vKEs5/SPVYRlJTOis=;
        b=Lpnfrt0/KCoBQ4z7tZoAcjYaHDIm200m0+PVdf+VRRm4tMfyBpyCpnQYoYhR8/xVz2
         gdjr0KGw98GoNSB1cpYXVCl1oKcbthld3pvwbadJNcGLuE3Oj7d3ANjoxSuqIQezwOdK
         j+wnv+oJgu2hJyf/Mdyyc2B1Dq+/waelT5aVnPJAnD7JQgJDkcFcrpjNtrsFb1xP/nOR
         6r0q14o+numglGmamqcHw54Z6FiZTcwfWXv4/JJK/xb2opKUfMRhXcnAVAX3rKqynS/X
         LMfavQLAYkbMSdR/0Fk2x2BtrzGJ3eoG0W1+KECz6rZe8QZ0UOAWDaZVWt8KRMUala5t
         1cRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779110820; x=1779715620; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pZAQCUyZBk+29ln/NK8x2jbQVG95sLDBb65Gie74aXs=;
        b=SXS1WlQ0JNnMj2UD4HNzNA/TWzIQd4wW4sVN7vrWbgO7nbSaF5Hl4Z3ZmDxo7XXFuz
         Q/S407XwCElRq0oMQ0OQ4/U3xJ9Ud8mcHgayMHTlOuhVMJ1zRGF8QJ1n8VcWrNZR77fo
         ayoJozFlXo/0CLrTIG9Q8gw/GrdR8GqXcVv/eukCWndlKEUzrp709tJyuWt0D70owDK3
         6QUHZY2UfnjEnAIkFnCP9qbVuL4Y9WyD6RXiCGW+Ht/M7WrIF0U3KeM8BiTwTM8MYXKv
         zTj7nZ5RBxab/TsCcwlUARqODhx72z3BGLIe3biqnbVJrlLlE3/LvJriM+UE+6PmhAZY
         rcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779110820; x=1779715620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZAQCUyZBk+29ln/NK8x2jbQVG95sLDBb65Gie74aXs=;
        b=ALRM0RZL2aenAcIMe9AvSRzm9zWbSSctTD72wSF0d2Wgz+JIiFmny6fIZTZcbB96Tg
         KXPhgOd+ZVNE3Bygm/0A0BN8550WQNilurE5fKLc/B/g3yVp11Nht4vHX+vBYFcgxO3J
         FFzb7y78g0V+n9VrlCpzaAmmZl0dFb+3FY9aVBsSlQpTPodz9PwnZAobpiiVJmUenaGa
         uNrcp3SI/qVxNyvLcyFd1uz5tUKSWjJ8TBLQNeOmDfYI/DiEvg1zrVwA8BMIm5OwOKHr
         7gb3/fSUzBbPoyDtwUvnA+kgGNqt5t4vQB1ZC/TMFq4JiMbwS9iY/mKkMldKn0V4/inq
         3PnA==
X-Forwarded-Encrypted: i=1; AFNElJ8Wq5ZKFx1ipgA2BC8CL9P0fheyEX/ZDlNyIIySYpGeAQM0vSYvZQcnJNhFpEjDRo6VOls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQfqm0z6fPXLItxpCYDrzw0YBnkW8b8Xz/PqKG/+JBAam08dn
	xmqkO/J6OedWORUvpVx+t1WLaa9gSccY0jz6D14WqZYHosz98aVdckLEO+Lq/kLPkTrFcWAK7N4
	U/86+FO2jOW8ZkL7XNadATeA39BHk1yg=
X-Gm-Gg: Acq92OFVwToWCg+vGnrmvTIIxGpjuSg0dLVvpQnGWLf30cI0Dv4ALTh4dIGeIvKbGtX
	zh0ylrXnr2xSixx4DCsMy3pLZVo+dnxQaHy76IO2utjEdTUGE8p9zZVC/w6bJ9XgsNJoX7YKYff
	6cSIqNeJAcx9aFgThiuvjtlPkGg0czBYJz/klnQpHob1iNTuGXzJ/CXsJmw5LPO8LvJ7Y0Ju3zl
	U7/CnAyBap7eq8ckQERjobX1A7R/5Bjp9a6JoGST902tXDUh8G7xHXrAexPv5ubMzXAIxhrMlIl
	pg++pZX5xHYZUVf2clOma4S/jr+cMmC8hv1NsTzmgc+DHpw6DUCBVOzGCfVjNR/cO4PojKKGKCb
	nRCJZv9+d1WuT/obx0b6jb3EV6Ou8AKCdk/mZHZf43XCpBRaySmZ/TNetMbdyEP3gqxctwTfj4S
	49BC3l/Q==
X-Received: by 2002:a05:690c:4428:b0:79a:6d65:c351 with SMTP id
 00721157ae682-7c95c8f06d4mr132038527b3.36.1779110820362; Mon, 18 May 2026
 06:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402211717.3604688-1-pabloosabaterr@gmail.com>
 <26d887d2-6ec2-4af1-b0bd-8e9b017bb4dd@gmail.com> <CAN5EUNQCsKD0CJqDi43i2JVBQQChAZVt_THQ1wGpdeydNHHCFw@mail.gmail.com>
 <2e8b9b1b-6a69-4e94-95ea-7f587435bfce@gmail.com> <CA+J6zkTGgeNuH0eusTy+t8LO3bjygSz4svJB=K4R5ASmBdd0uQ@mail.gmail.com>
In-Reply-To: <CA+J6zkTGgeNuH0eusTy+t8LO3bjygSz4svJB=K4R5ASmBdd0uQ@mail.gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Mon, 18 May 2026 15:26:45 +0200
X-Gm-Features: AVHnY4IG9CzIZAsJF5stVo3nl04ZRAskXggBjY33vJpUrlKTnApOvPfXnTP58bo
Message-ID: <CAN5EUNQoKRqt3FGLmzRGpPU1nO5jCAogP8Wm9gBZXuPbMNbQAw@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH 0/1] graph: add indentation for commits preceded
 by a root
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, gitster@pobox.com, 
	christian.couder@gmail.com, karthik.188@gmail.com, jltobler@gmail.com, 
	ayu.chandekar@gmail.com, siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Chandra, Phillip,

> > >
> > > I have mixed feelings about which approach to choose.
> > > The idea of a blank line was thought at
> > > https://lore.kernel.org/git/xmqq8s8vvw9m.fsf@gitster.c.googlers.com/
> > > but Junio argued against it for having an extra row because the
> > > indentation he proposed didn't collapse, however I find indentation +
> > > no collapse the most confusing one.
> > > I'd say that I'm fine with both approaches, blank line or indentation
> > > + collapse.
> >
> > I'm afraid I don't understand this - what does it mean for the
> > indentation to collapse, or not collapse.

Collapsing would be when branches move to the left, eg:

  *
  |\     <- merge
  | *
  |/     <- collapse
  *
> > Looking at the examples Junio
> > gave they look quite nice to me, though I'd find it clearer if
> >
> >
> >   | | *  12345678 2021-01-14 merge xxxxx@xxxx into the history
> >   | | |\
> >   | | | \
> >   | | *  \  23456789 2021-01-12 merge citest into the main history
> >   | | |\  * 5505e019c2 2014-07-09 initial xxxxxx@xxxx
> >   | | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest)
> > Added defau
> >   | | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from
> > f7daf088)
> >
> > was rendered as
> >
> >
> >   | | *  12345678 2021-01-14 merge xxxxx@xxxx into the history
> >   | | |\
> >   | | | *  5505e019c2 2014-07-09 initial xxxxxx@xxxx
> >   | | *    23456789 2021-01-12 merge citest into the main history
> >   | | |\
> >   | | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest)
> > Added defau
> >   | | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from
> > f7daf088)
>
> It probably *does* look clearer here, but I have the same reservations
> against this as Junio: the break won't be as noticeable when --graph is
> *not* used with --oneline.
>
> > >>> without the patch:
> > >>>
> > >>>     * A root
> > >>>     * B root
> > >>>     * C root
> > >>>     * D1 child
> > >>>     * D root
> > >>>
> > >>> with the patch, the indentation cascades:
> > >>>
> > >>>     * A root
> > >>>       * B root
> > >>>         * C root
> > >>>           * D1 child
> > >>>        _ /
> > >>>       /
> > >>>      /
> > >>>     * D root
> > >
> > >    * A root
> > >
> > >    * B root
> > >
> > >    * C root
> > >
> > >    * D1 child
> > >
> > >    * D root
> > >
> > > Here I think a blank line looks worse, too much space for just 5
> > > commits and becomes one extra line which if this were like up to 7 or
> > > more parentless commits one after the other would be more noticeable.
> >
> > But there shouldn't be a blank line between D and D1 so the two
> > alternatives take up the same amount of vertical space, the main
> > difference being whether D1 appears next to D
> >
> >      * A root     * A root
> >                     * B root
> >      * B root         * C root
> >                         * D1 child
> >      * C root         _/
> >                     /
> >      * D1 child    /
> >      * D root     * D root
> >
> > Of course if the indentation was smarter it would take up less room and
> > look better than having blank lines
> >
> >      * A root
> >        * B root
> >          * C root
> >      * D1 child
> >      * D root
>
> Right, this would be ideal but that would require too much change to the
> existing graphing logic, and should be its own patch.

For the examples I'll use the term parentless instead of root, as
boundary commits are excluded even if they are roots.
By having is_parentless as a flag in 'git_graph' that every stage can
access we could modify the rendering and maybe completely drop the
commit placeholders, working on it for v4 but currently renders like
this

    * A parentless
      * B parentless
        * C parentless
  * D1 child
  * D parentless

(A has indentation when it could not have, but that would require a
lookahead if the next commit is also parentless)
But definitely a step forward.

Do we want cascading or just a fixed indentation?

    * A parentless
    * B parentless
    * C parentless
  * D1 child
  * D parentless

By being indented it indicates that it is parentless and that the one
below doesn't relate to it, but cascading looks clearer.

>
> > > But there are cases that blank line might be better:
> > >
> > >    * 10_A2
> > >    * 10_A1
> > >    * 10_A
> > >      *   10_M
> > >     /|\
> > >    | | * 10_D
> > >    | * 10_C
> > >    * 10_B
> > >
> > > Feels like a shower of commits instead of an indented merge.
> >
> > Yes, that is a bit confusing. I think the thing I find confusing with
> > this approach is that we're treating the commit rendered below the root
> > commit specially, rather than treating the root commit itself specially.
> > To me it is the root commit that's the odd one out because it does not
> > have any parents, but we treat the commit that's rendered below as the
> > odd one by indenting it relative to its parents.
>
> I guess that would make the examples look something like this:
>
>   * A root
>   * B root
>   * C root
> * D1 child
> * D root
>
> No cascading, and no need for that massive _ / collapse line.
>
> * 10_A2
> * 10_A1
>  \
>   * 10_A
> *   10_M
> | \ \
> | | * 10_D
> | * 10_C
> * 10_B
>
> I say it looks better than the alternatives, but I'm not sure if this will
> be easy to implement. The diagonal connection line (\) will need to
> be printed before printing the actual root commit, which will require
> lookahead logic.
>
> I'd prefer to avoid major surgery on the codebase.

Octopus merges need a pre-commit phase where an additional row
increases the space around a commit with multiple parents to make room
for it.
A new phase can be created similarly to pre-commit as pre-root where
the connection edge (\) can be printed before the indented commit.

So far this is the comparison:

indentation at root:

    * A parentless
  * B1 child
   \
    * B parentless
  * C1 child
  * C parentless

indentation AFTER the root (current v3):

  * A parentless
    * B1 child
   /
  * B parentless
    * C1 child
   /
  * C parentless

Karthik mentioned that by indenting the parentless, we lose the
consistency of having the roots on their real column and now some are
indented and some are not.
The biggest winner having the parentless indented are the merge commits:

  * A child
  * A child
    \
      * A parentless
  *-.   B child
  | \ \
  | |  * C parentless
  | * D parentless
  * E parentless

which IMO looks clearer than the commit shower:

  * A child
  * A child
  * A parentless
    *   B child
   /|\
  | | * C parentless
  | * D parentless
  * E parentless
>
>
> Thanks,
> Chandra.

Regards

--
Pablo
