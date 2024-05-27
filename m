Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18172232A
	for <git@vger.kernel.org>; Mon, 27 May 2024 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796325; cv=none; b=i+lFj8eWnDEJigQ9IgjFNtwjjVa47RtvjRiFR8PtMTCZHPCNAiHtRhuA/0IIQ+nVZwfZ5sIa7REgCipvcWRSpDYae269OdXDFj5AccJUz7TyM/Ln7jTlq54kgJ+TYS071dTSH+7gN1j3qRqU6PbzaE4EwxMd2M+IDc5fJF3Ctcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796325; c=relaxed/simple;
	bh=BE2BM+/2a5vZ5NGBwExiSSPr6aI7eY5u97pVY+sNp08=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DvzH7NJFB3wKScZgs8z98FNJ3xDCU4np6DAL90bWSgcO1mSwtwimYTbHYo2FcZPmax3ou8a5A1HJFB8wO65AN5mXSk5g/4lLlOkbuwSUSLnoFmnHVD30v5zyohRiOXl4Py+QS/rn6/ku3YzkvYNtJM7TvMnsL97onid6CPsbUx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUjOqapQ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUjOqapQ"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-60585faa69fso3333946a12.1
        for <git@vger.kernel.org>; Mon, 27 May 2024 00:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716796322; x=1717401122; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3om6Xka0pxystg4rurw/DOGuaK0o2iT0NzjX8EqOG4M=;
        b=SUjOqapQkLpERKGrV9G7f8pqViA5rp5MnW4ezQKOZegaDVIQsjhwkpc57yD7s3rJ3h
         9qj8gtEdJTeLDmxWaRkFf61lnDxNMgBrO91LfNstR+8DXmi5fz2GZypr3du+Rn0Ud5Ha
         iSgm0LzUGAia7PFkL+yCdfGBHISl7osLtCglpqKqDPCnJcCdTTEBDOA9UDdw+BoeHZmy
         Vy4DiY3s0UKzunFSgiRH3Hh6x6fXQ5YgNf0kiJq//l+LAolci+StOU4o/DTcCCJL9yxs
         dYNlEnzYilgYc1MdiQ+PLj2IKiD+w5gyVOTVwZ04pP5fiGJulkFBAX2hZw72Lcy0u9o5
         UQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716796322; x=1717401122;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3om6Xka0pxystg4rurw/DOGuaK0o2iT0NzjX8EqOG4M=;
        b=ro+vUlw3x0Dwulr5dm3bi5ILBhm2HxBlJQao/X8GYF9VKvdBOmh5CNi7GLodB1y2JS
         ReHMhLs/31nqFzkUPWAT9dh2rZElU5Ja5X+5F0+4u2jy/VO4Z8MCo+o00AY8npzRgr0o
         5owdDajnZe6zfht/VgqINV6yzdwNrCSg/4gvFAlJarg2UtsymeLIzPBs9p4gO6ZxX9Qb
         8aLq+6r8qUqVxHiN7dg3N6oe1k82WHuQxbxAlYoSM4ZZX314HgY4iWzDxlUfrrbgu65M
         DXOvwzce0VpOWuB0q2GEt2WR69gMk3ggyLplvbvPNzYyhIEPY3nHlVyhiR6pw77b+d2t
         oVcA==
X-Gm-Message-State: AOJu0YyOo15GJcZLlQXOzMRpicLxjfvMbytuD/Ls4EtesRNtYeQbZ2UB
	bEKPr5cmv42tGZLTQDQDZKTyNlAFWXrC9MQUk6yB0cLZKef0CnKxgYfQlTsR
X-Google-Smtp-Source: AGHT+IG+Rv1W6nTqdhSnnqwM1hnA3rQDsTfYfuz2l0x1Nh3aJPg5XqSvKliCkpxnJqLHSfMkr18c8A==
X-Received: by 2002:a17:90a:6408:b0:2aa:c389:c9f0 with SMTP id 98e67ed59e1d1-2bddce8fb00mr16006284a91.12.1716796322410;
        Mon, 27 May 2024 00:52:02 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682226fc4bbsm5432894a12.41.2024.05.27.00.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:52:01 -0700 (PDT)
Date: Mon, 27 May 2024 15:51:43 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Subject: [GSoC]: Implement consistency check for refs blog
Message-ID: <ZlQ7j9HYVOpP2Xga@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi All:

This mail thread is used to record my blogs for GSoC projects "Implement
consistency check for refs". It aims at notifying everyone who is
interested and makes the community watch the process.

  https://luolibrary.com/categories/GSoC-2024/

And I also hope that the community could provide some feedback for my
blog.

