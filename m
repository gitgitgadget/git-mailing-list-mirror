Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DD578F4F
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 00:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766537770; cv=none; b=Xvezers1b5p1Cyhd0iZ39aEiJhWxE/tpxAxgECQ7TWiyehWUseezw0/FWmhFW1skPJ69yUtMcKq38HYgNwRXaN/47mUR9raLVJpylLKRV7JgSW1sF79urNUALNc1CxT8DPMuzrbuax83XzICrnAD0ByaSqfgI96ricMcHDkYm8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766537770; c=relaxed/simple;
	bh=/WJ1ogQFyyBUJ6sLi3cVO6G9eYcNWsd3y0jGrOYFyOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plbf6TdALVq9liUAubOnbSikNyri9onuAp0h5ljI4wNWofvPNgfvlCQbbmlD6VOfb/6gldQXr6xYdmbFGeRg04GXu8f3n1Mg/hMFB2Eym9xcvq3rXez2uetbFdfkGpmoT8kF77V1lFp9VSOBw4wqPqqkstS4gKXxC2BNGzM/eKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccMLEduZ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccMLEduZ"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b3b0d76fcso3330481f8f.3
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 16:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766537767; x=1767142567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/WJ1ogQFyyBUJ6sLi3cVO6G9eYcNWsd3y0jGrOYFyOg=;
        b=ccMLEduZFnzQX6V/GHbV/1XlzFuNcMNI03KXvGQKgLDTZhzdEAOhaqlfgLqC+09ItA
         Yxo7f0ttSUl6JAlxp0gv67XK0+z7MLz6k1ilBCSQExyHqI5os+VZasLJQIj9Iz2qQt0+
         1rJ9o20VjYPEznP8t2tm+CA1WFoALGUSw3o3mgJhZcxTzaSmrHiw8dlzUYZv9Sa+k8mp
         vZQ5hfhIin1UISuTkkaqh1HstCZEt5/bxKA2mD7sYlq9o3WcKDzQGlTyu+F/LL0VPYGS
         g/N9TwozVSBL6Vsku1mowUX0VajD1eBRlaDV0/3Ebr2q4YlT22tOkIqxA2JeL7fLiUR4
         dRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766537767; x=1767142567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WJ1ogQFyyBUJ6sLi3cVO6G9eYcNWsd3y0jGrOYFyOg=;
        b=njC8Ud+IcrbEQXNawPWv+jnqfZ+FwmyN8QZHb3cdW00q+ueZw1ADJVKw4ra8Dofz8D
         OKUC1AAFN0lcQ34EGwJBn9K22VauM9hWyZOJzR8FHeh28gQ4WaVNFkHS8wYfB5FVq6pG
         6iSQRRBTXNhExU9oeDRfZFhhTUHYpd3yIwUU1U1gw23Q5GCIVqMlOad1wGHZvby7nouA
         8x011ZNJFunVGB597rkwQUUvWgwZg01yY+EGO6d973MU5MWlvNpFgshl3PGiB6ffntF1
         RblIEzlMRoLZwRVExe4l3d+oTxdHPwJQRMpzhBPPjb4Fvq9Max3H6sA9IsEtN2tkm1sg
         tfEg==
X-Gm-Message-State: AOJu0YzceS6o8pxJYaSjFqSKdfQLdaKLhowvxnUqwGGEnVikNvTTO6el
	9NYj4PEZPQkbUPVfT14+/EF1rjSnXZdxtTdTExiO4ljF9gbUtpTn5fOxMKhctLqiTES+odvN2So
	cYgW/FrZXSFJx71iRyUN2f9FAzy3Y9Po=
X-Gm-Gg: AY/fxX6b2C5inesYJ43oxhOWlPo83GjEEoCWAiquE+qHv10m+oilXOEmV4Qns8cVRKX
	whMZwG7zztAbS9WI3jo4chftYVOlnQNxqWouqTzUldRr7Yc8W0bmFWZQDnJ2XIp64hJvYwPH3q8
	ZgUIFO4MlveYnHrp1p+oV3yARJo8jHlU0EzhVwl4M2ZK7C8YN4+Ur7/l9kfEgG2Z5w4FjmGXvoM
	JbmgBzVvCdsuNluNYbX+aqwgz1mn5P7u0gC7FhfhPF4PdALmEkd86EIAGtG1KJjnRke9Ag=
X-Google-Smtp-Source: AGHT+IFBwdnh+y5J0vAiwr/RwnyghvUqWnJX3P+ahtjy5EFGEmVtxsbJA2Vx+b5co2gehC6TSwKGUXNoe/SgGe/JYbY=
X-Received: by 2002:a05:6000:3109:b0:430:f494:6a9c with SMTP id
 ffacd0b85a97d-4324e4cd1b9mr15057798f8f.17.1766537766949; Tue, 23 Dec 2025
 16:56:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHTeOx_kSX7RhVvjjffSK849MMQbjNreqrq=ezHazw0GjMO2Ww@mail.gmail.com>
 <20251223235939.45614-1-haraldnordgren@gmail.com>
In-Reply-To: <20251223235939.45614-1-haraldnordgren@gmail.com>
From: Yee Cheng Chin <ychin.macvim@gmail.com>
Date: Tue, 23 Dec 2025 16:55:31 -0800
X-Gm-Features: AQt7F2qggmvIqOdq8rI-uO3Z1s-4sCt7dgFUSrKsuevdsnxrN9anQFGQbP6OFVI
Message-ID: <CAHTeOx84MS+hWHzXZdG2YTxGc9_5q-t3T3iEf6hVaN3cKvF=Rw@mail.gmail.com>
Subject: Re: [PATCH] status: show default branch comparison when tracking
 non-default branch
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org, gitgitgadget@gmail.com
Content-Type: text/plain; charset="UTF-8"

> I feel strongly that it should be able to be set be repo-specific (and globally). Having it only per branch defeats a big part of it. Should be straightforward git config to have a repo-wide rule but still allow disabling it for e.g. 'gh-pages', I hope?

I don't have that much of an opinion on per-repo / per-branch
configuration but I just wanted to point out that some branches would
benefit from the ability to turn this off. Perhaps it could be a two
layered setting that could be both configured per-repo / per-branch
but I don't know if this makes it too complicated.
