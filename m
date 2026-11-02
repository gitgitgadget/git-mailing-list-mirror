Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793587633;
	b=f+VY6YfTjwKX4Zcv/y2JmHgvyBaV/p7f1T1vomxQdjb4ww4VRFt8L5wVIxaiE0SIJTDe
	 q/MepR1MLfhJG56CT5QtWrcm98gpiZZq7NRmaReUH4XruEObdEiqf7GwCt45psPYyLuMZ
	 UGJrz3Kxn/E021Slfb6g8068hGWZs9okVyVxlkPDugAc7fAuxj+G9SXTy4KG6n9xLLTlx
	 x9HHBS18LNwY076m+/Cl9vAB0rdtPj+ZBtsNvE7GZUVVAXqiYm6EYwSW0DBK/4blso7A6
	 JrBe96G9aP9ngwYXZuy0Tc7QJnyb7taPtlUSAVuQSmqy7FoexPqU6M95lFI2TCnpWSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793587633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=S6iorwpD11vZyN56HSHDhl+z9mJ1tBBdCj/8O5mmVHw=;
	b=wMEWG7zqbrfDQHmcdi6jo+ZsS70DIBK2PJtdnI4H2G08TmYt2nR77Oj4cjdwW29rVAte
	 6zaPLYJSkfqlfdvnpKEs0C883TjB03HJ8Arn3MuVdWe8/EJCkfrPLQhrWR1rgRVwfDOh4
	 dx+FX1rmm5zVSE5scCw0RFMXfU9vUwQ88SxVTXK0IIrcoc8O7evm9aRRMeL3WZrmYgqyq
	 dT2BnUGHJQ+zJu9qDCDjhiO8cwaHqE6XkOfQPdfopR3HwDT7bH2ZfdM7+cKxWUFVslqwG
	 17flD5QmfO4ja+7EmUbQqzbFARNeuRkxLlj9GFm4ph6sX9jsj7LYzhVkxleJ1POKOAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MLSy3Ckf;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C357606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 02:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C357606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MLSy3Ckf
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e3b22e971so1177141f8f.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 18:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793587631; x=1794192431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S6iorwpD11vZyN56HSHDhl+z9mJ1tBBdCj/8O5mmVHw=;
        b=MLSy3CkfsykFgXw38eLfo0ZOj2uekWF9PvZfnktNQ/TpJz9iipjXQWOdiet+9jYhJj
         7XoXQY/UNt7x1I52hKlGjX+vdh/g0A75RTIXN0X31nJTfZAje+8nDOdlI1WauPfbrnmt
         vUST7eFFwU+UUlUc2piayvYTCXFgZxpWRLHdo4pFAPkSIFMYSStIzCBg3QX/vV9I4ASy
         YM8NNXiHxKTymXr+h5m29ioL6cZDOfRdB1NDt6tUbQlKOw5wHfhTuu1Ld9ApWpSfiOli
         6dPai4QHNybXEgOXCFirYsgj526qFmM7F5guUrpxJ1mBAPHUslnYA7r7hMYGGt2UHYQD
         BQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793587631; x=1794192431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S6iorwpD11vZyN56HSHDhl+z9mJ1tBBdCj/8O5mmVHw=;
        b=ghf4s0VvLeXpJxO0UjcAARtUO0ImwXfgsGbZwDRH3QTZVIQlG+bwWghBM38VGaCHW6
         EKy0EtHvFPVlx+SIjQRmnNbAQO0r5YvtuA/meePplG+f0uSZpzvkNNBbO1VBhogq+bJd
         zeebfcYkW34rQRtIIKc1JmwB0c7QzIs9V9kuzn8rjlFX7VhZ6x8mZTYnFYh4IhbJnNUl
         BJf8hCg/NUY9u4yklkJJ77D27DKt2VAaWRIVHnDWgod1/qD4gRql5WjCz4gxlYqVxV6w
         NM5wj0KwCgLAQnQmEWGBWduwO/AI/FgzB4WBt8qfH/U+U5fQZ2bVAly9qBVyChXKGH9V
         QjEg==
X-Forwarded-Encrypted: i=1; AKwUvBztdz+pYv+Uw5pWT5hh6hP+XDUKZpKtONJh0BQer/TCbwekuSQ2EVMSaZzSDEhELkeuRsU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIQ14EqbHO3PsshRmDGmR2WwiNqhJ60ivKEOIWEumOzFEY2dzZ
	O4TZL1wyyks+n8n5gpf6sfKEgYb1q3/x/SoJGS8wHHfAR3bnu6f+aJ/9
X-Gm-Gg: AYBFou08+YZGXnFlYqzxqUCjCdsET5Pm5Bbg8CgaDvh3uC2CRDzm8iqIHdKz/oyqYjD
	YOm68C9oX3t5GsdqtGl+qWTiQQpDjw6pTk4nrguZQVJZSurX6dMQSUm47uMPCFjjXZZ8lbrC7Zn
	QZykmRo+F9+eSplDril+z0SRrUCEVTZWxnL6DWtSh4BhaOVU/I6OGm8UPerAQ+GV6pUtvQbF9/h
	60C2RUXR336JSR8bH/1q6EPGp7X4UbFpPqOiXs0QmywFXlq3FVcemhfb9YNt3DRhggIJhh5LNKB
	jJvxjTI4KRRhnUpPd1W/fr44yab7hprs+92lD1yb/CUT7VA0on6DmPAtFphIl/aDkt405hl7a1g
	VR6EBpcLdf9HArhU1E13hm7lUYZOhKFSGe97By7A6GjdtT5VUFZSTrfvUSmAuOs7joR87jgm84T
	G2ZOhW8QrIuvzpnRy5zEw5ef7MYMrtBzWiS5x6MDqyReCeNEVBhj7D2yra6OvUMo2Hm3nadQHvW
	Os1TUiRiqvJyuH6y/qxuHuvnbD9HfjXJOaNjLJQ4s61Kqtckdy/iCkj2MF/wSEDGAAargacJTo3
	Khc4kU65IiDBtvSD/8UO+/kDIzfoLELqML9q9KKn7GtVegYdfEUb06yxAxisgkxVezqQeDb5mw=
	=
X-Received: by 2002:a05:600c:638f:b0:4a3:59c2:b41e with SMTP id 5b1f17b1804b1-4ac150b304cmr202640605e9.4.1793587631463;
        Sun, 01 Nov 2026 18:47:11 -0800 (PST)
Received: from GODS-GIFT.localdomain ([197.211.58.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04785sm312585265e9.4.2026.11.01.18.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 18:47:11 -0800 (PST)
From: Cynthia Uche <herroyalpriestess@gmail.com>
To: shashu8660@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	kaartic.sivaraam@gmail.com,
	gitgitgadget@gmail.com,
	siddharthasthana31@gmail.com,
	usmanakinyemi202@gmail.com
Subject: Re: [PATCH v2] test-chmtime: use parse_options() to parse command-line flags
Date: Mon,  2 Nov 2026 03:46:23 +0100
Message-ID: <20261102024623.24897-1-herroyalpriestess@gmail.com>
X-Mailer: git-send-email 2.56.GIT
In-Reply-To: <pull.2280.v2.git.1793350341743.gitgitgadget@gmail.com>
References: <pull.2280.v2.git.1793350341743.gitgitgadget@gmail.com>
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

Hi Shashank,

I built v2 (43c96de13e) with NO_RUST=1 and compared it with a build
of the base commit (7e34d8174d). t0082 passes 3 of 3. Thanks for
taking Junio's three suggestions from v1.

> instead. Pass PARSE_OPT_KEEP_UNKNOWN_OPT so that negative relative time
> offsets (such as '-86400') are not rejected as unknown short options
> and remain in argv for timespec_arg() to parse.

No test covers this. With that argument set to 0, t0082 still passed
3 of 3, while "test-tool chmtime --get -86400 file" failed with
"unknown switch `8'" (exit 129). Could you add a test like this one?
It passes with v2 and fails without the flag:

  test_expect_success 'negative offset is not taken as an option' '
  	test-tool chmtime =1000000000 file &&
  	test-tool chmtime --get -86400 file >actual &&
  	echo 999913600 >expect &&
  	test_cmp expect actual
  '

Compared with the base build, I also saw three changes that the
commit message does not mention:

  - "+0 --get f": base tried to stat "--get"; v2 accepts the flag
    after the timespec and prints the mtime.
  - "-g -v f": base tried to stat "-v" [and still printed the mtime]
    and exited 0; v2 dies (exit 128).
  - usage errors exit with 129 instead of 1.

Could you mention them in the commit message, or let me know if any
of them is not intended?

Cynthia
