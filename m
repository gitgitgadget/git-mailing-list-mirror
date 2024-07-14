Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACD61FDD
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720960259; cv=none; b=XFu+cDHpwbp8pP5Ks1LbhxMeOUpJ2sfcl5MISjxljZM96LAySgZo+S5GoeEiKURae50bPQ+OWRoSRptEZ7qkh4BucuaMFhqQ8EFhsDaYyRtWUT1oYO1Xy/ZYanNVximIfPVbQP2RZlsiTAY6D62SE77Ck4PybMNVDPloxfFXkpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720960259; c=relaxed/simple;
	bh=4S/eeYa3WSAOASAvQOCp2KZZaz7om+5BeG3DmzjcW/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=id6TW9qpqw/35+6RxvXeb8ZFIygnrD/hwPBsdqhv+/QVveR6A82jT17QAC4yZaunsLkCjXQz9U2ApJxjXrt/S+UwBEj+3KytvhNSBppCz/GDHvcDzS21q1Q4ewsiAtSV7fthGs5PvepEl1CRVdR09r3lL9e8PN+LYOV220Urg/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XG/Lvpxp; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XG/Lvpxp"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d9c487b2b5so2081932b6e.3
        for <git@vger.kernel.org>; Sun, 14 Jul 2024 05:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720960256; x=1721565056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UDRGCnen2eMRIWeoclWfDlQnsmaMv5ILJOERPNxlb4=;
        b=XG/Lvpxp59Ib7+7uh1qFZwtdt0QAJyzh9TN6u/TYlvEe+OQm760cUdutBUfkPwP5j6
         IlmRAIs/A0p/Lm8Mu5vwDjYgoml+YjZhWthKKrphAOp7y+kXyPeORczDW159fjEpGP/N
         8ot2W4jXos3ODJJCiOnP7h/TRxKlitPs3o+MVdjBsD3telBhaqxFwCNa97Ai113MiXSp
         GV0E4926DTQygsUtQzVRxg6YHnXrCZpGCEQQVa/8cQarg6kcWuTcZEfYKb3RSVRg1pua
         DMT4U2jVSeBzg5k79Hu5MEMjrJAKy3LQPMXR2C/9H19KUuHaQ16B+oiRF/4ugJ/hvYbE
         8cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720960256; x=1721565056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UDRGCnen2eMRIWeoclWfDlQnsmaMv5ILJOERPNxlb4=;
        b=e48xnaT3tHP3GREWzG6mOBjHayak6Cph5YvulHPctT1o09g0ikV/GAUYW7gsHnE0vI
         udQbS8E5vNu/wFrYgEUIt0i0FcwfKFM763Ar6+Ate6QHHSurXoafgUSazlacVoL5XNqk
         NoomHFEbdl3T9NoXNiPurD+0b5dwgNKPKOyBGqME4XU33z2HuyzUb4ZHmnNNy/AMDNHJ
         6KT14ZLlcni4WKtF+dvOVPzA3zs3ytAqYY1jSALArQOJBOGhX6uSK0aZE54+apmeJYID
         iJX/CcT5zuJt9YnIRcs/XMK0JL8FLYznHZCvk08eOUitsJcuLvyoNbMAvdmsywiRieSu
         7ZvQ==
X-Gm-Message-State: AOJu0YwbMcc3u5XmEyEhP5nYHaTidqlgjZxGt/6dNycIvRhDn1/SGYfy
	FyyE5ENImJqLhgkYFdlqTfogWgAqx7cW7VOQzWF4WMUguFWxLB0zSGS0ng==
X-Google-Smtp-Source: AGHT+IEiO53LssiQbIs9r/6GVYoPmxGFwDmKuZ9kAf9I3laOWbQTmHvGkgODJsFKaFShFbbG/wSNYg==
X-Received: by 2002:a05:6808:189e:b0:3d9:e22a:8fa3 with SMTP id 5614622812f47-3d9e22a94c5mr14721889b6e.32.1720960254794;
        Sun, 14 Jul 2024 05:30:54 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb73ea1sm22955625ad.34.2024.07.14.05.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 05:30:54 -0700 (PDT)
Date: Sun, 14 Jul 2024 20:30:59 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v11 01/10] fsck: rename "skiplist" to "skip_oids"
Message-ID: <ZpPFA0jvHvBeolsC@ArchLinux>
References: <ZpPEdmUN1Z5tqbK3@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpPEdmUN1Z5tqbK3@ArchLinux>

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
2.45.2

