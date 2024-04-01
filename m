Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de [80.237.132.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014922030A
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.132.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711970505; cv=none; b=PFhwMxSPTNbm4JO2DorBjqA+/6UuNk4EVizmCdE1Qe/OGOs0SWX/wmX9AVDYvZoHWeB4h8vy2bQeZ221F26hIrX2KmBFxHWCIA6xC22z+3dpiGaUVf/JAyNcEacOA/hUVhkjWncG5ANnsT4cqwtNqN5w/zMyJ7z8eZ/5kiIjB0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711970505; c=relaxed/simple;
	bh=jOi9LohpcVPH1QmvcSe8N7d4hXx9mSZmD8ctUWRM++w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IYBg3u41UXvxz4/vK+Mtg4QI/O08NSPwnHRnyNZgH/PMe2IFSANLCKg8zCDo2o4Rri3o8uZklXmql3zIUu8ZbaOeghrlHKQfjUGOB9wXPOLGVyjlDczC/rCiXn9HD/+TERjZXBukuwUCed3uOKfh9N+b0Bjh+C6cRy6hhNWb+1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=virtuell-zuhause.de; spf=pass smtp.mailfrom=virtuell-zuhause.de; dkim=pass (2048-bit key) header.d=virtuell-zuhause.de header.i=@virtuell-zuhause.de header.b=Itmf4ZhH; arc=none smtp.client-ip=80.237.132.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=virtuell-zuhause.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuell-zuhause.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuell-zuhause.de header.i=@virtuell-zuhause.de header.b="Itmf4ZhH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuell-zuhause.de; s=he130322; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=BFBUetY3TE43lGQybCQ2aHe0dLQXh3wsJCNBD6xOKfs=; t=1711970503;
	x=1712402503; b=Itmf4ZhHovhg3NdG89KQ8abPVLPTSglfunIXq9Q/Fe7IrF7FZLmyL0vBKPuP5
	HMxzLBQzRDpKKBkuE/3Y0Z5rRikbG9KgyJdA9CPv59YOnMOkSWrewvjnEgWBebPmPQRI3QMuPOxUo
	4v11m1a5Fycf83bU9mpqmjCKpuUlOAizUJMCQhoq/0BYDt59mN4kUuydMVVXgMaZaSU1vRPYQu7p2
	O69GMoDAH94U+OzPR511CQpI5+54zz592gGCZM/76iw8tbyrBc41EYox8204Nd4KVoS9IZBS7b6s5
	kk6YExV7udyJRPKv57GpXLiP3KkZzjUFuzcfkmpqnZiMFrO4ew==;
Received: from [2003:a:77f:9249:1989:89c9:57e0:e298]; authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rrFPY-0002gu-Gm; Mon, 01 Apr 2024 13:01:08 +0200
Message-ID: <17b55da7-42d0-48df-95a6-8433e1c028b0@virtuell-zuhause.de>
Date: Mon, 1 Apr 2024 13:00:59 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Feature request: a merge strategy that makes any file difference
 a merge conflict
To: Michael Ernst <mernst@cs.washington.edu>, git@vger.kernel.org
References: <CAAJCdQQB3_DWOTCTbb-TAkLUX_XVd5TBd3z0M2_KrHxKxr69Kw@mail.gmail.com>
Content-Language: en-US
From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
In-Reply-To: <CAAJCdQQB3_DWOTCTbb-TAkLUX_XVd5TBd3z0M2_KrHxKxr69Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1711970503;31551359;
X-HE-SMSGID: 1rrFPY-0002gu-Gm

On 29.03.2024 20:20, Michael Ernst wrote:

[...]

> What do you think of this feature request?

I wanted to propose to mark the relevant files as binary as that should 
prevent the merge to happen. But this is not working.

git init

echo "*.txt binary" > .gitattributes
git add .gitattributes
git commit -m ".gitattributes: Add it" .gitattributes

echo "a" > test.txt
git add test.txt
git commit -m "test.txt: main" test.txt

git checkout -b feature
echo "ab" > test.txt
git commit -m "test.txt: feature" test.txt

git checkout main
git merge --no-ff --stat --no-edit  feature

Merge made by the 'ort' strategy.
  test.txt | Bin 22 -> 3 bytes
  1 file changed, 0 insertions(+), 0 deletions(-)

git log -p test.txt
commit ec7cab2fa30c26738c6254202a399a616959a661 (feature)
Author: Thomas Braun <thomas.braun@byte-physics.de>
Date:   Mon Apr 1 12:56:07 2024 +0200

     test.txt: feature

diff --git a/test.txt b/test.txt
index 346a56a..81bf396 100644
Binary files a/test.txt and b/test.txt differ

commit 61e195554351dada7494e4eb4935d96120680420
Author: Thomas Braun <thomas.braun@byte-physics.de>
Date:   Mon Apr 1 12:50:29 2024 +0200

     test.txt: main

diff --git a/test.txt b/test.txt
new file mode 100644
index 0000000..346a56a
Binary files /dev/null and b/test.txt differ

I would have expected to see a merge conflict as git can't know how to 
merge binaries. Or am I misunderstanding something here?
