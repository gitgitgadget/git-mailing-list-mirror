Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7E82C9A
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738414822; cv=none; b=UHQx63N0m8nzJuw1a/AxkUkb2GBUoH5E/6PNLsQviDE+fB5Z++2YWlbkehFz8Hzb/x7QO8dblp8s19J+Kr+HUYsLeJPMuLcmU9rG8wQQVUysJo4BpHDVzKNVidIl+XlY9gP0EUugkR5qbxZTQVF8upbC0goSJ7meaih8FhuYATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738414822; c=relaxed/simple;
	bh=6S2525yqhyKpImexYSk2G8chwmuxse2NrXbTBcWHQG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqGU+yJbaLVK81q5IGLZXeWRovhw6mQ4M2T2vIF0ed8UnjqFxVZubWQ3PbW0I2FdX/3zmd7fR1gNB+Tuo5hNqt9KWRVVf2uhLpvozw7+QHhlMvEbpR9x/8JurIDy+0v2c/YUsWjO2RUDYOt4qRPOJqAX/gL1fcSUaktpm7H5Be4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAtu6/QP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAtu6/QP"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2165448243fso49611385ad.1
        for <git@vger.kernel.org>; Sat, 01 Feb 2025 05:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738414820; x=1739019620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=05A71CPFVr2XyPU29tLrLK9fP0y0KV4YLIDAqdK22+w=;
        b=NAtu6/QP2RfyXIBFVhmwWtSpWjG86kdxAyiGGsiTGjqsH9r783QrRlOeZRyi/LPsqx
         rynFJ3Tw3tdERCpQVrnVZlhnrXIgyk7CiQY/GwFQr7wxHEFbfH+zjP86DvI08j6k2Em+
         1qYCy3pIfMyzzIbx9VeMJfHjSTU2VJL7SdPi9DyzPz9mJSDM1n8fpg/s1TiTYsQZ8ywS
         0/ZiMX3qNfbnRXLOicM4EcWBud17fEiMamPgGGDcV6j16aBA3HWa7cVdtbHazCvK0Vfg
         ZlKgpfW/OZ2pCsF9dGJc/jLHhtbhxFLepfIY/Z1s6SLeXTfPO53TYTDfezNQ1RW/wHda
         FepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738414820; x=1739019620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05A71CPFVr2XyPU29tLrLK9fP0y0KV4YLIDAqdK22+w=;
        b=nm48z4Nz2FZ3Ju4TlQBN+ds8NPFhUOy/ba5GKy9XCCyIo+w0sNWlNbkH5Dgy/mcJlV
         0UTePe2LIn6bis63Iicdf/9GEndGqViewa4H7nFd7nvzv7Y+zxgqOmHht/3NXbTibXEV
         fyfp2oE98MhF7l/gK24ujU37DL+ynhmWPC+tMfOmWgwSZE3CeB6wOA/RJtYEsbkF1KKH
         nIaicn589Jh8snDyhrJKfGylzHQUVvyy9vAnkjxZbS2xcAefU8kn/rCwVT6OD/pavR6U
         X9wsAG1ID6me5Av8X6KNg1ZspLuW7pmGxD24WY6zxfGQAh4h3sfFl5+maSK7dAv0H4U6
         xYoQ==
X-Gm-Message-State: AOJu0Yy8R9HgEIyLMOHMYu9lPRJsRA171fOedvdFUsbIOeirEi1gj5d1
	mFPw78r5abp65zdQoyBgEMwH7viIA3QgztXWFCcU5/YX7xxze7/T49wCPQ==
X-Gm-Gg: ASbGncu3XXGNLNcxGkMFV9Y2jhHWyaDI7m42ykMIsAqt1PpUiuvfMzr/nyrG6bNWe/g
	cZpMichJ1n/EfSQ47qgxfvU5SPvJPWv+dDuRnXbth77sYKJ6VURGvuxWl24DEIvgA8YGXkr0RU/
	9/zHq60D7o+Sgj+EG7SDmzpEqLJ2aq3SfjtIxhgFExTchXhJTHg/lk3JXFr4WzTHqwg+Z8T6L1l
	gepeHeH4eA/ocy5QQL35U7azD+hSIqJL3w7rEpqFjb6xIqO/wNWWnyRwdhzsT8VAmPG8HpIgmf8
	j6IncgYM9R+VOPFpMpQOiEizTQ==
X-Google-Smtp-Source: AGHT+IHhpEtAzSeTpd7HG3lV+aRWBASuGnpOVXTOEwzaXwYwX/Hq4CyHXF9yzpJ39R4odnh2PJe/8g==
X-Received: by 2002:a17:902:c951:b0:219:d28a:ca23 with SMTP id d9443c01a7336-21dd7def0c5mr248656995ad.36.1738414820511;
        Sat, 01 Feb 2025 05:00:20 -0800 (PST)
Received: from localhost.localdomain ([171.60.225.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de33205edsm45287155ad.237.2025.02.01.05.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 05:00:20 -0800 (PST)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita <dhar61595@gmail.com>
Subject: [PATCH 0/1] Rename all *.txt files to .adoc in Documentation
Date: Sat,  1 Feb 2025 18:28:51 +0530
Message-ID: <20250201125851.21079-1-dhar61595@gmail.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello, I am Moumita Dhar . I am a newbie I tried to do this issue because it was tagged #leftoverbits . This patch renames all `.txt` files in the Documentation directory to `.adoc`
to align with AsciiDoc formatting standards.

Moumita (1):
  Renamed all *.txt files to .adoc of Documentation

-- 
2.48.0

