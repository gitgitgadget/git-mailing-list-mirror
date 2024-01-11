Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A72A624
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 02:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dF/99qwl"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9b267007fso2851554b3a.3
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 18:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704939323; x=1705544123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3CkrE/LUoI1EPoPLmiiL+g3bsylExpqExww2hoqwKc=;
        b=dF/99qwlanFLvU8lLpAOQpo/hUjqdrCfXvvyYE0p2h6kzq7+gZaaquuOYEHmnQYOiV
         ITnjZ/kZBd0LLAE85l4WuErYuQdQKAHAs1AUhL/AL0EGnODeHxVfxe7QxjznUyytKtN5
         dc/GgwnUZG//C97817/+ccG+jGDHNf/PWCuakls2ZJLjwL2/udARvfD53aRPmiEPlKvl
         Il9r9BrMGPWfH+NOMRI8TiEsORp9CEn2tRu4RvVsT1CVIOxc7NnCJIsDAM238pw/KWZu
         KQJLTDd8yKKznVigz4bibwBD+IM+mF/bA71QkifFHgx9CSy6hC2po3KhO4F3EVLvRtPN
         sVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704939323; x=1705544123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3CkrE/LUoI1EPoPLmiiL+g3bsylExpqExww2hoqwKc=;
        b=pCEB1mpL4DGNZR6BuIixFofjOwJrueRYakprJn/lbeRd4X3jUnw8P5mE4IfFfgow3w
         yfLnGs7DXGOZccgueYLRT7YJs4AhxD5s0gqv/AFaRnQ7wzaSnKwjh5O+UjaCH6HKc06V
         QNAeAGaA7ex9z/P4SuRDpd/iewxIIenI+H+r3ufxzwC1YIoiQKrfc0DmrWXWQMTGimoE
         LieJKzAzLvYOnpVPQOtZxb0OLzYDtce7C3TRYNi/7+FP89Pnn5MZGcgYKDoZlFtJyzYn
         zSyUujZcuFojEz/q/63CRS34qePZ5gCKbTaEUpeyE0y7gkL0OJ5QIbzbbH8flVQqBBQy
         vEKA==
X-Gm-Message-State: AOJu0YwPZ0N3teGuXAOn9estuWzuKaPo7h0wG+z8VfDC/rQwQmOmiGQ3
	pkodNiY7cw2+1QMqb5YbOFUUsc6TIIE7tCGNKmDdgX7UhVM=
X-Google-Smtp-Source: AGHT+IFNpokj0J6GDNntimvp8kc1rwjpZazHFSnUi5iy9evYpHLLzuwj562oQi7OMHERtwHa1bCMNB0hCCb8foWPAqg=
X-Received: by 2002:a05:6a21:3398:b0:199:6115:d32f with SMTP id
 yy24-20020a056a21339800b001996115d32fmr377664pzb.74.1704939323153; Wed, 10
 Jan 2024 18:15:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACjc_5pdijCZrrXQWHswsxYrGUzZ7pZq+nj3SzY1z+Xxop64Ww@mail.gmail.com>
 <20240110225709.30168-1-marcelo.jimenez@gmail.com> <xmqqzfxc7mfh.fsf@gitster.g>
In-Reply-To: <xmqqzfxc7mfh.fsf@gitster.g>
From: Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com>
Date: Wed, 10 Jan 2024 23:14:55 -0300
Message-ID: <CACjc_5rgO5Zcxndawm=3eRUX1Tuqh5LT05LhK+4V45RmUWmQHw@mail.gmail.com>
Subject: Re: [PATCH v2] gitweb: Fixes error handling when reading configuration
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

Ok, I'll put on my devil's prosecutor's hat then :)

I am not sure you read the first message in this thread (I know, I
messed up, sorry), but there I describe the real case that happened to
me, and the current behavior made it much harder to find out what was
happening.

That is the one:
https://lore.kernel.org/git/CACjc_5pdijCZrrXQWHswsxYrGUzZ7pZq+nj3SzY1z+Xxop=
64Ww@mail.gmail.com/T/#u

If the configuration file is there, but it behaves as it is not, one
will quickly point its fingers to the software that reads it.

In the end, if I had seen the message "Permission denied." that was
stored in "$!", I would have had a better clue that the problem was
with AppArmor, and not Gitweb.

There were a few unanswered questions in stack overflow regarding the
issue of enabling features on Gitweb when using "git instaweb" in a
persistent way, some of them might have been linked to that.

- gitweb refusing to blame:
https://serverfault.com/questions/551762/gitweb-refusing-to-blame
- How do I enable "blame" when using git instaweb?:
https://stackoverflow.com/questions/66688084/how-do-i-enable-blame-when-usi=
ng-git-instaweb/77793405
- My own question: Problem with `git instaweb` on OpenSUSE Tumbleweed:
/etc/gitweb-common.conf is not being read:
https://stackoverflow.com/questions/77789216/problem-with-git-instaweb-on-o=
pensuse-tumbleweed-etc-gitweb-common-conf-is-n

Let's see if someone comes up with a good reason to find the devil not guil=
ty :)

Regards,
Marcelo.

On Wed, Jan 10, 2024 at 9:17=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com> writes:
>
> > This patch fixes a possibility of a permission to access error go
> > unnoticed.
> >
> > Perl uses two different variables to manage errors from a do. One
> > is $@, which is set in this case when do is unable to compile the
> > file. The other is $!, which is set in case do cannot read the file.
> > By printing the value of $! I found out that it was set to Permission
> > denied. Since the script does not currently test for $!, the error
> > goes unnoticed.
>
> Well explained how the current code behaves and why.
>
> With my devil's advocate hat on, I suspect that the current
> behaviour comes from the wish to see "file exists but unreadable"
> and "the named file does not exist" behave the same way.  If you
> pass the name of a configuration file that does not exist, however,
> the codeblock to die does not trigger at all.  If a file does exist
> but unreadable, to gitweb, it is just as good as having no file to
> read configuration data from---either way, it cannot use anything
> useful from the named file.  So returning silently, which is the
> "bug" you are fixing, does not sound too bad.
>
> I dunno.  Let's queue and see what others would say.
>
> Thanks.
>
> > Perl do block documentation: https://perldoc.perl.org/functions/do
> >
> > Signed-off-by: Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com>
> > ---
> >  gitweb/gitweb.perl | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index e66eb3d9ba..5d0122020f 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -728,9 +728,11 @@ sub filter_and_validate_refs {
> >  sub read_config_file {
> >       my $filename =3D shift;
> >       return unless defined $filename;
> > -     # die if there are errors parsing config file
> >       if (-e $filename) {
> >               do $filename;
> > +             # die if there is a problem accessing the file
> > +             die $! if $!;
> > +             # die if there are errors parsing config file
> >               die $@ if $@;
> >               return 1;
> >       }
