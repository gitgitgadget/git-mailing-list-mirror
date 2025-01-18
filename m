Received: from rush.cubic.ch (rush.cubic.ch [176.9.78.115])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14B71F95E
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 21:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.78.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737235977; cv=none; b=mBBs83S9tHOl+E6xqSQIc/0ggLAJ+JYvCsYNkdey68c0NUxdH1BjQQK7XfnILxOvF2D0cu/qz33Or584yuvZzmP+N90cKnDegN5aNjO2wLi5VbBTmkCpDS1HZjZNcKTjHo0P7B+vJwmR8oj+SMFVD8qSuSvjMoVPwrwYjZw8+QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737235977; c=relaxed/simple;
	bh=FbaCXUjekGQWetCPA8pdgoIA5CU/ZrJiChQABcJxpKY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Up8RbVxOfdv58F3EmhuJzgxTxwESW47N7khmViMoQF3xw+svK404lTG2yoDeJgFhycQUxcmDmiz5xeFZbYbIJj/suL8G28UYODGaIQg0mmyzZ07gxSdC/DOjKQeNpmA1jGK3b3fdPSTcmnP2/yB0zTKglJ5JHDRPlsaCYMBLw08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decentral.ch; spf=pass smtp.mailfrom=decentral.ch; dkim=pass (2048-bit key) header.d=decentral.ch header.i=@decentral.ch header.b=o4PXssWu; arc=none smtp.client-ip=176.9.78.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decentral.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decentral.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=decentral.ch header.i=@decentral.ch header.b="o4PXssWu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=decentral.ch; s=rsa2;
	h=Content-Transfer-Encoding:Content-Type:Subject:From:To:MIME-Version:Date:Message-ID; bh=HNLSVAPJde1SOVmfbYKyDsBe8HxxoMFzGjaLtsGuRyE=;
	b=o4PXssWukvV/ST8kA3vLYf8cY/lhJU6ZSrrnUrGrTvKMbmYn9frnz/RrGIcAPrrbp0B9igOQiEbPq4S29I2++igI2/d0mf0yRyx0OMi06ITgfBSRV/5IeIPKTI6hzu/w9NYJ7DyrtNuioy7uhWYljrLFPZrciWL29DWM8ptm/Oy/eXXvD63QRSfdb4sQ4ahPLn5eu8x8yzSgtGN6J/1xtbKLAUtdaFmf4raZvZgpyMyr4gTqNez/YagpRR/T1Im49EIdj6xV/rN/vBGPVqZ1DTuqrxSYozQcfKGeQAyUt/qpuQ0EWd4V2cKzJzdZi8N3fA9LIuybi1HV0HTTeD+Sag==;
Received: from james.decentral.ch ([85.195.242.225] helo=[192.168.219.13])
	by rush.cubic.ch with esmtpa (Exim 4.76)
	(envelope-from <stuff@decentral.ch>)
	id 1tZFm3-0003YC-CC
	for git@vger.kernel.org; Sat, 18 Jan 2025 21:50:31 +0100
Message-ID: <db7ea8df-2f37-47b9-828b-67b8d3068232@decentral.ch>
Date: Sat, 18 Jan 2025 21:50:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Tim Tassonis <stuff@decentral.ch>
Subject: Erase a commit from a git repository
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all

Sorry if this is the wrong list, I have a question regarding a faulty 
commit that costs me quite a lot of diskspace.

I accidentally committed an pushed one gigabyte of firmware blobs into 
one of my git repositories, and noticed that too late, e.g. it was 
already on master and newer commits had occurred.

To my knowledge, there is no easy way to remove a commit out of an 
existing repository.

But I assume that there is a way around this: As one can easily migrate 
an svn repository to git with all history included, there surely is also 
a way to "migrate" a git repository to another git repository in the 
same way and then just leave that commit out.

As this sounds like quite a lot of manual work, I wondered if there is 
an automated process for this?

Bye
Tim


