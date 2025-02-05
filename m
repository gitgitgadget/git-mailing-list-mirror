Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86E015FA7B
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738776089; cv=none; b=LPRGDwuk9rW8MoFb5STU5X6+zVdtjGcMGEeeqImDc1RNJ3NkLn7OnQ3QP9TFwv8Y5Vrl05ijbgy9EvmLLVxZhdHgQ5ETQ/Q7Q5XOyCr7ZtESY5DMlrUK1/5pjH4F6VZc4CbEm13nxrzCDoOWf/0qYHtAfoAQhPzwPPdsMuQCm7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738776089; c=relaxed/simple;
	bh=GEaI+e4mwAse/fMIs+rddDgwWXT6K9wardkXnJz8L6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P50pTLKwydwLJV4cXW/CNj52Sj3Kbg+3ddYz3e265EjXhLkAu5fVt2y9VSqIhPdd3INA5RBoy47A8gUJXebZlLy5ZouflumSLE/5k+LP+h8hYj4uvhsHPAxid9Ap9kT1Lr8z2BGHlaf9RqtBYz3ve2+jaaJzlzXYmT6ZLryg2/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdfFG/H9; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdfFG/H9"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3eba5848ee4so3267b6e.3
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 09:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738776086; x=1739380886; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ckmjEd1IKRzlbdv9K/XmWAutjPW9M+HzmSeE4O2rshw=;
        b=jdfFG/H9A3PgFBI0nCDL3eeZ2kNYvbr6z4TBo73Db8AhPD3d5vjX42nPUKXhCAcTGp
         2u+RyfF4HRvOR2KD2pvKigOwiKTG8udv1oz+r7LD66FWqgr1E7OCm6Mii2ygdtfDb1gi
         adTiujHDqfOkcwOw2ul+BOE4vqc2kUJwyjC1spqQcEWa5KAT4TaO+Ll8htFkCWT727IV
         U20MyydA/2p+BvPenCx0rAE3wCrhVPzSqqoteay5dqp3dxqX8t9EaLsnuTiFVycinH5F
         nmSiSlDu0FkDl6BAz84mXs4pHfBVnhlRtp/ll2Y08eY4VuJEFftDeOI4qW2JguuT34uY
         tGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738776086; x=1739380886;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckmjEd1IKRzlbdv9K/XmWAutjPW9M+HzmSeE4O2rshw=;
        b=A+TWjxIC+Qdl09B/uMtYnHFsI6ZKFwTmK4uLGuYT4KFB1OOD5ak46iO1C8RRfBSF+3
         cMU5BMSFAOJKOnqNk4HdpbnmDKPvfYcsRlcxPdDVeqw1IA69bTuEaVA1fBhQtbndBxA0
         EuWxC+7WoHDSbeF+vh23tFCAu7/WAplvYnv3MFjL/duP0+6Cz5LBVgtK9UmILhaIzq6L
         5s+w3GeaiPIi8QeWs2E7uSymasgj2Bi2TM/dz6+jaaj19/dooQ2GgNfwLljTRZFtLtrv
         7ZLHov1VZF931IJGulTyO9c50nyemCtUkx1lxI2MKq0vtw87hsy9huLPmdNSP/5CaA9T
         My+g==
X-Gm-Message-State: AOJu0Yx4myHNwrRLX7G4pFe+aaUc/kn6exUMX0hgoR3hS0WvRxCOu1dx
	Rnp7wOLiu7I+wTBYjWmzMp8EDX9NJm9mAvedyzZVWlUM2i2g0QbjlGcLZw==
X-Gm-Gg: ASbGncuw+6uD1Ycip1jI0b0/4fUMyn6VQJrOV6eDHbUXwCeBeq++c2v+tlJQc7pAMFv
	Y1zszbwo4bYFakgn5M7anH5GQUezYWaIn83kQTbwRwjGhQmPcvnEN2X+rqx2dmfhuSrrWLVXddn
	aBkhgB+qdAt8yJQ6ZwdcbwAFFlttDA736d+K/sXr/hWXuYSsUHwMI0WZcrFUpPbwo+zfOiE0dto
	SlwKVHsW3o/o5PpASfRXZ/BtgT1jVU9djSDauglUfZArmoqL9gxFLFFq7N5+AW0WO9SLDQhtWtk
	laF7Zdgp
X-Google-Smtp-Source: AGHT+IFF5WPdjhU6D9OhS18HZk0cEAn6a4aGXNmFlc5GDfuqyqZm4JYWP4F/VQwffE1FJqZmQfCO2w==
X-Received: by 2002:a05:6808:10c1:b0:3e7:b800:1d80 with SMTP id 5614622812f47-3f37c136eeemr2457423b6e.17.1738776086647;
        Wed, 05 Feb 2025 09:21:26 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-726618b9f2fsm3985208a34.53.2025.02.05.09.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 09:21:26 -0800 (PST)
Date: Wed, 5 Feb 2025 11:18:28 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/2] rev-list: print additional missing object
 information
Message-ID: <nvg26kqiyzvzp65aoelxbhl4e7bodo7zsldqq7shgah65dyt7r@ojnp7ggj65ie>
References: <20250201201658.11562-1-jltobler@gmail.com>
 <20250205004147.887106-1-jltobler@gmail.com>
 <CAP8UFD31kbtqXQDp9LyA+x+h+m592=HQHHbskSfar3S2GOfWVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD31kbtqXQDp9LyA+x+h+m592=HQHHbskSfar3S2GOfWVg@mail.gmail.com>

On 25/02/05 11:35AM, Christian Couder wrote:
> On Wed, Feb 5, 2025 at 1:45 AM Justin Tobler <jltobler@gmail.com> wrote:
> 
> > Changes in V4:
> >
> > - The core.quotePath behavior is no longer force enabled for the missing
> >   info values. Consequently the first two patches from the previous
> >   version are dropped.
> 
> This v4 looks good to me. Ack!

Thanks for the review!

-Justin
