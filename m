Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEB0148FF0
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955439; cv=none; b=UZObBqA0BPI68DREcrIyfusmti236wOzN7l+0bEVaZ/wFVNT80SDsTRZiUGHp0o1coUYWaYdnbi5VPrWZ02vVbr12/iL85oNe45kFrdQ4iSxAJcsp/zOjgRhSVTZmwbA94QKrGlA/GcS2zmJ1loGX9g9xp8Au4PWP/W3olXoWE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955439; c=relaxed/simple;
	bh=wOnv7wLSmWRaQt24DQ3l6uncieikJeZtpfQomgXk2nY=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=UQwV/7Ir4C34UB2GKsWXduZBSKCLIhl5ebs/KN6Iw0E+4VHqnDh73B8h9tvvRNO8RaLGVp3D2/39aFJ3KI5AUKHeNHOHt6Hrh4dpT05sdhkHYMYtHFu5SeuEskYEPmQNE18frNRUZbL52jKC+UA2ftrLkgVaOm3tNZhKg3Peego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSpqRPuA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSpqRPuA"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a70c0349b64so619386166b.1
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 14:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719955436; x=1720560236; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wOnv7wLSmWRaQt24DQ3l6uncieikJeZtpfQomgXk2nY=;
        b=XSpqRPuAcd1/FzWseEN7dmsd7Pl6nSsUEQoNPBIzTfi3B45otQxL/k/nxEBaR651Y8
         IUFB3FG+tJWyVIFhoVRo6xfmEuNzs5T31rHm10Myt1nyPkVLGxWz2kdsJgH92Ts3Rlp8
         5WsS9gnzAsArMvNrnD0xgC/0/turKzqj9GAYuVixM9s2jX+t36rfHMbJPwg0Vb4HUgs6
         98Q72Lz1b5Kt3w+2Zr6uJOXUnIdiXrAx/Y6JSbAe4GmlCU4wSRo6KGVNfgEh1PvkVbrT
         4Me9wNfXjVAjFeaa2FUJHa7mmiYQyI/rPyV89TTzmVp4oaiXvWCcefy5vkWWpy8SCKsq
         9wvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719955436; x=1720560236;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOnv7wLSmWRaQt24DQ3l6uncieikJeZtpfQomgXk2nY=;
        b=R8ecshOTzHfb8Mi/d5qmvtLYFgt9yRy9S8bFvmJSL/od8IhWgCd7di/+thkXt7NWlS
         Mdwmw/P6AbdYAWjr5NZQgpkQyQgaTtBtOZox5nnYicTvbUv1vuR34AKRtPXydUYyzYNG
         OJNK8NYSpTKN5YTkLVT+o2INmOm65/Ff+A2Wqgq/+PO0nxUw1O9UVoyYCqO9KxEVxRkb
         B/z/BrPczDU3jy5lEKnDDqTtaCdbNuShBIkgCvTcYjNSVebFKTRqiEqIn/t5lHoGxApz
         m/IhNg2Ok/U79BtWVrT0P6HT1WLKrVXe7G22oWI26F5z3ujZqzWtG+Sl/hKK8f+TD9xb
         e3Kw==
X-Gm-Message-State: AOJu0YzmQKLWoiE3x7qX5tYPTAELue7GBc4UZPUh7ahhMkaEbZuxFZR+
	DSlcGhAJFgvAj3U8q8pEnlz72Kw4JeaiL6TMAKQwP6cS1PSEnAxjJn3Jflla
X-Google-Smtp-Source: AGHT+IFiVlJhqKgYUpR8Kr0ioV360awxXUqW1Rs4mqm050+T3tshiYtH2o1HA8z/zWKn3ZkrAB4Qcw==
X-Received: by 2002:a17:906:378b:b0:a6f:d5b:20c3 with SMTP id a640c23a62f3a-a75144a9059mr554683666b.74.1719955435578;
        Tue, 02 Jul 2024 14:23:55 -0700 (PDT)
Received: from smtpclient.apple ([176.8.55.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab065147sm451584466b.120.2024.07.02.14.23.55
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2024 14:23:55 -0700 (PDT)
From: Vitaly Vitaly <iamvitalyo@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6.1.1\))
Subject: O
Message-Id: <E03968E7-3230-42DB-997E-449A5ED5AC7C@gmail.com>
Date: Wed, 3 Jul 2024 00:23:44 +0300
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3731.700.6.1.1)

need simple brain/logic, and share info
#ai #agi #asi #github #gitlab #bitbucket #humans not O is also your =
problem please make static O - open source, O-50/50 and move, so by =
ability project for all of all, use your AI to investigate my draft =
https://github.com/iamvitalyo/Aphrodite and draft =
https://x.com/iamvitalyo or this not your problems and problems of =
humans?=20=
