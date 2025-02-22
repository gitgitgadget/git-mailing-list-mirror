Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57163224
	for <git@vger.kernel.org>; Sat, 22 Feb 2025 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740236495; cv=none; b=l6P8WIXl0MJkfGCe0DtNrCpb4MWz7NZ82Vq9RW8oDPPIanrlGjXfEbsT4c1kDxnCAe9y2fk7FvmFSK9IkWlgTmN2JdgEMpGQTMT8ZCMIJzCasuGk/JUJdwbAPADxiLhK68avwgzJs7yCfHVODigbawb/xhxnsiKuC40/njFNTDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740236495; c=relaxed/simple;
	bh=RfYP5WISnmvFBXWNuEx1HemsFnk8GOmc8nBGB8fQtwU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jDgknZ3h/PAFKZmLgDT/E8uWJVe7m4vJFdRD+Ii4qm86dGWXBY+N14gtBavGImYnFwM0+s2wjUzlU7TPKST1uz81tVfLM2iF+M6bRPd0fOxoYsF5hj1XhFp2c+zLTnXHTrajE6b06sn00Hf/6/79BF77Slqg4GXAog6qZdPWOqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPKU/waW; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPKU/waW"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e46ebe19368so2495856276.0
        for <git@vger.kernel.org>; Sat, 22 Feb 2025 07:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740236492; x=1740841292; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RAQblaPvihd1ZKS/S2cLBqaJ6MG7oo4PhXY6Y+0IFN8=;
        b=kPKU/waWnCekE4tc4J94wCM6H/VFc5yQ7HlTx/bVPOEg+sUXPCo4MppivZLgaWKsJn
         5Lt1ArItLpDGtBsjsrXEU8m1dQb6ZPsXaseRjFGdwzlrsds0guQI98B1It4jg7GtKVlI
         eaLgfQmZGKeUVRLk6N8oOD2rJNjLvljqOtWX3uUAPf1qG3mC2B3FDS5MM+gp7n+/2XvY
         K52RXas9KEwYjn6fl6UJW8UKkwXUtNpqg8T6vxM70pMxmVL/Q0STljU3XqSG6MYIFF+/
         6kdLu38tXBVm6Z8PwDECPgZbDUJQokw+lQQF/i5CqU6EU3+vOOaP8rQtkuGQR9Ap4Shw
         CuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740236492; x=1740841292;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RAQblaPvihd1ZKS/S2cLBqaJ6MG7oo4PhXY6Y+0IFN8=;
        b=Diq9J8BoT4M5pQf70W54RHiQ6NhlsdcLiJOyoPkWNrLH+n0Sg9JDLwdP577EmtnIYz
         kCMnh/mTPAG4scaUFJ2xOlq+2HH3abESWvFrkoLD6IiBwT7H8zHqqXMmzQ8zAjJ5XHlP
         oHvsKEjx6hx4xht2Mt9etG/ul/llPgDAjM19NkX4oe8Eg0e1/S6nSXMbAKC7n4vTO6me
         VT70hvh1ZUsgLzUP3gafWy39IIYQeG9XIsg+qzOi6WcwXom5NBburxq9XWjwnbcjjUsL
         jxWNCbsb677XcTSZrNfE/JHRowRoXRqusF+8MQfKvK1IRltAIKIuBu6t5oW8qmSuoJhk
         yLmg==
X-Gm-Message-State: AOJu0YxlnMXhOEzr253ACpFgaJ8ClplnxHVxCb3uvJfkLaewoiXJZp8C
	1n8r5P/NVJDc9U+lTZQQKNQvD2Y/tfAh/Smx7uH6T30dY2keXD8XF8hpJDN/fFH2NIzQC6dOaJB
	wG7/esCWAJ08WkvNvHwG3glwPGpXrrZvP
X-Gm-Gg: ASbGncv8UAR7OFizYvM8qnKXM9ORg1rSalbJnOND5SOMhQsRTNAAqgVCwKlh2V/5657
	2RBtC44JBJNN3QMo0OyZOBaVHG8UXh6Gziz8oezVJg9snbNcbTPgJie4+cRxB6vKwhy8E7dJFv/
	rw+0vr40g=
X-Google-Smtp-Source: AGHT+IH6lp/PDzvmiW8uGgBkHHVyJuR3dRhRYfhk9856Xsklq5fyO/EWaDVvNdW9a0Oyx1LfMpI9kcKpe8qCOnUFnYA=
X-Received: by 2002:a05:6902:1026:b0:e5d:fd9c:f4b with SMTP id
 3f1490d57ef6-e5e8afea2f3mr4561643276.21.1740236492304; Sat, 22 Feb 2025
 07:01:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John Giorshev <john.giorshev1@gmail.com>
Date: Sat, 22 Feb 2025 10:01:22 -0500
X-Gm-Features: AWEUYZky8vP_cIaQef1uT_eKq9RZMfZiIEWZTBRUY_JA9Dq5-g2ZcL01V0gFLE8
Message-ID: <CADJmAEiE=9Ar8CJFRWeN9f0i7TVDOF7VcV+4f-UaPw0m6Frh6w@mail.gmail.com>
Subject: git client erroneously downloads files when --filter=blob:none and
 filtering unsupported
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The git client, in my opinion, erroneously downloads files when
--filter=blob:none is specified and the server does not support
filtering. I created a related question on this before coming here:

https://stackoverflow.com/q/79413099/15534181

Instead of giving a warning, it should instead error and exit. From a
user perspective, when I request "don't pull down the file contents"
and it does it anyway under some circumstances, this is unexpected. In
my case it caused performance degradations on a repo scanner.

I propose something like this:

https://github.com/jagprog5/git/commit/c4bd8c9640c1491dc6e23acf31fa0230485b68b1

This is not backwards compatible. My question is, how best should this
be handled?  Is this breaking change ok? Or should there instead be a
new CLI arg or config which enabled this new behaviour. Looking for
advice, thanks.
