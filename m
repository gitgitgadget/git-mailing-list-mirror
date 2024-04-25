Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C082BB01
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 04:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714018567; cv=none; b=MPZ+CQ32UR39LJHpK6Y5eYRFpELhtzqGBw9gQmHRs3b7att3xkq8XzLBcmseZGRSQ6Qf2RDOxkDxFAf66pLED1eu0gmPudUJJA5pcf82qWUUz2jXfOj2WBtjCIPxunOu0bRwXOg5kCA/CAOrBBtV/rSNCvQvMwpZvQDCzOSA7rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714018567; c=relaxed/simple;
	bh=zxC9vE1z3HwRFkF3kiQduZEQDduKnHRn02lLGOwh9DA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjbFMJiMjfiQrVEejyfBNzPMrNgm6dBYJ2FBx0j9eha7zS3Mt87JJuGHCSNNkwRezm4c4BBhc9o5DeuKBxwPkCEksLw+v3KOOnN9TBXMCjOXDJbkNXTQEqQG/dHhcr5xXwnjNtrA4JzbTfKwYGHKx+uGc50sEoWEMkvJcDb9N1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itVo8DAJ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itVo8DAJ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2a559928f46so449846a91.0
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 21:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714018565; x=1714623365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zxC9vE1z3HwRFkF3kiQduZEQDduKnHRn02lLGOwh9DA=;
        b=itVo8DAJrQ2wdP43yM8QxNlCl2Y0xGR0SpPTQWqzgsXouHBC37SIGZPnDJ3pZXCKdr
         y+oRcfUYx7RMHpo1L/S37AShp9zePtGrQXex4b/TmchGirUvhV/1TYoftlD5j/j1EcoK
         bJcG1ZPHJHXMnfzzjVSrsAusC4QxKBODBOn8E3sCfhfcSQ5Wy/VbKYc9wyE6aB/E4pL7
         okSahx15cxmQVYp1RQS7JTAh79c+FvyPFObsw7dmMsSRry1QG5TTKpttWjp4zQdl1c7v
         t3NZ16jXgrwXZB+6CUd3NkwuElQU0a+8OtNzgd/rqC3nfxwJ7S7mdPOZ/Fua7Sdy9FX/
         DMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714018565; x=1714623365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxC9vE1z3HwRFkF3kiQduZEQDduKnHRn02lLGOwh9DA=;
        b=V7pdSvmhQxGEwhJib1E/1MupK18jvHygg/IMYhiAXjm1b3tu9uzx2guWKUckqyD12h
         90RvEss7UiEFGGdK4fLuEI/NClZ3as5BwKKixPhrC4UgwGfNZGRoR+h7uybcQgaWc3Bd
         mPr4GwRntwFysOYLmQLqKwp+yPGk4X1d2breovhq/gY30x2oPR0OEx/edjgQIpkm4GyL
         rqDus2aKVsPXs2GGsWVgolAkHEbxZhUXf6L06a5a+zI/dLqdN0qGDrTcEH03sHCuh2K2
         JNw00BVYudt8COr2YyeFS6YuqmKNzzZ4pEtDY6/TCi0lAIk67X3vZwKGkLtpC2J4go+H
         YYtA==
X-Forwarded-Encrypted: i=1; AJvYcCVtZEp3sor7ZHqAdBH2fMeDIMS5ZnvK1ksKRAruVYpP4InhwA51Cyq+kdFBaRaOb2CmQfmQxQDFPU4j/lIZ50E7VYke
X-Gm-Message-State: AOJu0YxtK+hhlTnHbfcn2zkmpGY3CR3rzGbqAoG/ShyaqN3AC5fgmdvZ
	oewarR/KLhZ2JsozHlh+5+Ah2tMW6gbkmlN3ovwn2Kuaf2gJfbwPlw1dwjWmdHAeGP/nBrPOhhj
	xToF7ZCMeK4KPw9CZpQCJz0+qcbsXWsyF
X-Google-Smtp-Source: AGHT+IGcQuPMwbGYPbnknRjusPAJZONSoPgCIFs0w40VOJq75u+5s7DcpGN1cRb5Kdd67DCzBEr7kOFDXTJdoTrapWM=
X-Received: by 2002:a17:90a:4410:b0:2ac:5b11:9e46 with SMTP id
 s16-20020a17090a441000b002ac5b119e46mr4765844pjg.26.1714018565260; Wed, 24
 Apr 2024 21:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADs5QabwDtUpehNY3hr6BzKyfpp-Ts54TANGkygWPcN3T=OSOg@mail.gmail.com>
 <Zil_m_1B0wcLejNH@tapette.crustytoothpaste.net> <xmqqedauwgbk.fsf@gitster.g>
In-Reply-To: <xmqqedauwgbk.fsf@gitster.g>
From: Dan Demp <drdemp@gmail.com>
Date: Wed, 24 Apr 2024 23:15:53 -0500
Message-ID: <CADs5QabuZYN9AbhZd6gjwtvuamietz0RToBFcmbxeFV1v7U2KA@mail.gmail.com>
Subject: Re: Git Bug Report: git add --patch > "e" makes keyboard unresponsive
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To be clear, I did close the editor, at which point Git Bash shows me
the next diff and asks me to choose an option (y, n, a, d, ...). It's
at that point the keyboard is unresponsive. Not while the editor is
still open.

If it matters, I'm using Notepad++ as the editor.
