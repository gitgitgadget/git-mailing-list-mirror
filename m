Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45AE269802
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941456; cv=none; b=Tg301rZwK5BIWb0GOeABC5LJO4vs+I8/SLwRA+jSc+XY3l9MZfxZIYPz/eYBF3xScADM4trzGzWDE8VFXG/7bKFiEOYm5UiP0bk9nfq+FGFjVX7oWeS/sZOcEOYAXI/UDBAcTgW+jxnA5WB1IVg3rC0n+U4L3xzHwVYd1L4f28k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941456; c=relaxed/simple;
	bh=WHnI0tzttqqmXtt39Itqmg0al6DJyWIJcDadMnZSdww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ois7eA51zyf4ob6wktnOHw8p528Dt9S/J0Hc1qFGOewYSX0G7yliCFqJwHDFSHcU0UFGIL6qDirJr5Hh/PKfbAbpHoAceObfHwDdP+cu0ulwfayUCDA/N6ozVgm6VaCaDpPikTK0O6ztEcecvkqWKCmXxF092MHUcoNqRd1tA8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu; spf=pass smtp.mailfrom=u92.eu; dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b=dsmJcutT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s8hXhnXN; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u92.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b="dsmJcutT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s8hXhnXN"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BF61A1140258;
	Tue, 25 Mar 2025 18:24:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 25 Mar 2025 18:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1742941453; x=
	1743027853; bh=en+gJcnINxAf68r9nuTZk4NhCDwieaOsZJuu+NBdulU=; b=d
	smJcutTLyVE80pT3zxUNkslrsADBd1PfCpGrbdiskpojVQamN37OiVfBkeFrg1ms
	LN04S5a4RRwqmwVoBLtpleOCHo+8vmav7QmVlVm2f4/kw8K7ztCXfEUA3WTul1o6
	j1K+1byHOhRzybrfTHdmN7OXtbsrmg//wADkqWwSHFawNrFDOTY+1mHlAF8NGTD3
	j4e5pAXAbu4Nl37NyyafvEqJt6p9maTKoJE2lg0KXKfrG+pQmY0q4fDZMA3F1lv5
	YmiQJuJYWA7ARX2IVFe0O6LMRKKfFWpct4yecLXPzBBPQ3hP/XUT2KfnyVl4vwzZ
	o0mNrm55NTa6ZmEkvpMeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1742941453; x=1743027853; bh=e
	n+gJcnINxAf68r9nuTZk4NhCDwieaOsZJuu+NBdulU=; b=s8hXhnXNlepXljD7h
	LYgvbX2ezrOTqSVWH0P5tT73utWbDRHTUHVwbZZa+xvly3uFa9Gu346T8rDn7cW8
	PRYxSl5ElomBE1EHifMx8dd4piImoWyavvOUX/MVW3ITLCo87Hp5B42VZdPly+wv
	zUgMljf/cZNgOCuJ/lKd809PHUgEHpuQQovNV7wFQWWdKBQEp6eMyrX8G97XIkpB
	QBUhRRZM9kHk4nusk/NjJvuQqOGtiizTrv344681vQd49Nbp/7vF7sU9SLfN8sRO
	qW/Lt8+wQSC3Ek/9Jfdv0+htYbygJe1tlWxvc9VfsgLdXtPxXemgoF4M4sDMHMDJ
	mPmDw==
X-ME-Sender: <xms:DS3jZ7Zch0DdN6Ao_vU2sgaXz7D9lJHAPWs2kwzJTEwwBRA_Mt4_sg>
    <xme:DS3jZ6YZrKrAu9vqLffQ-nzZYsnpnswwA84IJobTnqv62INEcrxd15r6Cz3GzjPiq
    MXEfsRglVNhjs1JWw>
X-ME-Received: <xmr:DS3jZ99nutpyVewfAS2Kzr8g_xkG9hsPjR_WOF60bSMRcacH0_rOrUz3dzFNi07rv6vtZnRuNB-->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieefkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefhvghrnhgrnhguohcutfgr
    mhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrghtthgvrhhnpeeiue
    dvgefgvdetteekveettdfghedutedtledvgedvffefgfffvefgueejheevueenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvvghnfhhooh
    esuhelvddrvghupdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvodhgihhthhhusgesghhmrghilhdrtghomhdprhgtphhtthhopehgrhgv
    vghnfhhoohesuhelvddrvghupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehkrgifrghrihhmihguohhllhdoghhithesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:DS3jZxoAKANfjMrgfcYTl01Z7JtDJMeX82B-0LB-YTvJ05rUGEIqHA>
    <xmx:DS3jZ2orWyiiN9q_4oSLAOuk-VH3ZjP0wPA1QrwZ87QrmzrGJ31piA>
    <xmx:DS3jZ3RUcYpOWMjcR0hRLzT9HjitO7Gj0w3J1OoxTbmWxcDxvCSQ1A>
    <xmx:DS3jZ-q-rqnhMDYITQGXa9syaks7iyeghlVXCRfKlm9hXH05ofJdHw>
    <xmx:DS3jZzCWBMq61ndG9EddlZQZxzEqV61TCbDuWlgyloB6QtQFPtQKeqpS>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 18:24:11 -0400 (EDT)
From: Fernando Ramos <greenfoo@u92.eu>
To: git@vger.kernel.org
Cc: "D . Ben Knoble" <ben.knoble+github@gmail.com>,
	Fernando Ramos <greenfoo@u92.eu>,
	Junio C Hamano <gitster@pobox.com>,
	kawarimidoll <kawarimidoll+git@gmail.com>
Subject: [PATCH 1/2] mergetools: vimdiff: fix layout where REMOTE is the target
Date: Tue, 25 Mar 2025 23:23:10 +0100
Message-ID: <20250325222311.400748-2-greenfoo@u92.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325222311.400748-1-greenfoo@u92.eu>
References: <20250325222311.400748-1-greenfoo@u92.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"mergetool.vimdiff.layout" is used to define the vim layout (ie. how
windows, tabs and buffers are physically organized) when resolving
conflicts.

For example, if we set it to this:

    "(LOCAL,BASE,REMOTE)/MERGED"

...vim will open and show this layout:

    ------------------------------------------
    |             |           |              |
    |   LOCAL     |   BASE    |   REMOTE     |
    |             |           |              |
    ------------------------------------------
    |                                        |
    |                MERGED                  |
    |                                        |
    ------------------------------------------

By default, whatever ends up been written to the "MERGED" window will
become the file which conflict we are resolving.

However, it is possible to use the "@" symbol to specify a different
one.  For example, if we use this slightly different version of the
previously used string:

    "(LOCAL,BASE,@REMOTE)/MERGED"

...then the user should proceed to edit the contents of the top right
window (instead of the bottom window) as *that* is what will become the
conflicts free file once vim is closed.

Before this commit, the "@" marker worked for all targets *except* for
"REMOTE". In other words, these worked as expected:

    "(@LOCAL,BASE,REMOTE)/MERGED"
    "(LOCAL,@BASE,REMOTE)/MERGED"
    "(LOCAL,BASE,REMOTE)/@MERGED"

...but this didn't:

    "(LOCAL,BASE,@REMOTE)/MERGED"

This commit fixes that.

Reported-by: kawarimidoll <kawarimidoll+git@gmail.com>
Suggested-by: D. Ben Knoble <ben.knoble@gmail.com>
Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
---
 mergetools/vimdiff | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index ffc9be86c8..0e3785d230 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -305,6 +305,9 @@ gen_cmd () {
 	elif echo "$LAYOUT" | grep @BASE >/dev/null
 	then
 		FINAL_TARGET="BASE"
+	elif echo "$LAYOUT" | grep @REMOTE >/dev/null
+	then
+		FINAL_TARGET="REMOTE"
 	else
 		FINAL_TARGET="MERGED"
 	fi
-- 
2.49.0

