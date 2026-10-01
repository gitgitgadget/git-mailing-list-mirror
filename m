Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B287F4BD348
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847811; cv=none; b=s1pl1INm5RTvEFOe87UrOyNpRTCyRXUTXWIBX7EkuIZsHeGEcpNtdJDQz41E3cuXRKpjr5Z+L/5F5/9mhiVtgKErgQYP8M7MtvdowTz5U26bwrcILckzlVvx56C/+qNi9jhD4nI0KLicZh2+5kXgiPWQVPR8ZoxNvNK0AOf9Bec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847811; c=relaxed/simple;
	bh=WzDILdtITT9Pu2jyreGd5xMLVXEkjeYYcELdiSNjJbA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ds0aSM3+kkamD4N8d51QCGO/jyAD4q+xs/OYZj7kGYYWHEnYbx6wYZ5uG9SU+owGAgdX1SFWEjGUZ0MRNIns6izwohpa4fLbOIVLB6hatnpa2BPVmO2ScYXKHqv51GA/YGsEGYZyEpDB/hIGe5NGc3ME9ljwvSPiZLfWD1SQTBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=OyFNN4lk; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="OyFNN4lk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1790847806; x=1791452606; i=aros@gmx.com;
	bh=YcXseJAuUDuHVvKm8e7sJLIZwt4pUbS09UBnAWX7ffM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OyFNN4lkE+33e3H0ImMDZaL98xIVwL5x9G4IIU1m83jY4J0jG0Ut6RB/Ziehd6Vx
	 qHtusMyobqG49TRA6N+jLWZ5VPN9nhhJ0H9g7tk0rNW/83sZETlLEcRhIXmPf4i+e
	 lReeDsa9pIPqedv+LfbORAW1J4S1eF1cC9H5yZUgCwvObacdW0q13iHLCd/F5iscg
	 o2/hgvVr+nSrlpqd7ExUixDQvljZQPz0t+eLJdkRZ4xzZIxM/aUqpeqpc65VXv7k9
	 Mhu7gmi1SpPB8qUwR+AL11qIZtOQNrlZwWhvT6viqWQ5L77TdUGExdCPF+JyxVl/e
	 /6fJpSnF0OEyi3lGJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MS3il-1xIYqr0u2F-00IHry for
 <git@vger.kernel.org>; Thu, 01 Oct 2026 11:43:26 +0200
Message-ID: <011ad911-2d62-4179-b3a7-e14aab79f18a@gmx.com>
Date: Thu, 1 Oct 2026 09:43:25 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
From: "Artem S. Tashkinov" <aros@gmx.com>
Subject: [RFC] Preserve per-file historical mtimes from Git history
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hfkat36PivKpMBcfWTzth0jZbBhtrWnBtPNkVROLy/ZfEswHtCq
 lViyRdmrCcJ4aU3tlkCv8W1awVj+m4qv0XTMnZRfyJKiOcR8Yn4MeBk1i8+FtiSeyQemToY
 +UEwFRI43MB2SUOFkIL7V6i4iUUIzR4SzYW+AbEZ0BiB/knYU74xiowvwO3TwYq707zrSNg
 VJjJebePQpfNcy6stKvtw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ByRx2wndbpA=;sU/aKBqSUO60+9Fz3UKGwFi7cND
 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
 08iCutoBMFRfWwo9l7KUw3

Hi,

I'd like to propose a way for Git to restore meaningful per-file
modification timestamps from repository history.

The problem is simple: after a clone, checkout, or creation of a source
archive, files normally receive timestamps related to the checkout or
archive operation rather than timestamps reflecting when their contents
last changed in Git.

For many repositories this does not matter much. For some, however, it
throws away useful information.

A particularly good example is linux-firmware. It contains thousands of
firmware blobs which have been independently added or updated over many
years. After obtaining a snapshot, ordinary filesystem tools no longer
tell me whether a particular blob was changed last week or has been
untouched for five years.

I would like Git to provide an optional operation along the lines of:

     git restore-mtimes

and possibly convenience options such as:

     git clone --historical-mtimes ...
     git checkout --historical-mtimes ...

The names are only examples; I am primarily interested in whether the
underlying behavior makes sense as a Git feature.

What I mean by a "historical mtime" is not an original filesystem mtime,
since Git obviously does not store those.

Instead, it would be a timestamp derived deterministically from Git
history:

   * find the newest commit in which the file's blob contents actually
     changed;
   * use that commit's timestamp as the file's mtime;
   * follow renames where Git can identify them;
   * do not change the timestamp for a pure rename;
   * do not change it for a mode-only change;
   * do change it for a rename accompanied by a content change.

There would also need to be a defined choice between author and
committer timestamps. I would personally expect the committer timestamp
to be the default, but I do not have a strong objection to making this
configurable.

For example, suppose a repository contains:

     firmware-a.bin   last content change: 2026-09-28
     firmware-b.bin   last content change: 2024-03-11
     firmware-c.bin   last content change: 2021-07-19

A normal checkout makes those historical differences invisible at the
filesystem level.

With historical mtimes restored, ordinary tools such as:

     ls -l
     stat
     find -newermt ...

would once again provide useful information.

There are also packaging and reproducible-build use cases. I originally
ran into this while looking at Fedora packages derived from Git
repositories. Source snapshot creation commonly destroys useful
per-file timestamp information, even though Git history contains enough
information to reconstruct a deterministic approximation.

Since the result depends only on repository history, two checkouts of
the same commit and history could receive the same mtimes. This is
different from simply preserving checkout time and seems useful for
reproducible source generation as well.

I wrote a proof-of-concept shell implementation which does roughly this.
It compares blob IDs rather than trusting status letters, ignores pure
renames and mode-only changes, handles symlinks without dereferencing
them, and attempts to give sensible behavior for merges.

The obvious disadvantage of doing this externally is efficiency. A
shell implementation tends to ask Git about file histories repeatedly.
Git itself should be able to compute the same information much more
efficiently in a single history traversal or using internal revision
machinery.

There are some semantics that I think deserve discussion before
implementation:

   1. Should author or committer timestamp be the default?

   2. What should the precise merge semantics be?

      My current interpretation is that a merge should count as a content
      change only if it introduces file contents not already present in
      the relevant parent history. A merge which merely selects an
      existing parent's blob should not make every such file appear newly
      modified.

   3. How should rename following behave across complicated/non-linear
      history?

      I realize Git does not store renames; they are inferred, so this
      can never be a perfect reconstruction.

   4. Should this be a standalone command, an option to checkout/restore,
      an archive feature, or some combination of these?

   5. Would it make sense for `git archive` to optionally use these
      historical per-file timestamps for archive members?

The last point may actually be more useful than clone-specific behavior.
For distributions and other source consumers, being able to do
something conceptually like:

     git archive --historical-mtimes <commit>

would preserve this information directly in generated source archives.

I am not suggesting that Git change its existing checkout behavior by
default. This would be opt-in, because some build systems intentionally
depend on freshly-created mtimes.

I mainly want to ask whether the Git project considers this information
useful enough to expose natively, and if so, what interface and=20
semantics would fit Git best.

If there is interest, I can publish the proof-of-concept implementation
and its tests as a starting point for discussion.

Thanks,
Artem
