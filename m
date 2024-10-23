Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B221CF7C5
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695905; cv=none; b=X2DXx1vCyl8ubMdha6/uiukdZ3HDMLqy6oUu/cVizIQAcLA5hSQMpJmb7RSyq2yT2ETlSt/C7EH79xZt7YpIdFePgwv9XVtW26ecWryvLJbKqb0q0mV1a6bivMo4ZcGH50RVLuy7DDsUyjGY+iV+pgC3DHWYmhsMEa470aZqTuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695905; c=relaxed/simple;
	bh=OBQF5/Zw0l8vl1W4cnKKiqkh211pA8HSqNYAiZaMXKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mqe+gDNz4nHtvBCg6hSk97ZRCGr1Cm0sjICoIU+jvGg+2B07JyRbEWL1/9d2ixTc7Ukuwb9RUAiTVuRomXZPpd5RfRu7SnNDaYBjaheWuxaF+nypYhYKJiA8xeB8fDeC4Z+JVeZRGM5vVaWNJqWhYs5idEW/3fkZZq0afJwu0MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uyk4yjXp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gYU052H8; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uyk4yjXp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gYU052H8"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 581901380044;
	Wed, 23 Oct 2024 11:05:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 23 Oct 2024 11:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729695902; x=1729782302; bh=os1gUgfcZ/
	a8+G9DEKspZUPsoUvpq5IJQuB0oEakLXs=; b=uyk4yjXp1oISFPjYiWklRxG/eO
	1aYYQByNmBqE87E4k5Qg2PNSk7jG1qJeD+VHgVCoLNKnQ6HFSHDwdDtzoPdRENlB
	9bORiVZc7puODaZ+DAfPuIGUDaXKgFUC0R/C9aRgDNMqAZvyWxKQnuJo3+Qkg8tw
	uHmc+Ps4wIAquU3icXnp/ss2d4l/1NiJLBWYS3BeQ4nhLL+lk0+nvq57I85YgpU2
	5bXyfno9rbOv81br9JQZ6D7UWxB6rAl6ofm4e8A6fEK7kQGX8Bf+r9LnLo1IgvR2
	UKpsZnlOerHnWMSBn1Vr6j8b1fMOtg6dKw0gc7B6AXans8RXrdWmqO092Wcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729695902; x=1729782302; bh=os1gUgfcZ/a8+G9DEKspZUPsoUvp
	q5IJQuB0oEakLXs=; b=gYU052H89v30QuYZZ5GIBG2IDNgPbH10Jmu4RQmrsi+R
	fr7GavnfhHAFQ6VZwhOc7pQQwAlhSaHbdSY2xY3Vc6FQt1csonlf/LByFq9g8C+1
	WLWTpNDhvr30dkYRDrxxCOsnNRH30MnJJLaKrPh9Sm0n6cUaVze0sMnoNpSgw0Be
	eJ+yED79tHacS6fET9fPP8y8KeTLoq5f9bfzI0FgTxhJdBI2CNmrMhK00XpHS5l0
	/hnDSaY+v4K/CLdwQz900IOFgYYPuhO6F/DXvfU7zPtqKAm1pA3mjooLMBwmfit5
	7niBy5PftRg4SdBjR7h4wEq7OXGXENx6OSwGJrv/mQ==
X-ME-Sender: <xms:nhAZZ4yhttJXEupwGXlv-hFICupPobNipKKeIylxwXeBQBqzNaxAeA>
    <xme:nhAZZ8Ss7Gk6bBbzRk9UCS4ZhDtdR8wsK3MAH8RUn2Vi1Jw1bLp9xuvH0f5Ylj-3Y
    o-pXam-zsm-WjrHOA>
X-ME-Received: <xmr:nhAZZ6X_DfHPiOaYroyhJR8IXECjBt-Cq39hnamkS8aDRuT1g_9UPJbFr0YQxA-xqgAAgK7ExfvmQ-Ja30IvTTm5yNhpVX4Ht4q-htAuNnsb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nhAZZ2iDoz32ch5ZyqHXnCOOJbCL6p9BH01wieqNjU2FWHoLf1lzVA>
    <xmx:nhAZZ6An0raLAgET1u0XncAuYRdmFLcOayu_FUJLboBy26bUrw3X6g>
    <xmx:nhAZZ3I7e2-Qt9yc0l5F-vFsHAM6GMcIX8EYHxt6uJG54cQFzKzEEA>
    <xmx:nhAZZxBNlko2aYqiOc_2qOwPa-ocLgwM_wjQWFnl1fJvMjl6LVP4fg>
    <xmx:nhAZZ9OInu6Uuob_Khagi0Oyw0mdD-ZwFED19zSycqTkXiTs2-d-lxw0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 11:05:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 47b457d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 15:03:27 +0000 (UTC)
Date: Wed, 23 Oct 2024 17:04:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] compat/mingw: share file handles created via
 `CreateFileW()`
Message-ID: <907576d23d1dc39b679a323e74b6bfb227d6c17d.1729695349.git.ps@pks.im>
References: <cover.1729695349.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729695349.git.ps@pks.im>

Unless told otherwise, Windows will keep other processes from reading,
writing and deleting files when one has an open handle that was created
via `CreateFileW()`. This behaviour can be altered via `FILE_SHARE_*`
flags such that other processes _can_ read and/or modify such a file.
This sharing mechanism is quite important in the context of Git, as we
assume POSIX semantics all over the place.

There are two calls where we don't set up those flags though:

  - We don't set `FILE_SHARE_DELETE` when creating a file for appending
    via `mingw_open_append()`. This makes it impossible to delete the
    file from another process or to replace it via an atomic rename.

  - When opening a file such that we can change its access/modification
    times. This makes it impossible to perform any kind of operation
    on this file at all from another process. While we only open the
    file for a short amount of time to update its timestamps, this still
    opens us up for a race condition with another process.

Adapt both of these callsites to pass all three sharing flags.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/mingw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 0e851ecae29..e326c6fcd2d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -502,7 +502,7 @@ static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
 	 * to append to the file.
 	 */
 	handle = CreateFileW(wfilename, FILE_APPEND_DATA,
-			FILE_SHARE_WRITE | FILE_SHARE_READ,
+			FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE,
 			NULL, create, FILE_ATTRIBUTE_NORMAL, NULL);
 	if (handle == INVALID_HANDLE_VALUE) {
 		DWORD err = GetLastError();
@@ -1006,7 +1006,7 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
 
 	osfilehandle = CreateFileW(wfilename,
 				   FILE_WRITE_ATTRIBUTES,
-				   0 /*FileShare.None*/,
+				   FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
 				   NULL,
 				   OPEN_EXISTING,
 				   (attrs != INVALID_FILE_ATTRIBUTES &&
-- 
2.47.0.118.gfd3785337b.dirty

