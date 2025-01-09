Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9A313B2B8
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736458318; cv=none; b=J9Z8IfVyqIbrMHGLcTngamP6S0T5yP/GkGl0AUELy2yrQawpM+1ds+kAkPVb3WZz1yKYHc5oOr05vV08WXD+DciBDTCX5ye5DlopJGvjEG/puJlAr8pCjuhu5IKn3Gq2Tr5/LtUHyoxpwPCTV+jzV3igTXEDQUd2IlOllmAPSwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736458318; c=relaxed/simple;
	bh=0Vp9YjHt82XT4CT/cbpjFxxeRoT40YCRvT+b+GbssZs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Pg3xA3QRn7Eb+UBNoKYGnqqAQB8ws06RMYArCZPPyJ1akPA8Nka7+Zt/S0tDkX+uzaTcDo/o7w85PO8E1l59brBobkzlqP0PcNZpC8DpEHmuWzzk+YIcgXSKLU2mMmKPMx+FHK7RGcCQAYpXi2EP7jRxwqh9RumHwiQsWXXszn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2xVLlt2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2xVLlt2"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2164b1f05caso23570335ad.3
        for <git@vger.kernel.org>; Thu, 09 Jan 2025 13:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736458316; x=1737063116; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Vp9YjHt82XT4CT/cbpjFxxeRoT40YCRvT+b+GbssZs=;
        b=K2xVLlt2t+OrmtovAj+LkeTUFLfw06pSnaQjfSImo03lARKKivALS0BGdQg/WvNLSj
         QZQEslzvgDcG9y+/f+Kog1WRNzoFC6WT7VVvKqEppJkOA3UqHXSo0llxDzla0obNdew8
         bbiRoIz/AvcOFmlahJrfd6DjBpYk9GWy5qjjaIXPVZU5JD8JYoBnfPNtTYNPpQ4HLOWE
         y7MC4gOn8NyMpYnLodEt/BD7yi9gT42+bEQXZogaKRh7bx0fhucHf8eKjzmaA6YkXIKD
         WMe2GOyIM9yt31InTGyebo5uULvRdMXvjanwuF6L2/mxfm6lXSer6WKJe+JeBiU5iTqt
         gwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736458316; x=1737063116;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Vp9YjHt82XT4CT/cbpjFxxeRoT40YCRvT+b+GbssZs=;
        b=moLGZedpEqvxHRskgpr9P9TaGsYHEsImwVDUocBZ71+7/2uEFmXmH2YsAQBCye+pb3
         RMtLRYqX3knQEQFwITH1jl1SvTEuC4qBaaUOsGPXj66xtiZly4J1qupxrHZaM1H8OJWX
         5I+FtwrMjxxKHpuA/OsTCmnv1rgUPJc104Qpdv4RX/o4ub3GJAx9Fe7ULHEajnWp69g7
         +d/GdbBOujHEn534B4X+BrfmQQqUd0ts0KhDmT1sgrW8yC/UaeJ3tLG9pRhS05xngRFR
         4yEuO/6X6p2+23OiknLyION6X9JX4mv4itjzl2n8A3bVYSfXTftvv6qPnT7pNuW8eW7S
         bHIw==
X-Gm-Message-State: AOJu0Ywgpsi5eNLehzJ3Rg5GBjeb4ZDXMjdv5yKQ2fCzxlWq9xM0Wcuc
	RNKl/+8uQsUR88fxpDOYFnbELM8oDbcB5tRc9wg8YmorQeu900x5wBuqG6pYz85rRXqYnNyRmpc
	aqKto3Pt9c51NnGh85pAcqo1bS2nytxUitGE=
X-Gm-Gg: ASbGncusbkG+LR3U9dHivTgS8Dyse8k7L6iSioJMBLsX3mj0DTnG+i+NjUN1mnmofsS
	jbLPN/395qyBlrRTEeXsCUgrZEH/OZhAuCoY+Zw==
X-Google-Smtp-Source: AGHT+IGM6IvSiM8b/wCdPwy8R6j1jJKkEoUpb/LFNCEa9fuWc3eQgOwJwgB4JPIr4ax1VTuYCzEmEEC0GZvH6j6NmV8=
X-Received: by 2002:a05:6a00:66cb:b0:724:5815:62c1 with SMTP id
 d2e1a72fcca58-72d22048b6fmr10886095b3a.19.1736458315641; Thu, 09 Jan 2025
 13:31:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Martin von Zweigbergk <martinvonz@gmail.com>
Date: Thu, 9 Jan 2025 13:31:44 -0800
X-Gm-Features: AbW1kvY7nxFh5uiBwQiIgbCRYjdez8xSwKbxNI8yg8h7lFIB7LK2ARsGDzZbzLI
Message-ID: <CANiSa6jtwizbR4K-DqdKjVeZqAkbswnPXCBZZrrfNy2CKBEQVg@mail.gmail.com>
Subject: Histogram/patience diff matching lines with different counts
To: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Let's say you have this a file with this content:
```
a
b
c
d
e
f
```

Then you change it to this:
```
a
b2
c
d2
c
e2
f
```

Note that most lines changed, but `c` remains unchanged but duplicated.

Now `git diff --diff-algorithm=histogram` will show this diff:
```
diff --git a/file b/file
index 0fdf397..7cfb042 100644
--- a/file
+++ b/file
@@ -1,6 +1,7 @@
 a
-b
+b2
 c
-d
-e
+d2
+c
+e2
 f
```

I'm surprised the first "c" line is considered unchanged. I thought
histogram diff was supposed to first match up unique lines between the
two sides and then gradually try higher and higher counts if there
were no unique lines. In this case, only "a" and "f" have count 1
(i.e. are unique) on both sides, so they would be matched up first.
After that, "c" is unique on the left side but has a different count
(namely 2) on the right side, so I would have thought that it should
not be considered matching. Does anyone know if it's implemented this
way on purpose? Actually, I think I remember reading that Git falls
back to Myers in some cases, so maybe that's what's going on here?

As some of you know, I work on the Jujutsu/jj VCS
(https://github.com/jj-vcs/jj). We also use histogram diff (and only
histogram diff) and actually allowed matching up lines with different
counts a while ago, but I thought it seemed too arbitrary to line up
the first matches if there were different counts, so we changed that.
Then we got a report from a user that Git behaves differently. See
https://github.com/jj-vcs/jj/issues/761#issuecomment-2581219294 for
more details.

Thanks
