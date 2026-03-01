Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB662158DA3
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772394027; cv=none; b=egeignM7qd+JIwL4LKohNL2uAE4VtFBziO7DwJaCkRaTDqToie/uRTJdatcAkRwffl4AugpkyMp2Ab+znM9hRNhlpFvcQlJPWNNpxKjK9q8CeJfPF7/CaHpkmQWwHvlt1C4vjO2ZykaAeGKRseyj8wF9LfWCfE8DWWGLimqSxGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772394027; c=relaxed/simple;
	bh=8Ecj/3zjjgVVe+Ip5Xu6EzlM3nTVL34Efr0Qm33MMsw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XvdV9tROk5pMPa9rv9KiZCdgr4hhN3uTtCCZgEhK8gpw2z5qrzzPFglFDx1lzIJiQ50FzHP5/pIIZNepmh9VdBUoDj3GQ8u/BOeKi6W3RV6PKbtzgoNf9KurYF+GCQ6FXW5Sbjs/XW3PxbuRF2Ndk1FDklRaaBR+Y2QhDcWIMiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFfMHoMV; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFfMHoMV"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56a8a20e6e6so1651235e0c.0
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 11:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772394026; x=1772998826; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UL558ECfLRRTswkYMVmT0B/FOrM7vGvJxI++bzskrc=;
        b=bFfMHoMVNmJMPs+roH1jRiyJugzW3zqemwMEk3+ZRt0wwwya+vyBPgbi6JOsY0Nz36
         SWUSCejHc7QI4v7gjPbrBG1w9PcsOeKXcR9+evo3m9vCqa0ouuOU9o5G21FlpNdyW+WC
         aD70e2dTkculmXxpnmovE/BDy375C8uXA32fRnaaTXK3piMBQ4c7/pqYlbvDLEK2DJ0p
         iGzOhlgttOyui7ZC+mkzxAieDrUY3dhrGuOLUPWDsJMmjf3cDo5rF15jabK5C7I1Y1Ew
         26lP1b+aiPrZG708fVD9lDLosQA520ejQoeqTUVuJo5FOQbm98QLwIh1ww2hCY07kKQD
         zXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772394026; x=1772998826;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0UL558ECfLRRTswkYMVmT0B/FOrM7vGvJxI++bzskrc=;
        b=sfmIyGRNytRd3kfFqkG4KPQTK7SkYj3Jz3QQdqZtBOMBgLx+6Lkw6UhfibaIWi7+sk
         SBsBvEtftemszo54ru9Zx2WpG49QBtGNqYSJdG1yS9TfanWelTtWBlX0p/dsvILK1guO
         tzge/R3Ec1bj5FUJjdHt3xjmcP7f4Ki4gw1iEXvEEKilrh/zNtVOwtoqajI4zrgMqEpM
         86/x1j2PQepgzL1iPWiBrX3i5iWBlOA6am2AeUkId5mhwEv3QH9adaoZX1MzuKUu6N61
         90de3x94QCkYc9DOXphrmI+4YbxyNNHj9kZmkL2s1z2l9wMyQvpelWHFXK62wu2IIQWC
         QHOw==
X-Gm-Message-State: AOJu0YwXX2FjN4dtOY1BRInyIC5w9A7js1j06+ZCgLAb5Pwe0OL2sj4Q
	wzOWIRTwzpCWCRkF8tAO5xbvBwpKAuvy9sMjgWDT74e4r7jlvCUDq7fh
X-Gm-Gg: ATEYQzyYvC8YoMYBAArMFJOcJodngS4EY09OrsYMsh+Lcu35gdmUodPg+z24YYL9akm
	DkWMI0lLG2vCCa2dy+leBgUPCePmOv1tjhUuN11STssviohPeyPzw0E0uSjuipAUsay+HV7CTYL
	ZTnrwmGxvShiuBoPSCqOPXpL6SFa8/e7ANGE5iBTvUwGCYeYk1XwJo0f9M7HjSV6bjTGLhPpIy8
	ZmwF6so0/0mENqzZchAoBePBmirbdB6K9+n15GGT8oSipwmqKevr0vzxId9pGYNbVdrdUno2GfA
	KElhdzugTa9OLGHyp6qA1sYxALmpLUHz+QWUygos5SYqo5dQRs2ul+B898z5CMyRT6ANTO+DjTs
	pOoIlGaul5NRV9YHd5nrkuKtE3nXo0QdBzEwFBWifoOzY3eoKiFWiUZZzBoGid2tr2RY9N1H6vH
	f3Vwe6v6bF+lR00MpvMsKngOhFrw12t0JCout/y73BTXUHKYDqZUT0VpS/wNrd
X-Received: by 2002:a05:6122:1d88:b0:56a:9841:9f81 with SMTP id 71dfb90a1353d-56aa0a4f95emr3747835e0c.6.1772394025714;
        Sun, 01 Mar 2026 11:40:25 -0800 (PST)
Received: from smtpclient.apple ([2804:14c:c4:89c7:617e:ea24:9d26:4bc7])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a91b8c1cesm13294598e0c.1.2026.03.01.11.40.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Mar 2026 11:40:25 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 0/4] repo: add support for path-related fields
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <c074cec5-eaac-49d0-89cc-d2ac9d605e59@gmail.com>
Date: Sun, 1 Mar 2026 16:40:09 -0300
Cc: git@vger.kernel.org,
 sandals@crustytoothpaste.net,
 kumarayushjha123@gmail.com,
 a3205153416@gmail.com,
 jayatheerthkulkarni2005@gmail.com,
 valusoutrik@gmail.com,
 pushkarkumarsingh1970@gmail.com,
 eslam reda <eslam.reda.div@gmail.com>,
 karthik.188@gmail.com,
 jltobler@gmail.com,
 ayu.chandekar@gmail.com,
 Patrick Steinhardt <ps@pks.im>
Content-Transfer-Encoding: quoted-printable
Message-Id: <491CD222-D595-4408-B78C-72E4C3DA0A62@gmail.com>
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
 <c074cec5-eaac-49d0-89cc-d2ac9d605e59@gmail.com>
To: phillip.wood@dunelm.org.uk
X-Mailer: Apple Mail (2.3864.400.21)


> Hi Lucas

Hi, Phillip!

> How does this effort relate to similar effort at at
> =
https://lore.kernel.org/pull.2208.v5.git.git.1772220640.gitgitgadget@gmail=
.com ?

I have this patch series started since July, but I could only
send this after having my two previous changes in git-repo-info
accepted.

I think that patch series you mentioned is based on some
previous message (or the GSoC project ideas) where I listed
what was still need to be implemented. It uses a similar
--path-format flag, but without dealing with the multiple
possibilities currently used by git-rev-parse (see [1]).

The original print_path from git-rev-parse has four possible
default formats (relative, relative if there's a shared root,
canonical (absolute), and unmodified), and we can force it
to use the relative or absolute formats. If I understood it
correctly, this complex logic was added ([1]) to allow the
user to force one of these two formats without breaking the
default behavior. Since git-repo-info is a new command, we are
free from being compatible with that, and perhaps this doesn't
make sense.

Since there are many people interested in contributing to
git-repo-info, especially in the path-* fields, I just wanted
to finish what I have here and leave the rest for them :-)

>> 1. Add --path-format, just like we have in git-rev-parse
>=20
> I think that's the best solution. Having different defaults
> for different paths like rev-parse is confusing and having
> different keys for absolute and relative versions of the
> same path gets rather verbose.

I agree, but I still think that it feels weird that we won't
be able return absolute and relative paths in a single
git-repo-info call. But it also won't cost too much to call
it twice.

> Thanks

Thanks, Phillip!
Phillip

PS: I'm also CC'ing:

- Eslam (the author of the patch mentioned by Phillip)
- Karthik, Justin, Ayush, and Siddhart (possible mentors for
  "Improve the new git repo command")
- Patrick, who was my GSoC mentor and the person I first
  discussed with about --path-format

[1] fac60b8925 (rev-parse: add option for absolute or relative path =
formatting, 2020-12-13)

