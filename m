Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E0E2701CF
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617608; cv=none; b=q06kTbxqBZDKxuv/OTQ/6onAzWbzERJ/aSFRHaSOGMguzs1ECn4R0W/wTlZIxmHhMIqhbK4tlYpJwz0caT1tnwV8ZmLi1UnQWAovRoBc9wdsh2J3oIpCTWt4goT1TFSoDCu/5w2HpVMjc4cGzdwTZoxSU+uS81RHc0sIQ+FXZ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617608; c=relaxed/simple;
	bh=ZgkvRVUhaivbzxOCaCXhlpkq1GPBybOr5Jv5iGIG4nU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AV3h3p7le8I7JBtHD+fOb9EDZ/HLpA5Eg8HZ6CopzY+TWG+YjWM/sDdxyr8ymBHo3neyF9RVma/mCm1NWXJf6N3YIelUE9D5Ij+d04hvtMSHDSJXaPkBa6YXAj2yECcG69F2kbC/wQ27nj9HaMmfA90P+ht5mqUFNehBI21BBi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=l1qcfytG; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="l1qcfytG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758617587; x=1759222387;
	i=johannes.schindelin@gmx.de;
	bh=z/0BCr4rBIGcOplV9S7aouC3RZexn8Lc0DEFXMH6Zps=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=l1qcfytGDCeakQxFDQbNIIZdu246VzsuLSA8IEKmbsDykuFmsGdQITYov7wJnPdP
	 EBbq5YjtYzGtlRZygQhzhIeNfE/wWihbS6TeIqX0MbzL1kTzUeCyqZWu1w9gt/fdQ
	 +arObPx/iTfaF47XPQLpnnjI2hIKxiq51G2Hxqdtf6HT99uLaer6YfoiSOH97NpSZ
	 W7UY2gYGNb19EsqAMPRyFSGvVoB0JUJaPx9GI7N/fSO+v08gi16swuNgenFP2TARF
	 ArwJDxc0iVWxxofm+DEzO0MucKyxXua7GmisKJDm/NoF/e78UvxmqRxnup4F2vhaz
	 syehXkWFynPVkZssQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.228]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPokD-1uecG948Lz-00IJY7; Tue, 23
 Sep 2025 10:53:07 +0200
Date: Tue, 23 Sep 2025 10:53:02 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
    "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
    Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
    Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
    Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: LTS "lieutenant", was Re: [PATCH RFC v4 7/9] BreakingChanges: announce
 Rust becoming mandatory
In-Reply-To: <aNIw23JzQE1vz2JD@pks.im>
Message-ID: <61e4895a-415e-f2ba-97d7-23aa99334191@gmx.de>
References: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im> <20250910-b4-pks-rust-breaking-change-v4-7-4a63fc69278d@pks.im> <xmqqldmmqa1z.fsf@gitster.g> <aMfwGHL7dh8dk2cQ@pks.im> <xmqqsegev4jp.fsf@gitster.g> <aNIw23JzQE1vz2JD@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bTfgZ7T5GqEwK4hHLjjNfVglh/ynXF2s1ET+PcMfTm2fxcmUj33
 HA7vKvYkd72kaZF1Q19f2SBSDZ00ZB/PzeRkcIo+72+H+vEhj+66jiKc5ptAO3O9aN+nvVE
 qMJQ9nq2YlvTC2zKGOscHcT6zIhdSUZnN6sn/f5hXMBZI+01CGAl9r23SjiHJNVepZjiR3x
 b7QSKQIEW170cGCZTcOVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V9hfJHbIVlk=;tsN5/dyQj5ffkvZTGSXTz8aHuGF
 3DQtv1Kjia/AJLYmNN989/67+qU1o4okCpvEhAJDUTTFwGnXtS9D5hzDQWIuDAroD4/JqQbFB
 HbZpkyvdMnFVidHwBTyIdqYKRfX09eZ7LQGQav9rLaX/Tp3YOKSKLaxv4wOZrCWmsGF6yd1qu
 wOmcDPX8iGvb0VmiKCIitmM5K8IA1Lbspsl3vo7LemvSY36I3V53HGmbXKIUBGzhL5cPzS0oZ
 cimM6WPE2rgvpdDydPBnf8kalhXBJJilUIQ9S5tXC3b00enyBeH6NIgVWLnnHi0FPR63vxgVg
 uUuGGdDwQdyRo9/GLKS1PCJPBo5IFWlm09PZiv0FclwJHsTTK0e4dgwb5rra2odxvRHymTYo2
 aEdi/3uZcXFVqvk25y1WYYaA9XU4Dvuili3tzE7QZDKcNMVCMCWTFACVB5RWclBGNPlZsao/D
 WUwuyrRyy70dPgCKp2bimEu+puJ2zTH65kXacr1g7CLdZ5pHV0WCcPL9Q2F13D+lKMqe86d4j
 RnxbOB9Jj33acd7RZlfdYC7VfS1tGWlYg9068Tfj7mXhxgcwi9aukpjhq1hH9v8MQBkE0m17x
 4v0AGfm1SNckPK0eF/W7uIpDnOWU7/To4ANtcLrxznbKg/mB6YkSOyfpPsSWt2KxHAsuj5qRF
 t1EOExGZlj67InaEiqqlZWocLc4XiKaP+7zq8nYPqhHfc316giiD83BAoJviau0e6fYeAs7lp
 UzpcV2MfB0QGjZJjNCswrqOT9jifx8vbBJx4Cg12+v2Ma8e0J8n8WvnqHur6xt3AtCqACCWcS
 Bbux4avw3P1MpZISq0636mABzm5FEweAefWDVgv0/YkpqtVktoxOzprMD2rHQ8JhAkWMnpYOz
 nyexL5BXEJDJn/mBFaS6oDuOUS+fbD1rCblkton6frNHXKNca7buGYDd/uTsaQ6cJQruwoSAp
 Qx+HaammDDgy20HXmfZXGS0IHbftFiOXcgsKHB2IAaeycF3A+xxa7DFtv3tn5l5xvNvQhH4ON
 rnal/PkJVHpj+T+Mq/TaJ05hjOiDC+mLbkZyavc9OSsP010CBC6I6IG2fstWEgHvnyP0uyYfB
 oSe1+RwgLuInXacHvRV1rM1GLYIxwcmgWixjXgn1tAo31185effjF2yPxh0apWB7teq9EQDuS
 sWyK2tx0LvQiWRG40wzZJQSb5Y2x7QmqV7rABJurhMH9h3BcL6dpxCIp+pWymTfzMKX/RAvkY
 j8/JAqJe1fUpDsc+8ZHyHBD0ffW9xbio2YNwQW1Q4nTFhpPK8zUe+iODAiNRhgddWAggU2thI
 7S4w3DBb2JCiUKMlgOsLTe0vDc1IwOLl7+uIqvdVLCrul1zJYUFZ5HddpZL+V3mGJHnSoJO0u
 wpnk7e6JJ0i/JcAJ/3nNo9fj0l22ZxJMjMHVOTxnNzJdIbkPEuwv2/UfLX37tPC+zheJws7Rw
 60JBqqZczCxEm1wq68hrKuyJGxAjunaaPjarpHVv96ib5H0/2V2EGynNrlkCJIxGysgqC18gI
 kXx93V8gHob66+1x58esbf6T/yCRDkmqjpCmjdDWVytvpRqqXvtjqUq187oaYpHvrQIyJFoYO
 YUmvShFWNIsYO67LylJCRtS+6WrGMP7Xo9CDjJhhHpC0KDDaTA3QyV6g9Lnb8APixdfgmqTkS
 r5Zm/ljtkN+ZYklu9je9aDswnKy0ecVkvxhYJmdQVc+mUkJauFmJT7jVv+++IJAM+nno5/Y+u
 h4mQJQbetgBEC8nUp6y0VHB4a625fmxC+MIjID65QDiyzE3G3s9cSJIF5bSiDXn3DnD2zyfXy
 erT0Quh49Webp6pSgs7Uh71atCu/L0+oyEFcGRINonaJ9WXfwpEy/gtg2X0tp+DSCNqza22ML
 X0YHm0W0QAeKlSQaLqphbSRTxNJarY45vgRUhojz3es8NWPZAjlyFdjbdLudo8EZoIdWALFhX
 m5Xlmh7T1+jSXnsULPu2pnAYHgbGVpt3G1Wk+YnkzLdGvBl3V3JwYITyQIfn9BL4Gr8wtgOzA
 CBA1OA+NOq/JGBIHz8iGxeu04S8jIWeEBq70PIKL0P4x6gjl6xREdLRjzA34Pj2L2pmuRBZEZ
 5QUjZok9M/IEjykheEtVXNzy0Bwjk6Lvwr7Rt5AEKkcWOVVbrK3ONcleG8OU2udW+9t0WVG/f
 XaJCmz7s6hpSV/Zzzp78LVJtfZmyCij7XJT3L1bsgJDaj/eVUDF3pcsHD7XIp7gZd2ZNJ+W5P
 alkmEr7gPzsrYS1qyDhxQ48SFJ4vNFqPQhEDJxOq4FmvdjmgT7usu1CYZqWWy3mF6iqdWjsc/
 HzfnxAQMM3+F5hMt7EMpjnyq3jGzCIzKDAoXzApp5Pqy33cc76GUFBEdjucymVAstep1a6B53
 GuIyrtxVcZV9OguxXQxQOZ1CcCH+IaiJu4m2ChqebCP0+wgzOeshHMvp0OYB9H8ueKnZtUkNm
 zixC2v/uuim3+FJR9ZYiBYs7YcBAhlf1faL6vCyJT3WVjQFhYoC5fU8k6voqQs8IQLSZ6yOpd
 j5HJ878iS+tmwLcgHZ0fOX/3+WJ0TBd2yycEgPyue65gkpGd2GMACOxc8yb0owUwjrm8Ob3IA
 sWOayykY+uLnpxS0mDidlX4LcXdHQIS4JJJYcjlnoNlnIAdFj7u1LvQPiJLbKx+r2C3z2xJP+
 l3v0oC6vZFMh4z5HIrr8tFJuBID1nUB2YbIVvEiNr+NRy9LRmVo9EirdtyojwAru4wYyI9EGh
 7JQ1Rf5hfNFr7FEPbVLgvJY5VtTi9Py97uVoVcoPA+WfB2r3kGQk8Ubaehk7yyQXCCcnPkmnt
 klmmUdlsTav9jtR7WVPL6OLqC67RaP99E4tV6KmgYLb+6MFTsuM5U3t76hokcnmDyMw/vnhRb
 GEk5GFpOBspw5Zk0CYUFY6I6GkEH2b4IgzXjc+fW9l7kYgtWz7SBu+kdRK5ZlltDjnt8YYgLh
 jGtZjYkqyUOZlcvAbtSC+Jf9A7rxFAQMAHQiWV8EPeqlKyr/YPtQEfBoLX9LNvwEtvStTBuM9
 wVHKyCNeNlHPUXo+z9dapv7AaeEkOqBUuOujWgw3TQMmP2tHTL57/ABTWBN4BewPNRrEmL5gI
 CjrApORzi2g3v9BxvqT3qa8+Pyy7bfPPPtfDYN8ZYJ4l6BVs2l2hugWEs/sGaFgs6y/EYPdwH
 ucT0Etjeq1Bq5tUY/2Rr7uIyopWJJlDolIbo8y7kENadA/zTBUZ6YBerWOeS15o7TQH0jYxh+
 aOo3fsrF2dk/9W7JnzpxD+S7k5uvtJOVPMeStaqQ3Q8keEcdfxqpE0QNmSZWX/afDFWuO98TS
 K7vyioa1BE+ESHRIaspv37wSB51HOsY/O42tk0+pC8tNU/GNqWGg01WBU56A5rsodIy38Uh5E
 GXSG9wocrO4lYDLz6EuDIBLBl3gwz0tH85LW3vJe8TclvcdzyOT3Sz8n1P9NA6yODVJxUZlmk
 1jtWGB6zadx49cywm31tF0z33xTe1pfwqBnFThnIScuXM6PrEumyXZWWtUwnrmkn05Zik8RsJ
 36VkfpGj9UvPnUCy8U8mmrzrrHLAVFukJrYFuoxvgfVRig4rHKOlT36p32Kk1C/9HNfzd+i2e
 OyDhRy0NO+nWSRmR1w3CXeIvkbHNBATlkVSPQJjtXgYqq+vM15VFmK3tg79xupqbZwVzf6y9I
 W3id9h5yn1IUnCHEnT4GQdEQgicKtx1Ysc4432rIFG0oesltg9Zf0PHDYG+bvu+6vcyIq9R/Y
 ldIGch/CHelo0k/88HZAUVhsJwZFGXtmUW472ZgTPayeI9GTDSwQLkNDFLbsf7J98ujdSnOOB
 HrRbXkcDLeYNVY5bIsnAxd93ejPaWX4AxYfAhgThmUBMQtUnSfmwgMUjPDop8qXp3xXdxm0u5
 gIGRwOSXGEbSkpSMcwwdqo0F/PlcluKx3ZmD/ZetSLBPJdJA8bmgQH250vLit0WbKWObQ4klX
 T4bOKPOMD/B1IBgBAZNAKaOht3br+ZiZSKYExvohc3dJssgoIbnuDYzYZet994xeFMRVJr5FY
 HPjVMBbBh83tUGRvO/t4b/raSwaDiMj7EszaU7NJ6b3mDYYQY4JUwYGG6RCNCzBW0t8EM11OL
 J97UuUzdgRzStk7BkUPwEEMcEp+4NGzuVdQy1n1Wu9rSaS+8w+tWyG7VKgewi8cs8aJUe7L7x
 RjSrnf9ERlhysKjS+1VBijQasWbk0E2BJumkLbOPAzFZUtkipPs4b+OxUydTO5AlGIPhrUsr+
 IxLDPDJ0uikxBZih9LmugR9j/A/UsJitsMsEUSF43TV1S4EZae4PLXUUyNBnVTVDgTk42ap7d
 ciCMv+sX8SPBHlsjLf8rtSFsXDHpE9IIsAuGtHRJrT1Ma0vg07fnNoSjDFn0uoMuSVvwaJfxB
 qnSa2n03RCzbHupiPg3/uw/jDtow1oQHKWa2fcG7ZMtdgjat7vx9RsTajRAXDvV19hje6cyRx
 RZ8WOqJsGPkTJb/hDaQ1zCyEZuQpYMAdD7whkl4fzqTSqrPYbjUPU+hU+DMvhRZinFQ1Qx+vD
 9c6GSDohI4Vbi3lUP6rzINOu2r+C4/eYeLOj/IwCOKsFHZokVUA+0B4j1uzGxF3phfSE3pzMt
 Z2OSjzvwSbMDsDyIbnbHhkcT/5j1OtK02TofhkIsi+uQRIl1aQTJ0Flv7JhjdLDRa5rOJSB8V
 5BvjyXnXJcUp1aMC/wtLU7fe+9piR8XJnYiDdeIXRGF9JsmJqQlJTQGcpds6EEzcx96aFbU=
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Tue, 23 Sep 2025, Patrick Steinhardt wrote:

> On Mon, Sep 22, 2025 at 09:24:26AM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >=20
> > >> I am having a hard time imagining the practicality of this "hand
> > >> over but we still review" arrangement.  Some of the security fixes
> > >> are embargoed, and the reason why we are jetissoning the stale
> > >> codebase is presumably because nobody is willing to work on it othe=
r
> > >> than the "community support" folks.  I can imagine that we would
> > >> qualify them into the git-security cabal and let them use the forum
> > >> to coordinate among themselves, but then to what degree in the
> > >> "community support themselves" process is our involvement expected?
> > >> As long as we can make sure that they do not leak before the
> > >> official embargoed release, they do not need an official stamp of
> > >> approval from the project or by the Git maintainer---that is what i=
t
> > >> means to "hand over maintainer ship", at least to me.
> > >>=20
> > >> In other words, I like what I see in this paragraph, but I do not
> > >> think we can practically live with the part of the sentence after
> > >> the last ", but".
> > >
> > > I think the most important part here is that this community-supporte=
d
> > > LTS release should still live in the canonical repositories. We shou=
ld
> > > avoid the situation where we hand over maintainership to such a degr=
ee
> > > that the end result (the tagged LTS release) lives somewhere else.
> >=20
> > Why is it a bad thing?  The official repository can have a README.md
> > with a single entry "maintenance releases for Git 2.98 LTS (most
> > notably with no Rust requirements) are found at this separate site".
>=20
> There's a couple reasons:
>=20
>   - The LTS maintainer may not be as familiar with the Git codebase as
>     we are, so they would benefit from the usual processes on the
>     mailing list.

Basically: It's a matter of trust.

>   - The LTS maintainer may not be as trusted as other regulars on the
>     mailing list are, so we (from my POV) may want to avoid having a
>     basically unobserved fork elsewhere.

Basically: It's a matter of trust.

>   - The end result would still be "git", and users will come to us to
>     complain about issues in the LTS release.

Basically: Users would still only trust the main Git project.

>   - Initial releases of the LTS release branch that are managed by us
>     would sit in our repo, whereas subsequent releases would sit in the
>     LTS release. This will likely cause confusion.

And confusion sows distrust, I agree.

>   - We reduce chances of a hard fork of Git.
>=20
> So with these in mind I think it would be sensible to keep the LTS
> release as part of the canonical repository.

I agree, and I have to say that I am puzzled that it was even a question.

> > So, no, I do not think we should unnecessarily mix community LTS and
> > the main project.
>=20
> How about the following tradeoff: the community LTS is developed outside
> of the usual Git workflow, for example on a forge, so that the LTS
> maintainers can work in their preferred flow. But eventually, once they
> want to do a release they send a pull request to the Git mailing list
> and then the tag lives in the canonical Git repository.
>=20
> It gives the LTS maintainers flexibility, but still makes the canonical
> repository the single source of truth for Git releases. Furthermore,
> we'd have a way to double check the results before creating the tags.

I have to admit that it sounds quite odd an idea to "hand off LTS support"
to a completely different entity. It flies counter to everything I have
learned in this industry. There has been exactly zero instance worth
mentioning where an LTS release maintained outside of the main project has
been accepted as anything remotely official. There is no reason to believe
that Git would be the first.

Let me propose an alternative, one that is much more likely to be accepted
by actual Git users, including professional ones: How about assigning a
trusted, prolific Git contributor as LTS maintainer? One who is deeply
familiar with the Git project and can, if the need arises, help the Git
project steer clear of unnecessary conflict-making e.g. via
intentionally-incompatible bug fixes on the non-LTS branch? Kind of like
the lieutenants in the Linux kernel project.

Naturally, I am thinking of you, Patrick. You have demonstrated diligent
work in the Git project, are highly trusted both inside and outside the
Git project, and you seem to genuinely care about the long-term success of
the Git project.

An additional benefit of this would be to have a dependable release policy
for older release trains, just like other projects have. I have heard the
desire for such a policy many times.

Ciao,
Johannes

P.S.: As you probably know from my past interactions on this mailing list,
I am not typically one to dump work on others; I am more than willing to
assist you in the LTS maintenance tasks in any way I can.
