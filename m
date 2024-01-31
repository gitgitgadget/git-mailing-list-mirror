Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190093B7AC
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741580; cv=none; b=A3kkTUGqcH/XFqdeU9CZgREM+ZhMPGM8MNYGaUViJeQQBXbC0BjNaJINWjGB08nfg+5kv+6AqrferisInpm4Byyr1kDE0LLntfIUvSjG4Ah5JZANC7U71Du4+OP35c5o7IUoZMEeTDAfzj/FjYW0te97tR5p1tvbEg0LcnxxHtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741580; c=relaxed/simple;
	bh=X7oko/yvIs3oAeldXN656seuSi7zcQTvgC2SAfCoHIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqZPxj8b0QXXq0Qg9x7xuXjKWMJh90Y0wdytiCMZekNioRnvpDwPITjMpLUJ2L5IrSY+1MwmLQo+EtpxTC1HuIEkQn0CFxGsXj3lvh0cNQaXIsma93VeCTLMnf06+hHk2w1ggT8zYVWcB35jTly/x+n56WGXgeoqr5sQYZ2YDKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Zqfboui3; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Zqfboui3"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-781753f52afso20224185a.2
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 14:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1706741577; x=1707346377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D2rdylrQlR8d3cmxxNnUi24Is1YeLY9eW34nzYmFj9I=;
        b=Zqfboui34KZKV11Pm7YB+OhlbDYf68gAumOLYVy2C/3ZYonBlGP9MltPCZ5Qw+Bqmo
         k72UM9zbvLlFMqOYn8E4OVSlKy8/cJZHu5EhZf98dWRHJpWw0nckiMraGTSf9SfO8tId
         nKn7FWxCNnEyMGtR1c0iEjrJzrM1BzDLLJHrgMJJF7THJTOfc5o0OHKyd4w1QghU2VYa
         OOtjZZzb+GJNbxi2Fz5GWIMn3pqIB25XOuxGvvCoVKxr/6Gbc/J6aosIn5v07hnYKWXk
         8fO3feQ1ydG6EHoJqzkMhBe2wyRYbPiDkrV5VuBYtGvg5Fy5F4fllCAp7lg3UW/EWEeo
         I+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706741577; x=1707346377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2rdylrQlR8d3cmxxNnUi24Is1YeLY9eW34nzYmFj9I=;
        b=HPj3iSeDfTBwRUzWiwil2tgK4mSpcMO748ubbbYpgfJ/3G1qWGX80Sv+RkFcqvKU0i
         wFz2QLjcyHCkb6PLu5wfw/WubgRKuUfSUEcQ6w4LGsM7aH3szPdCifeENDoyVly6Z0go
         YjFiSYIFxywoXvk6AgysAGF/xv5PNRX1HJIZYMW7NzpfLu8wF7r4GFHIWHr1AvnEnXVE
         CtSlRBEf3+c5kAqF65NSDBCXDu9LGuCp1IgylpsVhXR+gBrKVp39NkFoLtNKqzbr+czX
         OC9WZZV5wqTC0btsP+PgtUXoBHBJsuxRObzHsw0PYBbrJ/s1oDsCmj2osVtyDOcQJhCf
         0H7Q==
X-Gm-Message-State: AOJu0YwY7UNYrGWFt6Ul3nVRFWzgRS9bnAEDQWNKW6TmO3aHtC2CAumF
	BQKnRJMTZp6L78WzHmKqAeb4VygJbNmLi7ZHSp+TwBBoE13Bo0cO4zHTlAKe/OM1zIMWXiX1EAs
	ZGi8=
X-Google-Smtp-Source: AGHT+IGu6EJLUxDZlus1LIdjns6gY77R5B9i08tipPcc1BxQ/CIocwvJe24W3l6+/PHZvC3QUSfwEA==
X-Received: by 2002:a05:620a:3712:b0:783:7e10:c524 with SMTP id de18-20020a05620a371200b007837e10c524mr1208056qkb.28.1706741577665;
        Wed, 31 Jan 2024 14:52:57 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i22-20020ae9ee16000000b007815c25b32bsm5214176qkg.35.2024.01.31.14.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:52:57 -0800 (PST)
Date: Wed, 31 Jan 2024 17:52:56 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v6 14/16] object.h: fix mis-aligned flag bits table
Message-ID: <9f54a376fb317e9df9a37c3de0c8f219d4768d0b.1706741516.git.me@ttaylorr.com>
References: <cover.1706741516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1706741516.git.me@ttaylorr.com>

Bit position 23 is one column too far to the left.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object.h b/object.h
index 114d45954d..db25714b4e 100644
--- a/object.h
+++ b/object.h
@@ -62,7 +62,7 @@ void object_array_init(struct object_array *array);
 
 /*
  * object flag allocation:
- * revision.h:               0---------10         15             23------27
+ * revision.h:               0---------10         15               23------27
  * fetch-pack.c:             01    67
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
-- 
2.43.0.509.g253f65a7fc

