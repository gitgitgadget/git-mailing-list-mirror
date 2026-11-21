Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795242086;
	b=FI6d8iYX2ko/4ykk8/R639hYxHglBq5Iwf1qxQHIx3ruflwJ9FDbKZaFyAETQvGObMrZ
	 1z68SG78ZPbJHcb9Ip4eIlkN/PnJVhQnyLCi1oDiz4cb0ZD1jWt5ulcmMJAkuYzzEHxyl
	 9H/u+h8LtAad3cWyY7xmIat27h6hUyuooMhbEhL7o9yU67UZZkYlXzpEPReaW53HnxrNb
	 lwOyorLdjsXfNJP5oAXYE6AUt21nxrtx6+jthE8/WgIT0giwuZZOvJDRSzF/QqC+FamYy
	 zVjC/SjmknmHvFSQmb6cyGJ5cyIccj4wARZX/GpjJLJHySzoVWIcITQf9Wg3weGT2JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795242086;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wFtvHY101ItonwyHAaikXdQ8+//nKDTQ4vJUAxUtFxc=;
	b=A7qwjopmtwQiThNnFbIDgoSr7bAAWAPasmQw5LotHWZrbkksvULTOiU/MhHYzrFYY0Xn
	 VWDCUPKkI2XZXZBNw19o2fyljYT4ZtiUJfnGYCFSMZgQXoqKcUS5+TGDYruQRqhlHF99g
	 ddpYBbBQWnlJeXJcyp5nEbJ48FV/3/rLxFGiiWuC6utEJjFnOCHGTPQepTiM3Fpe2E+oI
	 jea0ONtN3WhpZyFQvb+vOZiP2Fi7rKgdWT75QdpirB7hvftaQd79eXyCOQPU2ANiHTYUz
	 K8/5qyBQrDusKYqA0CkC0QM1zSpLVt0PUFb48EOJBd5i2G/3d4Ny53kt+dPXY1ug9JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MhM8QTU+;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E515606A325
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 06:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E515606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MhM8QTU+
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b405d8f1cfso846901a91.3
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 22:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795242085; x=1795846885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wFtvHY101ItonwyHAaikXdQ8+//nKDTQ4vJUAxUtFxc=;
        b=MhM8QTU+u5KMi8+DB4SNlLwbScoa/Jv18cZlCX+qtKZBPyq+Twne6WmSHXaiAHEbT2
         SxMl4v6e+vyskoIrTpb2P98eIjVvcXecNhlL4HMVaXcxNFsTBy6lBpU6lJ1JHVawCRY6
         QXR6vNv5EcPi+xaBVNk0Mx5MxxOJtBbt2dAfsFfii6PbQtclxZPW89YLzWYsFL9ehIAf
         iyBWdILNyok0LDSqrsb76meovXmx8XPGieggZ2rY0kp7qn9+AFZk0+m/Su9O7yoPQtoa
         namQGD2Yx5whoWN72DPerL1rt/DXZOUl8NAKsSHv3sfy+FYzpG4Bpj+JLbdSylqBj/Dp
         APuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795242085; x=1795846885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wFtvHY101ItonwyHAaikXdQ8+//nKDTQ4vJUAxUtFxc=;
        b=bDyvnKeK8bmMpC1C+uZctvFIHdpTsIjwVAce61+5wLd0P8IIeConFT9vXRZdWj474Z
         AVssR3XFlxQ/AGI8DKX160c1KdxpKC3T2QvQQ3J0IUwCn3ucxJMmTL9cpn08xoOYnVHB
         qqTbs4dgTto2EUnFyBpYRP8LTIjZV0PPGcOAj5vPjFpf+jiUFHVkgRHtErRKQfIG36PU
         NIwp0LlBfxJF/+d2I91gPn0OHg7SxlFojLyBEsf2wtgilYhCZwL/j+yB84D4u/JMfpGK
         aYgDI7poiovp/LJpt/+/LO3P1ewCzNAjbhI5OgVePSzBicmu1UcGGsTLvqtc+TjSOB2i
         MzEw==
X-Gm-Message-State: APuU4Z9GVqOKVaSx2bY27BbcYy8RM/6aqqv21IkQCACwPRntL5ZbVDlj
	XevXtn6+0L1d3Os8TywAxZQFoA2oUcdHgrKGkMz4SNh6H2uwVjXia8bMldn4XGZW
X-Gm-Gg: AZFdTZfDtIyG6DNSVyJT6P+IC2t9Fw0AmKWUB65N/e40j22aahLdpBX5SDRDHJ49xyT
	Xcmk3BSydbZ+iETKDsa6BmYQ1qvO91axE9/IDWTfHSWpTnAGUlrx+me+N8zznuIcXQmW78DlVhS
	XeA+4HmY85WbhwL2AbAIzP7NSAPXc4i7ehzYPsWAn1msP10VI2U8gQAm9g9dnKbE1rKbEe/zLgZ
	fUHDaA3dnUejq7ySstQsS86vvbSPChDNvQjQ7TPSF6wRfYQLTxvOxnPBrhj6H9ENYy3ORW7qo75
	nt1SgODo07+Zu5UzoXHhg+qjK9WL24ktQPwOi9m1rLMxkXOqgWgJ286KKNhZslLeBEVZ7703+gP
	L5RK4ZAEDoOw7J7un4ZsO4xKkGlxPnU9caWN7nYvqo3Olj7dYZszXhkbopMU24DtmHygGjN03A/
	pQYqarRrJZ1ZrwbjXuTcI0iLQsrptc1mnVwzrjaZ3R+i0tMO677ptmNsMBaM6Alhh+34490eFRT
	3tdN5Dyu1XMeqR2+arx4++fOREEDlijz4uC4yH5Tja55Age3D03oLV7Tti0UCY9iZdfPu4Dr5kq
	EAEYVmsMDLic1jBCkH6SozdhhcIcnoVT4lcSzeCpnplB3DE3qHHhNt6FAXw4Q8zAVY1j6EKh+ur
	/UQXcKordOLkGgSNjCYlFgQ==
X-Received: by 2002:a17:90b:5287:b0:3ab:9c73:12e with SMTP id 98e67ed59e1d1-3b41c7c22c0mr5300037a91.6.1795242085318;
        Fri, 20 Nov 2026 22:21:25 -0800 (PST)
Received: from localhost.localdomain ([223.190.83.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40578dca0sm10564992a91.2.2026.11.20.22.21.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 22:21:24 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: haraldnordgren@gmail.com
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] status: say when the push branch was rebased cleanly
Date: Sat, 21 Nov 2026 11:51:20 +0530
Message-ID: <20261121062120.95388-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAHwyqnXks_cnmLrBxO0E-HkhvMNmnRx8cW9K2Lcyj6tnPUS0hQ@mail.gmail.com>
References: <pull.2437.git.git.1791270504.gitgitgadget@gmail.com> <20261120190246.79249-1-aniketgupta3001@gmail.com> <CAHwyqnXks_cnmLrBxO0E-HkhvMNmnRx8cW9K2Lcyj6tnPUS0hQ@mail.gmail.com>
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

> Maybe, but maybe the user experience will be weird if people don't
> understand why the check is suddenly gone?

Good point. The extra cost only comes from commits outside the upstream
so a normal rebased branch should be fine. It only gets slow with
thousand, so it probably is acceptable as is.
