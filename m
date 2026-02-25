Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D240F26B2D7
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 02:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984862; cv=none; b=YaDKrIPbTYCF0kbXdNVGPj3s3YGna+XXsyfUg8j834KbMlYmiJYVTi5kf43JV+Oale59r3TQTjmWxrs8LP58WDdpFKAAiULNMRIfftpVHxcUob/Nm/eJzHX0wRSsplyrjlvQI4H6gl3pMifEVGDhW0QcS3yQxai7+CMipLLPwCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984862; c=relaxed/simple;
	bh=IwVWfHG9itEEWUUcG7mnBHPjdMYE9kq6U4kxwDmpzw0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=aH/wze9QM6lGLwaXuJLXCQ6Vs6faE1/fNDG/e6Qo/9N31H1fQXlxmEZn/+Y2OLLYnnbCcd96OD1qA+yYD5vXkDoW6Agb5HpmOK/LaXCAeQ53vRhmZe40+BedHrBpz/Wg8fkQw2DIeLPBb9kyl6BAl00YtIKYXtQ+oqQvh4y5wOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZrWpPTN; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZrWpPTN"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-899a917a4feso18939936d6.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 18:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771984859; x=1772589659; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eHViz9uzA0qn0/Cwgl0PYBQiuFPJ7tiOWkbrkXBOjJk=;
        b=QZrWpPTNA90SvfrW2aJarMJ1kCa3LPbL64vV/bGWRIR8NW16GVvF3QVkKWtPvy1Am7
         OFCvwe64BqBMP6IApQXyJu7adN8K/tZoZIa8b8Vy/4SvMZvKVsg6JeUrnck225+fqHFo
         KppReAaDseV5KNbDB66e1x8dqs4AeCvY42webeCzwDsuZ7o4l0RYquHoCip6H/FwieNA
         TQKmaG0OOhmiYrcSKbtVrydHYc6bixANTp6cUSpyTM3ucTbdlwcD446LDy6seEN8vma8
         +kpcxfuwEr+7J8saRYejErxg7C/wqkMH6V/+5cUm9Yhr9EBjK/AS3/4N6HyZ3FSs3YZX
         P7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771984859; x=1772589659;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHViz9uzA0qn0/Cwgl0PYBQiuFPJ7tiOWkbrkXBOjJk=;
        b=bZhY4xh4v3Jz73Z+0pwZmAuCnjV/fUb3Q1dUCzwnQD+PDFo35o/56DLqVsy/1sVmNI
         av55ZsHESbWd2BjDDyq4HvBuDc2wax06l2inSi0SdUsQk3V7JQxDS4JiR85D9YUxorkY
         p8NGfPzoQOiz7HFrrQyKTajdCp0RLP3FNUxwOSCw+P8W6yQhlsVXKoA8u8eLKBkKT4qF
         EC9DOZ6Nz4tnfLs2G2JN20l3BFFDRaQqPirkjyPKrzYAISm/RB15QB7k7QNmlk1z8D1o
         fkwI/au6n22vrIajE5RchPL9/CGNvbZHD5TED+qw8Xue6uo/zQ1Hrfa/MG5CJwSnFXrX
         LZGA==
X-Gm-Message-State: AOJu0YxphNL8g+Gbdm+hnhY/1dQIv6thFYzXnyksVNyiw5nxSrzewZBa
	zZKu5pKf+s2auBXta0caXPu7dwMSkOyPsWL6JkbYZJWxl2Pet4kyzoHMFWWeig==
X-Gm-Gg: ATEYQzzDbr8lWPahSZBLo34e5+AicX3HfzTlcjacWbsVe0MiVA0oWMwzdTazZXzIOI7
	9KnmdUjOCdYO7zFLDZJPjvjmQapbWlIbIgpGS2ORUXvNLJsWO2IWVShbhASv3T74rX74HlSyPBN
	qfRM9NsMVnc/Utr54aC3MHYhrVKV4uQz00wTA6P6pKIYWzLbhnoaYpFOHYex9GZoo1xazGOpVub
	9OJvNyQa38iBtKM55VHoPNxXb7RQeOpIaenwwzlDqG5FO12KheV3kvx6B7KsICPVieH0AHhMYk7
	ri9oG7GoNVw+tuFd1W0OGw01RWNOLsDZPftWvSvnJ+5HM5PM7LgKx9V3hKRHIocDazUa1SyN9LI
	BWtnvfFaJnHwFldSW4QGZuq7oyY/9nrTilaSc7bpVgBnap3lOvDK5tFzYeIFK5sb9TrC+PAQWmw
	+7MINQ6qc+sQPzA9pvfnNOABgUpB8=
X-Received: by 2002:a05:6214:1d0a:b0:899:b7f4:6fe8 with SMTP id 6a1803df08f44-899b8c84eeemr7867616d6.65.1771984859146;
        Tue, 24 Feb 2026 18:00:59 -0800 (PST)
Received: from [127.0.0.1] ([135.232.211.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899b894a227sm5438346d6.8.2026.02.24.18.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 18:00:58 -0800 (PST)
Message-Id: <pull.2211.git.git.1771984857879.gitgitgadget@gmail.com>
From: "cui via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 02:00:57 +0000
Subject: [PATCH] fetch: fix wrong evaluation order in URL trailing-slash
 trimming
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: cui <523516579@qq.com>,
    cuiweixie <cuiweixie@gmail.com>

From: cuiweixie <cuiweixie@gmail.com>

if i == -1, url[i] will be UB.

Signed-off-by: cuiweixie <cuiweixie@gmail.com>
---
    fetch: fix wrong evaluation order in URL trailing-slash trimming

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2211%2Fcuiweixie%2Fbugfix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2211/cuiweixie/bugfix-v1
Pull-Request: https://github.com/git/git/pull/2211

 builtin/fetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a3bc7e9380..306138c6e5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -722,7 +722,7 @@ static void display_state_init(struct display_state *display_state, struct ref *
 		display_state->url = xstrdup("foreign");
 
 	display_state->url_len = strlen(display_state->url);
-	for (i = display_state->url_len - 1; display_state->url[i] == '/' && 0 <= i; i--)
+	for (i = display_state->url_len - 1; 0 <= i && display_state->url[i] == '/'; i--)
 		;
 	display_state->url_len = i + 1;
 	if (4 < i && !strncmp(".git", display_state->url + i - 3, 4))

base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
-- 
gitgitgadget
