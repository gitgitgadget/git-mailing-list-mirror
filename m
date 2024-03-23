Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AEA2940B
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711215163; cv=none; b=krcC/yEeUzRT1AoylIPEjbWlyp3GzYmv0CGzrqMECIxLeSJCmWWC4pkFMAu6HJAF/8qDR6ZKyr+1jBh0gorMPK8nHEdYsb5z1VabxwQ4ovxKlPPKn0oA0DRacAAed0DZYQL91cJHXZD+IIhcgvtPtboT9HDglHlR5G6nvU6mM1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711215163; c=relaxed/simple;
	bh=ZDztTMuSXCmF4cW/nOhMAdklkT4FgRXZ8UoBsn3vdwI=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=KDdvslK/bbt7/z2I9fBN+daL4X236enBwPh/ZbZVVpHiPOZ2Ad2jymj3Rcohd0E4Lh3iEoA9J5Kxf9+BT1lvi5b4HfME0o1oOY6NtkoMZS5pXKWgI17s+auYgeA1ZpAzlHS9PC1D7FIhJJUd/8E/jyhp8KpXYsJP9OEEy2xogbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aknsB0Gb; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aknsB0Gb"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-515a68d45faso212538e87.3
        for <git@vger.kernel.org>; Sat, 23 Mar 2024 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711215160; x=1711819960; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDTIBIEaIz063U0IYFJ040YSOKsHwlYgnEBpmvS5ae0=;
        b=aknsB0Gbj4F7MHxyFujgbq6rPrU+SmSr5zKEvPvjw1doKZ5azOMp9gcxRaqmiy8Pzn
         JUGdZT+sZW4JJtU7cr8/Alt6L0LcENrdsFj3Gz6XsNEmMTcATBJk8MzJJOtaxTFeUQtv
         J1+zrQ62WakJkdhndZsqLN4aHnE3fvty1V/QJhFX/noot+tnvHD4PuGxC1L24I3BFFvi
         Pq000ANjZ6D1UbyiaxSSqTNtoCf+j6EpdM1XeRCdKiJCwexnBK1r2GerALaPYIGc9OkP
         NWDfT1edSVsjuG4f9nJkq8OEkygxGQQVUnytB8KvUlEqLHvV4StYefdEzYsqB/meL31D
         BcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711215160; x=1711819960;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZDTIBIEaIz063U0IYFJ040YSOKsHwlYgnEBpmvS5ae0=;
        b=OeRXyYL8pbv5XRI8kJgYV8R2LKKzB6q57qjY0yS8tz2EBzYWg3VytLkwWHs2VdeBMW
         ZGKZxnNwkezTO23Kh9n7IbqJTZaXahljpqSMpyBDYzVQbOBs0nGUkG298mdYFSPNvqkz
         ADn9Vjt/+NR5YGIjgwJd14mWMrPFs3KvuzHw8Et0EKEk2eN04Xf+oEDSAL55GdF1ehG6
         Xb7JgFe1W6q28cvqMT+exY9heieYhK8FvaLBEWkROK9mq17a0sUIgAJnEIPPb7rgXdHv
         R+t54nPz4QOP/fql1h6E5f9jLDD9uhMSFD+CEwGnUg0XeztRSfW4+xn8Cw1/Ekw2bCtN
         5Ntg==
X-Gm-Message-State: AOJu0YzQo5uzwvrn3WMUwn7wn1mt2H4R2cK9oKO+xtoVm5JIR9cFkZwy
	TKJag9bsNsLJSzfEY6fGav4gr+waU+pIczW5udyBEYe2pEQI1Ehd8jIntOni
X-Google-Smtp-Source: AGHT+IH6kKwQGczmmYniRclJwE2APu8zQ6YZwHI8wT9YWzXjEPNudmDt+ddmRSTZ+GDcFrw4aJa4Fg==
X-Received: by 2002:ac2:5201:0:b0:515:8d1c:bf09 with SMTP id a1-20020ac25201000000b005158d1cbf09mr1539799lfl.16.1711215160376;
        Sat, 23 Mar 2024 10:32:40 -0700 (PDT)
Received: from gmail.com (181.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.181])
        by smtp.gmail.com with ESMTPSA id he9-20020a05600c540900b0041485b34a25sm513348wmb.31.2024.03.23.10.32.39
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 10:32:39 -0700 (PDT)
Message-ID: <35de2d76-a03e-4a36-9bb7-6b6ffa4ea123@gmail.com>
Date: Sat, 23 Mar 2024 18:32:35 +0100
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
Subject: [PATCH 0/2] improve bugreports
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Let's try to improve the readability of the bug reports we receive.

The first message should not receive many comments.  The second one
might.  I'm open to suggestions.

Thanks.

Rubén Justo (2):
  bugreport: add a new line between questions
  bugreport: add a mark to each proposed questions

 builtin/bugreport.c  | 16 ++++++++--------
 t/t0091-bugreport.sh | 12 ++++++++----
 2 files changed, 16 insertions(+), 12 deletions(-)

-- 
2.44.0.494.g7a0daf3e0d
