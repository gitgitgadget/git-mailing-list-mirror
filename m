Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09F33803E0
	for <git@vger.kernel.org>; Fri, 15 May 2026 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827198; cv=none; b=jEllqlfj+rnqRFzWcR3I8G9WfPax4vNT3QSgQuLj5vkXkUlZgYGETYGiEoOnGFl5CbwaqVnW/EnBnBMIE7a3P727oFObPdLsIC+HXD/Gre/4eI/yUWGrBx/J4W+9rd/wrhL9emhwdU1f+lQWiDiAzBwi8GxiSo3/bFk2mWtm98g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827198; c=relaxed/simple;
	bh=qU/xJEucvFrwvBNyG7MmwW4+SReriIqf6RVmKtRkjuk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=GaIM9XmcJz5ngYrt81G0gJuWUzhaazGuMbgTJ+Hw3bXVSwNmUvYBKuAQI9UHPm+bjbB9oiRCxorQ23SlPnEKsFayRRtBS8ArQjVk/fXIWro3kkupq2maMnNpgqLm5V3jkwDao9hPYYwiZr1MVifYBEqP901fmR5jfq85vR/IjFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWD+2WlR; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWD+2WlR"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-134ac81c445so659434c88.1
        for <git@vger.kernel.org>; Thu, 14 May 2026 23:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778827196; x=1779431996; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DYAIQNTDA4GeQEhJuen53ixp6OZWYg8rdAPvEVwoq7w=;
        b=aWD+2WlRacIDZbyUvg1g4iEpohEbqcU3uU0RLcDFSuhZQXKh50ceyZfZkXnOoUqwxG
         alEauxVmdvZ7YgB4xd2YPcIVAYWnnYpUAyMAm1tTYh6OFEalKV7QPLTPVWeLrvk+8QYK
         Wy2po6kbxwcwMOYeKTojAmNd6C8rTJjNmXtyn30kReeltjxmTSdmLz/HOIFes5vZXGpN
         n+KdS/KRDe91jZ/h8aLH+F1y52gr08MWNzjnP/AGmWVK2iTmW/SefLxjIUBdppB4O13f
         ks7uVBKb9q7nZtO5WGSiqMho24wWzsskwdBLAglfsKmcWnysw52vTvhUyZTbv9ods5sq
         g/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778827196; x=1779431996;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYAIQNTDA4GeQEhJuen53ixp6OZWYg8rdAPvEVwoq7w=;
        b=af0VjO44ePF3kf2uemW0yG7wBTYbNVXQwEAENGrT6ZUq2CEMtKQlGouDndRkYGaE6+
         FPMaklHmdOpf7MIwKl3qrBeadWzPh7ZYUpWqT6LX/CGrHk4pUedSpyLgxTZfICXDmVWv
         S/VY/c+dJDMFr24iuOguVU2v5o8RPG+nU+t8VdDpKkbXToMtOyu8FHYvvQtjOtU6JAhA
         M9DHyfYsvD6q+U/v7Mdy/xyT+Vk5zOHu4qZ2XxyhxP3NWNAWHt+RmakDtuqGizUWsB4S
         LFcUJIRwfmLg8++n80TwzHf3AUDYcWtA+WyNpL7IIiBf9G6wuVU/STbFVSlDNDz8VkIb
         0Y6Q==
X-Gm-Message-State: AOJu0YwnrXIv65mstrXYcpfZaI/SIRZUoxmxxio48texMC1+PS0BcKrp
	31A8hUQcYZuzo7KoYPaDnJOeoNDz08/yJRHrVGRBsjODLmf0GFi5FFOMK/fyLQ==
X-Gm-Gg: Acq92OE7BRrkTfKQIWH0ViJxKe9wd6zLAjx6wxot54SaeniRZP37Ch37FDTctG9phCM
	lIDtl2LBLvQoZwjyO+6W77bJk0CrNyVvm/U+s46a51ICV9lEM7XVLiPMyO5b78pp//RDrurRNy4
	/hJ0m2KNhajegjJeAsMCp7iAJQPW0CaCDmf01J23/XxBc9JvdHmvI/PIUjyGfa9JEE9m4QljrEc
	q572fytxci0x6nMv1W8bXjjA37Sq6RSpQlcH4T/pHoCcVkmYJl76rwBtxjicC36z6OaQA6t+vEp
	2TlI/5KebDsSdWLRDjksp0vNzV9x0xFxp4SCZqC2X5kRSqXZEwe23O4pBUEL3WPXbRmnpXplm/V
	OGZJsXm2drBWSbwBeuHVYOHel2WMuryuLw8QcoSMuF8c3aSLIeQ2Pjlfy1dpC1TBtxzxXoMY45x
	5gD8RsLh3KPpus3Kbmrm+0qL82oZTA86zvLBgnphs=
X-Received: by 2002:a05:7022:1286:b0:132:1e45:a21f with SMTP id a92af1059eb24-1350483e884mr1054776c88.25.1778827196203;
        Thu, 14 May 2026 23:39:56 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.216.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbed531esm8089285c88.8.2026.05.14.23.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 23:39:55 -0700 (PDT)
Message-Id: <pull.2303.git.git.1778827194448.gitgitgadget@gmail.com>
From: "Ethan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 May 2026 06:39:54 +0000
Subject: [PATCH] connected: close err_fd in promisor fast-path
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
Cc: Ethan <ethanndickson@gmail.com>,
    Ethan Dickson <ethanndickson@gmail.com>

From: Ethan Dickson <ethanndickson@gmail.com>

connected.h documents that err_fd is closed before check_connected()
returns. It is, on three of four exit paths. The promisor-pack fast
path added in 50033772d (connected: verify promisor-ness of partial
clone, 2020-01-30) returns 0 without closing it.

receive-pack uses err_fd as the write end of an async sideband
muxer's pipe, and the muxer thread waits for EOF. The same omission
has caused deadlocks there twice before: 49ecfa13f (receive-pack:
close sideband fd on early pack errors, 2013-04-19) and 6cdad1f13
(receive-pack: fix deadlock when we cannot create tmpdir,
2017-03-07).

Signed-off-by: Ethan Dickson <ethanndickson@gmail.com>
---
    connected: close err_fd in promisor fast-path

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2303%2Fethanndickson%2Fconnected-close-err-fd-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2303/ethanndickson/connected-close-err-fd-v1
Pull-Request: https://github.com/git/git/pull/2303

 connected.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/connected.c b/connected.c
index 6718503649..7e26976832 100644
--- a/connected.c
+++ b/connected.c
@@ -76,6 +76,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 promisor_pack_found:
 			;
 		} while ((oid = fn(cb_data)) != NULL);
+		if (opt->err_fd)
+			close(opt->err_fd);
 		return 0;
 	}
 

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget
