Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223C228E5E2
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750375815; cv=none; b=byk36LTuG6YGsbmP/JDJfoWM4bOPpsplKGE7/CrX7XzeA6tUZdJqeI0ex2/PQMF5fr17ZK3iabaH1wMrCLHzDSKCSii5v4LKZIKhKWb9dHKuMnQd3bbrSZaBZ2RXvG2F1PqoJyieegeb5jcevhYZtzHrRq5gl8HvsVlvpUAZ9Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750375815; c=relaxed/simple;
	bh=WtlRC6QTsy8IYSTqRoSOuRi+cB5QKRNROX3u7WUOKTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnKMR3WnmtesfHkBwTl8WDt/Cp9Im1R96Jdt8whWJp7fFK6PYsSSf9mMuFci/pU33OBiDIxfutxoyjOgmm1ssnZ4UJBnej56Tk0+rNmtZaYjlVgSJtehlQjoKM8i0oaLyidtZ3Bn0AJ+c97gjlQwiD827qGK4fzMG7JszpgX55g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=WBP/FICz; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="WBP/FICz"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e1d8c2dc2so12920427b3.3
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 16:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750375813; x=1750980613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qhy7RM3AI+mqw6MCJwCNOhnSs/GaCK3wg6Sc9f2Vc0=;
        b=WBP/FICzE8YFiOk0Ho6tWooxZnE+7IXZKUr5pfOfUmdUR9hyjEymUzHrd75kf9xCva
         pp1AcSt+Gc7DbXCwRVdJd7+v6SQe5t4Tt6fWvUKv3ndMgzluyp+MEFEDkF8VhIXb48xR
         IjiMoC4ZyxUaC40kdKgp0Eo04+ve+HSEajXKe1AY01AYYhCV+gYeaVPN4rTFwtPQGQv4
         S62fJ9pGSHuwTowGr1B6mPDkwTsGo7fCt8GKeIjzQBNTqBhQW7+pFEYjs1yYGHPQjhuv
         2SWQy6bkDNiua62bf87bUWbAlPBFZAVNzlfLqmJOCAwKFBUS6uXlwnKmNdLYXOQsTXyx
         C+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750375813; x=1750980613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qhy7RM3AI+mqw6MCJwCNOhnSs/GaCK3wg6Sc9f2Vc0=;
        b=Qhi+fU+N8f8FI3KQzpA8KHtSxP+aiM9sYS7Dxo3DhGllt3/5PhRh4gNJ8d7hsDSZV0
         TE8fsjWdABZCwz6uRizWBDfWEWs4ixxxiXs3c6/ihkN2nP5SAWqUBHNsUurHJUlptizm
         pH81N0hqbnVKa03UaVnuZEZXCyMHUQ091LAaxIy7N2L16XWdrd18mGChtQ8uiwfZkH0r
         8ZTSUBBBPz6ZIXvoCiniWfz0Iu4CW+5gQNdVb0opdRXjoGcQNhcM6Tc/coxEp88EJlFG
         3QebSefUA9PqKQ6kWICmuQUMB3Cw7TnIJgc5MDoKUCLsANQCvR8oF2CL0kewdtuO/ohF
         Ewqw==
X-Gm-Message-State: AOJu0Yyzd1glfL+0KD0jWz7W9I7dxOMmKkNnNnGPWpW4Fj2L0kWdJROv
	1X00pB2QNOZpJFoCq9oymP4AYty9StZTdjyQleseKMIT6D9g7yiVA49vyFcCX4z1u9SJQjwN6cZ
	hhcjr
X-Gm-Gg: ASbGncvZQq/hsJ3ZMH3iSb3K5KAp6fDsf89s78ug9pq076u/2G5671XAlx0whNWTWnn
	Xg27I5jWvbPDO5ZYJguwzh8ILMJOp13IjtzsoT0xJz4VRrejbcEuhbAnBz6khBA6YPCw/EOlZCC
	jORqWlzGUVpVuYqHjjGHiM/dmwn74+YbCKrMDjnJaKw24riibge0Ntwh+nFBqVe+GRZwG8ep+Nn
	HdvVME/O3H49xe6QdA5w5u62bH76KoASBoM0BtmrksBkzAtIw4N34h831m/I9Mfiw3dmeif2Rfl
	kb6qxjviJeQs54GD6ujALSKaCRR5UETueUVPDPbHJcwaxeT8GFEB36zs9qpyLOCWEPQEnv/+uYX
	hA4N0rHtjcXDjg0YlPPIM2ZJLIAoG7QFd5g==
X-Google-Smtp-Source: AGHT+IEvPg8PJ8W8VoF3ByH2xC48vPozPRzFEyBCXU+XxEsrQf/A8AfSkR2mXvNrwuo7OExlgozXoA==
X-Received: by 2002:a05:690c:4986:b0:70f:84c8:311a with SMTP id 00721157ae682-712c639648emr14017167b3.5.1750375812782;
        Thu, 19 Jun 2025 16:30:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c4a2352dsm2054817b3.31.2025.06.19.16.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 16:30:12 -0700 (PDT)
Date: Thu, 19 Jun 2025 19:30:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 2/9] pack-objects: limit scope in
 'add_object_entry_from_pack()'
Message-ID: <eaa1f41b25bbee35cd8329792dee02a54560b8aa.1750375803.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1750375803.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1750375803.git.me@ttaylorr.com>

In add_object_entry_from_pack() we declare 'revs' (given to us through
the miscellaneous context argument) earlier in the "if (p)" conditional
than is necessary.  Move it down as far as it can go to reduce its
scope.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e7274e0e00..d04a36a6bf 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3725,7 +3725,6 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		return 0;
 
 	if (p) {
-		struct rev_info *revs = _data;
 		struct object_info oi = OBJECT_INFO_INIT;
 
 		oi.typep = &type;
@@ -3733,6 +3732,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 			die(_("could not get type of object %s in pack %s"),
 			    oid_to_hex(oid), p->pack_name);
 		} else if (type == OBJ_COMMIT) {
+			struct rev_info *revs = _data;
 			/*
 			 * commits in included packs are used as starting points for the
 			 * subsequent revision walk
-- 
2.50.0.61.gf819b10624.dirty

