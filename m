Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE5F318EDF
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800196; cv=none; b=JQfDTy52lA+EB6ZksuBgO4653c5iqA0BEnMI1UZ8yA8a5W1we/g/EWpjxJtGDKKxJEeqXBtVmfM2HtEu+1PK+xabbVDEPPh3GliiyINBa8IZLRDeyTXKqtTVAf4asGzfla7GKPTCteAX6g4X+GXbLBUn5Ox9eXcrudqHLpZhv1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800196; c=relaxed/simple;
	bh=L+Fkr05aNJLCYulaHc1KByoVhiGqPo00DQuUhM/vS0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNMlrtxUWuYqyjSHjz/c41/AhhoymdIq10T6MaGSGnSe5sj7lPKoe3A6RPK+wr3resYuSoIJYNbmF5QI2ZCYHtSrwPFN1Vi5iF16Lx4IV4nGR1ki92fmJmZPct1UXqKHzVyVAUCxFhuzgqpMj5xeZ1iDfzLlJoZRuMvZ3i2Cbwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5B0X96x; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5B0X96x"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59b672f8ec4so3432363e87.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 04:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772800193; x=1773404993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7t4w/zruDW8a68XscTC42w2HCOEf7jJAXJos2MgJ448=;
        b=L5B0X96xVdxWlhoPGJZyWLet/yrdLWrU4mOHGM6eUfFHoIleoTNeMGX9rhsLoI8xmj
         4cWyFW4PRNvGflCSMlbHYfgGopXltdESYiYpJeMoUyqLCfSDv1V/IR5FjswXTnR1eQiq
         Kwcj9KGly/VKX/Feb7Ms0D8fAaYW07M329qBDBAfsySN2T3U+ITsTx0pKg1KUrxdZ9Jx
         IVj3iFQA4jInszEpef2WBsmFd1rpWbZk9GF5C4Jx+PMt08Tu366xsiUp6aSkrCJ2SOlZ
         Xn9iYTEFmg/qwHPKpeMxmoCrRcuYdHJnQWTja4H49ywjSPZlJ53EbbNTJJX7Aoy8t2Zw
         DY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772800193; x=1773404993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7t4w/zruDW8a68XscTC42w2HCOEf7jJAXJos2MgJ448=;
        b=hH7Rxi5rGIddQFFgTNX7CoHug/XkFDb6qQlCOFukIERti1zlKhvQTf67kykbwf/tpV
         idvwtx5rBrS+Akqb3FfoAx1X7EkLMQ6htgs6nQXdrZnXOSiYuVZ98YnweEWaE9qticxV
         /Wz0jNZFNSMsDioE+mbMO+Kncit7q7DpOqPnz/JJvPZrCo1DPsHgQ4gr9tyA3UE//+nX
         xnLxx4K+n66Q2V4k7xOZhwOqp2h7YAvr/TCRrMhhw+gd5hsTpN9lAB83Ejk6eMQG6no8
         c1IAlIeLv86YoQEuo5ZWf8QvNR17PL8Q5uZX4bLQEScCbj+6rK61y+xt8ZI95kx4Dqor
         460g==
X-Forwarded-Encrypted: i=1; AJvYcCWsLJuNR/9kl9tR5pxOkoGYk09GIhkshxaMB3o6zEg32kYEMl2W82RR5ETWyRF2pxCUsks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoYxnkaJ3LfzcD4BufuMMw43HckqUbCHL8p67QCV3uE4RniPHf
	64r5VxWunAIDTNuyeNxm23T6DtTv05LheDStU8Av4cI0jJzIyfpKddHa
X-Gm-Gg: ATEYQzwJAtv1O0b4EWM4/LzETWE+8GhyRQcEKNU82ajTXltRGB4u+7Lbz6fbsGg0h8N
	jvkbTRxCmk8q0Vo4DrOTYERlWfHvcddPKIPnHfusyslTR5q0O/IMY6Ql4yo4GnIhEsSbF4Kntbc
	pnn3zoCc22gVH+vMcTPjWJp/VOoDAqahF+U1B5nIkMMdgYfdvu4Q6++dNhRTxzqsnYgcWJixYVf
	gmq6d2KDfido1IZe1Q3UJOHZP8dwXPyP2ur06+cRHLndh81waOJd1IofudAWIA+k73fxbfZL02O
	z06hYecdPpzH5s3OGrl4ZUIM0EGXfAnsWkgb+vgWQ6o+yflRNmPVGzmdacSF/NzMKxT1ouVQajP
	oDFZCAo0vtg5GwgxFWWDqyrPGYIhLE+acU4FDPuPCkLAHdQ5rD9qRaCzMrp7ozgK2wuU0lSy11z
	o6utv8f36/J4wTj+vkpWR3zcv9iS3geqlZ1AyFaU+0rOpfMEGrjQUDbi7+6eBiNN4B+vTeB16VF
	KpOIpLIVzShJ/CUBEGW7q9xuFFESaqO
X-Received: by 2002:a05:6512:1295:b0:59e:62d0:2ad3 with SMTP id 2adb3069b0e04-5a13cd1314amr739833e87.43.1772800192763;
        Fri, 06 Mar 2026 04:29:52 -0800 (PST)
Received: from localhost ([2001:2043:be0a:d700:f4f7:caf2:a9bc:c43e])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d01cbfasm317526e87.14.2026.03.06.04.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:29:52 -0800 (PST)
Date: Fri, 6 Mar 2026 13:29:50 +0100
From: erik88 <erik88@gmail.com>
To: Mirko Faina <mroik@delayed.space>
Cc: Aron Sigfridsson <aron.sigfridsson@gmail.com>, git@vger.kernel.org
Subject: Re: Git reference git stash
Message-ID: <aarHnK-oPHlx_hCw@Eriks-MacBook-Pro.local>
References: <CAB0c_PjtTs8dWJCoUnQfCUM_YOaK3e3FcZfCgWjTOLcNWj-6nA@mail.gmail.com>
 <aao1hFwJYpJymY3o@exploit>
 <aao7uLxQ0ir0m6s2@exploit>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aao7uLxQ0ir0m6s2@exploit>

On 26/03/06 03:31AM, Mirko Faina wrote:
> 
> Looking at the docs for other commands that use pathspec, it doesn't
> look like any of them explicitly say if it's toplevel or relative
> neither. I suppose the author thought it was obvious which one it was,
> besides, it can be easily checked just by trying out the command.
> 

Pretty sure git stash push is the only one which does pathspec

    git stash -h
    usage: git stash list [<log-options>]
       ...
       or: git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]
                     [-u | --include-untracked] [-a | --all] [(-m | --m
                     [--pathspec-from-file=<file> [--pathspec-file-nul]
                     [--] [<pathspec>...]]

and pretty sure it's relative.

Sadly, git stash list does not allow a pathspec, despite the
[<log-options>]. But if you want you can do

    git log stash [<log-options>] [--] [<pathspec>]

instead, which is handy sometimes.
