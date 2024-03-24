Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C24F18E29
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711299836; cv=none; b=VTf/JqtrU24TaLqUl1uTfeG4O+leWxxBkLxzdCbojdpEd3y5i9jvbEIjrRw/X0Cp4pEeujRj0UtiO40rPgUFL5n7enqpK8ep65swXhtvW52+OVD9/0IJJkhzijORpZcwygoO5gvP1W+0t+RtdWbaBus+EATGIkt7oJm9dO9M2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711299836; c=relaxed/simple;
	bh=ns2MX0Gg++BCtbWrhB8rIaD+8lHmPRZJptJewPOvuJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IU2HgmS5mjolI4Ip5ng6lAFvwfSlL78pp3wQ5p/pr7yRivm4otmn5lJ2pKzbvh6JtUEJ+YF1RGGZE+v7ynM/1vtCzvHUOlbZvvXQoNzPv91UZ2TEAufVaH1kBnC7Xgtl7Fk0pGecXfu+Go7XAgwyzeRSZ/6nYKeiL95wgv0I2vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6968a5d1b47so2646006d6.1
        for <git@vger.kernel.org>; Sun, 24 Mar 2024 10:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711299833; x=1711904633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/7MX2Gj+NL1SBshB/epFJArzCe63I9nZVGoAzWkIWs=;
        b=oxHXkkD9GWL084OG6xUL9wUr6jW23RR1qenAP5W8Hjo5FHL1dJyWAQF0VWPu5OuEK7
         /9yjtJayhrUDcRSoPylmeFQe6rkvtmHhK60YJfXwuIXBmMeN/IqI3JT9CQ20iZX9XG8g
         VbOOC2t0ButAksf/yBF+jrCBxFLFMimrBVqt8ulH3ncaPMGDoHizdBRyLRIub+dmxUeL
         V+5PLZqXYvDTUJk0DcHP0XhFIuFHsV0AjO29U5wJeTizdYtehLfbOC0mBUBCqu2s4udh
         Kj7JXUI5ROtbN00QbcWWl9poj/LNp9QVdFw1HuYw9GkfVd0KUVoynQ3Nsy4wtUxj8mWV
         WB6w==
X-Forwarded-Encrypted: i=1; AJvYcCV5brfFF0vsEjCgEH0KdUAj/xtUQ8MsaRaefcTFEoAbMiw55Tni+VK7LpNbtZuWZKZegcdjc4zpc2RaBxFasEc1Kv5T
X-Gm-Message-State: AOJu0YyeM3IX8lpRdcD7awtZateeQn4cimWd8tTBI1Qfloa71enP3hut
	m0N7yuizpM5ddTJ6WGiYEf7i4V1bSRqLtDw0GpJ9mZwgiV5eiPezeY1XMQKT6+I8/L8Et1l/BQ9
	68EO5I92M+240woK25nM34aIobHg=
X-Google-Smtp-Source: AGHT+IEIy1nNNLNmkSJ0gz32IAYwmT7loTte0c0TeDAgEPYKBdZydjAy6qA8XyID0MhiDSdGI1CrLU5IKOxug2pYawY=
X-Received: by 2002:a0c:eb92:0:b0:696:7ba3:ff50 with SMTP id
 x18-20020a0ceb92000000b006967ba3ff50mr3989368qvo.48.1711299833429; Sun, 24
 Mar 2024 10:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322221327.12204-1-mg@max.gautier.name> <80580cc5-0285-43d2-ac51-71dce16f0028@gmail.com>
In-Reply-To: <80580cc5-0285-43d2-ac51-71dce16f0028@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 24 Mar 2024 13:03:42 -0400
Message-ID: <CAPig+cT1Bz9M5zsB_OSEu-LTTVMBPY6U4vaDHmoHtmoDfH+hpg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] maintenance: use packaged systemd units
To: phillip.wood@dunelm.org.uk
Cc: Max Gautier <mg@max.gautier.name>, git@vger.kernel.org, 
	=?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>, 
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 10:55=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
> 5 - documentation updates
>    I'm on the fence about having these in a separate commit like the
>    current patch 5 or updating the documentation when the code is
>    changed.

It's generally more reviewer-friendly to bundle documentation change
into the patch which changes the observable behavior. This way, a
reviewer has the behavior change fresh in mind and can verify that the
revised documentation matches the new implementation. Same goes for
revising tests in the same patch which changes behavior (though, of
course, revising tests at the same time as the change of behavior is
also mandatory for maintaining bisectability).
