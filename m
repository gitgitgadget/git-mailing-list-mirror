Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B618C13B
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 03:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743476493; cv=none; b=bRBhcebffujJiJyTYH8s+ZMC5YklLlGPDgu4jLLjyXeyvutnK2hkueGSLOJM1C49UCABjuTQ+Xojin4hJyYlremYQo9/+N+kMAmc/XjUZpAODpG/vQQh4J569dq6TKP1XIHcyVs/vukJlGPRcgxFrHb+sukqJmQHiMSXqO8psqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743476493; c=relaxed/simple;
	bh=xPw38iO1zzm8zlX/X8HN/trmO6VbX6nHZb9tJJqN3v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzokLHjP2XxFYjKnDnq/mEWpTU+0Kc5LRNsPfqQsTE/e+vC0XqidejLbTmeVANEC0N0zJwdzSHbQKJSRNq1HtP5n9wJ5xXzqUpQAo7x6tzh1WUOCAv7Qtb67CRlU+lyJCWEGv+ch0X76j8mbWGeqnHq+xDw3w19fdu5HuI9OKhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CG4tqEc5; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CG4tqEc5"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6ecfbf1c7cbso21649306d6.2
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 20:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743476491; x=1744081291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5gy3N7/VPRS7kf0ESU2sNr6Kzwjzgj70g75lPICU+U=;
        b=CG4tqEc5QytoidDAHYBfLdm/NcPgLjjC3EbtSjcUN6DgAfMCNRMn2ZL14Ku7ds6Vpj
         laIk38WcmQ88tLLAvUO075L+q2HahqZO3DPra3vsBz5WLrx+24cL79RdSb7OyR1A7EIn
         J9rukTktaTz3hYOZpT0v+1MmF6y8rwNhHAtg8+OoLorAgGUmOmxtCqDmm+wVxtE2J+Fd
         Cl0ByJO6TSjOliofUrdPudA7edJ95q/oT+a/mT2ZisiIa8EIE7VWj/yfTgvy0jRGgZjd
         TDxqDYcYqe4Fa+d5xB2j/D/LqxqiGhgCOH/9iHyk/TuOyB1OHQMEr+5xz4JHcNtI9BYY
         Fopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743476491; x=1744081291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5gy3N7/VPRS7kf0ESU2sNr6Kzwjzgj70g75lPICU+U=;
        b=MdBym7saWOdQfCdYH6UdWAHSZMpCcjihIk+Vod7WAnhlpTuO3YdIxFuBPv8cikPMbk
         MMurp82pN+FqysbSQ1t9E8rfc2xokGP0So4SVFFh5STSfItaegXfNAyCbaaKq7BJ+gL/
         ToFAQw9el8U1xEOp/soBg1M8m48UeE3sHa0sXNFfN2laQpEeau9THnTDqFGRWZTE2h1R
         nAiBrvmi/5dtwlal9NZiHbUE4fkMMrZ+vIJPj8O9zOLXTTw4MMnR8x1GgQSbJWSVwBNd
         oFBTbCDVKzpzWpDCRUjfG/rcxaphoHLWU0Q9U2JyOvD4PU9OSKNNQ9qADm4frsMvosEn
         NHgw==
X-Gm-Message-State: AOJu0YwRKyVaiEPjF6BV99+B6HAJIhadSDOe2pc7Ou6bwFwcY7I9fi5A
	pkeX4ZpXEiV/9JvEDt/ZkypWd/+Wv046qzrh2vk1G4/J7Gu0U1Li
X-Gm-Gg: ASbGnctpItFOi+nWfzT4QT30XK/9Wd5B8EzZFcxJ1HFDsSaeRYYKE8xWmnYlcytN8NL
	2Ea23tbIPm8m4BiLwSqcqrxbvr4hgDxvrotnFVIG9eOiyO3z5zguvhumnwT/mKiw8oYWSPiCXBF
	iuBNgjTWryN6y7UOl4eiC2SC7KaX5BW07DpFepxMieJxtYeUZNhi38aisU9GhVz8sYpCIkJwjTx
	RD7faT2mQn/v0xajF5CKt/uLNkxbAoo8mU2J+BLEiWqeGjBJSw3YwLQuI77yEzT5yg3coz2blEA
	qMrBqjdaGN/becsfNZVr+B0JcoIy
X-Google-Smtp-Source: AGHT+IGEr4CEIimJLOLtnfr2r9FHiSc7a3//HKnWefxk1YGO+cf+3g5ebX5LfKEuQU0VhwV62/52hA==
X-Received: by 2002:a05:6214:1253:b0:6e4:41b3:497e with SMTP id 6a1803df08f44-6eed62577e3mr166019226d6.40.1743476491263;
        Mon, 31 Mar 2025 20:01:31 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:2644:5100::387])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec96284d7sm55209556d6.1.2025.03.31.20.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 20:01:30 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: j6t@kdbg.org,
	johannes.schindelin@gmx.de
Cc: git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v2 0/3] gitk: override PATH search only on Windows
Date: Mon, 31 Mar 2025 23:00:59 -0400
Message-ID: <20250401030102.297272-1-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.49.0.99.31
In-Reply-To: <5b09f1c2-be58-43a2-9908-7243b5207251@gmail.com>
References: <5b09f1c2-be58-43a2-9908-7243b5207251@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Restrict overrides of exec/open to Windows only, as
the need for this is Tcl adding the current working directory
to $PATH on Windows. Recent modifications to this render
gitk unusable on Cygwin, isolating these overrides to Windows only
both fixes that breakage andk reduces the liklihood of similar
issues in the future.

patch summary:
	1 - modifies the existing code to restrict the overrides
	   to Windows, restoring other platorms to native exec/open.
	2 - remove now superflous variable _search_exe.
	3 - fix the override code to avoid path search given a
	    relative path like foo/bar.

---
Changes since v1 - fixed commit ID reference for git-gui, otherwise
                   improved commit message in patch 1.
		   Added patches 2 and 3.

Mark Levedahl (3):
  gitk: override $PATH search only on Windows
  gitk: _search_exe is no longer needed
  gitk: limit PATH search to bare executable names

 gitk | 147 +++++++++++++++++++++++------------------------------------
 1 file changed, 58 insertions(+), 89 deletions(-)

-- 
2.49.0.99.31

