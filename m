Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A097E14A4F0
	for <git@vger.kernel.org>; Tue, 21 May 2024 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716330192; cv=none; b=le145WjJ+epcg3FccnPDU5PlAlugpJHwxoFUeh+hSTdatQ3a1CIO3Hb437vlw7lzMCxVgg82FAHiGPt6hXnCetBMyQRy3rECzgXMmL+OOPmmtrzRYQ03gFFqU8tGzHxzaIE1myG4udQlpW47irwMWC8g8W2pT/pZchsn38csGhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716330192; c=relaxed/simple;
	bh=rCI/DX37Qpy91vWOspTjiqBBzmaop1aLRn+F72KfuYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/tzPYgWx3D8hyXkKZMEY80ceHmTwSLwZyObX3lbzsYhXM61xOXhxyD+rpuaZ8z6yCp7E2Byqb0W+C7/0urC8fJv2fsyCaXdc31Ry28XtEyIrWi3p23qV3N/pk4TlE823GtkaKDBgztRWi1jy5m3MZbZUw0Qn0iEctmCO0VgbIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=su+q5lGI; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="su+q5lGI"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-24544cfbc69so2015099fac.3
        for <git@vger.kernel.org>; Tue, 21 May 2024 15:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716330190; x=1716934990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rCI/DX37Qpy91vWOspTjiqBBzmaop1aLRn+F72KfuYw=;
        b=su+q5lGI7yyo3cCSNah3AfoMV3HgobUx/o6L/DEcPYoLfvg6INwaypBsUFbswWtj5V
         cg7QFd3Q0Ib6aNynlLtLXGeopp8ssUAvaiRRVdaONor1/hXAT0gxcagAc1WpsBWusm2j
         czJfhSJvvbNQn3hN6JkWNYImz5KQGUi1zQY0v9Up3711mtaJCpiWgr20Zyf4I0B+jU6W
         aw5Mnt/ksKriEmaclVW0QvT4TpK4Xj41kVzg6EsrMh8uuE3gFduw9T9fPmdgiqcLkT8Y
         nXBVUjSLnL7uZDwEJTTlQsLc9+netMBQMe/OyTlPmo7n6yGu5xetkI85WacBIqp1O4Bi
         bTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716330190; x=1716934990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCI/DX37Qpy91vWOspTjiqBBzmaop1aLRn+F72KfuYw=;
        b=FEkIZ3IO8HaMsIfaP5J2W3iV2QATfibh94xb9ue2a2lVJIkyENqB69f7DaXPqOVQoN
         n9/aEhqQ5s/dYkWuS1PpqVLzhlXDC++eAwF+ZLY2Y+Egkb2jwI5gI3zTFTFNqSPjB5e6
         prWECWvx8egv6552NE3JefvhsjTSBwjoUhAVeYtImBSF/k3ed191+xtASZi6WN8wHDnJ
         RNDsLK2qTT2uM4hYWs4S934AzY65nMbcnIedLhxmdpMXQTUe/4x+ZTyP84c6dbEKpnAM
         LAf2zSgsOqw9cnA+GqOzietjzdFXPg+C77cQIKzsydzl5DrqGZaNComCFzI0Quktz4Wl
         m1gg==
X-Gm-Message-State: AOJu0Yz7BbNfc/wDPhLay3DjkmiHYZKw5SpPqo29jzsSC4fF+jXe6FWL
	Yo37oK5UluetCilT8wBcm5BwL+PhFA4afVM/eB57Vlj/SzMsrAA5tJQjA5rGKa5qnz4BQUZ0K40
	C
X-Google-Smtp-Source: AGHT+IFTTpG4hUfZTXmWoIps28yBHkxT+JLG8oeU/jWU+AL82EgGtJoqOanYxKaPikP9ainrvk/idQ==
X-Received: by 2002:a05:6870:4205:b0:24c:5fea:ff8d with SMTP id 586e51a60fabf-24c68b58ce6mr456098fac.15.1716330189784;
        Tue, 21 May 2024 15:23:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf275861sm1330776685a.19.2024.05.21.15.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 15:23:09 -0700 (PDT)
Date: Tue, 21 May 2024 18:23:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Aditya Sirish A Yelgundhalli <aditya.sirish@nyu.edu>
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
Subject: Re: [ANNOUNCE] Git Merge 2024, September 19-20, 2024, Berlin
Message-ID: <Zk0ey1848sjGlBXj@nand.local>
References: <Zj0JyL1b+g1G3zWx@nand.local>
 <835eb66a-737b-40e5-99be-af299e231408@nyu.edu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <835eb66a-737b-40e5-99be-af299e231408@nyu.edu>

On Tue, May 21, 2024 at 07:47:35AM +0530, Aditya Sirish A Yelgundhalli wrote:
> Hello!
>
> This is very exciting! Could you share when the CFP is likely to close?
> Also, is there at all the possibility of having a co-speaker?

I don't think we're likely to close the CFP anytime soon, but I'm sure
that we'll give the list a healthy "heads up" before doing so.

I don't personally have any issues with having a co-speaker; I assume
the same is true of Scott.

Thanks,
Taylor
