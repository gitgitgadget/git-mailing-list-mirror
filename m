Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529302F99BD
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802281; cv=pass; b=ahZNqEuQg1atBmnhQVc9Ufxd6cI09z+HZrl6ijS0Nat7KLJ+Yo347/VO5GG5Mq9t+hMQ0fLaA+zcgK9MhNcnTt8NHKtRwpv/XnXM/O50zgkV1PVlzPeo50BLXkhKw00k/GNUVPeLKeirOYMtdOe+Wc7O2sBjOuRe41UpAvErLJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802281; c=relaxed/simple;
	bh=1M/wJxwpxlGxWIZq0mxgYVJ8f3GGtiU+4PWMRQBeeRc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=GmAdj4O53dl0tzb2GMbR/0WvD7fyvGLqKVT9PTJ7gBbXeBMUZ8kQ+qQ6Z3UHzZm2l3f0yeVrEkM61jDwlSVX5lCLE5Op+iYoe+V8DOK9jTxrUARtCfHQGRKVWTnTEkP8UUqnX1SibbCVn78PYfqZEPe2Wk8gstwqx9bFftAXmAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=hLCjz7WT; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="hLCjz7WT"
ARC-Seal: i=1; a=rsa-sha256; t=1762802265; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WSWvN7r+KXBbm9fnUA851iam9J8zuqlXDOnQcexHYIcPz5mU3nIG3RkfDHZ2b6gOgCuzCvMAKA1yY9Gqwybks10khvKjXoYQ96fQDsHK9WbGklJHGbJZ9XmZjTRGGXB5QUmVzecz+YrLWbrD2udxrW7haEG2yX+FW2AUJH4yuVM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762802265; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HYGlgeGCmERprBKIJmwB0BWJkYVexRlDCcEBqMc6Gz8=; 
	b=B/M6wK8+tF/cW9bV5lYeuW+1r9lOd1qvuAHhX3nDvHB1ZkvKyqghbMWpAfrxHxR4H8hh+roXOslB4WXpkviSjMvkZ+LG2y7D+EQCC/DRMMZHtRv568qLIyP78v15H1UEQ7QVlTK2TbVjpD2qA8M6BoE+R8PHlxoSFnXu+Qf6xBw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762802265;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=HYGlgeGCmERprBKIJmwB0BWJkYVexRlDCcEBqMc6Gz8=;
	b=hLCjz7WT8p59Vow0SQIp8TVssaLDmmNQbMAvUS1ZNVY8HU78y/c74UeoEpyDnHIH
	3gfCyZn3aUwnJIZ7Q04283RnrV9Azue3UxYaBsLX8l38c057hIliX5RiPwH+hrpB5uG
	0UwMqFyZxhselJtcb2raZ1FrxI5f18PCd5j92eAU=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1762802264007618.0132475742404; Mon, 10 Nov 2025 11:17:44 -0800 (PST)
Date: Tue, 11 Nov 2025 03:17:43 +0800
From: Li Chen <me@linux.beauty>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "phillipwood" <phillip.wood@dunelm.org.uk>, "git" <git@vger.kernel.org>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-ID: <19a6f33e7b7.34ee7a88535992.903448798239861574@linux.beauty>
In-Reply-To: <xmqqecqcmohf.fsf@gitster.g>
References: <20251105142944.73061-1-me@linux.beauty> <xmqqecqcmohf.fsf@gitster.g>
Subject: Re: [PATCH v6 0/4] rebase: support --trailer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Junio,

 ---- On Thu, 06 Nov 2025 00:30:04 +0800  Junio C Hamano <gitster@pobox.com=
> wrote ---=20
 > Li Chen <me@linux.beauty> writes:
 >=20
 > > From: Li Chen <chenl311@chinatelecom.cn>
 > >
 > > This series routes all trailer insertion through an in-process path, r=
emoving
 > > the fork/exec to builtin/interpret-trailers and tempfile juggling.=20
 >=20
 > This description makes it sound as if the code before this patch
 > series drove "interpret-trailers" via fork/exec and tempfile
 > juggling.  And that contradicts the title of the topic, "rebase:
 > support --trailer", which implies that the topic is about the "git
 > rebase" command, and that "git rebase" before this patch series did
 > not support trailers, not even with fork/exec and tempfile juggling.
 >=20
 > Which is it?
 >=20
 > I see trailer.c:amend_file_with_trailers() does fork out to the
 > "git interpret-trailers" command and is called by "git commit" and
 > "git tag".  Perhaps you are updating the amend_file_with_trailers()
 > helper function to do the in-process thing, so that "git commit" and
 > "git tag" no longer needs fork/exec and tempfile juggling? =20
 >=20
 > That would be great, regardless of "rebase", and if you used that
 > updated helper function to teach "rebase" to deal with trailers
 > in-process, that would be wonderful.
 >=20
 > If the main part of the series (i.e. [1/4]-[4/4]) needs rerolling,
 > could you be a bit more careful when writing the cover letter to
 > make it easier for even those who are seeing this series for the
 > first time to understand what is going on?
 >=20
 > > The first
 > > three commits centralize logic to reduce overhead and simplify error h=
andling.
 >=20
 > ... in what code paths?  "In command X and Y where they do Z", "All
 > the call flows that lead to helper function F by eliminating the
 > need to do G that is costly and replacing it with H", etc., is what
 > I would expect to see in such a description.
 >=20
 > > The final commit adds git rebase --trailer, currently supported
 > > with the merge backend only (rejecting apply-only scenarios and
 > > validating input early).
 >=20
 > Sounds sensible.
 > Li Chen <me@linux.beauty> writes:
 >=20
 >=20

Thanks for reviewing the cover letter. I will incorporate your suggestions =
to improve=20
its clarity and effectiveness in the next version.

Regards,

Li=E2=80=8B

