Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907973;
	b=hmBjgIy435mbP4/izs7HYoqfyBpDI5q4T2DCg73199Co3AZtnOqS62W9PlIOloihhXI0
	 AiDdpXmwCVkn//Nr6EZWJRh7kCwlF+Muur1MatP4Uj2voIQ5zJlmGDHHG5YaTOmew8g4H
	 V9l6oMl0ckck7wXKQlgf59gayRi+HsYBZ9egcPthkAPIwLfyGJc5EFZcSHgS3nCGvkJUV
	 6jz0oaCCGxQ5IF3bjtrNj9ouD125KnqUFjakGN2qxpUaZMHwfh4DxcAwV9m9qK1WzAnen
	 fLzsMBbBlNMgAIJv6cJvZIrh48wyqXYYPwP42V8SFvj9eE8b+f0bTtjf+/JDD20c77g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907973;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=DzsyztOg3UEytx2WuvMOL2TXu3jYGdJ2k2bZAoVYjnU=;
	b=lRaHnNca5h7a5/ia3iibG2qZTzHiBDm1+ISz5h/9PxA1z/asxjLIZP+880ak7EXvSwes
	 OP92upGCZZm1kIHLrungfM2a6w/xp4YnK779t/8qHOi6yzGa3fo0A//mwP6KfCvNGe7op
	 FR4iXvjUw/mifixRAhF5uUJWvWlrXDTvKZ1OACKHG4WmJqmqaYhHT6KC6zuCRs1+hA6RH
	 q0CO35AzbmzrrNhVB/9mdRTm135xV3SZp5/uoJhzUZ6N9HdlRkQw0Z3PW8AzFkXrxxHyr
	 YzoCs1P40PYCji2HKe8Ha6CDDP+rG5DOjp/FQbNi1q0tqtxvI0P9e2E7QbfwjszUXQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=giEJ+vOn;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RjFE4Fc7;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD54606A6C8
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 19:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFD54606A6C8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=giEJ+vOn;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RjFE4Fc7
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 164DDEC05DD
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 14:46:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 05 Nov 2026 14:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793907972; x=1793994372; bh=DzsyztOg3U
	Eytx2WuvMOL2TXu3jYGdJ2k2bZAoVYjnU=; b=giEJ+vOnbWJ3Ry5niznZjK385Y
	lKKld/T0K0r1GOvPsz/mYDMSIO3/6lZMFRk0DcmSbafOsROoi73xW0zmZkcz9h8q
	OBmw7DuQIV+dqzAW0Lx+jysuM5AUAJIR0hSph4/ET6fsDpndGC4yZq3xZZgXnQdk
	cGvc5PGVU+YhJL7eRljMq3CA/ntoWW/roTAtL9MUmlnhlB5krrxGwph0vODqCMGE
	NgIzRV0WlQUZTEplXSNG9fvqrnlZxGOX92Ia3syoXBvQK9RIGMyQSBOgp10/ylpo
	ayLdTMmimTpZtwCyOmSj4eve/+I78D4TZJsTABRz6HKBhVCv2AxUdKVwXqqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793907972; x=1793994372; bh=DzsyztOg3UEytx2WuvMOL2TXu3jYGdJ2k2b
	ZAoVYjnU=; b=RjFE4Fc7NxxMJYpOoKdIjEzdhdBi/y3UqNR5c3KkB2wHtXZABDW
	scwU5vMFlM7JT6DhJkd1FlSQqlDv29kOT3UZYSx2D9/MVGYG+17+sRBZbSmzhNYx
	UvJQnYutreiBjTy8LElklhSbzjgLsPsNPF/X2PO+xxwHBMH5Jor340b93Au4inyr
	WcoHLdDbY9Zzl/pvrnEdWxxE0U9AM3kXSpoqEgq1Ej3v7rOtWotEp+yYxOcJI6zN
	lUArGfE/cxmhWMlJj5I22suwrXtbH88AhAkYFVB+lAh0Wih3vbq+GVzbKZNh327Y
	ZHt8UOrUV6SAEQv+3pGxhpYE+Kguj3H9YXg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793907972; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bTbwANyMnS7fAAjURXj4uNjeD3SUIhM3Ush3Jacc1W2oxo7
	9CTf86IzaBs8Z9W785ImGYjpza0o+ynggfqYyOYp5l8eahxWQUd5TwxXzMSjPdgE
	HBj5smHRFIQ2ubvBU1z3/8BBjOhhuH6PhyThPFaM4uC9o8+9XXI776Fm54DwyTdl
	qBPEfM671dd1GnpDIAjO6eCmmOzQzbs5OysUkg5h/I2dLgjNF5CbO6UNidr5eq8/
	AYfJTTrizS/r+tbmU3ILI79w6j1RtYDgr8sfxATiE5uOYNS7VWppviyyoryivm9L
	hIl5mm+AxWotRy+BkKwzKc6UNGQ5X81F2SQgP1Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:w1c3Z2TFrLS7Yn2H5EVe/PaKjuir7YiJP91cDvuochc=:hcUXJdMQhpVxnYNLdJtztWcg7nlSImp+9EdVuLdUsIE=;
X-ME-Sender: <xms:A93sasqf-XXFV6HdMEBSF0CA12Ua66aLID5npQm2u87eiNIaBI53IQ>
    <xme:A93saphrPRbtRe1qsF609qDeVNg-oQzVI6l8-lv-a6HSHC4YxNM57p-D55_0dkTUx
    wbTf8W69ntfUxWyCsY7DXlwzQWnocF-MM5yNzUkSr5h4E910Jc5Nm8>
X-ME-Received: <xmr:A93sapjyA0qab0rQFnOUEHMeuPXXARzI2ECRfQwTBJSpD131sku4GZYMzHYu-zWjPNCa6Up-qO4jDcmNm-1bui3KihAkluW1YbEq>
X-ME-Proxy-Cause: dmFkZTFee0hoS+2T9Qugo2jUBlCCTtUlS85ilsYzWpXtSeZnczkGcKU1UTeyqBcmkQ0Ggd
    Yy4IthGEcRJ6gnLOBYAumsWxXGT6ZqvUaRE0iE3nuBrGwwsaya1oqwtKTkjy4Q8uUxjNWa
    E9ThFVJP6+Hqvwkq9hlBVVPQUFLprYy03Fs1apKQIYrwST6J3AThNcxveiG0RJEJ3MVFuv
    xXKBEhRPmldmPC1TzQvguDMg4sDQL28vujVsYK5+enwz2FVMOGn6CKDhgP+okOmSt6bwMM
    NPBicsWF7AkYlUjDi3lcTUrYAddncwIyU+nXFbRJ3RGPT/7x7tBb8kIq+8znmlDmKMh3qo
    qUIWOuFzDfq0Aal/YdENp6LGyV+6Kb9AciyKXIuIyVvLp9IfOeKj0ORmCPJRrYODOsHiQn
    gDbYJMG8xEf0qfSEVGj89T6fZnXRXFEpzEJJTpSLciI37geBmly8ZcELzwq93EO9lYtfRT
    taal800VPYg75xfR5UE6+M5vzdjTB97sUhrcUXvg97Ubo2jNdc/ITmgucNV4wyx/E4ozFp
    ies54wKvoRu0noPQx2gwaS+zC4JAa/z1Aww+ud9msuWtMo3ItC3ZUDryfebMWPV2t3MZsy
    dRLThZd3m71A8ol1Q/8o5Yy9R4SDDDORLvknwu9XBqxnwPnF027+LE4r+hqw
X-ME-Proxy: <xmx:A93savgEZAmT5RnWbe_RHfKMk8fB4aUU8pjXL4G9nDCZk3q38h2M6w>
    <xmx:A93sapKqwrU9lSO_-9HS-6M5wYHXkHrVmaQuSaukaAH4qMLxVEnp2w>
    <xmx:A93sauEltickLspRh89NJchvUr1bP7NkwZ7OU2fKREFYGu3WKecgCg>
    <xmx:A93satSOO-4Q33th03-y1M38psmwnI3JPxQy9fgy09aUWx79_STa6A>
    <xmx:BN3saogWR0mcnWv5AqoGwrBhtLUpkUus9U9juwbo6BaLXGtZXipwdroy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 14:46:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH v2] doc: git-diff: rewrite EXAMPLES section
In-Reply-To: <pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Thu, 05 Nov 2026 15:40:17 +0000")
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
	<pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com>
Date: Thu, 05 Nov 2026 11:46:10 -0800
Message-ID: <xmqq33tft62l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> The top piece of feedback users always give about man pages is always
> that they want better examples that are relevant to them.

I'll add this squashable fix-up on top before queuing; the change to
the code is because otherwise this change would break a test.

Thanks.


 Documentation/git-diff.adoc | 8 ++++----
 builtin/diff.c              | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git c/Documentation/git-diff.adoc w/Documentation/git-diff.adoc
index f15e56633e..42360f9b5e 100644
--- c/Documentation/git-diff.adoc
+++ w/Documentation/git-diff.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [synopsis]
 git diff [<options>] [<commit>] [--] [<path>...]
-git diff [<options>] --staged [--merge-base] [<commit>] [--] [<path>...]
+git diff [<options>] (--cached|--staged) [--merge-base] [<commit>] [--] [<path>...]
 git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]
 git diff [<options>] <commit>...<commit> [--] [<path>...]
 git diff [<options>] <blob> <blob>
@@ -47,7 +47,7 @@ to diff.
 	difference. All such pathspecs must be relative as they
 	apply to both sides of the diff.
 
-`git diff [<options>] --staged [--merge-base] [<commit>] [--] [<path>...]`::
+`git diff [<options>] (--cached|--staged) [--merge-base] [<commit>] [--] [<path>...]`::
 
 	This form is to view the changes you staged for the next
 	commit relative to the named _<commit>_.  Typically you
@@ -55,10 +55,10 @@ to diff.
 	do not give _<commit>_, it defaults to `HEAD`.
 	If `HEAD` does not exist (e.g. unborn branches) and
 	_<commit>_ is not given, it shows all staged changes.
-	`--cached` is a synonym of `--staged`.
+	`--staged` is a synonym of `--cached`.
 +
 If `--merge-base` is given, instead of using _<commit>_, use the merge base
-of _<commit>_ and `HEAD`.  `git diff --cached --merge-base A` is equivalent to
+of _<commit>_ and `HEAD`.  `git diff --staged --merge-base A` is equivalent to
 `git diff --staged $(git merge-base A HEAD)`.
 
 `git diff [<options>] [--merge-base] <commit> [--] [<path>...]`::
diff --git c/builtin/diff.c w/builtin/diff.c
index 18b1083e98..13fe8a21e0 100644
--- c/builtin/diff.c
+++ w/builtin/diff.c
@@ -31,7 +31,7 @@
 
 static const char builtin_diff_usage[] =
 "git diff [<options>] [<commit>] [--] [<path>...]\n"
-"   or: git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]\n"
+"   or: git diff [<options>] (--cached|--staged) [--merge-base] [<commit>] [--] [<path>...]\n"
 "   or: git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]\n"
 "   or: git diff [<options>] <commit>...<commit> [--] [<path>...]\n"
 "   or: git diff [<options>] <blob> <blob>\n"
