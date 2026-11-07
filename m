Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063939;
	b=ZrdPQMTKWlAtXA5yEYkVvtcPL588emKfIpS7SvOkJJwoJxsK7C4zKN7S4eS3sNHY+wNx
	 +vyqWufW/fxapZxb2NeDrH/dZJSMU//Rdcf9F8XLMf6RQaJeFZY8cyl5nXAydTwxQ03Du
	 Jw9DH7KDZRGnGXDescBbjiZODkS0xL/WpKRe+eUQ/VBF2NqTFKM7zpYGrvurjN+lQaZFx
	 sMgqLPdP8vf1+s3oMY2/veVy4X9+DZsTkO1zqMPAmD8XogPYoZlRAHVg7q6f0u5PhRkt6
	 Y90vsCT5GWp7CxqRS0meiEqA+CS10GSeGXaiCFoXdPC7nxVIJkYbw91TQ4hKu6O7IDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=eM3T7py2Qxv6HOGB+9DjeMJ2UR3Fenroj4jmv1ncYzw=;
	b=vejE0SRp/t/GZyLEFp9cIUD+/u7v8cjF8C+dvvEXCBAuluqYpXXkcMGR9/OGKNL14Lei
	 0PIhvbYIL5IdebxmJf6ih5nqnhRHooKYE7yumdcn4krpsne+GuIFc93AC4sYY5lYdbpwP
	 aZ9q75uCLclv8gY/zohC11iIztxpXRZmfjtyC0gKWYOrv3YV+VGiZrSfsCYKFAkyBvVDU
	 3HWYr7coOmVhZadZaW+EVmixv+D5e1kjqOsZtglWWZaVA8hc1QJxnF2xzDtgXksHRzhZA
	 ADwUGSkWJZz5Fi5g1zkkrqEdfgHOjLVf+GwmBTJPistWg9X6nO6OrW1ib3g0ypREK3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bnza3v1S;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB95606D823
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 15:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DB95606D823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bnza3v1S
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so2610162eec.0
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 07:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794063937; x=1794668737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eM3T7py2Qxv6HOGB+9DjeMJ2UR3Fenroj4jmv1ncYzw=;
        b=Bnza3v1SuV/+xxPkgz7aIU4ANploJ5ZqjtzIWeNJlrBHtvlgzsF/zm4mKxIY4Peptk
         UFv0tuaMpKY5+QmByjP27OaLP4M6mLCB9iWqhTDqfhO/0TKO61DkU+EiY6pjQvDoISYZ
         cYSex1T5V/V93BrL/D259QuqNb2neAQwkQ1SKKqNYii23bQnHmszc++qucY28CtZ3jK3
         USgfN+4W4LOHlpdYzVULbMuqI5UuBL6X1/9r+NqZcY8ZKe7nxQPU4hQPflCU3RVSei7q
         +gMDOovHdOdF+fCG8nu/ZlqS5eGYnKGOBACktakKLSN9PDRCXmlUMFfzZ9+H4lFolXMh
         DrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794063937; x=1794668737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eM3T7py2Qxv6HOGB+9DjeMJ2UR3Fenroj4jmv1ncYzw=;
        b=04Mq9S/vxJWe+n7jBR8ucEmu0JeY1w+j/lgsVQmXpYMhgEAyuJGIaLuNYE+T+90U07
         MLjfS75JKr2yOv6c1LLAuhgo3U8a/flCKMvDQye0MFMpJ7i3rZ2L6Zy8ItUERSF9wUPh
         zMpbhrP2Z57CoAlhTLQvpjB50m/kybJjCVNb8pRZEXt5v6IvrL3c0qVF69gJ3OPG4hSR
         0+c2RCe9m5U9XWxy8ix7WdQtpbOK6PEmOTvN15xUpMta6wsPZIUhrNLnvMNprDNBFunD
         nwAdEFMQMordhp7P+Hk+PaGtvoODU28osuYJK+EzVj+hhyiAoiCbxUFt7T5wrPCWBDcT
         x2kg==
X-Gm-Message-State: APuU4Z9j09DkXEWn8dcoIGE8guJAJ5hQd2IAulWFfVds5UsBq1souAen
	ARXqxaxS5WDF2npOhBio41pAIP7qlrrfVJ188+iXkSFrw0AlXs6uqfrBFIS2PA==
X-Gm-Gg: AYBFou3SlaFNut3iqZuFJ4F8a3b8PN43YOLuXiiOMoy0VYzWQVk7a+2D44Jqne86cD6
	Zu2W4IfjRrALQWAfG/RG05Xnjt8sjoHXdBoQLpJMOh2u76/cxrFPO3N+8Vx2MNoJHL/UPj4towv
	MJkNLYwcBH3zCcuX+5lxYYVwnT9CU0G8q/umaayuBTjCVkTYZGh7Iaco8OJIGa2UnongQV4sdXx
	XCVXiQT5D4z7jqVg5qXHFwx7p4Bor022DDMhgiw+rfDTNAr9enoyIrOfZOQ1PBQTPpyE/TLWfPQ
	YuVaipPQ+volmLcfmL4iT2Cx9TZmGYkl2P9L2L3HttKN6nXKejnMK1cnzlwkkdMqpe4lUSyBKoa
	uFKs9U8GUQuJCH/W3HUBRpvXLy0J7FIL6eceIYqHMEiCM1u3QHmCh10wDifb7CB8Sr3eysLlv5y
	2EO2TbTygik2tGYDnBAgO73Y7ICS51SU29HchvpoOGuzTxqLCZpMT7rV7i48nRnt6W7c+auD+6a
	woialTQmzJLh7zKpKyPzlekKZYq1ZpvmZmAoTgjGZH60CO+mOjUs2rfeW2fjIDDXOMnThGuBWX8
	1sXh/8OG9xNrHPSKFdiwCfItpW2pnoaB2X1bEorVWZl9pLlskDkT6so=
X-Received: by 2002:a05:7301:4283:b0:351:68e8:4646 with SMTP id 5a478bee46e88-36f770085f3mr7147555eec.37.1794063937138;
        Sat, 07 Nov 2026 07:05:37 -0800 (PST)
Received: from Anonymous.localdomain ([223.181.58.158])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9fc92fasm21032623eec.19.2026.11.07.07.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 07:05:36 -0800 (PST)
From: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
To: git@vger.kernel.org
Cc: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
Subject: [PATCH] partial-clone: document promisor remote fetch ordering
Date: Sat,  7 Nov 2026 15:04:33 +0000
Message-ID: <20261107150433.17540-1-husainsitamuwala21@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Document that accepted promisor remotes are tried before other promisor remotes, and that Git falls back to the next remote when a fetch fails.

Signed-off-by: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
---
 Documentation/technical/partial-clone.adoc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/partial-clone.adoc b/Documentation/technical/partial-clone.adoc
index 18718a3840..9720b856ce 100644
--- a/Documentation/technical/partial-clone.adoc
+++ b/Documentation/technical/partial-clone.adoc
@@ -195,7 +195,9 @@ cache servers for fetching missing blobs while continuing to do
 filtered `git-fetch` commands from the central server.
 
 When fetching objects, promisor remotes are tried one after the other
-until all the objects have been fetched.
+until all the objects have been fetched. Promisor remotes accepted from a
+server are tried before other promisor remotes. If a fetch from a remote fails,
+Git tries the remaining objects from the next remote.
 
 Remotes that are considered "promisor" remotes are those specified by
 the following configuration variables:
-- 
2.53.0

