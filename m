Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADA41C8634
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322545; cv=none; b=GnvSpBzAb/dr70TMr1j4rk7okyr01XFJosiKL839aE2w3bv5tyu2hhiRe90iG5Z7QJmJmfvrkDxdqt896LBRUijNt2VaH9nz+rQHsjEMcfBS8itBUivsI6ovRim1F7iVi1ZWRu/CiVE24Rog4L18BTEKhGP+F+0hfW/n42VNcSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322545; c=relaxed/simple;
	bh=BKtFlS3ivkH1x+OWupiYyB7PSHSY4MMfYLziMMa71tw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y2BY2dWHCqO80Ubxn8Ps9f4dxtW71Tp+CeNpjazLReIfanwkEW3F97Jhgt8+byhABLucpT9Px7F8zZQTLDvn0Z4e1FrQc34dMsGgB1PCGga3CJTNaUkm7wyM5kgUo1cqBrPVtea8vAdyjgbzedROaZGisd0/0gaGRgwTNanIO7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FlIqvady; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rNKvRSqw; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FlIqvady";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rNKvRSqw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CF62B7A016A;
	Thu, 12 Mar 2026 09:35:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 09:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773322542; x=1773408942; bh=arqnejqFlk
	wr+4whHc3y7uuB96iUS8VdJnKCRT1yuck=; b=FlIqvady5ZlbMRrXg54Ui8F7Lb
	UsGI160R4hc8asntoCummumxBqqcFRDs9Bcx0sFjo4jzc7wM40WzJDbRKSJirbwP
	DrlMLU8k/sPdV/JUXFHTB8uz54v86VrKkkoKfiGny3zhA/zR7e+PO+1HwlR99pv9
	LEFAzzaJK3DyEzsF4W+p6riuIzbAtOlRdte5/Cs9o8SPns7wIm8lRwpyJeeJuSlA
	31vfljHKdZOIPxE+q0uGqopltjAiCffbju+HlPkQpgUJ0mXqQiVCACSS7Gqrgw/m
	LKgCJ5bP29tbIXp1w/CSNuhC43aqcijTMhgPzool5SXRJi6gDWEdsKX6Q6lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773322542; x=1773408942; bh=arqnejqFlkwr+4whHc3y7uuB96iUS8VdJnK
	CRT1yuck=; b=rNKvRSqwjbYB7dmsbn1dssbwZR2ZnutlftiWpvw6fd/x39rumIh
	h2de54awKgOQHoXSE1zRSm9+XddOvVcKkCYTQxhGIE6R5pa0ioJ2OQnITJfaaqN7
	6P08JdrgrryD1/BvdIjZec63PWgld3TuU9VZVSgYTqznV94fN8DXIPOsrzjGDkaA
	QwNiMTmeXOqMVh/f/YE8xlLOhC/9WOmJjTZcyzr5Ax8qwgkhEnswcQ3KPDkbuMio
	iqwTutU22nSLv4L91QzXdlTtAaNjVRYRpbyIuROFA26jsUUSZn3/OG3VH/P8T2yy
	jrvVHvmsoRGKpHbYpk7JqyYQ7rXk0g5pXng==
X-ME-Sender: <xms:LsGyaYMJ-eY89vBcKlSa7Jv0WivIVkkwukLlkjaOynPJZBMhuVtVqA>
    <xme:LsGyaV9_h9jO6bOrhAvd8RDWJSDpSSbHbChzFf6L4Dh8GIG4q23TJcghUya76YMu2
    u60ZVLt1UzHf8SgGulijAAiiWu5iLb1YVV1Zl0lOQrxHhFF6m-xjA>
X-ME-Received: <xmr:LsGyaUSjnilgHf8q9D5bnu45oqCA0fkVEC12X5S11Ce2a71hPoCfpbR0vyUmvSJCvV_-5DZJHBArHxqmpiPZTyhjw0SMN7jTaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeileduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfeelsegsrghrrhhoihhtrdhshhdprhgtphhtthhope
    grphhlrghtthhnvghrsehnvhhiughirgdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:LsGyafmpCpPyUc0OZIQkkky5rEqEOEiW8D5XmECNcHh9ry2ZjIf0TA>
    <xmx:LsGyacRKDX3XbSN3f4mvEKNRiM_4Ub0mhTHhWgM9FlqBUg46F-BhSA>
    <xmx:LsGyaVM7G2N5qQanRrY00Pqc806LWdiPhH5GeGSl2EAZNhjuEIix_g>
    <xmx:LsGyadXnU9x4tXnzAZFlkFBltEqY4AY0WJU0Fe0Qy3zXgh1NA2-TKg>
    <xmx:LsGyaa43JyI5Fb9V4h04b9VWFciyznwVKHq1wKTxhHDd96yWdD-0_9sQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 09:35:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jiamu Sun <39@barroit.sh>
Cc: Aaron Plattner <aplattner@nvidia.com>,  git@vger.kernel.org
Subject: Re: [PATCH 5/5] help: add tests for subcommand autocorrection
In-Reply-To: <SY0P300MB0801600E6ACF38D7BC715D66CE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	(Jiamu Sun's message of "Thu, 12 Mar 2026 07:45:18 +0900")
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB08015B9BA815B2C4F6CDC639CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<7caf4a0f-f11c-4a4f-864a-933142311a68@nvidia.com>
	<SY0P300MB0801600E6ACF38D7BC715D66CE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Date: Thu, 12 Mar 2026 06:35:40 -0700
Message-ID: <xmqqy0jxi30z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiamu Sun <39@barroit.sh> writes:

> On Wed, Mar 11, 2026 at 10:01:55AM -0700, Aaron Plattner wrote:
>> t/meson.build:1193:6: ERROR: Problem encountered: Test files found, but not
>> configured:
>> 
>>  - t9004-autocorrect-subcommand.sh
>> 
>> 
>> I think you just need to add it to meson.build:
>
> Will add it, thanks!

In the meantime, I have the following as a fixup patch on top of the
series.  The 'seen' branch with the topic still seems to be failing
with meson build in my environment, but I didn't have time to dig
further.

diff --git a/meson.build b/meson.build
index 4b536e0124..0429e80a5c 100644
--- a/meson.build
+++ b/meson.build
@@ -283,6 +283,7 @@ libgit_sources = [
   'archive-zip.c',
   'archive.c',
   'attr.c',
+  'autocorrect.c',
   'base85.c',
   'bisect.c',
   'blame.c',
diff --git a/t/meson.build b/t/meson.build
index f66a73f8a0..bf0503d705 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -973,6 +973,7 @@ integration_tests = [
   't9001-send-email.sh',
   't9002-column.sh',
   't9003-help-autocorrect.sh',
+  't9004-autocorrect-subcommand.sh',
   't9100-git-svn-basic.sh',
   't9101-git-svn-props.sh',
   't9102-git-svn-deep-rmdir.sh',
