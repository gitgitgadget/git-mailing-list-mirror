Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2463B52F77
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777746; cv=none; b=csqqCO8JS433if13vp2GCJv+h44QRFpb/OuqOMHpt22fnqmY/NQemm090Ku7SMerqI/65btwaPIXLh3o1e+OW5A49copYYCDcizMS+AaM9zv9hKX7KXoGivhQVglXZKGEXlbsJQ77PIHQhpYSFxQzNFrMj4hgTg/JMuzbJ+D3lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777746; c=relaxed/simple;
	bh=ivFFEvMlkouAYQ1y4742WMMrdset+nG8CoyQDexro4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XkSKjoypzIQw+mj1q/vUSnj12xA+I/nsZgxHxy3ih/eqvnSbYOOcnY/SFSEdu8ur6GJv/X9t2YvK62GDXb8dM+UIEKdH1Q4LepPZHhT9GDcHOFeTt0ZiNIxzIEnG7MbJtDWrvLEfmlmFYJBacDgQfBEn6zsr7Ezoy3mKxmIgDkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kPipyZB+; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kPipyZB+"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 91D7B207C2;
	Mon, 18 Mar 2024 12:02:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ivFFEvMlkouAYQ1y4742WMMrdset+nG8CoyQDe
	xro4s=; b=kPipyZB+8MQsZaan8IgANszHt3gVWSCDuK0zaO3GUDOzNI5LPmUAX5
	/kCMg1b85bph/tsq9lacZaB41UdauUMfmg/uFo8MZqGMbRxCEyDxiQYAuMaVuR27
	kmErzmQLpa7j1JAI8SFFUcG4vBzrlc2ynos+1NpfFUhWMMZu7OFwA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 89F6F207C1;
	Mon, 18 Mar 2024 12:02:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E9BA9207BE;
	Mon, 18 Mar 2024 12:02:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Brian Lyles <brianmlyles@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] docs: correct trailer `key_value_separator` description
In-Reply-To: <owlyv85k2gts.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Sun, 17 Mar 2024 23:29:35 -0700")
References: <17bdc28ea2b88503.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
	<owlyv85k2gts.fsf@fine.c.googlers.com>
Date: Mon, 18 Mar 2024 09:02:18 -0700
Message-ID: <xmqqh6h3jzp1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E64FA036-E540-11EE-8D16-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Linus Arver <linusa@google.com> writes:

> WRT line lengths, probably 80-ish columns is the (unwritten?) rule. The

Your patches will be reviewed on the mailing list.  If you keep your
line length to somewhere around ~70, the line will still fit within
the 80-ish terminal width after a few rounds of review exchanges,
with ">> " prefixed.  That reasoning is mostly about the proposed
commit log messages, but the same would apply to things like
AsciiDoc sources.

It is true that we do not write it down.  Perhaps something like
this is in order?

diff --git i/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
index e734a3f0f1..68e9ad71a1 100644
--- i/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -280,6 +280,14 @@ or, on an older version of Git without support for --pretty=reference:
 	git show -s --date=short --pretty='format:%h (%s, %ad)' <commit>
 ....
 
+[[line-wrap]]
+
+Just like we limit the patch subject to 50 chars or so, the lines in
+the proposed log message should be around 70 chars to make sure that
+it still can be shown on 80-column terminal without line wrapping
+after a handful of review exchanges add "> " prefix to them.
+
+
 [[sign-off]]
 === Certify your work by adding your `Signed-off-by` trailer
 

> text files aren't really meant for end-user consumption (that's what the
> manpage and HTML formats are for), so I think it's OK if the line
> lengths are roughly in the same ballpark (no need to worry too much
> about exact lengths).

Yes, too.  And it is one way to reduce patch noise and nicer to
reviewers, when used moderately (i.e. removing a word and making a
line to occupy only 50 columns when ajacent ones are 70 columns may
still be better than reflowing.  Leaving only a single word on such
a line may not be reasonable and tucking the word after or before
one of these ajacent 70-column lines would work better in such a
case).

Thanks.
