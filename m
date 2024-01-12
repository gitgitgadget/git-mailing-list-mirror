Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B20B657
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 00:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtWopePC"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-557c188f313so8400279a12.1
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 16:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705020952; x=1705625752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cqBLtwwuV7rNdV9LaU9dbeJ0tnSXlmvSWyGbbjo9TRA=;
        b=BtWopePCjyQNtSkh9i4W2+Mlaay4M8gKenuq08NmPAWSZSVZ9huhPNuqwuqhq6plOc
         X84kEpkiyKvyJe/iVl++CSC4L9KMKS/vW6cbOuAlHbZQg7xf465fgzl5Zhk4YLt7TQgU
         eaAhjWGjbdvv4l/5K0UWmcSdQZtep2kLTo6m3l7RBgn0OUT0/pwMEj+zE423Du4lk42I
         dsiWX5jfz3b/aNx0ATd5b6sk/zAhaZ5IgjzfJYLDPYD/S08aEfKgYAt/4qfvmAZNo1H5
         4n+l7Y3Lub2etXAdJ9eBy5Yo9Ruw7Ikt4iPtTab/9JzGAM9R89RatWiAd5TNklWzhmar
         hOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705020952; x=1705625752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqBLtwwuV7rNdV9LaU9dbeJ0tnSXlmvSWyGbbjo9TRA=;
        b=tue1t+BvQKEOAXheHiPLAfAAsKP8LYsjUhKBEm3XYDX1T7iO1EDXRKp4OZPQPKu5Zi
         laeOk7jmiMWMMlYd4sHQTgvc86PQtw4y5jCQlrwkZT8mv1wdFRAB21bgIHcyvCc5wIR0
         7+AeNn5vlpCq5fix4Js5LlDTWHMbNecxW41UKkPHRg5SbK+F0ag3/8NZfgISM5StEn2Z
         GWDQbyYQuxaXlkrD6cNtpYVqhZg8d+wreU+Bo+CynXIY2u6kpvSWyphHsze927d/ChCX
         ForPPZSlm2cKWzjS+EJvopy8/NzZtxBlWB0P3B/rO/GfX74Gb13yWMttaVB8sEE1yZcL
         X8nA==
X-Gm-Message-State: AOJu0YxLPa4qgvY2VKDiwUHVtpL/U2/SfBUVXqyeck4/T+OBzZo2DCEl
	1H11ObfvP+0Q9WU317ZIHbNdixaS9h83u1Dj1Q==
X-Google-Smtp-Source: AGHT+IEC+/L7yCdSELzTYcSe94HWbhkQx4qvxP8cfHaDW2M0oLRcaUPA09f5Lh/yEom4nL98ntnYTdkASwC8E+4yPNQ=
X-Received: by 2002:aa7:c6ce:0:b0:557:dd03:cd with SMTP id b14-20020aa7c6ce000000b00557dd0300cdmr668802eds.19.1705020951571;
 Thu, 11 Jan 2024 16:55:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1638.git.1705008449995.gitgitgadget@gmail.com>
 <CAPig+cRr0V2ecnmxk1H_yF24dwSFA6niPxYXGH0MZ+wGP9m9UA@mail.gmail.com>
 <xmqqjzofec0e.fsf@gitster.g> <CADavbxcFXpP5EQZ=UEMZt+6KKVtCsTMbgQDHEo0uinm0YfRbZA@mail.gmail.com>
In-Reply-To: <CADavbxcFXpP5EQZ=UEMZt+6KKVtCsTMbgQDHEo0uinm0YfRbZA@mail.gmail.com>
From: Benji Kay <okaybenji@gmail.com>
Date: Thu, 11 Jan 2024 18:55:40 -0600
Message-ID: <CADavbxdexJ-nzbiicLF7SOJsELKW5J5Zox5MFGdWDHhcE=85VQ@mail.gmail.com>
Subject: Re: [PATCH] push: improve consistency of output when "up to date"
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
	Benji Kay via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If it's important these messages are not changed (under the presumption
some programs may make decisions based on the output), perhaps a test
should be written to ensure the output is as expected.
