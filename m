Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BCE2080C8
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764436943; cv=none; b=Dm6DhCzK15ZmHyrleRl9bD+rAMmcwHSU4uKJd4ZZeBeh16sHL4BFzLjkXSUTh5IAJmn06bL7lBVMZ1+8lL410yPh68QHA7CnIdC7rtFdXh5By0PXgItrRPSrziEuZBLxf9t6EBBUOcLLzlhq/eQNhnO2YBy2/Tv2ZzjCYjETMpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764436943; c=relaxed/simple;
	bh=0p135i/9tahzxPTArfPHE498N8JbFD+UlYSI+VtVyO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOafLcuq5STiVobiGwvnG50oHZxrEasVIP+D5p4jYRZwH3WkRx4iRJtd+jO7IZLCB/2gMmMMkHfs1VadibWRcT+6xK1grC0+TkhaufkRZTs4weMzckBbixpvcl//th4SZ7WYg4kzx09jK5bTT82PKA7oQLMRfTGc+8GNqh0gvwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4y3aMcf; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4y3aMcf"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6430437203cso398030a12.1
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 09:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764436940; x=1765041740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qkr+xgSEQkA1ZgjZzCh9imFLQvPtKqf8mYQuZfCgSJQ=;
        b=h4y3aMcfGtQ5RqLwN+p6EEjT+r6FwqjA1Op5JGSYJ/yxysaPO3Skbr4LgXrQ1RNLWm
         mROjQAmR8K1PtNz8fTpVWjZyQyZgFQHITdy8UtJJRnPzYsY3khUmvqLukwVdWMp8n5wV
         nXKnPrAoK5bKTiwAB97A+cGt3mVP+DonI6483Uzmnyj/oT+T6evi9zp7+U2oVaOUO02l
         Hcu/f38DgNNC6f5ZeWQ05sOiTFO0JhCxOSp9JqYh2U6OunVmVTtqyoZxXvud5Ffij16O
         7iZwyqAz61iLZwKN4qBG4WIuCNxJwHnSOEohEVoFXOi/09pDHoiqZ5XwEyfrwuSuRrPS
         85RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764436940; x=1765041740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qkr+xgSEQkA1ZgjZzCh9imFLQvPtKqf8mYQuZfCgSJQ=;
        b=AGlGd6yyHk8iVyMfnlIhFeDoRgvoUiytrFE1393JoLhGjr1q0qB49S+e9ftjCyuHaH
         peIA4e0AMX6zoXGG8BPq2IwUjmUSzz3bue+3Vx+1HTsdHaknGomBzkYOHZgquuexcG89
         lTMa5NY7FU+xRdP5tgNaq20q+kupQ9urwD3SSdfeD38iyk9IW3lS83qx4Uf/fp1MGOUG
         1+VRIlFOWXr6PDjc0pQTGp+72ZqTDyj7AgOKE3o44IN0wBeDYPRUDRKnFcgGQywZWfot
         WQEY0t9swxIvuK/XFGqO0ePQ/ZzIBybdBdfzEDc+V1n0T8SlwiXGMffbkQEt52dp9wsJ
         V5Aw==
X-Gm-Message-State: AOJu0Yx1noDxjumiMuHMdYi0uLqhpMLhHLX0bI2noaKCZ3/YNx/rYp9H
	e/E4B8iZ0X+fxIMNngZsQriYvvy6GsV/4bibI4acEm14Mk8Jo1z395YrBh/VOxJ3eQOAIQ==
X-Gm-Gg: ASbGnctmn8JUL22dF2HYKGV4LDFFIqDQsZIcp7hJukbdorXBJpWh/KOEYQjn9K/ihF3
	tXflxT4mut2u+0p0zFoYDVthSqeTS3j83ZWt7q1dlfZ6TEonnhetYTmvhmXDgiaJUW+RcENOAwG
	lgEaH6l50ytajhJe0MUC5Uo04PP02aEcmlem8np29EGq3GHQZCKZwCGBhpIBRT+e6mDe62TKPX3
	bn5xXNOF0/f6U3D1tVWuGSoA55N3LNlaKNPIHhzfcQ9FvV3v/rVibXkuE4ZhaQoPPdD3ebSNn6t
	OuiBqmvjfB2ZTYXzY0G+y37mYQ9hYISHELKWX106PHMm09kqI5t2E5BZQZ4PifFJ/2juPmeR5f8
	mqXLn3LwCpspGlPNpuY2Ipc5GWDj4FZsdT24MRfE4pMsWCgkA9Z+kYbvH2Dx5QnO7dEM5h0bzn5
	N4orpqMJcetCMtGK/b
X-Google-Smtp-Source: AGHT+IFLN+9eHkByT2uR4dKYuBtI8TKxvKZQGD3R96FXeV57S2ge9OOaUIbJBOVmzevXkv0F4SRPpA==
X-Received: by 2002:a05:6402:5253:b0:640:b6ef:9dce with SMTP id 4fb4d7f45d1cf-6455a0a9f04mr16270013a12.7.1764436939378;
        Sat, 29 Nov 2025 09:22:19 -0800 (PST)
Received: from archP14s ([194.127.199.107])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751035c2fsm7321964a12.17.2025.11.29.09.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 09:22:19 -0800 (PST)
Date: Sat, 29 Nov 2025 17:22:18 +0000
From: Matthew Hughes <matthewhughes934@gmail.com>
To: git@vger.kernel.org
Cc: Matthew Hughes <matthewhughes934@gmail.com>, 
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 1/2] scalar: add comments when setting config
Message-ID: <20251129172124.4164-2-matthewhughes934@gmail.com>
X-Mailer: git-send-email 2.51.0
References: <20251129172124.4164-1-matthewhughes934@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129172124.4164-1-matthewhughes934@gmail.com>

This is to help users understand that a change in the config was made by
`scalar` (and not e.g. manually by themselves at some point in the
past).

As discussed on a thread[1].

Link: https://lore.kernel.org/git/aMkVqNbdgxqBJ9K4@pks.im/ [1]
Co-authored-by: Derrick Stolee <stolee@gmail.com>
---
 scalar.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scalar.c b/scalar.c
index f754311627..4bdf8cf121 100644
--- a/scalar.c
+++ b/scalar.c
@@ -19,6 +19,7 @@
 #include "help.h"
 #include "setup.h"
 #include "trace2.h"
+#include "path.h"
 
 static void setup_enlistment_directory(int argc, const char **argv,
 				       const char * const *usagestr,
@@ -102,8 +103,11 @@ static int set_scalar_config(const struct scalar_config *config, int reconfigure
 
 	if ((reconfigure && config->overwrite_on_reconfigure) ||
 	    repo_config_get_string(the_repository, config->key, &value)) {
+		char *cfg_file = repo_git_path(the_repository, "config");
+		const char *comment = " # set by git-scalar";
 		trace2_data_string("scalar", the_repository, config->key, "created");
-		res = repo_config_set_gently(the_repository, config->key, config->value);
+		res = repo_config_set_in_file_gently(the_repository, cfg_file, config->key, comment, config->value);
+		free(cfg_file);
 	} else {
 		trace2_data_string("scalar", the_repository, config->key, "exists");
 		res = 0;
-- 
2.51.0

