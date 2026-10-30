Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793351152;
	b=JjgbLVtVSMubhUV1jvzVxkTcTyWQ3v8oQiayiR7XIzPSKMq54Cxgxnlq2WtwtKJUKUAz
	 SfKl7QUzj8GTk0D1RNgMx32gW+UvuEUJFrrFptDPBBumdMrdw+x6D/JraR/ZjZPwA9iKv
	 AzrZ0Ob6NgQgAS57YSo024PA4Sc7gMWNfJ6aptlYWVjpslrqIaBW1W6SHD2hMCNK6tBiu
	 NcwUJpeKABg1o6iWXC1cwBtO+iTUh+8Uhv/uDIRHUVcSczvtL1yu+sZDDgeuHGRWiezi6
	 N3eetd+B6eXNCElLU/DWRmjPHOYC5EK2/YsFl96XkCdyRx+WtK8s50cKxebm0A9f+Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793351152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gSV6kR+duvnQQ73ijKZIvMAlkwnvqwMFl5Zf+YRq70o=;
	b=RCyNZYg+xHdGZ63Zt2Qe7lcWqWG9AHU9J4N6bMC1lTIOf6BH/6NceFYVNJZZ1czAoD4m
	 YGTTloKeVcBZJVZCQKpLgqBA8ojwUD3Oi472G/Sg3jVF9O9g0LCXIDCAEFIGe934/1r9z
	 Y7LVyyYChbMDNu7uoB2NimJptGSWkySVNL1CJlt4fZDuhLW1kQBrpWTc0G9mMoRGc1Z0h
	 beJ5Eaoti6NEmJtJ07YsyKFE0OCa3KRfVDnhVIriyOvdBjvavrUbx9xdqcT7D7Db+B6pH
	 pZdvl/iTsfnOoHPZGZ8FB+nmM21INps9EJnpVdXkTsb5lOQWpHxSs75PSTWtKSCzapg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lbyiHhEq;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02AE606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 09:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D02AE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lbyiHhEq
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48df8fe8513so412602f8f.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 02:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793351150; x=1793955950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gSV6kR+duvnQQ73ijKZIvMAlkwnvqwMFl5Zf+YRq70o=;
        b=lbyiHhEqrpLxt6LtujhFhYkezWJhb3edG7S7/WSiwBc1ONjpjFnHqqeSvZZBr548tT
         1AweZ/sjWvDRaxFWhQ9HmagbHwkCOW6hsq0RggHSQYDG4UIrQHgL6xxgUEA1nfSFMEyB
         Bpn+jeYQNidCApPvNuj9KgxOFW/XHyqvsfBwHZhvMPcaa9pWK9+JA1X8W04n36PguUhe
         87bZmQfFQ9iKVcPevvun7SFFFAb7oQ1Kox7bLBywJrmNVfEzEzfrPiIXcT6jvLMVCHJ5
         2iiC0nhjUmbU2L+/j4BRqfMY+vNKs4V05j4pdqcixTw+4PbDdQNWjOwbcwUras94JGw4
         uyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793351150; x=1793955950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gSV6kR+duvnQQ73ijKZIvMAlkwnvqwMFl5Zf+YRq70o=;
        b=gau7oV7lrseUBaKXELR4ExSIYDLkpdow+l1CnD5PBQr+9FZ+AwywhUFo3kHp3vQBDf
         UYhCk9YnOk0cXUFbBuJW/KkEM9Jq76K20SnUSq9fHZV+bdBN/xxYBzjvLML+EchQQbxk
         D0l/j91tYhevEjkk2cLbveivXFjioGgyTjGidwnx6E4m2tdXIVN02JhMIgaMT2zMx3Ur
         LrRzAEnvpo3w61aF6xZQ9elXtaGRTzjSYwbPCY8TwwdG53h1tgQNLVZVC0h09WE5rzur
         /ygvCnWh8pPjoCdO0ZGLjE4NwmLCuBXIih1qeUMInkkbK+i7uEe12iX/am9w6+GsKIKz
         1s+Q==
X-Gm-Message-State: AFq9FYK3hKqXS/KnJfNP191e2szsNyzpFDtX6EyiND3Uahx/agoGvUQo
	6DWIlFI/tIFtue1OT1vbI10d6l+LmAMsIRk9cCYEBbV6kXAoRSLLjiQgaHS8B9Xy
X-Gm-Gg: AYBFou2eqNyUzUJT8NFM2rC8p7NsK+oi6iFPbnWwrp/k0NHT0Txbhe5SdPFc6loVwn4
	pyBuS7a/U1h4Nc3XBWZKN7Xt8CaLx88RD7J+O9CU5vvnfhUHw++4CXztWEn806XV8/OizB6N97z
	yVxdZcoAbPtWTIBuI1x0j52+05Ao2AIUR/cqysOtf5Y5lguMewmcRnqP2/ieg5BNEBJEND6tJtN
	OKz2d1GSqBQbin7gDog8pFgvJJ6pbHO/3ADhInhJIUDowaOw/8g12ypYC3+WAwNywE5DI8U5hWg
	XNNDJsx52MdG+tXXuqnrpHWi1z03wRZ5ZCWxc3GhReAMNDnkaGPN8Rr7Bq/53qUafSmTSlL7PNE
	GlZvKjV/9Tses/Elc8hCamJ/BCiGj21CWPSnoD8ilPfQPdZrOevaFdK5y923Jw2NNESWTlcIavY
	gnYJbM5yT2sCIqV1JgpDoqxeNl/UR9eDmZX7T39eV3wQn5oSG8OljFlF+S+ALvUKKfMRtmN+u5l
	ohM6LGMndLjwBDQwGFMkGkl6rYnDaXJwZjUIPUZsG/Q+l8l9EZfgUBNt7nQjmBR4lVVxR3fmqp4
	xHdfO6w/b+VXY5Oba6On3lTV5rTKKsGBO9e2RQ3rpatBuskqqEPuqtUDDR4kPxP6MTP3Pg==
X-Received: by 2002:a05:600c:138c:b0:4a1:acaa:9d4c with SMTP id 5b1f17b1804b1-4ac18c740c5mr31602505e9.25.1793351149704;
        Fri, 30 Oct 2026 02:05:49 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([205.147.30.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b289f7sm45096985e9.5.2026.10.30.02.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:05:49 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	haraldnordgren@gmail.com,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: Re: [PATCH v2] status: reword message for a missing upstream branch
Date: Fri, 30 Oct 2026 10:05:45 +0100
Message-ID: <20261030090545.9744-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021072137.258934-1-gitter.spiros@gmail.com>
References: <20261019175722.5223-1-gitter.spiros@gmail.com> <20261021072137.258934-1-gitter.spiros@gmail.com>
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

Hi,

a gentle ping on this one. It is queued in 'seen' as
ep/status-missing-upstream and has been marked "Needs review" in the
last three issues of "What's cooking".

To recap: after cloning an empty repository, "git status" says that
the upstream "is gone" and suggests "git branch --unset-upstream",
while the upstream was simply never created and "git push" is what
the user needs. The patch rewords the message for a configured
upstream that does not exist, and suggests "git push" only when it
would actually create it (i.e. when @{push} is the upstream).

v2 also addresses Junio's note on v1 about the "[gone]" label: the
log message now says correctly where it is translated, and rewording
the label itself is left for a separate patch.

Any review or comment would be appreciated.

Thanks,
Elia
