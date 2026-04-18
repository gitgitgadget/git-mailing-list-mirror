Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7A738759D
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776521812; cv=none; b=IxDLzZ580p+O3GIQC7sKXVDPXRG+6lTLrOGtjAFtI4Sgk6Pn4D5WQiWvzgv8zfDAp9yLrKGGXOFOXDkli8jV3TYFdbTNtXQIm730mzTxzcojO1ZihAymsCacyryjeFNOshSNR3+Ud/fAk4htlzyaQyJ0A5Kd2zHeiOb+Lt5xh5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776521812; c=relaxed/simple;
	bh=efQsQbQNQddbWKNHYTnYc4FSkLvucl7aDtGDuocfzEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdN2RInllY5MYJ0GggfiQKF/gr+8bTI2z4aCgwyfGEYke/BKyu9EanXsMccqEyYc1ll7UbZ1xDC6jSeZY8qLobeDfoF/2Vuhah+2ZU4sN0kxpvaQefYQ+kY8PYhdgjuFtvgxp1cLsYZQUr4lwtSFMTnXHyx8jghwbJGk4xT19WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vs5BNkv3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vs5BNkv3"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b8efed61so16317785e9.1
        for <git@vger.kernel.org>; Sat, 18 Apr 2026 07:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776521809; x=1777126609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q1H4R/i5l74uOyYXDkNfpFK32f1OdlbtdvvAXX193k4=;
        b=Vs5BNkv3+EFPNukRS4KJVPmRThrs2tYAa2jX7s8NTdBxoErBAhroY6GRUGsw8ruOSk
         jz97kG1WjAnImhXkitiJqkZIW8MuIBFB0r7X/Ahlg2GXJkWtRc6u59i18VGJtezQQemy
         3hCT1qThwteIkwR5f4yd7e00GyWTqekpNhEcexP2McdBt7qFkfXKr41suMgirn3OfBF1
         QrPTxIc+MAHY71C7Xm2/esHDG5CzkTu264mj/SxHTxehgW1U4Tt3c6kOPffDl+cBtwgZ
         fFzmLTKELjO6gfEXaNOGTZMeI2A57ckJQbUeBExpdUEYrX2Mbh85XNJc4FBmj3OuxYws
         Pn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776521809; x=1777126609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1H4R/i5l74uOyYXDkNfpFK32f1OdlbtdvvAXX193k4=;
        b=OvWzIf6vDoRZgDg12P2of/bKqp70QZ5F6GM+9jk5pqXPd5h757bncmae6a/Q0WleWW
         0jSoxGTS/ObecJ4xbJGzQJ2lP+ofLMFx73U4MlqZCmiNpasIblLGe1BaW6KIvws/EVve
         KgoeSFW1UYp37x19i2Bv/qFrcalPkndH+im/PYpS3fTMpNVLXto30HiyOMG7+SwDTfeO
         SV+DxcI+SWZXU/vHSP6FgMyoa4OXg690VZJZTgNTJioOHShi5ww5+81h0R5AHMRvb2g6
         aSTCZDvbUytv7iYDvoaPOvO3JGe9U0qA88pTfONdBr90UjF/LBm1Tjtnh7R/pghb042u
         mr8Q==
X-Gm-Message-State: AOJu0Yw3lDQNbsN3gGbplwelyRdD1W75sdC5QK1uU+kV8mWXmmMDN0XN
	xZ4i2WqTRh6ataMpfmyMZe16WWIWIYdxDOIASi3IXsXbE22h6eIo7q3NPmPMOA==
X-Gm-Gg: AeBDieturFxZ6QgopXRG2fRBBnqX37G4BEPfU4iIdZ/l5kUL4hkeVNgst/QumOLLjp3
	zDOiWB8PHNr33DPfnTfkQDSuSMogQPThjFX4YhjQU9rYdHJeDL/W/ywuzMFKcmUXWuCacQYVyuU
	ozeKwFE3+W/qPtrCIL/kV+XB3QkeWEu0IZz1QkRH/Z3jea0yatIUyxJYLNYmjKBaXWzHf058vGY
	VnFmJFr2WImD5KulSaxF7hI9xjVPcRDf5ykKSYdHdjxItb+WOV0wtM7Kof53vYnRk8KIoI7EnT0
	yd8Qo33+/yKCoLe7y864TsT0+rJ9xmTKpNQmKx2tyBsLp9iw9Lhlz362AoI88sEPqz1k2+LQB+J
	7BH4dE6antJzkPcGPoxQ80xonw4baGwfWH5gp5pymzjOsyfgm9YtLJO/XKrWYQzADsiRvd/Apzm
	J5qecvJg5dtofaCBAaitFVWSzlYpWY1ije6t9bhrZyQJtX8IcZx+azfHaueRKOhw8zk9id2RfPj
	gBBtjvCZ464ATg7m34=
X-Received: by 2002:a05:600c:870e:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-488fb84ffb8mr94342085e9.0.1776521808927;
        Sat, 18 Apr 2026 07:16:48 -0700 (PDT)
Received: from lorenzo-VM (host-79-19-37-238.retail.telecomitalia.it. [79.19.37.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c0354sm118855515e9.11.2026.04.18.07.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:16:48 -0700 (PDT)
Date: Sat, 18 Apr 2026 16:16:46 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Tian Yuchen <cat@malon.dev>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: [GSoC PATCH v6 0/6] preserve promisor files content after repack
Message-ID: <cover.1776384902.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>

The goal of this patch is to solve the NEEDSWORK comment added by
5374a290 (fetch-pack: write fetched refs to .promisor, 14/10/2019). This
is done by adding a helper function that takes the content of all
.promisor files in the `repository`, and copies it inside the first
.promisor file created by the repack.

Also, I added a comment explaining what is the purpose of the content of
the .promisor files, since this wasn't explained anywhere (I found
information regarding this only in the message of the previously cited
commit).

Finally, I added some tests to "t7700-repack.sh" and
"t7703-repack-geometric.sh" that check if the content of .promisor files
are correctly copied into the .promisor files created by a repack.

V6 DIFF:
 * changed the name of the helper function to
   `write_promisor_file_after_repack`.
 * modified the helper function to create the ".promisor" file, so that
   is not required anymore.
 * modified the logic of the helper function (as suggested by Tian
   Yuchen)
 * modified the helper function to check for possible errors, and to
   check if the lines of the ".promisor" files are correctly formed.
 * fixed memory leak.
 * improved comments.


LorenzoPegorari (6):
  pack-write: add explanation to promisor file content
  repack-promisor add helper to fill promisor file after repack
  repack-promisor: preserve content of promisor files after repack
  t7700: test for promisor file content after repack
  t7703: test for promisor file content after geometric repack
  repack-promisor: add missing headers

 Documentation/git-repack.adoc |   4 +-
 pack-write.c                  |   9 ++
 repack-promisor.c             | 194 ++++++++++++++++++++++++++++++----
 t/t7700-repack.sh             |  61 +++++++++++
 t/t7703-repack-geometric.sh   |  33 ++++++
 5 files changed, 280 insertions(+), 21 deletions(-)

-- 
2.53.0.584.g6b87e8e9dd

