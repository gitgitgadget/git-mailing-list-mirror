Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F371BC46
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 22:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708901962; cv=none; b=J/sCM0s/eYoTRim8l9N6S3vaLPhfTXu8rIZuReY4v/Dy1MELuvgTblxxP4o2Z05o+c0BPH26pyKO8YqXitSejsTDnYdeLWBXwt6ctfXLYOiNh30NI66JNefFIFTaVnup6WhlGMxHQb5vnOv1dMD30sPH/P81u3QQX1wXwfNaEU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708901962; c=relaxed/simple;
	bh=NqUI35p5cVwKjJ+ANQ4QinMiii2Hl9fOy+5cLEyRKBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNRUpmVofIhvUOpBloVwfzSBnXbl/rvvlUpFucnzrSGY2bUHImulVidk206Le7d7cL1WAc33LKIWJtJgvTgJsLDk7m6FYDVW2K29mdbckJCTowbWFMfGG6ml76i54P7yqjKsCyq9eUcbmbkbcWp1Fagg5haE67/WU09hbio+FYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbHjhvL9; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbHjhvL9"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so379502a12.3
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 14:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708901959; x=1709506759; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YZbcTuczF07NB/G0cyEn17sqyjxndfhZZ2KT92n+JDc=;
        b=VbHjhvL9+Dx4x1BQfxZvxCrQDLHS72K+OLS9Rgj7gLbbSsMpbvjzZZTo8j1B3SHNG6
         FQq4vot8dGhyX+GgWhApuMQwnLgKFjIgp0mnVVFYQ0I70NkT8tXhvMBwasEMY6myI2aV
         4eYyz2Jdg6EcymkJmP20iK7NGS7LPdqxmW/C48cNZHeQyWPTCw6QlthuGmzBNZBoHefa
         P/JCUsuW0jDb13uf0cTvHy730xBDI3i/PEHDVqJKVT+hhSNMVlHTYiZ+0/PgT4RXM909
         D+whr5fwcuGKRYa3aeS/f7xmXwH6IBs5mD/Q//OYyX72/NLjls3siowHfhK6FyT0t8Al
         tW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708901959; x=1709506759;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZbcTuczF07NB/G0cyEn17sqyjxndfhZZ2KT92n+JDc=;
        b=QC/Ow7HbZYMD52ebM2Cp5w9Krbh7LMqfIr8NG5UQl/6G8HjpMp4gLtksmO2jP0xVg6
         ErsQcsyBroC+rbifgjQAdYAXkC662id3kYDoexPLTMGoWC+uHo1/tZ/7nwF8HquYa25t
         /7+Ivzj4C2dTEpHTHMqS5C/dIPWD5hSV6T7Q9joOm68pTzG5bXKr2qaegswrNnb9+7WH
         JAaLso8uxEhEtosaGMJCnZ5ZC9dyqrVeADkcgwHyOMROT7uneHG0wl/JS8wlgm0dXHv/
         nlwdMnodvLDnsj0Zs22thcp++63Bi9oC8nzavGc7PeX126ISaT+gaoSzLm196uwwbOKH
         Pi8w==
X-Forwarded-Encrypted: i=1; AJvYcCWt0eHMxC23ad355Czy3EHp4nauvSAB8SpMKpQxvgxVNly933mfGfbbJJgdBveJN/Ut1/NqxJCcj/erb2SNfy0p80lx
X-Gm-Message-State: AOJu0YweWNC0oLQg4AyYviTRZa2/AHKovUpLcQqv4s10guSm475vL+K1
	4Q1BxJs2UVDkYbiqnd+mzb6k3ASp0k8IZle84LNfWGvYqakkenXYHGs8hXyK
X-Google-Smtp-Source: AGHT+IHh3Ew3k+ylnnkcc/gnbFUs1n98tQ8/riudw5Wpj/l2xB55LOqRBMhp/JqwFOnk5028yLBddQ==
X-Received: by 2002:a17:906:a046:b0:a43:35f1:944e with SMTP id bg6-20020a170906a04600b00a4335f1944emr1415144ejb.22.1708901959584;
        Sun, 25 Feb 2024 14:59:19 -0800 (PST)
Received: from localhost (94-21-146-251.pool.digikabel.hu. [94.21.146.251])
        by smtp.gmail.com with ESMTPSA id z22-20020a1709060ad600b00a3d125b9c0asm1820419ejf.81.2024.02.25.14.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 14:59:19 -0800 (PST)
Date: Sun, 25 Feb 2024 23:59:18 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2024, #01; Tue, 2)
Message-ID: <20240225225918.GB1940392@szeder.dev>
References: <xmqq5y0bcjpw.fsf@gitster.g>
 <ZZWOtnP2IHNldcy6@nand.local>
 <xmqqa5pm9tnx.fsf@gitster.g>
 <20240113183544.GA3000857@szeder.dev>
 <ZaMJU6MJ5wZxyLeM@nand.local>
 <20240113234134.GE3000857@szeder.dev>
 <ZabpBHBB1TXIXJLr@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZabpBHBB1TXIXJLr@nand.local>

On Tue, Jan 16, 2024 at 03:37:24PM -0500, Taylor Blau wrote:
> Hi Gábor,
> 
> On Sun, Jan 14, 2024 at 12:41:34AM +0100, SZEDER Gábor wrote:
> > > In any case, here's the patch on top (with a lightly modified version of
> > > the test you wrote in <20230830200218.GA5147@szeder.dev>:
> >
> > I certainly hope that I'm just misunderstanding, and you don't
> > actually imply that this one test in its current form would qualify as
> > thorough testing... :)
> 
> I hear what you're saying, though I think that the interesting behavior
> that would be most likely to regress is the transition between different
> Bloom filter settings/hash-version across split commit-graph layers.
> 
> We have extensive tests on either "side" of this transition for both v1
> and v2 Bloom filters, so I'm not sure what we'd want to add there. Like
> I said, the transition is the primary (previously-)untested area of this
> code that I would want to ensure is covered to protect against
> regressions.
> 
> I think that the most recent round of this series accomplishes that
> goal.

It's great that we finally have test cases for different Bloom filter
settings in different commit-graph layers, including a test case that
merges those layers, but that test case doesn't check that the
resulting merged commit-graph file contains the right settings.  And
there is still no test case that merges layers with different Bloom
filter versions.
I think adding these would be the bare minimum...  and would need more
for due diligence.

