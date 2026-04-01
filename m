Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7738245008
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 04:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775019587; cv=none; b=qKKHE05eDGLALT8m5M3bYDHV60Y319xdlqefvRePuJZjyAKVn1Pi8L0MWoTm8h1MQPETLLX9CjTvGr7oBvumISNqAjk/foBxAjeNadneIWpnmO6anvgLeICn4czt2fpwmB2SAweHKNXRjs38MzHeKZ5c5RCBwgnjQNCmpwW7x6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775019587; c=relaxed/simple;
	bh=0KpSutmtCcHy8enu92y0GCUWkX/qM1p0TOiImeYgnr0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=rVkcWrt/Ti4rF5r7pJALa57wszVwdQhgSjZ3OEdJXBfFj+/Que4mnqe2+fTV4VkwUYIwNuUk43q/U8XCjL+toiSTJ44ui/tKQu+pfm+85r8VfSBzP9pi//I/ATR/aamHQGy6JQvpL48R0QgPS00fZuCwVkL6IILyKKpzXb+BWss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r44DOjcm; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r44DOjcm"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506251815a3so54517271cf.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 21:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775019585; x=1775624385; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heYR0vh2XnCx8JYfdgnYiSVOb+tm01femwYuX+Fb5s0=;
        b=r44DOjcmxikKyJUZXtgvxhEeDZ5CrHcJ3X2S/20Uscbva3UAoJ2xkZa2m4GhdhxzaY
         KNL/LEgJGnlTMbV+06EwfF+XrlQKfFz8Z2o2EL/fnOnRjYC7cN6AJUPcO+s8HlYnHXMK
         l3gDeAg5SkZbrC0PnZO4dxT3bcBf6/aFWiRKteSeCVfQMj69M238UbSjnclZFeq83RXh
         pStMw6WS0esdV05X5WfMeVnrojFSrZlHfJcJoMHXOyXySUlEXLneGkIxk/spNOZmvq4D
         eoRw0Ykw23/aWdAENuQwNpao999QlqQxYJKEDBdWmFMsDm8LZM4qyIkU0d0bvrdEpoDG
         eotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775019585; x=1775624385;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=heYR0vh2XnCx8JYfdgnYiSVOb+tm01femwYuX+Fb5s0=;
        b=odXBJ2dkved8TtaMJgaZKrhZQbmW8S1bZSuLf/0uPJxTTEFolAPY3ZpMltDF7XLJOy
         UN7qQEB8+2hydtMyPPo85QvCxGioohG+UGXVwPjEhgsQWGJNCA+tndl003rDID02eIhF
         qHSxl/shrdLg79hlDSc/sIrtb6WvEy6xzJDo/1GFXRWsH0zxJ9RHxXBWg9NrzxmxU6sL
         PgYnktYt2gp4rHKQYJDmgmWo0zTME8I3JAaYRRfRsYtfargZjEWCaC489xXFb+goSVnR
         bebbPtGmpUK8Bqev4eA5B1Ps3eQCQdSu59W161WhaTVoAp1Bo8riniiYSBAW2fJ45MA5
         syWQ==
X-Gm-Message-State: AOJu0YwSNWOoZt2in22Ya1aAg5q6eT6IrYbGZekV1CDPzVovwsx+LSPs
	QtsjMR1XVnMs2hhxxw+Z8Dg3AlaNU4PcE0MhlQy63U0xlSoq77/owU5Dh+katg==
X-Gm-Gg: ATEYQzwnNa1cN6qXG3xe3i19dyc1KfWIxJjCoaZe5oWLUOyZVFAMs3ZtEazwzGJ0waq
	LpHM8CL4pKPOR9V8xZ9gOhtTWHLJfZAFei23XMNqMpRoqD4ZtE/cu2xf3dIkwqxCMT2aU0+yAOq
	QF2wvsyz659gwtCMJEOpM5XmmO+xR9E/VHAwnXWSD+BsJAqLuA8dWFuxyWLPOAS3PzfeNHNaPgV
	/SWPL2iWRxRhaL2RcHWS6zO/riqCnWw7brJF7fKVYBBZZ5q552xaIobk1Jw3+XVAiljAGokmmaW
	bdIyjxXWMizjqdJVza4CfxOxf4+j0eqM6VlzkHQox9tOtz9jAFrm0qosQmIfY5tiiquU3jNMVh0
	Z+r46PZ0YKRWl2K5c4TLkGG/gCsFKrwl8LHMX0aaUjp46tXNJ+2WBb7pDaMDSPOfZRPhPCofzCp
	UsorFrRKIs+fsqwC2SzJr6rBKSLf3bv6FPbPYMAmTJ457ydwD1t7pqa9YSJMuyZG+9j3xSuRgzR
	Q==
X-Received: by 2002:ac8:5e10:0:b0:509:23c5:3289 with SMTP id d75a77b69052e-50d3bd72949mr30319011cf.63.1775019584800;
        Tue, 31 Mar 2026 21:59:44 -0700 (PDT)
Received: from [10.11.12.14] (pool-100-14-160-128.phlapa.fios.verizon.net. [100.14.160.128])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2dd640dsm120858581cf.19.2026.03.31.21.59.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 21:59:43 -0700 (PDT)
Message-ID: <d8e13917-951c-4bde-8c03-851d727b2e18@gmail.com>
Date: Wed, 1 Apr 2026 00:57:54 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: me <sandidge1@gmail.com>
Subject: spaces in filenames
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[https://git-scm.com/docs/gitignore#_pattern_format]

so, there are probably a hundred or more pages where this question comes 
up. The URL I included is just one example.

Ok. fine. there might not be even one more example, but:

the entire tutorial uses namespaces that do not include spaces.
and since the real world doesn't ever seem to work that way, I feel you 
really should include instructions on how to deal with it.

I don't know if this will work/
"or if I should use quotes"/
{or some other arcane method/} :EOF

to delineate that my text has spaces and I can't remove them because 
users are fundamentally tied to written language syntax.

and your documentation, on your own procedure, doesn't help.

worse than this is that I was sent to your tutorial for help, but from 
different software that decided to use your process.  Now, I know you 
can't fix them (actually, we both could; it's jellyfin and they are open 
source, but one step at a time). But, please, can you provide a little 
more clarity about how Git works? I mean, I use git and I have the 
question now, I just learned about it because jellyfin is being lazy.

-m


