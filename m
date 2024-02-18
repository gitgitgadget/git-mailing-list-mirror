Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36B7568A
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 22:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708295894; cv=none; b=rA8+gExc/SyfAx/hIhZifje/0OYI97eqBiJwDHFcdFiFMNr7o2TMUQtpZy6bYdIHbH6KbVXtFhq383SPKH1oQAmXCY6gW8IBLBRrvY1YkERndIBAKYKeJ5GjvyMRPnLP5cNkaJsL7S4NoTWUMt5r65KnEtjVmACVG1mcgmmcRKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708295894; c=relaxed/simple;
	bh=V8VLo16SNUoLwcGctoz8QzwBoLR2v0Jx2qDEw9WZ0ZQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ke0CSJcbjqw+pWAm/fUhbEjuBveGk9qi2cdLrkOSsGjNYbWlZ4qCWMdF1dh51kWEzxx+SgYhYwXjhTGWtEDYgZYjzcWy07aIH0nHAjpxg9jCFTkRKvnRqAwY/rV9M5JloNATeZhkz+WO8Grkg52Qt9qlMlplPC9gxPhvu1ve4AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=JNQVD+kT; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="JNQVD+kT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708295886; x=1708900686; i=johannes.schindelin@gmx.de;
	bh=V8VLo16SNUoLwcGctoz8QzwBoLR2v0Jx2qDEw9WZ0ZQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=JNQVD+kTL4IY/NJRuj83/5+7rot8A1jUhnhx2PuY3fCzj3tS4VT5+/ZKBT5No+QP
	 ypOJP9tnOPBo1if+y8pI84BhiavET3CRjOen5BHm0uuwaCMtERHyOWL05s4oI59Lb
	 G0XvF9ri8u37tSot4zhTJRVETbfG3QRgwctvTmBqsQhrzBHlAlRlxeUfrnUd1TOEq
	 +gzWeAYOIObZPYnDME3A1sSqCQmc3GbF0v2wNLUv4RfLeZKNIR5NwFu3ljDbKc1tC
	 qLpoENZT+WmoLdEUs7Dy04+p2tu2llTclKBfxAtCGSmsHQx5VmDesufn6v2K87gQ7
	 B+yt5WLBWqOYbu0Acg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.214.170]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMXQ5-1rL7iz2Xmp-00Jce8; Sun, 18
 Feb 2024 23:38:06 +0100
Date: Sun, 18 Feb 2024 23:38:04 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org
Subject: Re: [PATCH v4 0/3] apply with core.filemode=false
In-Reply-To: <xmqqzfwb53a9.fsf@gitster.g>
Message-ID: <fd8264c0-3080-c9d9-cac5-51115b9909a5@gmx.de>
References: <pull.1620.v3.git.1703066893657.gitgitgadget@gmail.com> <20231226233218.472054-1-gitster@pobox.com> <xmqqzfwb53a9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yiV2/9gjqKGntHbu2uRYbF8WlwENh/1Q794ri8OXlexj7i4wPW+
 10zC5g8xdBeUYgJnbvXDy8wmU/QDYG1nbDyJZt07tScSYV0yPIB7RkBbUVu5s88OQLFLR7o
 m4wuR6cmu+r25pPJTwpSiL/u4+JSjgKoPBCKjZ40GHKyPeI5rojHmulTAzmWP5pp1IXcWJJ
 A8AuGBJQgSNwCpRAJmoOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0Cd/z+Iio3Q=;a0dEqAAU+QKfbRnyvKfCbsliIux
 wjO4PCXNZRD3h+wEoNEv3jxqwPP7cLto34iZfp534jaH1y4x8JWScqinc/dCEK4d6eCCm+nUT
 bNnrcREpxxXWq1XOm4RwrURLx+Cw5swB7Qm+TdC/eb2kZ5nNmO4jhYq8hkIKTq17t8CW3KG6e
 1bw8614NwQhwbs+yx/Ugb07myv9awnj/1REFknaRuDmYSMdNoOGDXeVxe49qJKS6Hp16WhaPl
 BlDR8+J1HQJ2c1+6XXtW7AKVHvppoE6bSl6bbcyAaPTPxjt3QS/nnQVP2IhHiiE0DYT1njrQl
 UjrhfhwJalqeo4tRRHAwCDLo521RmMl1NYt5Hi5cVPvxKjebk/r+V56R4EgfAbKF1W6ngzsPr
 t5WLSWdDoQ+i1vrLgQqNQaMb6Xn1uNHEL2diBroNubP4ltQu24vXXQyncpZclJhtXkpSisurK
 xLj0ovG2QT2omijSWhrkHWfhlGJzWkCZiQZ1CkdOwCSVx9ezfik9PP7sJOH+Z/yOOtIuIjTCC
 6iesaIgVEcoS/8Sz+6MA15p76zmJSf/k8hNBKyqSvgYyMCmpnNUuWO1yDdlKG09uQbIZnTM/K
 z5zF3xH1FDa57FcWZ/VJx1A+5HrMFZVUOyUJl8GJd51ZCB0iEnF8lBY7ky2S2jt+MyM6X1a84
 VMNAETn2UWzmNvr2rdOeSK7HwoszBE14EqAjY/Rs8aJAU9yRCiOw0pI4nq7eyv3r4Z3dCoWD/
 lUPgniWIwm33dZPL2/k1iPxvDBNluAf3VEzEIS85/0ZpuYGhWYHu8w2/V8waxcPXZvNYNAXTS
 yb03daiWZf1+3h+5LgLEk5YXx3/Z/OS+z8MLxWc8FP73k=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 7 Feb 2024, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Chandra Pratap noticed that "git apply" on a filesystem without
> > executable bit support gives a warning when applying a patch that
> > expects the preimage file to have executable bit on.  Dscho noticed
> > that the initial fix by Chandra did not work well when applying a
> > patch in reverse.  It turns out that apply.c:reverse_patches()
> > invalidates the "a patch that does not change mode bits have the
> > mode bits in .old_mode member and not in .new_mode member" invariant
> > we rely on.
> >
> > Here is the result of concerted effort.
> >
> > Chandra Pratap (1):
> >   apply: ignore working tree filemode when !core.filemode
> >
> > Junio C Hamano (2):
> >   apply: correctly reverse patch's pre- and post-image mode bits
> >   apply: code simplification
> >
> >  apply.c                   | 16 +++++++++++++---
> >  t/t4129-apply-samemode.sh | 27 +++++++++++++++++++++++++++
> >  2 files changed, 40 insertions(+), 3 deletions(-)
>
> Anybody wants to offer a review on this?  I actually am fairly
> confortable with these without any additional review, but since I am
> sweeping the "Needs review" topics in the What's cooking report, I
> thought I would ask for this one, too.

I just had a look over all three of the patches, and to me, they look good
to go.

Ciao,
Johannes
