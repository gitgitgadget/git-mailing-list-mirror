Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDEC15EFA4
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501243; cv=none; b=Er1nLEONRrGprN1vlZIcc4ylCgrEHxKi7vHKIb9SuPxOuiO+GoUQ36YdU4YXugDs36Ex1TQ5TFWmR8eyk3QZmtjrBKje/CBJWJfb4cfFsIk+tCVxAJITHRDIIVg+BL32hj0F9eSeaHWz8Kk1nX0NFruscQ+qQFlIrJ3PPIAHq94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501243; c=relaxed/simple;
	bh=79S8d/XIojCM3+KUc5uwvC1NwVpR+a+PQmBgMZpxLQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQvZdVqhJPCrxBLbiSArpeWrZOKByGMkw3yy/iMdgKFU6kq5cXqqPlkzjb5XuAS7U+bEo3rXEFgs9sMMf/0w67QktQMAVtUCgo//iMaj9F/IibDDzWRdKJBmaOhz26GOcr1RtZHw6k4WME0rTibvuY7bW2+PFHNUWGYl116vBNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFjKPv9o; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFjKPv9o"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f9d9b57b90so54523575ad.0
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 08:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719501241; x=1720106041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=If9jABsSdMpep5nQbosl5yEDT0JsxmJqEjUT7xQd328=;
        b=VFjKPv9oCR/Co0s38s6wQRnuQWw27ofxBUL7vSc0BBPOGTSdsAvCCkJkB7kasTGvnG
         +gOH4ly88fZ7cCRXwyx2X3tqkWRSLt7sbLzjvpuZ9QenFqyijHayiVeXLLdDlug0Ckfk
         G9cTw8oTnBtPUM146NUB6FdN7ilYq1NecS86jhECQLqAth7kHYk9pZFoQW8xBDH4f6eT
         nhkuje/K9CJBQA5C8l0Dwn0yM8zm1ns+njGyRnwu+26+ARWYNbNWePvMjldWU4vN16wR
         ZWv+/i2cYpV2i0UyPHjWDCPFU56R2PX0wS6CFEuIORsTpRkWBbdAMQLcFPlow9cyPbC7
         TRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719501241; x=1720106041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=If9jABsSdMpep5nQbosl5yEDT0JsxmJqEjUT7xQd328=;
        b=BfiEYjd+ZNlBMJCkuJz4D5OQg5An+N9oBI2oP0BEOJLfuHF5x3Da1oaFMumlx8sRs+
         YGq0H3d78Eo442O1tkpDG2j3C4PbBgs7nzcyzR7BmBZHNqwf1Y+1o0cI83OFCDUHc/Zq
         S0uwE8eEi/i94SajAQ6j7/kZ/tpkcIRgYST3hzydxOoazewIM58hBU3X/Bo+WgQ0pDmF
         qTP7+InAyAmzlKHcwlLKHvlyHV/iXOpejXj7dyoK2yZX22sRuvHiVJQeSd+yPplqtgw5
         ypuWi6S8UbcUqU6wV+Qe/KmP2tXCmUAp49aLl5mcyeBkr2wgCF6Ou1ek27SxmCPgdzXY
         dJ2w==
X-Gm-Message-State: AOJu0YzQa+okwE5/9De9K6BpZs54bxssVWUmx2YFYmBbt7DXBPo5eqvw
	wwd6uoo2dSC4y8X11r/GvSNHIeRRhhe+Smd1AdVgNkhaHyDipXcmXhileQ==
X-Google-Smtp-Source: AGHT+IHcubCvTpzNvSXYKQI3jURp6S0i460ph7zV5rYl1kqEnnXqE3CdySpQdzRBm3T0yHHFuooC5A==
X-Received: by 2002:a17:902:f650:b0:1fa:2dcc:7d94 with SMTP id d9443c01a7336-1fa2dcc7e46mr171194665ad.33.1719501240793;
        Thu, 27 Jun 2024 08:14:00 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac9c570bsm14414325ad.292.2024.06.27.08.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:14:00 -0700 (PDT)
Date: Thu, 27 Jun 2024 23:13:58 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v5 04/12] fsck: add "fsck_refs_options" struct
Message-ID: <Zn2BtjrhzsJlfH8U@ArchLinux>
References: <Zn2Ah3WDhtOmzrzn@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn2Ah3WDhtOmzrzn@ArchLinux>

Add "fsck_refs_options" to support ref consistency checks.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fsck.h b/fsck.h
index e531b44a66..a17fee30b4 100644
--- a/fsck.h
+++ b/fsck.h
@@ -138,6 +138,10 @@ struct fsck_options {
 		 strict:1;
 };
 
+struct fsck_refs_options {
+	struct fsck_options fsck_options;
+};
+
 struct fsck_objects_options {
 	struct fsck_options fsck_options;
 	fsck_walk_func walk;
-- 
2.45.2

