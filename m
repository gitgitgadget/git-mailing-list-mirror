Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C056B26299
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762599483; cv=none; b=PD7w5oN53rWNBCiBD3/0gO7iN+WbpkE/j8zx9JaXA3GZLmQIf47w6F/tZzE5JgRCazW1Z2IBRsFF6PG11pe4U6gqOZLXq+v4KcCljn/r1JlVnw2bei1V8M2KiGhQLJ5s9Pc96jz+DMUHkf/9ZleBtAqrVVNjvUnJFfyHaDDscyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762599483; c=relaxed/simple;
	bh=zlAVqhv1e4wC7NpBBW+fY7yjC26QvSGQvcXBGYGm3jE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eszg5pTcuViRVgxuNGUkiXcSGX4m/bVMvRGPvL+Ke2cPi0OrRkOYkCORVrVocQ2kadp1AZQpT1A2NrZtIeW4b3EqqL+M5hxWFiPSiYrENAVmCoOiXGd/icSmWt6hApWoEV36JCmG74Uwop3NkNptuOXPatcltz+YhbtRKV2KmAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkM0lcSc; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkM0lcSc"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5945662a755so1228979e87.1
        for <git@vger.kernel.org>; Sat, 08 Nov 2025 02:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762599480; x=1763204280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXglfBINiNWqkp1zMrkrXZZMh9uMxdCb8E5gT82z/Zg=;
        b=kkM0lcScFoG8aEoWfpmnEQbOVs5spFLTAdbSpPQMVCR8HUG8zMSdhcadbNgNeIrrRJ
         PSO+e2TtMjONJEilsFAY7h2mzamz6KlDc/2BE+EmiWtB8F6uKurtP05IJs63fR0U0rrS
         6Vo8ovqNO65qxPQQHqM1hIgNwH9R+FwdRg22daN58v+iqkuGhH+Xn5rg0+iS3URSa6qX
         6sZxwLP1QleSduggCrh8Beu5DXVKClcO9ABrbUq61P41ZiqyaK/MyFA3ukEzsgys3muN
         LnUgYE2WIQqKQ2BixbkoT4YZNcTyFHUU1TGM0ojwS1VjdlE1dwnKGnBmB7vgITgxSxZ8
         L/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762599480; x=1763204280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fXglfBINiNWqkp1zMrkrXZZMh9uMxdCb8E5gT82z/Zg=;
        b=twDdwg+mKTTYLdf5jPDKfeewzOLWDTUduRfr2ScuNGda3NfT5Fv+d5pYxEA+1d5pcO
         6DhgeY1OiUZPUOc9TI3PZv/sHDhxRggCaqsl94OP99IVdTjfHbvhDJ1xCFUUQ1ZN7hA1
         g7L3buXRuydUsULi8WUMn7i/8HA0ETlhiyob6jvDdcqc9I7B3bD9PxBEngUkYDbB0ixz
         lDPDzSny8ThPzqZ7oJj8jPjTQlweNns5LFegNr9UYqnniDjx42Q84ANugz15QM3xE0pH
         eAArXHsA7OVKuJhxIkZiaBZAGT8Mq2wK3tL5LWdRvuA7dCNmx51DHNUuvG40qm9yrURm
         bw6w==
X-Forwarded-Encrypted: i=1; AJvYcCU93JMuX8n/30jKi7R7heich0GVOPOI/oSNjWytH4MQTS2sdHkpprPov0H8pSAf5ACSwOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Q4ULwt4SsmPy+vU4CjiwgXvbmyM09yO9zQeR6Ra9/HVxSevQ
	RYJrpN5NoPMZONrz2/LmC2+z/j0QtwxCgz/+XJU5LkulEPGFPm2bfMQM8gnrmbE5sy6S7Pfl/1A
	xKTX5dAJK01ROmDs/4CA6uo3ReVCWuUU=
X-Gm-Gg: ASbGncubaIMCzl2Wr2eAMHyBWUPxxlq+6HOQUdXQ/MAJSQ+8BfKBjIDnkiN2PcyjriX
	5q2RuQzOrWTIzooJ/1R2WnOI3PVYlZgQZoftNfw01Q5rZ4sYcd1609kmNGQIeogNgHEl9LB8J01
	AJ+kizD8ZjWzkAWK2CskC1OyUtICevZtQbhGqRRfoNr03eCXBS7gIxSIwOIRSLiPjf+ms/vvsXR
	84Y5Wngtq5f9YwU/sMGVsU5OPR34r5+SOGUm3G0uRrhK3wewPt/BXFuTL+8D7Z7a9iyfY0v
X-Google-Smtp-Source: AGHT+IEuHH5m9JhInW4/j7+HB7DyLk2v1dEnMuvFoO6bf8cGHE+rgfZ/T7lCTB5LtIB7x6w/kvR4h31QD8b5TdzoSKU=
X-Received: by 2002:a05:6512:114b:b0:560:9702:4fe6 with SMTP id
 2adb3069b0e04-5945f168bccmr709808e87.24.1762599479295; Sat, 08 Nov 2025
 02:57:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEyHQXWd77_jJachC6FYbWMJ+L=KkKoUqiACQ7z8r-ZwYq8JYw@mail.gmail.com>
 <e1fede83-bed0-49e9-84a0-f026b9df6039@kdbg.org> <CAEyHQXWd4kN=ehWh0Y7xNnPGk3ofXEc4=PvSYaZM91TFyLtnpg@mail.gmail.com>
In-Reply-To: <CAEyHQXWd4kN=ehWh0Y7xNnPGk3ofXEc4=PvSYaZM91TFyLtnpg@mail.gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Sat, 8 Nov 2025 02:57:47 -0800
X-Gm-Features: AWmQ_bmPFlfgjt-6uAwXZCzj29BWkcfXhdIMuzkFxL92MxM9EJwLH6Dmj0NFNpU
Message-ID: <CAPx1GvcwAj5k0QEwxS8h=VNBNTgtxAaXGAf1a38Sb18COuSHEA@mail.gmail.com>
Subject: Re: [Bug report] git cherry-pick silently ignores error whereas git
 apply fails for hunk apply
To: bhavikdbavishi@gmail.com
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 12:35=E2=80=AFAM Bhavik Bavishi <bhavikdbavishi@gmai=
l.com> wrote:

["git apply" fails, "git apply --3way" and "git cherry-pick" succeed, and:]

> I've compare the file content of `mango/utils/apple_utils.cc` for `git
> apply --3way` and  `git cherry-pick` is same

This is all entirely normal.  You're seeing the difference between a
"patch" and an actual "three way merge".  The cherry-pick command does a
three-way merge using the complete information available to it.  The
apply command applies a simple patch, or, with "--3way", searches the
patch for auxiliary information that may or may not provide the extra
detail needed for doing a three-way merge.

To understand this, we need to illustrate the difference between
these two ideas.  Let's start with patches.

A "patch" says "we expect the file looks something like this, and
we would like to make certain changes in these areas".  If the file
*does* look "like this" in the indicated areas, it's easy to apply
the patch:

   --- lines 15 through 19 of file.txt used to be like this
   +++ lines 15 through 20 of file.txt should now look like this
      we expect the file to
      look like this
    + and we should add a line
      and then the text
      goes on as before

If file `file.txt` has the desired lines at lines 15--19, and we
add the indicated text in the middle, we've "patched" the file to
match the new desired result.

But what if the file, at lines 15 through 19, reads:

      we expect the file to
      look like this
      and we should add a line
      and then the text

Well, it sure looks like that patch was already applied.  We
can *guess* that it was in fact already applied, or we can search
for lines before or after lines 15 through 19 that read the
expected way.

Patches can add, remove, or (depending on the kind of patch)
change lines (or characters within lines, or whatever: the
more general form is "symbol by symbol, add/subtract/replace").

A *merge*, by contrast, takes two separate sets of patches:

 * First, there's a "common base version": a version both you
   and they, whoever they were, had that's absolutely 100%]
   identical in all respects.

 * Second, there's an "ours" version. By comparing the "base"
   version to the "ours" version, we find out what *we* changed.

 * Last, there's a "theirs" version. By comparing the "base"
   version to the "theirs" version, we find out what *they* changed.

This time, if we already have the change at lines 15--19 / 15--20, we'll
see that they and we have the *same* change.  We can silenly discard
their duplicate change!  We don't have to guess whether we have their
change, or whether the lines moved around somewhat in the file.

This same method handles removals (and if they're in the difference
format, "changes", which are just "remove and add" combined into one
block).

The way "git apply --3way" works is that it looks for a text line in the
patch of the form "index <hash1>..<hash2>" before the diff listing
(which has only add and remove, in Git's case). The first hash ID in
this pair of hash IDs is the Git-specific unique identifier for the
original version of the file.  Git then looks in your own Git repository
to see if you have that version of the file.  If so, that's the
"common base version".

If Git can find the base version this way, Git can then apply the patch
diff to the *base* version, which produces the "theirs" version,
guaranteed, because the change *must* apply to the base.  That ID is
*unique*, across the entire universe of every file in existence
anywhere, in any Git repository.[footnote] If you have that ID, you have
*that version* of *that file*.

Now that Git has the base version and the "theirs" version, Git can do
its own three-way merge: diff the base vs your version to see what you
changed, and diff the base vs their version to see what they changed.
This can still have conflicts, but now at least they will always be in
the right places.

Chris

[footnote] This is clearly nonsense, due to the pigeonhole principle.
And yet, Git depends on it successfully (modulo carefully engineered
hash collisions, currently possible for SHA-1 but not for SHA-256). With
some clever mathematics we can show that the chance of failure of any
given Git repository is quite small -- far smaller than the chance that
your computer will just randomly explode into flames while you're using
it, for instance.
