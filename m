Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956DAEAC7
	for <git@vger.kernel.org>; Sun, 19 May 2024 07:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716102427; cv=none; b=PO2c2XeO/QcuCjlkRvck5N3EjCS9tC0ntXlWHDdQMrIUggIVI6pb8SshR2irpXZLxWb4W83kwOn1eW5rwlD71Oi2LRvDobSzNVcUP5lXBy8ZL+Tb7c8dpj6DP+9y0N6BNXHUa5KGf7vA4Mw2WX2U7wcBrwHQPWG2qLNNaEoGtlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716102427; c=relaxed/simple;
	bh=i0hzu05ufHgif+D3fdWKEDjf+AFCBNdwSyG26fFIPjw=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=ubERtrhZD6Riy5JCGF7IZW+jyVHqFQeMxoHF1gFT5NxPSWdCTrJ9GCUCOm+c9foOWpH9f+UdbxpyCheFK5ASpjn1qtZD/EzVcMHqFymnH33sHLdqCMUWf6PUJ1mAIOK1fGG5TEdtJcUXbJ/2GFhm7pYiE7R03DhbXU8HJ6Fay3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hE2V+uHU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hE2V+uHU"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-420180b58c3so11985605e9.2
        for <git@vger.kernel.org>; Sun, 19 May 2024 00:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716102424; x=1716707224; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWm8hrKMTIEI7G3iM6xli3n3mzYP0kaVC5Ip47xVI+I=;
        b=hE2V+uHUBPXrk8VPQqW+E+kkCHD7nzyUyDxQatxT8w+eUqCEUYJPaMN5M2lz8QebPY
         ohA7nnt4lpKfrHi5vFBJqsh5yvQ6F2R0yFE2LfvHtBLdKbbFiPw2+gor2z7lfP9KAa9i
         ywD7ThjlS84Cb61lEKU+yjJZEQQfKNqBcDhCJeueRnxgEoaz5KOgUoAVIU/33G9lQGKh
         r2ulP1+MapMYPahHJkwDFk12ogZ4fK3K8hz30hCUfMLuTNfRTj5CE0xqU70Woz9d7jgA
         io+8312g3Z9CQm7G7UWeDbveM5ZyPqENinwjoNQIly89mPPUNRoXXSgwrQVR7armCzJH
         ATWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716102424; x=1716707224;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XWm8hrKMTIEI7G3iM6xli3n3mzYP0kaVC5Ip47xVI+I=;
        b=vISBMpfwx6dcBriGfU8v3feMFe/NAdP7jb6WxOQpYdG9pD7pKn4azTxTcyYj3b3/NZ
         LBZCzs+bZd7GK9JntpdMmgPm0l7O7lI/ddy36n0qI8oVuRzYTPhDKFzW/o8HQb9jM3Pr
         zJ8wU5djDQodZAcSQWTDC10I87EQuEYJq6p03XZMx1aE3GjZMgAGQhVHDhztAxNUI2XM
         GHrV4oBsJ85AISADO9T3UawJsFyF3t/VW6ykqf4k1B9O2gRGNao46Oon+TSMKuCXnvTs
         pHTQDnlpkAy/DfVCxGYNttJmVIOz8ZA1lFSNGV9/TymZBimsjqZ4FMn5iWiG3zG3fViD
         J06g==
X-Gm-Message-State: AOJu0YyIotzyssIXSwuZBB29ZDcspT9tw3/Dm3ykvd8P+4wdMpDhUhJV
	t/wtBhmVti/n9ezclmJNNdTOIRk2WLvVXiGUIw1pqNvrWwHVJRXz0xItwQ==
X-Google-Smtp-Source: AGHT+IFzENqY6pZ2soElIuqvy87+e8YJ0d4yRwL4bbe5PaDglJFhT/UyHcgfxd0JzRGLLz0w30yy/Q==
X-Received: by 2002:a05:600c:444e:b0:418:c1a3:8521 with SMTP id 5b1f17b1804b1-41feac49149mr203220485e9.26.1716102423788;
        Sun, 19 May 2024 00:07:03 -0700 (PDT)
Received: from gmail.com (173.red-88-14-51.dynamicip.rima-tde.net. [88.14.51.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fd97e842csm362825985e9.24.2024.05.19.00.07.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 May 2024 00:07:03 -0700 (PDT)
Message-ID: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
Date: Sun, 19 May 2024 09:06:59 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Subject: [PATCH 0/5] use the pager in 'add -p'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Invoke the pager when displaying hunks during "add -p" sessions, to make
it easier for the user to review hunks longer than one screen height.

Rubén Justo (5):
  add-patch: test for 'p' command
  pager: do not close fd 2 unnecessarily
  pager: introduce wait_for_pager
  test-terminal: introduce --no-stdin-pty
  add-patch: render hunks through the pager

 add-patch.c                |  3 +++
 pager.c                    | 41 ++++++++++++++++++++++++++++++++------
 pager.h                    |  1 +
 t/t3701-add-interactive.sh | 37 ++++++++++++++++++++++++++++++++++
 t/test-terminal.perl       | 32 ++++++++++++++++-------------
 5 files changed, 94 insertions(+), 20 deletions(-)

-- 
2.45.1.209.gd5886bf9cd
