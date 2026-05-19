Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462BE31F991
	for <git@vger.kernel.org>; Tue, 19 May 2026 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202491; cv=none; b=mjL0cm01EPnBb0wEK3P2Y2wvEGHkmQTnwcJJ6WkPtBjrreKgl2ZB0hWowmE7x40P6HMZGhxCsVzGD0LKcoU9n0tv/Y6S7sr7E6AtH8YKK54KNcHD2EiDZGBNcgdZR7q47iJOyDNoTJFotqMI2ZBPgP1sa7IwPiF5+9M3KNCnD1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202491; c=relaxed/simple;
	bh=RcRx+RA6XY9YG9IX4V1BAexA1l6wSADSAB0fwGVfH2s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HqaOGLXQN9C83im46Lfum5Lam+2doQRElz3Ooo0S+Ap1RAEOEWcu6Z61O3nkoOFNCcDbHsmImk2ARSyZH7M/iVJ64NR+WgXUKbxThS79cFweCBvysRZRgpkEy1WUrQRYij4xfG/bpfaPlFlU7uBtakp2+byan4Op+iEcRowvMsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lU5HZlcA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU5HZlcA"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so21686285e9.3
        for <git@vger.kernel.org>; Tue, 19 May 2026 07:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779202488; x=1779807288; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/mUEj0wpephdHMSObPBe5gyzUcLpmIs4s4ymhhW1wt0=;
        b=lU5HZlcA/sjh//gQ1z9vz2aUFOAH4Jidsf0BpIxDzGkWjLQgHoG3yWpSzL6UbdEICo
         +Yd/ZewEw4qaXG8N84nQaSp7kaN2KIGY2I+/ysgjUMumFCGl29Ao8P+PqLCo0YOmhgn+
         9ENy4KAZ/n+oEeQ9aYbpDAlbg8tfkyuxJNdEBbOF9E3xTThv6tk8/7SWWd2oTw8HwrHl
         7Z/BNqgtvZys6nFq15LK4ojjXRyGXN95lOaAu6t7CXbWDuvwVTXaoXTAzU07eDB/9+N8
         R2+SRKA9sAJtGkycjIjAWqH5tcDc8slOVnhZYmVcz5bq9Pmie1CdLd6Md9hiGm7rEG2l
         uIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779202488; x=1779807288;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mUEj0wpephdHMSObPBe5gyzUcLpmIs4s4ymhhW1wt0=;
        b=C2LoRVZAwRPB5v0bTje1xGCl5bBjC4x8HFCoPd4ZhOsb4CRW1DHoa5VyPyZHAkA/ew
         aCAaOmFYTYgEvPlkbASljo2lsJOsCCNirlDVx/sLFEj1aPWvkbxhjt7uvz4XKkPTWnFQ
         I41+E9arUPL617wlV2n/pPifQAZQCAhQnxUzmfMJwVPvnMmTDP8YAs3dvumMVsnB9tWI
         3KHDybAXFwznal0zNA6VyrVYTPpKjtfF7wZm07/VSacCKrpNFkWBX4quj9n4XGxPetaJ
         O0UrGKVs8uDnIIkzEcfBgfb3y5gyVB8d3SOJeZxRnGgRp76r/IokMOxT/xOPc11G/nGY
         dpew==
X-Gm-Message-State: AOJu0Yybt0kyoO9LtI9niYYJmEzCanntkiQJMvysm+OpMA5J1rSMZJCi
	fWEl4+BIU/0cNOTNuikfOvL/tha9g+c6L610iKXpssNP6CaAvar1Klf9SM7Z/A==
X-Gm-Gg: Acq92OGT9fGB7oeNRPphs+7MP82XdY5es0kr0bH+YZ8IW9OP35K1zChQh0mRu++yrHG
	XllEf6w2izVWOeq+WcZX5V8xiAFdNLV89YO1g6lovP1JXpDAbaFHV/uWJ+8zaGREOsGTFYoBgdK
	nS5YzRPwltbZDz9poElurwtbKLgq68t9WuATzhEVPxZ668DB88/EYEnXJkKMRrzw0/L1xp5Q9Be
	CFBpzB6bp+t5MtJ60scoclHn8uLJEKHQCAila28QOm/4cKrJQvyr23zHtpjwxdz358tnbyP6Vg4
	2KX9RzKQNwYSf0eWnXLI2F55oHILGaoDWeATbRymdzQs2kj4+QBDfu9V4anb+zVi1qDn/zDJHZ3
	8Y8XGfENbAsws0uETEK46kZEchGgDjLBuiUZGCm3IFUEgJzUDb0bkUWcJKm41ixus24UroQkmNf
	Cmu5noUh8cZ5tE3IotevR4F6a6L88lXM6s4A7jN+P939/d2adwDdDfkQrlroOYeusIlJl6iItbM
	3d0Fo8ul1Qlp1hYafO38oLtHrjW36KwqQ==
X-Received: by 2002:a05:600c:4e87:b0:48a:768b:eea9 with SMTP id 5b1f17b1804b1-48fe60e51bamr328533585e9.4.1779202488329;
        Tue, 19 May 2026 07:54:48 -0700 (PDT)
Received: from lorenzo-VM ([84.33.159.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8d39esm336469125e9.7.2026.05.19.07.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:54:47 -0700 (PDT)
Date: Tue, 19 May 2026 16:54:45 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>, fox <fox.gbr@townlong-yak.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH] http: fix memory leak in fetch_and_setup_pack_index()
Message-ID: <agx5tblaCZNsYEBq@lorenzo-VM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Inside the function `fetch_and_setup_pack_index()`, when the pack
obtained using `fetch_pack_index()` fails to be verified by
`parse_pack_index()`, the function returns without closing and freeing
said pack.

Fix this by calling `close_pack_index()` to munmap the index file for
the leaking pack (which might have been mmapped by `fetch_pack_index()`
or `verify_pack_index()`), and then free it.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 http.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index 67c9c6fc60..c28be26ad9 100644
--- a/http.c
+++ b/http.c
@@ -2545,11 +2545,13 @@ static int fetch_and_setup_pack_index(struct packfile_list *packs,
 	}
 
 	ret = verify_pack_index(new_pack);
-	if (!ret)
-		close_pack_index(new_pack);
+
+	close_pack_index(new_pack);
 	free(tmp_idx);
-	if (ret)
+	if (ret) {
+		free(new_pack);
 		return -1;
+	}
 
 	packfile_list_prepend(packs, new_pack);
 	return 0;
-- 
2.54.0.dirty

