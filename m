Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792446272;
	b=iO+xha5reaiHcrfeX5XxL+U9eZp/eRuf2J0063lQbL5Lk7Kwc0eLyW+oMoUhxtIu6IPI
	 YTK6bY9hQkBXDMG/n1CYdbYzDhKbr+MIPAjdRbMiSmIqADNn+vd4RdyKFfbbMCjkoSW/v
	 4Khkid9wS0zGnIIH9ej2WMffx487Cu+DlnlaI9v2cafJz6wm0CEzXGmfJJZvy4C5nwI06
	 EOStWCRsSgWVABobrpv04BtUZhEe28NA6A+51PhthgMyJytEZCzPrmxI8DALLLl1I7vQU
	 LpA9IfvZyJ9IJVdg3zAPKmrtCgxvjcevDBcCY80+tX3yVP8U64MOkZTN8C3eUlQodGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792446272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=KHozo1NOfQDrV2JXc6ZQIQ5FKr3aHntTn/ZMmsRzw6I=;
	b=bywmOkpw+yPkZf0eEBSfjYS7TFD8tcW5SPxYQkZFwgFjeSH7Giy2A9XhjG/3mltd5jMj
	 KAF3kPxTCusX+BtPYuJNgUsJ9TME5g+c/Lg2Ok40/2rnSmrKxveWZLyTKDQlG73BDxZUs
	 KVjnddUbOw4+r5f5i2OI0P6Ve23rYDgN+wkzmDQUGG5BPgrKe7CCZvLZdyTJiSpneiY9n
	 h9KkyOSUzIpVL0Bn14BSOedz23XGQpHbNUS8XS2ZpwW7cWcQRjiKZkXkon8rqnLcBAttI
	 E6GOq6QGCDpU3r5Cs3Cj+ASED2ux1zp6nWV0dXF/kxui8jgibc1zH0EzDR/iVl5rQDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dS3FBWAb;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E24606A31E
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 21:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27E24606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dS3FBWAb
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6faddda49e7so2382527eaf.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 14:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792446271; x=1793051071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KHozo1NOfQDrV2JXc6ZQIQ5FKr3aHntTn/ZMmsRzw6I=;
        b=dS3FBWAbHH8HV3oKbjVmitfMyZbV5WW35nad4QKIezbOh7L/qix/sz1pimPOc2zard
         /V2kMvJhIL9+iKXO5jAHAdLvNeiVzbZLFmLHr0MxY8mp4HoBiPasymehXn++j6qYOnP1
         RAONrUHzycCOOJzXsNaiCur116a3pwYSKxc9XAW4RUjG0YAXoKYuRUi7ft9b07r5Chz+
         ms5ehoWlTaMZ4DYk8y9rHe7+pBMDFFC2B4nFOBCPeRsYx5jmYTnlDsOPYE4uOteeM8dp
         O+kMA+BrnRuSaoS5YNAWmjjo4ZMCqbF1kyVLzaa9WrHZ3aTS8JUy67YSOVs4JU/wieKl
         SGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792446271; x=1793051071;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KHozo1NOfQDrV2JXc6ZQIQ5FKr3aHntTn/ZMmsRzw6I=;
        b=TMXnJx2mgBlcoONB40/0PYieQG1xcXJPSDUH2Xj30U9d6WnXBJQiXeYVEcqxezlPuu
         b/6pzDfxld3ukukd95hUwzrPA3Mwv6+qSmEox8yHhCKtlT5Bb30EndWP6CBZY50zuJa2
         friNvttGS1B5wsG22qq6CBFTM73wGJO66gbbu8+L5Sa5eZm7sYPGDRuGz7ogOWBkGw7f
         AHQnE9p/kN3RFDbK3TFl3X7m291ssU7QNoC1Gkj7II78+EsnmlraSqKSWVcijDVjqr5v
         mb2pWYBl/2bTXrZ5wxxC2AFfKClohZPN9F4HyaMipy/0jy3Gx4VnU7wG7ygxRMEEFoMu
         lswA==
X-Gm-Message-State: AFq9FYL89sIIN9y8SEp6dRehXwTqdkZf8JJb3F4fgCNNFqlsMqS4smRx
	3kOU4eeSHzv6OFg6604nrj4pSGoPkQ5+Fb9/yXUrnisjLhaR0f4u5xnDPE4UCQ==
X-Gm-Gg: AYBFou0vnehQ5GSIEToxxZAUM0F/5NUvlqehDG4lBeKNUc/0iEl3R0x6MenyXYi5lKZ
	fGj2UjSWtQstODCFP6+H4reKcTpC1vp7lGYBYC/mh4NKbAx5aV+alJ6gaeUI8/kKE43W/9fuaPv
	RE6/UsMSECWxdPX2yb3DbkFlbiPMlr4huw1E6wIUB6si9DVMYn/0TpTzzNqPSXZ1azr8ozGcc7h
	Vpu6OBs4+caZI74q73djnCwKyh8oX4cfgUu3DauCkuzqn/vHUEtIOaHubaaIYIeZCzrFFVqtlHP
	WqFGyUlCVee19pqCnqAMsDqToIVO2McoZ69eZobfG/++T4mc0Wb1J17Ot96Ys+THGhILfy3kZDj
	0I6R5Bg6GzVRMvXXkOOMNTKRAFjBzgmQuMkWOrjhFKOZwhHGCmG1Y/zaUOi8uJdnTN3py4gYrZC
	c6Zb6gUCOjIZDiMQeKzjxg4UFCJDDPXjF2hamJKLF+F5DkeprtYyYnG0DgxeXq8vgvO1aOMTa9M
	RHM4SQtB2XgxysziOsV7Z8=
X-Received: by 2002:a05:6820:c44a:20b0:6cd:3ffc:acfc with SMTP id 006d021491bc7-70357a9cdcemr4175698eaf.76.1792446271030;
        Mon, 19 Oct 2026 14:44:31 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-701900719c6sm8715322eaf.11.2026.10.19.14.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 14:44:30 -0700 (PDT)
Date: Mon, 19 Oct 2026 16:44:27 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] object-file: explicitly write ".keep" lockfile
Message-ID: <ataOnaLL1AzafGld@denethor>
References: <20261016022901.3838402-1-jltobler@gmail.com>
 <20261016213716.593278-1-jltobler@gmail.com>
 <20261016213716.593278-4-jltobler@gmail.com>
 <atW1Vh0b406cxCZJ@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atW1Vh0b406cxCZJ@pks.im>

On 26/10/19 08:14AM, Patrick Steinhardt wrote:
> On Fri, Oct 16, 2026 at 04:37:15PM -0500, Justin Tobler wrote:

> Nit: now that all error paths call `error_errno()` I would have
> preferred to keep `ret` uninitialized and then assign the return value
> of `error_errno()` to it. But that's a minor detail only that does not
> warrant a reroll.

I've queued up locally this change a long with the removal of the extra
newline. If I don't get any other comments, I may just go ahead and send
it up.

Thanks,
-Justin
