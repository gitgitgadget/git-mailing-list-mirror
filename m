Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C99730DEBE
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509380; cv=none; b=mDP8Qg3BZUu2elOEI763WBI3tAoXwxmY0eO6magr3gUjtN6elAp4U6fNS7FzAKWyLRGrsg2MsmgrwCLmh7zRC6IxmjVKE2bdn8TO/Np2iIlmNCWwqUt/pQpedVOUOQQLIuvX3JsoFM8x4NVN9UI0soZMle3fkEBW0o+f++Vvj5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509380; c=relaxed/simple;
	bh=wPkHcXka7clk0E+h39bzNztXrXa2fNJ5fqihaMkN1JM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=FgEQerVG2a3nowrj60/h2dAg2YYLQYm2rjPAEWM0RnNPGdZvDu9l9Ra+cSEfub6BhXYM/ipjqfez0fFCNxmAzkeZn5IcNdtmVu31BRCzuvrfo1UDhwEPr8AH78X1qhdsWe8aJ32tf6IUFGoFv06H8U/77j5BNUMMnQka1kAF0QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOg/wXxG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOg/wXxG"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so2483917a12.1
        for <git@vger.kernel.org>; Mon, 18 Aug 2025 02:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755509377; x=1756114177; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qy1pXngeCUuLpUmEvyZyurLNJozys6b2dyHcRB7yxcg=;
        b=SOg/wXxGy6SWkl6NAQOeAh8OF8njmZi+tmYyqXFQY/ZZEaPjVkCb/7gksOeexItZTj
         p2uRR0QbTVbTNI1cIxx2wIDHI/RZnUVBaIH7urjOLjFjOqi6s5XYla0epRPvvSVgBifN
         XWMjMsWcq9ONsZinmIkG4PZw9+BYWTIDcrzGyYz1wevofO7jXNu4FAQTFyvsALgVj1G9
         xw6z/PjO0eJYA+hloIJ9aK5oRE53ViuTxBg0H1FYNmvwgkGZk5I8Kt7z7+CovHPvKcEe
         bFPgmy46lEtU3m41L2QCV/6vCWb+Ug49vMtQLoQ2rOT8OsClj1MAe5cVFo45uoRh3+8M
         T0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755509377; x=1756114177;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qy1pXngeCUuLpUmEvyZyurLNJozys6b2dyHcRB7yxcg=;
        b=r/TDBKqUv/g4l7u+0yUUpVztC6JuQM6gVjs1CAqdjx6RygiCkyyn+GVpzYjGrJeFaa
         EX24htLlJOfWthzyne8MMJxMw+StL7zeWzMeLMPPJl/xPNslPzZ8Fkzot/NXE5qB0XG3
         iHLdy3TG6ml4DepF/xWDTUot+/NZp0sP1MlJClnriEhan/N3V3QoZPhzEnHlQ0EVVMWE
         HBH3IGoQvv7gmDjc8ufM34a1AGe2EcifavbFrjlrqoZLoWi4xmTNJzb+PTjjMVXfLWlD
         klk5fGr0xFB10f+yv6SOs5cCBZXJ5D7+V7VfK8epa8qcv6+tcNrUEBeFXu6yTAXsKEQW
         Xo2g==
X-Gm-Message-State: AOJu0Yxlh8Bc0GFZw7T1c2dfsfKV7aStxSsXRArmEMlqWT1nbglLHpp7
	y2nBevOiJQDNBwLAPwkYJez/ZZ575+1TF0fUXU2dxiEZ1E2n8NWw3+D2Qw6gwWdolGnJkcWkbWr
	6netwuAYOCajSwFOQDDrTwX5octiSWIICoNhkwFs=
X-Gm-Gg: ASbGncvtPP2ZLlKEIDWytNyoLN+AKN8I97l0fMxbQpB6R4X756mXG2H6pWTWbQ2Fc6x
	4W/rbrmLKazamdCfK+GpISOb/21p+aFYQLMynIwmRb5+dNHwQnALmEPAnDU0inclkMVI2Y8GRrI
	LEa4qf8BXyKA3Sjy0z3qUR7XRF/1Y3R0EUJ1RWU39yZrMTQBqStjabQBDwFVzTlkSV8Sb9Xabt/
	H14Y5OoDe4fitirWIVQnsyCc0DY1uhw8jda6rJ5sz/+D1Y9dx8=
X-Google-Smtp-Source: AGHT+IHi9Qv2XJ0de8C5abPK7VzURr2yuDIWnGOTc+IHCoOevOsBXEOW+vwQQMEiE32hx1CSjsAeb4SvkxDgUgswweY=
X-Received: by 2002:a17:907:2d12:b0:af9:6863:9d41 with SMTP id
 a640c23a62f3a-afcbd80de7emr1567061266b.14.1755509377382; Mon, 18 Aug 2025
 02:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ayush Sharma <ayusharma1706@gmail.com>
Date: Mon, 18 Aug 2025 14:59:26 +0530
X-Gm-Features: Ac12FXwpA2pf_q6Jq-TAlzJ6c2jVm0uzZEeFiJNT-TPBDf_NgCcw3IXwoXtmTf8
Message-ID: <CAK8tCCJEAt33AMkPKZazcS1h9PKFig2ixCUC4V+D6--jyTuJnA@mail.gmail.com>
Subject: Inquiry about feature request #1665: Conditional includeIf by hostname
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am writing to inquire about a feature request, issue #1665 on the
gitgitgadget/git GitHub repository, which proposes adding a "hostname"
condition for conditional includes.

The proposal, opened by Diogo-Rossi on February 15, 2024, suggests a
new keyword to match the machine's hostname. As noted in the issue, a
primary use case for this would be to simplify dotfiles management
across different machines, which can be cumbersome with the current
approaches.


The example provided was:

[includeIf "hostname:FIRSTMACHINE"]
    path = /path/to/firstmachineconfig.inc

I noticed that the issue is still open and does not appear to have any
assignees or linked pull requests at this time.


I am interested in this feature and would like to ask if this is a
direction the project would consider. If there is interest and no one
is currently working on this, I would be happy to begin investigating
and potentially work on a patch.

Thank you for your time and all your work on Git.

Best regards,

Ayush Sharma
