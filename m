Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057E3234989
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873457; cv=none; b=n+7eGIH/2pFG1kXJhCvoDA/LsAp2mk5Bozif2SQVwldrRgOmNAGhlAhLrlDihoIPkmiRzh9asBJS4DdveBf/D6fxxINFzpEsY9LjvAiRNfHb3tW4IfCJMKlyYsEhCh0gu8FBpAcjpFpZYdb2Xq1eRh7xpqDvJkVniDkyJKns7js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873457; c=relaxed/simple;
	bh=hiY0o+DGuc3e+Em96CyD/H2Q6LYDNl79CS8HlaPvOiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhHatV+Z7IawznkT47e2c0kjGJx/cw27j7l8cGEXFOgX3TOPDwMW37qXE16bfF3522h47RNHMbzdocXCrE7gmFJC/DRX9vzoy2PoHuo+X1zJhXAK15csCOEWqRpWlFPUwQm3SwAfb89v+CbdtTorFd3vSRHEYGW5FiOCd4rRlG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICGCSx4G; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICGCSx4G"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abb76cc6108so30922866b.0
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 02:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739873454; x=1740478254; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hiY0o+DGuc3e+Em96CyD/H2Q6LYDNl79CS8HlaPvOiA=;
        b=ICGCSx4GwAaAjJRt6LqlNo29oLpg68ap1zKMtoB8GjtDMGi3wSlRSypN5me3wiYJkq
         S3ZrI9CGX1K4gdAWP1uixJc9kINhQgzfMeDB4VbH4p9NDVBHmUsNtg2Q7xs4EEJzRKdc
         8HLXn6IjRa0bHBPFtB5s7k2E2nS2jPgJM2jd8Yjd/cRiVK01/awcFgFnlTXHLjJLsDcI
         9+JgKdAkFvXZ+DadTerRkXCwFew4lnZO+MxmogXybY4PB4/WOhKwg1i+IeU+0plngNPi
         M+N+h/prXFLciAhbI5ATVYGmveME4FMsy9jgrgtItkVCEOqMterVCzq5BfDC/WSX5UPq
         qi6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739873454; x=1740478254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hiY0o+DGuc3e+Em96CyD/H2Q6LYDNl79CS8HlaPvOiA=;
        b=IaeTXvk7Agh9DnN4YJ5V90Tvm6fkUp033Nfd7Qs+l5qK2PJl+U5sW1YBlKZBRFxorN
         Wf/8pHOtIxv92iQAANtj754+whEieiPqgwt5c+sIzcgV6E15FgrhtFuWUoCYyO7xekOo
         QbR9qyl8EQFNCn3zP+BH9YmsKOeVNbGCxcpCNX/jPGpbA4QS6zDtFxoS1JL/NBTtopsE
         VTgoFzCeQc6DYNuQKpUHogIB1kZZus1sHVf7yOG+pWRh06+RQeVXJqtnrVKfYh27DaIy
         D8IcYM0wK3DHoHt3IQe6/VToboJ//pdxfoMBfNB1/n5X245SvJ0f6VTjiTd4M8fEssBe
         pi4Q==
X-Gm-Message-State: AOJu0YyOU1bx7E37SXDae6dnbxRPJCrtCtpcxHFP7tVmvsA5XUyAHyIJ
	runB31lwZouHYbdNG7zfWu3wghOlAFt5Zq1FM2p022LwYNFLl5+ojlIPZonnud5TMHWBkFAfxSG
	9RbCSf5etQBoCv2kF/KTHOG8SmPY=
X-Gm-Gg: ASbGncv169zyjNaJRrrT2gHqD0x9tztP9Uh0/6nIlK1K7UjOjaHAcwdwoGARHvi46eU
	VkoqIwXhG24SCFnD0AgfYO7eXSZ9w/tofpqCuOw3DRfElWjmcwK6pzxZ6m23KPQ5L2Qfwyo8lJo
	4=
X-Google-Smtp-Source: AGHT+IHuBgqVtV6/Mybqu879brzS8atwOFWeTiu4tEwPggK5z6b1ZWvtjDzpnHUuEkH9KOlQNBoSnZC8Yop37UmRbdA=
X-Received: by 2002:a17:907:1c8b:b0:aa6:ab00:7b9d with SMTP id
 a640c23a62f3a-abb70ab8b52mr448898566b.4.1739873453951; Tue, 18 Feb 2025
 02:10:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
In-Reply-To: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
From: M Hickford <mirth.hickford@gmail.com>
Date: Tue, 18 Feb 2025 10:10:05 +0000
X-Gm-Features: AWEUYZnXjvI8hDBZo5RbJMZZ0VQfE7QC-3UKJahGrYxKfXizFpAoptpf-VNp4ak
Message-ID: <CAGJzqsnvbe8cf6_CN-CY3D0NmtDy1sMEOztH4pCqEjyA6qvf=w@mail.gmail.com>
Subject: Re: [PATCH 00/12] meson: wire up bits and pieces from "contrib/"
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> This patch series supersedes Mirth's patch series at [1]. I have picked
> the compilation fix for MSVC from that series and retained authorship,
> but with an amended commit message. I've also forged the SOB -- Mirth,
> please let me know whether you're okay with this.

Great work, thanks Patrick
