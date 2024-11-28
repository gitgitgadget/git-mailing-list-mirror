Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205BBBE4F
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 00:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732754210; cv=none; b=MtkXQfxSw1LdfzEYklin+k0GSbErp0SOXBZqac95SWYnCpTJVn8NeOQplPLvId8fIiC6ewZmaLFXbXTIMsyFk1MEHu7Nk86z//0Nblwsl5d0+gyrriC5KHr/nicRF/OUw4Tc4S/ijzTwNj5P+E2H+EOxypOofm6eZphSc6vzd/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732754210; c=relaxed/simple;
	bh=BHQNsCaTekW9SPU7bEatReyijOKDFZ7GfB2pzFKmghA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J4LFvliQ2ZjG6S6SlImCpZpIXT1nRUELeeLRt3iXhcOvE7MnxYToTMWpAVnPMArRZBSkLb5iTwABaEwvyByBOslqKj/Rmnqc72d94B70GB8GOCM26G1YPdW2vaRyNtGnPG/M1rvSBgVrz+AajVc/ZJoiRk8lwx8ef7Jk6Xec+zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iJVxpQZd; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iJVxpQZd"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 43B2625400CC;
	Wed, 27 Nov 2024 19:36:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 27 Nov 2024 19:36:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732754207; x=1732840607; bh=wLfPVgbUqpIHt911z9vVg+zbwb/kxKk4oHg
	rDF/+u2A=; b=iJVxpQZdVpkCCeAHtYG3q28pPG+Bxg+ERAe/DEz4e/bWj2lCjrK
	7mwW8XnuDianGM/SXSV+taNBuEJ3FEOO6Dm12PTHbKEybaugMFIsORiXtymw7MwD
	+A+w/iRQGh2pCe67rFrYdlea1F+xv6PMgTf1q61I7mvUIbt+LXh+hN/ccRNvZ1mS
	0ICV5BzXWxYM4c2UQkD8PeW2vmzbdSlYOYUS6888pKMf3TNWcRCm043GukMdzYkj
	FSWFkauFSwqCboFpJxlSiifQhcWEZTmUXRfpQ7Pj7ub7YETYicuV2ALuweqcUpWk
	eEwmr5ePfjoZQPq5NvB8ubz2qqrf/eoVdwg==
X-ME-Sender: <xms:HrtHZxco54aAMDqyTEI0yXWVx1g2Rh_OzBKahYIk381Ds5x494be4Q>
    <xme:HrtHZ_PXmk0njzGxQvAk6RCqUXA-6dyLJo5kYqib6NZvx4hi7i1kPUPbn2nlAhbkh
    cwtH4VsRLUBU9bWRw>
X-ME-Received: <xmr:HrtHZ6icVu69_ZFfDofLYW2LDyUbuVXLxDGGNoeR3DJBDsiAVa41k5-ekzgm8BW95BqD3m4BSED2qYH80nyRweaSyNi93NJUcraR05Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedtgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghk
    khesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnsh
    hhihhnvggtohdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HrtHZ68PY6vFWA47tjBdHfcdv79dL9PeFoiEGjek_Q8VHdopwdMcpA>
    <xmx:HrtHZ9ur3GwhmDe4I-gAzyZUYDtZIGvfJsj02LGf-s4ugCSAKy1DdQ>
    <xmx:HrtHZ5GKJnVDLkjuiZUBexI585ksI6WefmDo5LA_nimXr7g2nUMqcw>
    <xmx:HrtHZ0PXMHDATd52GktEuQKiqGy6Heb_5ep-OCuC_2DTjSVbLzfRTA>
    <xmx:H7tHZ7Whk_pKl-QsiEa41cNd2XZmPyRell_mH7h3LU0rffJc1nGplzv4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 19:36:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
    "Eric Sunshine" <sunshine@sunshineco.com>,
    "Elijah Newren" <newren@gmail.com>
Subject: [PATCH v2] CodingGuidelines: a handful of error message guidelines
In-Reply-To: <xmqq1pywvmhq.fsf_-_@gitster.g> (Junio C. Hamano's message of
	"Wed, 27 Nov 2024 22:23:45 +0900")
References: <pull.1831.git.1732557520428.gitgitgadget@gmail.com>
	<pull.1831.v2.git.1732561248717.gitgitgadget@gmail.com>
	<79f6027b-123c-40a6-975b-1c6053b9391c@app.fastmail.com>
	<xmqq1pywvmhq.fsf_-_@gitster.g>
Date: Thu, 28 Nov 2024 09:36:44 +0900
Message-ID: <xmqqa5dkqjmr.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taking input from comments by Eric (thanks) on the previous round,
this iteration adds a bit more about Porcelain/Plumbing and BUG().

  diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
  index 71e4742fd5..2b8f99f333 100644
  --- a/Documentation/CodingGuidelines
  +++ b/Documentation/CodingGuidelines
  @@ -703,8 +703,15 @@ Error Messages
    - Enclose the subject of an error inside a pair of single quotes,
      e.g. `die(_("unable to open '%s'"), path)`.
   
  - - Unless there is a compelling reason not to, error messages should
  -   be marked for `_("translation")`.
  + - Unless there is a compelling reason not to, error messages from the
  +   Porcelain command should be marked for `_("translation")`.
  +
  + - Error messages from the plumbing commands are sometimes meant for
  +   machine consumption and should not be marked for `_("translation")`
  +   to keep them 'grep'-able.
  +
  + - BUG("message") are for communicating the specific error to
  +   developers, and not to be translated.
   
   
   Externally Visible Names

--- >8 ---
It is more efficient to have something in the coding guidelines
document to point at, when we want to review and comment on a new
message in the codebase to make sure it "fits" in the set of
existing messages.

Let's write down established best practice we are aware of.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 3263245b03..2b8f99f333 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -689,16 +689,29 @@ Program Output
 
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
+ - Unless there is a compelling reason not to, error messages from the
+   Porcelain command should be marked for `_("translation")`.
+
+ - Error messages from the plumbing commands are sometimes meant for
+   machine consumption and should not be marked for `_("translation")`
+   to keep them 'grep'-able.
+
+ - BUG("message") are for communicating the specific error to
+   developers, and not to be translated.
 
 
 Externally Visible Names

-- 
2.47.1-499-g8536fed62d


