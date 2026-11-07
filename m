Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794030428;
	b=fQ8VrIjPBQMcyS03wEQmemMXtEasLk7XZ4YfgchLKRHAAd/o4BDerdxEwmW5f+UU7WyG
	 E/93aJ2xL51kRgKprqrgUpx6L8rmp3MMHs8VHT5uaGZc8HTJrTKTZ2spYVJ7eINwgEJVK
	 Hxy6KHT6HJLamU2eJErxGy7puzEr5pWZjjj83Ic6VlGNALPsJDpX7syHI3eMHevvttr6C
	 HNNKx6FyoNgnUWzPpw43qk8zHcOTbBtikPp+8zhjj5nmHy8z6UwMlgP8RURCv4tnAybaE
	 yzCfB8elB5WHRbp0BD5F5Flzk5YOi3e3eG1aNnJ4+NtuVVJyz8Z4aqUEah2Bl2j7Ozw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794030428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Akxn6ITUl7dhrZx4muWk5QNf1oo/AC75b2f255U7KLE=;
	b=xhe3maQDuUNkRDFfqgaFJU5X/uhrnBtST5VpvL/I9y4NjN5hMjqYY8fwCf6scgk58XTF
	 WWZ24+sbTslrYsHd+jyIAOKzaVVOnW9M8sKxJaSSyd5QqHirWmgokLZh1Uo0vuCV373z3
	 9A+u8/8eTYJxWZB8wzzjstIct8cLI4s1MogsMCQ5+JdvRi9txq8Cio/m7orTmkJ8jG9q8
	 g+YKRD1bGj/xPL7GZKnWuHQsPTp30swR5xyarNcwkdIQUz3QEj/u106DJrneJGstEKv4p
	 vxDC+rBf3Xh+URUxOAI8IcBSAGHdSzmbBpbt1AD5p46G4f16CxwyD0ZU/uKAe6+GvDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o9fx2XbB;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAB0606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 05:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCAB0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o9fx2XbB
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso779961a12.2
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 21:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794030427; x=1794635227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Akxn6ITUl7dhrZx4muWk5QNf1oo/AC75b2f255U7KLE=;
        b=o9fx2XbBGFlBA2JAGjN2I0e8MZbqQCyctIpjh2gLgoM7jNdQcypWPbX8/CzxiSMRvw
         CgH3VYvQxHJDXUpafqEdSE/FIUAsH14giKzsUlLk4jdT1diX/MVMPuhycp/d9G1zbIuW
         tk3NbwUh6Jb/4M1p5REH9lSlF9ccHqwu2pSuxk7R6tM+Er+sG5ORdNkkilzU1FJ3qXXh
         I94HALu19BGydAx9aKtraZe8o1wwhAcWHCdigmLaqbuk0gSivonrqSzrq/E0TPKieL9N
         GAGW3HQD8oeuH0dmHTFgAt9Cc7GiXDGKTIM6cgLcXnM/PSwJ97XG8fs8+Tdo8yrutCFY
         K4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794030427; x=1794635227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Akxn6ITUl7dhrZx4muWk5QNf1oo/AC75b2f255U7KLE=;
        b=mCfNWbGglTPUSfRuzqbYeFxKjJxgcw6cwO1V4QfHRHClVbCffbHXdgIA2B99q2OkNI
         IT6xZ/buyaCn4RMEI97nN79iIl0NdVC0zn4N64hpMiMdkv/KN8xi1xDuRCBYn+yzD07Y
         LzXoiONVaHa9egD95jaIeGgO11YA9vjbcvFgM8OnKjjWtVENU/mx16ZQox5c7Ur6a6ft
         C/6Y1pf5W8F/KVohcAP4L/ugomsiiO5t69axdwkFE0aBySEXxJJF98g/fMl3G3AdM+HG
         QFu1y5k3EcYgzZg0bODttLGrbq27SZcT4T1K0hNRi7/XuQvOxZYs9IFQOu62Dgwf52oo
         U1TQ==
X-Forwarded-Encrypted: i=1; AL+hErF9QGyboMCAMlOm+Lfqj5LEUtRHF/sLZAh1EnpSicz+nviJGyRL/jVfh5Axk/7H/aaVdBQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yCSGb/LW7ufs3RosQMKl6tPLhgRJyI1zMIR8DBK19KhzQQmmq
	1slTUk/CVKnOZbBcfeNlpZuLhBD/YsphvqUnQUKg6M7/vO9RufNCV/IHRojIwcRtziU=
X-Gm-Gg: AYBFou3Y38YIAHTMJ9ccP7MZjjErLM5tiniBC+DiZzRuZoNhoYp+QSqCAgybUE8UfwB
	y2duDR3+YF05njyzJajyKH+G+ACxinu6nFuFg7epOCHExVjhghx5JCpi+dRsBbx1zGU+d2LGgGi
	xZ0VTPezk9leAXpH4XM6taWqQSOueP/FnDst7uxKhAe+g672sHeSalkP7iWhiHeHvl4X2guwRLC
	Y3ErdmWmBEvEMn3MgTSI69PFA+Mrf0bZVgwhMGM0PeB1R2bWi9QmmFC9lvhx788kor5Re/bQFFG
	7jns2w2v/N20nJgk9QfXV6Q57MLBtWFmm/QwSYYqm9YIGvyFeeCmPblmDG5//pTyTFkrbMG0fu7
	eewDJB4yMyY+XVoETScpj9Ua6mv162uGh5EfX6MGpEi9BPb8/aBtZe1wMPod7GQZvnipxXYmFW+
	rSc14q9jNMn3GDYqjdMA2uTNtBQ1Xqq13vC1X/Am5bLEmDPXkMqtPgHiqiQVpJ7ObhJNvWwpqOf
	HxRaBj8dlOyuQS/vGYJNLPoh74GCBFXyKqBj1GHuTg+4OFX+flFtqc3+dlHo6zjcq9XsmwX2w5P
	UNyTjgZEXhkQgVCDVJ62mSeUzh/iirGNSR/m7nx9dNxwV5J6lkd0w9QJbHus51UE/ozTXvkfGKo
	=
X-Received: by 2002:a17:90b:314e:b0:3ac:adce:60af with SMTP id 98e67ed59e1d1-3b0db6a8ec8mr5106869a91.16.1794030427005;
        Fri, 06 Nov 2026 21:47:07 -0800 (PST)
Received: from LAPTOP-PVRSMPQK ([223.190.82.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105881ea8sm1855640a91.9.2026.11.06.21.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 21:47:06 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?q?Hannes=20Brandst=C3=A4tter-M=C3=BCller?= <hannes.mueller@gmail.com>,
	git@vger.kernel.org
Subject: Re: [BUG] git apply: pure rename followed by edit fails with core.fileMode=false
Date: Sat,  7 Nov 2026 05:47:01 +0000
Message-ID: <20261107054701.298961-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.344.gfa103ac04e
In-Reply-To: <xmqqfqxd9pru.fsf@gitster.g>
References: <xmqqfqxd9pru.fsf@gitster.g>
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

Hey Junio. Yup. Two commits. Hannes feeds the whole format-patch output
to a single git apply and separate invocations and git am work for him.
Though applying several patches that touch the same path in one
invocation is something git apply does on purpose. A pure rename
followed by an edit worked that way before 0482c32c33 and still does
with core.fileMode=true. It only breaks with =false.

Thanks,
Aniket
