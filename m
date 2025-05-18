Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675F938FA3
	for <git@vger.kernel.org>; Sun, 18 May 2025 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747583832; cv=none; b=p4ubbue8oammGxETCSN6R4+cAWL6I4wFsIk17UWVJH/8/9u+WwyNMhGKjKI/gQ1WWL5u0Dor+ZnY5zFuk6TFcfvIEQGwIdZjTVL8V9b46zOR01xBEVqVZ1248WKrQWh4GF1dTxExVPbDLyVZ8m1gOvfSoCFWz2WAyHMLqyWkd8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747583832; c=relaxed/simple;
	bh=upl9txsC30k6dmJED6u8Mfd5mnUSgxISgaamy/7jEdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxeZvNthShjsXc3QUDyNVgwnvHanZJC2qZCo4TJorLWNQCrr0wJ/rYak2Lnd+mqAlX2DT7oX7g08gSg8a+SFZD7sqOnZgGsYwqX0HbodoXX7UuOQjfhyC3y+nI5diAiUbZCegECR2UphR5V5Qu2+YaXAEMyDlscaf8tiNSlW2rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpgLgnOf; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpgLgnOf"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so2827720a12.3
        for <git@vger.kernel.org>; Sun, 18 May 2025 08:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747583830; x=1748188630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5oKzrnYZn2+wEep1D/GbPwIVZmUNjK4Gx9NhTT3ZbG0=;
        b=kpgLgnOfNAmF6QTmyLOaIEXYaZir/FnyJ9IDcn5YOfkUxouWVNnXruLwMTAFFiqUhr
         ewt7aiJylGiq9lVGDWRzME2TJGgECswOq9tY/7BX/dCJC7bR+yoP3IQQIrLspVwHpZcA
         aIpbxt17ZqLXJfWun3Kv9uNqWNZIVt6jekb1UspNvb3zsKaqXdYH0tu9jpe7JWkLwavq
         G4NXDF+vTriA78qocsrlbgsvF8SLYEA6QrEhDFhaO4MmKT3sKVvihpjsWXJGTMFFl4FZ
         BtKp0LfX8eMXCdbWq+GdStc26kkTgUt3xSFLJi0oHnyCV381yGvp0u6Hura4FKQbFuXB
         ypAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747583830; x=1748188630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oKzrnYZn2+wEep1D/GbPwIVZmUNjK4Gx9NhTT3ZbG0=;
        b=sUYA7+xGHv3XBJ6b482E6Yo1X3Y2HWFNiltdy/27o8Hb0YhDyl/zYrLeo+yFduV6DF
         TiBV7b4tDfW/YNRxHeJcobxB+yPNyIzOFyMoZqYqwy6Q0OUHWaL0zPwcKG/zYBJj28Bb
         Xt6iQhkvgg3+XkCep61dqNLVYTnyc4eUPidKiVkM63r8/GEDhXOiqG+PnLNa714e/elc
         nzyBq9BejXf2bLXbq4k4R71Xl/LG6SXRBWCXfqsEZVisMVJW3g28gNCunNXJXiO9ZcFD
         8xRXIP0xD5PVzqeOPJIrraf22m6EzqjM6Ub7sLH+eZ7aXbzTw53iruCLQ0wPZ0N5758G
         Q1UA==
X-Gm-Message-State: AOJu0YxK1KbWP2K6ZyEPbTip2Uy9SspFVVquQYUOQJW4KI8n1asyPEnu
	nCYQad5oN7hi9+5tqqtWYv3G4QnoNo/UPXOqhIAr3AXiGDcBCSCJNBms+xYZbEHh8xM=
X-Gm-Gg: ASbGnctOok9dZk1DBjTNtORUHPzGK+fU7FkbN56tnVtZp400pmDar2vMg3yv000Z14x
	JynLQchjyA2SqyzGY6/V67GilGaJz645F2m6ugi+ucgxcfbhC8z2AJ9l0wxcQwOa1CEdqScjq4x
	Rc7A5mj2yh+hONMlF29BE0YrVKfQm5lRfnC1UouwOsuLD16lOAUS2at0+fTe0A8+HRJaCZOI/uM
	JR3IJr4mj46OnsNN4G2OUaL4qMJsRDfiHaMnUn7cnFZ3Sdai/Au3cqW63dnpPnShPWcQrp6ion4
	h6pONcypvqZ9CULe319hFcvVR5vxACml9yHwWgG55E/ivYk=
X-Google-Smtp-Source: AGHT+IEyPkyQsRyBrQ6m993RL+W3zaBDFag6HlzBII3YUKTEPXfVR+ta4uUwUSjVDRhEyWiRS8ZPOg==
X-Received: by 2002:a17:903:f90:b0:22d:b243:2fee with SMTP id d9443c01a7336-231d44e6835mr114135975ad.13.1747583830238;
        Sun, 18 May 2025 08:57:10 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4b10b97sm45178925ad.106.2025.05.18.08.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 08:57:09 -0700 (PDT)
Date: Sun, 18 May 2025 23:57:07 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/8] string-list: remove unused "insert_at" parameter from
 add_entry
Message-ID: <aCoDU46MmoGPB60b@ArchLinux>
References: <aCoDB9P5XV1lHMil@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCoDB9P5XV1lHMil@ArchLinux>

In "add_entry", we accept "insert_at" parameter which must be either -1
(auto) or between 0 and `list->nr` inclusive. Any other value is
invalid. When caller specify any invalid "insert_at" value, we won't
check the range and move the element, which would definitely cause the
trouble.

However, we only use "add_entry" in "string_list_insert" function and we
always pass the "-1" for "insert_at" parameter. So, we never use this
parameter to insert element in a user specified position. Let's delete
this parameter. If there is any requirement later, we need to use a
better way to do this.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 string-list.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/string-list.c b/string-list.c
index 801ece0cba..8540c29bc9 100644
--- a/string-list.c
+++ b/string-list.c
@@ -41,10 +41,10 @@ static int get_entry_index(const struct string_list *list, const char *string,
 }
 
 /* returns -1-index if already exists */
-static int add_entry(int insert_at, struct string_list *list, const char *string)
+static int add_entry(struct string_list *list, const char *string)
 {
 	int exact_match = 0;
-	int index = insert_at != -1 ? insert_at : get_entry_index(list, string, &exact_match);
+	int index = get_entry_index(list, string, &exact_match);
 
 	if (exact_match)
 		return -1 - index;
@@ -63,7 +63,7 @@ static int add_entry(int insert_at, struct string_list *list, const char *string
 
 struct string_list_item *string_list_insert(struct string_list *list, const char *string)
 {
-	int index = add_entry(-1, list, string);
+	int index = add_entry(list, string);
 
 	if (index < 0)
 		index = -1 - index;
-- 
2.49.0

