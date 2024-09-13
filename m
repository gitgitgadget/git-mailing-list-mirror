Received: from silly.haxx.se (silly.haxx.se [159.253.31.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324001474C5
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 06:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.253.31.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726208473; cv=none; b=Kdjaw4+VrAoyIDQ3v1+5C+SRgLI4w17Du38fQx4JgbbJGzjNVJ+WmaeFuWEGh/Oqcx2+VsX1itma/ojnmOTUcLgGgTcbs9DBe1gPLyZIrh+3G4O+9bivXkpNjlfqbDiTsUUrfF7kly9tioTrDBt6xmo4LlkClB68qQNF8zVQ6AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726208473; c=relaxed/simple;
	bh=5hSMPV6JsTzmsrilMe0p19QUJNxYSWXn09rTMWO6Ljc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pQL6JaW0kXWlFzycUM26780YDloaavK2nTVq8RRAvHFV/YhGk3kBZng4XgRhwTyGrApRo2pcyLybSiWGhODascDCYnFkh6DIP0yNjC6gmuhw43gRBIJxeS3tHQ7h/6L3Ln6sTRAcLZZQPbzSfd192goKdqduLj/25NuVfZEEX8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haxx.se; spf=pass smtp.mailfrom=haxx.se; arc=none smtp.client-ip=159.253.31.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haxx.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haxx.se
Received: by silly.haxx.se (Postfix, from userid 1001)
	id BD07B6649D; Fri, 13 Sep 2024 08:11:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by silly.haxx.se (Postfix) with ESMTP id B99447E8E7;
	Fri, 13 Sep 2024 08:11:37 +0200 (CEST)
Date: Fri, 13 Sep 2024 08:11:37 +0200 (CEST)
From: Daniel Stenberg <daniel@haxx.se>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org
Subject: Re: curl 8.10.0 regression breaks uploads with HTTP/2 and
 http.postbuffer
In-Reply-To: <ZuPKvYP9ZZ2mhb4m@pks.im>
Message-ID: <q7soppq5-nsor-4qq9-801n-oq3461n3r889@unkk.fr>
References: <ZuPKvYP9ZZ2mhb4m@pks.im>
X-fromdanielhimself: yes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 13 Sep 2024, Patrick Steinhardt wrote:

> I noticed that GitLab's CI started to fail consistently with our 
> Alpine-based builds in t5559.30. After investigating a bit I couldn't notice 
> anything obvious on our side changing, so I checked whether Alpine itself 
> updated any packages. And indeed, it updated to curl 8.10 yesterday.

Can you clarify for us exactly what the test case does so that we can try to 
reproduce this?

We already fixed one 8.10.0 regression for HTTP/2 uploads with this PR:

   https://github.com/curl/curl/pull/14877

-- 

  / daniel.haxx.se
