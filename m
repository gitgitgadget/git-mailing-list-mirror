Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED68421D2DC
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191683; cv=none; b=aJsZYEgTuZvhXsAfzU4daIh2GADApe0F66YGOlX/1OmR8ADupR4YmGk4JO6/v/VkMqAmlH6rBJZ97C3mejnXOsvkMdK06SVUFtJEq4XXJ5dzgb+ErrrOgnd38qquQ/L25gvaNR2t9NFrk/TpXrZWOy55GxlhswowSoaBvipT/QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191683; c=relaxed/simple;
	bh=BuApIY/IBqTXXMJWZ+QgpZav/Td2Ishuglmvc2HsbhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcUW2AWfcxkXIH+nuBaWz6P0KdDARiD5H9NTEAqOc8X4X6DL62TfMrB/RdmVSrLkpxPKRn3uiOcvTpl7F5iUXFxJbeRqEPYR0sSyJ8CgwowK+1IpTtrY3l+U/NkGdFHrjGiQI/+PCMQplUH48LDqqBq6xZo/nsvDMAJKDrA/C9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=iVa9gI+d; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="iVa9gI+d"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e3881042dcso12515837b3.0
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 12:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729191681; x=1729796481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Irn0P7X54kU2o8F5EadlexeZZzHv6/unicHdTchtcFM=;
        b=iVa9gI+dv4BLj4blV1JeNEZOIiFol0ZUKLDW0ABeddcieJkDsEKPId/J+ilfKQkmcL
         0v9DaoU42qaqyMOsFfYMnfyOjL9sYHukzxzTxnj1QxatwNlt8wd1Tlovef+wBXUe3ZiW
         QeSjb/DgVigvw1hMhyA0NKTo09HgVKSXom9c5bge8H7q/tKiyrylsf9lBbdnSAEy/Fir
         KSuiQjzzBGbg5gAApqwLsMc1y+oUYWw9v/xY9HKKV3CABH/j3H7IAPyjYDkTgiJNZbs5
         N4DJrb5wSHQFW4/eaNNkFCZxxJWU4cPkUWMsTcoG2NKTesfSoaTInELIn/mq73r6sOjU
         wCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729191681; x=1729796481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Irn0P7X54kU2o8F5EadlexeZZzHv6/unicHdTchtcFM=;
        b=pTr9EvpYbvjhAvAbi7JnpppPpIaHGUNdKJ0pGH73nHIO/8QA8VQFf0aUGeGCRvlQQ9
         5TNVuurDWWO4pStEtXimn0p0nI9Gq64EgOQA+Deo57pS5Qm2hXfZpfPVKyBykn4yRldG
         B/wS5zdN/xNkejEK4Ya46Zpl+YMOPW7G6johOAKqmIBA2Udw8/S/H0bKGyAgEeQ8r80J
         xhH21qyl0rTvCrYmnwq+xjiXfCuHcAzrhk+ce//ja2aLwQ3db9F7Ky97WEz3J0QUnLRB
         1AUWcJK8GxS/xvco2UEzizGUCGja1i5HVHhcvygFUTH3lICObdUQg74Wg2bhbgFm6x86
         Gfgg==
X-Gm-Message-State: AOJu0YwiIBo/nBkOGdNp3cB/siUSPu2Y4OF9+Z8pqZOlLOM9LNZMmawg
	X1XVjkUloG3dN+kqZDkkqsPd5264BsACeVLJLn965NdPEX8Xp3eNgyDvkx7Ivs4G6FG/+5U2kWj
	E
X-Google-Smtp-Source: AGHT+IG95iqy4Xu30X1c1teBP9Apz8BOJJCodJY4ODtvvfKabzCcxUq6elA4nttgfLL6ZSuZiQf2mg==
X-Received: by 2002:a05:690c:87:b0:6e2:1336:55dd with SMTP id 00721157ae682-6e3644f5c25mr154710087b3.46.1729191680652;
        Thu, 17 Oct 2024 12:01:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5cbdf9esm12479327b3.79.2024.10.17.12.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:01:20 -0700 (PDT)
Date: Thu, 17 Oct 2024 15:01:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Why is pushing to stash not allowed without an initial commit?
Message-ID: <ZxFe/cEI0SzFMSi0@nand.local>
References: <bab5a7a9-f006-4a1f-ae38-2dec817c5a82@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bab5a7a9-f006-4a1f-ae38-2dec817c5a82@gmail.com>

On Thu, Oct 17, 2024 at 08:51:29PM +0530, Abhijeet Sonar wrote:
> I see that the stash commit has two parents: the initial commit and the
> commit that actually holds the files that were stashed.
>
> If git were to allow a stash entry with no initial commit, it would have to
> create a stash commit with only one parent (i.e. the commit labeled with
> 'index on <branch>'). I wonder if there is a reason this would be bad and
> therefore not allowed?

Right, each stash entry has two parents:

  - The first parent is the state of HEAD in your repository when you
    created the stash entry,

  - The second parent is the state of the index at the same point

So there would be no reasonable value to substitute in for the first
parent in the case where your repository does not yet have any commits.

As a concept, stashing without any commits in your repository doesn't
seem fundamentally flawed, but it would make interpreting other stash
entries substantially more awkward. The current model ensures that if
you look at any stash entry S, then S^1 is the state of HEAD when S was
created, and S^2 is likewise the state of the index.

That changes if you don't have a commit to store in S^1, since now the
interpretation of S^1 depends on how many parents S has to begin with.

Thanks,
Taylor
