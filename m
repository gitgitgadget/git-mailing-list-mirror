Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16BB23BCE7
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149161; cv=none; b=RQsFwPsbTNX8kN3i1Caz87YgvGC1mjhtUsc8CaxR+nhQdsV79dyb2jUIC7fZEWrJTXZXbC6eYbIoWxV1V5xPo1u8cRfhITb/lZG9nvPRGLqqk6UL4xIsHcaLKikov7AIBlqjb0Wd89VrtjasIoPQim+Z0jbJGDQBgGFfi1HyCBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149161; c=relaxed/simple;
	bh=KfuGW4EMecfByoQj0jaeZHOVd+il99clRf0I/uS9uWw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=a4xgtSjju2j4wYYTCa2lZEd+r+Ye8ksm4pehnvVmRQKV0gNquE9CA0u57+s5tw6+RL+jzW0KDdGj0KZDh9oFO9DXQg/rCu2wMmc6gEPodocOsErLKEG7kWTKrPkLXNLvAYOvnSnsAl1c/Q5qZfPbDoZMaseK6FVBwpUlrsKdnkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh6Dsel5; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh6Dsel5"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3307e8979f2so1192831a91.2
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 09:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761149158; x=1761753958; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KfuGW4EMecfByoQj0jaeZHOVd+il99clRf0I/uS9uWw=;
        b=Gh6Dsel5tZ387r9Lwy7mOWmHQfWNj2Lg7cS4jFZJ99IWJ7irmWvwhJSvmtHmYhEV51
         JyzQjzFcFZeMthWEHlzKKrEY9yTGYxdvs0WgDNemzjA/e6S6SncNmNsgZXu+ZJ4VEWEO
         JlADilGuq0y+FltXGFNC5oE0Qvl4huwydg4PbZkzyLgmpWNgXbK2ksXl6VKQUWMXNgXm
         AjdzDrmk3Y7FefFX+0XemXWN0GFUkm6/w82ls5BBhRKQofxikODunk8zNfgssF/eda/o
         gmY1FfHMMlZ/DrTCENfbbvzzLtDZCJwe5eBAzDx8GhWqHeJKnyi49q0n2zkmd+27Fn/0
         NUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761149158; x=1761753958;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KfuGW4EMecfByoQj0jaeZHOVd+il99clRf0I/uS9uWw=;
        b=SW6WUE1JRQKsUY/FzrEtvDrEDz+ktxrlDV8OVt8TkD39CyQvX5sijgjSZlyTNCyTVv
         N8DhyUsGu4zjPWRsCWMZ/JRo3XX5Rb8T6EI+c5JOMv8lWy+fXRO8tLqee2zhN8UCl7EN
         oWOEgpEO7YGGkl1LcAiaDxHDW4o64E5/07dHZLIEzm63/MO4ATGWz/31S+5vCHUrk/HY
         xXTNHH4hj+cny+r/FcZHuoHCRIyk2VhAKEmTD6MyQR6NQOv329ZSPlxegKLbNLX07BJc
         VztfQI4lkCMy3vek8HTui8NxRJs43RECKW3ihwQ8xCCvsK1BsYq17DnqxUWc53wIc8OE
         CF5g==
X-Gm-Message-State: AOJu0YxSnDafcAJeUsHtI5xlbZ8qCFkOqwdhf3pOhiYu/FVkYnHee1yC
	HP9QyjxOZuiLAM0iFx2eF+Dx7N6idgc6fqfrzfzx6/HgFw0qi/K3s/Fu7yjXWOx+/cj5dXUOT50
	hDTCjs4p8pTwMmKTw6ij/DII2tOzEZJWrJr4a
X-Gm-Gg: ASbGncv7GUcKmUG6bQksr4QkDSEu6ZS0mOPM05lgMDNZjhoblc03ZT04dFXjV6NLoSp
	OCpoV0c87et4CtnzNTlt69aPnJm49+b0BLu1grfpnhWAEtO83seUfP5l/GLWGd6B5XzPn73PhVU
	kyOjNmybIefy2HULwpzsXOA8LmOfFxLKt8dZMe+9HxxbTlhYB3z1O8FGgOyL64Tlr5xI4Fo5V/6
	liTiCH9xIfWeRZhAN/qHCwlrqcTMgD/LIiZxId+jcutBNuVvUbWd9+BBG0vDJHkoWyLqQ==
X-Google-Smtp-Source: AGHT+IEzKorwxnTZnVXDYvDaxzC6aZ602z7JsYwWk/q1T9fwllwMSU2iAC1Ryq+kdF7Gyv4l1M2Bna/JGDm/+Ob+R8k=
X-Received: by 2002:a17:90b:1d88:b0:339:ef2a:9749 with SMTP id
 98e67ed59e1d1-33bcf8fbc6fmr15936725a91.4.1761149158513; Wed, 22 Oct 2025
 09:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Benjamin Root <ben.v.root@gmail.com>
Date: Wed, 22 Oct 2025 12:05:31 -0400
X-Gm-Features: AS18NWALUNx-7fu5NAXYo_GhAyGQQURl_z5AiWWObXqUoneJoq77oFSjakXC9wo
Message-ID: <CANNq6FmsufpGZTxv8_OMf7nHwpscD4L0a+rd2HCnO9Cs6PX5gw@mail.gmail.com>
Subject: I still use `git whatchanged`
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I was directed by my git client (v2.51.0 installed via homebrew) to
send this email if I still use `git whatchanged`. I think it is a
great verb and I can never remember the different log output options
to get me what I want with `git log`.

Ben Root
