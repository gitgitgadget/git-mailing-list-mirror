Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC7317C219
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734528638; cv=none; b=RMOYaTomJIcm1W9W6XqQpEKipND/MOroq/s75F7YDj2CZYr29KolCo3PfIDIL11B2Li5OPPwMKsvovPOhWzXzQU90hy0Zu7VoujxIdiTyfpPJUBorJ1TTzlItaE+GAIjmev7cLoO/VixB6dRt0OJHD29yQa0iJjllgOo7n56tV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734528638; c=relaxed/simple;
	bh=tXUJ7G8CzM2/zrOALOomxlySREIeU6ajfMSM1VR3xDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNOOM5+4W1PR+Du0rva/VkfDaaGPyZ14h4zbxuB/XHbM1xY6FYz8IiUm2+oVdkmu7ZI3EL7CLohJJ1E9GpbOU8h8mOM0HwhJtIBrM7Y4fIv6ZWxw90/F8goUN/9w5KFopALAF562GU0OVpc+LDXCgiWemaiCWuvc5MSlzG1MFJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAvYZbRb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAvYZbRb"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21683192bf9so61920085ad.3
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 05:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734528636; x=1735133436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nyb6Yq1T+PYWu2Kc0paHM7wB8XSMSXLIWVAP52a6oKk=;
        b=dAvYZbRb/bNcOmKQ90IgZLMroDXXNhAIWc9YgUPtVwTlgJGEqmR3Tvleiz/wKV/gt5
         hw7PtAtkKNbVNhrgVrQjo4/mAgaU4nnUlOMJrVx0/hEyPV2hg2gjAobpteamLRUObEQa
         lsy+7LzD5jQXHbqmKeeqaFd7gcZYardJzNMJWLDPunk/OdMYRRTncsom25tOXbqIscEp
         mzxv9u6kl8OCi3K2/fimoemzW/hgSTvFU/QttPZFLnr+AbM5mdhF0DAn7+QLbOAYL0ao
         /4CniZt2TaBLUKcr8ip+lElRgl2gAymKg9RdELWan0zJQaXdO6uvMtiDvO7cCnAzvavz
         J+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734528636; x=1735133436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyb6Yq1T+PYWu2Kc0paHM7wB8XSMSXLIWVAP52a6oKk=;
        b=Lzt8CrUDJgI5rPdFq1PgePxg7JeVxZlymO7LwLFR59QO+zy2Yna6Y6wIDJwqJ6lSpQ
         /vuG9aOkqj8Yn2V5rStmoyoY/l4srWu7+EpigSgRwhq2NYWCrCR6sKiE9P23rKUCTPv1
         XRRAdV5eUdcDu9PquhzUZEck3JnXDGNFVjqp3LkNCdJtN8bn4FZrqoPpMlRqB7y59zga
         zwEqi3ilvbGrUAALPOpiNvx+a46VLsXMCRbDCqVgUV+Lqlvj9c+QQHVmxjy66mVE38t7
         LZE3kAwGcBA31gVsJAdJpQ56mXkE+ug3JKTQ3c9Mc1TgHH/a9LNMma51qO2Lgznemwg0
         khgw==
X-Gm-Message-State: AOJu0YwCNlJiDKVdpF4a5GOQe9tHlT2PRchn1Q8KutAsD+W/IZoz5V2k
	9LbGkdLo/7doeu2VYbn2jSbds0J9o9wORwwt/l1TDsoc97Ut/fjlP/G3lg==
X-Gm-Gg: ASbGncs/d+fEDzecobb0QGqVCnLME3lF23Te8eE8eYxaV5YDYMCkAjsiVH+oMqRuhv4
	x46H1LZltVTSNLzqtPCOt2Uhsumk+IJLG0qhogs27ZDrGZoCdm11yniMcnsd9RxstxlyS/rC1/O
	J9gQ0ku5qHvxY59fuIZ2z9SV4+q6flSGPQLhImx1LFvD6qxrdYT1VOhs9b6cus2PvT3rxY6kHI1
	IsHSpojTfAj6/znFiVzZ5GBu8ithAd+gEnUV993gc7+cUMCPOF+
X-Google-Smtp-Source: AGHT+IFyU9tNnQqXKkXg87lBRu9K2Xba8+RTElDcEfzyMu1WPLL0AKRjVij+1hUh/1SS1NRmzV0r0g==
X-Received: by 2002:a17:903:32cb:b0:216:2f91:92c7 with SMTP id d9443c01a7336-218d6fd5ea4mr49006715ad.12.1734528636146;
        Wed, 18 Dec 2024 05:30:36 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db8676sm75779155ad.12.2024.12.18.05.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:30:35 -0800 (PST)
Date: Wed, 18 Dec 2024 21:31:16 +0800
From: shejialuo <shejialuo@gmail.com>
To: AreaZR via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, AreaZR <gfunni234@gmail.com>,
	Seija Kijin <doremylover123@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] refs: exit early from the loop if it is not a main
 worktree
Message-ID: <Z2LOpOxu0oAY0DW3@ArchLinux>
References: <pull.1848.git.git.1734488445457.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1848.git.git.1734488445457.gitgitgadget@gmail.com>

On Wed, Dec 18, 2024 at 02:20:45AM +0000, AreaZR via GitGitGadget wrote:
> From: Seija Kijin <doremylover123@gmail.com>
> 
> The is_main_worktree function just checks for !wt->id,
> but the compiler doesn't know this as it is in a different
> file, so just exit out early.
> 

I think maybe we should exit out the loop early. However, the above
statement is confusing. As you have said, `is_main_worktree` checks
whether the `wt->id` is NULL. Why compiler doesn't know this? And why we
need to exit out the loop due to above reason?

> Signed-off-by: Seija Kijin <doremylover123@gmail.com>
> ---
>     refs: exit early from the loop if it is not a main worktree
>     
>     The is_main_worktree function just checks for !wt->id, but the compiler
>     doesn't know this as it is in a different file, so just exit out early.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1848%2FAreaZR%2Fexit-early-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1848/AreaZR/exit-early-v1
> Pull-Request: https://github.com/git/git/pull/1848
> 
>  refs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/refs.c b/refs.c
> index 8b713692359..cce63a618d7 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2791,6 +2791,7 @@ static int has_worktrees(void)
>  		if (is_main_worktree(worktrees[i]))
>  			continue;
>  		ret = 1;
> +		break;

So, when we find a linked worktree, we just return the value. From my
perspective, if we decide to optimize like this way, we could drop the
loop because the first element of the result of `get_worktrees` is the
main worktree. And we could just check whether the "worktrees[1]" is
NULL to do above.

However, I don't know whether it's a good idea to exit the loop early
in the first place. CC Patrick to help.

Thanks,
Jialuo
