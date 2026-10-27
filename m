Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126632;
	b=fTLn4XfWlddPBg7uHVsG/T9GV6yifrlprdvoSbeDC8Ja26gzwWsUQwzT9ISYSwwo1X5e
	 +BEpDiG12brVwx9YbYS522eJot1QxRzeKTlAGOkP2x+BBT2MMgLi1ldj/UxsLfwg44Bu7
	 K3TAqWy/kSf0twkmqJaiqoJo4C1qq1X7x2iiYVJs7Z12bBiXsmNPYNvGifsyRzV/ZpTeP
	 tKihOSaqND+8Ur+V/JQmT8BWlteG+fMX5eRGDedqyhApGuyg9/ee4E/vwjW9LhezTselp
	 6Vuskx/7Cg5eMMp4tzZ5iPVCxiNt90NT1daCKUqYajQOFm7PGefz1gzEAsPulkZczQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=brfOxwLecfrmdp6JdqBXUQagZ+n0f8YKlGAs3PQo+ZQ=;
	b=anZoZ4HWl3TeE6wzTQsQS1xvPUNu5TKEsmR8RWhiDhL0kbo71Vs0LawI2Q0OW2lbljp8
	 BaAviG85KCa/Sy8bubL5NkNgrT1j5BkPhVXm2n2x0yojYJYGmf43HSEqtvqHVdkbZvLuz
	 P8pgOBIVVtFubg3wa1JBI9TDiVAlDQvxb4aBXorsMR5Iogb8gwP7uJ/L6nLCqH94ubVAO
	 vHaABUQxkC09RMO76OmgohUm44loIzNj9q+8vp5XCX+anoHA5Dl3r7FtHn9sdeES5R4So
	 ESaKABqTpiV419mCgMKj6Hj1ZD0iX0VNN76NPEjThokDAuk2KxrKW/uJnpuU3FyEzZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=snFUxIuc;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B8B606A31E
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 18:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5B8B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=snFUxIuc
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a215e64962so1895115e9.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 11:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793126630; x=1793731430; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=brfOxwLecfrmdp6JdqBXUQagZ+n0f8YKlGAs3PQo+ZQ=;
        b=snFUxIucbibtYRIsAkVgM8zoTpzUrZCpBezdwhqMUzTIMuzF+zx37c0HLqOLxLuHtS
         X+atanXSZxCiMTWONxYxY7RXx9SDP73T7YlGCRKshZHcncFz88jQsn/w4fNIi/RET4p2
         +DqHjYvIi9RV7uHw/2N0NPnH0SNX7dKUrtViTn97ARa7Ewz8e1DIGlFpPRlrpMVI3Pcp
         oxdQKheD2wOQH3VwH7TZo3Lp5JLneRrt+mhu3H+WQNzVwWS4lBSdOC6ekIynIHVDIdlz
         reBq5bqEVPaXhGfNDPuEugZ1+84YTNVyR76Nnc1WqZpCPEhGA0oVhOEhhw3kSTeMGs99
         q9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793126630; x=1793731430;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=brfOxwLecfrmdp6JdqBXUQagZ+n0f8YKlGAs3PQo+ZQ=;
        b=mW68s4WdS/M3zEgqdhwgpMioxhthZblqQOagn5lYWw7beyloI5M7mnevL7RKHmjgno
         XYor8eKugNV5tHcwcGtfA9iVralq8FlC3Q7EPwua5rYqjZ7Ir7Zy0vyGVXSMNLH60X66
         FYJi+VXLgYMel4JSziijkeNHupnHchhyhwpxXjL5OX+wiA5QdqWoR0dhA9pFU2tc8cq2
         NGfntCv+t/8fW2oqOyiEl+BTukSEgiW1IC/cVnA6rLcMxeLH9uhlwLQPWLxXzmEPPeFs
         6xqaHiHv9r3LNHBJq4Ltu/Veeat9wDcZWPYu4rjS4IkCFAcDRrXe25Kw9Oatjaco/9zQ
         Z78Q==
X-Forwarded-Encrypted: i=1; AKwUvByNMUlGeYXOGXPQJX/y3w5pw+o0A6r/1qeNzE93UMbEB+yANdvvMR7ZUg4BEqW+0zIiU3I=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+4ufnNlBtVGxZGVA5K+jDs5M5PVqpdcOC7TdIaRru+u6OmVkW
	eHbLvKhJrylg56qRXEUrh5AzT6PDh5+zaqjPhi2zq3o75H+jDBoXiq+S
X-Gm-Gg: AYBFou0zMhXZsK/xeOSVy7m3UnhO007NubJoTIq1r+BHH7mYySewgDXmGzpeShb1iiq
	wXA/YHo/ZyiRiG85Okt8TR0OSkcnorDqUOL421BHobBbpEBRBSH7NrQtJSUrG76oIRlzhwB2e/R
	X3P0gJEqL6OX6qdi6NAefKkqQRDSqez3CbLvDQPqPUtZXOl1ATenESo+x7SCG4cmgsuz1DiXqe2
	hGgfzNCVxNEf8HrvIdT6/xcS8Zu/vC2ZIvN8ibnlfKwlu7288iTdExZ8iBn02iTmrpeIfQXetkL
	DLnk3aZIn/7nrOlOahzh5/STB21QfxrklYkEr80tgbuUhpTT1xxcE3Xb3X33fhoMexVlwmNCwJS
	4supMGGtgWjCXVbnPf1nWyEk0JwdLst7OuDgzJte04SjRlvJEaLNyVcNtvEjig9fzYITZzlLRCv
	0aG0kMCedt+KSblPur0I8tcr7h8cAIyh6pG3MDnqTiLvdMm/AM3oI1HbG/NXFIXKxaBBjJgnmJ/
	DTJ9zFMM98qRxNHZg0aand5eBnseQc8Ss/5k98c00XiSgi6W+sV3S+Sn4s=
X-Received: by 2002:a05:600c:4e43:b0:4a6:4d6b:a840 with SMTP id 5b1f17b1804b1-4a64d6ba846mr144800305e9.31.1793126629906;
        Tue, 27 Oct 2026 11:43:49 -0700 (PDT)
Received: from debian ([102.89.75.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a92eb9b52fsm4893025e9.2.2026.10.27.11.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 11:43:49 -0700 (PDT)
From: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	git@vger.kernel.org
Subject: [Outreachy] Microproject: Modernize file check in t5300-pack-object.sh
Date: Tue, 27 Oct 2026 14:42:43 -0400
Message-ID: <20261027184342.3948-1-ogundipesolataiwo12@gmail.com>
X-Mailer: git-send-email 2.56.0.116.g6de20f6092.dirty
In-Reply-To: <20261023154851.7876-1-ogundipesolataiwo12@gmail.com>
References: <20261023154851.7876-1-ogundipesolataiwo12@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Could you rephrase this to avoid “This commit”? It's redundant in a
> commit message."
> Please describe the change directly instead. Also, I believe, the term
> patch is more
> appropriate and not "commit".

Thanks for catching that. I've rephrased it.
