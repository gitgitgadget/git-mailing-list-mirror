Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C122301
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622808; cv=none; b=GodjMHd7rOqBwBUAhVDEk7peWgd5BsupPbM15fW6ZY16vPkI7+hJGOuf3N8wdP5KVeS0SXrHjaoORdF0/uZpBBNcEw5Y1u8t1CwdLkWgobSsD60vvueqWnLNjefzSTDBgZRbPZYZp0y/btu1Q9fWA+1vkrDaoMlUzacGs+yFa7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622808; c=relaxed/simple;
	bh=9Sw6iNngieWrIv+kQ+8GT4xa6VhATMKPT5y6Hc8NDlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lanECHE9cMgLun5ZbXqP6YpdYAgY4JpVEXkzrE+AjayYdSBkBRV6kx994vZJyl3BnCB48Fls1a9BfzvwGqvVo2/kPebq/97c12R2Ue8ePkd5LgQDJ+/MqpAI2b0s5O2pJOBoMvjEyKLboICeB3gCvTJ8FChVWCdyRXXTWq2VNPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ghu1+V+D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uyYN+JJA; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ghu1+V+D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uyYN+JJA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 241657A0170;
	Fri, 27 Mar 2026 10:46:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 27 Mar 2026 10:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774622805; x=1774709205; bh=Rv1IimglBd
	p7QaeNN7z0e2mbAXbsRQfcJQO+OrzbGmc=; b=Ghu1+V+Dmp5EocNGoXgwZDyN9G
	BaKQujM6s1hYFSRAzuLs/knviPhzMQtAfeowEwyj/Bi1TuYnyWAcon7dNUM4G43p
	dbabDiddoT4XQYbyILm5F2YihYXW9AlDKIicOsQM2My5EJ3khTaBekpnjSyuSgPL
	bq5u/TfhSTnBWSJFnydQr7mED0RUeQZmcn4pYZUD0optIUdPcsrsue4mp4j/Ho0W
	+frG26BxKJP1UlqTb8XSuqfnkgB0R4TzNZUssRcxSt7bf/r+RmPHhojLmcIvuCkf
	pMH3jRn1CsriqWy1cXld8YeWyuvF92xz1VoaTfkWqJiitfBEHHygONQIRktw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774622805; x=1774709205; bh=Rv1IimglBdp7QaeNN7z0e2mbAXbsRQfcJQO
	+OrzbGmc=; b=uyYN+JJAZAeJeRpv5oGG9nbS8mUR3X5UQvBA7DYlp/+Q5uDtV0L
	l9FVeabC8swp35CKASn7PCaWAi83qSw/DLQ4z2xWXCzKJKveDUkyAu9sjSyTSiNQ
	ZCCFDi+Z95KpukH5oYtIHRSEmqsczouwfBOVx+/8tBpqqdNDbd/pqH4aH0zc8oul
	njxVfFDMY8jvtTEke3k4gu4Iwz5Tv/FYJdA00Bc8SsA9DNWh0yWjW3ULXdptDPjc
	w4UhVxGzZIpV+0gNWqjn/WgaWKpfdElFbCcBT9qLEXRV7aPupombH6ORYipVXaMI
	kFD98W/318ymVF+xdnVlSx1ZcT59USqUfhw==
X-ME-Sender: <xms:VZjGaYcXHj-UzWxUVD2UJYwka7jgyRQIk87wNyVP1jRDMlTfA3NgyQ>
    <xme:VZjGaZRJ0DmE_CJ5jlwIR-VX-rA4JzF-GjrKCWvUedRw2z-7zQ-5vq5vT7RlOm-B2
    RjtZm10fGSzhhHJdNHzoJqWXTc52PTKzPejfHrQAfY0Uls2F87MEA>
X-ME-Received: <xmr:VZjGafsJx39gGQP3RutnsulvF77f-LaHf5avzEw2UgUtvIdyn7sWeOPtR39kNWGY1KbmSynMXisJkavrK6E4aZXtb-GzaKxjxHbZSJEF6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdr
    nhgvthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:VZjGaaffA41ncdaKonEYindKxDWHIMeD293FoWHv0zVs5-pmGaulAg>
    <xmx:VZjGaZbSyK3Cv7n8SgRiyDnP_v0t1jXFgJOVLfD0-NXjx8T157NEXQ>
    <xmx:VZjGacZrtIIkSGsNkUX4kxFpJeTRBdLPq_kcyHDpxT1p04uog_VHBg>
    <xmx:VZjGaeIX8VCmz3SZnD7sm0oCD62ur_YVPRRmdIqIMsPghdIn6qeLUw>
    <xmx:VZjGaWyD8mO210D0n5-lYUcvzhsV4mwkCVIlsPtCbS2FlQhmIndJqKBb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 10:46:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 430c72e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Mar 2026 14:46:43 +0000 (UTC)
Date: Fri, 27 Mar 2026 15:46:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v5 10/12] hook: move is_known_hook() to hook.c for wider
 use
Message-ID: <acaYUU4FvEwWTaNu@pks.im>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260326101819.1307742-1-adrian.ratiu@collabora.com>
 <20260326101819.1307742-11-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326101819.1307742-11-adrian.ratiu@collabora.com>

On Thu, Mar 26, 2026 at 12:18:17PM +0200, Adrian Ratiu wrote:
> Move is_known_hook() from builtin/hook.c (static) into hook.c and
> export it via hook.h so it can be reused.
> 
> Make it return bool and the iterator `h` for clarity (iterate hooks).
> 
> The next commit will use this to reject hook friendly-names that
> collide with known event names.
> 
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  Makefile       |  2 +-
>  builtin/hook.c | 10 ----------
>  hook.c         | 10 ++++++++++
>  hook.h         |  6 ++++++
>  4 files changed, 17 insertions(+), 11 deletions(-)

This needs to also be changed in Meson now, as we're adding
"hook-list.h" as a dependency for the builtin sources, not for the
libgit sources. Something like the below patch.

Patrick

diff --git a/meson.build b/meson.build
index 1b0e431d5f..2536ea80ae 100644
--- a/meson.build
+++ b/meson.build
@@ -560,6 +560,18 @@ libgit_sources += custom_target(
   env: script_environment,
 )
 
+libgit_sources += custom_target(
+  input: 'Documentation/githooks.adoc',
+  output: 'hook-list.h',
+  command: [
+    shell,
+    meson.current_source_dir() + '/generate-hooklist.sh',
+    meson.current_source_dir(),
+    '@OUTPUT@',
+  ],
+  env: script_environment,
+)
+
 builtin_sources = [
   'builtin/add.c',
   'builtin/am.c',
@@ -736,18 +748,6 @@ builtin_sources += custom_target(
   env: script_environment,
 )
 
-builtin_sources += custom_target(
-  input: 'Documentation/githooks.adoc',
-  output: 'hook-list.h',
-  command: [
-    shell,
-    meson.current_source_dir() + '/generate-hooklist.sh',
-    meson.current_source_dir(),
-    '@OUTPUT@',
-  ],
-  env: script_environment,
-)
-
 # This contains the variables for GIT-BUILD-OPTIONS, which we use to propagate
 # build options to our tests.
 build_options_config = configuration_data()
