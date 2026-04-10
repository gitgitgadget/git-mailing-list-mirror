Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A62033C1B7
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 22:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861705; cv=none; b=mHXl2FtjpZJKdcMPdj+2edHjs/2nAp2wZuIUAs7ne0Dija9soQHjGGr8U0O1ron45V6NZJXDDcxGo7t4eMzJKOfDQx+nzr5XrHtp5fAuGfuHW1aB+7x+8acGMF3m5ijtYnatYQNFLlcZNf2MUVzBj7l9s5eYrypxICywYnaJohU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861705; c=relaxed/simple;
	bh=bu4KNikspoCiRLwChFUaLjk8Ez6G6gmhx0lanuQE7Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyZBfOh3s1qLyrfEoiLJZAaex2YQRcNsA1JXrHKKd8PKk0yusY7a5MTswBvHj2+3B0vwAKYqP1gkPJEFXVyCv/jPg3kx+4liiJsSPN9rr+2YsiysTmpKwfzv5oCoCgXk+1LuLU8p4+jpQOGvpU/KLY3Kt3dNTea/ry9Ihj5kvkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELiL3Lfo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELiL3Lfo"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488ba6366a7so31316565e9.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775861702; x=1776466502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HnYNiI3ypsBx1lGM8mKlAHoHfCkfIOXArh4E0TVYXNk=;
        b=ELiL3LfoiF6kgzq34cN64QGogkYvliYZH6p3wvirUEsWwQcZefUk6sNj4Kq1TnmtOC
         aerdx7JoYV0Z6yheeFyLo3D3YaSz6FuzNGTiOZMK4uO/zql2Zv8I/1CDTxRVo5AbwhAO
         kHqeB15Ykf49JWTrWKspuafebm/KSvDf7Ym+Q8N6mNJ8ZoAwsDiEmECymn8bTmvv8+z6
         c/2LOfcjquLAI46VJYbnHJVSO0vP8238ro3a2JCznu+n1q30xmkVKgecGx6QcfmbTrwM
         OHSrFDLlOu9XlJDwglUMcOo9/jRCpi/N0AGVH5jILodQAECldbJVPPQ6pl8+ibhO4Gh+
         a8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775861702; x=1776466502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnYNiI3ypsBx1lGM8mKlAHoHfCkfIOXArh4E0TVYXNk=;
        b=QEvSZHpiLfgexMm1knatUEB4Bh9lzQcXHoJM2YzjqIzSxSYfa9LxZhRkZcmiWm/MYK
         XLDlwsqvaH9xnDq0nFBkpI+vfUKOdYF1ZUw6yKSKbXTXRVM31BCi9YweFvLUsWiryEjV
         fjYTgfOwdGoH1MpbEnbkTQNLrauej2xCI7OnjjqFj/Z9hkc8tcHI0Y/bKWHc4H6vdlEI
         KRA7tRn6xJwAeG2M+edd8dG2Q3T8WPfLPxo0EXSgui8xDZg2KQZvwNClyPrEjGGmFFar
         BauPhLRhhDxpsZGRFfzay2cqMuoKJokCF3fWuqfxZhmhcWS+jP7iQXcE4NB71UNO5DqA
         Qhjw==
X-Gm-Message-State: AOJu0YxdBgFVqUy5rjnsEgP5mH05mcP/U/pZOFFsBznXRY3W1bnqBkn9
	ST+Wh7Lvo5z8gWMsDRoDSDXopHZpWzyo/b25eRXUHad3BQ7FAh5WIg3OPNJvrdcJdvM=
X-Gm-Gg: AeBDieueDUMMJgIypCBE/7oD/uC8iDHKrGHuZpsH8y/Nv+xe7RQiswt6CE26nY2EY3M
	VSF/oT9pcXCKdkaDoc+19NWDyphFFn4QRgpVZGLxyu8i9oIyvZMkhZX4jhguLiBHubbLO1rsOZF
	Gu+Ww2ZIePRGfI5KO2S+uoPBd8OaXjA0xUzWKUjFiuf7sirNmAK5S8T2b5D2uUVZb5R1DO4Q0jj
	jeor4JggxLeYg1/T0EK090XwY5wx32IhWFan/NMXlVsDd5p46uEef9jEe3OY2MoYyPe/ysepDFG
	3VPzm671Nl8rP1FHE5F0nHf4drsDPfIAdKHxpwkc3C0zFU2d9UCVx4x4rYCjRippcKr570HVe5c
	n5QkZ8SZtezz4w9bdHeMqoR3yaUzstJrDeHQGk18vREFtmr74sL1OHnqA9iUgnwEn4ftU8lGXX9
	xV9i34ksX7HOQI9r5e7R2IhQeA/Sw4jiCN
X-Received: by 2002:a05:600c:820a:b0:488:b675:360f with SMTP id 5b1f17b1804b1-488d6889a6bmr57149675e9.27.1775861701727;
        Fri, 10 Apr 2026 15:55:01 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5b56d1asm105830905e9.15.2026.04.10.15.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 15:55:01 -0700 (PDT)
Date: Sat, 11 Apr 2026 00:54:59 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Tian Yuchen <cat@malon.dev>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: [GSoC PATCH v5 1/6] pack-write: add explanation to promisor file
 content
Message-ID: <b4990fcdf0759dc8f0e95b497daee54e08b09e0d.1775861047.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>

In the entire codebase there is no explanation as to why the ".promisor"
files may contain the ref names (and their associated hashes) that were
fetched at the time the corresponding packfile was downloaded.

As explained in the log message of commit 5374a290 (fetch-pack: write
fetched refs to .promisor, 2019-10-14), where this loop originally came
from, these ref names (and associated hashes) are not used for anything
in the production, but are solely there to help debugging.

Explain this in a new comment.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 pack-write.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/pack-write.c b/pack-write.c
index 83eaf88541..b8ab9510ff 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -603,6 +603,15 @@ void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_
 	int i, err;
 	FILE *output = xfopen(promisor_name, "w");
 
+	/*
+	 * Write in the .promisor file the ref names and associated hashes,
+	 * obtained by fetch-pack, at the point of generation of the
+	 * corresponding packfile. These pieces of info are only used to make
+	 * it easier to debug issues with partial clones, as we can identify
+	 * what refs (and their associated hashes) were fetched at the time
+	 * the packfile was downloaded, and if necessary, compare those hashes
+	 * against what the promisor remote reports now.
+	 */
 	for (i = 0; i < nr_sought; i++)
 		fprintf(output, "%s %s\n", oid_to_hex(&sought[i]->old_oid),
 			sought[i]->name);
-- 
2.53.0.584.ge8720aaf12

