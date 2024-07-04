Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F7D1A0B10
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720090756; cv=none; b=RnqkKBCidfkZHu0BMxs45abqDpBeRpL/7SLTgySoHMKAtJ/0gDmL5Pb8GPfOrPh+nPU5g5GNpyX9NzzzVLl44Dz1XLFKWQvImmU/8po0GP86/CYokmWI2Q02Vqg3fLxH3sYsdgwb1/yYjew+vz22Pj8oUQ11G9RQfH4IICficBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720090756; c=relaxed/simple;
	bh=PS21RVfTK72pNdtA5d8mzkBZx1ZM5bmjCMGXbbzYDDU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=RDQNAiekxo6O8XIizzpCCfamtegBJhBRxTprdZ6EZgGv2eqHQh/UgRK9Xa8uIDacnt+iqBYqFAmqPIT/1STq8SHXhX2EKug0jQpWlQeW3ihGkcpxiFZbd8mtViiJ8HAOOtsLJzeAvS6m/Id2/zkHMy0Qes86SFVCjoR6mcEGdRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9d86pPC; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9d86pPC"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-706b53ee183so1146070b3a.1
        for <git@vger.kernel.org>; Thu, 04 Jul 2024 03:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720090754; x=1720695554; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PS21RVfTK72pNdtA5d8mzkBZx1ZM5bmjCMGXbbzYDDU=;
        b=a9d86pPCaxLOpXENsZppA72KP+ZkooE8bM4uoQcQdPWeXREgInDnuf+iNqrgYVnZ4o
         Sps+EhtDqps9Msy0W+TUavvUMeGqftqkNsHic+2PHJXQfMt/utOsg2oPOps9li1MtEIk
         4ZuL3rGACezvgh07U7H67Sc6uyLvKBj8apWpyWgjxKEQ9Eex2KrcAHOhpQblRc6IATCx
         KrJKJ7FBdhgTzkoZPEGjdCmdLFkKGUVqX5Quytr9wnXPrhxCqsY78OKVntFg7K89jAAE
         1Q3MkYnB5A8TUs68+SydcBKg9Z8kpeZ6lLt570CqejcuBWLcqlU3bxbESHwBQ0R+uXsp
         UZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720090754; x=1720695554;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PS21RVfTK72pNdtA5d8mzkBZx1ZM5bmjCMGXbbzYDDU=;
        b=vJ/mEr9HaSX2JBDz0ZnFAe0LfziSXlHrFJjMsHSazbJi4101o1KxFnvtp2ywvjEPvi
         0oNhAYBH940pnluh7rKaPecxkixEVjhfsec0PVGnuNwOs/G4k5Y1g8Lh1vY+YR1m70wl
         bzQtqyWHVFhp3cTTajqsEMiDTX8Y2Q6JKzkHI65HTDUVRmfGtzSIhtJmSNmbZE6Asior
         dEq7Oo2HQJNptImeTif2HsmedegK/SAvMhtGZ6dsyQMCyPP3KhJziakDLhIEctm8lUsF
         Fv8frm8NaSFCDjjjX0QLX9dxAnU4GFgwK/ZUX6AfS96R5j3o3NU+puJVaQvtjxxQKCQB
         VRgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnqG9eF6Y5kWE6YPLbo/fwIIsGoGzr5+0j06NFfUwuxj46KrqP6OWWrTaNl6aeDgXPUlxSikDmfyFm5xCnjJN6gXnI
X-Gm-Message-State: AOJu0YwcFh4inGpDiSAHnmqr822sEX4P3iZu3Gz4wG4YY7sRrfbgNg23
	EzA8RkO+ZAPYy03DehHLBqqGThun9e1sgL7WojnOU7aTgi7vhSuoIQFRjvZc
X-Google-Smtp-Source: AGHT+IHPN+0JUF2S2XUsIpAUJt54qZ7LnDfw8DiNbPrUcBdTbEKR6Eg1xRFpLjIHwDr1y0DgjKln4A==
X-Received: by 2002:a05:6a20:3d83:b0:1bc:e9ad:e736 with SMTP id adf61e73a8af0-1c0cd182f85mr1736948637.3.1720090754437;
        Thu, 04 Jul 2024 03:59:14 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c7f76fbsm9537295a12.73.2024.07.04.03.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 03:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 16:29:07 +0530
Message-Id: <D2GPA4L6OZG5.17BQVOVDLS672@gmail.com>
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>, <git@vger.kernel.org>
Cc: "Christian Couder" <chriscool@tuxfamily.org>, "Kaartic Sivaraam"
 <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC] Blog: Move existing tests to a unit testing framework
References: <uhysopkwfeucsptx4n2jgase2duqhckcgujiyobqd3xw6ioez3@wv2vpethsjre>
In-Reply-To: <uhysopkwfeucsptx4n2jgase2duqhckcgujiyobqd3xw6ioez3@wv2vpethsjre>

Hey everyone,

My Blog posts from past three weeks can be found here:

Week 3: https://spectre10.github.io/posts/gsoc_week3/
Week 4: https://spectre10.github.io/posts/gsoc_week4/
Week 5: https://spectre10.github.io/posts/gsoc_week5/

Let me know if you have any feedback!

Thanks.
