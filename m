Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9304713A41B
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 23:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713309716; cv=none; b=TO802nk9uN9cnM7L7jEk83G2D2Whp3BIOJzZ5CbeOdToIhVR4ki/z+DJ01/7EboyZf40vTqKKhCyg2Fo6Uu/AVOUA1VjCbNDDbye0QUKCptc1ylEgViIjsI/pEVuNOdl+pqfAZvhwE0iqY+ljQYfalihQ6KAnpVNwAaTPw3Z4PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713309716; c=relaxed/simple;
	bh=XfLNxvKN0rUslLVP7bMviWsZMp8NKOOlFQ/Ie1MkV7w=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ogYfpDo/WXPDagtGZStxLFaQ5lIiQtD2CYwkTRFF9l8J75thClyPDSj2xGN7dxtzwaZ95B7i1baBTM+VETz5OsVIZLDwvn3M6oAEcCMxEEGaVaK92pnUR6swba2aPHUIuedzJ+zQgeG7xL9Bp5dFoSzdUNgyG7E59rUtdILn+BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffmdRPgZ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffmdRPgZ"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-347e635b1fcso1805494f8f.1
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 16:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713309712; x=1713914512; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GEhZrlk2IMrp1WpY3jsU314GTeqhyVm+JURLrJ0sDGo=;
        b=ffmdRPgZz5XMz545Flf6AeUfIh5HIDhwj0SUfe59ZvF1PA4OAzoJ99IKZuVeboyOLm
         75DIOk170waW1tcRjBZKuWwkyvdMJoo4jLypqA39VQ5dMXUToPU1dpkTaPD1OpArmmzZ
         IiKfceniH8K7o3yvy2HKllsa9cSmCVZlc4IisRhV5bI4Ms3EumtOxII9uHTNKHrpJE1G
         M17BbRJ15KgB0FC+GIONtZOyUafa1E5jAZWOsicVkQkctmXksUuLDgFtP18HdrmGlSmD
         AQfqqVv/yx6KhNL4BRPL0+zcj7eiK0py+gNznVNMk8Z34xwNprRGUbg0T6hhK9txEZpW
         cN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713309712; x=1713914512;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEhZrlk2IMrp1WpY3jsU314GTeqhyVm+JURLrJ0sDGo=;
        b=WK/iIuvs52av7DWOD6/xZ/p0eO29cyvovtyboUV6fA/KPTe00StBsBRiRxcSnDvki/
         0SgOrni1v6TE2Cr6KW7wvbtC9dnhPjWFJeYuc0AuzYWCuiUEiJ2Vjwi5abJTqVV85d+S
         U29hhPzsMOVPRzGTK/BfolIFhqxZ58bqH93a+RirKIXSMXLf+6rvml4RTlGSD3xVCzyE
         8RPESutkrn860PlK4rMR8D2WwvN9MSg48B08kdY6d8P7VTUypeMWqsWJaZoEwq5xzKXp
         YZ0vK9vt2zzKKT5tNV+k+0zVqNip+pYlxov3n7RZ4e1AqG5XlX/FoA2cVXFQXqTqwK37
         qF/g==
X-Gm-Message-State: AOJu0YxrFGuXcxCduw0v6tmwuoxhrhST8wZDKDzLbTDBaXdCUJXo1TIq
	7GNF2SJnV7/Gux4jgdTZnRLdA4dkQMutp5cx1QOyu0x+2KicpUB6q1uMxw==
X-Google-Smtp-Source: AGHT+IEpzEWAIEh3OtP60i8dJfm+2xF+EQPVoPmlj+a+4DVdjFJPwycYj9HB+Y/XeQ51xo8aJoAeUw==
X-Received: by 2002:a5d:59a5:0:b0:343:b295:4d99 with SMTP id p5-20020a5d59a5000000b00343b2954d99mr12447131wrr.56.1713309712068;
        Tue, 16 Apr 2024 16:21:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c358c00b004187f537394sm446547wmq.8.2024.04.16.16.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:21:51 -0700 (PDT)
Message-Id: <pull.1720.git.1713309711217.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Apr 2024 23:21:51 +0000
Subject: [PATCH] mailmap: change primary address for Linus Arver
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
Cc: Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Linus will lose access to his work email soon.

Signed-off-by: Linus Arver <linusa@google.com>
---
    mailmap: change primary address for Linus Arver

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1720%2Flistx%2Fmailmap-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1720/listx/mailmap-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1720

 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 82129be449f..18128a1250b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -152,6 +152,7 @@ Lars Doelle <lars.doelle@on-line ! de>
 Lars Doelle <lars.doelle@on-line.de>
 Lars Noschinski <lars@public.noschinski.de> <lars.noschinski@rwth-aachen.de>
 Li Hong <leehong@pku.edu.cn>
+Linus Arver <linus@ucla.edu> <linusa@google.com>
 Linus Torvalds <torvalds@linux-foundation.org> <torvalds@evo.osdl.org>
 Linus Torvalds <torvalds@linux-foundation.org> <torvalds@g5.osdl.org>
 Linus Torvalds <torvalds@linux-foundation.org> <torvalds@osdl.org>

base-commit: 21306a098c3f174ad4c2a5cddb9069ee27a548b0
-- 
gitgitgadget
