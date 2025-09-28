Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1C029BD91
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097332; cv=none; b=bIlLZULARqDebjRI1duNIf1WJt7009pA+nDyJtKbV2YCzLgc9YY2tDE3sJaft93qJcFJSF4Y7NHBqTaTZfrxqnlO6gih2q4QMt6DWac9lK0dSZgbUKvEvdeZjLyfc2KANuF1IHD9n82dbAHxN4hDleTsIiOz0gLdj+HQNm3ZDfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097332; c=relaxed/simple;
	bh=ZKxE2VF7cQUnCxgtROEWfw7yfPrwKbsot2CgYytGTSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5Rl2EzhuP/hmIoNA1c6tg0z/EQ9nUuR029m8wtyNwGqz24zpxQTVYYhdiKMBecFunFMwwGjnDyb99wNOzShGg+0USTXCdX+zC7lw79+j2I941NuK2DpjlqlVP8rNPHjLeF/aVkSDCjTsKqiYJgMdcwsBX+NVL8a894PFBX2748=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=A2ClTj0J; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="A2ClTj0J"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-633be3be1e6so3394646d50.1
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097329; x=1759702129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j/G0FUNbLutcdn3eeFyILOS9qbBinfGIaxAnrgg23AA=;
        b=A2ClTj0JmvQ72Qh9f5ustQgCRKVUcSGFJddaka+XSSpSrJ67eDjW4TV20FIkg6S9f6
         Q2W9pNTDhunKCkMB3d5GL/ijnbk7HugjvU8ZDD0GV9CBy3/6+lWD/mmqWrSiqZqaX54d
         c1igtFZO2tCug5V8i+v0uWpI8o+9DAhCl5yrCiPm/QpsmmMQuazdO8vsUffEEAbJ7Ns4
         m5tesddyfqAe7zdiIxhy1nigXfyt6u+Mzo0WfpwPBdNoNwtrcASGaxj6+1Dh26x1tdRp
         /gV+zfhX1+Vf6XGSR7eWN2I9V1ZGE1E5tuoxAp8nk9V700tC0T+eySBupJnFNQ0c+awo
         ACjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097329; x=1759702129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/G0FUNbLutcdn3eeFyILOS9qbBinfGIaxAnrgg23AA=;
        b=vBwDMQyPXh3swbfSY0fHFOK2AqEx2DWW+20+wucN6mYxL4y33lAvqLiEcfK1oKGPbQ
         u7SFWD4voqoqbTh30IAwjAwVfKmpZ0rBwbbtEh3FdQUScTx9KbbOvBN7+VG4HT9DNhps
         GB+4qHMHcgzcW3F2W8B73f142lmbLP5ZxU+pMBc6BI4lVFzWge0CWnd009VNJXUtB6PA
         YmpLfgCBMGwdaNPsB1QbLlo3DuUco7xT7fRumHZgkwMBy+p0GCikJlOe/XrUqHByUw+b
         G/ry3PORUnF6lmNX03HgKnJCeyIlWYQTsLUh/qX93p3zFZ6frmVV8QUVyH+jbuCH7cJ/
         Fypg==
X-Gm-Message-State: AOJu0Yz59jXaW8hJCdzDJ+NRdcKR8drj9/1JjaHhgshqKJ4P1Qf7pJ4g
	3p58FtHBFCdWp7M67Mq6wGdxIDyeva1bC7ASJucbDIjyemXiqXJVcRpJVIZK5E0+YUOXVHSws9B
	EUEoj7b5hcw==
X-Gm-Gg: ASbGnctLEYO/yXtJcT7/1ypKCL9IIvzMNQ+gxdH4FcD0ZuTmblYCmgA5uUhbwhLXcjN
	M4D7LK+WYjyY7zU+MQk+R9jli3h8Q383ht74LvwLRhMUiE6IXR8Kup11yGBMWpBGVITU2v7+V+5
	mWQi4vg8k3+iaTOSElndoxK2VyqLVjQwyHujCQfierhPz/wnM72faI0MduLJN0TTdR8dDmC7uBs
	vsV21iRgFJRxRrgFRYc9+Qjqq0L73b9AOi8HkIYUAHPySrZxhLjFdAtR4QB2RUFlbqsyA7uX7Yy
	hXbF4A7oo6J0I2oZ8rsTK5dhpAK7S2nGAegumIJtc5KdV+90qpO1yMsYnBWe+AykF6OPatg6CYZ
	rV4nIxvUAb0120fjx5e8cqUpCLATz3jCErGkYqRsqwf3lM8ntexqTs9xKpgkxxX4bYqCd5RiLMT
	mqpaPoqvw5GQD/KecMtVjs6kU9cmuFmVRO8pz+
X-Google-Smtp-Source: AGHT+IFjhcrtkZ357URqoNOMIDnZ9aznCdMkBxc+qFiZVlGHYsa5f8Ra6vKLQUdM7TMpV14InvmvPQ==
X-Received: by 2002:a53:d008:0:b0:636:2128:36e9 with SMTP id 956f58d0204a3-636212837f8mr14339709d50.15.1759097329333;
        Sun, 28 Sep 2025 15:08:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-eb38394da1fsm2936870276.29.2025.09.28.15.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:08:49 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:08:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 25/49] builtin/repack.c: pass "packtmp" to
 `repack_promisor_objects()`
Message-ID: <67effcb4ea8c02198194f452296e2f16dc717599.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

In a similar spirit as previous commit(s), pass the "packtmp" variable
to "repack_promisor_objects()" as an explicit parameter of the function,
preparing us to move this function in a following commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index b7826e676b..ca7658e38f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -136,7 +136,8 @@ static int write_oid(const struct object_id *oid,
 
 static void repack_promisor_objects(struct repository *repo,
 				    const struct pack_objects_args *args,
-				    struct string_list *names)
+				    struct string_list *names,
+				    const char *packtmp)
 {
 	struct write_oid_context ctx;
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -1199,7 +1200,7 @@ int cmd_repack(int argc,
 		strvec_push(&cmd.args, "--delta-islands");
 
 	if (pack_everything & ALL_INTO_ONE) {
-		repack_promisor_objects(repo, &po_args, &names);
+		repack_promisor_objects(repo, &po_args, &names, packtmp);
 
 		if (existing_packs_has_non_kept(&existing) &&
 		    delete_redundant &&
-- 
2.51.0.243.g16eca91f2c0

