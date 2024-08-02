Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD351DC47C
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722598219; cv=none; b=Qpy/i2lo4aLlbi/8VfjbA/OVpk9KMw+b8K4wNLpr7rRWs81pVejA7Aj1HJmT2iMD3mtrWcYqMZXt/gI61WCJO+9xUrDk4b4xrlvkGbhg4fIOnD0yuUXdRf463EeQvaCcKwCPeBbRx+ygSZihKvsI/01dZdulUaEJr6XvebP0YAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722598219; c=relaxed/simple;
	bh=NvDMqULdHon7dCrQtf4EhfHDM6KQy3K+cYbnleoeVUM=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=W/S9uQQheieJPWN7jLi9Gn8cVWl+2njxBq8cxVujfFr41nSNrVXTNVGdWII9bIRgfRolkTzaTsOUwaa14lyVGWwTlNRi+e8ZqhcCX7kvq4dUuwiVkU+wQ5DAUpAt6WfJiK8plqHYWMxHP0D2dTOKzp+hCdEsVY/iEPizjY5PF0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mouldwarp.com; spf=pass smtp.mailfrom=mouldwarp.com; dkim=pass (2048-bit key) header.d=mouldwarp-com.20230601.gappssmtp.com header.i=@mouldwarp-com.20230601.gappssmtp.com header.b=TUQKfSIE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mouldwarp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mouldwarp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mouldwarp-com.20230601.gappssmtp.com header.i=@mouldwarp-com.20230601.gappssmtp.com header.b="TUQKfSIE"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-368313809a4so1814882f8f.0
        for <git@vger.kernel.org>; Fri, 02 Aug 2024 04:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mouldwarp-com.20230601.gappssmtp.com; s=20230601; t=1722598215; x=1723203015; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NvDMqULdHon7dCrQtf4EhfHDM6KQy3K+cYbnleoeVUM=;
        b=TUQKfSIEitPDc2e/731cG7r8JIuta41RFkhfesELw6L5i9I/qG/Ai4Pc0vQL+xWhYi
         C74+UkqCJMMa/tk99sGbqkOgLOZboPZtJN5MkkOOShEzaE020kfwhFtyYiWwt8eFQCud
         vgCcXtH3CijG5wjDRyK89/FmGf3GBE0GOnwAsnUjcI31b3R9gPeBDRL2AJeG6wGfx3OD
         yGZfMEoFMUMf2NJANi5oQZYZmJWAe7lstseJSv5qwfdwW/dpnqwKw649yeAl8KhO3WlB
         jYCxaVzR2WrTNavDkvURn8cNo/pOx787ybuVy0QTPWJ1yezaf0cN6l1ldn0t6U5/2h4t
         Rx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722598215; x=1723203015;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvDMqULdHon7dCrQtf4EhfHDM6KQy3K+cYbnleoeVUM=;
        b=qD7cVq/8y9eQCbgu4LRrAt5ABm93Oyjc3W8wXwPwv9t/n35cM0qWRqHP8rjCeFBriW
         AgBfcA4FVUEUu3ND3ri1rMbSOY2HTayc43QTkK0Y3t/hZ9E5RPuTiPjBHvFNQkvgtdmU
         SL9P4LNkE/JHuLwagy38kPgC5FkvK0tSSDeChKLtKkhu7yuWmUEjRLQHgFF9zFNheU8D
         2uc+vT87IFQ5H40Y3kr3i6l0JK699kjeYVdpv4+YAJlI29eUEscrc8ZsmRAOlHosht1Q
         0lH3TBSI0nUjM9o2KNXm6JD3UPnaX3H6BrJtm5W6WC9LNO+v/VSDR07GsSmlYzLsTIzz
         +TOg==
X-Gm-Message-State: AOJu0YwPDQEzx0+hOLhDGO5f3AneIEC65Pry+jInyQQEAHqoNimNH27A
	ewYPFtmc5snFhSsH2PI99+Ba9SJNceS5i4bFQlLQbKIU3Fncz0nVStDFSpls2zBRe4wuxZaF+Z8
	=
X-Google-Smtp-Source: AGHT+IGaizxm/JjwKA+gX+vsPd8Y9XPAO5UeD2qL4Xr+L+F2Rnnq5jOE9M7y6dTqTgYJvYbFzewwvA==
X-Received: by 2002:a5d:4844:0:b0:36b:b08f:64b3 with SMTP id ffacd0b85a97d-36bb35d2828mr3481897f8f.20.1722598214591;
        Fri, 02 Aug 2024 04:30:14 -0700 (PDT)
Received: from smtpclient.apple ([2a0d:6fc2:5f40:be00:588c:c93d:e795:99f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb6405csm91480115e9.34.2024.08.02.04.30.13
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2024 04:30:13 -0700 (PDT)
From: Costa Shapiro <costa@mouldwarp.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.8\))
Subject: git "security" overengineering (reaction to safe.directory)
Message-Id: <DDA0EFF6-64F3-48A4-A99F-F0148FC0BCCE@mouldwarp.com>
Date: Fri, 2 Aug 2024 14:30:12 +0300
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.8)

I think the breaking feature of `safe.directory` config -- within the =
basic CLI
is a dubious development decision.

The thing is, `git` is fine as it's been for the last few years, and it =
doesn't
really need any features, especially breaking ones.
This is, of course, boring for its current maintainers, dealing with =
just
the bugs and optimisations, I can totally relate to that, and I'm =
forever
grateful for their selfless work, still, sometimes, enhancement is not
the answer -- but instead, modularisation is.

So, I think this *breaking* "security" feature is a bit too much now =
that I've
stumbled upon it for the second time recently -- this time, within a =
"ruby-git"
Ruby gem suddenly failing on me (as I'm sure there are many =
`git`-CLI-based
component's users being confused and unhappy as I write this) -- =
following years
of being a happy user (and an actual promoter of healthy git-based dev =
processes,
see https://medium.com/@costa/git-decentralized-a25f00fd2955 for =
instance)
and I have to speak up.

I know a thing or two about security, and one of those things that I =
know is that
you cannot improve security for ignorant people, unless you
either (a) really restrict their actions, or (b) properly educate them.

The reasoning I've seen for this feature that I've seen talks about =
users being
too smart about their shell prompts and being too stupid about going =
into some
maliciously crafted git repos' working directories. Well, this looks =
like a very
specific (even exotic) case to me -- for bringing a whole new aspect =
into
the core git functionality -- especially if you consider the vast (and I =
mean
*vast*) majority of git usages. But even if we take this very seriously,
and decide that this should go into the very basic git functionality
-- instead of, you know, easily wrapping `git` within an interface =
component,
CLI or not -- with this aspect taken care of; even so, we won't help
the ignorant users, who would just google the "dubious ownership" error, =
arrive
at the common advice of `git config --global --add safe.directory '*'` =
-- from
the search results page, not even going into the source info web page -- =
and go
back to their "insecure" comfort zone.

To summarise, I think that this "extra" functionality (and actually =
complex
security aspect in general) should be removed from the basic git CLI.
And again, kudos to the maintainers who are mostly just the best.
