Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3FAEDD
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708306850; cv=none; b=GfPz6qWvzblERlVhQ6LsSRx0ylOrOXacAULQO2DqEQg1xp7kblezhIDLDqTMnyhPxheqFP6VMMjqDNTUlLaeyb4puSbjfr6YalNSl+M4hAHAdgA3YCovJGoZpSRtyu+fufQMxQ+x1hGcV3u6WHXznYowPmdu8QfAILf+ZyAj7Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708306850; c=relaxed/simple;
	bh=lpnq5AG7RknmRp13Z1V/TvMoNqZe9kTyc7u9Zp4lP4Q=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=E7EbnJk6vyNCGXDXe+Xx08trPVXJwSrtFmWJb8BEPif5Ll7ISKvXZG+q6U4143Ebcmq0HeGgaTPtSrT66+aenQ/vgMUXlYih0P7ynEt4URAdVXFQos2kVCgXTPuiUTCJmh4ig8SPCnKsFvZv7MmxfygdQteb/k208teE9csSR20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHr2KkXn; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHr2KkXn"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-511ac32fe38so5662849e87.1
        for <git@vger.kernel.org>; Sun, 18 Feb 2024 17:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708306847; x=1708911647; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpnq5AG7RknmRp13Z1V/TvMoNqZe9kTyc7u9Zp4lP4Q=;
        b=LHr2KkXnUzRZwgUVtu2wbH1oQeW5M9BnEoSC9ZxIa0vwHes9QsWRQNoB8Qp8IJ+SNc
         IvMNSuwph9T8OmTbxrBqBUHrQrpAiox6ZOi+cVPFDuTBR8FlZufMVSkoLuaYKokdcJgU
         /P4K+z5Ogc4Hgk7uAF3BlBMUAqQc/G5YDxzWPj8/dF+LMtV3goEaJA46ltz2nyiFecXD
         8o2EK2dsCCx2kMuGQKz/lazFfchRiaDCAor8NYH+Z3Zzz5hlYKkogf+65+wwPn4mBfpR
         ZA4eQoqNpMLcLfX9yIFJiApX3s9k+GWAex4kf7VRrAqhbvIcqrXXyZFpsJNGJgn05i8/
         xmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708306847; x=1708911647;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lpnq5AG7RknmRp13Z1V/TvMoNqZe9kTyc7u9Zp4lP4Q=;
        b=vbTZNkX8wBWpmwbrU2KDIUrW3ceSpZHp1i5hRHy+zvZzve2PkwbqbqJvkC0cPCjJVg
         qzCoSqMgVXh99MjUsH8GS/oTWqV9B3twKiNfdTdN5e6/yw3mHHELQYkhyh/3fz4fyU6q
         Cj/gfrq8YvxU9W9MxGLo7H1mJmklrDHRUMQ4tBmEqEGzBUsdAUmDwwJSmiCI5WZZC5D2
         P4e5ABhuZVdYQILJv3d4w9OLjFeR+gK9sOkCE+cCnDLow3u60neFw95HStXewrDyH9og
         cR7TPHVFWhqqeWQce4vtd8yCCa/VS3RX+IyWuzj96DNjd9188XGNRbVWyPmhWkF3roEE
         64BA==
X-Gm-Message-State: AOJu0YxtZP1at2ntX7STutZAA3fUkRso/JR/cZO/tC0V5J8q60GzOnxx
	rGwWbYlCFMUHutfcPNgTKLUxmvFwP6+l7eOhaIp3VqzmXWEqYwTbsI4sXOeJ
X-Google-Smtp-Source: AGHT+IEspPP6+rUCLUmksMA/Vg4X+YjuGBqRKU/ZlLwAOS1manfIa1STMi+eQhqcZ9ZiXe8jXZPz/Q==
X-Received: by 2002:a05:6512:234a:b0:512:b1b7:a285 with SMTP id p10-20020a056512234a00b00512b1b7a285mr1869334lfu.51.1708306846815;
        Sun, 18 Feb 2024 17:40:46 -0800 (PST)
Received: from [185.222.58.100] ([185.222.58.100])
        by smtp.gmail.com with ESMTPSA id hu13-20020a170907a08d00b00a3dfafb264fsm2425113ejc.7.2024.02.18.17.40.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Feb 2024 17:40:46 -0800 (PST)
From: Sarenaa Fuller <zdndaba99@gmail.com>
X-Google-Original-From: Sarenaa Fuller <castillom551@outlook.com>
Message-ID: <6d7b3e4d719a80d936bb98f1b48dd6995cfc23712bc5c1edfef77cb9e7c0a62f@mx.google.com>
Reply-To: sarenaa.fuller@outlook.com
To: git@vger.kernel.org
Subject: Acoustic Instrument
Date: Mon, 19 Feb 2024 02:40:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I'm giving out my late husband's Yamaha Baby Grand Piano to any passionate instrument lover. Let me know if you are interested or have someone who would like to have the instrument.

Thanks,
Sarenaa Fuller
