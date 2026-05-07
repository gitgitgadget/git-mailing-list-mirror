Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF0A3EDAA0
	for <git@vger.kernel.org>; Thu,  7 May 2026 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778166380; cv=none; b=MAGdLKEY71goT78GPty4Eu1+T0YCZu+hsJ5p6GhcH8c+ORbcFwVncP84zbPrAn03Jxydf4BwYIFoE+aqakw1l5ENhv430IyRxnXHsNcN1BFI3VeKSwb3pryfaYS/ECOHVwiNsSXo9XrXZBmhdMZQKYOe94KNBChdpusiAB6G2SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778166380; c=relaxed/simple;
	bh=H2/jiOLI9ssODoBWoWjmtjMfr1nl/P+tO1dYSIDX8EA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jjHQd1yeibOqL5GNcn2hgTpoB2G71WdpvwbExwNgPxYUBfTDFLKozbWL833U5aV/7a0y5EWDGDrczbB1ix73PGtyQqzoqBMzPl4OqDiqzCkryyC2t4t5aQ3jkLspJRlBp2uwi6aSnnguefgF7mO3hTST/KcIu7UY45nvWlXNR9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=EkjRoTpT; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="EkjRoTpT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778166371; x=1778771171;
	i=johannes.schindelin@gmx.de;
	bh=9ZeT87W1//DfN0NJIXdbKlynwTDAeWuIoIgzBKb4HXM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EkjRoTpTybOg0c/d+Xc23CI5jHaERM33waTZAtRkAGcYBB5hFyONHiK7WX3cakxO
	 B245lluiIT6HUZ5kOU7OGrwVZw+mISvEx6mDEef/szc1S+LWnEfqFWc8/Ekwz6FYO
	 w66EV7jxiUsEUlZoP4G6exkdoXUEM9fw1DEMJ0A+Yb+qNunhOXAgGcOVRLKOghGSs
	 Na2lI9CZx0rgWYe8EITIcd5oU82mAEbGbog740YffM6KFQ/Savsz3eDO5YsEh9pwC
	 l22h9kunCsgRJ7TF19m/+ra3xbaPa8qjHqYQYzxmvp1JVVI75VTP2o3jh8zmmQXY2
	 8ssz8prJmM2miCX2qA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mt757-1vSCrL3Yt7-01605X; Thu, 07
 May 2026 17:06:10 +0200
Date: Thu, 7 May 2026 17:06:08 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
    Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH/RFC 0/5] replay: support replaying 2-parent merges
In-Reply-To: <CALnO6CDJgUEiEgG=4r_F4jeyrHSsSpwD0X8rZzh+EScL+vJn7g@mail.gmail.com>
Message-ID: <4a94c675-661c-1f2a-27d0-3f10f761cf6a@gmx.de>
References: <pull.2106.git.1778107405.gitgitgadget@gmail.com> <CALnO6CDJgUEiEgG=4r_F4jeyrHSsSpwD0X8rZzh+EScL+vJn7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1567979427-1778166370=:12327"
X-Provags-ID: V03:K1:7EkD2NxJcp08Qq/eBjdcyUgxZQmP6uI/TTI2AUK7NXlIinh0aBf
 RdTj4mRBY8duV86PafcjXqgut1ZDL4P21DQcRH8uWjbOJ//L8bATSir1rYZE3piPVSRtpO0
 IizTwptK0N0F5azI7CRO6cGdLa4fd37dO2t2IB6J1vilGGWBiWAzxvjdGTF0kGLEejwHWRu
 55U1O0aspWXIs99zI18tA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sh5ptgmzJZE=;4tXtNjYwPdjQ4Db6a/oKnF++nX8
 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
 6YtgMQ==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1567979427-1778166370=:12327
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Thu, 7 May 2026, D. Ben Knoble wrote:

> On Wed, May 6, 2026 at 6:44=E2=80=AFPM Johannes Schindelin via GitGitGad=
get
> <gitgitgadget@gmail.com> wrote:
> >
> > [...]
> >
> > While I was at it, git history reword had a pre-existing
> > silent-success bug: a positive return from replay_revisions() (which
> > means "conflict, no updates queued") was treated as success. Obviously
> > this should never occur, as a reword simply does not change any of the
> > file contents, but bugs do happen. The merge-replay work is complex
> > enough to make that class of bugs more likely, therefore I introduce
> > error messages for those instances.
>=20
> Fixing this bug sounded interesting; I had a hard time spotting it
> while skimming the first 2 patches.

It's this part:

@@ -482,6 +482,9 @@ static int cmd_history_reword(int argc,
 	if (ret < 0) {
 		ret =3D error(_("failed replaying descendants"));
 		goto out;
+	} else if (ret) {
+		ret =3D error(_("conflict during replay; some descendants were not rewr=
itten"));
+		goto out;
 	}
=20
 	ret =3D 0;
@@ -721,6 +724,9 @@ static int cmd_history_split(int argc,
 	if (ret < 0) {
 		ret =3D error(_("failed replaying descendants"));
 		goto out;
+	} else if (ret) {
+		ret =3D error(_("conflict during replay; some descendants were not rewr=
itten"));
+		goto out;
 	}
=20
 	ret =3D 0;

> Did I just miss it? Is it worth splitting that fix out to a separate pat=
ch?

Well, you _could_ argue that they were not bugs at all: a `git history
reword` isn't supposed to be able to result in merge conflicts, nor is
`git history split` because they leave the respective commits tree-same
(in the `split` case, the second commit).

I could see the point were anybody to suggest using `BUG()` instead of
`error()` here, but erred on the "nicer to the user" side.

The only way this _might_ be triggered before this patch series is most
likely by playing games with replace objects. Or maybe you cannot trigger
it at all.

With the changes in this here patch series, I wasn't so certain that I had
covered all the edge cases (an early iteration of the quick short-cut in
patch 2/5 keyed only on the parent commits' trees, and forgot to verify
the merge _bases_' trees, for example). That's why I think it matters more
now than it did before.

Ciao,
Johannes

--8323328-1567979427-1778166370=:12327--
