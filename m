Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823F83C8717
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784980538; cv=none; b=eEC1VT7C7sbsodr3rGN7nqTGtBcy0eHVLFZD/Sl2DzwIjGr+EucWYIrgOWLZiHWPGaL5HZ2yw41f365bza7qUN2dPN9PWIhdSPLTAl5TQyYz1Lf/83MqCctyKTg57ClENLGG4JdGD3ukO8cOzPBjc7IJEQm3RgkVMXi/dzQzVGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784980538; c=relaxed/simple;
	bh=iishma2EqtxzRj0X0DFQGPtaZHRt3aVRQlgIAzVbB4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WGOukIrC3EnHiOX1UHI6q2AL82mCEV+3bR61nh9guDihXNl+HHo9RaD4vF30o6OPa/Idmm9SyZmZmntP9jHkXhccheEBCtNPF1Wbauz/EylBMA8b6hNMYxwVY6qGcGPpO/DWLSg10c6vF+ilrV1UKYFF17ZT1JlzFBFkjCgItZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEW2uMOx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEW2uMOx"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493f6de72faso10253145e9.0
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 04:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784980535; x=1785585335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r7uXtXwdEEdYzWzM8O32hOVu+sl8We77LyATIKle1/w=;
        b=PEW2uMOxHIR6EvOywmY/qFUB94sckheT1j4vIVx9n3vc3/dg4vOf4t4wohVPRTNnkc
         u1zaRqmlWMTvUtimX3TDqmCa/+M33eumuPHNmJ3vnJCRCWfMRAnvztyagnHeWQsWBcWV
         O+jwmD5TIbSZcIhsNUdfZQv6mJBXb1p0//T5cSoHhcZEgMocO+I9kJm2C3v003sGhA2X
         7x94aXHzlKlFWMMKgqtsLLul/IuEZfSG8AffrNoHDLOnslFSjpzMMNndkDOJ9fomp/Oz
         ofjTclNZd5hJU4R2fPAN4PDq1qblyCdWtkPkYhOSJhABv6TzH5RBHJDESjckkMrM/OZP
         JsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784980535; x=1785585335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r7uXtXwdEEdYzWzM8O32hOVu+sl8We77LyATIKle1/w=;
        b=rjJ5a5PramAOKU3EiUJZc6M5dZXOOv0lDgy4RSbjPzw3pqOyZJu8cFdx4nFotKXIFw
         f21GOnwz8n71VXq3muVqZoxu1F7zhGgvADT9//tX/cbqUKe8EvyOmsvgCwDJUuPJ1wJe
         d1Es2jk/xPEYbKTipL/r5LrPYb83CxEeJ+Rno6lfUmVsGST3zR8oEHaOe5T60e/NdkeK
         Dwg82MVoHPTBeiYu66iwdRWQVuSXZSqFH3lsZ3tK9ArI6ptwtf58rg1y5mkEaxPJDmlG
         cDcNe+2QEzvYyaodX6dv8Qt9bHAD1/2VxpCCULSU/VfbeHLybvf6L0okVNbZrFhM0gq1
         OWUw==
X-Gm-Message-State: AOJu0YwhExeC6bxPqwyhITFI4z/jaa1/7h6zyDrRuysGIFWzZ6KPKhit
	GndEITLuBOAEyb4ITZZN1W22/Bd8PgzOBJ8aKXIj1Gdoc8576XPlNck7
X-Gm-Gg: AR+sD13m7o4ATLYQEhrtKlXYoiKQyTm+ZInfrzN6TBH70nEyks1ruyWkBltuKDBKROi
	WCbrEBLKlgdSdsK9kw+n7ULMLr87AntQ5d3bib+c08LyBiEHcuVsKrNTBO4s0USXTrMRDMRu0HX
	kCkf2xHI69/VJvojo2LJTPBKQwkgpqKBrAcSBrWdHdWQxsww5jAjX6q/S+HCFT+1XkZAy04CNFT
	ed3SYkoVOnjeXs3iI8WUbFIt2p0+RC6NAmonR50v0f8u/PftgMx191jimlvwbOVuA8jKftoYJ8u
	FkD07lQ7FW3RlSFygWpT5/vjtu0pwq/Ts3AI/sJSblODb/O2h7oPqsnhj0+prVh2PzQH+8pUXrk
	dL1bp2a/dXWVErP+/hKFmXfbuHIQhMIKyKOEttpDZgfkaMV0ICzB/7jPI2NWLDOQ3ilI0cSilr8
	IHgcGCKfMcPxuxbFasQEEBX9gQHpjoqQrJkgFUNBqZwBPkzf475FTO2aC+KLURyryR8wTe91CfF
	4+hblJnyW67p/+rAnqN72JtuJxKNxZMFq1nuG1sGE9oEfMKMfK4mChbdDcYmC3EaSM44s85fx5N
	xe3FD5P35v77qWivOkyn6bHypAsW6jswiN4KxSfRxJ2FGyLkA12zlzHArDrMTCpsscSoDd3uJ4B
	4XKT6SSd0znxWN+WhqhNHs8hpRBx31x109eE8xvZAbokHZBZWTpDLgGznunBUfxj/bYznMKvDGw
	==
X-Received: by 2002:a05:600c:1d0c:b0:495:3c6f:7c18 with SMTP id 5b1f17b1804b1-496b5b3b22cmr25116645e9.3.1784980534662;
        Sat, 25 Jul 2026 04:55:34 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (132.red-37-158-18.dynamicip.rima-tde.net. [37.158.18.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4858e86sm41700515e9.1.2026.07.25.04.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:55:34 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 25 Jul 2026 13:55:04 +0200
Subject: [PATCH GSoC 3/5] fetch-object-info: request all supported options
 dynamically
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-objecttype-support-v1-3-2d4ca3bbabf1@gmail.com>
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
In-Reply-To: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

In send_object_info_request(), size is hardcoded to be the only option
sent. In order to support type and future capabilities, replace the
hardcoded size with a loop that requests everything on
object_info_options list.

This is safe because the list has already been trimmed previously in
fetch_object_info() to only contain options that the server supports.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-object-info.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fetch-object-info.c b/fetch-object-info.c
index cf6b94afb8..e5cfdafe68 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -15,10 +15,13 @@ static void send_object_info_request(const int fd_out, struct object_info_args *
 
 	write_command_and_capabilities(&req_buf, "object-info", args->server_options);
 
-	if (unsorted_string_list_has_string(args->object_info_options, "size"))
-		packet_buf_write(&req_buf, "size");
-	else if (args->object_info_options->nr)
-		BUG("only size should be in object_info_options");
+	/*
+	 * The list is already checked to only request valid and supported fields
+	 * no need to check, just request everything left on the list
+	 */
+	for (size_t i = 0; i < args->object_info_options->nr; i++)
+		packet_buf_write(&req_buf, "%s",
+				 args->object_info_options->items[i].string);
 
 	if (args->oids)
 		for (size_t i = 0; i < args->oids->nr; i++)

-- 
2.54.0

