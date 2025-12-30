Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E24831813A
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767107044; cv=none; b=QS96M+kpTPDqzKAfh9aYE3CcTzgQqb/+7tD299m95CPjTo2Dj1bFwHQWhbWf33DeOk1QGCbErXBoM9sVZQU6lNtuGQToK8C3Irz1VEQjE0ZsOuy+EzHBVefdNXts05UeGHKitiwz8lx1BFLx8YTpqxt+o2nTkPO3nPuKCIjWfgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767107044; c=relaxed/simple;
	bh=Aul3bpEcVlbdjodaowNiwKXQAoWhMidzOXvA8PuHkZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKcuGo0vKnPFMXFps8VVSK6TlIq+6+snKyxUSfZhp/td/l6jg4JrtxN/g40cNhL6mAeU9aWm3DOxVhYMF49isLXXMEytNU/ohnw9Sk8Iuznh2bY0f1MvXoNliKi5O/6Qpoz9Tb6Yx/K3rKEjgVWEUlpRy6enllMCfDiv5EFGhAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dcQ3ewuy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tuomoc0o; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dcQ3ewuy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tuomoc0o"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 9064D1D00019;
	Tue, 30 Dec 2025 10:04:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 30 Dec 2025 10:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767107041;
	 x=1767193441; bh=C/I/o6W+rPURarGGl9u6CKqJ3fNWUybwBjN0NW+jes4=; b=
	dcQ3ewuywuH20L3z7MMLD4BqnvkUAYrNFhU+RsuZ0suilwSKvJKW6Gw1HOHSoDlp
	9jbsvnwxw58oEs8sT1JIolAAxcrkJ+XPVl5bfcXADJFpWjS1d8UF/gqsUCCFB2O1
	faV6DLcFzjYlRampAQyviZd3bQI1StKAKZ/fjJEFOoYy92guwlV+00+vsVn1RLAy
	r9MGuz4b6vGovNVpdQogzXyJA5nQwyAYsECOG8J8AbttIzaTzYc/s98M5o8b2jXG
	ico730hGYC6Lmg/pUdMp2BB5/El3Lg4PZGSWPcow3U/jTiAAD6jpiZfigy9cdb/Q
	atiDygBGfHKc0t5v5WPtRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767107041; x=
	1767193441; bh=C/I/o6W+rPURarGGl9u6CKqJ3fNWUybwBjN0NW+jes4=; b=T
	uomoc0oqA6A03HOkXtk6fgaAHJcE0Ygy2b+fJCabmeFkVrfb7+73U6OLT+0rrnpM
	Q90MsdoXUiXzSrKpKNNf8hNVpyb6jGM6EqHMeSn9TQLaN6IdDvXe4n2B+gy14A/m
	hovi13/bDhoiglirGk7OIHK09/oJjPRltidjdh7up6SO2w35CGT891h0IP9UdE7U
	dZxB444YeVhrJw/5d8z+JpXUAuzeeNqJWG9mS4gnouLXEGhcs1Uan0fhaG97+GK7
	8mHSPKbweOAPOzuPmmkd59i6cChq9afOWRHgKGDnS222Xlw29DZ109lDqwDjkRoC
	d6K7MFkTudQWbc8qIo+zQ==
X-ME-Sender: <xms:4elTaXxcgdQu-jJQ3iEhUSmDOGQDAdD0vhrNc4umMHeTvD0MFPExZO4>
    <xme:4elTaf82Kw0P83yjQRhDVo79QjMj1z6rfc60dPZ-401BUZyvwqRLoHsjRLGi3SL6n
    RrREWlqEXGzKL9OINU-mGL-y8HrDAjM0ZzXl5-544jSkSwVGZeoCg>
X-ME-Received: <xmr:4elTafhYmIuRRLILe4k6Xd06h1yX3GHPf48CJCXX1fkkKSPsQ_rwz7nc-4aCAreEmhu7WrK0iAaMojp8OGWdeASJVW03lzv9t7ccsNLmCmWxA0jk5rpMHwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektdeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculddvfedmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpedulefgueeiueetkeelieefgedufeehteekhfej
    ffekvdeuhedtvefhkeeikefhgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtth
    hopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiug
    guhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4elTaWERurY-59dv8bF6mJO6KIXZij5yh9MQ-laeXv699JFB4XHGYA>
    <xmx:4elTae_nHJAJ-FOFvGZhP8OvG7gJgNxH24bKtpZvcD8prsKkhLZuEg>
    <xmx:4elTadx1bPX42_og9TWMYf-exgmD1SrCqyDmYeziAprkZdrh1eQViA>
    <xmx:4elTaaOUbvMD5DwswECWcDFYfvlV4p1pljdoT2lnCC_4TUkwYkD3jQ>
    <xmx:4elTaQPB6NqlWV5o7jpG0zpqdidpFXW4UBxhjWDkTQMIE9j3f3lHjICf>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 10:03:59 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/5] replay: die if we cannot parse object
Date: Tue, 30 Dec 2025 16:01:50 +0100
Message-ID: <V2_die_cannot_parse_obj.17f@msgid.xyz>
X-Mailer: git-send-email 2.52.0.10.g08704017180
In-Reply-To: <V2_CV_replay_die_descr.17b@msgid.xyz>
References: <CV_replay_die_descr.13f@msgid.xyz> <V2_CV_replay_die_descr.17b@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

`parse_object` can return `NULL`. That will in turn make
`repo_peel_to_type` return the same.

Let’s die fast and descriptively with the `*_or_die` variant.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: [new]
    
    See: https://lore.kernel.org/git/xmqqikdxriw3.fsf@gitster.g/
    
    With the `*_or_die` function we don’t have to check it at the call site.

 builtin/replay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 07a6767ade1..ca5a14de4c7 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -34,11 +34,11 @@ static struct commit *peel_committish(struct repository *repo,
 	struct object *obj;
 	struct object_id oid;
 
 	if (repo_get_oid(repo, name, &oid))
 		die(_("'%s' is not a valid commit-ish for %s"), name, mode);
-	obj = parse_object(repo, &oid);
+	obj = parse_object_or_die(repo, &oid, name);
 	return (struct commit *)repo_peel_to_type(repo, name, 0, obj,
 						  OBJ_COMMIT);
 }
 
 static char *get_author(const char *message)
-- 
2.52.0.10.g08704017180

