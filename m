Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9703D28FD
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735870246; cv=none; b=QF2z+r3ahM+eKSx5RMsgkvpAwkATzZ22qma91O1bE91dZ/u3mi6uAxkWqVY5rfwJDmyLAZ2KLvW8JqPP3DaSwZDeg1vweE36VloUE/LxA+yHz3TR7oB8Jb+7hHTEtZyiVpSX2vaOVPQaf27p4MsvDszY2i0XU2cmU2RC0sAUdJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735870246; c=relaxed/simple;
	bh=zVRbpS+r7A51AEk7HPvOmtU+3BH1TIrp2ynUJsj+A24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMDa9vCZuWsGWbp1EKOQIhTaUQp97s/1Mi1P3YAOGmqVPc1JDrUB4bRl3SnXl0ysf603G+I6DnyWEZiPXo/Dq2TGlwi1jonW5hWzbyGSj7LBcXnjH9O26vJb0JIsKrWmgZ5hlRZxaX4x/V/7nTXfH0fVy5Sc1Sk0JMspFBz9sLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBTZ4obv; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBTZ4obv"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71e287897ceso8393527a34.0
        for <git@vger.kernel.org>; Thu, 02 Jan 2025 18:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735870243; x=1736475043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Z0Ft7b3SUAotHfvWhwwWmxqEY1ADe12TVfXQPXqQbw=;
        b=iBTZ4obvFOVTHJLIqQzjMfcbzvrgHeZLO5SqjSxn3W7YIPeYW2X0jztLrn5snZDZq4
         Nbr6/bGbX+eW9fA4LcJGz/SX4k+ymu7+ysUVjFsuy4NYlw6KNtjvX3r9gvT9aDmYwptu
         TzBOHTNomGFbjSLT6qFw3sHekFoyNY1047tLLCO3WoQbqgC3lkRnUcOUd54dCghO8Sbj
         vecLsb+Aua71blY9zvqiSPuHPaD3WwOL30q8ZgCOJaZk0WCkvOKX5k/MB+H8xuDpbEZE
         syNTds5iH/RlO/cmOZjrLIVWZ97ebryuRw+stITTBPDYvaIBROYjM4QNih9T/FgQBeeF
         Nk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735870243; x=1736475043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Z0Ft7b3SUAotHfvWhwwWmxqEY1ADe12TVfXQPXqQbw=;
        b=ZOsSBY7hhXd+17JUafkvvohzvX42vJoWaV+lLzwZlO37Ld8RHpQ1tn2SpjBY0DnFEg
         KTokdNTkDbfaoUEDUNNblby8i3KCmdOlgZOdAmyEtEzJMSDt7FmPZ5OoCmWPG/WQqNDg
         fdoMY0gfZpCraeEE5lW6B9vwbfWWwomoBiNfG/Ae4yq7ws7DlCqOYYSXMFJmJJ0SNTIM
         m2++D2eNBmJXuVTTSUJGEPchks7PSyOdbUKwBPbCja8fLUCpZo7MYyuCMp+APQShanw+
         O4GlMcl+Qn8tp7oZ2w+HYmlxip/RWAEFTmSQwbWa4KE1T1oIS+lRPfcPm4ThXvAnhBWB
         t7ww==
X-Gm-Message-State: AOJu0Yw+ziSh3o+vt8XVNDAMk/+OWUY8j9evQencGqHVf82xKv41O0+U
	COSyp/oz3OoiRsUefw20sdIXhdS+Kc7pYbcx9NEFqLm3RJG8l/6e
X-Gm-Gg: ASbGncsQGQV4e3PgdoVT1Ve514LAKwgL9igwqcqsIQq/OAal7j8ibgguyGLsPn4+4nS
	P+E+GctOMbw3eeZbRpr4UmKEQcc8/+tpZFRkt2yGH4zv9ylmEryaiReSxTYcDzU/zu1e9oRJIVZ
	LaRMqKuab1KBi0crcFST1CuFASGhsy+S0F20MUudCWITajysUAnNS4BXC3Oxwr74z1crYSUF/N5
	AvmOqI0cpOJusns3bIe4dz1f98Kqbhuo8KLunPOOkylFI/u8Q==
X-Google-Smtp-Source: AGHT+IF/MMCgRSVrU6kJ0Vi4k8Sj54NndeQOvw4vNnCSA6MvUOnukZnAJVYBiEKZvoR6GM7lxQHFug==
X-Received: by 2002:a05:6830:2b10:b0:71d:f4e8:f5ce with SMTP id 46e09a7af769-720ff835ad9mr26931730a34.18.1735870243523;
        Thu, 02 Jan 2025 18:10:43 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f4db588946sm7424876eaf.12.2025.01.02.18.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 18:10:43 -0800 (PST)
Date: Thu, 2 Jan 2025 20:08:15 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 9/9] commit-reach: use `size_t` to track indices when
 computing merge bases
Message-ID: <s7b4o6elbbxrzp55mbgtj5tmfdtmdi4kczxad5ogy7quotrfhj@yq7ppxdjp4kd>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
 <20241227-b4-pks-commit-reach-sign-compare-v1-9-07c59c2aa632@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227-b4-pks-commit-reach-sign-compare-v1-9-07c59c2aa632@pks.im>

On 24/12/27 11:46AM, Patrick Steinhardt wrote:
> The functions `repo_get_merge_bases_many()` and friends accepts an array
> of commits as well as a parameter that indicates how large that array
> is. This parameter is using a signed integer, which leads to a couple of
> warnings with -Wsign-compare.
> 
> Refactor the code to use `size_t` to track indices instead and adapt
> callers accordingly. While most callers are trivial, there are two
> callers that require a bit more scrutiny:
> 
>   - builtin/merge-base.c:show_merge_base() subtracts `1` from the
>     `rev_nr` before calling `repo_get_merge_bases_many_dirty()`, so if
>     the variable was `0` it would wrap. This code is fine though because
>     its only caller will execute that code only when `argc >= 2`, and it
>     follows that `rev_nr >= 2`, as well.
> 
>   - bisect.ccheck_merge_bases() similarly subtracts `1` from `rev_nr`.

s/ccheck/check/

Small typo, but probably not worth rerolling.

>     Again, there is only a single caller that populates `rev_nr` with
>     `good_revs.nr`. And because a bisection always requires at least one
>     good revision it follws that `rev_nr >= 1`.
> 
> Mark the file as -Wsign-compare-clean.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

Thanks Patrick! I reviewed the series and overall it looks good to me :)

-Justin
