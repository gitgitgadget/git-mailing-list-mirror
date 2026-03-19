Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E29A3B5850
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912293; cv=none; b=DvjccLmbDRlgpfEm/R7U3y/1NB9+L/HqnpFZhkiBm+q4cJAHKQIS/Tk/KSgHIEivE1xvIYcq1g3AZLNj+ZsiGgsMXBBlLN7syXNysxZpWVu2QYFsrGCbMf0Ns6DWg51bZEpMtJB1vgIPvv+WKTQpx1DBiVwUIbZCLhAkzf2wnnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912293; c=relaxed/simple;
	bh=+4+GtCb8rzgweMzpdGU9P02b0Fwl/c8jKXoK5+9uNTw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tiiHy9btTgcLaN/eOyowFjMDQa94vsPVVri7xXGVrScRIxMOGs56eeTMIz30Hvj8p6znY5PQ0kUdV/w1MZ4BgoD6SHwbBaXiJQd46loGMJpfJLntNGO5w3P94WVfgBhF1eNrjtGoIi+LY8GuavI6vCrYQJstLUUX0GbDSWBnubE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUEGX9Hp; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUEGX9Hp"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-827270d50d4so741782b3a.3
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 02:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773912292; x=1774517092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EK9hXVcdbHjfNLtYFvL8cki56f2F21PS58SIb1mS91s=;
        b=gUEGX9HpIMShSjUViqirnJTrdc+clBOrFJ2Qz7uy4NBkzbgxhUiTGTegFNiTMchR7Q
         Uj82ECUUU4uUFBN/ZTgwqMXvIJfHCj1h0cb4Sd/DBUGn2q58xlxQFY+8qos8j6zuseQc
         KJQkMbzvhSSvUhucpuRU1lg8r5hqEG7BZ+YThJFiAPEdVIr0ykVO+BvQFmHf8VFVb6fK
         V3Vwf5Bc6R+t187ZGjni0anDZFW6OP6Hh6qyAMeVXo28FLeanMNd/R98OgJxnWd8o41A
         oaT0fbwmGdYWCX2wmaVSK8lgCqnni5mGKLNgDMd3ieJ4HIrOXDzYnKsE45RQ96InS6qB
         PZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773912292; x=1774517092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EK9hXVcdbHjfNLtYFvL8cki56f2F21PS58SIb1mS91s=;
        b=DulYK/nkcCxoEdZ3MjHRBl6FxqKaMu1LZWjsSRhVfsm0p9JYbg1yLR60wfXvcCmEkw
         qZCI8PTYsW1kOHKOwMzs6+SYvq2QLB0BihblxrU5Y8hRra9994LG8pUpk77LEgXd2X4t
         Z/fEIoeBWpPv8CYTwFZcHEpxjk0j6r/nZppY6nWIOMaxOJ/Gq1rOWPWsjNl6RzeF333k
         6lMEdAhGmePyOVfizMaTpxc4DLuS/vM/qEzbseeOCWEwejwzYSJWyKjQdTDl4YdkRRjZ
         RVbfUoE1pTv+WA3udwedF9b5bHTCwnU2KhgN5gcPQ091ws3SrhhBEaTu35zDySffgRUm
         YWQg==
X-Gm-Message-State: AOJu0YyEr7RXOHMJEfNe8WYwijyITHoMddCRyQjQufZy0bO85b6+wKlE
	H/e8PmluJTwFYHmsCeMRXZ/9O/VbdftyTwJOodWEUEn2uDv4cmrHYbmYYTqA2g==
X-Gm-Gg: ATEYQzyUJHAWFPA/yWXi7r3YjjXidGKxWOaTHICcBba/HJusG0AgsKqpOhJGa2YCK/l
	9Y1Jg54LgCJsCtvKq1uGFjcVKnEb1PN71e+Cok4wePqRBDBNlL8FgRL2h1NLqvQOHrqqwaa00YD
	h43iZqIoUTBeuxFR5kZohCAMM26Vj9B0OjW5SOvH1AuIdSB7MY1UwucG2rz96XLwKfvm6GzcSiY
	yUeqf7xihx99Aug/lJNNVn69S5PjsTQuIT3brOztGOHaSmuH9+GoPLHB9tunrJ9dq2sja4x9OR1
	Uh43BL2Crj+fqfXCnUA/Yop6vLvgQ3rvnCJ7VEj8YxlxBUudDoIl0C9yNqdpNDhMy+6o+MOQ58J
	m4dyne7e8p3jN/5rG0fp49vqJp8KA6wLvgxKa71dfCNrvYfhiqqv6m+tgJJ9ph/q/Ob2o3WJTye
	VjtnY2qluYX8EMlOpWgQ5h/Iq1IJ4scZUQacziGpxloIY=
X-Received: by 2002:a05:6a00:3e23:b0:81e:af19:34bc with SMTP id d2e1a72fcca58-82a6aeb2ce1mr6082896b3a.36.1773912291665;
        Thu, 19 Mar 2026 02:24:51 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:8811:76df:792c:fa8f:e4c0:f42e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb390csm5746005b3a.29.2026.03.19.02.24.50
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 02:24:51 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Subject: [RFC] git am: apply patches directly via message id
Date: Thu, 19 Mar 2026 14:53:36 +0530
Message-ID: <20260319092441.1283001-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Currently, git am supports applying patches through several methods, mbox
files, .patch files, maildir directories etc. However, all of these require
the user to first obtain the patch file locally before applying it. I was
thinking that it would be a lot more convinient to directly apply patches
by by their message id of emails, without any manual downloading by the
help of a new option '--fetch-mid'. It would something be like,

        git am --fetch-mid "foo1@bar" "foo2@bar"

We can fetch the patch/es from the standard url format like,

        `https://lore.kernel.org/git/<message-id>/raw`

We can also make the base URL configurable via a new config key
am.publicInboxUrl, defaulting to https://lore.kernel.org, so that users on
private setups can point it at their own public-inbox instance. The fetched
content is already in mbox format, so the patch application logic won't
need any change. A further addition to this can be to just provide the
message id of the cover letter of patch and automatically it would fetch
all the patches.

Does this sound like a useful feature to add or maybe any kind of indirect
implementation is already there and I am missing anything. Let me know what
are your thoughts on this.

Best,
Shreyansh
