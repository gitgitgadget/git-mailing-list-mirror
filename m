Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AA02DFA3B
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643708; cv=none; b=s34Rb47bBuOrPnWYeSx9QJTVTcHSYzPu823etQqUdWpzo4FJfXMRRkiBFN2+7tuTVRKQDtVoQtoxGdetdG1QO6Cc2I3VhpPUcHmgS13/eNCHWQkQKi2udtoBQO0e2KpFSa9eNRDJBnF297bobkbSltjeGYeBaj8QIc6V5CEfCJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643708; c=relaxed/simple;
	bh=XJVaS1ujYL4eH1b05B+A+SYYSy1pYs8zxzicw79gJAk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cgIg43lhy0l/3b1xcD48ab6vWaUs7cKbkZRMA4IPMYG24FeL3R9Jz4tEKcbGdaa95bspdK333/3iWY2Wfg0rx99hx8idZUyV1Dj65O3ODj8q78mpF4/Fms4QfBG+eDqAYF8V7PUU7Luz3cIeQOLU8KfxNzAwMoagvfuxivlAuis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8IedeJC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8IedeJC"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso6030330b3a.2
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744643706; x=1745248506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F/3o2X0/Y9ajz5hHkAhptCmYpQ9u9SNmIX6Kdw7VG90=;
        b=I8IedeJCXETCj9OJ+4uuVJ5byM4kTn8WL1xSAOqQi88bOmP51Iyriz3WMV4+c3xIZH
         7aunrHOlL3IEH2x5U6qseGckfs4oz5hE4Wx9R3VDNHpUyVNQIeDfev+7Oh51xw2E1Rl9
         BYcbQWs1cgQVzUkY5tJoirsCMhPXwhEIvSVZ0yA0YfoBGvMKonE/mVTVrVSl9n65wykQ
         iLhlXG0cjfmm8pNW9t2e4/W1HTkhiyKJLKtj7rGbnxnkSy9r9s19l3vzUzWfFxcaig4z
         qbvGZrkkz4g3Bgo35H6tJXg91Li+ocaMvMa+6wIMOVdnobXPVLPScn9B154R38yt7OvC
         fVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744643706; x=1745248506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/3o2X0/Y9ajz5hHkAhptCmYpQ9u9SNmIX6Kdw7VG90=;
        b=QTOB3h5mfR7uLnYUls4W8N0ecRUk17Dk1EYSe9PNfP1d8U9niI+hnCZNI4xyE6v424
         1ZWlmzS8xdG8Hi4JP1TWwODtcL8AkaGjnTszTlrBlceB/nsNnFfC8oAnlW/nTsqlNSWY
         Kct6DH3O+MTNQ+22pYCyZyWWdW/VovylS8qs4d25RBjegWmFUSsX38fglXZ2/E3pIgrh
         P19CwpfMQYtDk/XIyCmB4u16eV+8mm0BD0FKPEjBwYKSzYz1gvkfI3xYWinQPuxzJk3N
         IiK0rMNYegU7WAq/IMiABalXiCAfVVVAyvg7EhC12V4Wn19fL45iHv293Mu39k+yDhsc
         8TAw==
X-Gm-Message-State: AOJu0YxKM/ny6xSQr3aAx8XXMiX2qwNdwvkGLgGJ1nAnFgYiZQNRAn2I
	G4d35Wb6a764sRTO3obSPeVPscl0FBmgFcRUn8hhxsz7YYHM/opQ9d7dBA==
X-Gm-Gg: ASbGncswJ+iJYrlkQuWsPiFrp1kR3Fpn57HS/P189YbnwfFrXY2yXDSsLTw0IyXCjLh
	0qQQfGPLLE8ZOzv8AC5mpITZlyBlwqzCn/qAPRFxhwxE+iFe0t1oROUZYt119QGIXO4hUQbQXCv
	5ekbXztXiquQKO1tNIS2NMKCKFqeWIX03xYxGN9eS1oSLyyRKNAKkpvPnPeCCP5ENuRID09SOcP
	0oscGWP2ZS5w8yziX5GN/zxOzNIGceH1542HYcmHoFKH9rSHj0sZJTEMBH8II9GsIrEpNR4DFqb
	6g8mO3JgIn8zByWvGbT1Nes558lQiwVt+iBe/N5H/sryhMPTpH1K+TF9rwpg5TnoHwTNoFbRrXV
	3Rpw=
X-Google-Smtp-Source: AGHT+IFCgXy2QSYkRNwa0jj59ngc/K3PA0/jbaequWjPmXlvNdKnJVSy7BlykdVuGRb87PTON+YydQ==
X-Received: by 2002:a05:6a21:900f:b0:1f5:5b2a:f629 with SMTP id adf61e73a8af0-2017996f566mr20982116637.30.1744643705843;
        Mon, 14 Apr 2025 08:15:05 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8e7e:85b7:aff:5cfe:b6e5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a2d3a4d1sm9402439a12.57.2025.04.14.08.15.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 08:15:05 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH] revision: remove log_reencode field from rev_info
Date: Mon, 14 Apr 2025 12:14:38 -0300
Message-Id: <20250414151438.22232-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the log_reencode field from struct rev-info, as it is not used.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---

Just a simple cleanup patch removing this unused field.

When I was working in a previous patchset (this:
https://lore.kernel.org/git/20250303220029.10716-1-lucasseikioshiro@gmail.com/)
I noticed that this field wasn't used anywhere in the code.

I also saw that it hasn't been used since it's introduction in 2006, in
commit 52883fb.

 revision.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/revision.h b/revision.h
index 71e984c452..87f8d798c2 100644
--- a/revision.h
+++ b/revision.h
@@ -292,7 +292,6 @@ struct rev_info {
 	struct string_list *ref_message_ids;
 	int		add_signoff;
 	const char	*extra_headers;
-	const char	*log_reencode;
 	const char	*subject_prefix;
 	int		patch_name_max;
 	int		no_inline;
-- 
2.39.5 (Apple Git-154)

