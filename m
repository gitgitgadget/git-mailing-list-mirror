Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5463E479
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876292; cv=none; b=t0BS1a0t6va46BtUpkMYyaMvXe95G8GS7hTKdt4UNUCcdOrPioSNihbduwI6T7nwGElBd88xn427t2IK3bHUL+XZWcYDi99jNheuPwLoAgoZBI0htEsCMb1p5YqVN3I9MK8UbgRpunCgvvsP2UZDWMBkqqtKlc3OqRnyUNvFo3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876292; c=relaxed/simple;
	bh=amDj2c5gDZRBhglehafDqExLCk1rzcqUdwLMoGAS4gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tC/yCv1D5e1ZBBOE8eWiVMkTnqJ/ZJUJmXhJdb1tnf1joZOrTgSV+j+wMZYAwUmC07Q9Uu1buns4fZwjoyyytx6jcFncv0DGkpeImf8Ugi4s7FLKB5sa6sssSvbDbK83xGy+KUsG8D3jGdgYqRu1o5moqat0yVX5BNFBji5UIgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NufLzusB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NufLzusB"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc6ee64512so80395805ad.0
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 09:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722876289; x=1723481089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ijt50yIi5MF0RHPoiFN0m67WlBufRjXujnKRkvfb7lM=;
        b=NufLzusBA2n3f5xukezg//PdwQUtgouBDhVzPAiaa5MI4uHAN9JnPcFacEJHLUSxmx
         nFZ7Qfh4WmP9ZupkaXmKnO/Skr6AUWN1ohOEZZjTNiQimXfLxkl9Rb9fHKTt9JNqaqfB
         Q5nP3P/jwmsHQnVhziuuJnaU+Qy0jKxmL5nn6rhB79BmvkHsI6esArb7YrkXSs5gAIhN
         MCpw4NTK1drKAGqvBZiOI7IurS2fhEAXQboh8pF06Z0dmFNRr3NnFLu8yT+LHkqKNjzN
         PjroxqgLgZ8J9T55lC4fZxB89LE/rihKhU3V1AyDmX++b3d5TvK3SCYDvRoWfbXbPghY
         /iEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722876289; x=1723481089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ijt50yIi5MF0RHPoiFN0m67WlBufRjXujnKRkvfb7lM=;
        b=Yc8P1MeO1yuzaLBbJlVSTkEdI071h5nFlCN7ZfUKr45QtQFd67AUKATT5JGtQbz/+v
         erG8YllMz2gjLuHz9Ixq0VZtkOCP7Ar3KCfvTaUzlddxNbTrqjBn693oQGEYL0K9r8xN
         Gj5+YSRbwS5M9f+M98SWRqqoPO+HoyPnMZsu/mpfy7Z8Jqe9HdzkCQe8ZjGvMRpqSYHa
         TH1m7dThqwq0iQAkHZQmM7u+OHTaiAShbGNVAeT6ykfA0y1by0PTNV6wqs8nWENpOGxt
         Awyjy3bERB0msrv0pwipZFFOKTB9w3ZXe//qZtdWHNhex39r22KuCWzQ03ObadvkunfP
         9lDA==
X-Gm-Message-State: AOJu0YzOht9g1j5HrtbN5bPsrQbCUzcYONuT4s1rKBrJ8ME9zi9qdrEc
	0XRQTpAAh+wXslGZxyBUfCeQFEBowQ89iZcdy7qJ8tIk/EFFCHyH31Zl8w==
X-Google-Smtp-Source: AGHT+IFdodlE5uncTPJPueC+rUwfLd5kBs+bKveIpM4VwxCIbW9Jqvsq6Ls7Un3C6Byvet0NF6T5GQ==
X-Received: by 2002:a17:902:ced0:b0:1fd:74ca:df49 with SMTP id d9443c01a7336-1ff5732c9c0mr116315575ad.33.1722876289389;
        Mon, 05 Aug 2024 09:44:49 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5929404dsm70180485ad.245.2024.08.05.09.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:44:48 -0700 (PDT)
Date: Tue, 6 Aug 2024 00:45:17 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v15 1/9] fsck: rename "skiplist" to "skip_oids"
Message-ID: <ZrEBncAbTZIpwczk@ArchLinux>
References: <ZrEBKjzbyxtMdCCx@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrEBKjzbyxtMdCCx@ArchLinux>

The "skiplist" field in "fsck_options" is related to objects. Because we
are going to introduce ref consistency check, the "skiplist" name is too
general which will make the caller think "skiplist" is related to both
the refs and objects.

It may seem that for both refs and objects, we should provide a general
"skiplist" here. However, the type for "skiplist" is `struct oidset`
which is totally unsuitable for refs.

To avoid above ambiguity, rename "skiplist" to "skip_oids".

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 4 ++--
 fsck.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index eea7145470..3f32441492 100644
--- a/fsck.c
+++ b/fsck.c
@@ -205,7 +205,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 		if (!strcmp(buf, "skiplist")) {
 			if (equal == len)
 				die("skiplist requires a path");
-			oidset_parse_file(&options->skiplist, buf + equal + 1,
+			oidset_parse_file(&options->skip_oids, buf + equal + 1,
 					  the_repository->hash_algo);
 			buf += len + 1;
 			continue;
@@ -223,7 +223,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 static int object_on_skiplist(struct fsck_options *opts,
 			      const struct object_id *oid)
 {
-	return opts && oid && oidset_contains(&opts->skiplist, oid);
+	return opts && oid && oidset_contains(&opts->skip_oids, oid);
 }
 
 __attribute__((format (printf, 5, 6)))
diff --git a/fsck.h b/fsck.h
index 6085a384f6..bcfb2e34cd 100644
--- a/fsck.h
+++ b/fsck.h
@@ -136,7 +136,7 @@ struct fsck_options {
 	fsck_error error_func;
 	unsigned strict:1;
 	enum fsck_msg_type *msg_type;
-	struct oidset skiplist;
+	struct oidset skip_oids;
 	struct oidset gitmodules_found;
 	struct oidset gitmodules_done;
 	struct oidset gitattributes_found;
@@ -145,7 +145,7 @@ struct fsck_options {
 };
 
 #define FSCK_OPTIONS_DEFAULT { \
-	.skiplist = OIDSET_INIT, \
+	.skip_oids = OIDSET_INIT, \
 	.gitmodules_found = OIDSET_INIT, \
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
-- 
2.46.0

