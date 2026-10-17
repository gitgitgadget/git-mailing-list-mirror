Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F119460
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239653; cv=none; b=IUGyTijL3yjsFNeqX2qMCt/O+si5FgCQVpaS6oVKakuBZ6lktxxUxiOQJTN7yaS0MLYL3wJr7sya6mjcpBEz5HbzqSdlOHQNSZg+9Ly4qD3u+c9xMTfPVxnyOxayh5u8mGk/3pl2XNIUmZrNMdCSkR8XSGChq+fO9l1JLLszyDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239653; c=relaxed/simple;
	bh=t/eaRQZmJE2X8LbWk4cJHw/BCP13dD+0Z3x0wQQjfks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmrIM02sOxmvOhtxkE095axXnE2flHeR70aNK8EnWH/HTiwykbMDva2XcWzYfZyTqzshlstRPO6TNH9qaddShiz1WoJSyM6Q0zFS/dabJJdIcBCWW+mVxyTidjx4DMHDMcKqoLdJWVH8pbDpDWPcDd5GMahVbJKOhYd81KVlzEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQhNF1uO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQhNF1uO"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48b060ec084so395031f8f.0
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 05:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792239651; x=1792844451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t/eaRQZmJE2X8LbWk4cJHw/BCP13dD+0Z3x0wQQjfks=;
        b=fQhNF1uOytqkWzzXsH1OlJceo1lH1JUuIbdk6n7PoiLUSrEUaV1+AO+FwADUlK+m9W
         TqAlv6Qbn7AFQQiGyqhk9UUl1WwjmaOyNqu+Yr9j/WFFMWm3CFdn1bTcGltfuL6KcXXE
         +C71K8btK1MEdYPcNFG+Fe+bRkI7V5NRQZZ+KLwwrdIxA6n6fczLVJgzGAMcAQW2xogs
         5RVLlt738cMPtsDUA5DGHT4i1C6DkMG5PfEE2fs+yAHfZtBpQOEvRhDzjVrAv6lLQMu8
         PXkBmooqIsHeFUdYDf0VIkPAzyC2+vpvYIFH/LmdqrPd1eLd90lUVIGldxhbEyRAvW+s
         TFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792239651; x=1792844451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t/eaRQZmJE2X8LbWk4cJHw/BCP13dD+0Z3x0wQQjfks=;
        b=Kl+9cOKCmjJYbhz4yffrqxr+0sG+E8HsmkOVcCZqDiyeY2TEW2l1dhMxFNca/yaUa2
         v1u/oYQwNdHXRErK9n2I1EfVVr3yPRcD1emT6G1k9TC/EMv6SEfEO6k9UXbXWecEYDA3
         3vUb2yaCEscD59HkrcTqaZZV39cUw6A1O8QfVYuaWh+MWjkNEkcvSMJEYYXsqfEnLeyD
         RRLYd6dQe33YDKy70vtgKq9A9mryxkB67+MfYHDCkgsIm9MF0GtVuVQQVptb/9v0CvDU
         d4uZ06oW+TPjUoIdJ0E9dbkAcqyQVETXXWBputp3RNTXoHWNqyO5knSFN+siuzjNHnhu
         R1YA==
X-Gm-Message-State: AFq9FYLVrdy1XatRtu9icgBWuuaiQ1JF4Gn8cd2p3uWBswf42txPCvOP
	S51NaAvFbe7JF74WRDoBGtIqQHNhMeRYAOLILEuAcPhwk4tPnkxixGkv
X-Gm-Gg: AYBFou2AOXSc3BrIbKNFHT7uI4VscXoyEfXGtFC3CyEZ/hj3kSwcYKXFI10P+d9Q2+k
	4nc4FpZ0BERhPJFe79P6ljKcTKHzclUp1MeRS1wcpMKmr30YA2ejnDU7vIR9JUB1yn5Q3TkaFUc
	iYlFQhAJUvPKzWFi2XHUpd0YUdUf6CeVgh4LTeMik8vlz1gvkauNa6rOoqj/REJg+SFIqnoBkyU
	x7odc9qUJcbPayq5btj3v2FDEl/fExokMLRhp/v8FU/hU+R10s0J4RiJ8tLAe05X5bmXFhnD+NW
	N5ZSjJKDUPmio5JRZl+M9gJc6+qxJV/JaX95foWys58VgiupsuFZNHY7378Xxks8XFBzA0Xux3X
	M2cgfArX8E2bYH8PMSCJtZMzTRrcmmzMRhzKpQUKGhnNpS4o6ZpTi7ehguusO8aCcHTPXEDfSKN
	JeheeVGGrFcGzMzlYRc2Hm5+ZOzohvLVgDaam02ib7k0fsO3VFBAQclD0QQ3+FuJUHkjToQOWTi
	sNzK0tbTnLJg4h6nFdge+k=
X-Received: by 2002:a05:6000:2c0e:b0:48d:f1b4:38d1 with SMTP id ffacd0b85a97d-48e07f9fc72mr4731222f8f.35.1792239650482;
        Sat, 17 Oct 2026 05:20:50 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c575esm9711732f8f.10.2026.10.17.05.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 05:20:49 -0700 (PDT)
From: kerylefondji7@gmail.com
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,
	christiancouder@gmail.com,
	siddharthasthana31@gmail.com
Subject: Re: [Outreachy][PATCH v2] builtin/var: refactor to use parse-options API
Date: Sat, 17 Oct 2026 13:20:44 +0100
Message-ID: <20261017122044.568-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1a146af667a8bcd4>
References: <1a146af667a8bcd4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kristoffer,

Thank you very much for your feedback and pointing this out. I will fix this immediately with my correct email address for the next version.

Best regards,
Keryle
