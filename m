Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A4209F32
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730242560; cv=none; b=PE2huU8mPf8q4AD3FFweqBBINhLrXrRHAEFe7+OMmlyB0d4VHeDRLM0Pek+H51v1GIL3uoaKalrluPJ1yNrwSj5yBXa3/k3xkTub458V76Ma6rTHfKPx08iVcROUftR0DEVKBmcobh5LLkrQntXii2kPS1LEEv0ymCydFR8azbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730242560; c=relaxed/simple;
	bh=5VM7UvELs1SOLWUymtmuI7ysUryvHWRcgKFw/1b9l70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lz5jdjmyniJta0qiCDhGv0H/QZlG9xPY4H8ZUx3gNCUZMmZ6kmrDt3AOOm8SYOFqkdSnnGdOx91VIhcoL3JLeAtGoK0TlKQPoZB+EsHDdUhhIQ38ukyc2X7O4j/DxkaL61BnmvXhgWaugnjbmpd5HnHoWyFPxsarm4I/Rv3TyFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=AzzFdFf6; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="AzzFdFf6"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e3b7b3e9acso57174257b3.1
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 15:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730242557; x=1730847357; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5VM7UvELs1SOLWUymtmuI7ysUryvHWRcgKFw/1b9l70=;
        b=AzzFdFf6PArUAVXtbM1nOGTsQiJ6rjpXgFsBLDaJSbV5uu+EoU2Ko2ei2RdDVzms/g
         UG+5gymUZXSLIfzKgN0ozb+ryTIQeuRMsmIJIyHxufCT9wrSFozCxUbEJ9IYhEtZogxp
         fJ2Ti2jOgfOJ5XbwAAH8SzMwQGh62SP8v4kizhmVMYw7qTHO0aAKgMatIjPD5NWfS71W
         vRlhto1tb2mseRNZA12VFFHQZr7iWoPrV68yl3snCt8PkTqwz++280ZjX/bXekgduyKt
         HQHfbetj0lt03zm0MLtjjTH+PYoUn+o6jijJZ8SqKflfJWyvsVUvrBpAQ3yMIUfruP8g
         x5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730242557; x=1730847357;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5VM7UvELs1SOLWUymtmuI7ysUryvHWRcgKFw/1b9l70=;
        b=ryMFUXroNne29Q2FNOB+vxAIW5elZepp5bGJDXqRPXngAgG1e+8XWqWI0wCcQZIcBR
         1cceyOgPXjS/Qo5cSmlJpoGMX7KAgcOXYxteawR8nCMfTkyf8P7Q1ldsuo6lJTueqno5
         EwugsvXb4sC+ITXXnECgzVjx2LEgfMiJMR+7Nb1ezK59XBbdgshxbp3XsqkBoZDEWq70
         ZiJbp6plo61va16WNEFzTpnVEpX/5NumhPAvic6PXC4pbnxchmHmSCacgClPqsp4FX6d
         OW8duBehyHB4Lu7J7XywuiDceRXG689E71QWhCL41jsKHM8Qn+wUWu49ELF+acIjS3Nq
         DwwA==
X-Forwarded-Encrypted: i=1; AJvYcCXmdHI2tj5sCPmi9V0o2y9d+gIzgoE+l8cMR7ytsmOVBjTQCtemvh+Y/HiP+hd4/ZVSIZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUeA+TN38F0N2SXnCMOQdL7T8FRP3DjixZqG1ii8hl1r/NRTCu
	mbOK5qYUtbEyn4JpdQf5mUUY2mGZtNchw6/pKq3AzEUs8n3FfsxzWudNK/zjBKU=
X-Google-Smtp-Source: AGHT+IERss8Z4rJPMbjQQv18nfh18WFeMTgprAFpngAd5aUittmmglzkJayMUKAiS0o3SoN1xOMdZQ==
X-Received: by 2002:a05:690c:f06:b0:6e2:ac0a:8926 with SMTP id 00721157ae682-6e9d88b8a54mr139496927b3.9.1730242557427;
        Tue, 29 Oct 2024 15:55:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6bafd18sm21665817b3.21.2024.10.29.15.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 15:55:57 -0700 (PDT)
Date: Tue, 29 Oct 2024 18:55:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: phillip.wood@dunelm.org.uk
Cc: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/5] worktree: add `write_worktree_linking_files`
 function
Message-ID: <ZyFn9xErajxzQo29@nand.local>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me>
 <20241028-wt_relative_options-v2-2-33a5021bd7bb@pm.me>
 <4a316a5f-9360-4f24-843f-bcbb5b3378c4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a316a5f-9360-4f24-843f-bcbb5b3378c4@gmail.com>

On Tue, Oct 29, 2024 at 02:52:36PM +0000, Phillip Wood wrote:
> Hi Caleb
>
> On 28/10/2024 19:09, Caleb White wrote:
> > A new helper function, `write_worktree_linking_files()`, centralizes
> > the logic for computing and writing either relative or absolute
> > paths, based on the provided configuration. This function accepts
> > `strbuf` pointers to both the worktree’s `.git` link and the
> > repository’s `gitdir`, and then writes the appropriate path to each.
>
> That sounds like a useful change. I think it would be better to pass an
> extra parameter "use_relative_paths" rather than relying on a global
> varibale in worktree.c. Thank you for adding some documentaion for the new
> function.

Good suggestion. I definitely agree that this is a useful direction.

> > This also teachs `git worktree repair` to fix the linking files if
> > there is an absolute/relative paths but the links are correct. E.g.,
> > `git worktree repair` can be used to convert a valid worktree between
> > absolute and relative paths.
>
> This might be better as a separate step so that reviewers can concentrate on
> the correctness of write_werktree_linking_files() when reviewing this patch.

Indeed. This patch (even though the diffstat isn't overly large) is
somewhat noisy just because of the number of spots that needed to be
adjusted here.

I wonder if another way to split this up (in addition to what you wrote
above) might be to introduce the new function and convert one single
caller in the first patch. Then subsequent patches can go one callsite
at a time and convert them to use the new function.

That way, each patch is easy-ish to verify in isolation. I know that
results in some more patches, but I think that the additional clarity I
imagine we'll get is worth doing so.

Thanks,
Taylor
