Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1184418D4
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921366; cv=none; b=p2rAIBaVvJATPTQ4lDIqN2NWgcReX1fvMnXd8xotePEvOo3Oz55r1cOBDFu5vBFR3Dz3Imdt/3tYlmjA3nCnMlJaHP3PJBT94abSfLUp5xL8OuVLTvD31rAo3LpZXer0Oe8f2Q3CvQSJr0qIPdsIIld6wzBSpL1SqRHJ+JVqNMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921366; c=relaxed/simple;
	bh=pTHV2xxF0UUezZGvD+FvoDcaADIMj0sgZbmj+03MS4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOM/uNo0C6pEzP9tYzZ4cnZiuW1ihMEXlU1F0sSrBXf6FksfsyEv1zjYVjrLZBanbhPJ6n+YaIBZiKmoF0babpli+aLTfJU61+zqkIRBMtLpuIrvynSAn8Cs3q3Ib8iL79g+TBe3hYfGwtfPLayu7Z6JcNe9gu12oSEFTlQubDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+u+8Chm; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+u+8Chm"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47ee301a06aso51657305e9.0
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 07:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768921363; x=1769526163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IsWta0m+gzA2NLHBlWdAS2J/e9mfWv9qCW77x7ye6iY=;
        b=V+u+8ChmmddUvQ2C6+NSMwXVhG57jtpI9Y1xD7FrMON0LoUZk1gRnv3cTgB4cQezeb
         yQUfmGbXEtLWe8ksbM3syeBCLJi9i3P0OkW470e3DUox5Jin4++DovZ9weJmCGuZTpeu
         J9RPcq3BxmYLB685KEiszJdk87ioI2ABpGyIonJ1Jc++Lp72ub7GV5VCQkUXp5imna7l
         uAQTEqH5hjaGqJhPmSY3rBsBPjh1t9175u2y78WffzKfZsIy+3wUablnmKfNf77YC6ps
         FTIxOhAX0kfp0vg6VsQk/SFjTD0EvikgTLPADiCASMa+Dtms+eEynPDoIfsyYyTtPERH
         kgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768921363; x=1769526163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsWta0m+gzA2NLHBlWdAS2J/e9mfWv9qCW77x7ye6iY=;
        b=rtLfBczNE/LoagDkbZS9Jc3Ei0hVPm497zOLUmBdoWgP57Yc6fn7mPK92VJD+OJqUz
         bQokfRDR9jvsOdx8o+p8f4pUOC9MMe1zb38MF9OlDlJRYJqApnh67hzkyLmYJGxinj7P
         siUtrNOs7mCSaH1Kab7zUTc64Dz09LfZPVYS6oq3fmV+0FVO3E3T3MpnGe3vAuyKBfo5
         j+zOsFTF+/rrWGx0dsNfqovBOkZZrrFL2TkAsmrJx3AtBCDTon5uPflRVpU+vdH61RHS
         ELK0w1reLxuBKF5ItS8pt21pUnqah5AyGyKT6zRpulRw5wmYMz9mStRtJU4kvVOex4Cq
         rumw==
X-Forwarded-Encrypted: i=1; AJvYcCU1YVXP4e7qCO+yoBXXDTzMI43MUAne5lqlgfA9wKBRIW+cpBLQ2PCDlOrM+XKola5sIGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwAKwvgIuCDPe79CqHbXJLbSyFm0dy8+570jvhYjHg7NAmS8LU
	1fiMSmXZxai8eAxfumMQ1MSMO7VxPhXshvbe/YC/2JXMpx6pmqUyJMsbaFWc+zOd
X-Gm-Gg: AY/fxX6mPUoPPk4dqJ711jHlxct564MHJjw9KSaWTpb+bjaf1Vtw7VsOU4t8jV4MLWZ
	pQSGn4f4UdjB3D8zui1WtUTocsUzbU+xY8Wo22OOYlw57FlJd1d7njZp+7LYUcPHsH0UUhv5Q2h
	bmRO/6uQA2HUfenb5AJRO522hKOmbTaPZ5Saz/OBtu2zvVcr+EV7i7wPVJPIdx85Ea78TR1riJ/
	ZUvMYK7GwJNSs/GPcmlTYBYZdgBqd4LzfCIJzJjbbQemr96rvzMTnlo6Ce386ZONLDn+Jnp2N7W
	flIF1vIhALl1DQ/7fwZKVRKypchpjnYPdP6GwNWl+qU4Wq4w+bjdUpUNN5P8Jt+9/fFpU1EUbcf
	hGCXSmiyFwuG4xBO5fAixwvCaCBJCMdAiIIFjlp4zxvzMjmzhFJ6sV2EZpihrg12G/D3SREr83t
	fxcb3CaTRrmKelmkmFTktfg6+q5SpKKh35EEV9HN3CmZjDFd62a8u85A07zLtDDKwF9Q==
X-Received: by 2002:a05:600c:37c8:b0:47e:e87f:4bba with SMTP id 5b1f17b1804b1-4801eb0e1cfmr176324555e9.29.1768921362706;
        Tue, 20 Jan 2026 07:02:42 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921facsm28586755f8f.5.2026.01.20.07.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 07:02:41 -0800 (PST)
Message-ID: <f17adb7a-8776-42b3-b753-f6306145250a@gmail.com>
Date: Tue, 20 Jan 2026 15:02:40 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 04/10] xdiff: let patience and histogram benefit from
 xdl_trim_ends()
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <70040ea1351451243be90d59d26cf1a403f3000a.1767379944.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <70040ea1351451243be90d59d26cf1a403f3000a.1767379944.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/01/2026 18:52, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> The patience diff is set up the exact same way as histogram, see
> xdl_do_historgram_diff() in xhistogram.c. xdl_optimize_ctxs() is
> redundant now, delete it.

Does this change the output? The patience diff looks for unique context 
lines and builds the context out from those. For files that look like

Old	New
A	A
B	B
C	A
B	B
A	C
	B
	A

That will give a hunk

@@ -1,3 +0,5 @@
+A
+B
  A
  B
  C

but trimming the common prefix first would give

@@ -1,5 +1,7
  A
  B
+A
+B
  C
  B
  A

Though it seems like the diff silder causes us to output the same diff 
in both cases for that simple test so maybe it is not an issue. It would 
certainly be helpful to comment on any possible changes in the commit 
message as it could have been a deliberate choice not to trim the ends 
for those algorithms.

> -static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
> -
> -	if (xdl_trim_ends(xdf1, xdf2) < 0 ||
> -	    xdl_cleanup_records(cf, xdf1, xdf2) < 0) {
> -
> -		return -1;
> -	}
> -
> -	return 0;
> -}
> -
>   int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>   		    xdfenv_t *xe) {
>   	xdlclassifier_t cf;
> @@ -404,9 +393,10 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>   		xdl_classify_record(2, &cf, rec);
>   	}
>   
> +	xdl_trim_ends(&xe->xdf1, &xe->xdf2);

It would be clear that this was safe if you changed the function 
signature to return void as the way it is called in xdl_optimize_ctxs() 
makes it look like it can return an error.

Thanks

Phillip

>   	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
>   	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
> -	    xdl_optimize_ctxs(&cf, &xe->xdf1, &xe->xdf2) < 0) {
> +	    xdl_cleanup_records(&cf, &xe->xdf1, &xe->xdf2) < 0) {
>   
>   		xdl_free_ctx(&xe->xdf2);
>   		xdl_free_ctx(&xe->xdf1);

