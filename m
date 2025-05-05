Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC8E1B6D06
	for <git@vger.kernel.org>; Mon,  5 May 2025 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435114; cv=none; b=qRWofgkI0h84Wn1hvAs9fiaiJcoRfWcZ5oylcWsHKv4wLbaO8pOLHuhSgjQ6v55jsRrC+YqA6lZPjb5hLib3cbunemkC5ii2SFescqKe1fx1IvFwcRztPYxywC0+XW/Fl6k6RwK3aYgPrGwHpAYjvyJDdGLvVNSk1w65fQ5pkNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435114; c=relaxed/simple;
	bh=X2rvscZuZT2bPJgO7qRmnypaMrpx0DzlonZ6YMU1bSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WVlouYQzoCxLDrUTGJtuODLrBl/Rbbbgz/RQ6wzbzZwgaEf22hMUUyN4gDiXbUQxRYEmoLp3LdGzXnFobmSCtzZ0U1Z3fmSc4KlSTLLRGhKlhaIfrEy+DzJjaFAYO1Sk05OrBlO7UK5rhpb9gqX8g/8/V9o54FcOWCiUZQQjqGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bOP6JhAQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G9IIVf2Q; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bOP6JhAQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G9IIVf2Q"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 63A3C2540251;
	Mon,  5 May 2025 04:51:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 05 May 2025 04:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746435111;
	 x=1746521511; bh=cslH9NHgn0WLIsCOYm2hK7lG+0QInTHK5uyrhycegMk=; b=
	bOP6JhAQtLjsug3s3jlTsiSxDGQLEn+sE5XO9bzWAx/5fOemC5/m/7uTHDGHTCxd
	67bC2/Zkq+oZ3wbuPUKlGnrXzYoaM8wdFuvH4561t55bLNWmkDdEpslLehQ9RExA
	nx1RFV10Rz6tOiHMfStMrw/Z4YAQwbAwkKaY072J/Hpaz/v/u18AqoWgWEekJWQR
	JcK5m3xkdP7GF1GW5Ss/7+mDLD9kArSXbwU1s9RMW3LH/SrJIcjou4AXVJv2wE7c
	U7ZAYlzEAhV2YtjMXAx+vY6kXGP9Je2kultyarjNr7E4wUDmps4zI9bNU7A6iGf3
	6GUg8oOr4/HSFUy2QgqsKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746435111; x=
	1746521511; bh=cslH9NHgn0WLIsCOYm2hK7lG+0QInTHK5uyrhycegMk=; b=G
	9IIVf2QlgOI9VysS2bBpu7P+CMzPa3MUPMTs7o77gilCXGoxTH5wgypZf0CFnhz1
	4LM1ROT2d9ttgs5emoacqHdqK2e1hd8Yh65T7chAxOcj2ekcYnT/3yZ1QuR4fJwi
	Ie3xcwgwTx9N5KxPVE7RKiTK9f90uOAHw1QP3a5eUpqIh/R+VPozeXUZoyEWCKOr
	zMfe10jcCHivEf8rKO1/+e7LtuuRdeC3enOCUx7AR0Y62zoX7FvuwVB7o8hrGhML
	ZpHWDEkQFvbcs1/sWFFtgq0X6dAn99WQ1YUBrMy6Q1Je9RvpjvtdPOixRo2tnXya
	OSDsqaNWwuIlo7yag42ug==
X-ME-Sender: <xms:J3wYaFi0xkqFTusD5Zy_A3t28aoNAbgaKv-2rNtDIyBFhaotw2hePA>
    <xme:J3wYaKD1tzUkJaSpiT3W_B8BSiM9h-GvJUG2quh-hmudyU0FxWh1u0wIBbeHP8qo9
    NUzrGNzC-v73rIowA>
X-ME-Received: <xmr:J3wYaFGt4UwLqUZpXO1kUM_9jtNPksCtnUviR5sPuofPVtXkibmuZDl4WsMbJ5dqR_agV2EOnElgIsJCOFzn90bB-Wffx0EoDvETbKIKPyg72Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    thholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:J3wYaKT9XMeAOkR4el-BIu2dfTC24BV2w2ASMejL1lIXWo0NFsBAmw>
    <xmx:J3wYaCwb7bXilG98McpwDH6Cm9ez_eERYaBnBTL7qhLq_zEUTqccqw>
    <xmx:J3wYaA621DEyeoGvDIiCSCfwziYAtxElxAjJW1qx-ZlD3KuZbllMyQ>
    <xmx:J3wYaHypp76ZPv-o_JJ1-TZBrW8dmemdHLEE62YJ3frEiAImm7NoyA>
    <xmx:J3wYaFupUlNOg6i6XXFtKqXNl9kUjAuhjXOTm04sMNrD4Q2wwAQAh0fD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 04:51:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 10bb1aaa (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 08:51:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 05 May 2025 10:51:41 +0200
Subject: [PATCH v4 1/7] builtin/gc: fix indentation of `cmd_gc()`
 parameters
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pks-maintenance-missing-tasks-v4-1-141f4df906a1@pks.im>
References: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
In-Reply-To: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The parameters of `cmd_gc()` aren't indented properly. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index d5c75be2522..a73ec22fb18 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -724,9 +724,9 @@ static void gc_before_repack(struct maintenance_run_opts *opts,
 }
 
 int cmd_gc(int argc,
-const char **argv,
-const char *prefix,
-struct repository *repo UNUSED)
+	   const char **argv,
+	   const char *prefix,
+	   struct repository *repo UNUSED)
 {
 	int aggressive = 0;
 	int quiet = 0;

-- 
2.49.0.987.g0cc8ee98dc.dirty

