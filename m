Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F69217F2A
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890452; cv=none; b=Bf2puSIb3oFBGbW40ig6XkF6ZGpWR+0Sq1Ts+G3xKOq3XsTBYm+g+x19aAKdI0owgilahkbnTTBgdYiFE6FUMjWpHuPf8ESgnSN/I1gkOq+EzSHRaK4qQ+Nvzs6gEXJei9Ng87Zw2SfpGp03mpvTjBeSihOXk7gBc/iPKXeo5t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890452; c=relaxed/simple;
	bh=JgwMG2yZbmWXKPZk2As9V+RzNcxH+in95QTiH7MpCwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pm23/mbkvXb5fFDHK2rhHmAmdzoY11MHmyXkUap6JwL/IXhB3U1Hei8iiqK+imWnxUD7srn72WGmQ2zTVTiF3tJEppdvVo6odZeBYfHp0ET+Ur0IuIVdHf+VJvfDwY1Yn5MCcoU8wCkBU2nSFy0XU5kw+rmnpxF2dxA3qrKOZIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=czywX7xy; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="czywX7xy"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso2593225276.1
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 14:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729890449; x=1730495249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+/Das+LZODiHcJxZM4/gfCE4SXruN8bzi34z13SeS28=;
        b=czywX7xyObTY9QKtyGkBjObN1JwZZO0ysBkriRHH2FvJ1i3oXwXFrjFtfePGyctqOm
         Uq90Tl1Uj507F4WVs0Cl/CN6YPRPeYpbE035mxW4XP4y22zEcsZ7K5KDvJmRAquchbn/
         l25Cip4HKbxbR7qSje3N6l0WZomniuwE7SXgSmCq00/ewDRW/vVX9fuFrhFfsmqBMaAk
         xKFB/CjR5gB2PtuE43YdzlkxrR/dAAaakyzh+rvihwaTm9Ebk2WA4TPrL9ZYBnzJqknv
         jxp4O96tjgJv97mTbwrCqBvDpDOxa1haP6bnoS/WflDtPzSacoEjmuNTHEBNkWZXVcI8
         VIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729890449; x=1730495249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/Das+LZODiHcJxZM4/gfCE4SXruN8bzi34z13SeS28=;
        b=dZcTVy3tEaSi88FD/C6TEwVUw5SJDocq86pScBSJMmVR7dPX6e2yU89HSFxt9AhEg5
         f1vzE1qA4nqSQQIJXAsnTUSt+vWoYnFFlzdbHKjazdJnH36+h8nozZfmYNmieWVlKOcE
         r/dxh0i6lbtotKk/GOWAOimn8JRYVSGpEDh9Yt36ZMa64k+XGlK8fJNtCHOf9YLavY/C
         rLyNy4MDDHy9QVAxC2mByJSgw2qTnzTiT+WkERKkpI7AASK+jkVMdW2jfShZNPKHMl+8
         qrzLn3+q1cL4NwNKt/vClKbpITIopCHHn4BqBip0H9HR7jkjLnESuNBRvRGoRJHVIZ4I
         cgzA==
X-Gm-Message-State: AOJu0YzdxmOIh1+rQiEckOz8ikbmgO3xMqSp3ddLOC6En/heeAk8Sgj1
	JXEQFEQNxcbQhzAA3V1RyhLOrcxxl3+UKD8KDuY4B5/v1y7EmPdBCq8VBo4BwNE=
X-Google-Smtp-Source: AGHT+IFb/gK784kAAPJcCegCMXTTyoa9Aa7QDAPYop1HDzpYHYGtzzANIiir5zqNsG7l3EPhpkZRRw==
X-Received: by 2002:a05:690c:9a88:b0:6e3:2e50:8c0c with SMTP id 00721157ae682-6e9d8b52043mr12619797b3.41.1729890449538;
        Fri, 25 Oct 2024 14:07:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c769fcsm4354297b3.78.2024.10.25.14.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 14:07:29 -0700 (PDT)
Date: Fri, 25 Oct 2024 17:07:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org, calvinwan@google.com, hanyang.tony@bytedance.com
Subject: Re: [PATCH 0/5] When fetching from a promisor remote, repack local
 objects referenced
Message-ID: <ZxwIkPJLuDDxfSgE@nand.local>
References: <cover.1729792911.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1729792911.git.jonathantanmy@google.com>

On Thu, Oct 24, 2024 at 11:08:39AM -0700, Jonathan Tan wrote:
> Jonathan Tan (5):
>   pack-objects: make variable non-static
>   t0410: make test description clearer
>   t0410: use from-scratch server
>   t5300: move --window clamp test next to unclamped
>   index-pack: repack local links into promisor packs

Thanks, will queue.

Thanks,
Taylor
