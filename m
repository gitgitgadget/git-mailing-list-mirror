Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AEE2571BE
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 21:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774559054; cv=pass; b=TBy+9snZbafRGz7uEmV/IGnN8QwRc5F02zMwDE6J7RBAAarzYWFGfHBK9k5QafjZ6l9nS1j6mLxk06u1YWRJQqig6QuRHnfJXdB/gTERed9KP7/S2Xxc7advce7/sL2A+agRpiUtGTi1xFtGQbTbS8aGP+toSqCJ9ojNuy5dWBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774559054; c=relaxed/simple;
	bh=w2a7PAe44stPoQe4LjFION6621SCyni6xdsVQj4ggO4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UqnSaVQ29EM0EhQ+kJXcecZdKLlyz1SM4LKYP/yJQkqhV9/FeGYtDAwmYWZI7qiiprbNoCp/cMGCwJC+ZzVPXUyXQqfau16U4+oLk+wiZ5jIC4ONKYXECZcwHV6iAQuyu6HsKalSaIMi4wCBIxavw9OumXdVE43nqzevxUCA+Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GO5ZeOXP; arc=pass smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO5ZeOXP"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56cd842b60bso1039262e0c.0
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 14:04:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774559052; cv=none;
        d=google.com; s=arc-20240605;
        b=ioUUXxFd1pcpIcyqIs1MfjjU6AZDpl/i/JqqSCWKT9/tXXm076X0e/kLQf5Nx/WsVW
         SY4wDjrTpYRZRAOpB77EvEot9hIkZws2jRFOqI5Do4O56p295vRyg87F8G+LPFWirXqq
         /2whe3fxdZE4hxbG+AhxFPsqsiyg9EagLbSgUvhfo5/jijtb894c35LnUHmMmxcG+sQ+
         WUPRNKXHiKxJcCuo2SyZLoSjCQhpU6Yw0UA98ggT2QZrICaQDDAVzH6GZhUxhXuZ8RIS
         EW92mkxsoETsGqcxDGVAL1k8ZxXw0U6JUAkIRh5Sy+3h1K9iMjjuReGTSK6yYh+4JbRk
         /CFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=w2a7PAe44stPoQe4LjFION6621SCyni6xdsVQj4ggO4=;
        fh=j7G2rj/UpQWRBPdCRRTxGmnW8ylGkzbH1fLuSLpDn68=;
        b=YXNd6yZ4hzbpS7SNoeIga1cLOMtZAA1I+LVfiVkq7XDI88zKAeafrmO3Ihg1u1y6KN
         JrlHhAOtrKKy+Lci3YqCVugAZFpY1qO9BwbULZVmm1OdGJqsyiTVlUmsxdv2fraUar5p
         3qoQmWiI1AMTneAkbarI1aUh9+chGP1OAdL6F2Rxwf8yk8/KHR9r9Xf0hh1GhxyMBZgp
         fm95cHadOWA8948FvnEwpAVG+31vDLmdEc9SNzmxVLALVOHbtcxg6AGUTv4amotjBpGT
         7mDkN9sP/PnKf3ks+hvXynWPiMgGPPDm2F5heuUDLUM85m+MU4mhzkO0RwPhIR5m3tAK
         kddA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774559052; x=1775163852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w2a7PAe44stPoQe4LjFION6621SCyni6xdsVQj4ggO4=;
        b=GO5ZeOXPiR24XaWU/WwCcXZ9JoAZiCJlUW6Z0qHZKSAjR1axH4E5yGvQ2pdxHhSff3
         ddD71eaxyV8esh5FtWFl8isp7EUNksaSV2OreruETjUBssNh4XmMSYXTLRttsu5anV5B
         c+Qtt47ISiJzu3lKxvOi09q5QjI4xwDqufrmBMUm7FirC90beO7obcAc7D9JeLZ/oAF6
         GGaY5E7lvsNAbpUUz5il+Z72wA11D3cNZw35si6rRB2HVJHwc+pOBXdjGAdfaKLz/3I3
         Swyo2PZ2/kqY7n2AIAgI7SupKwbFog3dXsoJCOg7RWdOiIMApaT+0VTRkymZfN7oiJlQ
         LE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774559052; x=1775163852;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2a7PAe44stPoQe4LjFION6621SCyni6xdsVQj4ggO4=;
        b=cUQzGBKgCZDIcsNonykHB92q1MAEvz7FeNgnMva2BYdtoFy0XxKP2tPavDWbCuNo+b
         uj8t2n3uxsncYPpbRqT0TxBNIJd0d223/OzAuEpIk4bLDvazXDDbArlbbY1J12Zwk4eF
         KKLO779jO6tusIgIY7u/3JFv5XeLuOi2GkwvMrhtvWjj8iV+Ey4KyVWua9RD6hNx27pE
         GQWO+PxCqd3Y308KmI7opLYmYlNVrG+ZfX+vZPRDI1mjUAo7gdTpk32Bu9FBq96Xf1xZ
         w7M7q0HqdmkOuTfxuIWgraK6MbftyPSokC+z1lDB4rckeEYmpEyGeDFf5O7YQ8VOmwrY
         Q7TA==
X-Gm-Message-State: AOJu0YyWLM1psAMEir1RdDlIGrtZ2DGCp+Cqo9Bqg0PtiJu3rep0u+Od
	5R367rufaHDgMTt4DtiACWyORvyWnqk1nx6FB/OTl5JWyYAAfbbyvAd2SPGZRQhf43Xk9JyDbqz
	avgKF/g7Xm+F6gtUEs5CrKGI3UeOim5vKY3q/rZhMMIka
X-Gm-Gg: ATEYQzzD4sBunZrR6aak+lSwel6VmOBjnKp4/fcbu92+54NfrhGyWC/O+t/nEcQgQTs
	3sL+iAmvhf6mNVW5acbZ2ZamcZwmaogcKogycCns9QY+VWjMIEnzOiPIdahCdzgsc0mmjoVivlS
	0Q//WI3ewNYujpKTL4+KN3cQI+3ndkjQ/CtZ4u3c17+m8uxLmhFKlJvqVRC1gPegkZwta9Sp3UX
	fUSQzlXiA6BAVA6ZDBqCXLOLRCTNG4PY93sWqUb62j72wwA2X4avPFV1HL9ymYRVCcVcXvhg/Tp
	5/1n8ZM=
X-Received: by 2002:a05:6122:a22:b0:56c:c76f:1bb0 with SMTP id
 71dfb90a1353d-56d2207b027mr4307430e0c.9.1774559051949; Thu, 26 Mar 2026
 14:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mahmoud Samy <mahmoudsamymahmoud01@gmail.com>
Date: Thu, 26 Mar 2026 23:04:00 +0200
X-Gm-Features: AQROBzBfqbH1YFa4yElHD4-2DrRCPsWg7eULqGRr4GGaGBjjN_TJ5-LH8dk4hFk
Message-ID: <CAC5WPUdYxm-7Pjq4oAddLKXjSa7B0YdK8ashyeR9vhCQt+wvPA@mail.gmail.com>
Subject: [GSoC][PATCH 0/1] My microproject: Fix improper pluralization in add-patch.c
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello Git community,
My name is Mahmoud Samy and I am a fourth-year computer science
student in Cairo university. I am interested in participating in GSoC
2026. I am writing to express my interest in the project "Improve the
new git repo command".

I have identified candidate strings in add-patch.c and am currently
working on replacing the _() calls with Q_() to support proper
pluralization. I plan to submit my patch via [GitGitGadget /
git-send-email] within the next 24 hours. Please let me know if there
are any specific considerations for this file or if I should
coordinate with anyone else already working on this area.

Best regards,
Mahmoud Samy
mahmoudsamyhamed
