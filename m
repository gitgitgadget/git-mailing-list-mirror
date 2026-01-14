Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D729E358D0D
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768377587; cv=none; b=AX1444J4jUfMQhg+qNninWm4E/DLxyP9iL/9lxLGr1H1X+aynei3DSKfuuBxc4FRsUZ2D1DF7cVjiLqorLqfyd82Ih2P5OsBAI2gfH2uWtb7b1qfUUzy1P4kt62ImPYdKIxhwvuI6z0VOjVP+jTC8q7ES+XNgithYv8tE2gcUCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768377587; c=relaxed/simple;
	bh=Daw9OV3UuVRI3uWa4KQ6sCL95ooH/hKwSU8AZtgnbqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuzprgDITNQWzfJLRvmhuRMuObtVw4r9TK7s19WqGbjJllPIQKRbAemhnQMlmPUihxftv0rMBJ0m7zAmUar9VPKUhgSl+1VaShoJizYN/9igjoyuO683ebRSENii6BUTbjudwKvdgth748f4roUPrKpujoZAA7JahgbanJiF/Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sun0Q9Bt; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sun0Q9Bt"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59b672f8e40so9566261e87.2
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 23:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768377579; x=1768982379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG0lmBcbZHrKUofkq/kXfDhES3A8iqhF7sIScjELkxs=;
        b=Sun0Q9Bt1WIuKRhOUOe/pgr10jfyxpc3ivxHbwzBdbEYdiF7+g6NkDrr/m4Er6NdIO
         BwzRhwNRGK7FFp+es7ROMpOGsf5hW/cTeias0XXKaZT0qO5wL27QF+HxZj+ARs0jM3tF
         O+kh5K4ewR3Q0unnH39zMs6XSUIzCHNUxzatpR/LuE5TyhKYhgQRHPaBDW3zYAYdybzX
         48yLptS8oGcmWIXAkt6B/QLbcdd6KxSeFnOqqxKyHj8D3Y/RmFwEA5R7QY2YYHpYO2hK
         v759B8joKmhcfSyin/5TJtIzPSVFGykZhTQ0C+NZK4y1LwXJN4KAPIAXJzYOT6karmvf
         MWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768377579; x=1768982379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NG0lmBcbZHrKUofkq/kXfDhES3A8iqhF7sIScjELkxs=;
        b=sxYXNeFvE9VTAr5L3spLv3Za5p7+PVwSHYDIZPgCoK63fJ6L4qv3y8864R0uRbk6/s
         2xgFX/Ef40ArZhsGrYiIOU4Xo3b4GGn3m9SUwO+q/jwymOJW9hx4IPx1G7Iu+JGnss7F
         roc4Le+mQM0P7c3mA8Cklaef265nLmMwF9HJT+R8CmhmQpMgP9zNDc16yEpOrqSE9P8g
         0UJbRZF/h3BWS4Y93Gf9JUnI6dcmFXNneMrkxa5BtLovhdn5fsPDZ5mfZCZBphIfsbLz
         Q852vLlcjpXTVlDz8ajGNLSFtMREl+JFyO2BNQTcqQeIau/Xd27SipOEma25/Elxfy1k
         ngrA==
X-Gm-Message-State: AOJu0Yx+JleMt0FNoZhKjG+1ssj8d+NhX3gWq6KX/XMNaW/BI6JXnSc0
	jehn5N2a9HBlXsoX8Q0MvbYKbEUC13LMPBjK1DfQF2E4uzpBCbIF5IUi
X-Gm-Gg: AY/fxX6Dx4WSdg7PIVVSTjdf6PVlppkLyiVcQE2E44fu5l1ALkB9kTQshB1BweZn5U9
	k9HXyx+SbLPXnRPhB6SsNxhClfAKSD5gFGn48hm4iMwQzGHsdj2nfcebP01PaO0U1WrEsz/WV86
	g0a6WXV4JeEYDMm6Ozl6peztmedU7DsUD0MQuG8wIKjQW5diWoxHoj+snD8kIrc4PUk4YQgvbs5
	Fuzx1/99p/NYP6boLTBK4WEMpUeiTcTNF0sraEyeFslft60vR6+zTM/Mnjo39HAOOMHfgj4MN3G
	6eLclluyL9kphhMwgXnmQ6whV9FujKgrJsdz+LscnIAqeVyjaTuzGevzA0JRuvxcMI4lH2Kw7T+
	Px5tJ8Ydrk2qtsWlwI1i+vcyU/MQeoIGCrj+OH9B7RH6YThtCzwtUnDkXxKr2X0dXGDFvRwDRrO
	v76poaQX0n3a2kP0m/BnFNFRVUynZfrb9iGTQrs0mPH5n3I3LgyZTZjKS/+8biyOOaOLlfrYd1p
	wJN
X-Received: by 2002:a05:6512:3b9c:b0:59b:72c8:512b with SMTP id 2adb3069b0e04-59ba0f5e96bmr499790e87.2.1768377579178;
        Tue, 13 Jan 2026 23:59:39 -0800 (PST)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59ba101bcb3sm458991e87.21.2026.01.13.23.59.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 23:59:38 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: ben.knoble@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net
Subject: Triangular workflow
Date: Wed, 14 Jan 2026 08:59:36 +0100
Message-ID: <20260114075936.40221-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CALnO6CAnfmDfCFJY55J81TTeRCYqeHq=dVapeanF0d0Z_yg=tw@mail.gmail.com>
References: <CALnO6CAnfmDfCFJY55J81TTeRCYqeHq=dVapeanF0d0Z_yg=tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> My workflow is different from Peff's, but it is similar along at least
> one line: it's really convenient to have "git push" with no further
> arguments (only possibly flags) to push my branch to a remote mirror.

Would you also like the status reporting to be off for your push branch?
I asking because that's what Jeff is arguing for.

I fully agree on the convenience of bare 'git push', I use it everyday
together with these settings and commands for max convenience:

    git config --global remote.pushDefault origin # As opposed to upstream
    git config --global push.default current
    git config --global pull.rebase true
    git config --global rebase.autoStash true

    git checkout $(gr | rg '^(upstream|origin)$' | tail -n1)/HEAD -b new_branch
    git push
    git status
    git pull


Harald
