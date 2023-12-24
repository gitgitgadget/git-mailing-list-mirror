Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0DC468C
	for <git@vger.kernel.org>; Sun, 24 Dec 2023 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kokzz4wu"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e7288a6e1so972794e87.2
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 23:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703403973; x=1704008773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjZydqF3LeTxtBX2dPOoLY26aABENcOgBRv0b6cdqLg=;
        b=Kokzz4wubSZt4C9vW6xxY8oMPLV9NJ5Yt2IhmAX74hglOyiPSRJFxlLqhhb/Tecc2q
         eNxbP5NDypSsEyCZe0GAXzG92r9pKLi8+6d2vezw2zt3IRAsojNSCTD39ksGUeUO6Lze
         4ApGJy4BwuAkka5YclgNXA/++fe4m2eQoS13BA0l7mgfDWiNANV937l3ts2qWIDzZDgf
         UzCMTj/Y0KcvBBdw0q77rz+net721oPOwabAqpKd83Fm8xpy+YDbBaoxN9lro0Rp3qnL
         4A3VkHR8ZVjTHY9Xefcbig70c7Y4Lvvxf1stHo27VKpXPcJ+C9odyqrWCvEMdKWrZrAI
         RBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703403973; x=1704008773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjZydqF3LeTxtBX2dPOoLY26aABENcOgBRv0b6cdqLg=;
        b=PcOjQsCmFtP/efj9UFI7xrWuVPZD8TZIVO4eme0/w828on2yAQOUoRLAFsthpCPkYR
         OqPVPqXfwgd+jhS9SryARUTRpa+RFIy5DDTz2+mdCnBRzC+k9Nn736bTpxXBdsNXliAM
         wbbMwcO/X4chpJ/qm0XqmsDMTpdAGFS6KQJw8vVMvp7vgXfKN6Tw4R+CQH2MFCiaGYDo
         VQvBEEoTq6Cc0SGTI7RuU5xg8n69ny7Gpe/qhsJ85cg+Ho8H/dFXS3mdZtqNWdpvopkv
         C6wBaInm7OhvgIY5lJuMznuDvzN7z9Q9l60Wt37haiiHtvAYYYjq3l1DQTz0ob9yRauN
         Tx7g==
X-Gm-Message-State: AOJu0Ywa2FiiU3Txa3RG5fZ3glK2nQVuYctGZD9/dzXmVv2/boIyBa0/
	qgSDfInaPaDCWnrAqZmwJIKbSwfeQmAisQnqq9lOLFPQwyI=
X-Google-Smtp-Source: AGHT+IHIop+5hoArLQr2QlTiXdPvmlxl+00HX6FoPy6iHp/57cxROR9MwZhyR3Ok6qDZxpdivhB8fijTNFDNGh91r/k=
X-Received: by 2002:a05:6512:2fc:b0:50e:242a:775e with SMTP id
 m28-20020a05651202fc00b0050e242a775emr1655624lfq.106.1703403973193; Sat, 23
 Dec 2023 23:46:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <LO6P265MB6736043BE8FB607DB671D21EFAAAA@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
 <CABPp-BHYaxa7QoXabM=7hW-93hQLK-=KayGtDHtWxxdAnJCcJw@mail.gmail.com>
 <LO6P265MB6736F5F9E8368A9DE95D294FFAA9A@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
 <CABPp-BHEX+SyophEfgRqDbNdrAS3=bptt_cKzHLBSutnBAxexw@mail.gmail.com> <990ab7d5-e29a-4766-b112-c8908a7ed196@iee.email>
In-Reply-To: <990ab7d5-e29a-4766-b112-c8908a7ed196@iee.email>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 23 Dec 2023 23:46:01 -0800
Message-ID: <CABPp-BEdSGBt7DCrJCmOtG+RgZ2F3fNZQJ91PjZQxNa-ShKf8g@mail.gmail.com>
Subject: Re: Git Rename Detection Bug
To: Philip Oakley <philipoakley@iee.email>
Cc: Jeremy Pridmore <jpridmore@rdt.co.uk>, "git@vger.kernel.org" <git@vger.kernel.org>, 
	Paul Baumgartner <pbaumgartner@rdt.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philip,

Sorry for the late reply; I somehow missed this earlier.

On Wed, Nov 15, 2023 at 8:51=E2=80=AFAM Philip Oakley <philipoakley@iee.ema=
il> wrote:
>
> Hi Elijah,
>
> On 11/11/2023 05:46, Elijah Newren wrote:
> > * filename similarity is extraordinarily expensive compared to exact
> > renames, and if not carefully handled, can sometimes rival the cost of
> > file content similarity computations given our spanhash
> > representations.
>
> I've not heard of spanhash representation before. Any references or
> further reading?

You can find more in diffcore-delta.c, especially the big comment near
the top of the file.  But here's a short explanation of spanhashes:
  * Split files into chunks delimited either by LF or 64 bytes,
whichever comes first.
  * Hash every chunk into an integer between 0 and 107926
  * Keep a character count for each of those integers as well (thus if
a line has N characters, but appears twice in the file, the associated
count for that integer will be 2N).
  * A "spanhash" is the combination of the integer that a chunk (or
span) hashes to, plus the count associated with it.
  * The list/array of spanhashes for a file (i.e. the list/array of
integers and character counts) is used to compare one file to another.

Now, why do I claim that comparison of filenames can rival cost of
file content similarity?  Well, in a monorepo of interest, the median
sized file is named something close to
"modules/client-resources/src/main/resources/buttons/smallTriangleBlackRigh=
t.png"
and is 2875 bytes.  As a png, all its chunks are probably the full 64
characters, which works out to about 45 chunks (assuming the 64-byte
chunks are different from each other).  The filename is 79 characters.
So, for this case, 45 pairs of integers vs 79 characters.  So, the
comparison cost is roughly the same order of magnitude.
(Yes, creating the spanhashes is a heavy overhead; however, we only
initialize it once and then do N comparisons of each spanhash to the
other spanhashes.  And we'd be doing N comparisons of each filename to
other filenames, so the overhead of creating the spanhashes can be
overlooked if your merge has enough files modified on both sides of
history.)

Yes, this particular repository is a case I randomly picked that you
can argue is special.  But rather than look at the particular example,
I think it's interesting to check how the spanhash size vs. filename
size scale with repository size.  From my experience: (1) I don't
think the median-sized file varies all that much between small and big
repositories; every time I check a repo the median size seems to be
order of a few thousand bytes, regardless of whether the repository
I'm looking at is tiny or huge, (2) while small repositories often
have much shorter filenames, big repositories often will have
filenames even longer than my example; length of filename tends to
grow with repository size from deep directory nestings.  So, between
these two facts, I'd expect the filename comparison costs to grow
relative to file content comparison costs, when considering only
median-sized files being modified.  And since it's common to have
merges or rebases or diffs where only approximately-median-sized files
are involved, I think this is relevant to look at.  Finally, since I
already had an example that showed the cost likely roughly comparable
for a random repository of interest, and it's not even all that big a
repository compared to many out there, I think the combination
motivates pretty well my claim that filename similarity costs _could_
rival file content similarity costs if one wasn't careful.

I don't have a rigorous proof here.  And, in fact, I ended up doing
this rough back-of-the-envelope analysis _after_ implementing some
filename similarity comparison ideas and seeing performance degrade
badly, and wondering why it made such a difference.  I don't know if I
ever got exact numbers, but I certainly didn't record them.  This
rough analysis, though, was what made me realize that I needed to be
careful with any such added filename comparisons, though, and is why
I'm leery of adding more.
