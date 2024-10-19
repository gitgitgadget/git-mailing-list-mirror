Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306291DFDA3
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729336623; cv=none; b=WeehyVpNkAYuWUrWSuPhbYOEE/3VjFU9otOPJ90UoIr0d4VMRb1qEsQkxHD4tyP2X8K8KfSSMEc0PTaWy1fdZkuavb6EmgJkPg5Ol0VYOKz2uGVCms8czS99OC1rnCQtWgVTEQ9lidsMCstL2UOSYVG04hzRZYNWeLzY4E/SWvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729336623; c=relaxed/simple;
	bh=+JXwMpOBbUN9m+xb7iRU7ToDL0ncLr5SOfjTf5rUJP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOeh+T7e+9rMpmVJyk5NwM6n6OGh6KA7yuSedb973JqJ7hW6TqI5Qs6pjOvIbJUaPFujF+gW5YBg1HJ6urL35puynFfat2kBL0PKjJQBFIhfbTExZLcXEJDK3GNXimXCYq7i6wuNpPJF/cZE2dIuta44VzGb/ZyE6zlLlsKIg70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkzsUBfP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkzsUBfP"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so27695165e9.2
        for <git@vger.kernel.org>; Sat, 19 Oct 2024 04:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729336619; x=1729941419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYjx4/QtAPk+AqONQIxjvqd/z8n4D63q72tbAwsZHis=;
        b=TkzsUBfPn1CBoH3O5ABgK81ZSE9tmyxJ1xm61cWI2OIwO6ksfv6pFN7A07N6DenLq7
         ILv9XI5TaDgqt7evqdfcLJBgdvG+RlAOD6MuPJeDze+rax2jniUuOk7ZXD31Z6h3aNPs
         QSvkCrZcho3mU45zA5dUKdAABgrZYKyUPw985LrnLL8dnyTZ/cbpf19iWtt6j3lzp58l
         5bQRqE1OCoNgUYE/5gmbRkD8tE+G8LE6SQRpf8IiuKNqcEa3Rvgc996sPDXDqlWZacWL
         y9O0foDMzbUSkMGgjIIq6iUK6EkKiyU/u8JBY8rLDs5j4FAbZrKqRDseDJSgj2Llw3Qv
         EA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729336619; x=1729941419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYjx4/QtAPk+AqONQIxjvqd/z8n4D63q72tbAwsZHis=;
        b=iFPX7zwzXqYKjC7uq1EbZ+zxJXoJo/Lq+xfXxlfYt+/2cNu8Un0qKGhMaUQiOIqwdF
         d17/n+VXpa5/WRJ3ThDZ5nwsLwuO7PHVr+GNlIcysNs7oQNkNYYrjkh1jrsZBWjjEz+n
         OkUUXyoqggM53ZE1/efOHC33REyQVnADUWTnzV3mUHYpsw8m+ZwFMyCOa02kT53zsoE4
         juJEHXNITi6k70KQBucgUtrJi7OJfIetiCOXIGW9du8RCPYbXuax2OsG+CyLebVozP3/
         Dzr+ep/AW1q0gyrxuUs6R75OlbHCqL1JEixHM/krYJLotr/S4yO6BOwl11x588VCcUEV
         XLVg==
X-Forwarded-Encrypted: i=1; AJvYcCXx7bQMs7xgkwm96WjAgE+I+VZOWLXFo9zpcNs0Y+mOWXtYEsISV7QBXHyhxT5awFV7H4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRzF6Ot/SYBVv8c4sufNcIK3n8h2sB29d3z1z3VS1z2vXzcifW
	+n1vpocjC6HovP/eUCzy7TToNdX64BC1qvR4itIgOO5rmgxqyKt7Z2c/SV2/kR0NX0pJMLPdcB6
	xNCZuTuRheZuS3cwbp2QvlQVAk/g=
X-Google-Smtp-Source: AGHT+IFyw56Zv/sDymWUdH+2dxYW3tVqNZOz1uhLwakbBQfw0Qn2irZpYU2bSbs0+P5Aap/F0bkUZcNWpwjkW0sFq30=
X-Received: by 2002:a05:600c:4e12:b0:431:4a5a:f08f with SMTP id
 5b1f17b1804b1-4316161ee27mr43500265e9.4.1729336619098; Sat, 19 Oct 2024
 04:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <gitgitgadget/git/pull/1817@github.com> <gitgitgadget/git/pull/1817/c2423410614@github.com>
In-Reply-To: <gitgitgadget/git/pull/1817/c2423410614@github.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Sat, 19 Oct 2024 12:16:49 +0100
Message-ID: <CADYq+fYkGrbUWYmPVPQgAPqcnL-o8+Cq534-dKFHYLKV_y_Ttg@mail.gmail.com>
Subject: Re: [gitgitgadget/git] [Outreachy][RFC/PATCH] notes: teach the -e
 option to edit messages in editor (PR #1817)
To: "gitgitgadget/git" <reply+A2HXZ2QSSHERMIQQ2GNE246FD3Q27EVBNHHJVYOJHE@reply.github.com>, 
	sandals@crustytoothpaste.net
Cc: "gitgitgadget/git" <git@noreply.github.com>, Author <author@noreply.github.com>, 
	kristofferhaugsbakk@fastmail.com, Junio C Hamano <gitster@pobox.com>, 
	phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 1:43=E2=80=AFAM gitgitgadget[bot]
<notifications@github.com> wrote:
>
> On the Git mailing list, "brian m. carlson" wrote (reply to this):
>
> On 2024-10-19 at 00:14:13, Samuel Adekunle Abraham via GitGitGadget wrote=
:
> > From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> >
> > Notes can be added to a commit using the -m (message),
> > -C (copy a note from a blob object) or
> > -F (read the note from a file) options.
> > When these options are used, Git does not open an editor,
> > it simply takes the content provided via these options and
> > attaches it to the commit as a note.
> >
> > Improve flexibility to fine-tune the note before finalizing it
> > by allowing the messages to be prefilled in the editor and editted
> > after the messages have been provided through -[mF].
>
> I don't use the notes feature, but I definitely see how this is valuable
> there much as it is for `git commit`.
>
> > diff --git a/builtin/notes.c b/builtin/notes.c
> > index 8c26e455269..02cdfdf1c9d 100644
> > --- a/builtin/notes.c
> > +++ b/builtin/notes.c
> > @@ -489,6 +489,8 @@ static int add(int argc, const char **argv, const c=
har *prefix)
> >   OPT_CALLBACK_F('c', "reedit-message", &d, N_("object"),
> >   N_("reuse and edit specified note object"), PARSE_OPT_NONEG,
> >   parse_reedit_arg),
> > + OPT_BOOL('e', "edit", &d.use_editor,
> > + N_("edit note message in editor")),
> >   OPT_CALLBACK_F('C', "reuse-message", &d, N_("object"),
> >   N_("reuse specified note object"), PARSE_OPT_NONEG,
> >   parse_reuse_arg),
> > @@ -667,6 +669,8 @@ static int append_edit(int argc, const char **argv,=
 const char *prefix)
> >   OPT_CALLBACK_F('C', "reuse-message", &d, N_("object"),
> >   N_("reuse specified note object"), PARSE_OPT_NONEG,
> >   parse_reuse_arg),
> > + OPT_BOOL('e', "edit", &d.use_editor,
> > + N_("edit note message in editor")),
> >   OPT_BOOL(0, "allow-empty", &allow_empty,
> >   N_("allow storing empty note")),
> >   OPT_CALLBACK_F(0, "separator", &separator,
> > diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> > index 99137fb2357..7f45a324faa 100755
> > --- a/t/t3301-notes.sh
> > +++ b/t/t3301-notes.sh
> > @@ -1567,4 +1567,33 @@ test_expect_success 'empty notes do not invoke t=
he editor' '
> >   git notes remove HEAD
> >  '
> >
> > +test_expect_success '"git notes add" with -m/-F invokes the editor wit=
h -e' '
> > + test_commit 19th &&
> > + GIT_EDITOR=3D"true" git notes add -m "note message" -e &&
> > + git notes remove HEAD &&
> > + echo "message from file" >file_1 &&
> > + GIT_EDITOR=3D"true" git notes add -F file_1 -e &&
> > + git notes remove HEAD
> > +'
>
> Maybe I don't understand what this is supposed to be testing (and if so,
> please correct me), but how are we verifying that the editor is being
> invoked?  If we're invoking `true`, then that doesn't change the message
> in any way, so if we suddenly stopped invoking the editor, I don't think
> this would fail.
>
Hello Brian,
Thanks for your review and feedback.
Yes, I realized the tests do not show a way to determine that the
editor changed the message.
Thank you your observation and pointing out to me.

> Maybe we could use something else as `GIT_EDITOR` instead.  For example,
> if we did `GIT_EDITOR=3D"perl -pi -e s/file/editor/" git notes add -F fil=
e_1 -e`
> (with an appropriate PERL prerequisite), then we could test that the
> message after the fact was "message from editor", which would help us
> verify that both the `-F` and `-e` options were being honoured.
> (Similar things can be said about the tests you added below this as
> well.)

Okay this is duly noted.

>
> I suggest Perl here because `sed -i` is nonstandard and not portable,
> but you could also set up a fake editor script as in t7004, which would
> avoid the need for the Perl dependency by using `sed` with a temporary
> file.  That might be more palatable to the project at large, but I'd be
> fine with either approach.
>

I will look into this and also take a close look at the functions
which define the implementation
for the GIT_EDITOR which are the write_script with fake_editor as file.

> Do you think there are any cases where testing the `--no-edit`
> functionality might be helpful?  For example, is `git notes edit` ever
> useful to invoke with such an option, like one might do with `git commit
> amend`?  (This isn't rhetorical, since the notes code is one of the areas
> of Git I'm least familiar with, so I ask both because I'm curious and if
> you think it's a useful thing to do, then tests might be a good idea.)
> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA
>
> =E2=80=94
> Reply to this email directly, view it on GitHub, or unsubscribe.
> You are receiving this because you authored the thread.Message ID: <gitgi=
tgadget/git/pull/1817/c2423410614@github.com>
