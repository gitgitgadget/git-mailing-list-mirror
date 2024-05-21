Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE15E53E31
	for <git@vger.kernel.org>; Tue, 21 May 2024 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280785; cv=none; b=pN7rM7n89FrUlxyKfArL/8raMZAyP5Ilx70JMZzyexXg/BcG4UYQrtkf7Ny5aSO+6QQYpa6pS7cee6JzqRHKl0RSGGl09E1nvwZA9rc5/rpipWqsCjBw/pyfsDkqwvcUD4ZQlpSIbFiKN0P1IF/pKzWbsVYEXatdDA5HOfKhy+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280785; c=relaxed/simple;
	bh=/Ixl35uaUHjkyl59FofJD1W49HtuEWjUNcxeZokHHJk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lqKe1CplFF7dUzC/Z4RsY+L7XSIF9H72k8cRTv5L+JhYEtlePKRvuyixoQYvtPqKVD/NArR8w4/RZa4DmjWEvOAIj2dgRcjXCTc7LEkDWJYIdZIodom6erekJYcMqtoIPrx9BLaYazch8dEaPn+q7ICTDCpWwaQnVrBLK2aH7xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ml7Yn4TI; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml7Yn4TI"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5b2a2ef4e4cso2308814eaf.0
        for <git@vger.kernel.org>; Tue, 21 May 2024 01:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716280783; x=1716885583; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Ixl35uaUHjkyl59FofJD1W49HtuEWjUNcxeZokHHJk=;
        b=ml7Yn4TIZ9P8MqXb85yIJ+t5490++C+AKvAv9o1UysVTqZwPqUZNi7cE/SidQf3d/+
         1lL1j3u2gK5SamD5aCG/m8czw3viTXTpjgMGAn4DqlrNxefc8qazLaQPVssqPN9n+MDH
         Ze10GC5gXKDpmznpgz1yG5QZMUcouNWGZjMIoIkLIah6q5QriTxMpJViNm6jj3TZ4G8H
         XJXyhWiJG6nE8McxheaH0uP0XkdXDDY3PEbG0MbZsPaUfaWFUymUU3OxwVZBYGlx4aAI
         eC7E/xDbuftha8mq1JLo45sMB89Aykp18k4KK5LUVp1GKJK24LpKmN/CTO9eXjDqsFaR
         WIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716280783; x=1716885583;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ixl35uaUHjkyl59FofJD1W49HtuEWjUNcxeZokHHJk=;
        b=Hz1CQ8+8V4/cd+09Gf/h2nPHHP7okTCHJJb4CQq1THt7czdE/F4ZNu8FMl4DWhHYH9
         HPH6dzuK7LPWbRFqarzpsBGOfkBnlV5oQCtyI2wA8IgzPTcNtNzo5v22BpVh375k8cTS
         rYqi3gAGbw1lCj4FRQdrwlcQUXIwuTZGE0o/aZkCaAPx1C4gaK6ixv7T5IHtpSpySEyR
         NV2WLT3iKgrj4Ph4YQuBvVub7qUSxqawe0/2IXV+XsUY1TI2az/lK7c4Mfo63I7Q44+I
         VUqIwubO6NV6SFEAvpF32HaO+DsRxcDDbjUWCh6S++FF5Gd1FtKqSlqa4ca0UM4i20vj
         I9Nw==
X-Gm-Message-State: AOJu0Yw+OlQs3kqP8k7b4cQpVZ5UwaZyJCU/ODzwY1/flrA7pl2KMHRL
	6hdIMsUgv4TLtgNITlCHiRKT5C1HvWxn1gdeItD3Ew1gKtyurBrHzxwn+U3p++4EAqLblN99nhm
	+vwFdlx9Ym1KhCFxawa44CXa0ZEMaGRhC
X-Google-Smtp-Source: AGHT+IHjpijgAZzPQJmD6k4mBEKBRnfy27cd5n21W+2AJ+y1xvwQW61c5/9GRl3RFMSMLTVenkaNOQ1rSDuaS7P7LvA=
X-Received: by 2002:a4a:aa09:0:b0:5b2:73e5:1d9c with SMTP id
 006d021491bc7-5b2819a7b0bmr30653707eaf.6.1716280782772; Tue, 21 May 2024
 01:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From: Jeffrey Walton <noloader@gmail.com>
Date: Tue, 21 May 2024 04:39:32 -0400
Message-ID: <CAH8yC8mPP_2jv8HDBdMxWv6TbiLXeDnD=KmNRMbno2bHQtfH1A@mail.gmail.com>
Subject: How to disable safe directories?
To: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Everyone,

I've got a big DoS on my hands since safe directories landed on
Fedora. I think this commit is the one responsible, but I may be
mistaken: <https://github.com/git/git/commit/8959555cee7e>.

At this point I've wasted enough time on them. Now I would like to
disable them completely.

How do I disable the safe directory changes?

Thanks in advance,

Jeff
