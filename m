Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136B1281508
	for <git@vger.kernel.org>; Sat, 22 Nov 2025 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763847915; cv=none; b=YsNZ3hSpuThs9KtTyNxe6gw1vNKHZNIW7hYBxadayyWV9guvJ99WERE8/Y28v9RWjhCmH8UEiVk5jW2dRlpDyk8+v/B/2iZiBPmOfIm2Rn62Da/ftM+DdskctbNV9/F1gaNNRjsH0bjsrUlAunLD2/YBP06xNkvhkvlsyjTXzlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763847915; c=relaxed/simple;
	bh=dPZIU7VXzepcplU7DWavTDkcTVkQPDyTfzpXm5agWcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAzM+hIVOimded8ItRMdtprQJfJzD5+W3YPfUyiwLpwcKwnyx38kRF7XrfdJYJiduTCRoYiXwJ1xHkkZEpicb+KtNCGpE7k0mLWeaipG9dKfQaV9vVt5stt48ZaaAse1ht3aueP2fUQJjdUYgqNP5JqrHMLgEHf051BQ43nvcUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=AY0LGLkE; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="AY0LGLkE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763847900; x=1764452700; i=l.s.r@web.de;
	bh=JdO2EaRVtweif6XpgZ1IdP4rLUSb9VFeeB9DRrWUArk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AY0LGLkE+2fM0UDrp1GtT/CTKa9yFSSVbw1liR1xzT4V/93gN75SAQG1Yeu+fSmo
	 iagidAWzJvC4O6eoV0DSTE3gRR3GdN7PzNmzNjjyYt/MqdAAiLoCUrUcFNVYGMl/d
	 czYX7ac8AlAhZyxnsTDyfeLTqA2iILqdbXhN2lbpAzqVXliPNe4CP0/x9W4oGXfhP
	 s2iYotYAvCMYLwtCP3+sYeaGW/1FPtc5v3GdYn7sWcoXL3K2zWhjAnBHbWIJlLuxl
	 i9SIUYzkoNf22QEDADKuaOsXsyYR4+Kq+dkINFHoPxflCqpLfXb6Okre/WI4fmPB4
	 fyroV2Xzo6yJ6EV0RQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.146.25]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLRUX-1veJfr0fVT-00NEPT; Sat, 22
 Nov 2025 22:45:00 +0100
Message-ID: <8cc12ef2-1d2c-4924-b130-bd740a975ce0@web.de>
Date: Sat, 22 Nov 2025 22:44:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] diff: disable rename detection with --quiet
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Junio C Hamano <gitster@pobox.com>
References: <CALnO6CBsj+aMvHJoUQ+LHAtXhcFhQeH8AuHyrX+rumur6MQQog@mail.gmail.com>
 <8796cd59-2335-4674-823d-d682ce7b7f8e@web.de>
 <20251110175408.GB76603@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20251110175408.GB76603@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cPTWrtJsIv5Epr/DXxPopyHsNvOzAxav1d1PhO91YuB8SDMFEwj
 1LfMp/6jPW0EF2Y12zsHB6b0x7Zk2ncciUVid5vz8MZ+bLdZVOM/IsJ7zYWZJvgx3XA5gRJ
 gu2ei+9gw31V0THEu+Xq/9l2soAvuS4fea1dQ9WZer3op3FML3st9cMSozrFzwljHEipz1C
 fWFefkgZ4VFIIKIQG9+pA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:B7QYn3bLmkM=;OxygnDfnbIp7DT2yhs7U81XdzCh
 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

On 11/10/25 6:54 PM, Jeff King wrote:
>=20
> I wonder if we should _also_ take the hunk from v1 that teaches
> can_quit_early() to avoid triggering when copy detection is on. It's
> probably redundant now, but it feels to me like that's the place where
> the correctness check should kick in. And the patch here is just
> optimizing out the unnecessary work, but also happens to align things
> for correctness downstream.
>=20
> But I dunno. Maybe a check for a condition that we think can never be
> triggered becomes too confusing for later maintenance.
That check was only necessary because we queue unchanged filepairs for
rename detection as if they were changes.  With --quiet forcing rename
detection off we won't run into this anymore, but it still feels like a
trip hazard.  Adding a check would help, but we could also stop doing
that in the first place.  Patch below.

Ren=C3=A9


=2D-- >8 ---
Subject: [PATCH] diff-index: don't queue unchanged filepairs with diff_cha=
nge()

diff_cache() queues unchanged filepairs if the flag find_copies_harder
is set, and uses diff_change() for that.  This function does a few
things that are unnecessary for unchanged filepairs and always sets the
diff_flag has_changes, which is simply misleading in this case.

Add a new streamlined function for queuing unchanged filepairs and
use it in show_modified(), which is called by diff_cache() via
oneway_diff() and do_oneway_diff().  It allocates only one half of each
filepair, which has a measurable effect if there are a lot of them, like
in the Linux repo:

Benchmark 1: ./git_v2.52.0 -C ../linux diff --cached --find-copies-harder
  Time (mean =C2=B1 =CF=83):      31.8 ms =C2=B1   0.2 ms    [User: 24.2 m=
s, System: 6.3 ms]
  Range (min =E2=80=A6 max):    31.5 ms =E2=80=A6  32.3 ms    85 runs

Benchmark 2: ./git -C ../linux diff --cached --find-copies-harder
  Time (mean =C2=B1 =CF=83):      23.9 ms =C2=B1   0.2 ms    [User: 18.1 m=
s, System: 4.6 ms]
  Range (min =E2=80=A6 max):    23.5 ms =E2=80=A6  24.4 ms    111 runs

Summary
  ./git -C ../linux diff --cached --find-copies-harder ran
    1.33 =C2=B1 0.01 times faster than ./git_v2.52.0 -C ../linux diff --ca=
ched --find-copies-harder

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 diff-lib.c | 13 ++++++-------
 diff.c     | 20 ++++++++++++++++++++
 diff.h     |  5 +++++
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index b8f8f3bc31..8e624f38c6 100644
=2D-- a/diff-lib.c
+++ b/diff-lib.c
@@ -418,13 +418,12 @@ static int show_modified(struct rev_info *revs,
 	}
=20
 	oldmode =3D old_entry->ce_mode;
-	if (mode =3D=3D oldmode && oideq(oid, &old_entry->oid) && !dirty_submodu=
le &&
-	    !revs->diffopt.flags.find_copies_harder)
-		return 0;
-
-	diff_change(&revs->diffopt, oldmode, mode,
-		    &old_entry->oid, oid, 1, !is_null_oid(oid),
-		    old_entry->name, 0, dirty_submodule);
+	if (mode !=3D oldmode || !oideq(oid, &old_entry->oid) || dirty_submodule=
)
+		diff_change(&revs->diffopt, oldmode, mode,
+			    &old_entry->oid, oid, 1, !is_null_oid(oid),
+			    old_entry->name, 0, dirty_submodule);
+	else if (revs->diffopt.flags.find_copies_harder)
+		diff_same(&revs->diffopt, mode, oid, old_entry->name);
 	return 0;
 }
=20
diff --git a/diff.c b/diff.c
index efa8d9773c..e2a2927f8c 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -7349,6 +7349,26 @@ void diff_change(struct diff_options *options,
 			  concatpath, old_dirty_submodule, new_dirty_submodule);
 }
=20
+void diff_same(struct diff_options *options,
+	       unsigned mode,
+	       const struct object_id *oid,
+	       const char *concatpath)
+{
+	struct diff_filespec *one;
+
+	if (S_ISGITLINK(mode) && is_submodule_ignored(concatpath, options))
+		return;
+
+	if (options->prefix &&
+	    strncmp(concatpath, options->prefix, options->prefix_length))
+		return;
+
+	one =3D alloc_filespec(concatpath);
+	fill_filespec(one, oid, 1, mode);
+	one->count++;
+	diff_queue(&diff_queued_diff, one, one);
+}
+
 struct diff_filepair *diff_unmerge(struct diff_options *options, const ch=
ar *path)
 {
 	struct diff_filepair *pair;
diff --git a/diff.h b/diff.h
index 31eedd5c0c..e80503aebb 100644
=2D-- a/diff.h
+++ b/diff.h
@@ -572,6 +572,11 @@ void diff_change(struct diff_options *,
 		 const char *fullpath,
 		 unsigned dirty_submodule1, unsigned dirty_submodule2);
=20
+void diff_same(struct diff_options *,
+	       unsigned mode,
+	       const struct object_id *oid,
+	       const char *fullpath);
+
 struct diff_filepair *diff_unmerge(struct diff_options *, const char *pat=
h);
=20
 void compute_diffstat(struct diff_options *options, struct diffstat_t *di=
ffstat,
=2D-=20
2.52.0

