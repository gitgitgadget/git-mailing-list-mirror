Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930884052DC
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566870; cv=none; b=Im0nq0m4sGyLVVFu4bi/vIxrfN6yyAYyZOVm50qMDZgQIXHJhYhZumaiUy3ApU5pziWus3rWruZaF4tg9STYIAsnVm1lJBr5ehOv8waoz0WC5qC0HnvCCEKfYynuNunspoEksNuQ3d4dv5If9jInnymw1yah86u+rCPmFYO3PFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566870; c=relaxed/simple;
	bh=N0WMD2NEoMqy5ejZuH1H/0bwDUTiN/IbGGRveTwUV/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ICI/dlQQbDgQ2/H00Dc/xpxLXnnajKB4JwRUhu+7b1HaS+aa5PhTfJuNCCtEW8g9jFiWKnsKfn3F7FUSH6F0JWPbUP1K5XlI3h1rDW22ahCyLJhCZkUtAkM1gFxiOpYeQ9CItaz2ZXARRj/6+rR6Zfo+P5f1ck+XvKKD9//fzS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pXczfbzJ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXczfbzJ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c20e70a0962so490992966b.2
        for <git@vger.kernel.org>; Mon, 24 Aug 2026 03:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787566866; x=1788171666; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oQXucLS9JhhSbzwEWCxCwUTJ+50Oo1InaUmt4jFaezk=;
        b=pXczfbzJX1RgrSdgM3jzLS/bGxLWiq0ptH7Di+5R7rxVy/R4q/lLqlGz3pYpJO9SoV
         ncXcfi0E7+gJ+6m52nIeNPUeDYxCsf7Y56i3P8MhhAweXaVZz1c4hKU/M5HVU6mwBilw
         oJV4QfzmknbK2AgN8y+uerOR/lFko3Zi6CPxqAZ03/k6LujBgtey3c1g0JfNaUmh/96m
         Dujs6MxWyPqXiJQYYFyen19x9byPpM10OyZWTpqh6iFXUTHq8u9BhX5bXKJcgc0xRk/4
         /QYx6TcEVM+BN69/qMBPhA9SlEhMUrfohBzQ+QPkaS7ai7mgpLsuD4zLaT5oY75O8rYX
         NYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787566866; x=1788171666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oQXucLS9JhhSbzwEWCxCwUTJ+50Oo1InaUmt4jFaezk=;
        b=nG0bWNF2k0J6J5fHVxO89VZ4v/bJP9tqftY55wkdkBuWHk2eiHhvKXC2hppNhhsqPa
         oJZsxfyVbe7T5EtVUSnR7NHQ+oUlKiMx9FPWDnHVgdmxjSI6fWzVYtEXtEQWuZlsF1yy
         z9fuGFgtp6oJ4clyQcTdd/h0omCpoIn+QtssUWfCn+VedacARpDhjddOWXN0PEo6LEbr
         SdPi+5oM/s+7eDrkzXn0fJYqU7MrUkA7CENjcpiHTEZ2N0PZdWx28rgJPfO6F2cTz5Yt
         K2GZYAHX9vf3LAhOy5dQaLagF4p/CDYFalodVLjRryqd3+k7CRbTihkm0TQ33CKB+JbB
         WT5w==
X-Gm-Message-State: AFuF++mPVaYiDMDVpDHRF/OkhcIwC21jFXXBE+lg5Nh43JpEGB3CYe3/
	Wu+GdeLF3Id77n/S6fdWtVJjpTKF9L40C+BOMwXtwYzIEEtTLz7fT3X0
X-Gm-Gg: AR+sD11kH48iHuTYPWP0LT9J9FTE7hZlUwKpxR6GbnzAHb24IZOKd8HjTKFExOd/ch8
	vFcmC9Gt843JlYyNiJdP1gnyjrmRjpBH9kFUqSgHc/sXvipgZ/wmKsWIXo1jlrTwTauLDaQD91N
	pNCfKRyiHnm65D2d5KqPFZqE5BQXrKCmAMzLL2i4RG7kQVkD8MnWab8cMrabm/T0aWCjxBuM2SK
	bUQTsxoUeE/V9JqIpJEP9EARhBEOSL1fYXKB8Apz98AKAGiVbJWB2LcVcPgtK+rmRYE3AK74TZS
	QTkSS+8s1M4accf5oQjkUp8/nUtI1fV99+zpcTzZ/XOrM9Ag2OULXmWmL+VhI+NhbICKIDpD9t3
	H116GCgpgBAzyZzPKrVWqPvwodceD6FprDHKjClQ0DdluhUa8XYFUQQKhKh6dIZOU36h/0eel3Q
	6uKrF0wRJgJqYJ9YtplnQn3ZhAaMYLjBP2DaF8mDUCFRiThG9hRqhzQl8g+FGQHpEcwLR3fu04V
	IaBDKXCU9Z9oKZrkmdkSBF6fRc=
X-Received: by 2002:a17:906:5183:10b0:c16:84dc:9607 with SMTP id a640c23a62f3a-c246a704562mr2269966966b.19.1787566865663;
        Mon, 24 Aug 2026 03:21:05 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:d6d5:360a:4ee9:3f53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629a901sm1327677066b.25.2026.08.24.03.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:21:05 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 24 Aug 2026 12:20:59 +0200
Subject: [PATCH v3 1/3] doc: add proc-receive hook info in
 'git-receive-pack.adoc'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-758-introduce-hook-v3-1-499526f0a062@gmail.com>
References: <20260824-758-introduce-hook-v3-0-499526f0a062@gmail.com>
In-Reply-To: <20260824-758-introduce-hook-v3-0-499526f0a062@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 jltobler@gmail.com, kristofferhaugsbakk@fastmail.com, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=N0WMD2NEoMqy5ejZuH1H/0bwDUTiN/IbGGRveTwUV/k=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqMGw4ayUcsBxB4rNLHmo6r1v1R9tPgkrIV2
 AILCMJiLSTwQIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqjBsOAAoJED7VnySO
 Rox/8ZsL/jNsX0uOSFZ1URG/KT0aMS04vsA0hEbVqGlweA1xbwKiULI3SI7oxBR/RL0pZbyyxZA
 UNqd4Ry7OhG119yH0qdZshcyrSbi1Kv/uOjBwtV0nR+3wHiwA0QCbAoD4NiU0VCf304cSm902D1
 fZzkCBwTyNmPcMxe5LFNQfgB5vw/AY5K/KpJPb2HkbdQ28HACZrDun/YCNRR2hyvQtu1gaNqbtq
 N7Hj/EmS06ir3HXTAW6en76oEXE+xPdtXYMXCm50CxaUN4SYC82NsvR1jlbVxUTDg7l/6pzP8QY
 FNm/4OCvlww8W315UrZcbqRozlTadal+1vX4NXe3SbIzhFJS8wLl3+nyJr1jIs0mvmNcKO2Is8N
 JxuE/34rycJFmkanO/qiY87iq2rOAeBH07uX93RzWi06iswRYCakc/6AsOuZPqzQMo4pZRiMLgL
 Ng4vvNp9LNY0UrE3PXMZXW+lwQTwaM+e10L/UPIMj1jlw7FPI0jhmPdrJbEjuf7u0cNOatqSOu6
 Y8=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'Documentation/git-receive-pack.adoc' contains documentation about
hooks which lie in the lifecycle of 'git-receive-pack(1)'. Unfortunately
it is missing information about the 'proc-receive' hook. Add it.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-receive-pack.adoc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-receive-pack.adoc b/Documentation/git-receive-pack.adoc
index 0956086d61..4349487e6a 100644
--- a/Documentation/git-receive-pack.adoc
+++ b/Documentation/git-receive-pack.adoc
@@ -236,6 +236,12 @@ if the repository is packed and is served via a dumb transport.
 exec git update-server-info
 ----
 
+PROC-RECEIVE HOOK
+-----------------
+This hook is invoked by 'git-receive-pack' when it processes push
+requests. It handles refs whose names match the patterns defined by
+`receive.procReceiveRefs` and executes the actual ref updates. See
+linkgit:githooks[5] for the full protocol description.
 
 QUARANTINE ENVIRONMENT
 ----------------------

-- 
2.55.GIT

