Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC9AB661
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 02:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731812291; cv=none; b=BIp01j7bCTB5iKi3s0XUNZO5r8h0uQVY9f/jBCcmNgtLp7Zeq7iEYAiUkfL70J9HwGDnVNt9OAv9JHH6/BgRXrNtMxEusyWYTqrVLgy+PqFD/gR3Wa6nr+AsbJKZ27C07TLdBPfIMuDaOVIoAfDa0qQBwiBsxfHk6K7ktNuHZZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731812291; c=relaxed/simple;
	bh=Pkv9APYewH4+k7x5tvnE6aq20eV2NDyuOdOXWYXaDmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eK82iGffRTFeu6NnhiOzX3utNofiNZzaeRJuIIh3jelfPt5WCGg3GFkc+Or7JMubDflkmTqarCsx5al/Ed+KlGtbrvW5jg6QeyuNjXhAyXOTILQkcqmQUBcVAL/ebsa5D8OVEqLpAs6fwuUgagLAsYP5saRq+xd1LOBlhwAEtec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkjrllDj; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkjrllDj"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cfaa02c716so1155381a12.3
        for <git@vger.kernel.org>; Sat, 16 Nov 2024 18:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731812288; x=1732417088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkKc7KblkTPW7rEZ5NYrd17TE+W30SXOI3NKUpB8fVc=;
        b=fkjrllDj+K4VeAJ+bP/3lxrR6fBEg7exU+BfGL+Y752st6hoJWpYJhkMkbrMigNc0Q
         3PReJLVf+BIsG3zlfJbdmXxewsjfIFs5CFpTpDme0KA3M4ZIHVXB94JFQcfx4WieN032
         3dtLU1CYg9ab+zIWXh43bIgTtMPZUC3UVrDX+tVXwJr3v5GE62Hg3v6mEUAYGioQQ8Pv
         qadg/VYbkPjpziLCl58kdmXZf4P0/YqcROt1XMTMhwfujVQ6+gVIXL8piBfVraLxrRyX
         P78gqAZgG3oDuseLYJcuKgIO+CSiFG1lYkRwUGqVw38i2uyp9vGwkJ1Rjh1q8ul1EJlc
         4xSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731812288; x=1732417088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkKc7KblkTPW7rEZ5NYrd17TE+W30SXOI3NKUpB8fVc=;
        b=ListQ+yKz2ka1JefK23kNVhwbVAmEOJI/TlkiQF8nSKrpufAwl6x1xbjEUheRWsdRb
         YyqVj4fvITga95ZjeHlb3EOrhxT5PwQipqvH/4Gw6hlZyJmeCjRmJ7+6/k7HEgnEXfJv
         CqpQKjlZTCIGSF8265M8DXRj1w3KoLp6RkVqlxkzaBkeWfU9Sygf4Fez608NGhGr2vMd
         kwn47pVzTkPH+OivPJqDXgdjSRaEO3u2pat/XYGOiS/tVPeeIVDX2p7gSDvsi/SBIRZD
         0qPJ8Mgt1e0RpCwRlyCgag2IEXByHpO9W4WMwJdf29SlCjpjT5g/DTozLHHqRkeba6rg
         84Hw==
X-Gm-Message-State: AOJu0YyRmAJlNjPd09mAQvbq99CMIl4asrf6g9BaE12nzledXshwG61e
	SBHeVxQgxA6J1RRywHuU+srNN9t3XYn4ZiIHwMktaKP3bO1AbSdJi9Jt9vpp45f4xuoz0Nt33WD
	1vN8C+/zo0IfNSv7N2yyid21tVpk=
X-Google-Smtp-Source: AGHT+IEsSzuxJpo9sMahZ+jrhD+u42VDZM36ZtZCoMmmT8r10vz3RQvtbrFAKMZV/fmDKCZ0KXA8V5PK0BSF4xt6GRA=
X-Received: by 2002:a17:907:9289:b0:a9a:e0b8:5b7c with SMTP id
 a640c23a62f3a-aa4833f70b8mr764657066b.7.1731812287915; Sat, 16 Nov 2024
 18:58:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <myxdTw4K7jcrlKX-HC0edNKB3mgkjGJPAejkxWTcab03uT9uROZlO28zjhmnogOvGCJkag5q_Zvbok0VUyVjlkw5Goz3Gwe3l636lCYnGic=@proton.me>
In-Reply-To: <myxdTw4K7jcrlKX-HC0edNKB3mgkjGJPAejkxWTcab03uT9uROZlO28zjhmnogOvGCJkag5q_Zvbok0VUyVjlkw5Goz3Gwe3l636lCYnGic=@proton.me>
From: Chris Torek <chris.torek@gmail.com>
Date: Sat, 16 Nov 2024 18:57:56 -0800
Message-ID: <CAPx1GvfT1iNnpJ0Jv0vhdHrwD-pDOK81MnUW2-Fk_zcJkW9PUQ@mail.gmail.com>
Subject: Re: What is the diff between a --soft and a blank reset
To: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 6:08=E2=80=AFPM A bughunter <A_bughunter@proton.me>=
 wrote:
> The difference here is touching the index but what does that mean in prag=
ma ...

Understanding "the index" is _crucial_ to using Git, yet it's not
often explained very well.

(Note: _emphasis_ means italics emphasis, while ALL CAPS means
bold emphasis, below.)

I think it helps to start with a simple fact about _every_ source
management system: such a system, by definition, _must_ have TWO
COPIES OF EVERY FILE available at all times.  This follows from
the fact that you can get back the version you started with -- and
to do that, the system must retain each original, unedited version
-- and yet you must also be able to edit files, which means the
system must retain the edited files as well.  So those are the two
_required_ copies: original, and edited.  If the two are the same,
it's at least theoretically possible to share them, but that's not
important here.  The actively-being-edited files are the _working
tree_, while the frozen-for-all-time original files are saved
(forever) in a Git commit, in the case of Git.

What's unusual about Git is that it keeps a THIRD copy of every
file.  As noted above, if any given pair of copies match, it's at
least theoretically possible to share them -- and Git sometimes
does -- but that's not important here.

What Git's index is all about is that it HOLDS THE THIRD COPY.
The reason this is crucial to know is that running:

    git commit

tells Git to make a *new* commit FROM THIS THIRD COPY.

There are tricks you can use to attempt to hide or ignore this
third copy, but using them is, in my opinion, a bad idea, because
eventually one of these tricks fails and you're exposed to the
fact that there _is_ a third copy.  You might as well just get
used to the idea.

Once you _are_ used to the idea, much of the rest of Git begins
to make sense:

 * `git add` mainly copies files _into_ the index, preparing them
   for a future commit.

 * `git commit` takes whatever is in the index _right then_ and
   uses that to make the new (permanently-frozen) copy of all
   those files.

Now, logically, `git reset` might be the one that undoes `git
add`.  And it _does_ do that.  The problem is that it does a
lot more as well.  It has, in fact, _three_ primary jobs:

 * It can move `HEAD`.  (Understanding precisly what `HEAD` means,
   in Git, is another crucial item, but this message won't cover
   that.)

 * It can copy some or all files from a commit into the index.

 * Last, it can _also_ copy those files from the commit, into the
   index, and then on into the working tree.

(Even more unfortunately, `git reset` has several auxiliary jobs
as well as these three primary ones.  I won't cover these.)

The three options -- `--soft`, `--mixed`, and `--hard` -- tell
`git reset` which of these three jobs to do:

  * With `--soft`, `git reset` _only_ adjusts `HEAD`.  The
    default adjustment is to leave it unchanged, so running
    `git reset --soft` with no additional arguments does
    nothing at all.  That is, it does only job #1, then
    stops.

 * With `--mixed`, `git reset` adjusts `HEAD` as before --
   it's usually wisest to not have it adjust anything for
   this case, in my opinion -- and then goes on to copy the
   files from the `HEAD` commit into the index.  That is, it
   does jobs #1 and #2, and then stops.

 * With `--hard`, `git reset` adjusts `HEAD`, copies the files
   from the adjusted `HEAD` to the index, and then copies the
   files from the index to the working tree.  That is, it does
   all three of jobs #1, #2, and #3.

And that's it: that's all you need to know.  Well, _almost_ all:
there are all kinds of finicky corner cases around files that are
in the working tree but _not_ in the index and/or commit.  There's
also one other problem, in a new, totally-empty repository in
which there are no commits yet.  But those edge cases need a lot
of explanation and should be left until later.

Chris
