Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED044248178
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739028592; cv=none; b=tTrCAzn8ZsQe9v2kXggwSOHqzqtBqIXS7yLr9Sxi+Z5rbv0rVCWgdfHmpV7m6dEi1EVlHDAsY5xdNuzzdSfCW0wxXXtE7W+8Pq7az2hRdk9IKZjgQKw77Mu2n5Fu6eS234d6C271azz3kC91KqDgT3eYt0jRMpDwOVE+Xk9H/Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739028592; c=relaxed/simple;
	bh=dW9m2kutTgMkHLBoR1J4ZlPqZ40nhk8S5A3Z7mbdwcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUlZUUs/qJAlHF5dbsigQImfsHUpEurwM8csVAJCB3p1sn3WvCDX4IUVOzKfB14txta58BxRlBXk0bfRn6f7ClqRSKeJ1EjWxslPkU8HqUlOBo9/DYTDAADpGel54RS5QhKql1OZxz9Mg3o9PGm+AL7ki6D3syP28OJDj08V970=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGhZ9eV8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGhZ9eV8"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21c2f1b610dso74758015ad.0
        for <git@vger.kernel.org>; Sat, 08 Feb 2025 07:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739028590; x=1739633390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EYOIlsc/MdKzcQZq19sN9s4Pol6Nf6hSEIe+lvLpZyk=;
        b=QGhZ9eV8lLBWuYEFqBornGePRTQQ2u1m9CmMvE3N2kiNfghtj084yEAoKB8fzbmSGM
         XT/qxnNMSeuwsczrig+qHP3SX3d99ABKO+xKg5VcDT1uHFV4cmdryI23dLYzohCIF/pa
         vj06Z0nWMZKqLB8XjltZyvtqwtz/Pxeo9eLQ1PpIGtD8BPfMq2NwaQS2eKCtvgdypqYl
         h88fa9BeeoaVlLpV91N8Q5mpoZLK/GXg5l4usL1sDCzRSXVNW5dODESyQ2qzUtiBf5Hv
         bwCtPr/FliswjHACjjgI/iBTncImZwVuivo6z+j1j9WwExSWDuz7MkYHtuqR6UP5nnIB
         oGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739028590; x=1739633390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYOIlsc/MdKzcQZq19sN9s4Pol6Nf6hSEIe+lvLpZyk=;
        b=sPFo52wGV8DNrbE8UE+e1dyEHaFHbIdRxN27f0MtZCzgPda7DJ0me2P9yciQ+DIrYc
         JhtxLh5eVTGanUPoe9ZQ2oa0r01+LNYmgRqeM7v4aJigPI5x0avt2IVfTWd9Ku6IQ5ns
         uG9EMnFmb/6tc64lLvRPpUZMUdWLNgBx1IQfwEyOV/ahGzZ80/y2PIxIjZM9Nzrx1wTp
         IWJnKagsjOmXFvkBgBYXwoz3IKYO0ihMbIox2L8BRq77UaQlwp/XITYsjqei84SRv0nL
         hBy6ungSdd0Ni1llBttH71MTdEoerJS3yUgxnCCx1dWVaQiCeeaprGCtzPHjTTwRNnSO
         GYSg==
X-Gm-Message-State: AOJu0Yz3LyQDo1+s9mxm49I3VCWSI5QZ4Q7TKKNMz4ufAvFUD4GJCZ+V
	YzHFr0PP3Nd/xW3luo1c9Z6svdjGZHPzeh2DrAkCloENL3Ev9sAR
X-Gm-Gg: ASbGnctSlpigiSRAJDDuhx1fm84L7IqctzJygsWknfgRTvqu3VZQlZQHfjlFb9+RCAH
	o2Q06kx8RXIJgv8eeVyI14ZK6Kyy2kgiS6zRQ1L8+RBiQTdshAmkLtbk/mamdS3d6k0Ag5GlABH
	zxdZrxToUAhOP/LSb/xxmNteMDvAC6FxmSKnaFZF/jDVH7IV/vldPKzZVTjaDQKercpqMayx4Sj
	TunizIPBkL4QkE+MUnm4YEpwUxr2zuQLbMgW3kKup6PwoCQOMJWEQuUTUUYOFKBr33kuw==
X-Google-Smtp-Source: AGHT+IG0RX2A3mM+TE0Sd0o4BCC9peVNeQp9uyI58NFsv3cCir5nEXaomvMInbVLkErA912zUhNCYg==
X-Received: by 2002:a05:6a21:9017:b0:1ed:a812:c3b with SMTP id adf61e73a8af0-1ee03a1db85mr13868407637.2.1739028588643;
        Sat, 08 Feb 2025 07:29:48 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73048c163a7sm4833769b3a.138.2025.02.08.07.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 07:29:48 -0800 (PST)
Date: Sat, 8 Feb 2025 23:31:33 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/16] path: remove dependency on `the_repository`
Message-ID: <Z6d41SYoyavqcei-@ArchLinux>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
 <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>

On Fri, Feb 07, 2025 at 12:03:25PM +0100, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series removes the dependency on `the_repository` from the
> "path" subsystem. The series is structured as follows:
> 
>   - Patches 1 to 5 unifyf the interfaces that can be used to retrieve
>     repository paths (gitdir, commondir, workdir and submodule paths)
>     and adapts callers accodringly.
> 
>   - Patches 6 to 12 drop repository path functions that had an implicit
>     dependency on `the_repository`.
> 
>   - Patches 13 to 16 refactor "path.c"-internal code to stop depending
>     on `the_repository`.
> 
> Changes in v2:
>   - Rename variable to `wt_gitdir` for the sake of consistency.
>   - Improve several commit messages.
>   - Link to v1: https://lore.kernel.org/r/20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im
> 

My questions for v1 are all answered. Thanks for your explanation. The
range-diff looks good to me.

Thanks,
Jialuo
