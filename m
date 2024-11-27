Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09971FAC29
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732713831; cv=none; b=P6JAQGj4sXLaMuNHvOzcCLKfcRRkmy6XtCYub7GcIa4GTvL9BMthPsMZeMuNiCis1Wlt8RWpahKLx3xaNkZCpfREir3Iw0+zErvplZjcAte/fXQjYMIfuE4+COIGdoEh/2s38ko9wyne20TB+FsuxyLOmjUPhaKD8qdd10rWEpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732713831; c=relaxed/simple;
	bh=kTnvyA37Obb/YRr0aS0Rkhx2JqyjUHfs1WjUH4ZnlO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IZe2jcRoqno2FmkIxMh4pxop6awC7tQNF4D7mtbXKetNamlD8Rkn+4FjSc6+Kjp2WfQYLhOR9uxxaK+O3NWM9hwihDKqSav+DBS0iAwQlMC/GL64j+Mv1vKhoUv/7vAV0ul3wEygfYW54pN00sw0laUV4MLXzDZt25q46l+e2sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rfKl/5rA; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rfKl/5rA"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B53EF114019C;
	Wed, 27 Nov 2024 08:23:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 27 Nov 2024 08:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732713827; x=1732800227; bh=mIgM20zQTwj0JY2CH4E4tmRcXn2oBIiEiZF
	5qZQnlOM=; b=rfKl/5rABEgnoMrnW1lwwjjjk7VVa8wS9B354gfUDauAD+ZNoqp
	hA5iIDjabdlMSF5kELHCWBZNj+Z8Hd6ohaZ1UeJi+ZTxlAOrabufWabOl4GNRvp8
	VLlY7t/oql3umVu6dixgqYDB84eagBsHjJ7hoYvlJgDVpkJQ7Lg+FxpGpXoy7b94
	4q+QotW4Vq5Q+rBYSQZ0KbKFRfMpBOpirN3mHwqxOXhqOoH9o/Twl3u3CrBhsKGQ
	KpDntosBRAbxz5NibSgGKgR2mXu4uMk4XIOelLg1PxTbpBrbEhMz1/VN41mNMkMb
	Ky+TGat5jMaHOt19sCzQ5vDlciS99n0XqXA==
X-ME-Sender: <xms:Yx1HZ0fao-TKt4dgX3t1ysoak3BzNjGtnN-QIR79LID2O7lX58McOg>
    <xme:Yx1HZ2PWSaP4JjjABFcV1cTDEos1An5Vg4EEBCliwc8zbb3KFy82gGNA7uI5yDY-k
    fgY2pGWJ4tha7oJgQ>
X-ME-Received: <xmr:Yx1HZ1iSsVHr-kj1HV3NcHJwjwX1u9iI3lvQ6YgxMvc8p5qyw0pd8g-wGq2L81lQLGm1txLOOmG9LTDzOwCCw8KyJV6K5GXYtxmI6xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeelgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhi
    thhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggt
    ohdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Yx1HZ5_LGdDINqI-r7C6plAIPas3vvLggbDqMg4pMe85cHkEi4SLcw>
    <xmx:Yx1HZwtRxJzEefLOVCSOF-tRw5v1WV2y9SKSAHeq6VL2bfD7u7lKKw>
    <xmx:Yx1HZwEAceFTNIljYTVVgDPJUh4gJq5dmlbqU-EbzxCxHkjRMTRnkw>
    <xmx:Yx1HZ_N3p9TOmpdh2AQm3NU5vW32mQZpbKMqg8VznaGNgvfIOhVrZw>
    <xmx:Yx1HZ0hf6IiYOJk_c4Uf6XwUA7yyZtEJUbH8belvQII2gJ9VTWiJdjgx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 08:23:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Eric
 Sunshine" <sunshine@sunshineco.com>,  "Elijah Newren" <newren@gmail.com>
Subject: Re* [PATCH v2] fast-import: disallow "." and ".." path components
In-Reply-To: <79f6027b-123c-40a6-975b-1c6053b9391c@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 27 Nov 2024 09:28:03 +0100")
References: <pull.1831.git.1732557520428.gitgitgadget@gmail.com>
	<pull.1831.v2.git.1732561248717.gitgitgadget@gmail.com>
	<79f6027b-123c-40a6-975b-1c6053b9391c@app.fastmail.com>
Date: Wed, 27 Nov 2024 22:23:45 +0900
Message-ID: <xmqq1pywvmhq.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>> +	if (is_dot_or_dotdot(e->name->str_dat))
>> +		die("path %s contains invalid component", p);
>
> Nit: single-quoting the path seems more common:
>
>     $ git grep "\"path '%s'" ':!po/' | wc -l
>     17
>     $ git grep "\"path %s" ':!po/' | wc -l
>     4

Ah, I missed that one.  Thanks for catching.

We probably should write it down.

--- >8 ---
[PATCH] CodingGuidelines: a handful of error message guidelines

It is more efficient to have something in the coding guidelines
document to point at, when we want to review and comment on a new
message in the codebase to make sure it "fits" in the set of
existing messages.

Let's write down established best practice we are aware of.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I am writing what I think is the established practice from
   memory; clarifications, corrections, and additions are all
   welcome.

 Documentation/CodingGuidelines | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
index 87904791cb..0444391983 100644
--- c/Documentation/CodingGuidelines
+++ w/Documentation/CodingGuidelines
@@ -703,16 +703,22 @@ Program Output
 
 Error Messages
 
- - Do not end error messages with a full stop.
+ - Do not end a single-sentence error message with a full stop.
 
  - Do not capitalize the first word, only because it is the first word
-   in the message ("unable to open %s", not "Unable to open %s").  But
+   in the message ("unable to open '%s'", not "Unable to open '%s'").  But
    "SHA-3 not supported" is fine, because the reason the first word is
    capitalized is not because it is at the beginning of the sentence,
    but because the word would be spelled in capital letters even when
    it appeared in the middle of the sentence.
 
- - Say what the error is first ("cannot open %s", not "%s: cannot open")
+ - Say what the error is first ("cannot open '%s'", not "%s: cannot open").
+
+ - Enclose the subject of an error inside a pair of single quotes,
+   e.g. `die(_("unable to open '%s'"), path)`.
+
+ - Unless there is a compelling reason not to, error messages should
+   be marked for `_("translation")`.
 
 
 Externally Visible Names
