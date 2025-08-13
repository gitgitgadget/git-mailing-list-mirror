Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E052FF4FA
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119902; cv=none; b=TAQNTaN22QYnaL/vlb0dCbkx2coRrUTf9VnXMBw30spvsHMwZNucrnNbQVUPx3Iq+za6Lm8z+EtmE9boqldHNu0URNCm4mw5NkRZkzplCj2t3tIeJPM3nBG2XaO7FLzis9i8Ql6WN8jWtL3aKvQk+YjJ2e6/w/2jFJRD2Tioi+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119902; c=relaxed/simple;
	bh=vVdom+4/t5WLjdKZASIFrHnMYwJWwe4X1bmcXX5AWjc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uJuwqukEbFWJQt2qz1ipmkfvPt/I+QanFDDF5eokj+I0GdarWH2cnpGd4zhLLPM4haXTvjAVPYWYhz5dOjvcgDojc1FChYRYJ8WVnP9HZELyQJIt9TE5CaAsbUwC84UJgZ3+mRbCecZIu8us/piHrtlDLLrgRDJ7e87MGcteEXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVH4EiVo; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVH4EiVo"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-53b17378b74so142045e0c.1
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 14:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755119900; x=1755724700; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVdom+4/t5WLjdKZASIFrHnMYwJWwe4X1bmcXX5AWjc=;
        b=TVH4EiVoqtFe5Kz7tauq1/TVEpgFiEJ6GEoVLGLL5yklTXat2IB2QeH/6kdK6xQzVl
         tIxtaMSCR+kwLXJhiCSFsgOFTS7T8E1G34iUWwsirF2epivz1ISe0Y7kOuB3sQiC3wME
         i2gZHyALHlVxcnKbYIs9HDYfxo1SDrgQ2jf77/FR14QOIHWOcuHooIZxfPv5cYFkhpJ/
         d9OCcyoFfvvpk+x9RNLNqd0373lF+3UUvY/sSKlpKjhMwLq82COKZt08OWgu/Xu5J5pP
         tiPhgKo1vZO+6cp5tbsHIBXXOb0MPKrXNfDJStryosI982NY2yqRvXrYvO0mtMCDzaeY
         Mirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755119900; x=1755724700;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVdom+4/t5WLjdKZASIFrHnMYwJWwe4X1bmcXX5AWjc=;
        b=aPoJ7XIk0fQB5QkbTAqeW8mERRA0mxwbD4pxLJcBkc776djvw4Ga9zzLvSiSAUUWKm
         KbdSICRvSu44c2tzYsraNH9d4iQaIk9ly4Y3kccYKA/2NnbZtCm6yC+BBPh82CQYlii2
         zVf5Qevug9iU229FBrZu2U1GqBJJUUEeXaRif7yW2DfX7BryDB6sxDCGSXFGXTY2eLQ0
         jDBUqMPcvStlwURi+xvgqUkK4NcAkobQ1ocYaK8wpoiX4rHvwdmQGdd4NhMb59ymoKsQ
         zROVQk5973jGwTEEdIjStqNOn9lGiNVc6K0wqKBntKtthgbXkhwdlHxjmoIHO9dJo+i4
         vLrw==
X-Gm-Message-State: AOJu0YzEh8a6RefkmBVx4LlcGg6yF1ihEpMlirQ6RgKsLFVS7NsX84zp
	+d7TdGonLC6bxTW5og9cbOPDbsuSalvykLB8+T2mubPEoE8HGMlLhmQd
X-Gm-Gg: ASbGncvq44MpuF4KqwurgwspGHB+1rEbQAzme+dy+/aBBJUTcyzRPl2wsctsR0gNRjx
	eMiEbzkTu038KTgcE2xUJZMuwjrNluwXPiXOCQc/ca8VeBZaPKmAfvZ+RRM3rtLZRtLaGIE4lGf
	IDH5DPN8KrV1pVCZWite0WKvkUEtHw4Wc1FNXV2X5j7m5L9KJHEYt4kGYgt6HQOE+nvP4Tir/pd
	IyrTYEc4DDfMQpJMjBdzG1Bd65mR3lkbOqDP78jiX709zraocYWEVPROMz/hs+7oEkeRBybuP50
	GJt1qIOVYh6AnU4S2zWeTwDqtm2kiFQ/zhjnT5L2phAWVf9nMb/vrxX9OgtAhJu14SRvD+0jqDT
	rKRPALz+7+aOfhv+hF7FoFuJ3+HzKpqtm2dLgzPkBkqLDUSkWLGLdWGD7
X-Google-Smtp-Source: AGHT+IEK4Yr2ppElo1P5/JrowyMM5xkJGDxW1zcwd9ZhycSLBkJ8pXQp4zh5tP5laBUaYmI7boDkKw==
X-Received: by 2002:a05:6122:200e:b0:539:4669:5626 with SMTP id 71dfb90a1353d-53b18ad534cmr195296e0c.7.1755119899776;
        Wed, 13 Aug 2025 14:18:19 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-539b018a12bsm4175232e0c.6.2025.08.13.14.18.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Aug 2025 14:18:18 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [GSoC PATCH v9 2/5] repo: add the field references.format
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <f97b712f-95a4-480b-8ed0-174e4f45ff81@gmail.com>
Date: Wed, 13 Aug 2025 18:18:04 -0300
Cc: git@vger.kernel.org,
 oswald.buddenhagen@gmx.de,
 ps@pks.im,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com,
 jltobler@gmail.com,
 jn.avila@free.fr,
 sunshine@sunshineco.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A30D2A7-3290-4E7C-BBF5-A51AE5AD19F0@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-3-lucasseikioshiro@gmail.com>
 <f97b712f-95a4-480b-8ed0-174e4f45ff81@gmail.com>
To: phillip.wood@dunelm.org.uk
X-Mailer: Apple Mail (2.3826.700.81)


> What's the reason for this?

Basically, filter out duplicated keys. This is also helpful for not=20
repeating the same "key not found" multiple times, as suggested by=20
Eric [1].

I could also use other data structures for doing that, but I think it
would make the code too complex without having a real benefit.

> If I query three keys from a script then it is much easier to parse
> the output if I know the keys are going to appear in the same order
> that they were on the command line.

This assumption would be a little bit broken as one can ask an invalid
key. In this case, this command will print the error to stderr, and
proceed to the next value.

> If the command re-orders them my script now has to check the value of
> each key which results in a bunch of unnecessary string comparisons
> because it cannot determine the key from the position in the output.

In cases where the client don't want to compare strings, it is still
possible to ask one key at time, just like other Git commands (e.g.
git var, git config). Since this command won't return too many values,
it would be ok even if the user requests all the possible keys.

> While we were producing json output there was a need to de-duplicate
> the keys when that output format was selected. However, we no-longer
> produce json and in any case de-duplication could have been achieved
> without sorting the input keys by using a hash table, or, as there is
> a small fixed number of keys, an array that records the keys we've
> already seen.

I still think that it would over-engineer this command. If I follow
this path of returning the values in the same order they were in the
command line, I think it would be better to just allow duplicated keys
and multiple "key not found" errors for the same unknown key instead
of increasing the complexity of this command.

What do you think?

[1] =
https://lore.kernel.org/git/CAPig+cTxNUPayO2SdCL-BPtjb2rfr3e3RK=3DBsQxAiiE=
AtpBaRg@mail.gmail.com/=
