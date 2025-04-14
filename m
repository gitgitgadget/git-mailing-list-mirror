Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024F51DACA1
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661185; cv=none; b=oJXyw9Fk3Im77aXKhK5nlYA53wOUAbP7ZgSWCrGiIKtbqJnXraLfs6h5+ymSnJt3Ob7UquXgZHKDki2qcVsTYHTQLWaJJuHQw68n3AkKbvR1nR4bvNE4PrKneS4okRCxNsVcY3uq0pUrv5T7DWmMOy43HpvucheBu10uX5M7n+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661185; c=relaxed/simple;
	bh=ywU0h+S2+XN6ZTKsV/DbJhCb68Sn/LmHSw53qDlIxXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpOFfRJdKYKY9XW22kHwXPA4LHKvAZImDoaNJ6t9OH7Y0muF5U0KCG6jvRF+l0c0seg5C7XevYC6+mfsgLwCfPpSPA01IkCkLP03WiiM1aVwjRROu8V6c32XMUzaLHeCSuswBejOnMzMUFu0Hvm+3EemjHxfhck5PDzbDsp5+t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=fdGCQDa0; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="fdGCQDa0"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476ab588f32so67080181cf.2
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 13:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744661182; x=1745265982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ILIICMDPl0RZSvP63rdvmZ+/7hUawIa+Dcdqez0DYC4=;
        b=fdGCQDa0XxB9eWVVX77uSbrR9pXUFl/Jc6jhhHCNk2OViLENuzAHC1jMGBQ/Gpwt0o
         9cM5s4ZPdSZbTAKwm+pJ1TNYIDsSSp+YXgvTgBIiABQmpU1/ADaIYSQy7OEjOHVwjt4k
         eA2QHj3fSUWWwfbnpTKTiMt3RFOQrKbuT6x3SDiy9rvvHHCPOj6vsOtg/8eBexZGWoEy
         ELqtLF1Q5bru8/j87KChg6+WfgrI7Wf2C0ApP1Zgzg2c/07NC/PFxQQgZoaHuZAo0swh
         jxi/ic3XvURmyynEusZqN1/peIa56JegQqWV0iAglR/jM9AHvym02SfoYw8ZwzgryVtN
         e+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744661182; x=1745265982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILIICMDPl0RZSvP63rdvmZ+/7hUawIa+Dcdqez0DYC4=;
        b=tgZFzll8oi0+xCPmDwGYW72yuw8nDxQKLNVrIboFCkXn9HuQsxU/3xNpLHirSeoFj0
         jaBx7U4jShgYl5OAudjGXGVe2We/qFBGnEouxGVVz9mcOcNKCUPPlXgfbgdjtKiAA9mW
         D6uVixcN2OCc+Ta84fk9YMjXOidq+qUoFsx80FX+QYUOrToAjDUV+T33Ku0ueH97J5nF
         LoscBmdp6DZsmU1NXCo5OgjX2TAR1Fh/IsA50wVq+J1J1MY/GX1Jw/aAGokjgxwWBDDS
         es+fs/U09gDzqBRMC19DhM5sr/r0f1dafaiuk1laVFLnqmMp3JnUloJgFSTMY29G2zUB
         OjRA==
X-Gm-Message-State: AOJu0YwV9prgBsKK8dpE5Uwv7QlP0NtjfMGXheWoKTkxcqBVzTdD2l3D
	T2iK8APJaFToCmWPglmjL6nIgeC/OGowFWlcspIKcluM9y5F2Qs0gnULHQUw/aWgU/3yZRzl7DP
	aTks=
X-Gm-Gg: ASbGnct16LnU4CC5oq1lJLBNgiZqVxHX073d65OjVbxXcswzAQph3IEfSeYk8pZ4peg
	ZM8dqGUgrVHXI1n9GvlTlwflpFzemegt2OXEAdAxXirQNWL+m3/m65Jos7VIR7XBUudmoQLDLnD
	XN1v044J9nThSpj+ytpH+OnNm6yWMrumcedngpIhnxEG4miwMrYEbzlMH7xKQqbCtFk12INyqqq
	bb2zjxv1RM0Nf1jDrgyriNlTNLRhHNzJ4yU9rbtphyboDwk81txzKB9XJdW4veppOOepKzg8Ww4
	o0L76YQ31/yidTcemN/CaNpOI9Hcr/chdfjOppOtqHELvJPvCdvxzXB8a5WjSzXpyntSXtZ57uy
	ha5FPokVh0GS9n28dKDzVsU8=
X-Google-Smtp-Source: AGHT+IEz8pJUi9sm1Pi9OSWbCSX4VcqUqGA2F9efkJz6/YZet4ZaLoIdgZKLgrmKyQpJei0TLAcEcA==
X-Received: by 2002:a05:6214:2465:b0:6e8:fcc9:a291 with SMTP id 6a1803df08f44-6f230d68f0emr220254546d6.23.1744661182318;
        Mon, 14 Apr 2025 13:06:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0dea074bbsm87991086d6.70.2025.04.14.13.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:06:22 -0700 (PDT)
Date: Mon, 14 Apr 2025 16:06:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/8] pack-objects: factor out handling '--stdin-packs'
Message-ID: <5e03b482bad307e6638a85733a36d3e045abdea3.1744661167.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744661167.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744661167.git.me@ttaylorr.com>

At the bottom of cmd_pack_objects() we check which mode the command is
running in (e.g., generating a cruft pack, handling '--stdin-packs',
using the internal rev-list, etc.) and handle the mode appropriately.

The '--stdin-packs' case is handled inline (dating back to its
introduction in 339bce27f4 (builtin/pack-objects.c: add '--stdin-packs'
option, 2021-02-22)) since it is relatively short. Extract the body of
"if (stdin_packs)" into its own function to prepare for the
implementation to become lengthier in a following commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 540e5eba9e..793d245721 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3672,6 +3672,17 @@ static void read_packs_list_from_stdin(void)
 	string_list_clear(&exclude_packs, 0);
 }
 
+static void add_unreachable_loose_objects(void);
+
+static void read_stdin_packs(int rev_list_unpacked)
+{
+	/* avoids adding objects in excluded packs */
+	ignore_packed_keep_in_core = 1;
+	read_packs_list_from_stdin();
+	if (rev_list_unpacked)
+		add_unreachable_loose_objects();
+}
+
 static void add_cruft_object_entry(const struct object_id *oid, enum object_type type,
 				   struct packed_git *pack, off_t offset,
 				   const char *name, uint32_t mtime)
@@ -3767,7 +3778,6 @@ static void mark_pack_kept_in_core(struct string_list *packs, unsigned keep)
 	}
 }
 
-static void add_unreachable_loose_objects(void);
 static void add_objects_in_unpacked_packs(void);
 
 static void enumerate_cruft_objects(void)
@@ -4773,11 +4783,7 @@ int cmd_pack_objects(int argc,
 		progress_state = start_progress(the_repository,
 						_("Enumerating objects"), 0);
 	if (stdin_packs) {
-		/* avoids adding objects in excluded packs */
-		ignore_packed_keep_in_core = 1;
-		read_packs_list_from_stdin();
-		if (rev_list_unpacked)
-			add_unreachable_loose_objects();
+		read_stdin_packs(rev_list_unpacked);
 	} else if (cruft) {
 		read_cruft_objects();
 	} else if (!use_internal_rev_list) {
-- 
2.49.0.229.gc267761125.dirty

