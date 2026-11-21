Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254357;
	b=l3pidWWqtAO1xxEa/4+EbWceH3zJf7B0B44phTTBNNRlr9WeC2+rs0Qt8RE6ioOQNpDl
	 6VuVA8ILbOHwNpgT16sPBvvnI0bJv7XFNPxeiZq9NdshZjpU4afJinWvijReq+j52XFud
	 qAcQTC+fKzsPv+P3hLRhPrcuy9/E7hp6zi54O39jPhwznhPa40A5V/Ex225Y7jFNOHC0Y
	 SO0hHyb1ocPiga7Vw4oL2pF01i8PzxLiklUerpj9CnnnSCSENcs4mtK1Ve9vFYvVLSzYK
	 CdZv14FYmAf/VZLQku11H0MS14i4shVmDrciXdtdeVoNrpLrf3K2FiTFio8KGJXQlCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HxX0+qkFNs97N4wW92jelshiel4MxJ1pKBpTwKKRrt0=;
	b=u281jOx6krO9/+qXM4KPh2GNk5O2nJqWinizSBRLb6L0ouzfSHeYdqP0YASQMmaQ/O8O
	 LP0qx9s8eZFQWZzeFeid5/PHmMHcAWuXZ4hvyWSIdlYQ64yQvEUjE0t8YGVNKzfL5Wp7x
	 /37lBJ6kCqVkpREPz31NOx/p6a4w+rClndSH55nY8cji3WhGxvdlqBfeyh5jcW+32Y80P
	 iW0mnC9ZASdWVsb60a2T+LmVtjrFr8y49tF5kvZTgwCM+7B96/k4WvUsKJgBDp7wgksTI
	 Q5ULvHab8YEY4kCmqwMQBlSp7e3zgoWAs9K2lXXHbbkESGa6gYopBJ+S2gjHeCFTH0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M7oqc3VV;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E98606A331
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 09:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65E98606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M7oqc3VV
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-38699cf08dfso783286eec.1
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 01:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795254356; x=1795859156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HxX0+qkFNs97N4wW92jelshiel4MxJ1pKBpTwKKRrt0=;
        b=M7oqc3VVg8AbCQqoXbLD8F7Ni44pJ9zcrR9FY6xl1AwWNBC/7liIlkY8Hxz3IuNnqp
         3qyw4SrWSptSp8fT4OrWKcsHN2BynVb5cHpjzzFaFWJ1VeMSLxAIppYsywoymlqXjd07
         en35n25iM7Ud9OuvQeRcppeI6xHcPEG29nM3F6nSc/11t9G2kDfFtYe75gtjW86LYAH7
         tsY/IHJZriWnw/rdHUX6AGwQLz1y4W7vfVLH65VbuRg0jB7KRXpW3BsvsQ0H5WwU6DL9
         FcxHBdd3gC2X8WhsL2edFuxKCOdiV2lX9Xk6fde7RY9ws6neqOY6n/QBAW2v4TVWUdLC
         h0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795254356; x=1795859156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HxX0+qkFNs97N4wW92jelshiel4MxJ1pKBpTwKKRrt0=;
        b=JWAZuAVOIAEZs8dbX1MH//LcSRzpBgmw8xnfdUbG3Nva8dmZc5L7jleaCxd1FoNfU7
         xZXVQe3h5byXtpl8jgko4vrzoRTnqe/SAD8yHVgVjCjf2riNq2yu9VoTaOPRP/mWj1Fj
         rtr+se9+kRSVlnYr6cQkFvu8HNKoxlS1tAPgAFv782XNkgDfHARwo+bEVqlKy1kTU/a9
         O6dCufOdd2zejd8Yw7FZZhnlYs51Sgq/59hMOF+wf59/9GEChzO9UyJOs4htYojPtULi
         3Lld4m/v5jbmetNFXVCHg4kFQioSYHAa4djkohvxt6d3EzHrA5LsRVH1I8N91BiQ9zy1
         NnYw==
X-Gm-Message-State: APuU4Z9Nwf9xm+ruHMBHNOcT+ry6EEzCO3rJUr5iDy2nvVhG9UdR5RRH
	kYk6M7xtvdsI6yPl5nM1ZbQcEuIKH2AcMvqe5Vr+yCq4qTSbeNpyCnD+
X-Gm-Gg: AZFdTZd8FGq44vcP/gvl3DXxn5KDNV4L2gfqtoyBg6tEOOhhFdp9OE0QVWWysZz8y+I
	jgLNrIA8vf9G6CbCj+VGYpFWJrZPmHMAmoYdgl72bSgYocxslQM/zgELB7pNkBQXsf5PTqs6LCb
	WpossYXCxd7HBHkpvmGOqwHm0VH436JeCHeFARsNpufIlj9ELkdB47G+yNynk4djHgQQfbZeWf+
	l4uzmgitQq1cG7UlQwaqOcmGibDVzxEsRPkoE54PuSadrbsMo0RV2EuT9z38BXTbo14g1Ywmwcf
	YWgPye0fdoAzR5JNeeGY3LtBtdExiWMn5loI0+k8hmp+ZAbNU+Al7cTw+u7rZ59mrFlEH0Z9+ql
	qwxBl1X/vQ7LnZKjEmtqAq4LpDeXw72h6ZqBATsa1IB7YD69F6ul/bet1RQyQmXgKq0wxoGEDUq
	eeJcHyFDNENYEmUf4tug5fR8UrhM/C79fXRI7mSlF60oCKVWDmFw/tJpafaXqXpFA7jqRKs64r6
	q7KnT9P/d99gEpU37kn/Bx7yI4hbN9iISKF+lXirauEwqZ2Rzh6HhHQLheu5otOZd8pyvkhUztO
	iebuTNh+Y2kSIf/OTXCdimJsaVJwhlVhQ7k3e1znNoIXx7H9QOdi6xgG05CELOd5fCfl5ASNEXd
	AHtOO0llnl4ActG20zUMCg7OMlkpDkg9bK8P5tmSQ2Q==
X-Received: by 2002:a05:693c:87d2:20b0:381:ad6f:75ea with SMTP id 5a478bee46e88-3856f14748amr5632056eec.13.1795254356256;
        Sat, 21 Nov 2026 01:45:56 -0800 (PST)
Received: from localhost.localdomain ([223.190.83.65])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385665f21aesm20694756eec.4.2026.11.21.01.45.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Nov 2026 01:45:55 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Mike Beaton <mjsbeaton@gmail.com>
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] dir: do not turn blank ignore-file lines into patterns
Date: Sat, 21 Nov 2026 15:15:51 +0530
Message-ID: <20261121094551.30133-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAHzAAWQo89ox+S_jtPX9DOtzfr-+3uMbWHN+HXdi9Aw2q57+Ng@mail.gmail.com>
References: <CAHzAAWSi9D1mRL=A5-9GxzqQwo9jJ=45Hmxj3hVAF=8wkNZLmg@mail.gmail.com> <20261106182945.1316297-1-aniketgupta3001@gmail.com> <20261119171942.85689-1-aniketgupta3001@gmail.com> <CAHzAAWQo89ox+S_jtPX9DOtzfr-+3uMbWHN+HXdi9Aw2q57+Ng@mail.gmail.com>
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

> Do I need to do anything

Nope. It is still waiting for a review.
