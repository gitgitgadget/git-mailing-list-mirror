Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E61B193086
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646654; cv=none; b=dVRcsSr3hAu4NjNlOMcOa16TmcRaxUT8ImG6vNoFtal3UX9D3k5kmMjsFYdthBm5/et+Cpln/hd96zQAqIwJq0LPI0PQrLgX38qOqzpdkWNYCWyrAlRv2w3i1RfZrdEdOt8YYZjSVgM4Pai96+JcgJTUJTFiXMkgUaJU01zw/aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646654; c=relaxed/simple;
	bh=zMgFH4wzE26m+dt/ix5HyWATZI514dQLhlO0ZK87CEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oizu49AyoT1ps40iUj4iixLege7V2n9XtHfRtwdZj3Xw8xn6EbFU0QRwhLiTTOKGpHMrjarmHzSmG19F0wVwvEZiytVMDOR6T6Yn3MCBHpSWYpX3ojN9o9rCQhfpy637wF3hNC7squniMUwTpB8rvOOX0sx2wnZSgPf0LWcnGGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhW+xqb6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhW+xqb6"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso49523225e9.0
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 09:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744646650; x=1745251450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gDEi49TVTvNQTj4EltG8XtvLqTulTPsJjrOFrLNcq8A=;
        b=WhW+xqb6cmXZBxLimkQEd6Viw6oncQD/OhpinisFu3uuk/CrBLUui2fO5MxH4D3R+W
         jvNwF7OUEi8VU5q5dZJIcWjNcqu+rmk0at3kgXLEoOPduM+A45FYWiRAXuJwvrMlWgbU
         cKo5aZTONYpxkTuiyM/xG8Mg5NaFB0XmAF37RKsYp9+Hn7yRbSIoXLCHqYPWO4mtJSCG
         18jK2Ysneh2mIVDMWwPUQzJ2lQEiCG3lJrqxx3lTHLA4baoROjnHFa7oTw+oawc+yIqJ
         Qdqu8u8ANiaaw+st5XRhge4jzMdi3VgHaaoQHQ6cljWxV8K9Y6ePdcGyizFWy8M40guc
         AtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744646650; x=1745251450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDEi49TVTvNQTj4EltG8XtvLqTulTPsJjrOFrLNcq8A=;
        b=lMCMZF0H+uJA3jXXLe072KmgkVkrnYQs1yegdq4FF2vc00d4vSkAOhUnyZOkM+3Mhh
         nvkJ/qoPkR8I5a020oo/4oY3pvTz8JoygJ335IYkHxaB5QXCUWjbne7LD0+knHebZPUu
         /BZF2f8D8XxgDtN4iKx7rOPOVkxvJaJDBweah2erotjPwM52BDHSFQ7N6IroBGmO+4S7
         6juHFyFHu0fWIpl3sqp/PonwtcfUh2J/qbKPcHTcWnkCymLqQtny+eNFXinX7IAa/psc
         RiaE30J/8N/qOfNgiChWCccC0t83KtCXPL0liTsGxAyM0buVFq+Ewo7x0ErtVHt+v+Ub
         CNMg==
X-Gm-Message-State: AOJu0YyISYgr5K7VaWdZpd/6m2F/npE6pSZ1IbDNj2HqoDcXYzL9fvNu
	OL/c6NI0HvvoGip3LACzIhMZY7/CCnKazcYNOKSpObJarKZHsI0wS+1gHA==
X-Gm-Gg: ASbGncvWlODQGT5KrFD/KgLMKeFsuutu2gUqD6GyuDLrtjMDNQMT1voDQoo52IZOByn
	vmye9Deq//qvh0Icz3/AxaaBYhWyS2ESliXQ94Zrtetrj7LqoKv3UGVFeJlstolWRmTEFjsRH5L
	OtSJcq5s0RLpocF/+qZmSdCMySzlXICfRXlqH4IN0lz6W+3J1fsJPKjn/eWksjy/VFa2PF8OWds
	oXPT/mw+Flu+tYWNUqgTN2OoOGsa2lenJk0qCU7CvUB2XYz7jut2/fi37ow8n5BYWhCj/lvzzbK
	tl9ZQfLU6hNKakJ5lL/p9dS/NAfJEM9CjXf7lp79Fq3l276kXrXZHXAmG2Y0Iq3yVkEFhz34LBQ
	=
X-Google-Smtp-Source: AGHT+IGrFzR0uVqsoYHpt5vp07kzWPwEUBV66VJmn4BnfghjEQokV8FLxGCv6/WMHG2XvXAGMUM7Bw==
X-Received: by 2002:a5d:64ce:0:b0:38d:e6b6:508b with SMTP id ffacd0b85a97d-39ea51ee650mr9601016f8f.9.1744646649512;
        Mon, 14 Apr 2025 09:04:09 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:a9d4:af7b:bb5c:77e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae977513sm11258029f8f.42.2025.04.14.09.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:04:08 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/4] Make the "promisor-remote" capability support extra fields
Date: Mon, 14 Apr 2025 18:03:39 +0200
Message-ID: <20250414160343.2216312-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.158.gd3b09c1afe
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "promisor-remote" capability can only be used to pass the names
and URLs of the promisor remotes from the server to the client. After
that the client can use this information to decide if it accepts the
remotes or not.

It would be nice if the server could pass more fields about its
remotes and if the client could use that extra information to decide
about the remotes by comparing it with its local information about the
remotes.

This patch series implements this by adding the
"promisor.sendExtraFields" on the server side and the
"promisor.checkExtraFields" on the client side.

For example, if "promisor.sendExtraFields" is set to
"partialCloneFilter", and the server has the remote "foo" configured
like this:

[remote "foo"]
        url = file:///tmp/foo.git
	partialCloneFilter = blob:none

then "name=foo,url=file:///tmp/foo.git,partialCloneFilter=blob:none"
will be sent by the server for this remote.

All the information passed through the "promisor-remote" capability is
still only used to decide if the remotes are accepted or not. The
client doesn't store it and doesn't use it for any other purpose.

On the technical side, we get rid of 'struct strvec' and we use mostly
'struct string_list' instead, which is more flexible. This matches
some suggestions made when the series that introduced the
"promisor-remote" capability was reviewed.

Right now in this series, the fields names (like "partialCloneFilter"
in the example) that are passed to the client are compared case
sensitively to the local config keys. I think this is a bug and they
should be compared case insensitively, (while values should still be
compared case sensitively). I am planning to fix this in the next
iteration of this series. I am also planning to add more tests then.

CI tests are not finished but look fine so far:

https://github.com/chriscool/git/actions/runs/14449949491

Christian Couder (4):
  config: move is_config_key_char() to "config.h"
  promisor-remote: refactor to get rid of 'struct strvec'
  promisor-remote: allow a server to advertise extra fields
  promisor-remote: allow a client to check extra fields

 Documentation/config/promisor.adoc    |  32 +++
 Documentation/gitprotocol-v2.adoc     |  42 ++--
 config.c                              |  11 +-
 config.h                              |   9 +
 promisor-remote.c                     | 287 +++++++++++++++++++++-----
 t/t5710-promisor-remote-capability.sh |  67 ++++++
 6 files changed, 374 insertions(+), 74 deletions(-)

-- 
2.49.0.158.g6ac6832dc3.dirty

