Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA7648425A
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313510; cv=pass; b=oT46ltkzpgXI5lhHsm8qyyjRHTeAb3WiujxQr4YcdZ8DgJHrHOTRkqVSimbix4VxSmQ6CepOIKsf+BDuy1wFWlIQKqYob1i0aqQu31Q4k3tNNYhrcnfd+vwWQNBrH4SPl+RrWac9PTWi2Cg4oqQpoA+Z54Lbf+gQYdLFTsfkSwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313510; c=relaxed/simple;
	bh=hv1gm56ZzjI9H/8niYt5ZYAG9q8JEz8SIQid6pADHAQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=u+f8qoUGHXM6TOSyyKm9d4KwEFP8XBpZ4h/IF+8N6pdFM9LCBlkq+PW8WUnYtULR4C0Mp36kcA98GX/R7LsDA61Nuy/YbphRZap7K0pRRy2L0tMmB75TS6wnM8zOX1sEoDrm8TLi1uf1JxVggo3C8zihqV3glNYTJclPL6AWP1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJ5BRGm4; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ5BRGm4"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so917307f8f.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 04:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787313506; cv=none;
        d=google.com; s=arc-20260327;
        b=QVAiHlbn4myGEz3Ox6uMnaPMbRBhzGnZfqTyDu2jSGrwpWU46COjTR+bwRvvJd0dNW
         p/+2Nd5c3TP/ecPv4TuKDVk8oXJDPytokF0w82eJFvIyIQ2lghS6toYsEclT8ZXcD85K
         0cKMptyGEMPLJcn9vmL4mBKEiVasq8RIxpyD/r4rP8qEBQS1hfW2i1imAn/lKyJfGYo/
         z78UZGq2kdgJy/Y4PoIjv2zmnVeyX06SENXrUpneGcU09AMMnRdsJLBOKRy1n6v7F8FV
         Q6NayscO//+CC2kBjTR/NJ3KLm7uqbT8yt1FA+/O82h/JMXITkgvF3lpN3Hd71jHVx5S
         WMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=hv1gm56ZzjI9H/8niYt5ZYAG9q8JEz8SIQid6pADHAQ=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=Hhd8BxSGPK5GH+aAiWk77D7+hvR+67xILlieV8eoN8VIuFmKt7Q9MtMLbAwb4qHtcC
         W3RFbVr6echqXLzWDKRCjmxH4vAbvKXhA1rqTR7AdvkRKGuMxaLUcOV57kK7rtqEuAEg
         954SoBvTqFyyHJGamGsEfgavArdRu28prRXASDfMQTRcSeZ+++Huyi/vUywKxZ0jjdoB
         D3/yPJhcnJ8BkTVNQemXQAAtSct7/P/ZTs5eSPUcOq59aD4mBoUro3iW6ib9XYOXXn+Y
         CaapVLISyI1OOomXemdU1sBGM4AMbSlJKQ8YQuQHitftYOE3eksx5+wZ4BEwKMV3ZmeR
         QfEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787313506; x=1787918306; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hv1gm56ZzjI9H/8niYt5ZYAG9q8JEz8SIQid6pADHAQ=;
        b=cJ5BRGm4IMwyK7r2wc+DL0eHef7HjBH3g7reXVCJSU80YNb3vrt1cXbR/Vc/BZvZfC
         rQCZjItOJXeoQ9kknFMcoTYqDMKHhr3wHBHACVpDpKeICPW/U8y+k+tYV5WDj0Vxz81n
         1PjAxJOhiayx7SJM/0oakE9uJwUVpu/WaIw3ImBG8CL7kbor3M85497s8BeUaa06cxTh
         pgTO/gymI5IvyiBTl0RwLdDBSoMQV84VGkCFWI8Mo88cjYq2W7heFzLbwR346RvZtY5o
         FgNbHCkb4/sMubTNFH5egIeLC8XuqlC0z2xFd1uuXtFngigZiPgFGsVVTLvHbc3auSsR
         yvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787313506; x=1787918306;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hv1gm56ZzjI9H/8niYt5ZYAG9q8JEz8SIQid6pADHAQ=;
        b=F4VD0N/F8Oq109M9+7vgqdUDORj3iS7+bkDKWbK7TCJZqHS3c3cLQNymwj4zC5uiar
         yfq1BROL1bJEgX3zOUUCLmgLeuboynvadYcUv9w3Ay+RuPBQBEP8eEagtduTR1aReanz
         7SyQuvBpsWJNzxTkp0oIbOBusyvvmlG/I508vdLzM8/v2EljnxY2+f53JlK5EXAbpQOU
         4CAN8BpQaFpfhE1Bf3DEnivytrAgbE0UlxwhVrw7yWboTrJ81Ifd6CpG58GnBq/XmvYX
         8mstV8nsSKvg2fm8OsqHm8e3t0/oX7GKOBVYGs1ATjzzcJI0GX7SsNUXoBy/xspBzi8y
         w45Q==
X-Gm-Message-State: AFuF++leJEYKu2ak9dMdew9VwA3CYDWWhB75nTUmLOIYqkhpgm2/qUhm
	k56rRpHuEF11mE+kM1F0S3PntZ3FZv53A+zx0gYV+fzg7uF9XBSxdggUeyVBDgdCs3jx5WvFf68
	sa5U0IIzGHH78N3OJ4nV3z85qUpardTsWMRzz
X-Gm-Gg: AR+sD102BRBSXWNMtFvh6uniEQoCDIr5TXw9F3QNNnqZ9eGz+zdar1TgL4PF7GzseY4
	qDSoDKAWAD4ZhVjwd4so44Vg1c2HV+6qI8TSLoaaRj1C1s6sMGpeSB8qb9Kt74VAQHoC84gcZ1x
	nGapWUxDKWCpUODToIls+V795mrWmwBKX9dsnrMp85Ugr0MiQ0pGcaV7hwY3B06POBDZojxnkr9
	hpyVQ1oVF656LkvEum+38goQlxG50VDzSkx61PUmT2VPMRxuaBRJ5Py/WOpOcrU2V2hphLv9lNY
	1t8WDqcT1/x1IemIjVgZVdv140Q0GyqerAByVLmKm5tGeAta9zJEoaPD
X-Received: by 2002:a05:6000:4b16:b0:47f:f1ab:9075 with SMTP id
 ffacd0b85a97d-482c0bb16f4mr9570461f8f.20.1787313506217; Fri, 21 Aug 2026
 04:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Victor <sgm2005@gmail.com>
Date: Fri, 21 Aug 2026 14:58:13 +0300
X-Gm-Features: AcwNN1UFX9u9vN2SjVm83N3CULflplpFuGRtAJZOuKeJZxrgnjb3uOUPGfzh2RM
Message-ID: <CAH9cVJTQxBsKAA1DRUGj_J6B_14dsX81ZuvN_rETY7a-QvZQLQ@mail.gmail.com>
Subject: Possible bug with sparse checkout and submodules
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

git fetch fails with default fetch.recurseSubmodules=on-demand when an
updated submodule is excluded by sparse checkout. I have a
self-contained reproduction at
https://gist.github.com/balakine/c15a268fa0644be6c56225cefc70a7f6

I wasn't able to find any existing reports in the archive.

Victor
