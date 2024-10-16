Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A7E5478E
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729113026; cv=none; b=tLFyCiGMqqyIHkhUJ1DMJL4hju0u/3Vk5me/ueRbnXSdhN4PNmJdhYh1HNER3H66THv7Nve7vDLQ/uD8XxnhtIqede+5PxwEfXakkMBLWfS/MIqdFtKlfzcXxpSQZO7APxMEiRgPepDLsjWLbZP31S+aA1JowGVrHT/wLwKph38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729113026; c=relaxed/simple;
	bh=YSu+GZwbINI+KRCzA5/MjDeUu3YSlFZkMujEuucLhRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4bsUyqIWCbaSy+/QfNqDCIaOMQtgVgQhFwP6lam4hJlzMh0ealk1oqUYGjDA3jsJdizNpE3+1iFrKzVnQmPpAeEI0siEWzlqbRdIoICYtmFeEQuNi5Wfo5BETbSPFpSvyyfZ9RuW6DjE4pMgc6rIFTrD1sdo3rZtDoVr3025fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=iXtVWomO; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="iXtVWomO"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e38ebcc0abso4692987b3.2
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 14:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729113024; x=1729717824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wkTg4urA3pjMYPXhUw5hH6S3KGmx6DgM364QOXMDghg=;
        b=iXtVWomOP//UHoDB8G7w2uNI460uEWX074bkeRrVWhn2fYviGDzF+ragb+uGAJEB9L
         U4xO1kye9IIm/OoxEoaaPbAA71qwnQxlj20QIBDmmE2Mn6LDi+loI+MhmPwXBl8wYFVi
         sofHCwTGPw6TVRLUICZp2tw18Y47OZ1U1xU6oSMVfms1EY59z8QlilI2HB2WS/18X14C
         iflfExUE1GuSWAXrbb7iXwDoMXc/YIWIDdyFLJW006cVhAEvZ/AUAbzXPsKt4DkdUrjj
         brlCG3lyCJjwn8UboG6o8dVO7O3wK9uZ/rZ80lWpZ0piO4nqGuzyHqiYuDqbUG9fdcdi
         6LMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729113024; x=1729717824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkTg4urA3pjMYPXhUw5hH6S3KGmx6DgM364QOXMDghg=;
        b=exg6RoTJDgLW+vFerKqOpQ09BnMhjexcYgT0djlwA+ie6qYk2bOAK1HKi6gW4Vj76a
         SoqfGRXSprjIxNSAoqTH96cgPZBYou+LrRmnihi1OlLRdGsAgPRMYp2prjoK7O87i12Y
         nH5X9HjN6WAZs6qIRcIsFL5c1opdMX1rk4ihBr/m2pSD4qQe0QWz/c7C9VvINH2gr0Sc
         eh2jYNvJ/vo8vml5BKPg4BWJfnJ4GQsEcL2WBzixDV9rHp98exHjAtqQyCI5aYCz0rMf
         h7vUI+NZGIzQH+RYuLWp0x/KXC1BCwsIF/b2EHqTSBoRL9jOts+XXOY0kQ2ypImIwz/F
         m2QQ==
X-Gm-Message-State: AOJu0YyWlEP4Gd9pbP7RbqYod2D2cONnbEcOBSgnfGu2drDQxMWfKPLX
	LfmBokcV334xDBVLOTpupDwxi1UCCqv+JWG6j/kmxYqurQB0efiL8zmcdS5i4ehygGs3SsEvwua
	m
X-Google-Smtp-Source: AGHT+IGcvFqZBlBXWiIDXBC+ygu7icwK2KFDB2tichuniQJKtOrcr/7mr44NMf0joYVEo6NgUj6H8g==
X-Received: by 2002:a05:690c:4a10:b0:6e3:22ee:bfd3 with SMTP id 00721157ae682-6e3d40d1740mr59428137b3.20.1729113023747;
        Wed, 16 Oct 2024 14:10:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5cbdbe7sm8535627b3.92.2024.10.16.14.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 14:10:23 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:10:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2024, #08; Tue, 15)
Message-ID: <ZxArvQMURgclzEFt@nand.local>
References: <Zw8JFB/SUN0WlwNk@nand.local>
 <CAPSxiM_=9qjcrJRiwsSCOy-DvkmZH1ooNqLE-DGJJmtfYbVs9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPSxiM_=9qjcrJRiwsSCOy-DvkmZH1ooNqLE-DGJJmtfYbVs9A@mail.gmail.com>

On Wed, Oct 16, 2024 at 01:36:49AM +0000, Usman Akinyemi wrote:
> > * ua/t3404-cleanup (2024-10-14) 3 commits
> >  - parse: replace atoi() with strtoul_ui() and strtol_i()
> >  - t3404: replace test with test_line_count()
> >  - t3404: avoid losing exit status with focus on `git show` and `git cat-file`
>
> Hi Taylor, I sent a message regarding this.
> https://public-inbox.org/git/CAPSxiM-Cn8ZSC+LzRfeyY+Z_Vfj=DguweQ+ZjC4dau-Z64dnWg@mail.gmail.com/T/#t,
> kindly check. Thank you

Thanks, I had seen this message, but it is still not clear to me what
the difference between these two are:

  https://public-inbox.org/git/pull.1805.v7.git.git.1728315124.gitgitgadget@gmail.com/#t
  https://public-inbox.org/git/pull.1810.git.git.1728774574.gitgitgadget@gmail.com/#t

Can you respond in either one of those threads which one I should keep?
If the answer is "both", please let me know here.

In the future, please trim your email before responding When responding
to a "What's cooking" message, it's common to quote only the topic(s)
that you are responding to.

Thanks,
Taylor
