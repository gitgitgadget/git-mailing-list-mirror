Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356133;
	b=AwXWItQol+wyQdgsqQQ8F68kmaJfpbGFUy4zrK9EhJUV6WgIMDWVPYf9ZPox3h3UT2F8
	 g6n7TPYEsiOC1jIVVHNIdcJh8fi0yXEBDhREWObhEqSgzkcZQu9Hb0t/z30x3BXcOacAi
	 jXTCPV7ENk4RMRPWnylggHeUqWKrnT/9YNmat/Amw8Wvqhq0qa59/zCk7gxdBazOakSpd
	 0QET5VfpHJxy+xls4lS0IBpem9rM8zo+6VfapFU5o6xAsp3Eq7d/+ik51LVWjRpBIbmiL
	 KVcokm7xyqJ9uH15PfFQ8ejxSxMhz5a/70UV1dT3fX7crXoJeFF+sXfj4Vx7WQh4yrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VRMhMgx55eiYzaFYGNRABKMqrdCnEnkM6V/EVeEFL80=;
	b=FN97yNWsDCKiGN6muEFuSNCdGYFmCwfW3Gn94Pt/Ur9cQfMO3FlXrCp0aaNNyRdxIm3H
	 TgnMQAMMi31Cge2ui+Li9gRVyIiMz21IxtSSYQiuhBOcc6GXGtM9QejYqgX5Sq285lSWQ
	 Q8sS2mfD/2LfqjI7hNa3fHJG50fXVE8P+d3ViHHxurNEj8SS8AgNot0CeLMKn1yTSQes9
	 dCz7FPp8OQY5cO2ayTE1hml1thGlbVsVFQZEsqhXhH809N3V0EKf5zYZqwBVEgNho1BDs
	 y6B7WVjeAoUC6Fu/StYoKj15Eom8etKRj8wkAgNdLKOcefUD0+L7kOer/As+59JRZ+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oRT1aSTK;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C833760A6F70
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C833760A6F70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oRT1aSTK
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e6eb21a8fso202419f8f.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793356131; x=1793960931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VRMhMgx55eiYzaFYGNRABKMqrdCnEnkM6V/EVeEFL80=;
        b=oRT1aSTKATfxecNcMIqZNEDYFcvpovt6plXdcU4UW0lxRJ4lN3rJz1RD7EThOiqsov
         0lzY6C/GLxz6yhS3v+cwet3k8qN6XpypBN0A69OQ0AAaqYSQUa1LdcPmQ3LTf7MDOycp
         XrMkpsKxa11DtVC1YQGlz9wNMIFmbK9Mq9r62+BgJu1L6yIhbrv9Kou7sZC8dArNf7tZ
         nl04Rgq0J35J1oaEQzhsxmZStxwhZ4c2/F4wuB3YYIHnZp7LhPKxaRX5RsYp2SMV+KMU
         EdAhv1ayGcHodvJGi55UWjyuqP1XP3f44uqvAJ2iDbwvtI+iin5MiURIym0f0zxW29em
         zTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793356131; x=1793960931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VRMhMgx55eiYzaFYGNRABKMqrdCnEnkM6V/EVeEFL80=;
        b=SlKiH1Ux9eGHo93dI4ZW3ZSwcBwg17avo2dXmdpCXNaW4ywyEa982ZcXa3nJcfz8+m
         jWWV1xUO9MGc1ViZ2Y5klQTI/lUj882YodA8oHTnK05oFYYgRXxZ/XLxVVYwlkl4Kp/C
         yz7GzDgk+GBg8403/MDT8hKbG24huhMEwAH7cu6NC3iI7n9JF9lZyklp3TEX08OgSP9F
         /tl2OQQIbaJUXVaR0ETN8vEcZ66wWK17hPhQffnATy/UJrhfMuKMbPWDL34k860IOa6A
         54ttO+5l6lseH9W1lUzyIpeiRmhrzZ5LaVm5CgsilupqVKmDqS4+NIwNNa/3BA2Cv5Ja
         d9NA==
X-Gm-Message-State: AFq9FYKSIsuAFbK0vM+yutYx+tlYBVxb0J3ycrbLkEoPN8IkF1+4OFAN
	nplb4lyvs7atgx7MVo8iWoN+1xikfwRjGkvIuSjbdZgcn43wKBYVsPOHfafMVw==
X-Gm-Gg: AYBFou3k+cZui/uRkoBZ6XWi3Bpdqn9J+LE3nu+xquoaiPNg7iTfTpaLw4Vsr1BizMj
	pMGhhsO3C6eY458k+fHbR7hM7AMJNZ1Gz4nyLHncSMP5le97b6GpGl3az7byvVRLw7I5gHC8hJK
	YfClEDx/Qbvhd3LrtZBReNKVaXt7R3qC7UEm86Q+8D9QIJPcB81oGlyq93ZF9G3MY4QDIkylgFh
	yNJHEZggcp8r9Fi5c+PXKgj+KqzfSw4ST+zh0KKxEE7j6Zl5QV5zMO4R9Pmqs9kHh2iGOwLf/tX
	tvYaz6xeQ3o50U1nRijigkVnsa28Qvj44PoR74K6xzj3gQGQsmBXj7ZouOuZpagcmIhVsiqLzXK
	LWpL+qcjM1yqLZQHPOBbwwirXR5s43G4ZT/HjwqDThdnk9WCFwoxnDlJeSDeVZXCT2NvJP2JAfP
	kvwyScd7syL9AWZUd/VfOUtbRMrBu2PwAnzfjXSN0R9VAs/H/PfyiD4zTGqhbn+u93nSEsNnwFt
	1CQUvxmEwxrX5KnTMjGHc2YL6XaufqkTF/ONfwvxZQNDEIdheMf3ctRbWL5hx9RpWX6eDxrcOw5
	Jo6yZSg6r0WXAjDkbRLFApO/JLvTAkOkdr9fHNqOQ/FJ4UArk2Y=
X-Received: by 2002:a5d:5f41:0:b0:48b:5e2:52c7 with SMTP id ffacd0b85a97d-48e6e2bc057mr4856313f8f.8.1793356131188;
        Fri, 30 Oct 2026 03:28:51 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([205.147.30.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b964desm2449445f8f.46.2026.10.30.03.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:28:50 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH 6/6] diff: use size_t in count_trailing_blank()
Date: Fri, 30 Oct 2026 11:28:39 +0100
Message-ID: <79f1781abdd196ac35ae888ea5470705c56eaa4a.1793355390.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793355390.git.gitter.spiros@gmail.com>
References: <cover.1793355390.git.gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 3c7a31204f (xdiff: use size_t for buffer sizes, 2026-09-30),
mmfile_t stores its size as a size_t, but count_trailing_blank() still
copies it into a "long". On platforms where "long" is 32 bits wide,
like Windows, a buffer between 2GiB and 4GiB gives a negative size, and
"ptr += size - 1" points about 2GiB before the start of the buffer,
which we then dereference.

check_blank_at_eof() calls this function whenever the whitespace rule
includes blank-at-eof, which is the default, and it does so before
xdi_diff() rejects inputs larger than MAX_XDIFF_SIZE. Large files are
normally treated as binary and never get here, but a "diff" attribute
or a textconv driver makes us diff them as text. A repository can ship
such an attribute in its .gitattributes, so "git show" or "git log -p"
on a commit adding a 3GiB file can be made to crash.

Use size_t; the rest of the function works unchanged with it.

No test, as triggering this needs a platform with a 32-bit "long" and
a blob larger than 2GiB.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index b4ac17f8ef..e42e53d43e 100644
--- a/diff.c
+++ b/diff.c
@@ -711,7 +711,7 @@ static unsigned long diff_filespec_size(struct repository *r,
 static int count_trailing_blank(mmfile_t *mf)
 {
 	char *ptr = mf->ptr;
-	long size = mf->size;
+	size_t size = mf->size;
 	int cnt = 0;
 
 	if (!size)
-- 
2.53.0

