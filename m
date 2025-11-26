Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CF5219A81
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764178560; cv=none; b=gjA+HZQYBR6/d3XnSCsGmhLN/rr77hjdiVjFRspSeJXK4JCGCDDDjqmElQgUORkpO4fvQm8fIp93JGnCu+2Xpw8/DJi5qRRSAVLX3dlJ5nk3plBHw2V/Q85bh5wI3nufqAzdCEw5Gi3XkOfDFaizV9pb/MTK8ovzq061PFIU3aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764178560; c=relaxed/simple;
	bh=FD7lr3yNWhBPETggvC30w3cuT5IOE3y/l0BwRxG3xEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QpWz63/TPpqMvingvBVGRgHiUTgpgYB8pjuyYtxLpPuRYOaV2hoWjjU7lyAazSXWNRJ8O0u2JaNMLBzI6wJJU19f9t+IH+V9IwC13pq4tJDNVZtUfOtRJIhBgvXT3k989N2VFy9/gSSEXfGfOUnHk29C4cYP1ywH+mgLpASrFlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5Xswyik; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5Xswyik"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-9490c862fcbso162239f.2
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 09:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764178557; x=1764783357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LnxOto2dZ6OYzzuXq4UGN4Fc7DmOH/l4Y+1TMNHIpI=;
        b=J5XswyikS+queflUReN3zp3Xdk0fhjffkSYvkDhZAwGORUehB2D2U1skPy4XDF0Z+l
         X5wUuG8t03GwOlQq4ZMFMjFdu+AQ4HvODO/rvSg3AC7Glxx+43QFn+qPoeCJqj+LSMDc
         ZUKw7qWMaGgIfyDIhoG3TSfwT+/fMHnkJnORnJwgpN7ykeOGfEqsqZLPYQZGlFg6jsDn
         hKnbh8grkLCj/rW6v5uYMn0TEzAIfLZt1x5DqWRIW+wEXSqLY8MB+WD36cbOkCjoUnCR
         a4PFKH71fNc+yTMTkQpTu97FCZR8LLHQbIsqROuaSkKNluGW6M3nIwHiHA708uMOTR0C
         NivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764178557; x=1764783357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3LnxOto2dZ6OYzzuXq4UGN4Fc7DmOH/l4Y+1TMNHIpI=;
        b=QE6Ukxa60kx12TqpsNwvHTpWyrYEQ5Nz4YtOupw15wxkqs9KFqUPBN/9XSWh/7BJkN
         hd3W1X+p3aUZGHyMMHHLbMBtUOpmTdH4AoA4qEGhnzxBRHHwl90dwXhpzau/vDdUbhx/
         UtEmLllwI3VkgAjskfNO/T58FggBuivuwwSEVRQvuhJ20YvUfn/mWPZvWvnbwFDDes02
         Wkfz3pkj5sEgU3KMVCLLSAfn8PQUbpLYJX89AsjEFWX+jO3YiHxfTbGEJEE/JBnU/e2o
         tc7eNmC9rPzvxm6O0137cKGkO/K/GPHJK6jLjKaOlOOEB+f94azT+Y0/t6OGIZkQovkM
         tZ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBNqpXSEtTZDN0pHm8qkj/6v+ukLHHVVq2zfsX9Z+VlMOuHl9mArZhZTKzuvZuSxQElv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWyMXaJb4XoFFYmJZCqqvHozaYdlv04rKEOrDMw206cHD1KYjj
	bXPJpvpsoEO73TrTShku2akjhTnctfzpfNK+iX2V+bPY49VUFcSvXuyfEf4RVP5nmNg5I2sx4qo
	9YX2tLE25ajDaglSo32/Xfdl+pEkG/L8=
X-Gm-Gg: ASbGnctHrulLDh+JEIGY4R4bDnqY3gDPE49f1AIW1adu4nv9TTxQa+80B+xCTO7QPMQ
	h5KEUSR2LRpt+xySuuFHIqAjZS1Uyq2rAYPghHbEZY8kEBrX41p1+xdG4plx1pqmvHXoYNw+O16
	SXyJi32ort/TpwuIf/82AVhPzWEXcGJe2mixLgWgRtwP9VTt6Ixzvu7die5ukoWJa1ttEcqSQwW
	0r/rrC8sPoG5fuAdTc25enPWTJGtur07+wFxZVUsYYgXFM8LPZI8i+0TAKWZk/qNPhOCCPezzLl
	dMFsHEdJM4KJA3lg6fXFxcV1GgGP
X-Google-Smtp-Source: AGHT+IE9X4rOUi99RkT5bq4+VfDVLT9XZjXcfAMdo94F6gEsAGNHo0UucwI7jGMb3spHImDZ8t2z7y2Eh9zM0mbJf38=
X-Received: by 2002:a05:6638:6374:b0:5b7:33d3:6f6c with SMTP id
 8926c6da1cb9f-5b967a7bc85mr13268146173.15.1764178557554; Wed, 26 Nov 2025
 09:35:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251125170056.34489-2-siddharthasthana31@gmail.com> <d563b68b-e01d-4b18-bd84-86f36e61a70d@gmail.com>
In-Reply-To: <d563b68b-e01d-4b18-bd84-86f36e61a70d@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 26 Nov 2025 09:35:46 -0800
X-Gm-Features: AWmQ_bl9JvrqHOYaur4jLvgyzttmOAygEcapzLM7rcDdsiaNzqatFgRo_yHgvOY
Message-ID: <CABPp-BEF1RVs7n4xf6ihyPUmxrhgpG6VEpZLrX=MTgcBWBRbfA@mail.gmail.com>
Subject: Re: [PATCH 1/1] replay: add --revert option to reverse commit changes
To: phillip.wood@dunelm.org.uk
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org, 
	christian.couder@gmail.com, ps@pks.im, gitster@pobox.com, 
	karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com, 
	jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 3:10=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Siddharth
>
> On 25/11/2025 17:00, Siddharth Asthana wrote:
> >
> > diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.a=
doc
> > index dcb26e8a8e..ad7dc08622 100644
> > --- a/Documentation/git-replay.adoc
> > +++ b/Documentation/git-replay.adoc
> > @@ -54,6 +54,18 @@ which uses the target only as a starting point witho=
ut updating it.
> > [...]
> > +To revert a range of commits:
> > +
> > +------------
> > +$ git replay --revert --onto main feature~3..feature
> > +------------
> > +
> > +This creates new commits on top of 'main' that reverse the changes int=
roduced
> > +by the last three commits on 'feature'. The 'feature' branch is update=
d to
> > +point at the last of these revert commits. The 'main' branch is not up=
dated
> > +in this case.
>
> I'm struggling to understand when I'd want to do this. Why would I want
> to update 'feature' to point to the reverted version of its last tree
> commits rebased onto 'main'? In order to understand I ran the first
> tests case which does
>
>         git replay --onto topic1 --revert topic1..topic2
>
> after fixing it by adding --ref-action=3Dprint the resulting commit log
> looks like
>
> commit d337fab78e90008835f74e890039b464a0308cbe
> Author: author@name <bogus@email@address>
> Date:   Thu Apr 7 15:30:13 2005 -0700
>
>      Revert "E
>      "
>
>      This reverts commit bceb3acd81ddd36ba0da391fffa48949a1337276.
>
> commit 47f0cc1c1f1911c0047a4d79d79f7c19c6c7151a
> Author: author@name <bogus@email@address>
> Date:   Thu Apr 7 15:30:13 2005 -0700
>
>      Revert "D
>      "
>
>      This reverts commit d953cf2dcc1da8b51934e43fd83dac72d0e267c7.
>
>
> The commits are empty because the original they are reverting each
> create a new file which is then present in the base revision but not in
> either of the merge heads when we revert. This suggests to me that it is
> not a very realistic test and I'm still scratching my head to see where
> "git replay --onto <commit> --revert" is useful.
>
> If '--revert' does not make sense with '--onto' then perhaps it should
> be a new mode that takes a ref and acts like '--advance' but reverts the
> commits rather than cherry-picking them. When reverting a range of
> commits it would reduce the likelihood of conflicts to revert then in
> reverse order so we should either recommend passing '--reverse' or make
> that the default when '--revert' is given.
>
> As you can see in the log output above the new function to format the
> revert subject lines is buggy. If you had used test_commit_message() to
> check the commit message, rather than just grepping for ^Revert the
> tests would have picked that up.
>
> Thanks
>
> Phillip

I was going to say the same thing, but from a different angle.

The sequencer in git is used for three different types of operations:
rebasing, cherry-picking, and reverting a range (with a sequence of
reverts rather than one big revert).  In replay, these correspond to
--onto, --advance, and the new thing you are trying to add.  As such,
it should be its own new mode.

(I do tend to see ranges reverted by a single big revert, the way
Johannes suggested, rather than as a range of individual reverts, so
to me the utility of the new mode looks low, but perhaps others find
more utility in it.  Or maybe the intent is to only use it with a
revision range that is only one commit long?)

Phillip also went into more detail about why "--onto $COMMIT --revert"
specifically doesn't make sense.  I'd also say "--advance $BRANCH
--revert" doesn't read well because to users, "revert" means going
back while "advance" means going forward, so it's a rather confusing
command line to make them wrap their head around.

And yes, Siddharth, you were right that the new mode should be
incompatible with --contained, but that's because --contained is a
special modifier of --onto.  --onto, --advance, and --revert are three
different modes that are incompatible with each other.  Once you've
checked for that incompatibility between the three modes, then you can
either check that whenever --contained is specified, either --onto is
as well, or neither --advance nor --revert are.
