Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767835;
	b=tJrFaV50A9G2Oxj+h0WLzTBrlpIXs0u4HNU/BTbP3Rjm3z/GD5hlfiC275m6p7vboNCW
	 PZUn0uMWsGCpkQrVhj27CInVoZu+mqohjY5lf4brVi6xCs2dOzAn81lXo0J3lhtm/jiFp
	 N8EVTqQ54m1pUY+ZgeSpQXuoppeB7LXTUM8dQR06/oPrRsVHnieIMYg/92E+T58u07qtg
	 zPj/xyXvJ8+y0UF6rPKsh1YIqZT+zFSEahctJkTK9QaO95bxkS+MKQ/qPm5q0cymu9ck/
	 a4Wc9UnLWOu5c9LtXl7phDLjNx/uo2FJ2c77PNnJ7zo0lrZm0Kwv2CrmjsGq2a8BlGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PeV7UV/u1r7IiEDhNbXjPp/z6f/moa6f/wIr7LxXM0U=;
	b=Pb4t0jU8+UjGwkh4BZgcS4CAjSfHKcKpCKpUOeNnmI3dtqgRL0kk+SvJVCIXh8dRNswt
	 HFVyiDwJ/iWu9eGhtb6Q1oBg4UuYyHAragaIvDjniFxsKIXZuQwiySQbYP2bvPPpGi/0t
	 NFpHY1O4aGDWl1xWINnBCtUuPEsKyFadR4fcakPIMJo8Q27ozv4cY+OB/A4H1XRRJKjj9
	 LsBrG2+X/Zo9CdtNe7TDyQSUpQ0iSgv+QlpU0TKQtZUhdrze6Dtl2KjzCUDgYefHx/Fc6
	 UdZZe2saC3Me9a8ShK8q/SrmPvwHK6atRS0RKOqkxFozfUFfuL92wLQO0S+v6otzm/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hJD22Kis;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE61606A32F
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AE61606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hJD22Kis
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e3b22e971so359832f8f.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792767833; x=1793372633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PeV7UV/u1r7IiEDhNbXjPp/z6f/moa6f/wIr7LxXM0U=;
        b=hJD22KiszXK9t8W98AG3QUo7ko0uWVfaY7ui9ckdJE6vh5m+zTaLXb6XNV7O0a8i9t
         r6N4wRJt3zU7XLLzbo9Cc8TmAV3u08pfTX5B8TR2SnYaqkx73Q9w2l6RH5dlqTAj8x0z
         7ks15c2JG2ngQyTKrQYqbP7TEcZLQlt72FkuK5wBwyfJemM+kX//c1Ryy3Beb68Au/UC
         gNfQn2LC9mbAtrDfeox0fIjhL00yrEyz4ZMPOt4cf7ADkUdMrMMvxwIRjeXdosNDJtTj
         G9RbVWxKUnayo2RKTUQDAcPEucWQD3Zqqr8Xp2IebQIIFQyqMo0azwV/4a7xkFNGI6qa
         uIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792767833; x=1793372633;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PeV7UV/u1r7IiEDhNbXjPp/z6f/moa6f/wIr7LxXM0U=;
        b=ub025TZFf2cUiaR86EwKosBsmsvc1dVQUB84/VrIDqiwHmOy6MWwpJHIE4tW36go6q
         f/BagjLV8iVw0/ssi1p7qxt9/GvLqwJ7EFshzQOra+2HOViTwJ38iQgGMpAvAeWlI0SY
         V2mb/ha/uuGZvhAwR07wG38TtroVibf/1oNMryx0RQrdosDdnybV6+nhJKjHD+tJAGTy
         /Ada8vTMhigwNKqzukZcpgs3N3BzfYc9ymly0EIqpTPL8rmRonbzrdOoZBgFWL+eA4zc
         qxJApd6IFos/EqSROsv7DhqztQD1mkR8AOBimxGHsGNK4lT52gHOZu50NZb8EkNL24Mj
         E6xw==
X-Gm-Message-State: AFq9FYIy03VziOtOF+WI2fP1c5U5qHmvkbh9bR9oZf4Bx2NIRk6xbU7r
	or6clCg89RHOo/Vdb9qcsjI7LV75kLizzii8msrzrxfcVIQ7hYaKj7wHK1WNtQ==
X-Gm-Gg: AYBFou1eeDCG1hVFQ6vupezJ3mEaHi5vmg9vjvQvqjYPmJyVOvqHeunxcUPHrWHZrIl
	UQ9Xxla9jZ+OOKVpaf9p0YV+4GuRSnIieRP+UMBbxCINzErNLo2yHhCijLSQ926QkPJMM3HD9tP
	nJWVOJuaRwQSGmr8s2Vj5K/EyI9pMx93znVNaBEVil2OsbBEAqzvC1du7CbnULeZ5Bl7BsPItY1
	xUwP2bFOqztSsVQIgV5p0pCW38EdbSDMxTTpyeY0sNg10OHpaxMqp47oG5XyoIDAWVAsq8LLUl+
	/HqJ2jfCK0vY3pDh5JE89oRvZGSh0/aBvHSrjt3ObIBpquRGYTAid9DQD9puNKcT060wosk/Utz
	Hy4VUMJnR8fxn1DoC+8Vo5RYfrC9YjhYfJS/Puzd5S4mUVRy3BkD5njYDyh/sSg9BaSsJ/u2NnG
	Z7W2rYuzCfOstHfLpVhHRZ3o1ECejsE8rshyg7v/c1jeSARaZ0Pq2hNrVfrJP3i+KnmqYUM2nk0
	vFXVoz11RnGv6lTnD7jnEuRh0SDxiX3d0N1RfPEhW6xJVHx+S/lpiXh//M=
X-Received: by 2002:a05:6000:46c8:b0:48d:f470:6b31 with SMTP id ffacd0b85a97d-48e3859a8f4mr3004776f8f.38.1792767833460;
        Fri, 23 Oct 2026 08:03:53 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d427e68sm296326f8f.52.2026.10.23.08.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:03:52 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 6/7] stash create: remove unnecessary index load and refresh
Date: Fri, 23 Oct 2026 16:03:34 +0100
Message-ID: <8c54c118307cce6553929f5ff7242f85d0bbc733.1792767795.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1792767794.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk> <cover.1792767794.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

create_index_from_tree() is called either directly or indirectly
from do_create_stash() after it has loaded and refreshed the index,
so we do not need to refresh it again here. This saves three lstat()
calls per changed path.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index e17f75641a4..f97cd4771a5 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -384,9 +384,6 @@ static int create_index_from_tree(const struct object_id *tree_id,
 	struct index_state dst_istate = INDEX_STATE_INIT(the_repository);
 	struct lock_file lock_file = LOCK_INIT;
 
-	repo_read_index_preload(the_repository, NULL, 0);
-	refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
-
 	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
 
 	memset(&opts, 0, sizeof(opts));
-- 
2.56.0.134.g299a3c16181

