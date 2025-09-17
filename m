Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2402AEFD
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144820; cv=none; b=Qf9pcfo2uJ+NEF9LzK8w9oXYm6dz0K3ZuMxwiYl6+CdWxj4G5sBOfvB9DgvuDEqqke3jBwvWjSpZ6FRe4Dgh4eLye2Kt8b45dS8cBCfKN9RhTemOwC6mrVpywpbzDYPwn49CrE9f4VzFE+8URZZsEoYShPefi0gJFkbbfVnWLhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144820; c=relaxed/simple;
	bh=yxat3McZH8Ur1eYvU2MIY2E5wYsD1Gnr+Wvu8FTVAdo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ixl5/6TKcUyhQKbVID0osQJ1W0p/+xzifrK+uqvxpoE3oh1VM2kTcZYNANEY8kPoHclkU1ObZHVwUxr/ixN/u+QrxvA0xqHrwU+gC0TA4DrJj4ijZCIN+0ePamUaxRK6F1IBZm5tDhOtMI8kGfG4gi0beaBbesozNeTKnRSINXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQeq0HL9; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQeq0HL9"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-4234e6c0762so1087685ab.3
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 14:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758144817; x=1758749617; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5/aAJxcnclp+efder/xzrCXlNg7MIGRy4qOgD9Ff+jI=;
        b=MQeq0HL9ONg+zx5GOyH62yaDhw7hHJnOAsyvgB4P0Lzkl02OQMvZV20so14l00CD/j
         zzOa4QcVB51E5InV8gQtoBMA3Ctkj272zEBvi0E33cmoZuFGhGaQaBFG4/FCc6ZKLq/8
         9zq0+HlG7Anz3QsveRS3WWu92Wf0VYwXYHMDcO10kkBAKLbNhsQWmGEWSKFUASdhi9vT
         NS0sUlpq4A+rC0flWDsy2GjIdzyz1VtS7kmepzcjzHeCOANdrQYpqQuf7rV7KZMIEtT/
         dXPLn+vavx1NClEp0KYmJzbIMr5/YYK7z7UAtageN6bZSPGefGONoq5xhyMc1ZDOLqqC
         r2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758144817; x=1758749617;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/aAJxcnclp+efder/xzrCXlNg7MIGRy4qOgD9Ff+jI=;
        b=c2DqNG1wah1JQZLQIJmAY8CYxKzO/p56L2kRVoEZBuQ2mKOP9pBbypcPCVIVFoU7h8
         Uv/FJw5z91mqs9Rnogo4NiG+F45BNG5J3J81IGxUTUHdkohVAo9/3uIW628pdZc6LkkL
         cWfVTdthheqxcYvYSzvuDK08ZaRzVL5JX/4uw9u/FXHPW8HpMhFefjUpFd9Vsv8MhD8o
         E747DR9JSIQdIJ/QxKyFZhrPnn7XsO+R/YQg21wc5vkPp2INgjyHfC2n6y1auZ0L/ht4
         Ixjw1caM2Ggq5lNuQ2Yfyt6D7J1FEZ5FCWdpxznBYs9YdkKPa96xLwAtSkEKQvbxrJWz
         E3tA==
X-Gm-Message-State: AOJu0YwMHcT/0yuUaUiylugiCj/jcyf1ptTUZ+MS/7nHDOEcRlWaO7nP
	oeivS6yicVtZe+//rQFNzAZH56PsddQOjkK3nVC+NVDyvnKye9Lnej42aet1nA==
X-Gm-Gg: ASbGncsiXrI+CUNYOjs6fQubkTSEYPW94AAn5/N4gcrXW9ltPfIP5QhDBv0ayrUUeVd
	ZmdHvhmq7m8hBHFUDnfVV6toQB5obArdjMAbHIB61bZYKxtR9tt/iWQWLQUj0zjiqYCRAyA5gCd
	X99dH9Sp/Qku9xh9fjwzu2Q8B2Ht3gJPspg+aJE2dkN7+EfH2l9+bbojYE9k2P+0f4IXNiyOlrw
	uOlMD9ePajLM/zQ8PQ1YldCyQ5k5gaOZm38NPnCQcDja7LAMOUBgWm1w6Ji/rfWJnEKqLYk6iyC
	D0sebEstOoH0zZWuQFiSDEYnsvDDmmstwr6kAV9B3qEdDqMrIMM2SijfG+AJpEHyxn0R3XGulZW
	jJHH0D+b9sYIrfQXUObvkJvEOimx+fDrABIeRkM62aLLSIlIaDwtYfqI=
X-Google-Smtp-Source: AGHT+IFk3ZGidTD0qN4svEoiBMWJe3eZ6GDUI0do+CyHNG4y+D0ZEr2tya6FJUQ2F+PnUqKxWhvIaA==
X-Received: by 2002:a05:6e02:b44:b0:412:fa25:dd54 with SMTP id e9e14a558f8ab-4241a4f028cmr57152985ab.14.1758144817262;
        Wed, 17 Sep 2025 14:33:37 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.133.184])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d50aa6538sm193916173.51.2025.09.17.14.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 14:33:36 -0700 (PDT)
Message-Id: <pull.1973.git.1758144815.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 21:33:33 +0000
Subject: [PATCH 0/2] doc: git-push: clarify section
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>

This is a continuation of the changes to git push, from
https://lore.kernel.org/git/pull.1964.git.1756240823.gitgitgadget@gmail.com/
. These changes to the refspec section got kind of big so I'm moving them
into a separate topic.

Since the last review, the main change is to move the rules for pushing out
of the section and into their own section ("PUSH RULES") so that it can be
easily referenced from other places in the man page.

I don't love the nested list in PUSH RULES but the sentence starting with
"If the source is a tag or commit object..." is really a tough one to read,
it's not going to be relevant to the vast majority of people, and I think
keeping it contained inside a bullet point will make it much easier to skip
over to get to later information which is more likely to be relevant to
folks.

Other changes:

 * removed "+:<dst> is optional.", from Junio's review
 * kept "+ is optional and does the same thing as --force", since now the
   push rules are in their own section.
 * fixed the fully expanded refspec form (main:refs/heads/main =>
   refs/heads/main:refs/heads/main)
 * switched from a numbered list to an unordered list, from Junio's review.
   I think the numbered list looks a lot nicer in the terminal output, but
   it's true that there isn't any order. I briefly attempted to understand
   how AsciiDoc's nroff (?) generation works to see if it's possible to make
   unordered lists indent with fewer spaces (2 instead of 4) but I was left
   feeling that nroff/troff/etc are not for mere mortals like me to
   understand.
 * made it clear that "tag v1.0" is not really a refspec, from Junio's
   review

Julia Evans (2):
  doc: git-push: create PUSH RULES section
  doc: git-push: rewrite refspec specification

 Documentation/git-push.adoc | 198 +++++++++++++++++++-----------------
 1 file changed, 102 insertions(+), 96 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1973%2Fjvns%2Fclarify-refspec-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1973/jvns/clarify-refspec-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1973
-- 
gitgitgadget
