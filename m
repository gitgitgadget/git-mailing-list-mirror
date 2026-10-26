Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793041475;
	b=itjBKQdi11F/8y1Fmt1wMQcamx7ElWULl89PpbwLN0Mjt+y1+/RAl+sAm804F/rLePOk
	 FQFSlfr4NOaQOupfeONlK28GRrno7ogLknm+1bFaXzoj6hVPsjK5CKDKSm1CefAWw4mmH
	 4TbG4F8ACBc5sy2DmrF1/12de+MojH+i8JefUPSNtCd2N60VV25JvwTNrxpUPxmkG1KN7
	 ujif4EbuJULqixVrAPZIQdPG61E5FmhDJVVg4HPSJk8uwQ00ulsqoDMySh1TlN66TN065
	 ucGgFr1shMLTuYFPhhTM+np2BwgBjsXz3nuyx5PVI/AgmchZT8wRKgSXH45vTd9Qgsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793041475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=u1mJF3TM0e2zVlqpczdTDtXsW/aPT6zxtaQF8G06HRI=;
	b=jctSnmoEuMtbtzievUrBua6yyGkIDIoTiBbM3LaJzAN5R9R2nMv9txTD6QfmPPaI5b6U
	 DppD7cESaiI6aPciKefmggvThcSICkBZCT6mDhS7aq6NiOobskBdd3+qKETNHfRNQTG3R
	 CxLBtJg9lGsidhrZ7UjrPo/myv+DEgNIT77Pwb3bWQ3LKPRMxxsoUc5R5b7WUl9kftgnU
	 zYCKtcaO5fSOMVeA/wvr/VLNItnF3RqODU0DnEygceQEIOXrRma96jbBNcg3dqYineTlH
	 Cb1xUCV0U+oEm2u6NaeaCTP2FXLmjYFELUEuwL+6Tzm3lkGb+YvZ2bX7Rv0HQnZ09aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qNsc6foi;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4FC606A327
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 19:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E4FC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qNsc6foi
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso35240215e9.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 12:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793041473; x=1793646273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u1mJF3TM0e2zVlqpczdTDtXsW/aPT6zxtaQF8G06HRI=;
        b=qNsc6foipPq4lNcEwQm+QzbGrn4NPZ/oLUmdOSUKe4Ix+NjCdIoLGCXaexN/M+cKIr
         9d69iWkJAMua/2jaaAgzMGtnGjx6CswcYL0UcwbC8WeIvP9IdPCM2zAe1XsqOj6E25Fk
         CfekgUcxIhac8QX/6GzYqS0k1fr6cxdBW1R1rzldC7KBVbvzTGg6KEa3Xn/77JC0uXg7
         aatNQ3ed2LkgeWEK4J6vb5KJCqwzhst50MPVv51bQ+u8dmbScV7nw9ou6z5iB+jeQ/6/
         gPcj02B8i7E+k4ELe4GfWhBLFaeh9dJS3cBF1KaMo57SE3pBO0vOBDl7pMY7SOGC7ROO
         I+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793041473; x=1793646273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u1mJF3TM0e2zVlqpczdTDtXsW/aPT6zxtaQF8G06HRI=;
        b=wSf1zv/4yn57LXEBcznVljiYLeZZ7l3VATJZ+UF1nMOPCo+bsuBg+wPFU+K5R8E8F5
         GRzcKwwlPVB5TEPBOueyL1yYtCFhXOrE5GQWM3MF6oSUwML5n3G888z/OSPEEMLi//k2
         Qi7xCwJuBxXIDAO/R7K18+eZltyQLPYmWxznp0Fh9kF0UyvQEwNNSIYALYZU4yhIFKkH
         fJ+wGum0IfRlrazIYJyA+LiMbL8SFbHBom9gNB3XsR/SYnF4B5+F9QAjY1QrE6tJInxp
         a8HkC2SFjFvTmXhMQkLvJBJgG00vC1M8Y5v0ZynmHSP7rr96UYrkgA1pSuhaej7hTqml
         omFA==
X-Forwarded-Encrypted: i=1; AKwUvBwZRi+kOAccWkobVv5kjc/s4lUEUpkBqygEE5KlsfKVGr0LEyq8l7x/zJA6CnYWYHHqLXk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdZTNDYDqM0gibEovzgi1DZx/2aNVOhtKkGtkjEuXJFKl5QPWQ
	56bc+khE6tqU0l+OPeSbZmazzXFBq6qT5SiwcOza3761xeFHlkB2FnsN
X-Gm-Gg: AYBFou1DnfLmny7YmgyTNEtnMjdrYHf1oKaBPnBTypNPeTWISyAIIQf592sNCOGxm9u
	xXmfvNNo0YAUeN6e8y2S5Mpi6f5M72WJUYrua06of7CKvYesiZ+QrL2nD71KKfDS5mUw3f5rCXN
	/ZfdA20KAvlnfu9uFp2khQFN5FTiYbrGqZ/AYx+LgYC6nEE/rSI93hkPltSLooiAtIxR0GemTPo
	2+cG3K/ZtIzxS0h98YzCPPSViVNi2fDx/7crGjyGddOnNIHmrAy+2cIlbv6cf3iwzHtqGJh26YA
	dTxTMIq4EqkN5B2k+jj85Vyr7S8O5vKHAOcyoXFN/AaR51Kzuv9o6MfeqqYzjhWsO387+Q2JR/j
	IZpNbZjUZkVGQXSKNUSs8LM9JMuw4h7kiU7an2xqNr/f6jIY8jhUZ2gHP3I2Isehz6wXfKJO27I
	jXSErVfdezsSoWaLUp/kub303wKGrzr6jvtWZPU3Nr/MLyGad0tQRsT1Qc7uI4+PNpjGbulO7tV
	mFkvIGLQ+TkTTTOwQ6BLsaX7w0kua/WHF8778zd52uWegHTQLRd9oIHhuBn6ftQ+aOaxqhtBUjd
	xo50
X-Received: by 2002:a05:600c:b86:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a35acc1129mr141897665e9.33.1793041472419;
        Mon, 26 Oct 2026 12:04:32 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a046fefsm271518255e9.5.2026.10.26.12.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 12:04:30 -0700 (PDT)
From: kerylefondji7@gmail.com
To: gitster@pobox.com
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	git@vger.kernel.org,
	Keryle Fondji <kerylefondji7@gmail.com>
Subject: [PATCH v7 0/1] archive-zip: refactor 'path too long' error message
Date: Mon, 26 Oct 2026 20:04:21 +0100
Message-ID: <20261026190423.1925-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqotsm8qsdl.fsf@gitster.g>
References: <xmqotsm8qsdl.fsf@gitster.g>
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

This v7 addresses the feedback from Junio C Hamano and Phillip Wood regarding
commit structure, missing commit log message, and patch threading.

In previous attempts (like v5), the diff showed 4 deletions and 4 insertions
because it was compared against prior iteration attempts. Since this v7 is
flattened into a single clean commit applied directly on top of master, the
diff naturally shows 2 deletions (-) (removing the original master lines) and
4 insertions (+) (adding the complete Q_() structure with correct tab/space
alignments).

Regarding the mistakes in previous iterations:
- The commit message body was inadvertently omitted, which has now been fully
  restored.
- An incorrect Message-ID was used for threading (replying to an older
  reference instead of the proper discussion thread), which is also corrected.

Summary of changes in v7:
- Rebased as a single clean commit directly on top of master.
- Maintained the exact indentation approved in v5.
- Restored the full commit log message and proper Signed-off-by signature.
- Cleaned up unrelated modifications from the working directory.

Keryle Fondji (1):
  archive-zip: refactor 'path too long' error message to use Q_()

 archive-zip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.53.0

