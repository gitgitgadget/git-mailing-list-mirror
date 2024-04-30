Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316A81BED61
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714513736; cv=none; b=R90cP48bByGg4sF7G8FUvjCmC/I8IXA4GIz0HxopJvbh4z3O7Qx8PpO5BiNhJPMO5Uo3vUIRjuOS/LuEDhNWJqIrLqHDQr5HpmsK6BEwkHJxEB6Irb1J46jBwG/geEZbk4dOH4G7Bx/2BkT+IlPrmNJS/m1oGjuLChTE2ZMveGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714513736; c=relaxed/simple;
	bh=PyBEFViV/Px2h/amLO6AWbD7p+d3S6Tvm0Ou4mWQktw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4nEYYzYrvxDQJemcywbnf11M/VZOE6PmmKPrrH1CxL5PBv9WqfByT1jqBxSjxXxS3ThR6Ese6G04tcZvqU+ttOxN7/CwjOPgErDp50buSSUNMKC7jtZoCgjJd+tRXxTr7wgPhvVPsrJmMBoUw6wMvoDqV4LI1fSyxHGFgGoqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clh4xyWk; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clh4xyWk"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4702457ccbso823900766b.3
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 14:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714513732; x=1715118532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJWSqJ8j3WE9Yyy3Aq+RlGjReOG/X1+WU1IYTrvClIM=;
        b=clh4xyWkBbqSEHocfpqBf2478sVOYE40mtTI7tUq7EzS2wA9Rm3Rz1v3egvRcYprvH
         CPMLfQBaMmWZXh91hZgepFwhgV5SWfFGLJUGR/aqkNdECTdR57vNRrsA+ny6o0E0Kixp
         IV0qkrRJcQ3ASy8M24J1V5rtQvdCQmLMwg+rcdamRjH98MuRH+JBYX3AI2VLFcYcxrTW
         D6orgXXBBftEcW35WYW0NzRWfrcoi3jtznNBTzNKRXGB+7Cgh9/YknBf+L/f4Od5K5Gi
         qq9brv/3/EfWyl3WLoFLWjXCT/QUwgPnTlg6RDp9XRCGIoVYofok9xP7T33if8OoxRHN
         mb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714513732; x=1715118532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJWSqJ8j3WE9Yyy3Aq+RlGjReOG/X1+WU1IYTrvClIM=;
        b=HdsGXD5Q35ZWp6aCwBymvxGhu0j0EVQNR7m8iOiZ7KS3flLw0yRFq+BRIhbq4+/ht3
         /K0q5iwXrm7IjSHx9gDx/7U7rJG6ovawE/kRQFY7L7pTuklKzG7+NfDN+T1M9fFdJ3ag
         xOHqvU+aMTjKbCnjJHSqAhwJdEyfrbC/r1oHma4taYLDKEAmfSfGQtclsWJuCoA3OJ1t
         T+Wma/xAyQN6BbNhLW8ucE89jvkPv5zaU4XJxROlH50lQfpzyP5CWbow6jajOmlg4wyI
         C1pqy9A9+7ehmXzUwyU3BpXfCKyL3OG74fPTJslDMcPjzdUVV2NE/B+lQ8w4Njp1ZJWI
         ZLDg==
X-Forwarded-Encrypted: i=1; AJvYcCXRrCA9gx5yb9cQedXraizwPwObI653MPrZyxoV7SDqxwHbKtcNiB7aOVC/ZKCb0FIIXJXgqLRE/z31BEEpQbK/aKrg
X-Gm-Message-State: AOJu0YwQhRr/+ztgrzpfJrIjEes7wzXN/9dHcr2sttjd03I9gJbI+8tU
	irKyIqEKitJ4nXKeDLdhCH9yJK8RU4uhkCw8/KENFIKcUczwLOGCTdXpRgeQI7BxfLGdeN9diCy
	Oiib3hgSd/gXnMG6RwXnbv2EbUXE=
X-Google-Smtp-Source: AGHT+IHUDHc5TYwylcBFIQlUv0ZLmok/noRDxjjIpjcloEpyBAQ12Smh/qPuiHE4rns8mhfUPLhhHURKzUJ6O1q+81o=
X-Received: by 2002:a17:907:940c:b0:a59:5191:f0c0 with SMTP id
 dk12-20020a170907940c00b00a595191f0c0mr29923ejc.2.1714513732141; Tue, 30 Apr
 2024 14:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1723.v2.git.1714409638089.gitgitgadget@gmail.com>
 <pull.1723.v3.git.1714416863.gitgitgadget@gmail.com> <5b6239167b8d7c26f96e5c23d0d82b7a3a9b01fe.1714416865.git.gitgitgadget@gmail.com>
 <xmqqv83yrduw.fsf@gitster.g>
In-Reply-To: <xmqqv83yrduw.fsf@gitster.g>
From: John Passaro <john.a.passaro@gmail.com>
Date: Tue, 30 Apr 2024 17:48:14 -0400
Message-ID: <CAJdN7Kggv-y8xRhdFanTyxa5wP-bG0omBPuETW6qijA67gn8oQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] builtin/tag.c: add --trailer arg
To: Junio C Hamano <gitster@pobox.com>
Cc: John Passaro via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 12:53=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>

Thanks for the feedback. Hoping for a couple points of clarification
then I'll put in one more version of this patch series.

> "John Passaro via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: John Passaro <john.a.passaro@gmail.com>
> >
> > git-tag currently supports interpreting trailers from an annotated tag
> > message, using --list --format=3D"%(trailers)". There is no ergonomic w=
ay
> > to add trailers to an annotated tag message.
>
> Well said.  Drop "currently", though.  The usual way to compose a
> log message of this project is to
>
>  - Give an observation on how the current system work in the present
>    tense (so no need to say "Currently X is Y", just "X is Y"), and
>    discuss what you perceive as a problem in it.
>
>  - Propose a solution (optional---often, problem description
>    trivially leads to an obvious solution in reader's minds).
>
>  - Give commands to the codebase to "become like so".
>
> in this order.

Understood. In the most recent version of this patch, I updated the
message. However on second thought I think I'm gonna keep this on
the next submission of this patch (without "currently" of course).

>
> > In a previous patch, we refactored git-commit's implementation of its
> > --trailer arg to the trailer.h API. Let's use that new function to teac=
h
> > git-tag the same --trailer argument, emulating as much of git-commit's
> > behavior as much as possible.
>
> Nicely described.
>
> > @@ -178,6 +179,19 @@ This option is only applicable when listing tags w=
ithout annotation lines.
> >       Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
> >       is given.
> >
> > +--trailer <token>[(=3D|:)<value>]::
> > +     Specify a (<token>, <value>) pair that should be applied as a
> > +     trailer. (e.g. `git tag --trailer "Signed-off-by:T A Ger \
> > +     <tagger@example.com>" --trailer "Helped-by:C O Mitter \
> > +     <committer@example.com>"` will add the "Signed-off-by" trailer
> > +     and the "Helped-by" trailer to the tag message.)
> > +     The `trailer.*` configuration variables
> > +     (linkgit:git-interpret-trailers[1]) can be used to define if
> > +     a duplicated trailer is omitted, where in the run of trailers
> > +     each trailer would appear, and other details.
> > +     The trailers can be seen in `git tag --list` using
> > +     `--format=3D"%(trailers)"` placeholder.
>
> I can see this was copied-and-pasted from git-commit, but I am not
> sure if the ones used in the example are good fit for tag objects.
> What does Helped-by even mean in the context of an annotated tag?

I can see that the git project itself doesn't typically add trailers to tag=
s.
If y'all were in that habit I imagine this feature would already be
implemented :-)
Nonetheless Signed-off-by or Approved-by is easy to imagine, for example
in an environment where multiple sign-offs are required (i.e. not just
the implicit
sign-off of the tagger). So we could just leave that in and be done with it=
.

I have a couple more hypothetical trailers that are both plausible and some=
what
generic; do any of them seem expressive enough to include in the docs?

* Tested-by: T E Ster <tester@example.com>
* Testing-assigned-to: T E Ster <tester@example.com>
* Scheduled-Deployment-Date: 2024-05-15 (or 1714500385 -05:00)
* Deployment-assigned-to: Oscar P Staff <ops@example.com>
* (for RC/alpha tags) Full-release-scheduled-for: 2024-06-05

There's also project-specific trailers. For example, on my team,
we use "Deploy-Strategy: ..." to tell CICD what deployment routines to run.=
 This
is pretty specific to us but worth calling out. Maybe could translate to a
documentation example with something like "<Project-specific-trailer>: foo"

> > @@ -338,10 +344,22 @@ static void create_tag(const struct object_id *ob=
ject, const char *object_ref,
> >               }
> >               close(fd);
> >
> > -             if (launch_editor(path, buf, NULL)) {
> > -                     fprintf(stderr,
> > -                     _("Please supply the message using either -m or -=
F option.\n"));
> > -                     exit(1);
> > +             if (trailer_args->nr && amend_file_with_trailers(path, tr=
ailer_args))
> > +                     die(_("unable to pass trailers to --trailers"));
> > +
> > +             if (should_edit) {
> > +                     if (launch_editor(path, buf, NULL)) {
> > +                             fprintf(stderr,
> > +                                     _("Please supply the message usin=
g either -m or -F option.\n"));
> > +                             exit(1);
> > +                     }
> > +             } else if (trailer_args->nr) {
>
> When both should_edit and trailer_args->nr are true, this block will
> not be entered.  We first do the "amend_file" thing, and then run an
> editor on it, and that is the end of the story in that case.
>
> When we do not have should_edit (e.g., -m "tag message" is given),
> we would have run "amend_file" thing on it to tweak the message,
> and we come in here.
>
> > +                     strbuf_reset(buf);
> > +                     if (strbuf_read_file(buf, path, 0) < 0) {
> > +                             fprintf(stderr,
> > +                                     _("Please supply the message usin=
g either -m or -F option.\n"));
> > +                             exit(1);
>
> Does this error message make sense here in this context?  The
> earlier one was introduced by 7198203a (editor.c: Libify
> launch_editor(), 2008-07-25)---after we fail to run the editor, as
> we somehow seem to be unable to run an editor, we suggest the user
> to give us a message in other ways.  But this one is different.  The
> user gave us in one of these other ways already instead of using an
> editor, but mucking with that with the "amend_file" thing somehow
> made it unreadable.  Shouldn't it be more like
>
>         die_errno(_("failed to read '%s'"), path);
>
> or something along that line?

I didn't realize that the first message is intended to augment more
expressive failure messages previously printed in launch_editor().
Knowing that, your suggested message will point users in the right
direction much more effectively. Also i guess die() probably preferable
since unlike launch_editor(), which may signal non-exceptional failure,
this error is more likely to be a bug.

However, in service of helping users find workarounds, shouldn't we tell th=
em
--trailer may be the culprit?

> Failed to read '%s'. Try again without --trailer (use -e or -F to add tra=
ilers manually).
