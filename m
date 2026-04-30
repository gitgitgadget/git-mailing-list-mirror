Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C086A221721
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777562241; cv=pass; b=IOSzk5VjlnnR1B5alpvhVXSqLCVJOsy9vU1Q2qw3IcmLAkEnljQ0LH9eE452Uk0u0PWi6iaEMUnauNKiaX03N4HDhtfD0lpqMF7L/60xZ44c74TB9OD7TWCfDnHyC08hmcf9dp47OkmbR9cxF38EucEE1aYOxzBH4F8D6Eu3Npo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777562241; c=relaxed/simple;
	bh=9gbKnMpz70GQ4C8J/RHEmw3tFmkPyXIt0bfjGQKj3zc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NdhMraa/BKKAjOzfqogel3VQimau5OfC1o0WbIME8lE741I5OcBF7160E7WR0MFMg3UZaz2d2n7P6Lgq0qkCUge1BqsclW6Dnr67I9ws/C1F15CTBWVagDx3JWTmypWAxjyDD3ydXIS3LAhHUJVavQjx+R4zuhAvwcsmgF1bdvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUDmsSEE; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUDmsSEE"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12dbd0f8063so100456c88.0
        for <git@vger.kernel.org>; Thu, 30 Apr 2026 08:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777562239; cv=none;
        d=google.com; s=arc-20240605;
        b=OWO/7EGQ6KP9MWKIzrBoTEW7m5u8NvxVCtFlzV6IPjNLgtPz/wmC25y710SE/97V/N
         RgnfDKUNPg/FmXZf5vL5tC2hnaoQ5GJNr0bbMYI3It9i1VzbUN70/r8Mhq0Pda4HhjoI
         CYHYBtwXCxzA/AXX8ophkH7AFXogKJ0Y11L6oaDe5Gu2A1sp95FOTWHXH5YVQJ8MuxH1
         I3klyn5435S1LqDTKGoTsWbK0yDfSBvzJQg+n7oCvMQbxBbfJrRNlIfKNkDH/7F1P/3J
         +l1PNbiUxlCeiZx/E8XIvuYwS/EMQLB9ksjhmMkdZPsoe/8wgqqtMtkk7hr/DYCAlKde
         Bj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=jZ+DpPlldXRni1UaDOdmK86jSOdy78RWkns51vTbqJU=;
        fh=xtcYOoo0jjtZ3zafjpHUafL4A0FpJJU59cX3qTeJ3ko=;
        b=jLe9Is+9X6aVT78hNyWQgpEyNJ5XecdXMRYfZxTyn+wS8IJgQuXa5H1x9X1xRreO+L
         1cm6X/l6rScpnUYNY1RbR2TxOufHcrDwruMYRxLr2WFv3AGAIsfyVO2JwMUiFvth54dO
         EMgmlnxcDJwzeSYx33UijBr6Uub68CvK60oLsZH2H2b9/HgtFOZD6U3O6PBRVknt95pJ
         ng7aeXHsldP254FNyQQ+QbqwpgZeTm1OmW2GXAIaHBAte/iA9l1OKxU+doFLsMH6IE+g
         LEFGnq0KaN9eMI88GEi7JhanecDJAlPFqAKodNX2pTg252YFsVxEoxjIM6lgI83Cha7/
         orKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777562239; x=1778167039; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jZ+DpPlldXRni1UaDOdmK86jSOdy78RWkns51vTbqJU=;
        b=TUDmsSEEA48wF0TQ8Q8XxJHUh9SKzEc7RvMJGrCylIsJfGyXC/d14xTbFp1d6VkYKC
         lFFuU0VJoZiyzHVCaQd0d5QSf/AwsmqSzCDhjAPMmdqdON2HYlpm5NHDdN6geBv42xQa
         9PlKmVdR2sqQFKgB4Y1qnbAYzd4ahwN4RoWTqYby2duZ1uiw5VssjKDOOyN0AvgejPZ4
         Ew/x61X2wBwSY5r/aIl152garywCjayp9af7JixEnvBdPe8DBcopXEuwwlHT652jU3x5
         rIKP8hs9X1I2wqdj2EwvjQHO0yunKmNet05oEQIqTekeTOT1ZaDgwKOYj4LN8V1GHTD6
         Qexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777562239; x=1778167039;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZ+DpPlldXRni1UaDOdmK86jSOdy78RWkns51vTbqJU=;
        b=pYHski+I5BJSIp13verOLYWoeVbae2RHA1oxRPi/qEfjG0PTr6qbRy12RyW7TchqG/
         nPesbsNyZAZ3UVrxlCsXhpU08CiRK7GTcn40E4ezVMZ6dj4uWVWJv03oWqDVOKO9AQLH
         Sf+DH+2Hu2gAQQtnuP5gkL5ViodRLXFdb1YtJ5SdV/1Sad+qLr4atutpHMkbttjwfN6Q
         gj/wNSR0W/fdgfw6ipD4UoymSbBT/WSnccupbJL/kLqx7X+4tvmbdqL0FYIIJZmLdz4L
         GHWexRPFMU7vDpAarYGoxAwioYCpH0DlO3sludoynemPbJC3x1H9JjG0b3Bfd9ZvuTSV
         YLJw==
X-Gm-Message-State: AOJu0Yy7SG6RgVsZ0pDNWascBtx7ma98CEmaO/ekPkcsiZh7hJiq07rT
	LinvL4xlXKydRKg+yBvEltHbouuOCbjuSZgxVLTxlQ3MMGee0FnXU0Vn2KVyihQrxc5RLCWC9WX
	YC82drcFoODFksScFHO3/0xTrtPmm9fHGmrBu
X-Gm-Gg: AeBDietqeAEZKvhcN5LHqu5Xt4XqbmgXihd1Rz7vr4CoBLr4NieUzsV5ciLQ5fvZqq3
	NNGfIAjxIIHRUMnpFQVFuiBBNrkoNi9//d/i7REbH+Woy5XZ06sxWxfi5EThmyrfso4iM77FmmO
	0LOK9OuYWt7o80BTeZ7+qsHPUF4QyvEfabENKs5YQsaSEtxyO0Q5ZM5Rl9UyqtmFNyNi+C7/9Ej
	vogMd9uoRtsaEX9zXrlS2FEY/dT/0AMIriCOOjr/nO3V39p08w7U55dzl4RyXtndUvwpu1JMoyO
	zhhisVwOQS39NWc+nlJZBx9MiqXx7EGwh0rDr9t8whFX9+CNeIw1jZSVe1FkpcUvm7IPLxfCNCK
	zRkk=
X-Received: by 2002:a05:7022:6291:b0:128:d5f1:d594 with SMTP id
 a92af1059eb24-12deac58da9mr1756407c88.10.1777562238455; Thu, 30 Apr 2026
 08:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 30 Apr 2026 17:17:07 +0200
X-Gm-Features: AVHnY4LmQdFUyFoSAyDdOr8_klGu_kL3K3ETxthGAqPEO8vaL0Q-NrwuJd1chxQ
Message-ID: <CAP8UFD0w2FzfxXsCGgnH2pH2XkAJEFXCjWe9Pz4LwpfMfTdFNQ@mail.gmail.com>
Subject: Draft of Git Rev News edition 134
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Michael Montalbo <mmontalbo@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Matthew Hughes <matthewhughes934@gmail.com>, Paulo Gomes <pjbgf@linux.com>, 
	Toon Claes <toon@iotcl.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-134.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/842

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Saturday
May 2nd, 2026.

Thanks,
Christian.
