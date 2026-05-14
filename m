Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AFA399892
	for <git@vger.kernel.org>; Thu, 14 May 2026 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759840; cv=none; b=THNSs71E2GFtjp3xlnZWNpxBUNwVDoOhFztWXD+pIYAEJiksS33ln5eRJLsMVNpXwRYw/DcsmNBXEeED2K+kPzWhe8CwCx/7YW2tQ7aK2DhDCAi+mtsc273YJrbdIz21KA9RGlzoaHoNErf0R1t1SPM8og4RLMAvcqCusAaCy9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759840; c=relaxed/simple;
	bh=xHRG+Lk+8gybaTzTd9Q6K6aHhpr2xfXxRGNmVFsR9mY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kfvmuRi49rbuJTu7bb3EGWtuqVvZjhQ0ecbPXqXfdGUXjF9qVpHcMei1d2J8rfy3zJ/TH3IU0BLyvqBJ6jw1DnMsMHyZFUXjd3fqcL7+eVUyedmT+FNevy9I8UPYK6zDWThTlwaNVZD5QaFy7uPtZ3wwwwJ6A1t4qCJiNtlQeqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=B9LUHWnE; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="B9LUHWnE"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 64EBv2iL011555-64EBv2iN011555
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 14 May 2026 14:57:02 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wNUgY-007H3A-Ig;
	Thu, 14 May 2026 14:57:02 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 14:57:02 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id a56148cc;
	Thu, 14 May 2026 11:57:01 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, Tuomas
 Ahola <taahol@utu.fi>
Subject: [PATCH v3 2/4] approxidate: alias "today" to "now"
Date: Thu, 14 May 2026 14:55:18 +0300
Message-ID: <20260514115520.6660-3-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260514115520.6660-1-taahol@utu.fi>
References: <20260512145430.13212-1-taahol@utu.fi>
 <20260514115520.6660-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-14.utu.fi (130.232.247.54) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhbSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFlbSBgNDg4oGA0ODkYGDRxIWA==
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=9eBe+CnQpUPs8xb5HT4ol3ADE9Iy8X0JtuzTvaJrE3M=;
 b=B9LUHWnETUjVzJXYjXhtgZ/1c43fsjrKoTZ3Gx873m6Veglr7XVC9J4NXpJjS4VOAq9Y/HK5TU/S
	ECDezMlAcEkz5tVSy4fQNbBdin+Cbtx21RhjScqlaPldwbQCh00TNGlLaaHisuVE4X6KNBXB358M
	s9Z3HEatstBgmEzkaNbdiQ3s8py6id5KsUz4PLZJ5BlKgW0u0h4oEwCwaD63L1MMNIs1ozgKIEx/
	E9YIIqfnI588wMwskYGMYvC90vEhIl+h360Io+gNoAf7zuJS7nfrEJR5NIGZa/QNUnwq6I/4cLp5
	iIjS2v4+haJKeuciMY0SILHX9PWAdAaJb+IsxQ==

As far as approxidate in concerned, "today" is a no-op.  That makes
it functionally equivalent to "now" in commands like

        $ git log --since=today

Make that behavior explicit by binding "today" to `date_now()`.
That way later patches can give "today" some functionality in
cases like "today at noon".

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---

Notes:
    > Hmph, this may not work very well for "git log --since=today", which
    > you may want to stop immediately when the traversal reaches a patch
    > written before the most recent midnight, instead of stopping without
    > giving anything back.
    >
    
    Sorry, I don't know if I understood.  Does the patch change the behavior of
    that command somehow?  Is there some kind of edge case I missed?
    
    That said, if we do want to change it so that "git log --since=today"
    worked like "--since=midnight", this seems to do the trick:
    
    ```
    static void date_today(struct tm *tm, struct tm *now, int *num)
    {
    	if (tm->tm_hour == now->tm_hour &&
    	    tm->tm_min == now->tm_min &&
    	    tm->tm_sec == now->tm_sec)
    		date_midnight(tm, now, num);
    	date_now(tm, now, num);
    }
    ```

 date.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/date.c b/date.c
index 17a95077cf..412aca6dc4 100644
--- a/date.c
+++ b/date.c
@@ -1204,6 +1204,7 @@ static const struct special {
 	{ "AM", date_am },
 	{ "never", date_never },
 	{ "now", date_now },
+	{ "today", date_now },
 	{ NULL }
 };
 
-- 
2.30.2

