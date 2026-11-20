Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193447;
	b=McdacbUltvEHcEl1zLtq/qWKqz/rdvjtgh2GFGESG3inHE6OQdvbrqM17FQQ6iwYl8uh
	 ernGWEh3D+1xZHOGsDTLPvquQ4iVOckX2lZnuvzq4cXiQ8vgkLeXqt7i3G+bhvjv0AZzI
	 Onvsu061bZYdSHLxZsQ3IrgKpi2XaF7qfu9sP0sCG9DmtDk6mbNY3MdBJ3JtMgbr5zhFl
	 LzitWKnRWa3qI8C8EkTpMr/ctA9OD1waj6XCAQL5qdMoRIHaBZ0vQywdDk9KgIo1HTVoh
	 nEAH7q2YFTem5c8jlSys6I2XT49Rf99jf5UXQxSCFJsLezgVU4gkwHncimjyfg5w9hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=j3+TyedhqjGUtOOh24vgsGALKaASUHi1pGIesY8HYIo=;
	b=govvWgKe63hPL9c0SWRekrwUdAmY7TcASRIA1TyTJl535J8ruxaAUTzOZgbSp2rY5Fpq
	 Ev+qV63TG8oIQqcp+bJ1nSrHyc6Ijdfit03ZJ0nd4NF3LE2uKEQfLDV/defGNE4/W0kA5
	 d1JYhfjcmI0JgpPVYbt14wzWbFPxffT5H+qf6Lwf1gYUWU8HUsVBq9SiHISGcu7jskK7N
	 Bl97CoakIELrsVCNrySRnfSjTT77EFXyM4/Cu+juiHuXs5YiCbpj3wmAjeen4UMguQyFH
	 ysmdJncOqAPzM0DzhzBiTqD35eBZRR6WQ3U226CVMQM9LnhEFk0dpCDIwSzONnt4lrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ETMSuUhs;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DE3606A332
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 16:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8DE3606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ETMSuUhs
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso821233a12.0
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 08:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193446; x=1795798246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j3+TyedhqjGUtOOh24vgsGALKaASUHi1pGIesY8HYIo=;
        b=ETMSuUhs2qrnVfcmW8OQ4Bpxk0lEpiAGT2Dvo/C7d2gycx+kLeV0DNow2v8SN5hSZa
         rojTvAqxWQWlTPHCQZ2FSU+nQ/BGw1y54uOU0ruilaFfMEFV59Aca5Vlv/gbjfhtOaap
         AAsWKCnBEORB9HlApkuSqUF0GKqcuCrsvVaCiLTUykHnASSRSqrqtJta0yIhvk1iJlKh
         Io4bOikhmjE4UHMu6BrImY19266hOkFipvu/zrvGLQebD+WQrumJPWc4djZCKoO/+cyz
         x7GTNewBQ4fxToYfAxJQVf4BLdr8wmklD/KLFXL4RGLYOgTa+i5PrRVaYAwOpaU7NW4Q
         kqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193446; x=1795798246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j3+TyedhqjGUtOOh24vgsGALKaASUHi1pGIesY8HYIo=;
        b=unfRh+Ev0cr+4GAlxUPTbkb6T6XKIRtRxM7AR7Es0UbDYe3aHpKWmlWThg8e1Khak+
         1kBsGMQO0gQ8u2RlzNdoF8nsWUReUWstxHeGMAjPIoz0tz/xKBQftnYGYhru142AWYlc
         7fbMgM3wjASC4DeFGNjnT0zWg4cB80LwPiBwCi/rZENAmY2EM0e0qT3qROG6VorIdhxH
         eCMgT2XBfpBY+0Tikg63rxH0cSiGEN8ihtT34bmpPMXCOxqgD6k/EBJDrtbrRi6V6scX
         rDuL9tZT+kkNOz06ICUHx5nObwDC+yQu3aD6f+FbNHInRGeN1HGyc9M8MJ97qW9tzDIF
         ahhQ==
X-Gm-Message-State: APuU4Z+IZui3ClPB10FL9a8YoMzUuOiQ58nIzEy1GhE/Tm1aryqVPr/a
	PFglHZffCO0DoD71tGGOEkKzmm3+uZ19Lz53FVJTnmJ6PT8ntDf3xq3ezpRdVds/rDg=
X-Gm-Gg: AZFdTZd/q1BCYEFAMcoWmsQS6GxFdYNMCWMpWLPxUw+QPRZP1h9kOJ9GpdRwS8/r6hI
	wWI6moDl6XfJIjmhGH7uUfyA/UzmdujYAE6Qc7P9LD6TecdVHL4srILeBMINHLkVwTA8igTgnu4
	zCFlgnHmXIoRbHFJrlGlO0WOnMlqwsRPlQfn72IPw0i9IEBQkHzgMs1QcaBnk1Cz/OiqzXwunvC
	/Awp0ZeIP9fJX+Z9mD5dsLrCxwOU7TpMaOX4Bmbdyws2hFTPOrUXECrRKMlRGkOELbhF4aR6NpI
	h4enhSFtlv21kOQAjwDjDe//8/0glJT6lrqUr5cHgfCK1oEv+9TGLiAUtGhr4D5xGcHZz5FyGBq
	wHCj7gCbIwJnE5C4EyUik2nCCrWEpssS21p7dftlLmEPi93OLmeEOsaN+YEP3oHZyyEcxDx+aDT
	r82mA4NClXQGEiWNvsgs5bmgoEhLH6arQQ9oLmylpRM/sUOVjLi8fksDRhrzyvjEJy+pHHu0ukc
	GF0fnpEubtqK0oRcxYkKsyQFBJgZaQamAg/SHtO9aVQRVoina+QYp2Oq8OXs4ltsoGg+1YfAFf5
	WWwg/OAWuxiz9PgV9wr041jI/zkaybePHkUO4XUhuaFotXIBCAiWXQps44JqD7ZGoHEQCuA58i4
	0LJxBz3Lg6qqUywU+3RqJoxHxvUBnTDfQUQDvUjLB+g==
X-Received: by 2002:a17:90b:2c86:b0:3ac:9c37:9430 with SMTP id 98e67ed59e1d1-3b41c9b2bbfmr3446656a91.21.1795193445931;
        Fri, 20 Nov 2026 08:50:45 -0800 (PST)
Received: from localhost.localdomain ([223.190.83.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d11753sm8202448a91.5.2026.11.20.08.50.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 08:50:45 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: sami@theorem.dev
Cc: git@vger.kernel.org
Subject: Re: [BUG] combine-diff: wrong deletion columns at 33 parents, no hunks at 64
Date: Fri, 20 Nov 2026 22:20:41 +0530
Message-ID: <20261120165041.91627-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAOJ8FdczW9KxFknceHodV0jmhyEB24OMtqQUmhkP3E2vfsmgag@mail.gmail.com>
References: <CAOJ8FdczW9KxFknceHodV0jmhyEB24OMtqQUmhkP3E2vfsmgag@mail.gmail.com>
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

Hi Sami,

> parent_map is unsigned long, but 1<<parent shifts an int.

Thanks for this report and the reproducer. It seems nobody has picked this. Can I send a patch to fix the shift and to handle merges with too many parents?

Thanks,
Aniket
