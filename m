Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86DA41C0A0
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467790; cv=none; b=GImpBISB/EQIQ6CPTzF7nIz1tOaNJi4yKEnw5hYlNYm8yjXhoDP39qIdMm9LNO0NeijWd9kL/Fh3+mbGFyxUEmRMR9ssjH8XMuMX5U2OO5fJwsecJ88hLdRMsSm6LulqtRHObH8P3iq51S0/agFVWYcD4+eZ3peQqa8QG8SxHdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467790; c=relaxed/simple;
	bh=mDhqeAUOJpXtAwDBMqam/+cVXTMgBgppHkMEQpVFj3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OXIj8BIMsbsUH3rRS2YibcSwhaOCtgzouztU8WFtClZrFxeOEfwpiz4bPszADBQjF8Aa2Ee8E4o3iv6wPFCrBHGu+fxCDHfsiowvBU/3t1C9Bp1k5odEqu/PaPch+kx12KovN4iWx3jwGi8xhX/hmeWI9tCFXs4Wel30tyxzxb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuqLZFtK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuqLZFtK"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so52610875e9.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 08:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772467787; x=1773072587; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NCyELQJmsESJDB0XKTCts7o/DbbDJxIHOGV0h1xmaEE=;
        b=HuqLZFtKMj8jggPeziDc2crZRnwgdUVPUlU9n40SoJglFyGoeIX84tDTYLocJoUtwH
         jMJV8EVQf6AU4GFsJSbYRd1PgqHgp4E8K0owS0PScc0HXn/GjHilGteakV7cgj2AA7Wb
         Mnh6CE8V0VK0miu3TpZE7uNQ6wK+s9FfO3w/6j7hWZ6WuZscLic09NHS6v91GXUUAV7L
         Ojr/h8cvxBdPO61Rtqd+eqQCrYLiQ95p0TEFQAZl+ykbR+n/LLMqHDy7i2xOHPtwM/TX
         /QEKPlRmztaljPcayd4FDlvnS/T8Vno1g0qfuF9bBDnNDULZfr8IfvK066S7RSwbRm13
         VNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772467787; x=1773072587;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NCyELQJmsESJDB0XKTCts7o/DbbDJxIHOGV0h1xmaEE=;
        b=ee2MRNWUgbR5E4w8qPy2Q9cgk1S4Uvw4b/8D3sNw7pOHRDhRZ+M+l03rtq9FALu4Lo
         8InO7xS7VeSMb6H2NHev2WkbriXCw1rwxJl3lpifx2JMkNQHlvPKKqnS3QlUMTRFs5fZ
         v+IALJVk/VtJKI2c8BnFulYZ2tZDs+7IrsmNB2NO7F4OyBxwmeG3/fYwEhuc/dk97Wn7
         0XpCUmt+qg8ZRTlTEcXC1mRRzmi1wQbvNED3hs18bh1jNlNRGt16BjwKV1wko8QTPBjv
         Q8mPtuSxdn//Jxciw+P5Ta9YUp9uT9WuxY32TT57efknASTBuSxsY47n6iNJVas1lzSF
         Jcqg==
X-Gm-Message-State: AOJu0Yy+8ZsMNfANwOD91IGZMjrmIkjtCEypK8ZGiczPXHPhdg8KVdmJ
	n9p4ge54OY9h7loRIEB7k55Ce0bXCqs+1c9uizvaZ4sFLKI2AY5C+j0mizIHVA==
X-Gm-Gg: ATEYQzy3kw4AXzrXm5FcpGSR8buo8HfVZuQnOX17zXDy+i2wpkam93PZb4kKm1cm2EH
	hSONvcEup+j3mIX20lgRXEO8R4kKYsTHuYdAShfrtrpvKwFz8IPf+0SknrxtRQPAEUD/zta+suF
	zYS8mnnepkHmfL+HTQPTDZP6C9UjsbEByTCTgqbi7Wus8r/2lAYJU2qp0nJXd2tYyMWB3xEGUW3
	Em9QjRgmGExhEo8WpojsDSPluvcFtcztF9xYvjwZf+d1gGh9YS48veXaCfmiVFDKeyExYa0wV5y
	FQM04ELUwdr5DROC+uo1x3mC2KW2UzxCQPf/w5kiVAMeKBJFnNe+jdCz+yC7QWOdqZNEfbx2ySo
	gT/RBlg8OuL6CKxfN5QIn0X/L12OH2K9usj5cBxMMjSHyeIDie9V6HIW412cUFJzmXuleFjBw8b
	n0/Hz/QcgHAErd9zGVxMYy3obWp4Pe7jawcX0=
X-Received: by 2002:a05:600c:3486:b0:480:3a72:524a with SMTP id 5b1f17b1804b1-483c9bed89emr256020575e9.19.1772467786248;
        Mon, 02 Mar 2026 08:09:46 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f26d7sm433981145e9.3.2026.03.02.08.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 08:09:45 -0800 (PST)
Date: Mon, 2 Mar 2026 17:09:44 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH 0/3] doc: improve gitprotocol-pack
Message-ID: <cover.1772467050.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

While studying the `gitprotocol-pack` documentation, I found various
small style inconsistencies.

The patches are just tiny, simple improvements, mostly to improve the
clarity of the documentation.

LorenzoPegorari (3):
  doc: gitprotocol-pack: fix pronoun-antecedent agreement
  doc: gitprotocol-pack: improve paragraphs structure
  doc: gitprotocol-pack: normalize inline code formatting

 Documentation/gitprotocol-pack.adoc | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.43.0

