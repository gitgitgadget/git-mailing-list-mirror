Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401E9B67E
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768766330; cv=none; b=nb2ANHU7AYSW0wLC1GVi6aJk3SH4/7K9NtnKQ29GPhiQGefFNUlZiteX58vU3LoySe6KnNKrIQgqO+vrFHCUzSJMS/H6YtIDc+qghwT2Dak9OYlzb1GjUeWKOw5QJeJCbow0NYnWTkRVPCdlsYt8H8cjqxeMlvbRlkumTKFNML4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768766330; c=relaxed/simple;
	bh=5naKLx7KBYf3DEIAEzHo1wb1uoVd0EVxsMBd8xsZ59E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgQpDeNyd4HUot7rnWBF+HZdgIDcYKDMce+HP9hdWE63t/VTGS2b4fjBPSptuegi8w9d2VY5YVv61i/2Ae0jXktLW94RFJk+IZ+pEdChtRUvudD3Ucsux4rSvmmBe92bRD+vsruRkyexx7xeo4cnmcvYS3Mr71obYWXt2iBQqoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJaKip+G; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJaKip+G"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38320cd563aso44296891fa.0
        for <git@vger.kernel.org>; Sun, 18 Jan 2026 11:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768766327; x=1769371127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUf7hEiT5DnpdNgxbtSVXnCQGt9SOEX5m1TrUjEhuaU=;
        b=nJaKip+GcFS9sts9Fwa4LWfQWW1KifTo7RgF8ywKPYUE7w/Jo5eztQ0JVNqm1bu473
         3O+tEfvZMPDEQCvVe4lBlg/Is2Tcfk6VDgQoarfWH6N1J0uVsr58D88dQ5GWstSZQwfT
         hsvVBoi1VvL495yvH24gQa/0bMyTXUkc99C1b/FGfOaOzry+myndWhFjL1gOeW+tFMn4
         iag6hRN+KwL6sdQMvrZO1+IpyrNbmKws3GPToH7kaS0cUSmN15yt+yvkUcCEy+vFWrcn
         zTVJOsBhoa9naqCWceADc4HCkRKt8XNUA/RktoQodaUmXjPQdYo3VR3/soBCjykFzsw8
         aG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768766327; x=1769371127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tUf7hEiT5DnpdNgxbtSVXnCQGt9SOEX5m1TrUjEhuaU=;
        b=HGJvIrKxOR5hAowNOCF+BgnO49XLoKdOj2Fmu6F198tAAKsh5svSCG7SwXPl+aD3A6
         iI8MOq2z/cTFH5aGbBllEs4shVryEa5uYzPXpDwlF/I7Shsxuwz+iIRXJcqAkV5KZ3c1
         SajyOZyLMURBAB3etWZ0zcqV407UV+DrydSzyejkMNI1g4RI+cqZOax5PhG6OPMB3PFk
         x8NIGzf1+goRUiDco5H0/a0nNFp9j+nRlL8UVMaku0TAqo65OjAqZX+QLDAZ8/poedgj
         Jxcw0McUmq8GjOD0TpsEA25cD3rRLLrNaHkUdUmv3daBazD7p2bE5hSarTJk8JoER9b8
         apiQ==
X-Gm-Message-State: AOJu0Yyl9BbGDWDDQ7txdDniA47jMpEnlMCT1Syf2gFKTnni18017AxD
	+iJMvLWHLTq7S8Va5hlMhesk2dB4MoxVvJcBAZF+XXXVRYtOES6ap8zG
X-Gm-Gg: AY/fxX5295sN/U8YAMp8lx6CZgvtw0t+A/AWsBBNpKigc1mwbvEYx+5Ym15Cf1HUezb
	3LvVnjNz51V8zxqIq9WaifGq8PnQiabdC3FWrtDsL+D4c+x8dvEbMod+T9Ew2i3isqt+lWpQP6F
	D8638AlyvneXyd2Aj/Luhmw8ln7wdHEOnIHhv3sxQddcXhrR9XJvfK0LQz6L9Zt70TbZPLfgn+4
	jw1eMwvHxGzLbbpTWALHNwn8XR/kbEmi2mwUuFg7ITCCovE8016XEQvwFNt+BZuk5GVc8ds1Dxy
	wOprDvPU6UlgrPa8MuTLM4eyJriihpwsk/2mYZLZHQLpzSsEPz4v0oUbccRvwaCKW0CqLSWsPif
	bdMKUrUmJXzQmhL0qLgXR/DNBSPBrhInv6sOEjVgcyGFlM6Y693OhXMWXAcY97bSf7cKXvXMXLs
	+JfKWcwSaUBbjimQl27fiuApVUCcmZx+gaRIcwyqLWIris19fa2YwOZB5HlS6z+gU9quH1aCo=
X-Received: by 2002:a05:651c:b0f:b0:383:1255:9240 with SMTP id 38308e7fff4ca-3838419786fmr30947681fa.13.1768766326904;
        Sun, 18 Jan 2026 11:58:46 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384d78a87sm26145311fa.11.2026.01.18.11.58.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Jan 2026 11:58:46 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net
Subject: Triangular workflow
Date: Sun, 18 Jan 2026 20:58:45 +0100
Message-ID: <20260118195845.16908-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqq8qe0f2iq.fsf@gitster.g>
References: <xmqq8qe0f2iq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > And having the extra output from "git checkout" is just extra noise for
> > me, especially because it is easy to see only the second message (which
> > looks just like the upstream ahead/behind message, of course) and get
> > confused. The first time I saw it I thought I had misconfigured
> > something with my branch.
> 
> It now is clear to me that this should be _optional_, so that those
> who do really want extra output from the command should explicitly
> opt into the feature.  After all, any optional new feature that you
> must opt into by definition cannot regress end user experience for
> those who do not ;-)
> 
> At the same time, I suspect that extra comparison on top of what we
> already give against the @{upstream} may not be limited to what
> Harald implemented (is it essentially the same as specyfing @{push},
> or something else?).  I wonder if we can come up with a flexible and
> extensible notation to specify what branch(es) to compare with, so
> that we can use it as the value of this opt-in configuration
> variable?  Something like
> 
> 	[status] compareBranches = @{upstream} @{push}
> 
> signals that the current branch is compared against these two
> branches, and not having the configuration (i.e., traditional
> behaviour, which is left the default) would be equivalent to have
> 
> 	[status] compareBranches = @{upstream}
> 
> or something like that, perhaps?

I'm implemented this now. Please take a look at the latest patch!

But there seems to be a memory leak that I can't figure out after spending
some hours running the CI over and over.

Harald
