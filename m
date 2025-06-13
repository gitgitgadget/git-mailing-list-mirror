Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27580372
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 16:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833582; cv=none; b=X9iI/rikMY30q3BJ3FPYT7ZJhAg7RNoDmFLqGlqUmNZYGaOOafMA6/wK0CezKzJIUiwJkWYO5OAASbYFTkLyZNuaJNyxSfD4ADXqU8V5EBEg2nRlggExpVe1R9cR+T+E/6eHAM/iBclYCe1t2iwJxN5P/MWBIZtvZ+fUYSgAwyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833582; c=relaxed/simple;
	bh=hAGLuXA4XBFIgf4TairEs1r8NeYLuW3+z/omLLHLO5o=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=fers2+8HN9lZoIF2vYejFHrKQp9PI01f2we91kOWo7x/F4SIVxzWRCLRZWD68kWPVow3gRlCuJKuJxzQY/DzI//VQXD72GOkI3vfQOYDwASGVedF3sUcMS93YnMw75xCQ4hL3uzFO7WvjlarH+KAuOtPu9DanoAMXLUpN66bqNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AknDYL8g; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AknDYL8g"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so2485353f8f.1
        for <git@vger.kernel.org>; Fri, 13 Jun 2025 09:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749833579; x=1750438379; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=APiPjnAQ7LbAtNCO7LrXRPdQH5CyjggQv7X/mYrdsdA=;
        b=AknDYL8g8ckajTUODAyrCd4q9sD5swlhezXFIp9qlCVlNgfjHChxjSjKQfbSjK93lk
         jA/ISzzkP2rc7PJ0le7GKtgzMFPNUyPEkvDsFbAZ5U+Mnjt5RZ2CXQMHOVXVLz8KboQc
         +qJsIMpb+ksXqWxGl+A9NWuJiocIe9SzBlWO83QsKNM+MIpZSpIT4/gJpuBlbBB2f8gz
         ROr7XhdjFWNiqf8uOisTDfX4DcxN3YDYyqWqnByAzvu8Wc18Yt3I0lD1q+HT6VTpCHF/
         J7//47rZYAz1wxyFLZALp1oBZVGN6oL6dJVBCtnarAB5I9yVSso41lALJPPS5ujJtARx
         h4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749833579; x=1750438379;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=APiPjnAQ7LbAtNCO7LrXRPdQH5CyjggQv7X/mYrdsdA=;
        b=mBZ2ux/StY8x0AMXdZ8MHKrFd7zMQbVgYa1kFIJdxmAgG+YB5GVHl7PAmtwELZUnY2
         OwzxNptHNRFQkn566bPC5SeqWjbQCwRms4QsXY04lKHUBxt3NomUobOS72JZpakY6Sr3
         Kr3KNCzzu9HloyJfKuQL7Za6B1Cu1vjUiWfn0E7OT3dJL2zbCXWlsAJvd9K712dxwE2N
         Cww54BkCrgB04UDpWbzlzXeoNOLW8nn+GXJCH3ABwGLCX3KT85u2S3sc5Kghx6+U9Kwz
         9kOeut4dAczMo+dCcINMZ0efWsv02Nbkwy+8j3QoC49d/9mGe8TybVbRtEgxX4swR3gX
         yxMw==
X-Gm-Message-State: AOJu0YwoahcfJPkuV0oHXS+Pi670pFboFEToaeXthAhzEBGhzhNY9QyW
	COOO6Fd2o4DDUIDfAFAOEk+EBlV8gCRwOpkPfoYpulKQ2Zxroe6717Xo8cQkhg==
X-Gm-Gg: ASbGncsi9uB/72HboywSr1Y1ywUio9t9GL29qGT69R+4E5Dtdo+0SVpNPJSxcJciFH8
	JrgaVH93H6rj5dXUwXMb4jNkCmCNKwi6izAFCSyoYUgITj+3DnzACZSXzHPkM6eCwRSPpw4zusd
	21LiIuVeKOWsjzEXRFDb/VIA+XTXdg0IhRMTGlF9cqhfU2a4IM4RK+M5u1sIhWRLe4sOTKa8uWU
	q9qg9U1aArT8f2aVqi0uueRaTtm0vyPCMcjtp6D3ZrOxhsKkNURiH+5b8I+w0jl1gl2pUCAKhuM
	KjU6Lb9bhtTrKoq0aB1cLTnCa46jOtUI3hEVKmoRqv9IzsgYDbmkackVHytBubo=
X-Google-Smtp-Source: AGHT+IHoklw4beqU71wM8GGoUIbJsyTjLNx5pH+62FnW9asglF8fieY/5hCpxYedcwJ7im7xTjrQOg==
X-Received: by 2002:a5d:5f8b:0:b0:3a4:da0e:517a with SMTP id ffacd0b85a97d-3a56d837d63mr2059896f8f.23.1749833578936;
        Fri, 13 Jun 2025 09:52:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a73a7bsm2911552f8f.36.2025.06.13.09.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 09:52:58 -0700 (PDT)
Message-Id: <pull.1997.git.git.1749833577767.gitgitgadget@gmail.com>
From: "Alex via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Jun 2025 16:52:57 +0000
Subject: [PATCH] Fix memory leak in function handle_content_type
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
Cc: Alex <alexguo1023@gmail.com>,
    jinyaoguo <guo846@purdue.edu>

From: jinyaoguo <guo846@purdue.edu>

The function handle_content_type allocates memory for boundary
using xmalloc(sizeof(struct strbuf)). If (++mi->content_top >=
&mi->content[MAX_BOUNDARIES]) is true, the function returns
without freeing boundary.

Signed-off-by: Alex Guo <alexguo1023@gmail.com>
---
    Fix memory leak in function handle_content_type
    
    The function handle_content_type allocates memory for boundary using
    xmalloc(sizeof(struct strbuf)). If (++mi->content_top >=
    &mi->content[MAX_BOUNDARIES]) is true, the function returns without
    freeing boundary.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1997%2Fmugitya03%2Fmlk-2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1997/mugitya03/mlk-2-v1
Pull-Request: https://github.com/git/git/pull/1997

 mailinfo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mailinfo.c b/mailinfo.c
index ee4597da6be..e0ea358311f 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -266,6 +266,9 @@ static void handle_content_type(struct mailinfo *mi, struct strbuf *line)
 			error("Too many boundaries to handle");
 			mi->input_error = -1;
 			mi->content_top = &mi->content[MAX_BOUNDARIES] - 1;
+			strbuf_release(boundary);
+			free(boundary);
+			boundary = NULL;
 			return;
 		}
 		*(mi->content_top) = boundary;

base-commit: 9edff09aec9b5aaa3d5528129bb279a4d34cf5b3
-- 
gitgitgadget
