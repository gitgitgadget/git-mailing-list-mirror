Received: from mail-ed2-f16.google.com (mail-ed2-f16.google.com [74.125.228.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556E846F4AD
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 21:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372637; cv=pass; b=KNHB2Fj/dh9wLcdd//hrNaREmwC/WJlCNuRQjc32Evmb0wj4+0MyMeMqmZIkJ7fEq7SnnN8OzNqbCMOCZu0QuDRRid4ySV5I6bct4Vh1AS+9UgLi/1Nh7sLU7N83IRq2Y4YSijzNZs24VuATnBt0Nmww4RsRlrFGr6yoJ6MDoXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372637; c=relaxed/simple;
	bh=dN49aw/U46xrAPFiw5sPFil3eciV1YaapZfNaiRpjew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTl3JITg9Q5HLdxnTKgiXIeZwpwZdNJXzkGy5U1e1kk7lIjAWsEBjOgWN1UMOUo2q8EnHbRwRnGW0LRpaMCJKqJj8vsGlrlME23m8fai/UNJAW9ouWTaGjYCBTTrusb1DCo6KJJkeMmBhggQEP/9D9lHeqEVD9+hOqyJBd0CERI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJ2herH/; arc=pass smtp.client-ip=74.125.228.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJ2herH/"
Received: by mail-ed2-f16.google.com with SMTP id 4fb4d7f45d1cf-6a9984f9adcso2232325a12.0
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 14:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790372634; cv=none;
        d=google.com; s=arc-20260327;
        b=VGr73ujAmgg8xhgSEMy4udolXdgQNA/+JeRrJmtwczvxKJ706z1b4X/CC3QsmaY5KK
         ChwJBxPlRDDb68h69QaXURky6V7JOrRqi6Ecua5+WIcahej4Dzy93Q24sAQNFdXOmQXV
         5FUIGTtVopIkIFQq4IEloaHiwcxtYrr44Gg9ZctgQv+yKnf0J0Pe+SCjgMIUgokxsRU5
         fFlhyh+LT9CZjCQIjj1+rUPfJEjQPM5LXOfZF3bQMcjGzGcvAV9k88zbOBM2oGqfeiaN
         TRZTuhdMfsSugvkJRqNnq91fWKg2j9lcxWGcj5zcjDZGyfdO7HEFpyqYl/egDOuJRIeD
         szsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/vpBnfgNhQwzn8gWODLwrQ9fql1OR7G4Ojr8SiXKoEY=;
        fh=HKOPPDS6fGYZ17noZNKL2BHYmxKnHar7PSZ6/cwFjuo=;
        b=FxOfSIi2UcZHlJn1cJ3PI80ekF4kre9/Humi695bT/HRYZpaYF+yKFjU7oOM2JToH2
         H6ec0d/93R5e55XIihUntR/03QNDJ1JR3uoywEQm1mztVYMYZHEtNkVnJElnAl3tv0Ku
         G5qhYC0buklLaelz5nl0VKGaeUrjvf362qJxgSkLI0udsJ4xEhKV4bFQsmY5MqhWVGRu
         NNvx2OKjOfMUUp7Myfz+l8W96ODRWkQ45OmisycRWrmtqiNfHSKJ33aSQ5ArOvhMI/Xe
         OLKX8n+D8xL7CxhEYfbruoujsvJLTkUr0q5A4eRXjXd5kg6AgJ2NOkydDFGkM+R4L1pV
         1Zow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790372634; x=1790977434; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vpBnfgNhQwzn8gWODLwrQ9fql1OR7G4Ojr8SiXKoEY=;
        b=YJ2herH/O3tkyQmjlYoCCsqxqrFgXOX+EYIh1Qxzn+gBFWcy8lH3o50mkJNDGCDZfw
         V+/XewQOtJUelT1GZrcC+knEIm3tNnegqPHdwbIO+1GcuoSYuYDCGPDsr4K3CZYO3tGH
         ker+ZYXJ5p213kp7BfWaVOspVbu6kbI8heLDSEfcdGqcP7l3W8V7uqeIzT/fgAMYwLgX
         BP/UTf1ReyKWKq3Q+OQDc7uFV0a3nZ+Bkjvuyu5ZJJgcavkITgO18NG1fSXph0tubevc
         hYD137BUJXjGLVL1p6tzocMikTGk5o1ddyS3AE4H2k9pb5GOPjEAN3iUbtSYFw11X0qd
         K6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790372634; x=1790977434;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/vpBnfgNhQwzn8gWODLwrQ9fql1OR7G4Ojr8SiXKoEY=;
        b=e74zUsjmfas44wtlii9/yboO+WJfhObpy+FfG9C9IHN8/kcco9j9zYuTa+Gg586U6y
         mOQn3xLEd76+Bv5PfGs37VUes8wOn7bdXFay+r4GTqhZw6KeIMRLHKmuYL2Cr+Taj/9c
         L3sWbTkOZF+UAArEXXIHDbdFEzRkEnSt8KmtObRR/Y9PznlcIxdFI6igSCExFf9Ht5my
         ho0kipKx33/tY4DikkNHgkIoDEL2P5k8eO1VfYUJp81bu7cP9OXWYuNdZN+0cBjWKitP
         QgfRJjd8lImn43CXAXobEArw3jp+pOBa9yHazjyPN7FqSnyXHlPuYlHTQmQukik6l/HA
         jvRQ==
X-Forwarded-Encrypted: i=1; AKwUvBwrd0bW6ze7TAwQ3bSCbq2QhvnexP9+QLLskIbALbeO6SpBBj3PH7xq6KTzL0xDykQUyrs=@vger.kernel.org
X-Gm-Message-State: AFuF++nyjGFafldVbUOgyZk7g9DYfS2M63nQMooFKmeG90uYn+IJ8nun
	rSZRMV1fxYMGGHYFMmcr1y3+oKsoEKgDS0Q4CfSvJIkzGgq+hKSvLtf0OsTqpZuCiLTnG2wiTJO
	xjwnKS9X3PZPB5TiUqpPzUvgKWHkdZkE/8w==
X-Gm-Gg: AYBFou0oWSN7fxoOclEDTU2BwnH7/QLqR62XJ+XNEoDr1/C7NjNagNtGj8pFyC+S3fY
	YZAN8p4B0pm9aa2aVJmP0cyFob4hfj/Q9R6xsJWIHy9c/UrUanMrgh18cikJjEhP8bFPcbJbd6v
	L2zqAn7LyYj7Ue5DdLCrRm/5BsWlHt3RTwEfwFcIiQcUHQNa56bARUG6MmKQ18ptp3YXAEnrSdk
	bYZ7mzgp58OHT4pR1YuwOB1X2LqrXWDvqgL1ZinkEfTkUraHvtAhku4eSbmGpJgoVcXKTFiZSBB
	E42cEWfla1iG/evF+cPzxYj1w5IcaW9oHe/83hLJ+bBn8+iJvf17u3o=
X-Received: by 2002:a05:6402:23c5:b0:6aa:9799:e33f with SMTP id
 4fb4d7f45d1cf-6aac90f2da1mr6125260a12.43.1790372634329; Fri, 25 Sep 2026
 14:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com> <09549A0E-D5FF-465C-A933-F144A19D14E4@gmail.com>
In-Reply-To: <09549A0E-D5FF-465C-A933-F144A19D14E4@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 25 Sep 2026 23:43:15 +0200
X-Gm-Features: AclHuK948qz6Q96AQbPDrmmE05Oiowjfp-aWNZ5YuXyWLHDy33iOaJLPtQ4Wp8o
Message-ID: <CAHwyqnW83nMOcYUJrh8pHT+UT59Kh7kvWOg-j0UqTany2FBvqw@mail.gmail.com>
Subject: Re: [PATCH] ci: point leak-sanitizer failures at the actual test and error
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +github_escape_message_ () {
> > +    sed -e ':a' -e 'N' -e '$!ba' -e 's/%/%25/g' -e 's/\r/%0D/g' -e 's/\n/%0A/g'
> > +}
> > +
> > +find_test_case_line_ () {
> > +    grep -n -F -- "$1" "$TEST_DIRECTORY/$github_markup_script_name" |
> > +    head -n 1 | cut -d: -f1
> > +}
> > +
> > +github_annotation_ () {
> > +    echo >>$github_markup_output "::$1 file=$2,line=$3::$4"
> > +}
>
> Without commenting on the rest, introducing the helpers first might make the important patch easier to read.

Good point!


Harald
