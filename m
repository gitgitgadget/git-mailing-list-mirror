Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69A112C80A
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387479; cv=none; b=NG0vEJRx0jc0XlbLwGxoLsFbxpkX5+XuNIGmKP+L7vH3/7oDm1X+9lwHls7I8io8hXccfUPzkoP0prbgZPp5cgbczSE5/ekvoyY9CSS9bBX3zyjfzmVKgIJwAJh+e1RK0V7AYyJVamL++1PTj5mGfk7+TRSWwsJ/WDY93/zx9Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387479; c=relaxed/simple;
	bh=NDPtDtw7T+0JatdBkWT2+BSE6I8rFk0sWdOtK9u8RYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLfT3t/BSipH6w28hL1ps2LyG9vI5XV/BmmmTrm+hN27bhw2p7Lfk36UgQ/70ap0OqqdBJgXFrk7Z2TkJK6VdsjhBT5vosjh0GSoehk9Q/N46H8fFV7Kj8Efw/j3/8gzb6dR+p9F1md9JPoP4eGi8+V5CgUmgE7XV0GsSC+XEXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=t5m+hzzD; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="t5m+hzzD"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c3b256ab5eso2387290b6e.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1711387476; x=1711992276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GoV1jDIczJHRwL9dURd3Gzt7HmKY5m4NmbsSqobqSDw=;
        b=t5m+hzzD0cLvTbVVr7jBvZX3a2S2qadNm+5Hd3TxeiiGXcezj0fy5sNScYEq6qU3iJ
         L0+wZScd6sZetYylRH64z1hBUz2dMN+tDY2ItG8JzlnPfqpibCeJ0S8S1ttgkr3nIJO/
         8Z4eGr6faJy5kuGKujLyymoyD/6x4ghvtKbowNYINW5BDRnb6QkJCYrUYm3oGfCBQkp9
         oJh3BWuQ6EXsxRsJSewp+ATCU/5SQAaDhYOb3ormUxU4RfJJUU3xqMMTEl18sg61AsLn
         jvCtUCxS1ai1pJ46ZLo53u3JuMOidZlY5xx/6AS8foEHv/13rolNsymAjtgnZZDowxpw
         lRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387476; x=1711992276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoV1jDIczJHRwL9dURd3Gzt7HmKY5m4NmbsSqobqSDw=;
        b=C/ERDrVngl/q/IhbrA1BmC9pFODiW8zEIoYD/C+z9SXscvSYWWV/4I2GMSZ4dksRzw
         bQaoS1F9f5jiUwTj3GXUXIVHlzausG+O23dW992N2GWPP8dogK9M0jRMSoZ8kbkHZykK
         Wdh5bVXPyTYvw7KaGI9ssf2PZB4DlDRak1FKDH7vgtWeBcS9bUqUpVP9+yBt1MYbDbzE
         dWRSlzmf623LUEvYBPhmd6+51USWWV5WtR28kWBS5MKbz4zRwysjCLo4OUk2X6ah+UFO
         JleMJ7pqpzXH9CyIkquWQwnwwn4B4Gd7RalpIxdaak3au9oTQLiXPXqjjVQ27BbhIC1X
         +HVQ==
X-Gm-Message-State: AOJu0YzUX5kLXZ/nJbWy7nFRobAP/X9LVhFIcnwPbCc2U3weaKRCnUhp
	JrZcnZfvntecwa8skg52eqHbk4KonMG2/+i/Ygu0DlH5Q2Cf8NEbFKQMVxTy/+WoQnbocXqQ0Xy
	DHkU=
X-Google-Smtp-Source: AGHT+IHKqSQhzws6Hrc4mlVM8SYYKs3cuRo+1JxCOi7WFAOTGCquq8xta4d9JTnQpKVmjUb4KfxR2w==
X-Received: by 2002:a05:6808:6492:b0:3c3:5852:263a with SMTP id fh18-20020a056808649200b003c35852263amr9929826oib.42.1711387476645;
        Mon, 25 Mar 2024 10:24:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k20-20020ac84754000000b0042f30e63b1fsm2782347qtp.49.2024.03.25.10.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:24:36 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:24:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/11] midx: move `write_midx_file` to midx-write.c
Message-ID: <73977036d7a8cc8f84a5dbc54e462477d33f2c1e.1711387439.git.me@ttaylorr.com>
References: <cover.1711387439.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1711387439.git.me@ttaylorr.com>

Prepare to move the last substantial function related to writing from
midx.c to to midx-write.c by moving another thin wrapper around it.

Like previous changes, this patch does not introduce any behavioral
changes and is best viewed with `--color-moved`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 9 +++++++++
 midx.c       | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 635e6af193..3d7697d8a2 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -18,6 +18,15 @@ extern int write_midx_internal(const char *object_dir,
 extern struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 							const char *object_dir);
 
+int write_midx_file(const char *object_dir,
+		    const char *preferred_pack_name,
+		    const char *refs_snapshot,
+		    unsigned flags)
+{
+	return write_midx_internal(object_dir, NULL, NULL, preferred_pack_name,
+				   refs_snapshot, flags);
+}
+
 int write_midx_file_only(const char *object_dir,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
diff --git a/midx.c b/midx.c
index 702eca805a..39b5c86736 100644
--- a/midx.c
+++ b/midx.c
@@ -1755,15 +1755,6 @@ int write_midx_internal(const char *object_dir,
 	return result;
 }
 
-int write_midx_file(const char *object_dir,
-		    const char *preferred_pack_name,
-		    const char *refs_snapshot,
-		    unsigned flags)
-{
-	return write_midx_internal(object_dir, NULL, NULL, preferred_pack_name,
-				   refs_snapshot, flags);
-}
-
 struct clear_midx_data {
 	char *keep;
 	const char *ext;
-- 
2.44.0.290.g736be63234b

