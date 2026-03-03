Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8AB36C9F4
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 01:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772502350; cv=none; b=JGc4KryLr3Euzh0lreEbddXWHgAxa2+4LNhcxrt/oeck1mmHdavvWa7BqluNXzDDh4UQvk00nImnR5/Ubusxegc+R7yVjN59GTMvLy5NRyPzRnz1wxtZUoz+RStjwAGaWxdVve67sdJ4wC668VA++4julhSRXZV208x9Ozq5i+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772502350; c=relaxed/simple;
	bh=NAtpkUyg6obHBZZw4lNiwkC3ValgIOK1oeqgh+Nku6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9X7mpUVM9Ga/zUyowYPJgaKa7+DSnJWM3ok0h/0LdFbgvG4I4MgXf9y3vtEsJSiSBOLWjUhCImj/sRpBj5/jxIoIDlu4B2Hh9j7yPDcjtRdIPGvVUbzl9ix9KHnnLmBGMiiL4nQCxEJ5P/a0/DPnSVjv24JwHsJRUoIWYzspHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZCEesBX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZCEesBX"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso45301705e9.2
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 17:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772502347; x=1773107147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sl8mkcG0ePvSj7A3AqWR+GtiPPjv1PYqwv41wqlhFac=;
        b=WZCEesBXqHfRvBUXrekrKaPvmgZBGq+K04m+w6OI7PRUly+xq5sHL5GPbFw6+5bbCv
         1WJ+uvuyIaMFJmCbTxD3WcdQ72S4rdlD9NwmTLZ/1PwYvQcxlm5bgHEijBrs7vEOdmOJ
         tZNncHQVpjYZzVPm34lH2BBHDiXrzJjMUC5E3AlN3pIH5H139bWXG+sWBoqpLcUSSmE6
         7FYiVKab4w9m3JOXChkfJxXfgDO5vSfTJEuRg8fRparmgcZwhegt2+jY2TrRLPmq6Wrf
         XOGVXL6PF9LaeJ+eP92F6vcDEJrXS0S2ong39HEgQnDNu8YuVzTkY9Zl2X3md04HugMy
         uTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772502347; x=1773107147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sl8mkcG0ePvSj7A3AqWR+GtiPPjv1PYqwv41wqlhFac=;
        b=k9MrJDzQX3eZP7lisj5yIgcHvcJKsvwxba4WfA22YIRrOjU5oZS4LUVzqM3svmx6zt
         33yHNzOx11/sacD1nLKJpaISs87HNgGB975ZmBWnxAwrAgsFysvBBG3d5mHfR+vn5QTH
         sSfP2hmdzUeuAcujIpV6eTnE67PZshlwYRGm1CqpmcHfb2CW8jobQO9QdNtGP66AY/hS
         qj9X/IfPUtXIZ9dSNmBawwlhpQ+0T4ZobaPReEN2z+4iGbB6amzgFJas+oMTSzXdYHcb
         PBbAsOGEUYVNvalXf9KHJYKfRC0BiAo58500LtpdB4GOsiHVOP/TV4DZijoE1HlxU90N
         Tkpw==
X-Gm-Message-State: AOJu0Yy2RtN9oS5HVxC2KezUOxnhUqBKg7E5iQbUq3nqWsIHk4YIXyTW
	IXzoPu0Ocxf6eVDUbzjHGGzdM9nw2euVu4RCKi4JqJYnjH5po9X1dNs90cVK6A==
X-Gm-Gg: ATEYQzzmKWiuQDa1yImP6GnClyr75vkuMRwZkeE02boqXKjngSLXBz1e6m9jCHSUo70
	af2ydD1O2qQBshQPYUXZmL5iCC6ti4yQ9XW1jL80vy+9bOIz+wV1o813E/yYGwO3Dg5awSgqu7t
	vk60QveFxcbW2RpT/ZHSgJlXlDZmfilNb0jRq/hajeWiKOQ4UHuJ9dcIt98oSrE1snB0aYonL0s
	EKfXnYYtliyEpZ+27c+o6yuu0+z2NP0DPWLJyT9/Hlrhw5w2RklZYoqt+c1TBaKbRWkH+bQahGJ
	WM5wPQwfPWdCUX/AiLKJ8TH9pnT9UX1cHMzmwHBkZanCb21URUn96k3Iua06jA99Psrp3ZNcY08
	WqoFkUgO2wWm598HmE9IPMcGeEqruRGFDTViNG3CvyPrn91LrQoj5LGf4iJYKpkP1yh2LGNp7oA
	PjvI3taEPi0KZr9XNFXngNTQGc7saKEHKaLj4=
X-Received: by 2002:a05:600c:a47:b0:475:da1a:53f9 with SMTP id 5b1f17b1804b1-483c9be2ab1mr258402205e9.14.1772502347423;
        Mon, 02 Mar 2026 17:45:47 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485133a91b1sm3316875e9.12.2026.03.02.17.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 17:45:47 -0800 (PST)
Date: Tue, 3 Mar 2026 02:45:45 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH v3 0/3] doc: improve gitprotocol-pack
Message-ID: <cover.1772502209.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1772500189.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772500189.git.lorenzo.pegorari2002@gmail.com>

While studying the `gitprotocol-pack` documentation, I found various
small style inconsistencies.

These patches are just tiny, simple improvements, mostly to improve the
clarity of the documentation.

V3 DIFF:
 * Fixed final patch to properly conform command and process names to
   italic format, instead of the inline code format
 * Fixed typo that I forgot to change in v2

LorenzoPegorari (3):
  doc: gitprotocol-pack: fix pronoun-antecedent agreement
  doc: gitprotocol-pack: improve paragraphs structure
  doc: gitprotocol-pack: normalize italic formatting

 Documentation/gitprotocol-pack.adoc | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

Range-diff against v2:
1:  0d679e5eb5 = 1:  0d679e5eb5 doc: gitprotocol-pack: fix pronoun-antecedent agreement
2:  8a6b5d4c98 = 2:  8a6b5d4c98 doc: gitprotocol-pack: improve paragraphs structure
3:  6410967d65 ! 3:  2cf8a13eaf doc: gitprotocol-pack: normalize italic formatting
    @@ Documentation/gitprotocol-pack.adoc: two commands, or even just one of them.
      In an ssh:// format URI, it's absolute in the URI, so the '/' after
      the host name (or port number) is sent as an argument, which is then
     -read by the remote git-upload-pack exactly as is, so it's effectively
    -+read by the remote `git-upload-pack` exactly as is, so it's effectively
    ++read by the remote 'git-upload-pack' exactly as is, so it's effectively
      an absolute path in the remote filesystem.
      
             git clone ssh://user@example.com/project.git
-- 
2.43.0

