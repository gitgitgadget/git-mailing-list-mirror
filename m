Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DCE202C4A
	for <git@vger.kernel.org>; Tue, 13 May 2025 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747171344; cv=none; b=Hj/E0E1RA8aX2Ek/q7a2v7x85x9WPLn3I/Wk3bKzZeKLKuKd+t4SSP+ecfSLBiWOLrNyj7yXi2eYJYIOlAGnV0jgeMYWWeVzboSqMThqnolG4DoGJ+bBrRJWb1fuqO3tflgg2e+IjYz+mqojqrPUQFIJlAfbDBLVz2rGluYmGOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747171344; c=relaxed/simple;
	bh=ckzgYSxN1tCXfDcjcfPjSKtLikQKbkcCk9k/UEz1GW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0ZOqRrb0LoaF4uCCsjwX95eYWvkTvfvwOVJnQQWsytpeCaTPuu5KXX5j3XAt482RIBhtb/VG2B+4p0IeZMxZTJWsdqf8OwPt49qLj1N2U9JxHARpgZKlqZ7xTy37Nq0wGBC/6gvjkEHSzE28w/+6wi5MQciEBCgzCXVstafim4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQjW85dL; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQjW85dL"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5fbf0324faaso12403842a12.1
        for <git@vger.kernel.org>; Tue, 13 May 2025 14:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747171340; x=1747776140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xT6JRiRvdIVEJ9tjqc2CPHT1ZbxlgHU5ybpkkRnhnU=;
        b=CQjW85dL2ykup9Rk1nJiW5ojOWdcPbq91RUsStllD9k1VcDG7srhKeRDvSKHsxdZ2c
         /7yljUTvTSeRbxaTIT/3gIjJsWB8axLQpowUHhO4fC55hPjrfcdfm94E3MqZBvZawUKo
         JfE6uB+lBomH+fXKqbWpOFRpcm9Pot8nGATW+X1UfB0vn3zBO5GrHV3cMcK1P6nMi5HC
         0OHvuIBpCSZRXtaeDezAGiiDoweWpeSdK78pigPhMgIHv2BGYiiUYn0EKov7PDk9mJH3
         9s/WeGgeDz3K1YGjMRpehTaiaRwMrNRB1Tcp43Lht1zkLTsZL/SufYfXZT3SKd9NazfW
         7uHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747171340; x=1747776140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xT6JRiRvdIVEJ9tjqc2CPHT1ZbxlgHU5ybpkkRnhnU=;
        b=plMX/AOUFRQ0zRyNdNNgYGMQmrY9YIM1e5avBxMeLONR6zJlQL/hy+eOOG5HQhYI//
         SF/w4m9DfTStjMmvFQVeSnuSQn0VOEbG3nLWgt5zdJ4sSDFZNmJWLk5Um5i9aT6uW6+g
         Cydbhixpf67ZxOYqEuLztfTvkNDmAZrY3DPiJ+f3H/eUCLvB8CQzF2ZD0fz/jr1y81nD
         gfnvH2Nur0AdYqFFjWWD0BwXup68VWbvl3lOvxLYbLX4FK2ScU8uwSMR6nka847p9KMt
         RW6Wr3CYcDlW19DcEwErt1eX6sn1ujEzDWhD+QL8TVEOOSVhi6tbPUemrKiDshEx85if
         QO4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxLrb0sQNcEFdXT3E5QMjCLnK485CMT17jlPIWvEJNZFWLq7hvABQDKgbUoxqmvrv1sXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhRkIw9vftdY/WK/LCN7FG8AncC+OduPDdnBtqZYUxGKXzeOEC
	jDgMe2q3a9EipXBf6G04j7GejcKprJ5ZNgRB3kwT3+2IshLHH7NUDyv0qVCE/G+x2D1bU7V0kr0
	LkiOKR894ALeyRLqjLqOMfWBaPZc=
X-Gm-Gg: ASbGnctUX0QSCnd0pvJhJmiBNHt+XnQqxPSbkmgYcRq37Klahs/ar3aNjffydS3M3fd
	kUkt1QsgV6JFBGlJ4tm8BoOS8n9KQUuXSvczdgAMHDXYcOYaZ7MNaZbpveGb4vQsqNf/U+wOFjq
	Zg1SJVwrTRaI+jlCzXK+TvxNVLMLzLkz6bjUwa+y1LMIP0gTLVvrwbZuly9eJcEAMvVMY=
X-Google-Smtp-Source: AGHT+IFKzXG8MC6++vZUyMuHTUUwCSQf/2mZk5mZcgcPqMArr8WEwnnscgo6zopoILSkqYZhiBX+YlGdE4DL3bOUfIA=
X-Received: by 2002:a17:907:7f8a:b0:ad1:8b5c:114b with SMTP id
 a640c23a62f3a-ad4f71de01emr83029366b.18.1747171340299; Tue, 13 May 2025
 14:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z/VGYrrVZYQ13TLj@ubby> <20250409121924.GA148735@mit.edu>
 <Z/amMj/eg0RbXdkS@ubby> <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev> <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <aAgWytQNqtLzg2TU@ubby> <CALnO6CBq2cqBAhzMh8rnXzc8cPTsB4hz98YVn3B4+PGdiyn9_A@mail.gmail.com>
 <CALnO6CD8JTnNGfuCtb1QKFhx+Vv1txUZ+wCL1nZCDGAvHx6A6g@mail.gmail.com>
 <CAESOdVCKTnUbVuXq-=F3df4i2T-GcDpJMENr8wwm-ZXR95+59w@mail.gmail.com>
 <aCJi+4q6DZhnfdy+@ubby> <CAESOdVD_Cse6AjwLb-4QKjdo4ESWwF3FzSS5JaHbE6ZrMjFeZw@mail.gmail.com>
In-Reply-To: <CAESOdVD_Cse6AjwLb-4QKjdo4ESWwF3FzSS5JaHbE6ZrMjFeZw@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 13 May 2025 17:22:09 -0400
X-Gm-Features: AX0GCFtBlGDEFWgP9tRb7Tz13rTfgzmrPgjHHDBuwn9NuIG8F8HJvnDXlLSyNIY
Message-ID: <CALnO6CBSyCyJ_veinUndZNxBnDuwY4cn3RZu7Jcd3bM7pVV5xw@mail.gmail.com>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: Nico Williams <nico@cryptonector.com>, Remo Senekowitsch <remo@buenzli.dev>, 
	"Theodore Ts'o" <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>, 
	Git Mailing List <git@vger.kernel.org>, Edwin Kempin <ekempin@google.com>, 
	Scott Chacon <scott@gitbutler.com>, "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 5:43=E2=80=AFPM Martin von Zweigbergk
<martinvonz@google.com> wrote:
>
> On Mon, 12 May 2025 at 14:07, Nico Williams <nico@cryptonector.com> wrote=
:
> >
> > On Sat, May 10, 2025 at 01:31:32PM -0700, Martin von Zweigbergk wrote:
> > > To me, the main benefit is being able to refer to an evolving change
> > > by a stable ID. That enables things like `jj describe qx -m 'new
> > > description'; jj new qx` (update commit message, then switch to it)
> > > without having to look up the new commit ID after setting the
> > > description.
> >
> > Notionally this is not different from renaming a file.  You have a name
> > (file name, commit message subject) and you have the thing it refers to
> > (file contents, tree object).
> >
> >   <insert sub-thread about why Git does not have inode numbers for
> >    files, does not record rename/copy intent, and depends on file
> >    content similarity checks to detect renames>
> >
> > If Git can do file content similarity checking to discover renames, the=
n
> > surely so can jj and other CR tools do commit similarity checking to
> > discover commit message changes.  Is there anything that makes the
> > preceding statement incorrect?
>
> That wouldn't work in the `jj describe qx -m 'new description'; jj new
> qx` example I used above, right? I think you're suggesting that when
> the user runs `jj describe qx -m 'new description'`, we should compare
> the reachable commits before the command to the reachable commits
> after the command and then record in some storage that the new commit
> is part of the same "change" as the old commit. Is that what you
> meant? In this particular case, the commit message obviously changed,
> so comparing the commit messages will obviously fail. We could of
> course make this command record the information itself, however.

I didn't follow the entirety of the example (since I think you'd have
to have change ID "qx" to start with in that case), but:

I think you'd compare commit /contents/ (aka the trees they point to)
rather than /messages/, just like how rename detection compares blobs
or trees? (Although I seem to recall a recent thread where a heuristic
involving the old/new name went wrong because it was too short, so a
heuristic in the messages is probably also reasonable. Doesn't
range-diff do something similar?)

>
> > > Given that we already have this stable ID, [...]
> >
> > "We" =3D=3D jujutsu?
>
> Yes, sorry :)
>
> > How is this stable ID constructed?
>
> It's just random bytes (16 when using the Git backend, 32 in the
> Google backend).
>
> > How would things other than jj construct these?  We spent many messages
> > trying to work that out and in my estimate that wasn't settled.
>
> Random bytes has worked well for jj.



--=20
D. Ben Knoble
