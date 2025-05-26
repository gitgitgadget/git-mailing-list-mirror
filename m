Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCF120F089
	for <git@vger.kernel.org>; Mon, 26 May 2025 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748269665; cv=none; b=UuX867iC9RSYcwY/vEPv1p53TFlqyr3wObSt+2cgng6U0ziOP2/h4DGOQpJDTVE8yZfBcvLhFCHDZz3viyq/CAfQMrqGXzdfWjLBUCaftXNJQk/7lx3aH4t8Ocjr9jPKcGGLq56L9ORgGZtGX+WjD4k1/jPWvqTsUe6Dx2/eVH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748269665; c=relaxed/simple;
	bh=Z9leguvUsTtzKMPTfO7iZxAw/alQmFLnh9sLfk4PP7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7y4OrUqFD203Xcl5CnAfBsZwHPSdOIsp+FKQDe2E1Spaut3kVqi99PXbyKfy6PGyXgWH0TygpMWXZ+o6LMAzgQVvNK+rANnZH1ccqi0uX0Rw17JR2gEH28ZkQWztvfGyj49g3RbHVezzXml2+aLdPgf7lByE7S0XDnq7xnlkLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMp5ksMj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMp5ksMj"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2347012f81fso9721365ad.2
        for <git@vger.kernel.org>; Mon, 26 May 2025 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748269663; x=1748874463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EyLdJ4flTEQBipHJeLTScUT//aD3tQ0c1UaluSv9Rjg=;
        b=kMp5ksMjdoyhsKNUviE82G08vRTDE3zua+maqWNT3dEhwYE06AyO0LYWXxLm6HT9vc
         R3jqYAyhktZveHBBix7grRmHjfYim0C3KcLXD40pc1TUFXWQr7hmX+Me1NmuHVJu0/G9
         DIUUUTYZ64BtleI8ncDIOmEdqJePgArRIs9Z735q+vjD82sDmUfKxEKeJUHJnMlEgZjS
         skR0ILzeGMFv1MaGhV0mco6BpkAVtK7jlbfMZchcwquMTKlfxa39m3uvNyZBZwzEZkT5
         p6ofMBbiUqdSQXFGKoGobrEeU4NcE66nj6g7XKD1V/JsFHvfULhYe8VtIrwVxWcOG0EC
         ATtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748269663; x=1748874463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyLdJ4flTEQBipHJeLTScUT//aD3tQ0c1UaluSv9Rjg=;
        b=kdoRW1gSoVr43tyFfyJOqPGhMndNWKErCC+bp6cOjWm8D4DF8pOL8ETY/WZsr55+Fy
         2OFLcURhYTmMrfPJIic/Fo+47+Q8JOnXOg+tyVzdc1JgCiiVkTLy+Zc17ohGV3HgULBy
         4WkbOElOcTIf1oh1BDIxracK868hO7xyF3gU9IAGjk7yLwKTPC0c+zBHg4aR77GPDyWC
         t+qU1mVgB91MxxqpPzAsX30PN5co/z7TStC6B0rSg10TylxXsmv0hzEW6IsvEzVf0wZ4
         06Q1Ts78XuV/zKkZcAnIcSOWfwP5ZKWUBe/Fu+j9zdBinpXaL1HquuspCBEX370eQ5yj
         suVg==
X-Gm-Message-State: AOJu0YwilrntkDLL1a/V2dxyFPW2hI6HbMN3vmK59ab9IGROY6MGGAwF
	uAA8BSr1SK0DcM7uGG9mBnMxAooEwQwRsHnKAXKtLpzRWCQPgGMYbKoZqdSsielr
X-Gm-Gg: ASbGncu3sEaEP35MsB0JJXjssllknuywmldeDmCQyqdxsc1N3e0ISMFoFSAkkJCtC3R
	RMUWMdXrD4H8w1CVZ2oXpox/3Cz90EN+qy/Y7MBKkGc1U3sZKAaXxNGbBJGsaQYCtL8YDsJ1KNk
	Wl4bDJmPRESP7qsnmxoN+pbbIrtd8Of1AN1buAVbaeJNN8jlDx4wsJma+a8pe+jt/0NSdXkLvZS
	/J3/v2aHwUBEx/FHuGu0JBNkERUnJOOCMi3VgIfdoj8IdzvOMqJ0rEbmUJRMNlJXWpsxipLbdNy
	C7sYGzfCPY/gANaVtVdJyK/wy9NFo1IpTeGqSZaUVRNqnKA=
X-Google-Smtp-Source: AGHT+IHxMw2P85yfIAxvbd/Hhjatr8tVIC7SSTuH2QOCedS3A4ycFid4gBJkdKNkwpRNRavJvINn/Q==
X-Received: by 2002:a17:902:db03:b0:224:1001:677c with SMTP id d9443c01a7336-23414f32ca9mr131634945ad.9.1748269662743;
        Mon, 26 May 2025 07:27:42 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2343f093060sm28215095ad.189.2025.05.26.07.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 07:27:42 -0700 (PDT)
Date: Mon, 26 May 2025 22:27:47 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/8] string-list: enable sign compare warnings check
Message-ID: <aDR6Y-osR4s-clRt@ArchLinux>
References: <aCoDB9P5XV1lHMil@ArchLinux>
 <aCoDY4A62uWb-_MV@ArchLinux>
 <aCrbKz6tr0vj7ytY@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCrbKz6tr0vj7ytY@pks.im>

On Mon, May 19, 2025 at 09:18:03AM +0200, Patrick Steinhardt wrote:
> On Sun, May 18, 2025 at 11:57:23PM +0800, shejialuo wrote:
> > The only sign compare warning in "string-list" is that we compare the
> > `index` of the `int` type with the `list->nr` of unsigned type. We get
> > index by calling "get_entry_index", which would always return unsigned
> > index.
> > 
> > Let's change the return type of "get_entry_index" to be "size_t" by
> > slightly modifying the binary search algorithm. Instead of letting
> > "left" to be "-1" initially, assign 0 to it.
> 
> It would help the reader to explain why this change is equivalent to how
> it worked before.
> 

Right, will improve this.

> Patrick
