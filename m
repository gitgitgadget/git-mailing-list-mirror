Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CB937BE8D
	for <git@vger.kernel.org>; Sun,  3 May 2026 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777835991; cv=none; b=DOp79lQeII5rYZbu7MCfObyrdtY/x6Us38wx2eLk7oL9vazNBeaAGr4LsfVo2qLqToVEUcptPatBn6MVzF9CQLjqXK2ISOMjWhoaFw/+pv19SQx1te2f7DG0tt9y+b92CanDGwgjPLDUtiFYVcyTwaqXPNoMqcCvnrILJSP8dA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777835991; c=relaxed/simple;
	bh=5lutB4cGCsl9B+O2YuSPdZEw9OWaPhT6WeaLk5U4o5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gkr506Km0hASBykcc8pqf6z2SRjD12rSBHG81sobiiZK4lK68LNDT3a7tRceig7EU4dztBNYt7m4QVYc1ip5of+21IpPDvRD90CRuBURe4lgMal+71+VbCDvtP7qd/jEda/Cfc84bhwBKcZBXMxbO2f7W8D1710DoN2YWnlvYlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wqWlc0Yd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HRr5TgaK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wqWlc0Yd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HRr5TgaK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 27105EC00A0;
	Sun,  3 May 2026 15:19:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 03 May 2026 15:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777835989; x=1777922389; bh=5S+NU9CNKH
	znb8jv0vYhcLYazNUn3bfiZ6Qx3NzHjPk=; b=wqWlc0YdbUF1Z7Kx3HB5M2Ro5J
	Vfl/k+Lg43lJ+0qydo4Vv2hPzCsf0UCbo9GmoyBcYVMFpas0Tyw990SfhTsafbEo
	P0v2kw0FwvINIAgLGGjy+dl6HPIQWcQ6NMEU2/WbOqSG/xZ8nXWCztyT/8doNPAD
	6CIMCzNSV2MgqNHJtdz6phKrEonJ9AvKv3nJmma+UEguEg/wWXnZsqAqN/lmgahi
	KBg8YI5n9VbelcrPRf5y/f6jk64OqLwvf3S1uaKUriOybPJD0my1RAe4thqrGrX0
	Qc5K2KR+O8vdiQpwyV9e6oUuGKsnUb+MGqeZ3Vm0oDESZ8OrU5jGJTtNbzmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777835989; x=1777922389; bh=5S+NU9CNKHznb8jv0vYhcLYazNUn3bfiZ6Q
	x3NzHjPk=; b=HRr5TgaKrr2Cy38KTHl74LO1K/Iznn5cuikrJFAhDP01bouVYvo
	5S4ARl/+wa6NbjnddA581TSi5mgxl2ho9UoYkar3wqdyRns+JnioxFKcGucS9sl9
	fi8RGKhyA5lu5vOP7zxwu23V27WdxcEoJQWFW1FCLyM2JXZ9NARXZt4njKQVphxG
	mEE3fLCdO9EE6UYD9n7WskQve/bbvnGK5d+qrYzDn8z+o0M21aKIB/q/ENvFqzqQ
	PoDqGetEsgZmjJyXQ5ec8gxw2pm1g77xSveVO5TU/UIWk5O7pDQkDHFxYYS7YxFN
	N7dDEQsBP8FZuoUJo9+4NLHdZca0qNyS9SQ==
X-ME-Sender: <xms:1Z_3ae8_nFo5XxUzhMLT-oAL_QbycctgCchVHZsOX8omdc9racmPLA>
    <xme:1Z_3aVnZeEOfkdxpglRMSa8XrwldTySJYr7XWT_IufkHSQ-hyU4V2wUKJtzQeYSs4
    py_a6-_pIcRIwUctO-L8DApYrIpct7-cFIrEnkLnkv83uKm1Ze7ELE>
X-ME-Received: <xmr:1Z_3acUT2XwByVxNtT5ej6oNNUDnlqyx5G8FRcDknKON8Rk3CaNLR9D6Xf2zm2tWDG1JDLpUuXyhgUrEJuWHm86wkRSUKoMEkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelieejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghu
    ghhssggrkhhkrdhnrghmvgdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1Z_3aSGTbcXgStXvS7jwH99pQI-88cTMA0XL6GTwrzUlo5GdF7xtYA>
    <xmx:1Z_3aQcIWfdOMgx57jCn0OTf4RrK5tFCj5Rl3M2R7pedCZyJ0kI0qQ>
    <xmx:1Z_3abIOj8rS-Rx_0o4sk-3caJPIX2AiAXfUSzYNWELrG7JHZKhsbQ>
    <xmx:1Z_3adF1bgQ4mcNe7ShKCLvQZYmbnVrjpEksstQunDWNHKHiAMm_4Q>
    <xmx:1Z_3aZXIVVC-jARq6rJt9gK5WxmddlNuzsFux8zjjjlFdRQ735YsVMQG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 May 2026 15:19:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  ben.knoble@gmail.com
Subject: Re: [PATCH v3 5/5] format-rev: introduce builtin for on-demand
 pretty formatting
In-Reply-To: <V3_format-rev_new_builtin.66f@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Wed, 29 Apr 2026
	00:25:56 +0200")
References: <V2_CV_name-rev_--format.51b@msgid.xyz>
	<V3_CV_format-rev.66a@msgid.xyz>
	<V3_format-rev_new_builtin.66f@msgid.xyz>
Date: Mon, 04 May 2026 04:19:47 +0900
Message-ID: <xmqqwlxks3l8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

builtin/name-rev.c:883:8: error: variable 'commit' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
  883 |                         if (peeled && peeled->type == OBJ_COMMIT)
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
builtin/name-rev.c:885:9: note: uninitialized use occurs here
  885 |                         if (!commit) {
      |                              ^~~~~~
builtin/name-rev.c:883:4: note: remove the 'if' if its condition is always true
  883 |                         if (peeled && peeled->type == OBJ_COMMIT)
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  884 |                                 commit = (struct commit *)peeled;
builtin/name-rev.c:883:8: error: variable 'commit' is used uninitialized whenever '&&' condition is false [-Werror,-Wsometimes-uninitialized]
  883 |                         if (peeled && peeled->type == OBJ_COMMIT)
      |                             ^~~~~~
builtin/name-rev.c:885:9: note: uninitialized use occurs here
  885 |                         if (!commit) {
      |                              ^~~~~~
builtin/name-rev.c:883:8: note: remove the '&&' if its condition is always true
  883 |                         if (peeled && peeled->type == OBJ_COMMIT)
      |                             ^~~~~~~~~
builtin/name-rev.c:867:25: note: initialize the variable 'commit' to silence this warning
  867 |                         struct commit *commit;
      |                                              ^
      |                                               = NULL
2 errors generated.
 
