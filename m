Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2D230DEC6
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625882; cv=none; b=H0V/8XJszX80IHRVfQtoL+jPYurVBaDg8gHHlTFiqu4eu/5t/jZRyJ6++d25Iv39U9d7q6qBPlk5JmOgjpXzJTsyOYUBug79c+HyeZe7mWR22pIR7DC8G21lUcesO3COM4KKBAqliYRFBZRu0fFDPrfhPKdTkzm8WABJja9Y1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625882; c=relaxed/simple;
	bh=P8J6Hw0jyX2B0xy3f0cnockVso4JnB8uSNq6yvez3W4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YZmCU5m0TzQFzAdf4/6qC3DCdd18eIhV/J0EklgtYLyhhFvwxIYU24NxGspbsnLaUcB0DNh55zJwWZcZ5W7tCtSDmnuG7Xw0oWqjQKmgqZCyrz+zzpauSHAowfOoGls2mPhcchMCH9FT9spQupZoAvCfKfb90uLCEFfLzJF7Ci4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=donorschoose.org; spf=pass smtp.mailfrom=donorschoose.org; dkim=pass (1024-bit key) header.d=donorschoose.org header.i=@donorschoose.org header.b=UtoYUvK6; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=donorschoose.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=donorschoose.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=donorschoose.org header.i=@donorschoose.org header.b="UtoYUvK6"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55ce520caf9so6640820e87.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 10:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=donorschoose.org; s=google; t=1755625878; x=1756230678; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P8J6Hw0jyX2B0xy3f0cnockVso4JnB8uSNq6yvez3W4=;
        b=UtoYUvK6ZdAGrCxvCIwDHg+lxqA6Nq1IuYoV6xBl/1dtuJc3hCXaF802qddffNi8OH
         JNOFaQqfkF0vMfjV6HAK4ZlGTEjN1HTPpYcTUdSGCE19OW740hM4e2XwM3YrPFiyMcFa
         QnQk8UPyHBKEmxddmwG4R3aHSYkQg+nd5p7NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755625878; x=1756230678;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P8J6Hw0jyX2B0xy3f0cnockVso4JnB8uSNq6yvez3W4=;
        b=Jude81IT1T13cZ78k2aZdDxdD2GVktX3rZ8uK9DvRGPps8v/zGdBJFSO4XMI92ZJkx
         aScqbK+lcYJQH89vbiI0QjCIO/3NOEDB4p00kkq2COCf8JrVxSvDHYDJPcG7HuOWiQH0
         RzgAFPxwc1yAn/XSjJ+IEtINNDDa4mKuGN5VNkx2Z9wiFIQPwVgxfRwoI+4735tWypec
         52+ect5l/ptBL4f+cvqJaqkKkqGlOOTegIT2rlt6MrLHkgfNBoN/BTnfQf5F6dipk19t
         awVvRizWU/nzpopeUDh/KZIGnmzj4sLV5Ka5ms2FeS7L4EUeoGOGKj2xemyBaEIoNW3s
         yGAg==
X-Gm-Message-State: AOJu0YwUEoAIMYXs3xfn53EWvskVtGHF4j1MYLEF8J/0phqIggFev8je
	taKSABJiRwEvCNe9nbMYWfAoavHaO3cEepYGabaQTKIfaFYGQrOkDnbK+KcIX9yuw4heeDnVkOv
	qmf55Vs7z6LKRpiEL1BHjzB09rHzpZ8aZjEguyiq7wLiL0y2ocWIT2w==
X-Gm-Gg: ASbGncsWhe6P4plgrrGwf5m3gToRctFqGn0ETNPezPNwaxriDlAfrqTlqRo3RTnxi+C
	vcgO95jgmoJ0C/v7CDMYbxJBhfV/RCGSBxYXUJ9taSjcgFZYYf6rl/VR+T65nGVhAh6nRVeuWSM
	tViriUejuetUpjgZguNvmQg/PZIiV2wZ2aZk3v3C7vmJZdCfTWDlUi6kgOWh+ri5mLtyKtx53oZ
	k5C3q45
X-Google-Smtp-Source: AGHT+IFSy+T8QKh4C9G71sqQc1Kj3cIovZ8d/lFaNjpJY0hPgeMldVqJlguG7xUWHez7jZGoHLyJ078Tc2NG7XdWHEg=
X-Received: by 2002:a05:6512:3f13:b0:55b:91b6:4473 with SMTP id
 2adb3069b0e04-55e00795866mr986985e87.9.1755625878276; Tue, 19 Aug 2025
 10:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Judkins-Fisher <chris.judkins-fisher@donorschoose.org>
Date: Tue, 19 Aug 2025 12:51:07 -0500
X-Gm-Features: Ac12FXxIvQyEa_q8TCETPHzPULwgr-Mk2LGZ9tDHJrFG4dw5DmdMO3cIa0ki_kQ
Message-ID: <CAAn3O_2n75RGpvxv1o14BE3KFdwiJW9OOKaHp6_c0rd_MqxC2Q@mail.gmail.com>
Subject: git whatchanged
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey,

I still use git whatchanged

Thanks,
Chris
