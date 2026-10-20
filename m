Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491755;
	b=W+08SZ/+j3K4WNzIS8BQ7tOp+pAxsp/kp/aCclJitvoYRm80RkI2TLC8k/Ou/56WTPoW
	 Jbtce1lK4hK8nCWltWLBW3ZUpU/Jk0BdySnGZbIJxNZUL5e4ytkGnsHaOUsC72LVs2tYf
	 jGqgEV5ARaZHI2Kke6AL8JwtP3roR7VJMCTtqp/fgFipXey1umx824jdU0/vNKstnTuRV
	 2aaBgK5ZONMkd4BVmOXtGtHngwImkz3NHTvegs8376cibmpRAUnb8OXkHLUfLxrGGsA8V
	 7a7+bw3nK1jY1ZeUEqPUnaD5JjqHsMV3N6/hPsn5B5RySD/Huf9jTnLE5rHaZkYgeiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wzEAUhezHjGqaZ1mh+hIZMEfDZVlJZSS6PqR9hBk8NQ=;
	b=fAZY0UchIj6GvXv2YWZEpRKRNI6xREMNe3apeutNdnpOUfs4wCDlT5VbdoEyMb2grJ1B
	 wPLrKNPstQQguC7imV578YUq6puyC7WS1s01ZEVFun6gnpsHUn9Fp9rb0hakXjpkblIdN
	 OqYZUJ2kt7za0C8EjZvsY6Jsk9iTHMzMOB3xn+DtO8QQo7R5j/VKTtVRTSMVZ2e2inExK
	 fsX/wCyFfjYfAIDhxkLXtLniALnFdg3ALI0CEv1y8Zr0IEk9D8zLQtiV6yjUibSYx4/a2
	 gMII5mK/fGzR1c5DM/y1fx1na7N9G0Ytj+1OJ7VZ03bw2B1ClEFin+IJvLg6NmIvCCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H2FLtzxw;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CDB606A31D
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 10:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34CDB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H2FLtzxw
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48df4f540ebso1703067f8f.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 03:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491753; x=1793096553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wzEAUhezHjGqaZ1mh+hIZMEfDZVlJZSS6PqR9hBk8NQ=;
        b=H2FLtzxwoevn8L4FdWQ3a5t6JmguU30/C9k5XzQqtvIKmpqQUxTpMVTd22eRfV+yUB
         ZQCZgmtW7EvQvNnNSyF/zRIB4M9DIGMJi0HjFEbFsNWrBQ8ygWeKqhouGFr0BgOpVvPZ
         nEMj5gOgbxN8IhHNUmdpAMEWR1cRNbdJ9GLV9tAYaD5Htiv4wqToF9XGFoDPO+eT+WvX
         fNfoSpFdcMN6EnpN4lqxONR+t3Zt5/nPAfC2WwfDyndt5nuSOcr4zt6U5qB7KjexBXjf
         RHo31/qeBSenrpiqgVANhNwIymuVBShxlnXc4WEGV8JjkXsNILjGwjKYpGk/LwaL/T0p
         9eLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491753; x=1793096553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wzEAUhezHjGqaZ1mh+hIZMEfDZVlJZSS6PqR9hBk8NQ=;
        b=xDfF//l8rJApYwN2tktmnUQN1zORukS6cX3eOy6ryH3YRLmcbPaaEPxGY6ZfQZGpE7
         gEIFFfj3aVzPLExA2iG3bPK1RdbW60qDrkyjJ/n4/KsjpAldfAiXjMU//UTfLjEyDWCw
         KrfnBmkJqXeNDsySBTtYd+qnl7B23UNYXgNBsMU5ADYBfcL0DZgQWD4JuzpCmox5Y2v0
         jfjcfR/JnGzk8ueGEqhDEQbD3iJQtGARWMxQ+AdGB0zfg83hDuE5lGOgiuvI3bqQkFn5
         /QxxoXeVx1AtksV9UZ9FTBZcNvhEpp9p/h5bBycH/uYHvAwOlRvWL70ZZo6EEZd/pP2/
         8/rQ==
X-Gm-Message-State: AFq9FYIXvRxvDkl2QptjcWOC+MzAHLGLmiM9GkltY0DR/edgeWhBXKex
	JrE09EWvVuJ77zUTbLb8PMXHOGsrcasRI2pLeUOMJtUQVq1y2sCAtG9QmNPSdKnV
X-Gm-Gg: AYBFou0To16UIubhMeZsY7JXSaYqIW3VCWdXIe2aAjlleg3zaHzeYarWnp+6Co6Ndbb
	rNuVnFObiZn1Moza1jj5175WA7kO9412G/R+I8lKUgF1emdDakyOMjX6+lFT686vfTudxv9AjhO
	AimGpmxBtAnB5HiW2xD235XRmybz3wIqBeO4KbuljyWo6JTGAHmYhi917Er3lpaPpDg6DJFPSK5
	5+c2/AYzDAVsQal7sEzBgeRrUPpTBOix88p2Vvvy1sftemfeHG/GW5QRsv1coj6G6mUhRASsbUp
	BV3FmdvHnt1Hm2llpHnsAMiOk0Sjq1BPFC5riA9EzBfmxqYHlLmdQ3FvJVDg9URgOwdZK1NcFeL
	kWjw37iP79ZlKmeUcAKaFYuvQZlcaf3yNKCi8N+hhaJBmGYfyJck8HvJeXPjcKSJab/RIIp5Xxo
	eDVH15bmjUnvxcMCrgQklRTkmYVpUOPrpV4uJYrf+EKzN5djKYy2bQXTkD9hX+UCTUqE99mty1G
	QFVsb27UOd94qOW9HlahmI=
X-Received: by 2002:a5d:64ed:0:b0:48d:f957:bca4 with SMTP id ffacd0b85a97d-48e07fdb461mr22062558f8f.44.1792491753245;
        Tue, 20 Oct 2026 03:22:33 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d6db78csm5254913f8f.2.2026.10.20.03.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:22:32 -0700 (PDT)
From: kerylefondji7@gmail.com
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	Keryle Fondji <kerylefondji7@gmail.com>
Subject: [PATCH v3 1/1] archive-zip: refactor 'path too long' error message to use Q_()
Date: Tue, 20 Oct 2026 11:22:10 +0100
Message-ID: <20261020102210.829-2-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020102210.829-1-kerylefondji7@gmail.com>
References: <xmqqmrs92y4c.fsf@gitster.g>
 <20261020102210.829-1-kerylefondji7@gmail.com>
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

From: Keryle Fondji <kerylefondji7@gmail.com>

Replace _() with Q_() in the 'path too long' error message. Although
pathlen is always greater than 0xffff when this error is hit, Q_() is
required to support correct translation for languages that require
different plural forms depending on the count.

Signed-off-by: Keryle Fondji <kerylefondji7@gmail.com>
---
 archive-zip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 6f73ca6d58..9df49ae160 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -328,8 +328,10 @@ static int write_zip_entry(struct archiver_args *args,
 	}
 
 	if (pathlen > 0xffff) {
-		return error(_("path too long (%d chars, SHA1: %s): %s"),
-				(int)pathlen, oid_to_hex(oid), path);
+	 return error(Q_("path too long (%d char, SHA1: %s): %s",
+	   "path too long (%d chars, SHA1: %s): %s",
+           pathlen),
+	       (int)pathlen, oid_to_hex(oid), path);
 	}
 
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
-- 
2.53.0

