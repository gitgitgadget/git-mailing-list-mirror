Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B8E33CEA5
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787092500; cv=none; b=Byzjxonp42hI5e9yijjzPHSUMkSiniyZI9AYgjdjme/SxuGit87xjMvcSUxQbSqp5c7SW2Xb/dmsIRM2cTPC/gkWXzmMle0hnkltCHArj/4pQtXa7fZ0PVSDO+d8KrLIxagJ+Cg/UI70RBEFtPM9/jDc+498veAkrv6iXnzQNP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787092500; c=relaxed/simple;
	bh=cZbNb53gresesCVVT6rFG4cnKzqLZCqWnQQ9qb3lTlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5G2gotqboDY5vO54N2g3HlvNf8Uv4l0ioYzuxsOfHcDLkKTaVbPxFV0kTIk86G26ol9cnB0GiJ+9WgAEqyce43aYgJ76Zw4D+61UIiiOfmuQ6bpeXAdeSl+g/tVOat1CU6MUwBKwYUqc2UfPxZ6Q9AnRabaBF/Ob5CjaucNwwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbIfZTPK; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbIfZTPK"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4ab89cff9c7so206931b6e.2
        for <git@vger.kernel.org>; Tue, 18 Aug 2026 15:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787092497; x=1787697297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iA8TLepAK6i0XxdhbY07cnR6BJ1uIps2kzvB05RL3Ns=;
        b=AbIfZTPKmDH0FzcJcb4eHuYwWfAWB4wUBWdioYFQN9TrYdRdP6ZSP4IWckSa7Q2MP7
         wK2WwlI1oqQ08iDmKxj+8+0FD2q9FVeEfG/eXOlRB4WgiBS6Jd5WBKPxhrmXliJwDWPb
         eGJkREnC5FBMAugntRYGwH72KtSpD9RrrX3vo+OEWfwSH1IZW2VW8w3FT3kTx5ROMIHJ
         PUYWcUdELabshiMsqyg5mMcKncNOjiUd4b8NMFGR6ITYGiYZbKOqfQ/4gohY/jSPgomS
         JRSsZBE6PQ1wlRbf6BI063izZE7TlzyvwR3eyfAnDAPTNJeSpo/HO1zLvCVeqOfTtaAT
         0ZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787092497; x=1787697297;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iA8TLepAK6i0XxdhbY07cnR6BJ1uIps2kzvB05RL3Ns=;
        b=SvFqdFyS4lP72A29RT3LxWpJxzc/Fq6PWhFCox43zSxx7YWs8nS56LUWuQnK3B2O/3
         kE9N3Ac/Z5023VMus3qJzIs2tIXSutBt0ih4SzB9bB4mWslRWvx0hqU5XnZiNDEYoFyp
         CVvE1FO9lP4QkjSfSvAOW46fUVL1fmy7dwB9av48VGwUAtkzl3T/vJwTUHl7t4Q3J31o
         FzNEPsNhGUlIuDftai/pzK8oLdElu1Zl9v4fE67YjarAR6nbKoYxFwcRzWbQqRlcRNSs
         fhD1eETjyQvVGmU3/9uz3v4YplBiBb3xAmaSXpWOC5INjag1+lPvnkcBzgRjphx2N9Ol
         52kA==
X-Gm-Message-State: AOJu0Yyfx+Ps8HlSB+D2HA/tjK/REu4yov9cBuuITAYKuOTwnLTbPCzS
	6udDxb5TJTbZHR8oobLtKOcO6buqWMyPPOD5b0khZwrOMg6hHNAfwYHsyXPZxg==
X-Gm-Gg: AR+sD13h16GSaPUBUfhr7mu/8vB78/RDoOf7W5wu0K9BHJDSA53svWiJ+i+XG66PfaI
	/7qBkUdY3MqiKOZlddegAY5GAnMvEyV7G0qg2pLt6JMr3NBtHJ8nJ/gC5CYc2FztZDTrY87s8E2
	XY4R7u5EdpGibBZYytfMAWTXeQbN2RDZES8btLL/PbMmoigdzTrR5Ugw6v+p1xL3U0fxxqxU/K5
	MPCvkleuAfc5TCGXzuRtEf51MU7o4YI329bClquGhXPrJ3lP9DHeIblEvejWrA8dL5jJPsoYbXf
	0HU69726nDWoWhQq9NGRn6cZBx+N6VoGHQiHarW6Zfg5480uY1JhtqBqv3i3pJHS08nmtiNW1N2
	7BFXWKPpqP3u8+E5wgGpB2cfotc/ytq1gCZainaBn6y+NV3hCzyb1/d8Js68HSOu/n9/fO2esWL
	ryLBBXSFvYsUl7kIGGWaRYh+6upOW+v1sIZkQ1MJvqyvWp7vvTHpdb7g==
X-Received: by 2002:a05:6808:13c1:b0:496:301:36b9 with SMTP id 5614622812f47-4b2bc469cdamr56788b6e.0.1787092497458;
        Tue, 18 Aug 2026 15:34:57 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b29604341esm4447730b6e.10.2026.08.18.15.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 15:34:56 -0700 (PDT)
Date: Tue, 18 Aug 2026 17:34:54 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>
Subject: Re: [PATCH] odb/files: be less aggressive with geometric repacking
Message-ID: <aoTcxJSmKWNhnjZ9@denethor>
References: <20260811-pks-geometric-maintenance-reduce-frequency-v1-1-7a54c42355ac@pks.im>
 <anuFzZluJEU21MB0@denethor>
 <anwIRuuaYG3AgG1m@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anwIRuuaYG3AgG1m@pks.im>

On 26/08/12 07:44AM, Patrick Steinhardt wrote:
> On Tue, Aug 11, 2026 at 03:44:12PM -0500, Justin Tobler wrote:
> > On 26/08/11 11:04AM, Patrick Steinhardt wrote:
> > > When performing auto-maintenance with geometric repacking we have two
> > > conditions that may trigger a repack:
> > > 
> > >   - Either the geometric sequence of packfiles is invalidated.
> > > 
> > >   - Or we have too many loose objects.
> > > 
> > > The first condition shouldn't trigger all that often: it may be hit when
> > > we fetch a new packfile, but users tend to not do that all the time. The
> > > second condition is what typically triggers more regularly though, as
> > > every command that ends up writing new objects may cause us to cross the
> > > threshold of loose objects. It is thus preferable to not be too
> > > aggressive here, as otherwise we may end up repacking objects quite
> > > often.
> > > 
> > > For the geometric-repacking strategy though we have a default of 100
> > > objects, only. As we're approximating the count of objects by only
> > > reading the "objects/17/" shared, we'd only need 2 objects in there
> > > before we perform a repack by default, which is quite aggressive.
> > > git-gc(1) on the other hand has a default of 6700, so it is quite a bit
> > > more conservative here.
> > 
> > Ok IIUC, the reason two loose objects can potentially trigger repacking
> > is because the heuristic used to estimate the number of loose objects
> > only counts objects in "objects/17/" and multiples it by 256 (the
> > maximum number of directories that are fanned-out). That makes sense and
> > indeed seems like it could lead to repacking processes be spawned more
> > frequently than desired.
> > 
> > My first thought is whether the heuristic itself should be updated to
> > capture a more accurate estimate for the number of objects. That would
> > of course require looking up more objects and thus be more expensive. If
> > the goal here is just for a very rough estimate anyways, maybe it
> > wouldn't be worth it though.
> 
> That wouldn't really solve the problem though. The problem is not really
> that the estimation can be wrong, it's rather that even if it was always
> correct we're still being too aggressive with packing the loose objects.
> Because ultimately, a 100 objects is a comparatively small threshold,
> and leads to 67 times more repacking compared to git-gc(1).

Ok, that makes sense.

> > Increasing the loose object threshold here to be more conservative seems
> > like a reasonable approach. I'm not sure exactly why 6700 was chosen
> > here. 6700 / 256 ~= 26.2 which means "objects/17/" would have to contain
> > at least 27 objects before repacking is triggered. That is certainly
> > much more conservative. I see that 6700 has also been chosen else where
> > in the codebase as the threshold too. It might be nice to explain the
> > reasoning a bit more in the commit message though.
> 
> Hmm, don't I already do that? In the paragraph you're responding to I'm
> saying that git-gc(1) already had that default forever, so I'm adjusting
> our heuristic to match that.

I think I was just curious as to why 6700 was the chosen number for
git-gc(1) as well, but its probably just good to be consistent here. I
think this patch is fine as is.

-Justin
