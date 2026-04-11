Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE423148A3
	for <git@vger.kernel.org>; Sat, 11 Apr 2026 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775933474; cv=none; b=nsWhh/DVC/Z0+65sQ6T0jwl32DqcyTdIyzc2T+lQBTl0QKMCV2S0VABC1DHqOaNquDuUX6NK9E9xXRhp10aSAm0MAVNsCzMhGUGoo8uE4TOHrM0Q9OBd6v1dv+dOL5B6OJz/baBQC/QR4iMYbHAj1ejxu+eotFOkoTs3Lw1mREE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775933474; c=relaxed/simple;
	bh=Uqlph4rrLm5rlNckpTGfgKZCJlf8lwgcG4InYncg00k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMqC0vHEBfqrzgUZl7fmE4pfdwd1uGf7jUReS4hLBoyi0YpyLgXM0UtYBAvjSOsILNmtimYZsKOLxOg97s0k7KOjszA7y+JEg84L9F0Q84UljKtuvbrEMKVfchD/wPqyznSY/RZfTU7fEU6WDwHH1nq2gypM0JEqTg6Iz8Rcpzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBekXhBY; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBekXhBY"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38ccde812ecso30147541fa.0
        for <git@vger.kernel.org>; Sat, 11 Apr 2026 11:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775933471; x=1776538271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qr5OyxL14oWO65AvJV5uWUCqMjAEAQuG4xXDtxkiIGg=;
        b=jBekXhBY+M4KYCQIvLjxrHjLmYSsc+8yKBirGmWzY9V+tkO10yXUjmMfMqwhgmBzxP
         WBUi6pxhv8lkEHmdg162WYdJkOvXf+zr/XY9W6kDu15x8LS6dW1ZmnOTjmzwbJp2CZPa
         PF19y1eC0pAloP1tp2pr9nKHFMhe/ueR2FCKxCNnsyGnI7niai3BXu4VV9afqUvobB/a
         jrjtapDUbxUGEdF7UBS+OmRmvR5QKIdz0L4XViEw0GLfEli+mU+N0gRK84PnikeCCSIy
         thWiOMybn4c/CD1o2J1tlA7J3vSxxyTLKEpTk1n4MwLb3U4zByXB2xQ4M23EUaxW5MQz
         heJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775933471; x=1776538271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qr5OyxL14oWO65AvJV5uWUCqMjAEAQuG4xXDtxkiIGg=;
        b=ghfd6SaWiZNJjBmDQPFcXIOrWTMmuBmIZ9Ev14GyJ+lhYJ6D16vBa4NwFOd8Tmp93G
         pjTLJSkBQAVmVo5cV8HLC9DDXUyWGqqryN2b42Riox0BpYIIpuH3oInrUI4QRNLxEShW
         5xqbprGXvYYS3magTF9BA5BUdQOyUkpHbbyak/lhu3UE9mRx1aBj/SWR49fEIxk2I5WS
         E6GmIj61OU0+wYlylQdL9knW9+Mto4Yzt3qbv6/ECwFgU/gpt2cfIH+0CVqtkHpbyVOD
         W8ugO+UkyHlQFuWmUpJNt6wZvqlxY7VSzDbY4sc9CDLJk6XFXhiY/OSRywqqhYTYBTgB
         yq2g==
X-Forwarded-Encrypted: i=1; AJvYcCWDC7nESiqIouL7xxkaAwZs98i3PxFyLqgR590TZ+d3+SMvxRnD46mclyvTYXpJO4VpZR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Q8HPxsSu0y0js3bqK0wAXOWfc7lz+EhkY24ndf+7hWLpK8Es
	v71Nv/M0zSTUBYcl+MiiA3p+9TY1H+jl5Bc/BmtKMuN8tQEm8q1pT6C2
X-Gm-Gg: AeBDievERczct1z4tKIbJekwQ8Y5T4NNh1iGLPdQ7KK717pw/6KjXQD4vTuNyVkWrQk
	UTbg+MfRlePSyu+7SrTRKb0+jLacexWBbJqXERZO05V6FbwbAh5UFtIKT8DMXiTGNtnKPbnqpoZ
	r9ZossF1fKqemmlX6G6ovjKFT2SahdwiGJconp5W8wSCpx9bKo4pDrAJ4VqTydpHF8DnunYYb41
	kGi/Oao805q18tq42E1yfDEyEHd2iFLmMLX20J3FWbsaxHwwUwYxhanOrghGJOxmr0frq6pAjtt
	tDyxJqr0TD4ldc9SlsjH2Umd2Xpsf4hDuNRTIVfz73/rSJgGVcWoO86G8LjBJAWnTOGp57MIyhq
	JyFHOtvIQ8C4CloyJmXPgSUn6Gk2axt7nOL0J+elmlVniE7pqatqWYq80oifu+QGJFjtVvCLW9Z
	XoQ4nFNLV5lyk69b5txoIDfiKM4GuBzBCyznq7Gw0qYOULfL5WeXsp61LFyeMBLdQ8JNLyt6VSE
	5I0qSCAQCVZoOIf
X-Received: by 2002:a05:651c:3259:b0:38c:bea4:d7f9 with SMTP id 38308e7fff4ca-38e4bbe35cdmr22125781fa.4.1775933470611;
        Sat, 11 Apr 2026 11:51:10 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e492702f7sm14307621fa.9.2026.04.11.11.51.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Apr 2026 11:51:09 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: peff@peff.net
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Sat, 11 Apr 2026 20:51:09 +0200
Message-ID: <20260411185109.37795-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.rc1.69.gaf13460d94.dirty
In-Reply-To: <20260411183823.GA672575@coredump.intra.peff.net>
References: <20260411183823.GA672575@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> This tries to create a root-level ref called CHECKOUT_AUTOSTASH, which
> violates the syntax rules given in gitglossary's "ref" entry:
> 
>   Ref names must either start with refs/ or be located in the root of
>   the hierarchy. For the latter, their name must follow these rules:
> 
>     •   The name consists of only upper-case characters or underscores.
> 
>     •   The name ends with "_HEAD" or is equal to "HEAD".


So maybe easiest is just to rename it to CHECKOUT_AUTOSTASH_HEAD?


Harald
