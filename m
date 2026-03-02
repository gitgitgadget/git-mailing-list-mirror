Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DBA36DA15
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454942; cv=pass; b=aSaXduKFtvdzu92/YbYbekZkGKV99T9YbNIWgTq95zWnyKFW3yyVmX/uyX9vohgHHGkQD3uhrfqmdc5oQyZhXyJ8N66X6XNfZFqIGJU1cNkwLBpeivE45mmsDyTe1/FL2pNWVdU2QJfS3lS8HABwL9l/TpWVILEkTWf+tuCnZXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454942; c=relaxed/simple;
	bh=0G4kWfsHFrjCQQJLIVDj17GiuojF7uywKtDt5qEQrOI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rbBHn5HTHKKY0uoyxqe7kt/wBa+eSlMJWfB3CUP8dxIxcCbQPx6psYCdQyXUsPR15otSrwWc/xRZ+SnThN1hXv+P185lHp5ZDUx2z2MQmXa4jCeG1epaSVVplfJkTZ9s0buFQhuCPLiKN4c0Zv0Bmg+wWDh3E/3245wtdzHL15A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeilnfIU; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeilnfIU"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2be0e24d627so810814eec.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 04:35:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772454940; cv=none;
        d=google.com; s=arc-20240605;
        b=kSDgLX4U5CrbWGu8U28CPjE0vJkqBDP7I6v2gSfPjMO2FqlJEFkfC2mvJur2SPYdjY
         ZmyPsc3f0iM/b7EfwP7z3gEiBdNt6SAqpA2ztLbN1CV82h4vQoz3/DhVyp3Ee1WVbuh/
         XQEql+vlU7sPJwz6xVbfCfMIetddjU97SxNs+E+cN4O3PxL78NExVI4bmat6EZ9u8aT8
         cZ7d1UxE4FlUW7z9ekApGtC7mktNFbAEM9jiBDZARIQqIHzIQQafMROjuy9AIyokLyYW
         GB25htbOdKMQjBTfT1glcuN4+5z85LEnkcecOMHaNWPQLH3sUYwXwUjmT+I4Cs3zZBgQ
         X2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=0G4kWfsHFrjCQQJLIVDj17GiuojF7uywKtDt5qEQrOI=;
        fh=1ola943ZWeNVAq0/6xwPR2JqZKMeyhAUlII41p+x1Xw=;
        b=MFG2alBwahHmX1MPG4+hI44u01aGlpIR/FW9gh3FsAMyzpX46htAMkJiLQSJKxnB+w
         KD8QH7ecrtPxjzzbk4j1gtY2rdq0x75hcwhGnhYD2uP+o3BNxU7jbNKt27kA2EJ7a4BF
         Yt40MbCl4fyEbEYBBBfcU/eSVMsBX942ZmYXXAV8X/MoBmSnH1AO9GHCkl+xA51GAwvL
         ZirytrQgunhhoXcnFv6pUykscyBDWVmELoRtfKAnTvxKR6i5+R3/+8EpZdzmj+8xj7MD
         WVCFTDbxOkWO/szhnNVJB3UnVoTZQNRImeDAVrBoRa/gdJzTPkgE9VZveF9B5dH/rxnT
         DHgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772454940; x=1773059740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0G4kWfsHFrjCQQJLIVDj17GiuojF7uywKtDt5qEQrOI=;
        b=SeilnfIU05EsEwBBTUXsxilfQEodtxyaFM/ylCw6nWQwpejVpek2izba0fBBO/O4ZF
         BZeVI5XGf/ZZQ84QWgxeSusddMyj5kbz7/lsI+eJYpxhZpoLGsUxL+mJQAQ3O8xaBEEH
         XBpJkUGFyTT0OaSuhwcRdbDBpbRBXkUgALayqVD26ZndspwmGpO4MSEzFBWPiTNyY+rb
         etYEoMPFnl6fvIx4P55pSIagQ6f/zliuFout4cHds1jCZVM2gb9m9aglfRFBTCqf/bl9
         NMUWEc8HNXJP8fPFepNfcX3WT+Vagx2RFxRfjv0a5bvR20yhx5/faJOEgWTCQ7kNuRtL
         ogSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772454940; x=1773059740;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0G4kWfsHFrjCQQJLIVDj17GiuojF7uywKtDt5qEQrOI=;
        b=EJjhOsYcS92UZdszAVqjU+o/lSLF3qv0FYfc00+/rFw25B8flEtC6gxOtOu4Enllz3
         f5IgBP8g+cSTICK0qHJpTza5P+MEgUhL10uTkFdDMuUEKqN9JGw2rMOCyG6DdV4fP3hM
         flULdQ6dEblUvuOlDzjaY/U3tdMLWPkpfgSojN2VRR9gmkMHCdgiDWgU1rvGj3NLC1mx
         fPceBtKrgRy4y039Fj9WrAOpA8QuGN0qkAzJQfG6l1VJVPxrgr7E3JvAKHPQpU3zYWY8
         ctR67PNzv63+TjsKhpw6LB6StC7yFxtn2D0/cuHhKSawxnF9rM9SOWBIn1F2PPoZc5i9
         nwAg==
X-Gm-Message-State: AOJu0YxSAbQgHLIumsDZXhGmBGzdxVIHdwWs2DZ3+FBFfvsEeAlUaOWR
	qhixo2zYOcjIk2JHNyHubtG12W1+JFy3qwR4VFZza4v0l+9vlvcAsXZ4RD1Jtp8XRqtSWoIqDMk
	5ezsMBxTunVQz7In0FIbtrMYmf9iIPISX+uPO
X-Gm-Gg: ATEYQzyGG7VOSLKVPYa0E6F4zTjZGWqQZtSWRcT9cI5O60ml3ZnJG/SLnzAHfbhsbDb
	ozx1+Y3IgelNx0qNY9GJLnOZYkm9IGH9m6YGdCYPN5K635Bz/C3yLSadPH3FUZvfX74JvDiyLM3
	KfhDtBVvV35i/Zzs/tPQr/fpXo8CbDz+UmXcZM2AgH3nJVIs++xUie3Dj03fGKWtSTtG3qcRqQU
	gYZT13VGOCmml52xS7pq1k2tQ568c7u2RksuuLTMJ8MzSYgY53Rc6GCLuv3SkgT2i2+ssDQXVjb
	7u4ICAIivPFkg8+sN2G2rH9qextMhqS8hk0kd/JncfQvT6EPkbO6rSdu6CQvWJ/yhnm+QV8=
X-Received: by 2002:a05:7300:cc0e:b0:2b7:fcb:765e with SMTP id
 5a478bee46e88-2bde1e6bec2mr4255083eec.39.1772454940308; Mon, 02 Mar 2026
 04:35:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Date: Mon, 2 Mar 2026 18:05:27 +0530
X-Gm-Features: AaiRm52QWlFSS6p9tov-qQvUd0IYY7D6ao5VW_SC1ebhm98jkMndf_QE40b6m4c
Message-ID: <CAG7UgETCyO9MoVzkft-B_UnVZ5_6Gwr2vxcMZOT=JOquF2WmLw@mail.gmail.com>
Subject: Re: [GSoC] Introduction and Microproject: modernize t7412 submodule
To: ysinghcin@gmail.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Yuvraj and welcome to the community!

This sounds like a reasonable microproject to start with. You might
want to check the mailing list to make sure there isn't someone
already working on the same file and to see if there are any prior
discussions about similar updates. Searching the list can also help
you spot any conventions or edge cases to keep in mind while modifying
the tests.

Please make sure to read [1] before sending your patch.

Best,
Deveshi

[1] https://git-scm.com/docs/SubmittingPatches
