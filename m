Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98522500D6
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 04:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733287615; cv=none; b=uxIerhsM3RCbrngVhJ5h8OdknEd0BsqpS0gC07TZeaS2JYaAp240yESe2JFZFtiPd1hbLjw/CkCE7Ye245jbPNHDZhMluFLgR7rcabjFaYd667d0fIVQsNRDKuHhhFM/L6tuheIGRu6v/bnD9CBUUzDGl68E0WCul6PwOvcHbKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733287615; c=relaxed/simple;
	bh=NUmua8ORmsEIUAb6xAMjdsLvwl1P0MYAH53IhyQTVKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R+IyjKuTPHo02sCd6ial0gIGdi46tcsbd34egZrT3zebTONB45pGMwuO2qhBKDBoSyn5yKZu823fNcTc+SkncsFz/lV2W7Kuar+UvtrL8UZh7ikJqKGW4KFSfN+HJT6a+J45k2wP4nb/TNDlhQ6Iaj1s2fGMoS+i0Gda2c2I/U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UXzcFbQ9; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UXzcFbQ9"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EF717114020A;
	Tue,  3 Dec 2024 23:46:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 03 Dec 2024 23:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733287611; x=1733374011; bh=WvqBrAaxEovw1SnkAjYqOqNmr3/3NpscuYy
	T62JsszU=; b=UXzcFbQ9N2QUb7pZRcnwuJhKWWbMZTSwsGrgtc2aXOxJZWsytrx
	UW9yqfZ0r17cg/7xKidU6goEAScCg57NoZJXhUYfXuNLW36+u7r5+l0pa+q1SREJ
	7/L5KEyabfmUXq/oye77cyD4rt/9FulpD+YPbLIkA1HkWc7ePx0qFQ10Nkysr7rk
	ceQqhUDGbCp6DScs0/RLEGvCwwrlp6ExkChapFC8c4PPfapKvHId2Jp8gWuOw2XH
	mHD/FbIeYO2BBCeL1zGicIz5gql6MWKy8cJRxDy6zUnIIVS0g9Xu3BMDOcv00z7R
	1Rl5C5Ot63HvsAWqS4Y0YLgbuOqmZsVVrYQ==
X-ME-Sender: <xms:u95PZ1kCo-kNQHtCybV3V-WlHhPsXJJQIZdyMNBJIgiisbTuA3IQDQ>
    <xme:u95PZw0Sho5IQgeyocwdAeVrfMj-_xPZL1YoMYpH-snBlJFVUWZeP_FO9g0ubGn5q
    TyHUWXbWCnIRhRpHA>
X-ME-Received: <xmr:u95PZ7q1qQTMofKQlA7V8OqxLyL5kBe_OfFBIv1un55tiUkg32WnedLX8e4jg2m4jcnA-JUGi7a1Q-AKOG1aDOC9IaK4IUbuc7OSo9E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepffeite
    eujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgr
    ihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhnrghthhgrnhhtrg
    hnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:u95PZ1no4o3pKvyUcPYaJZlin5xWHTklkN-RyiQNe-JITGqNM605lQ>
    <xmx:u95PZz2orOJbP2El0v-bNFEffHYx3GTaGeT1xmE68fhwoUJQ2tHwNQ>
    <xmx:u95PZ0sMzSH9_o_3-30SP2mzYbBOHR6bR1VFDk0Xern7GF5myLHjyA>
    <xmx:u95PZ3UvG28Z53aN5r2IQfukkgkiMNzaDAhu16TbcWhjLYqF3fpdiw>
    <xmx:u95PZ-RX1RCJpUjQl7NhRuhhcl7Vktro1LTc7ORMqOZ7w49u7tG6IsAp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 23:46:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: [PATCH 4/3] index-pack: work around false positive use of
 uninitialized variable
In-Reply-To: <cover.1733262661.git.jonathantanmy@google.com> (Jonathan Tan's
	message of "Tue, 3 Dec 2024 13:52:53 -0800")
References: <cover.1733170252.git.jonathantanmy@google.com>
	<cover.1733262661.git.jonathantanmy@google.com>
Date: Wed, 04 Dec 2024 13:46:50 +0900
Message-ID: <xmqqr06o3vid.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The base_name variable in this function is given a value if cmd.args
array is not empty (i.e., if we run the pack-objects command), and
the function returns when cmd.args is empty before hitting a call to
free(base_name) near the end of the function, so to a human reader,
it can be seen that the variable is not used uninitialized, but to a
semi-intelligent compiler it is not so clear.

Squelch a false positive by a meaningless NULL initialization.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Tentatively queued to unblock CI.  There may be breakages due to
   other topics in flight, but at least this one is easy to resolve
   (hopefully---I haven't pushed it out).

   https://github.com/git/git/actions/runs/12152173257

 builtin/index-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1594f2b81d..8e600a58bf 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1803,7 +1803,7 @@ static void repack_local_links(void)
 	struct strbuf line = STRBUF_INIT;
 	struct oidset_iter iter;
 	struct object_id *oid;
-	char *base_name;
+	char *base_name = NULL;
 
 	if (!oidset_size(&outgoing_links))
 		return;
-- 
2.47.1-574-g3b2d6bb55a

