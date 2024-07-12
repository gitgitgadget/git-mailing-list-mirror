Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292A97E6
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 00:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720745870; cv=none; b=XAh0ffL9R/Fv3ju6DzlD/r1hGhTOvRNepLh4eXj81I+qTMEg2ZTF6aOcbGuX18WbuafwG99ZiaU6i4qWi99mM/p1C64596RqAS957d6Cgn1Y9zOCXArU4+HUZjy7gsJjIvav26GMgNsP3uNbVBpgnqsmSgBpKR5nYHRZCVqERhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720745870; c=relaxed/simple;
	bh=kp54TKX7k/2/BXjaO1dPdl0c1wfnbUPzljXZp24sVIs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=S0O5FdQV5DQccSpvOl9coqLN8Z0OjLbaGuPYdMimCrEbLPO1SWwvvNFYO86eUVoepePpeNE+G7EWbPNPOklE3FkV6JntExpvLFHitQoKiafbOkP/vHiAXNS7vqCaHHTKS//X1vSIro7REiKGyroIdhMOS0QWJnLVzNCGt4eq6t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8RzOF6z; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8RzOF6z"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70b0d0a7a56so1376345b3a.0
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 17:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720745868; x=1721350668; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtsB+BgsO6GixXcMGhD1SyQ7tW8t6IPQw+vREspTcl4=;
        b=B8RzOF6zrh+9kLaALgUJec2EiwYqCAyUjm0dweiviJyoHnD7ViVIehDk4LiHr0L8m9
         +6rCGV9a7ptoIonIw5SAK8JirQgX3Q6pzuwoAODBEvpoj5x+yuinKocxbl6GYo7xilUy
         Al7t9B8Riz66Fgrwf7UmwzFQ/1EVTRx1ICziLiHacTgkSLWwoI4bijv2GdtiAzZVi1fd
         T1P/G06Ueah+VECCULlXZEIQvcn4utI44NOyimEfYt4HKwzspEEAyBWvHvjjb/az6lmV
         20hhs3HlJQkIfY4UlruiPyEQpizu+JhkHIfe73AG8nz84S2XgsVrfj2b5vJJAFefdGpq
         ZA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720745868; x=1721350668;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TtsB+BgsO6GixXcMGhD1SyQ7tW8t6IPQw+vREspTcl4=;
        b=NGDPXMKp9dV/Sknaj7kGCNtwEOVD62ysYhUaBgcq6or8pqeX5xodIkrzEex+iiu5bg
         axwBJmRCXJrqI9jBQOjDB2cOqpFJObuMuHnOaCrEG+ItZyfDHfxUopCd+s+GGaElwkjs
         o6S8UDJp/suyht66RgmJMtNsW7+VeYG2rg+w/Gbhu/81UnPDDtZGyJf5zeVkZHXbekMY
         LZZ3Y6oj/h4r5VsKlGa1j2UZ85V1ktc/ZARIYZKCG3j+Pqb9OFwE6aaBWJQ28r645i1C
         SA+GS7Fv4lbtZi7vSDSGbCc06ujBkQ4RuqQbtPDCR7tc9sN7QlLvDwcTm7lgblGLXHhU
         t04w==
X-Gm-Message-State: AOJu0Yzt4QGz0DrNVa4YwIG7KTCD7Q4nGlRAx4EFC/7YmGn4K74Ittr/
	C/i9dDbU4JCYXrSe4UJhd1XOR4rDecuzBzvxTeGGuTEJO6k3ii6xc5TgSg==
X-Google-Smtp-Source: AGHT+IFLfc3fpK8tB9WaGHXVWctBmy7YGk9GrwGb5ov/DoDCI75u/aMU+ZrI2fmUMrwMWUg8PdxL7A==
X-Received: by 2002:a05:6a20:7484:b0:1c0:f23b:d360 with SMTP id adf61e73a8af0-1c29822092cmr10626201637.20.1720745868277;
        Thu, 11 Jul 2024 17:57:48 -0700 (PDT)
Received: from gmail.com (p4357013-ipoe.ipoe.ocn.ne.jp. [123.222.98.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab75besm56254325ad.148.2024.07.11.17.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 17:57:47 -0700 (PDT)
Message-ID: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
Date: Fri, 12 Jul 2024 09:57:44 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH 0/4] use the pager in 'add -p'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm resuming work on introducing a mechanism to use the PAGER to display
hunks during interactive "git add -p" sessions, which will make it
easier to review large hunks.

The thread where the previous discussion took place is:
https://lore.kernel.org/git/1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com/

I'm bringing back the proposal to introduce 'P' as a mechanism to
display the current hunks through the PAGER.

I think it's sensible to exclude from the scope of this series the
option of a new command '|[cmd]' and other modifications to the original
proposal that have raised questions that perhaps deserve their own
discussion, outside the scope of this series.  Questions like:

   - What to do with ANSI codes?
   - How to allow the definition of a default command?
   - How to facilitate the reuse of a command?
   - How to combine a default command with command reuse?
   - What to do if the command fails?

To mention a few...

I'm also leaving for a future series a possible configuration
"interactive.pipeCommand", "interactive.pager" or similar.

I hope this approach makes sense and allows us to move forward, and that
it doesn't represent a step back.

Thanks.

Rubén Justo (4):
  add-patch: test for 'p' command
  pager: do not close fd 2 unnecessarily
  pager: introduce wait_for_pager
  add-patch: render hunks through the pager

 add-patch.c                | 18 ++++++++++--
 pager.c                    | 45 ++++++++++++++++++++++++----
 pager.h                    |  1 +
 t/t3701-add-interactive.sh | 60 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 116 insertions(+), 8 deletions(-)

-- 
2.45.1
