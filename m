Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBE413D51D
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723636883; cv=none; b=YN9hrhXGU8ONP0Xh6lDNeo2IYHIxeFFYdRIWp+XiF0UD7SD71sEby97W2+Fzi/+0v8qX5ChqFyu7MXS4+TmLGgxvYA9S70Sw5h3cXDRt2FSGCVQe3yNvuP+e6SAwbgkDabUFhtHlSZXpyJuWaiyyb9x1Bb468ASf2RXKfuLy0lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723636883; c=relaxed/simple;
	bh=d2E0bWlGsr7VIzwQ0Z61EPMUZ8laOGKISz+M1ePyvSk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JrivNSz4PwM3/u6HbasuGWPY0J9ojOj1VnFc8s/jZyzosPXa6lVXnWqTvW5p9kxEo7xU+3HdNZyCudKi6mwLsnYlD2WyP3yh+02V0AQhSDJdjBg4M7JrUg5qvXzZfCFqhlMwm7PFatdbjxq60NDsbocZOlLlX+0IDTXMW8OWYQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=pE+DJOq8; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="pE+DJOq8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1723636856; x=1724241656;
	i=johannes.schindelin@gmx.de;
	bh=/5Lmve0H1dRa7YYIFhlPBIC06MERmV2ps+hE884jOUQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pE+DJOq8zIs5TJsihMBeIzeMuM4JNt/td6YFUN2YFA3mYsItNK5PKGowshuM2I5T
	 R8bcbnEPh8IN6/6EJUDPhOH2tG4mBsPSKPOtkUQK+bFIbcw34D6KAGlMvdXeI7kcT
	 ppbXDhPt41jDLS+as4WRT+pLdXUtbRmrStQ7V+KkZD2QgZAk0ZhCwzNQO/FqwYu2g
	 UNDItURUgKU9MNngZ5Iwhne+Eh+ngLdHPRwGWz/ZQzmmWed1FfQaG+3DGisjTb/yX
	 EEMYiNBup19kocZTWVdnCTh8cuq2wzJ3Et3L7PpxTGBp7MQJiT1v/+zp7o89KulrB
	 VE9HhAW9bm+p1MgExA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.84]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsU6-1sVRF22tQ8-008yMs; Wed, 14
 Aug 2024 14:00:56 +0200
Date: Wed, 14 Aug 2024 14:00:55 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Phil Sainty <phil@catalyst.net.nz>
cc: Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com, git@vger.kernel.org, 
    hvoigt@hvoigt.net, me@ikke.info, rafa.almas@gmail.com
Subject: Re: Adding nested repository with slash adds files instead of
 gitlink
In-Reply-To: <s5wed6rg5c6.fsf@catalyst.net.nz>
Message-ID: <24f8477b-03c0-5dd5-99c3-7520ce95376d@gmx.de>
References: <s5wr0azfeh9.fsf@catalyst.net.nz> <xmqqed6zht04.fsf@gitster.g> <8436c2bf-45cf-8009-14cd-c5ca708ece08@gmx.de> <xmqqle105oko.fsf@gitster.g> <s5wed6rg5c6.fsf@catalyst.net.nz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RmTgqGCy5RZ9lzERG2N5Zxpm/6MXoOf039UhYj9QbYJbjfvoVsy
 5it0CVQqQiKCLqiq6j9XmRoKlj8MenPLR+U+ng0mHdJCTdZ9qi1xiNF/zRA+9BpH6ojrYsK
 lsg1oGZF5m5DpL2govP2in4a8eNQuv6Hjj38izUwLYBCoQ9zxSh1TC8/zmJ2SLJwiNbn+54
 nVOWFCxUzYllhveEtBhsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:drHJLN/vyzk=;I+YUu8mE44+qh0uRn0rEzhKvRCk
 RQrKO0u6JsTHwM5hVZJDU+sBaAFHKn/e7xydBPvlHrAAN7KeivNdxLS0+Xcx/yUSmQ9dftaHE
 lJBoTwGMhkfreJtBJ2hr8CAmiCHZoBRD5nzfVxUT/IxY+TmKu/9ivwIJn//YkSG6t02lQtj3S
 g7CiubmJRl63W2Mw99SoTkMPcxmRfm6n3DVxqrRe30vcTDt0l7vwgF/W+cLSSEcyCQ7yAVbBg
 ZyI14zXHB10T65Qw5ywD/TR+TxhhUwhak/vw9a33NVOwKNBo/8D/au8SpS1HumPRqN8Rf0oW/
 q63Errpbi4+fO0jrmzZEMqCpHgTAnDvqDKrp8DZUBtjJ8z6u9C77SeX7HaD3TlNSIOLkaue2n
 gtadZywlzioTVpWfrjWdcHQuQfdhYpQF9wRGznp0tP5wD0eUHTBMSK+N4j+tQF0cGFldoBcFk
 V1UWI8yawqMmKQn7U//V4hfsm5zUCMhVW46FQaRubQl4cgxa358wO+qzFxD3Fkt2Yrjy7oell
 YYtnLRMDM1L4WGpyRI8Z8BWJQ54OT+zn7J2BRLzfYEIk50LuTvsCsA+uJdx/WSrx8pWNqIBNq
 UHtea6lj1BmOWPfzfOs+jA44CNERA70ke+/T+PaQSqU+a/GbJ4K8zVi8guk9mlhKrwK2KCSI2
 j1IglWkfx0Bfis71mNe11xsxfKbhSHPubyjBqqIZTbAkSOpI4OGfIY2Dfj8RN1HNyUJI8+Dc1
 ncEI5fVRfTuRV7BH1vsurcgiKpfUnmr4y2ymx95rQjg1szhZpxMNLodCR31a/b6HbCpOftIs6
 WXWmQPr5uwxhwS9betG43Ejw==
Content-Transfer-Encoding: quoted-printable

Hi Phil & Junio,

On Wed, 14 Aug 2024, Phil Sainty wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> > Let me make sure I understand the above.  You create a commit to
> > contain the change in the submodule and at the same time create a
> > new commit to bind the updated submodule commit to superproject tree.
>
> I can imagine this ability also being useful, but it would be an
> independent feature from the one initially requested here...

FWIW I did not intend to suggest anything to do with submodules.

There are too many issues with submodules and I don't think they will ever
be resolved, as they simply don't integrate into the original, elegant
design of having all Git objects in the same repository.

What I had in mind (and which I described only very loosely) was to create
a super-project commit that references the modified subdirectory as part
of the same project, much like `xdiff/` files are tracked inside git/git.

Yes, I papered over the need to create at least one new tree object that
is derived from the super-project's root tree object and references the
root tree object of the "inner" commit. I did not want to go into too many
details about the technical implementation, and chose to use the `xdiff/`
example as a way to transport my idea, but apparently I was wrong to
believe that it would do a good enough job.

In essence, what I would love to have is more along the lines of how
Subversion allows you to check out just a subdirectory of the project, and
restrict the revision history to that directory in that checkout.

This is different from submodules, and also from subtrees, as it would
allow to treat `xdiff/` as a stand-alone repository, but also allow to
treat it as a tracked subdirectory of the super-project at the same time,
both equally-well integrated into the standard Git processes like `git log
-G`, `git bisect`, `git rebase`, etc.

> > But I did not get the impression that it is what the original poster
> > wants.  My reading of the original thread (this is a resurrection of
> > an antient thread dating back to 2018) was that you have a submodule
> > at path S, you muck with a file in S/file, and you want to commit in
> > the context of the superproject, having the superproject track S/file
> > in its history (not just S gitlink).
>
> That's correct.
>
> My common usage was that I would add the entire contents of S, along
> with some associated configuration outside of S, and then make a commit
> of all of that in the superproject.

This could be achieved in a very hacky way by moving the `.git` directory
of S out of the way, committing, then moving it back, right?

> The two repos (superproject and submodule S) are then tracking the files
> in S independently; so if I was to pull new changes to the submodule
> from its own upstream, git commands run from the S directory would not
> show any changes vs the state of the submodule repo, whereas commands
> run from the superproject would see new changes.

I did indeed have a more integrated thing in mind, where the commits of
the super-project that touch S and the commits of S were more connected.

Ciao,
Johannes

> Cloning the superproject repo would produce its version of S, and
> without the S/.git directory.
