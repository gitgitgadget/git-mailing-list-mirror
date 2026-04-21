Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7823384249
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756890; cv=none; b=ZJYmYcmLaAO4+tAttvMacRsHu6KM+wNMCv2gGNsOdNmaqUfHZtuFAo9vxwfz/jeoCMH+zHhGbdFeA/8FY5embFi6jZKsbvBITuGpVah0xfejk82ZEUjSQyTUJ1TcuhB1mYPFhbjlnkG38Ue9byunJhCvWHqpRwVUQxeL75+VRu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756890; c=relaxed/simple;
	bh=UlDXaUfzx6IMdRP5F2AvtckzgtdXui5Yv7Xcyeqswt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BHn2WjgPm6n/4zGs3MuM0IKCfI7VCo+1c1yWju5nN0X4BU8jWckrt3wfV7O+hVRr85Yl4OhX3TLL9hzRx3NERR7qZ7xSiVZKguTYB5CG48IvFTTbXlFMKjYJxnbUzvUQOm/giRBAL93tuDQ2zPjOxqJQo4LLYuDWJMSaLEtARd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qFeBDZTz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AIWhNZNb; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qFeBDZTz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AIWhNZNb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DE66E140006E;
	Tue, 21 Apr 2026 03:34:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 21 Apr 2026 03:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776756887;
	 x=1776843287; bh=EHFJH7VQh+QkUYO7zUibFLHUh7WJT4Z/qYk1frvlGjM=; b=
	qFeBDZTzzIRZJfdPAR2juP4lauHP0HXifC6PiMYcdipWVSp/vuLKjqk/lcMZcVZI
	swSOFPRnsBFUmH8zYPVy2OzQXrFA3NvakhMtCT3Icwi1m1GfPL7faX6zKut1rDGI
	VsD/y/fOq/J9fuROnWU5/HxDM0LqUNylMh2Imv08TRFGjsXuDuXbEEi4svWs5QRU
	3WMgJw64e2h2O7gpyRAZ7x5eyvdIDuIUcLRf+TqN5NdeoFiy8VGTbTt86jYuFjdo
	6rUYnmPvVKIi22sqbvMuB+3gsiQ/yvx9KrhzXfaHvAJa4n1jVM5WSDUrNYl/3+wQ
	EyD5igWHhb73L3vqyZKjWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776756887; x=
	1776843287; bh=EHFJH7VQh+QkUYO7zUibFLHUh7WJT4Z/qYk1frvlGjM=; b=A
	IWhNZNb/LIDzIVC7vqVj9QgM1k4hkvDFJDr77ZIrn/h02RQLly8DyKy2ZnZSeP5v
	7clXI5ytcwmttdWELkg4lsoie/TWB0Kq5qrtF6A9iL47IeHqZCGq+OqsP24snxSi
	Hdom6lynndQS1FBNydsY0MmqR0Pn/AOvQHWBHbsIQn/gx+NF5EDXGgF24v2u+j/c
	o6z3v34g145HfA3DBjKiE7YYLD9WpNWD5HykY3WMI3ITUQVC74bSr5rPLN+Ghh8t
	Yv9XckgDE48bhWO/5k6fyjun6DQfTKVKmKLNTzY/u02XXrJdqQyE/CKAFpDG5DwL
	PCVrzBy+rf2L4CuWa2sqw==
X-ME-Sender: <xms:lyjnacSzREKJUsORNLtMIWRNBtP4Nzi3AHoytot70vZJeOrYtaJp1w>
    <xme:lyjnaQxjoQRxO3ut964TwVkueKGLiJZbOGFlVQ3HQcjnoGrwNOzHeq4Ja5nzhRrC9
    nJthU9Xy86rGndWbBIM6LcLuvUfpsUehU07B8eiipJGNau_Yb4tJA>
X-ME-Received: <xmr:lyjnae0BrhzFlF4wg8eTlb8BoikiT7Vvd8_jYso_Jn9FAFFN1aCnuYUbbvgvOM0QTMiS4aUH2nxreRWgphDn_yQ1cNXNhdSvVvuj5XGeJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeitdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgf
    dtudffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsiigvug
    gvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:lyjnae7NbbHHcwtl6vgvLPekzb-f1KXii5fQ0j9zRCwRYQE9ZKviRw>
    <xmx:lyjnaRW4bRv0klTY1GIFSupCvwvgBaLTewKdH6qSTgOdQ9YXON0M-A>
    <xmx:lyjnadCMDHkitxGi8mvrBqfxNWFtn1HY-kQB7YBeJKNB4vOeKrGGgw>
    <xmx:lyjnaQ7ohYg4UiFTg7Xzheq_olrt1CU4IovAP7A6weHJxbd8XNvPpQ>
    <xmx:lyjnaQxsw2-tpu4JjyMcKXPqF1ajvs9O3xL1qWIi36ow2jaNxzznvPYi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 03:34:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 29019fa6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Apr 2026 07:34:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Apr 2026 09:34:24 +0200
Subject: [PATCH v6 11/12] t9902: fix use of `read` with `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260421-b4-pks-tests-with-set-e-v6-11-26330e3061ab@pks.im>
References: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
In-Reply-To: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

In t9902 we're using the `read` builtin to read some values into a
variable. This is done by using `-d ""`, which cause us to read until
the end of the heredoc. As the read is terminated by EOF, the command
will end up returning a non-zero error code. This hasn't been an issue
until now as we didn't run with `set -e`, but that'll change in a
subsequent commit.

Prepare for this change by not using read at all, as we can simply store
the multi-line value directly.

Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t9902-completion.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2f9a597ec7..28f61f08fb 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -590,12 +590,10 @@ test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
 	__gitcomp "$invalid_variable_name"
 '
 
-read -r -d "" refs <<-\EOF
-main
+refs='main
 maint
 next
-seen
-EOF
+seen'
 
 test_expect_success '__gitcomp_nl - trailing space' '
 	test_gitcomp_nl "m" "$refs" <<-EOF

-- 
2.54.0.545.g6539524ca2.dirty

