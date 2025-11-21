Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244D333C503
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735577; cv=none; b=TFkjRY+B/Qzcrr1csGm85G7NTIZIdFf3Uju7MFKCFo+u/5DBVEpznuAU/N2sT+uCWIVSKOm3v7skOKJjyRml3K+h3bYcXsvwcsJs6JnctIuIO0IZPQHSjmkiCS666V50pwB+iq++U6tQw/yEkJZ/ZszCMt4Ugob8qgDil38OX2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735577; c=relaxed/simple;
	bh=OzBhZaSwy9oDbAjNi/aNPzdhXx3xwqOV+AH/kc6sa3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdpXU6dqcyv3YWnkMXNSSeaztxlUyPosoJGNM46XKI+c8QFabxQ/Vko7vj9MAuEeEvVGkm2djFAPE8F40N5hXlJevdUzkwzrwclMOyWEBqcv8hDlciPuL1uGaAT3mC4+5lFXu6QsFv26XMHXlefGTani2r95l1Q7U1W1sjD97yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lt/jazI0; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lt/jazI0"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-74526ca79beso1626166a34.0
        for <git@vger.kernel.org>; Fri, 21 Nov 2025 06:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763735574; x=1764340374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAaeSWzpTnydGxaWg4gN9u/DxnUIUGhI3BWO2LOPqLg=;
        b=lt/jazI0LVTJBvnkbvBe4vPjrHEBHZXzEGjGn3GIEDRerKrGAO0pOKV4DVDCiHG1eD
         KhfKjWGDEU40ArFLf96mEcwInet7GIx+hv5livgDhjUogC19m6iobgFPlnDgtsJ2SJ5Z
         pbZQ39OOLQtkUBZtZBZezjU4zr4Vj2syNL0rACERW5ea4hHdd5VcRHTAFxORiIMNmKMZ
         GPLeNdqAnoGnoj/Ajy3V9BmRsZpzSF8rD1Gm/1jXqBErJP1DKQCUYp7dxW2qMBR/Dt55
         9apWkxqyJe0xO2JLLmS2eGQshENQDweKGRb8zBeZtIz/NLV1cxnEHQMzW/5nfI6tDzMV
         rGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763735574; x=1764340374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAaeSWzpTnydGxaWg4gN9u/DxnUIUGhI3BWO2LOPqLg=;
        b=Cik8YZWS3z+USTFmD2qf7TgPoDq9ZXTjjITeTDyPjbe6rcRyy1brkr7lLNbT1IpNAK
         3UOjNvZI7EiT8EXDzvTgOkC7C6ssjEBt4uV85upoabWNCj2BX7AjOrJfyMrCOuuJ9fBd
         5y9MBGGWMCzs3y9WEC4yBMCw6tGxJ5PARcomV1oeFBGREZqD2TvRRbpW1QTNnKNFPyiw
         lz3BOYkqj5XFUgyEJBa/j/lgwZBft/jCqxYDOJACmGxqLKEKoNFNBH5E9xpRJWoxWUzn
         AvM8dcH7VG7UEkEVsyJSrxxEtsgF9Ie6n+C86SIHjyCf7MQ69DDZqKuSAYGMIdHMucAx
         RZqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGhAwR+jiFVbuHlfXv3PtbOtX2fbTnWTjTluFalggOEJC86QRyHd5HVdUaIbql3WMu2wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvUFw83w3FVhMPtiBva19p65pBtcy11LSASkRGmAu3wLd0vHB4
	Ak7QKIWLByvUSrafbzEoRo9wMZKm2DWu+sQxJGVg/WJkYKDhNJHG9NjoF1Y6/HTbS294WeKcJm2
	AbofY/GgZcPmP0F/0Q3MJL2ytrdrRIzA=
X-Gm-Gg: ASbGncuOqtM7zOTTKzKnlIqMRdYDp6+r7ZoMI54f4qn+O/6HAL5mUKXcYU4xlE+Ulvq
	NqYltdHLxhO1l2BuYqXdx/TX9gL/oLngIVkWqrcdwQ/4rBSZNJNIYK1pi/duXK/pkpEQh+c4dDh
	CT/VF7WlwbkYmkm9QzvLABTd9th00G8AmLo2rk7HgUEdug2mPUcaonV4ffdlzA4jgg9EEltH54p
	ww9fVgjVvUKnOxsiT78vJZ9p4bATooEHXl8W8wnu5HpGmqVv0u5urflTuj/4wlh7VgayjZ/DH7R
	2C4FQmI75QIJa21thl5VI6661Q==
X-Google-Smtp-Source: AGHT+IFbYPeueNoyZgksHvTLR9CsJxBEYp8BHwpzSixdlfQyPvdmBN0RU5L6WzCiU6Q3Hz0hz/na99/VS6RkL+pL8N8=
X-Received: by 2002:a05:6830:33bb:b0:7c7:8113:6f6e with SMTP id
 46e09a7af769-7c798cce20amr667597a34.27.1763735574125; Fri, 21 Nov 2025
 06:32:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL4-wQrgD3nnW2BfNf6e9d7tDANE60dYBRRP_0FW3Z-LvQrZmg@mail.gmail.com>
 <6F4B3935-7F2F-43C9-8E5E-12E2FB3331BD@gmail.com> <010b01dc5a7b$4790ee30$d6b2ca90$@nexbridge.com>
In-Reply-To: <010b01dc5a7b$4790ee30$d6b2ca90$@nexbridge.com>
From: Martin Guy <martinwguy@gmail.com>
Date: Fri, 21 Nov 2025 15:32:41 +0100
X-Gm-Features: AWmQ_bnGPJX_QEQ0CwvLZ_0-NNQp_LHeZCs2Hj1H9nmJOTy7G9WtvNcGNkKXg_8
Message-ID: <CAL4-wQra+7HOJ6_qNy+4_tvz7=KApW7yb7BNE6B86JnowschXg@mail.gmail.com>
Subject: Re: Feature request: git cp
To: rsbecker@nexbridge.com
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Nov 2025 at 01:10, <rsbecker@nexbridge.com> wrote:
>
> On November 20, 2025 6:08 PM, Lucas Seiki wrote:
>
> I know this might sound trite or wrong but... does this mean that git log
> can actually detect SHA-1 collisions based on similarity checks of file
> contents?

If a git mv is no more than a git rm and a git add then yes.
If i understand correctly from Linus' fabulous rant, that it does
line matching retrospectively always, so not only will it notice
the split of mp3.c but will also notice that the functions in mp3-util.h
one of which only mad used and one of which only lame used,
have jumped to their new files and mp3-util.h purged.

Staggering

My only regret with git is that it's line-based instead of word-based
as that would see a change from < limit to <= limit as one symbol
change, allowing semantic analysis of program changes but
if it's all retrospective anyway, the line-based change analysis
could gain a word-based mode.

   M
