Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F33C48780
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrUSv9NT"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c6736d10fso848855e9.1
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 11:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703102067; x=1703706867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xw1Xq9mm8jREOnfAUyfMMg5twcPB7N2a6JMExNZHTyY=;
        b=KrUSv9NTbcTuKCaFJ80dytrdH/mMyXZ1WnzBcUJEwIrAELofbKJ2KE+irTB54gVN1S
         i1ZiyJjA2KNl56BTQi37aK2QYps12QfWyggA/yyeRDpLsVxw28W47VkakFrHIaseTyVn
         o8T1fvLAbgx4JnibX58ukAMeHJlf8GonOPCt3BPNYW2rL0Vjp8x0z0MYxIY0R9I50J8/
         5hTY7n1RDCZU4mVnMshVUZavQKquD0GGi/6V1YdWpseb+3sW78BQh2qhR9Qd8CY0RulI
         fLd5LvjplCQMSmh5yJDJNx49xXfqPrWvrMDiu9vWIja4cH0nv/ErZMykaZj9AYw3C7JU
         rJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703102067; x=1703706867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xw1Xq9mm8jREOnfAUyfMMg5twcPB7N2a6JMExNZHTyY=;
        b=AK8BBEHNi/cuGvoY1LNR498/pnsqZQm3eBRkLBLHfILKCXWYyHni6NElCWKFOayXXv
         cqzwDIKMtB36Zhuov7eS2J+a2YoOY3i0GCRTE8uUhMH0fH6ib0wuS7gRZNJBMW50y+b/
         m355K5WyfqjL+2GthUJoYv1R82JZy8YZRYUlHWeofr1J7rudZMCz/eaVD1pqlxdHnZ4T
         c0kgH03hz3JW1edy1WpzVh5ijwA2QfySbmsv+XKcKA6zE0DSljpsgrtsBG++LC7sWnOb
         OgVBXN5QZ+Vw1Zti3MHrGKFSYYqru8L+r5IVuOUmPbiPoPg9dPyoBtkJ1cua7QZaHpY2
         d15A==
X-Gm-Message-State: AOJu0YyTfLeJYu+NhfK07LkSjWo5Y1w0soPKkN9gc5fQgxKrtP02lPL6
	SsPndsKV+z54sZtLFVyEaXg=
X-Google-Smtp-Source: AGHT+IH8mQQqBLrqHmeLbyvYmaoaah4Fw0ijxhzQQ6lwmxYsbb1Z1YNn2CvBcjhUcLEq9YUXULmtOg==
X-Received: by 2002:a05:600c:5185:b0:40c:48c2:f531 with SMTP id fa5-20020a05600c518500b0040c48c2f531mr131178wmb.42.1703102067147;
        Wed, 20 Dec 2023 11:54:27 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd7-e0bf-0-e5b0-3039-5d18-ec57.ipv6dyn.netcologne.de. [2001:4dd7:e0bf:0:e5b0:3039:5d18:ec57])
        by smtp.gmail.com with ESMTPSA id l10-20020a05600c1d0a00b0040b2c195523sm8710001wms.31.2023.12.20.11.54.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Dec 2023 11:54:26 -0800 (PST)
From: Michael Lohmann <mial.lohmann@gmail.com>
X-Google-Original-From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: l.s.r@web.de,
	Elijah Newren <newren@gmail.com>,
	gitster@pobox.com
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH 0/2] Documentation/git-merge.txt: fix reference to synopsis
Date: Wed, 20 Dec 2023 20:53:40 +0100
Message-Id: <20231220195342.17590-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <c6814a39-b4f9-4b1e-b81b-45ffe4aa7466@web.de>
References: <c6814a39-b4f9-4b1e-b81b-45ffe4aa7466@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey!

Thank you all for your great reviews!

> Thank you for this patch and sorry for the nitpicking below!

No need to be sorry - this is what I am here for since it is the only
way to learn ;-) (also I am not a native speaker, so I know I am
constantly making mistakes)

> "Synopsys" is a software company.  A "synopsis" is a brief outline.

Oh yeah... Now I need a face-palm emoji :D This is what you get from
trusting the spell check for words you just tried to copy far too early
in the morning... And another thing to learn for me: don't submit
patches while you are not yet fully awake... Sorry for everyone who had
to read the first draft! That was indeed not very professional from
me...

> Had to think a moment before I understood that "enumeration" refers to
> "The second syntax" and "The third syntax", which have been combined
> into this line:
>
>        git merge (--continue | --abort | --quit)
>
> And it does make sense that we can no longer say "second syntax" and
> only refer to "git merge --abort", or "third syntax" and mean "git
> merge --continue".  In other words: References by number are no longer
> valid after a merge of some of the synopses.

That sums it up a lot better. I wasn't happy with my first draft, but
couldn't come up with something better - now I used your explanation
with a slight variation.

> > The connection between these two sentences feels weak to me.
>
> This sentence is a bit more problematic than that: Even when there are
> no conflicts, "git merge --no-commit" will also stop a merge, and one
> can then use either --abort or --continue.  So the assertion made by
> this sentence that you're reviewing is not accurate.

Oh! Another thing I learned today! Thanks a lot for pointing that out!

I have to confess: I copied that sentence 1:1 from git-rebase - that is
also why it did not fit in with the next sentence... But Renés
suggestion just avoids this (and the "--continue") problem altogether,
so I went with a slight variation of it instead.

> I like this alternative wording

Same! I fumbled around with it just a bit to include your hint

> Possibly.  This looks like a case of me making a mistake while
> criticizing someone else's grammar, though.  Which happens almost
> every time. o_O

We all make mistakes (and my own grammar is horrific...), but the more I
appreciate it when people suggest/ask things because that always gives
me the opportunity to learn as well. And you are totally right in that
this sentence does not "feel quite right" anyways, so I understand your
unease with it and why you wanted to discuss it ;-)

> Just being nitpicky and curious, but does the abort/continue also
> apply when you run "git merge --no-commit"?

Yes, indeed that seems to be the case (also pointed out simultaneously
by Elijah Newren). I extended Renés suggestion to mention it as well.

> > The only guidance I found is this paragraph from CodingGuidelines:
> >
> >    Literal examples (e.g. use of command-line options, command names,
> >    branch names, URLs, pathnames (files and directories), configuration and
> >    environment variables) must be typeset in monospace (i.e. wrapped with
> >    backticks)
> >
> > So shouldn't we wrap all commands in backticks and nothing more?
> > Probably worth a separate patch.
>
> Thanks for a good review.

Indeed! That was very nice!

And I also added the suggested changes as a second patch. It applies
just fine to master without the first one, though that obviously would
leave the changed paragraphs from the first commit with the mixed
syntax, but that would just be a minor inconsistency until the first
patch (or a future version of it) is applied.

Cheers
Michael

Michael Lohmann (2):
  Documentation/git-merge.txt: fix reference to synopsis
  Documentation/git-merge.txt: use backticks for command wrapping

 Documentation/git-merge.txt | 70 ++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

-- 
2.39.3 (Apple Git-145)

