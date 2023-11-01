Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C767F
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 00:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7BhG033"
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EE3F3
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 17:21:59 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a3b8b113so9021286e87.0
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 17:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698798118; x=1699402918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/giue7ceJ+eUS1/jH7Dl+oU0XZCGlunXRizGTYO0u6c=;
        b=b7BhG033x0o2mYPra80ksmEQN09CaiM+s8esfwB4yrzrK63BhZIc6USfhMDN4rwrXq
         Sjn6vDCoBiAs7nYSs6Jin8O5Nh25CnQZn6gBItYDev+oldbIxZl5zrZdsgvusTLPVq6V
         xuZmapj7ABv0xsfcZ/78yR5+IvTUPKtiMR3U6jisSTULm3Qe43hFaE1kCyrRMvvX69Db
         9cWmh2fv13XH5qeoEjRkxjCry99oFCjKUAJd7e9fULrpZIuGgTTuoVu5EerZSemWTyX+
         IRoSiFDRyfDRWwA6hXIOAv9mP6VyoqN6m9Nyfr/ChHP2o6E9htP97TogVy9hFtfeaIWV
         0hwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698798118; x=1699402918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/giue7ceJ+eUS1/jH7Dl+oU0XZCGlunXRizGTYO0u6c=;
        b=PcMpeKUbCKDGDu8lUzGd7vlLHHpDMpmHNLwdE/gUIKthEl5ZOzogKpiVgQGoHDihiF
         rMGA8++AGDtOGtM9W3lF+oA9pkmOzWIPMIdZm29BUPHSYhiOowxfNjJqJXV11OKEAbSY
         li1TelpSZjSMnhG+j8ki4LokLDyghZh1QepHNAA//cC6+0GTA0r3Ed9qT3i/NbY2Eg1V
         uHQ1pwPsE3TeGuHvnrwPEmvRx2MDnUnwf1mBF1uZ1yEl3PaPNaTOD4Ay5k5KdyYRrMrp
         0NBZRIHXfJHzbNVQXKa2lnJLh3Xx4IV02hv0SXRmZUuZ6fELAIQwpq+8NnTej5RwXgzA
         T1TQ==
X-Gm-Message-State: AOJu0Yw6vaW77GmHiAXlT0I8o+5bGnefeDykLlc0a7LtSRrFHoLI+FV7
	rNAt5r80aEv8GNVlXgZjs39DxgkXHBplQa9VFpHK0m5A
X-Google-Smtp-Source: AGHT+IFteLiJwvhzs3zti1TrgLVsppiX9SGDLYa6vIyyH09z834MUSsqSSS0iREb+5z1uEHozpkSS7aiyE7vMJ7qKCI=
X-Received: by 2002:a05:6512:3282:b0:503:28cb:c087 with SMTP id
 p2-20020a056512328200b0050328cbc087mr10182616lfe.29.1698798117639; Tue, 31
 Oct 2023 17:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1603.git.1698635292629.gitgitgadget@gmail.com>
 <pull.1603.v2.git.1698728952.gitgitgadget@gmail.com> <CABPp-BEjV0H=waNQfKNNqibs3g_BU1CCrNjb8G8h_jXrt8kaiw@mail.gmail.com>
 <f59f75cd-1991-456a-9ea6-638b39711bf1@gmail.com>
In-Reply-To: <f59f75cd-1991-456a-9ea6-638b39711bf1@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 31 Oct 2023 17:21:44 -0700
Message-ID: <CABPp-BFzY8S=tE7JHy0MUrW2R+X7=pcUBVdPbRC5CpEVv=G+pg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] sequencer: remove use of hardcoded comment char
To: phillip.wood@dunelm.org.uk
Cc: Tony Tung via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Tony Tung <tonytung@merly.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 4:18=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Elijah
>
> On 31/10/2023 06:55, Elijah Newren wrote:
> > Hi,
> >
> > On Mon, Oct 30, 2023 at 10:09=E2=80=AFPM Tony Tung via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> Instead of using the hardcoded # , use the user-defined comment_line_c=
har.
> >> Adds a test to prevent regressions.
> >>
> >> Tony Tung (2):
> >>    sequencer: remove use of comment character
> >>    sequencer: fix remaining hardcoded comment char
> >
> > The second commit message seems to suggest that the two commits should
> > just be squashed; there's no explicit or even implicit reason provided
> > for why the two small patches are logically independent.  After
> > reading them carefully, and digging through the particular changes
> > being made and what part of the code they touch, I think I can guess
> > at a potential reason, but I feel like I'm crossing into the territory
> > of mind reading trying to articulate that reason.  (Besides, my
> > rationale would argue that the two patches should be split
> > differently.)  Perhaps a comment could be added, to either the second
> > commit message or the cover letter, to explain that better?
> >
> > More importantly, though, I think the second commit message is
> > actually wrong.  Before and after applying this series:
> >
> > $ git grep -c -e '".*#' -e "'#'" -- sequencer.c
> > sequencer.c:16
> >
> > $ b4 am c9f4ff34dbdb7ba221e4203bb6551b80948dc71d.1698728953.git.gitgitg=
adget@gmail.com
> > $ git am ./v2_20231031_gitgitgadget_sequencer_remove_use_of_hardcoded_c=
omment_char.mbx
> >
> > $ git grep -c -e '".*#' -e "'#'" -- sequencer.c
> > sequencer.c:12
>
> As far as I can see those remaining instances are all to do with the '#'
> that separates a merge subject line from its parents. I don't think we
> need to complicate things anymore by respecting core.commentchar there
> as the '#' is not denoting a commented line, it is being used as an
> intra-line separator instead.

Ah, that might be jogging my memory slightly.  I had a patch to put a
comment before the one-line commit summaries in the TODO list
(https://github.com/git/git/commit/f1ae608477e010b96557d6fc87eed9f3f39b905e=
).
I think I at some point noticed comment_line_char, and went to switch
to it, probably also switching the mid-line comment char for merges,
and then noticed the potential for breakage due to the manual parsing
of those.

Anyway, I trust your analysis, but I believe some of that analysis
belongs in the relevant commit messages if we push forward with these
changes.

> > Granted, four of those lines are code comments, but that still leaves
> > 8 hard coded references to '#' in the code at the end (i.e. the
> > majority are still left), meaning your second patch doesn't do what
> > its subject line claims.
> >
> > And, most important of all is still the first patch.  As I stated
> > elsewhere in this thread (at
> > CABPp-BFY7m_g+sT131_Ubxqo5FsHGKOPMng7=3D90_0-+xCS9NEQ@mail.gmail.com):
> >
> > """
> > I think supporting comment_line_char for the TODO file provides no
> > value, and I think the easier fix would be undoing the uses of
> > comment_line_char relative to the TODO file (perhaps also leaving
> > in-code comments to the effect that comment_line_char just doesn't
> > apply to the TODO file).
>
> I agree that I don't see much point in respecting core.commentchar in
> the TODO file as unlike a commit message a legitimate non-commented line
> will never begin with '#'. Unfortunately I think we're committed to
> respecting it - see 180bad3d10f (rebase -i: respect core.commentchar,
> 2013-02-11)

Thanks for digging up the old commit and the explicit mention of the
TODO file.  Kind of disappointing.  While I can't imagine anything
that would actually break by reverting this, it's not worth it at this
point.

> > [...]
> > I feel quite differently about patches that make COMMIT_EDITMSG
> > handling use comment_line_char more consistently since that code
> > simply writes the file without re-parsing it; although fixing
> > everything would be best, even fixing some of them to use
> > comment_line_char would be welcome.  I think the first two hunks of
> > your second patch happen to fall into this category, so if those were
> > split out, then I'd say those are good partial solutions.
>
> I think splitting the changes so that we have one patch that fixes the
> TODO file generation and another that fixes the commit message
> generation for fixup commands would be best.

That would seem more logical to me.
