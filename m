Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C117119C540
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097243; cv=none; b=DunjjcPtxJFDWobfwm57qyPV/VVc5shDnBblVXdtVba2POJ6tq9WMCSXgoi6hB4HvTQB8lbxlqtOy9b9B1S6AeP2HJSg7v7TY89qDOOUv4N5KHyV1pZObblnebLila9rWdcM3XsM85qkGPqjamnbhR6w7hKp+RXPXg4vYMJVr7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097243; c=relaxed/simple;
	bh=1ZcsBD1yYscyPDe1GJlQC/359Ll8EjxU3+caB1gx+M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjVkKBTRSNwjLgqRI+WbUYg66pdH9HP/Ar0iKD3u+z64KnX375l94obLtkInOBwiAj7TSDKrS5DCieJ1XPdLauqKCUSzgrYttLNYQolIS0u3cQW/HoPNdzAYeUml3asNmQKgvQakoQ0LVLKe5PPpemCHMuxSzijbGE/x2b1njfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=YOdIJ+sp; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="YOdIJ+sp"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d6051aeafso40152387b3.2
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097240; x=1759702040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R6JxmNgvpH+K9zshdHq3atGv9r4RdUsHD5XplvrqBGo=;
        b=YOdIJ+spwhDptd+k8/0AfEM0rIzXJTHEmOITCAQj/KcCxqWXNNkjtNPSia5s8yQ404
         jDnMYL5tYSyna62aAMIIontl5aj37K99G3QexFOIHk0tzU/dKe7Lu/yVAfnS1f+0DHWk
         s7ucqDgdds9JNqnZXHWtA+cIVg8K7JWhcqu6TMIpkWK21o2s5LxFvhoICGCBz8EORR9Z
         oxCzez0J+T6dgsQac/vKO4FyIQaCElnIhc8UweWIsAZdHj4C75qhr0osuHfaS4jvrqJi
         ICzOH7vPfCE85bD4NoNwf17IEHrEbguvZxKZC7KYokQoeEaE9O9A9JY+OVZwDBzBBdh3
         bNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097240; x=1759702040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6JxmNgvpH+K9zshdHq3atGv9r4RdUsHD5XplvrqBGo=;
        b=agU8ake8DrN41FyciKPg29ic0JLt/vGLBJUfvDxTh2ZeR83oMsIoco9IGvmHGYDDgW
         9LA79RQhKwqPVg/6qQnJaMAT+EchrzdXHfuzEGnWz/NhjzTOE98V6cQQxIBev7vb/t1Q
         dC8LTXL6xC2QPWGfoXlh/JFXDJE08Vx2PPonQ3zSk0YPR9hz69gTniyUYZpNrKtu8Gyk
         64b0aXLfIoZJPMdjB3ny154rPkLAXMW50AqMAIQbjjhKoApv1i1xLzL9YPInLLtP1wR6
         zjQ5YvMJ5AMAITc32jQhdZtL+BYkX81Si4J0kktHXKmdLggJkZOnmFyiNrWFvoTNC3q/
         4eqA==
X-Gm-Message-State: AOJu0Yw0huCBjGPAfJbx8YyHp2RiWfon8mR98kQluFGDDzk7mZtRlFL/
	k7ixC9na+tbZc0HCfd1y8j7+fwuei5c01XWAglhCIcgyVgIPc8j1+l2CTkc7OTA4a93ViweVYPC
	tpNJFd8S6ig==
X-Gm-Gg: ASbGncsMutP7l5pPYAaRaVBGtz5NioO2A4depE8fpBljYi8MyFQM0DmZQGuTQ9s6Ba6
	oIrXjnyYuZj653gK3PNu640PXJXA0bJzwedet08dLXM0WeU3PhU1XKpC54x1zEoChkmslQnlxdB
	0x8Lflop2LMbjj7hqUaaHWEStB2tiCambw9YBsU2QGHnG78ENfVM2ON7m5XKKMUB+4Ig5mKlT0C
	FlTQLhwfwe7XRl9UCWFCF21q7TXNnpXdBIvZw/pi/K0SpELvk8chVORVkeMgpc021+BUsqQ54Ps
	mYL22fR3uBIJG+0hogWlF7aKof65j5U46D1GmTXE6peWNKa8bN5ONQ8133GuyW+gtlBXbQbDfDz
	tEGTVj8a2Syfu91n4WlLvcRG676Q/cBVIo0+9yfnTcBRR1wZx2z25WN6REaikkw1ksQ3E4pUb8n
	SpC+/dsIvOCGakn9FWykqsK+JY3qnhKzmrZLWr
X-Google-Smtp-Source: AGHT+IGC/5SmH/h1DR1FIqxwatom5GAFvi7SWsFK4BuIJm64S38rHHByP2lzIIHZWpOd3cynUJh+lA==
X-Received: by 2002:a05:690c:3202:b0:76f:d03b:de27 with SMTP id 00721157ae682-76fd03be5a3mr107871677b3.14.1759097240611;
        Sun, 28 Sep 2025 15:07:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-636d5b1d9efsm1976115d50.17.2025.09.28.15.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:07:20 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:07:18 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 02/49] builtin/repack.c: avoid "the_repository" in existing
 packs API
Message-ID: <664a67c93620edf6727f0617f4dddce99901fcde.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

There are a number of spots within builtin/repack.c which refer to
"the_repository", and either make use of the "existing packs" API
or otherwise have a 'struct existing_packs *' in scope.

Add a "repo" member to "struct existing_packs" and use that instead of
"the_repository" in such locations.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 305782b2c9..7223553bed 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -126,6 +126,7 @@ static void pack_objects_args_release(struct pack_objects_args *args)
 }
 
 struct existing_packs {
+	struct repository *repo;
 	struct string_list kept_packs;
 	struct string_list non_kept_packs;
 	struct string_list cruft_packs;
@@ -265,7 +266,7 @@ static void existing_packs_release(struct existing_packs *existing)
 static void collect_pack_filenames(struct existing_packs *existing,
 				   const struct string_list *extra_keep)
 {
-	struct packfile_store *packs = the_repository->objects->packfiles;
+	struct packfile_store *packs = existing->repo->objects->packfiles;
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
 
@@ -498,7 +499,7 @@ static void init_pack_geometry(struct pack_geometry *geometry,
 			       struct existing_packs *existing,
 			       const struct pack_objects_args *args)
 {
-	struct packfile_store *packs = the_repository->objects->packfiles;
+	struct packfile_store *packs = existing->repo->objects->packfiles;
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
 
@@ -1139,7 +1140,7 @@ static int write_filtered_pack(const struct pack_objects_args *args,
 static void combine_small_cruft_packs(FILE *in, size_t combine_cruft_below_size,
 				      struct existing_packs *existing)
 {
-	struct packfile_store *packs = the_repository->objects->packfiles;
+	struct packfile_store *packs = existing->repo->objects->packfiles;
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
 	size_t i;
@@ -1405,6 +1406,7 @@ int cmd_repack(int argc,
 	packtmp_name = xstrfmt(".tmp-%d-pack", (int)getpid());
 	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
 
+	existing.repo = repo;
 	collect_pack_filenames(&existing, &keep_pack_list);
 
 	if (geometry.split_factor) {
-- 
2.51.0.243.g16eca91f2c0

