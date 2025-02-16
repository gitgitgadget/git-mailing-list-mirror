Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F299610E9
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739689950; cv=none; b=ZzGggDtiK9bHEHV1USSe/bGwvH32qgnBnFewjIKHdTsF9Eb8ORAY+Krl983f7xIWJ/x35ETxgvRFsVMFjkud349WVDP6bbrVwNcgNlAzD/KJvg7C8Ah52LZY7i9aLVUEd9KAiqnhy7Qkd/y9fEx2RCaPbGxtdB+DwRTEOgZ9qJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739689950; c=relaxed/simple;
	bh=/Hndr+P36yp1YfeWB0bNCi79AdHHYzBsMppPzejTJKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZE4+TI+lgSuxoSfrZRbxSZPJbBXj+a2CzNtg1GlsWRK9n1En+OmxjYaMG+xUEC+i6JJn3I08BfS7IYwDKtIDvr473jwaEeS0ZgmmPSLYJAxt1Tf7Pjts/wfwL4SQ4nrcsJ5NBrPTh3KBFGnZMyymLLVgkOMvmirPQ27+njDytck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZpr6RaQ; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZpr6RaQ"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2f44353649aso4766355a91.0
        for <git@vger.kernel.org>; Sat, 15 Feb 2025 23:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739689948; x=1740294748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwFIeVwYYYJZnZkSV7Uib6YZItbT/+4KZWCjo6HvdJo=;
        b=iZpr6RaQsbYMFpdGks9hkD28UAtjmuwbh6qyKc8LJRMjRKqdUuj6CdTrcgSXocgfWN
         hLS31CgyEkXDHRkZPSLRBi9uT3MYi9JDOpYE2ets6AoJYzL9X5JsQtrB6kNOGYeWspGq
         vc9VHu8/ypz/ZCsAv669CRqqYk1CnjOVFPok3NAhGhdE10f95sjaPA66z1p1i2u6Nc5j
         Tv2DIRMU6EuDiDPzaIVR8j9E//NgmwvXHrp/NOZo63hvSKHuXEpUbjscw2xi4RMqU3Ig
         TORKdjF5XrXaChMPK2/h4JyTm5hL2xBW5e8JhHl9Zn3bK18R8SrWeRMEtnx7JPBw3X8o
         HXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739689948; x=1740294748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwFIeVwYYYJZnZkSV7Uib6YZItbT/+4KZWCjo6HvdJo=;
        b=rVaRsZ/NGVmsKedm+QXJsaqbt9KUzL7wMsyMunEGr8gNob4coLPAppzC+irfnlgPRX
         peatFcya6H22e8GA/OuAarYA9WEXPL7v0oY5sMqeuV5VLjdtL3Qnc1EwIYXnP9pK6qTI
         0cGRACiZeNYgJVu54cmhTRHoawg5fKaVr1sOiKoQih2NCNBcKpysoNiaFcmaevgiRYN6
         S3SzA9AH42rbRTfQsO3r0+dtFOCdDp9NHZhEtJpW5gQL+bXQq+tPgKk7vq+s6ulDWQG0
         3MoReyH9kVeKZgwPdDLRGegofLyA5WikuJj/2az3FYQUk5ZIkoGODfTOIlosrV+T9F3B
         KJ4Q==
X-Gm-Message-State: AOJu0YwNRU4GYd0yy4G7xE8z/lxN2sa0LXBbOruGNImX/+JyQ24E672A
	UTPpDY1mLL++tW80xDnn260To5TuD27EFcTPq5NAqnDU1gOYB7GY
X-Gm-Gg: ASbGnctqaqXNerpn74qxS2xVrSh/Ed/E54kFWldqOqsr4U1fQ0gMc6wYuu//81ScqBo
	TS/mqVuNqrCaooNNTTKOeUQntPFZ0xkQW4bV/zwImouZUtOGHAQ8byiS1PHIHpTntUU81EXMaLy
	iyaTZcTKrj7WDJtDOAnK1KZYUjn3Ztz0LZh6HcD1OUX7ygJtRl66DaSsE46Syo7w6hMWH6lMA/m
	0tcnHuLMSWxfOGDJTPRET3FTOwUmP2yp/YASIy+R8v7QPKchuRgazgnBc8REG7ZNOolP47dP++f
	+I28yfmuykGgRxWOJgMwkN/Qf5I7UkOoenfRDKUQH8g6f2yQuZjP
X-Google-Smtp-Source: AGHT+IE/zcZFOGBBm2LGYNwcGNX7FnQoHqxPAYRSC1yPFOI4yTL3Kh6xj56e6YI2uJB9s4//bmwhXA==
X-Received: by 2002:a17:90b:1d90:b0:2fa:b84:b320 with SMTP id 98e67ed59e1d1-2fc41045081mr8591344a91.24.1739689948077;
        Sat, 15 Feb 2025 23:12:28 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. ([82.152.91.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98f0d17sm7972974a91.21.2025.02.15.23.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 23:12:27 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: ps@pks.im
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jelly.zhao.42@gmail.com,
	newren@gmail.com
Subject: Re: [GSOC][PATCH] apply: address -Wsign-comparison warnings
Date: Sun, 16 Feb 2025 07:12:02 +0000
Message-ID: <20250216071202.61372-1-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Z62MTZXQD3Wa47Jz@pks.im>
References: <Z62MTZXQD3Wa47Jz@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Feb 13 2025 07:08:13 +0100, Patrick Steinhardt wrote,
> > @@ -2706,7 +2707,7 @@ static int find_pos(struct apply_state *state,
> >  {
> >  	int i;
> >  	unsigned long backwards, forwards, current;
> > -	int backwards_lno, forwards_lno, current_lno;
> > +	size_t backwards_lno, forwards_lno, current_lno;
> >  
> >  	/*
> >  	 * When running with --allow-overlap, it is possible that a hunk is
> 
> These are a bit curious, as they store `line`, which is itself an `int`
> parameter. As far as I understand, the only caller is also only ever
> passing a positive integer here.

They do store an `int` parameter, which is `line`. However, we cannot change 
`line` to unsigned since it can temporarily store an negative value before 
the assignments to these `*_lno` happen. Below are from function `find_pos` 
(without any change).

  /*
   * If match_beginning or match_end is specified, there is no
   * point starting from a wrong line that will never match and
   * wander around and wait for a match at the specified end.
   */
  if (match_beginning)
	  line = 0;
  else if (match_end)
	  line = img->line_nr - preimage->line_nr;

  /*
   * Because the comparison is unsigned, the following test
   * will also take care of a negative line number that can
   * result when match_end and preimage is larger than the target.
   */
  if (line > img->line_nr)
	  line = img->line_nr;

> > @@ -4288,19 +4289,19 @@ static void summary_patch_list(struct patch *patch)
> >  
> >  static void patch_stats(struct apply_state *state, struct patch *patch)
> >  {
> > -	int lines = patch->lines_added + patch->lines_deleted;
> > +	unsigned lines = patch->lines_added + patch->lines_deleted;
> 
> This one is curious again, as the type of these variables is an `int`.
> This should likely be adapted in tandem if they cannot be negative.

Thank you for identifying. Will be in next version.
