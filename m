Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D3F1E4BE
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 20:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139967; cv=none; b=Yzt7HkcguZfAjn0oMMkB3UdBkSFBdycDmOhAxohmYXT+qgdse7NfycLYyEMfMVNJewCYRQJQZ2d8z4xYSaPKDYus0lDc237q5r+a5BmLObpwSPTFbkrP5sJFJ93ZbNwE6XTaRz5GWGxOiLM3TmmSZlx0FhiynTmjAvoagAvaijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139967; c=relaxed/simple;
	bh=oa2bTpcRxsz+KfqbQ0juBVsk67B++yhNXL/JTPaYX0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKIqDwDCvZnb3x8aZxDOjaQYAJ6H46v54SvarvvF7j1s02YsbkvSslbAku3O6kB8pqoVGaCGvihe2KQCyQ3nwgAw74wd3LIdD9063H59BxnFqWtOh2BG7ChHOYZ6tGy/DZIUnqY3l6v6NA5vsZpKWEwyr6C8cIv3KMSMuDIkOd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARyaG0z0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARyaG0z0"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45f2c4c3853so797185e9.2
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 13:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758139964; x=1758744764; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lLAG0jgIaXpa3neFEJslTa+MPKhxiiFGII83cqLQaWY=;
        b=ARyaG0z0y/sI64V2wnQB7BR8oPgEvI0wJrT/q/nJry2jEOcBy3MrHu59uVQhnq+TcX
         KqIsU+pcoxDC8rhX3V+Tx99ka4w5pXu9z4hB53IUZ8bRMW5lTsqH+Yg2XE57SfnZJW9Q
         9Jrt0WH4rTRhwj+Yquy0D+FbQlNsUg06EfDUtNuF3RznHapMsIg+pWCwWmw23U2RwdZ0
         Zu6PKFqm4AlK/6s1WtSZsV2eXjr0dbuU2CKND/HPGgNAnKu2/TmYYreH1bEBHr2bgCDU
         8KFNqksKVDdUxQaV70oBVGW8zMvaQDdaLLtoiyoBKA1qOe6reA3FitByqju1Hl4IxeQf
         Sq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139964; x=1758744764;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLAG0jgIaXpa3neFEJslTa+MPKhxiiFGII83cqLQaWY=;
        b=al3HN+R5Vz6T9ijoGwG5hN/S53OPt4/IMln0a49cYR16CBh4zFamAY+jPouGLVOiQK
         oFLcDCCoH7fcrwCMhjgNDIsntG6YS38FjPZ7X9HeR7nTkVysu7I1CQ9nh8vo3eycq+ve
         RLqxmNDtsdzBtBLFFzEGeCQAg77KG7f1JDhC+Kxb0WsYK+xd6ne3Wft0IvV7H+Mo3WxO
         FdtGK5fiD9P3cD4KBzbhGTzpEFPn3GCLWQQ5VIOJ5yCibyC4NVu64bt7nwwS3x805+wT
         1QLdmbw1+5Rue+x/8XYVcsMlxw/QF3AiVG6aze3cKIiaj6kZxuliob4NPGTtW4XWnN7a
         MI4g==
X-Forwarded-Encrypted: i=1; AJvYcCUPKwqdP2MDcRChdwuyoPSBa2dQT6n6w21XZMMtL9MxPKqyM8lBAktLowfTl319Sj1DlSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDP/JvRcTB2a4wB++Oj1lxR7tafmLZntimoUfRape9djg+R6gU
	43r73j0QexlZ/MtVA167nIOi59CIM0J99Gj222cFODRhJscb7BlF2ejV
X-Gm-Gg: ASbGncshJL+73O4gal1SoFdyk2QSTDXqeSVR6ijTBWbMcv1mId4OVqGpJbpWNKEH7L1
	DAjai3JHGqhGVzjSxe3K7o29VBjb6b5CYhxTZFdMdcnThg1gGOxjoi96n24cVaNMQ92crRWGR2B
	LNctRFLpJF+MvxVyHMSYXbHkvC8WcGc3uMo/ABZ4l6oO1Od6eyrqNEPRYx7vNZvlN5lgRfypeXn
	4DoHfAx10Mgn5N+7mMAlTvftymnhI/04qGeWgrl5xAaVai8sj0UQaKfLnZvpRvb+0YjX9L90lwB
	ZHiYpD1a4CTb8p/+CDhIquBXP422mJo2S3on616CbNDQ6ZdgAGOstq27d8HJHYK4ciWcMaxEhoD
	2QTws+ak7lo/x7Ef3rVOdpXLXgOeT8oh9AyWzNdMbEjgkLFYTbtfP+ZNc6wfzKGe207Jlr44=
X-Google-Smtp-Source: AGHT+IFu9MVYTblEUsgikdjtPcfoP3dd33jAQrpvqZKW0784ae/Qh/HNTV6SzAZ0wiOx1b1DpUIvlA==
X-Received: by 2002:a05:600c:1c8c:b0:45b:7b54:881 with SMTP id 5b1f17b1804b1-46201e95ef1mr29162485e9.1.1758139963864;
        Wed, 17 Sep 2025 13:12:43 -0700 (PDT)
Received: from localhost (84-236-78-104.pool.digikabel.hu. [84.236.78.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f5a281f1sm9238895e9.17.2025.09.17.13.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:12:43 -0700 (PDT)
Date: Wed, 17 Sep 2025 22:12:31 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
Message-ID: <aMsWL2cSoytbmRjA@szeder.dev>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>
 <aKs3tqjE510MF0T-@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKs3tqjE510MF0T-@pks.im>

On Sun, Aug 24, 2025 at 06:03:02PM +0200, Patrick Steinhardt wrote:
> On Sat, Aug 23, 2025 at 06:25:06PM -0700, Martin von Zweigbergk wrote:
> > On Tue, Aug 19, 2025 at 3:57 AM Patrick Steinhardt <ps@pks.im> wrote:
> > >
> > > Hi,
> > >
> > > over recent months I've been playing around with Jujutsu quite
> > > frequently. While I still prefer using Git, there's been a couple
> > > features in it that I really like and that I'd like to have in Git, as
> > > well.
> > >
> > > A copule of these features relate to history editing. Most importantly,
> > > I really dig the following commands:
> > >
> > >   - jj-abandon(1) to drop a specific commit from your history.
> > 
> > It also rebases all descendants on top of the parent(s) of the
> > abandoned commit(s). Branches pointing to the rebased commits are also
> > repointed. So is the working copy if it points to a rebased commit
> > (the closest equivalent in Git would be HEAD). Do you plan to make all
> > the `git history` commands behave that way too?
> 
> Yup.

That sounds scary...  What does "all descendants" mean in this
context?

Let's suppose I have this piece of history, I'm on 'branch2', and I
drop commit B.  Which commits will be rewritten and which branches
will be repointed?

   A---B---C---D   branch1
            \   \
             \   E---F   branch2
              \       \
               \       G---H---I   branch3
                \
                 J---K---L   branch4

