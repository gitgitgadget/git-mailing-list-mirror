Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFF81D61B7
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770148723; cv=pass; b=hhYkfXx4KLDGY557w6fTuzmsbPnmA0xJ1xQzJzPG/f7mE6bxGEysNXdVE9iiCDyVl804q8pfQLg7E3kZcliQedmefXo83bphpbuaD6pD5f/lY6OzQowHkmpXC3Gkgw+qhXlWGdkHcbsABiGa79hEqkRsdQ5OEIRomoOa28oFlFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770148723; c=relaxed/simple;
	bh=5M2Wx7I7snwYCdTarJKvx8VkN0PGwNJoZZJ1pxZdHhE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CfZNc+IB8tpqC21mITuLQ0YCMOnTX+MMSMXKYoIiQcllEOya04A27qEVvSgIyKAv/uL2G22QzUzwqMjIwoCfP4N0Kd4l1uF3Hh3o9OhtXOiF6oKvQrQYlW1C48Ob3Nbo+z9dNDvOuivrM+DaMD+VVYDz0PGFmYHNbB6UEMfZdio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsxea744; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsxea744"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-649dbff9727so231019d50.3
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 11:58:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770148721; cv=none;
        d=google.com; s=arc-20240605;
        b=Lch2+Ndk1s+emKhTnaCx7NUmAI/TG8x9o3HQPWB673WeRziWcPBKoiucV+uSkvEYH6
         wDwT5xWoojiF1Taj6DkPZfIiuqsG9wJeP/dposGMpJSO5r1Ze89AbVRvlSnmCn7KeijP
         +oNL+j8SZ/yGgtq/W4dFG4/fgRnB3lnh8HVuO0n9Z41/IYsgg58O/+7zr2Dy35WKBa09
         SONFaI/mekKx+g+NGrkV+MfHpxS8k6Mm0e7qhwFoMnCQ+Ix5yJw/GHycM7TsLSPh1fnO
         F54ckanxQPy/2+wVhK//YCMv6U4OAqtrmVNq3uWp7l5RYTjr8jvJ1FMVu0wvxI7QEn7w
         ih5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5M2Wx7I7snwYCdTarJKvx8VkN0PGwNJoZZJ1pxZdHhE=;
        fh=QnVQ3wfWHPhiZMoMSXPWuRxIZpGYqet0mF2rlxd0t4Q=;
        b=i8ufFBuA+1btWin7MzXtpHxZow8Oq1EidjUvAAPcUdQ8j6Nbpy4oRvwcmPESgbySgB
         bmP53aGHBEH7GPKMU0Bd3APtvjnMepfLEZIjU85jQ+8cel+kvbl8z0m58AZGZ+ILGc4p
         GGCHNuQId0xHQYR43EhfbSDICWw7ti86matsQ5Y9qWNu7482BmaGN4Ggp/Do8+WYx/Du
         pouhUcXIdRQNEZ05OA7Fy1nVi1CrTT2zhi5bIF0JD4dsbZV5zx335kO2G+yv5XnwA6H8
         R5paEEjldiVVTO7DRnuY4nBjY1V1eAf4BZma2Lfc8GzyaueVtzHJvivLVA4MCGbyE9U4
         N9+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770148721; x=1770753521; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5M2Wx7I7snwYCdTarJKvx8VkN0PGwNJoZZJ1pxZdHhE=;
        b=bsxea7446FjJb91C298F7D2rJWwkzTlzrRpn+iuAiM0E4IrUG//hpzsmSZdufKBXeI
         jv8c6bcxu3rhfwlHGAgLG77vGPB0Z1xIZnlEPtJPUxUjgCU7W/46LOshVpq5xQONPcXU
         O80XYnoJUMm17fxMF4xrCnn+xokrhaaLGL9Inz1ySE7Amx5DgIyWWj2A0WdZ8fpXFAXM
         jGQ3HFMJuyVq/xxMOy6Le4Un1FyCiZ1H8fl15zqwnGVj9OVdhnNztXBLx7wkssrt71sv
         aJniUxehY9yhJigYITXBCNQeuFDvpkd1RpTPaE2CBviAGdyCIRinvRBelN50RhYbdCJd
         lnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770148721; x=1770753521;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5M2Wx7I7snwYCdTarJKvx8VkN0PGwNJoZZJ1pxZdHhE=;
        b=MTKTcRa9/LKppr48GxLHbIZ14QV64z1SGeMcxgH8RHl/11Cxk1mGJfrJvygg8/h8g7
         sHblqnLx19IGNhdqR3kz7uPOQx95za/4vkd3zACjMe8S4swinQea8ifnEWz5VFVr4P9b
         oBmFXd/khd2XR39uhxjTA/XNUA5AY5mC7BNE3J87N0shd+al+Rp1eZJTeIcPXhPVIAOx
         HiH79ALchdpISh92ckUuOQrzY+ctjP7z2RKzx9Gm7tCmq0FX8LEaxh7IA6gRcMfQL0Fi
         P8vJC+qEbWOz1UKu0o4MbXxiGpRFlqbgMiiOcTCDoLpvtFeO16fCx5Z+b6xEJtCguuZW
         W6ZQ==
X-Gm-Message-State: AOJu0YxW1lAhsa+Ok9AcQe71LNZJ/Nht/vxCP15qk3gPZNqn97eQyF2m
	ruATY6Vb0DjhU3wW7jalpLuj2AMvzw88ZuDBMyIGYqSFOYES6ummQ+XlUkq0orbHFsTh3BZSBKW
	pTDiWJ3It+AmxVhFewexYs9avIbCKCpLgjLjT
X-Gm-Gg: AZuq6aJQYlfF4U/HjLtbILzuLV0VgNWgpPQpEVeloVL2Q6yXmvJQ4cZTG/+Zug2BG65
	jTuxfY1/ewkdmKs96J+eIPoEYnIBEEeQNHiWk+5lPAxk2CXk5HMnKa9id+Yk1gnceMEb72NEJCH
	Ljx2G5ldHa8KrRx1wACg9kg2QRT7CZaK+dDp/gzlniz0WIHU/+nRlfdMnsC2QIo3t+K+zubM8Oq
	ualY1S/OhkSOmX2EJ7TH5yW4LUxDu7ckeCAUPTCV+zeqZKfame6CZJBJi4H0B6xWw5d+PVB967T
	DJJCnoUOLwIqeBggb+Nwk3qJBg==
X-Received: by 2002:a53:ba84:0:b0:63f:c487:17ab with SMTP id
 956f58d0204a3-649db499932mr525895d50.47.1770148721050; Tue, 03 Feb 2026
 11:58:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Packham <judge.packham@gmail.com>
Date: Wed, 4 Feb 2026 08:58:29 +1300
X-Gm-Features: AZwV_QgSIUpuq3zz4Jf-QFxQZpo9emtV2JOEZ8HLmHHjXAL2Ecb8MfXgT2xgOoE
Message-ID: <CAFOYHZDn-e5P9Rs3=2oS857QvYnHbpYq23x3RCkDWTTVGg5gNA@mail.gmail.com>
Subject: git format-patch --no-renames
To: GIT <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Git,

The man page section for the --no-renames options says "Turn off
rename detection, even when the configuration file gives the default
to do so."

But I can't actually see what option that might be.Does git
format-patch use the same config as git -diff?

Selfishly I'd like `git diff` to show renames but `git format-patch`
to output things that can be applied by `patch` (specifically a
version that doesn't understand renames).
