Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E0B1531F8
	for <git@vger.kernel.org>; Sat, 26 Oct 2024 22:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729983112; cv=none; b=XCZOf/Y1Q5ACTkk6EfSO8WoobKKJdGgJXuZTdhpyO/cbMUYqJmRNpsVIyt26RjaruGl3ASJLXIFczBalypziLqRIaxaAo2Ab9u8UOZuAhi5r13OBlSzT+QIeMPY62h3D8JrftfpgUHMKdc8GCobzUvLwbjVyEVDUaMdptCSEOGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729983112; c=relaxed/simple;
	bh=wCnuQDaiEfmR9gnkelAdm5SygZ41GdqTFzin8rLkjgo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=FWoBJmQRlSPK5biDG5jRv/YK3c0gbKv3amI58CwLQtLoa1XUqkubeJuxRORsLkh9HsD7vp4IkWpOxLOAUpXEotXhacbTjo+1rj0F7Su+Nu3zknRoVD5NDtn3eAL4nKyNc5T2+3m8KvtAlo81Ur1oPqArcB5ievxCLeuv5ADiMHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj5Yh++Z; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj5Yh++Z"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e3b7b3e9acso28651097b3.1
        for <git@vger.kernel.org>; Sat, 26 Oct 2024 15:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729983109; x=1730587909; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wCnuQDaiEfmR9gnkelAdm5SygZ41GdqTFzin8rLkjgo=;
        b=Yj5Yh++ZwPYtwEScox2dmxJfDQ2f9JABwiacxUeRlDvDdj/1RLED1feg5iLYELzczY
         +GhsVW5VbIBzOOQH94/5lPj9MedRPCmfWagnlGXl38vJF7MH5pCsVpU6FjaOruSLfjsc
         X2CPox+yysIsspblIdUVoU/4RqqfTqVlxiRVxViwLWwwo/hKHd7V7qLmHcsV0cNzvkjI
         qX2Os/vWnlVDwHlZxYDSX6moiXOvvK2iGXil/Kq9Du+lBywXVJxbMO77H3tRT4bd91Nt
         LY2BCAsxasINiNQ7O/mbmMBfVoLXM4kEJLM857BCdXo1VBCJC+BvDFqXxhuwEbopuy4m
         Zxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729983109; x=1730587909;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wCnuQDaiEfmR9gnkelAdm5SygZ41GdqTFzin8rLkjgo=;
        b=pSbmxB6fWUkj+HZpFjOPnPh150c5oZaQcSuq8mJ7XTDpn5YilUUmFl6s4vDAtEQc/m
         hoKwz6L1Ng08jH9DonA8znSvdj77iAV0/2IeP7xJPKxe0CtZtej6+LnKCDN2G1Nhowbk
         QLczf7XO+51L4Lm1dHQd6U8K32Hh+v98GBESIruLjWdPPw6mFLX+6naCIrtQQBxIH4gC
         8S/m0JLMLfpkN8KyTcIkgQIds93I+Fjh1slFgI0JI/i7l3DiIXNKrW7qyc1BeilSDjlh
         NYP2tBvEZ5Y7Di22vpxBySaVe1hSYCfhVbJovg+ToXfeCJoZIAUMjrbtpLmfkkjzY1Re
         QaGw==
X-Gm-Message-State: AOJu0YylucIANslwY/jLned0mz1Eb1X9m9E8esZIDCUsKHhN7SYntigh
	F8/XPKozSvozt690FqTOsodchhe3S8PEdTxB+w/OFVeEe6BQ6xjU7tUZahlI4PbPNDfW8V8L/Q1
	gvVKoVhfnos3s1oIURiwxf/9H1EymQEW4
X-Google-Smtp-Source: AGHT+IE5fLNUe4KnMqeT8RQOzxC8SRE23Fv4bVyp633JDqxcDT2+Ru2F0udMY/8XXl1wVXT/4ouxR++mNum0b69o3rI=
X-Received: by 2002:a05:690c:f96:b0:6e7:e009:2c2d with SMTP id
 00721157ae682-6e9d88b8a96mr34298917b3.5.1729983109189; Sat, 26 Oct 2024
 15:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Oliver W <oliver.warrick2@gmail.com>
Date: Sun, 27 Oct 2024 09:51:38 +1100
Message-ID: <CAJpsEwqom8VqnS4SBem5Q=o3Mb6jUjYN9zg-a7FbtCyBO7idJg@mail.gmail.com>
Subject: clone: concurrent interactive authentication
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When doing a multi-job recurse-submodules clone on a repo with http
submodules that require interactive authentication, all submodule
clones happen in parallel and the username password prompts are all
printed at once, including disabling echo, making it effectively
unusable as you don't know if you are entering a username or password.
I think this could be fixed by passing some shared memory with a mutex
to each of the parallel job processes, which they can then lock on if
they do prompt for credentials.
Since there is the workaround of omitting the -j, is this change worth
making and would it be accepted?
