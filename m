Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B10A2820CD
	for <git@vger.kernel.org>; Wed, 14 May 2025 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244252; cv=none; b=Qz0m2dvz9hpAMj7JMBAKAZrdOBvpU4BznS7iKi6l+h54beoC+OAJK4enCiVGXyDUvwUGjbGvyBhkQjF35B0Lj0m8JDq85lcAtofPTtccdd4UgXPk96gpqzT2rzlqgUV8BBJXBoOPZaLLcaIABvCYUTsmCrE1MpgGg3tr3IIgGAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244252; c=relaxed/simple;
	bh=q4GvZBaPZB6gO4HxL09BsQld8GUJwIMvjej/DF6U3tg=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=Eo6tt6oT6yFeOf73SYTl9MsGmIznjTqgD3+AHTdhd7oGVBRtN9PIbPiIA8NT/l17dV2Mb5hUBxfkDbXAmGPdohp5XvLg+RspA6cBNgsSGxn//MW+Czl+Gplzd4WJ+Q9ne/hAxrZ7oa+wOBGngduWcMoWQJsgF5NJXFlaldZGCcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLQZormw; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLQZormw"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8616987c261so235659739f.3
        for <git@vger.kernel.org>; Wed, 14 May 2025 10:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747244249; x=1747849049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:date:message-id
         :subject:from:to:from:to:cc:subject:date:message-id:reply-to;
        bh=1UCo/OvSUT7ti1wAPamdZk4jc4Qq98lvdmETjO+H8Sc=;
        b=LLQZormwxEzhLb/qaqPlgKdURXbWohAhl9ZoQfWP4QXsWAgojz5+fK/mvppK/Qdr4G
         RvM0TUrkavZExR4mXf3dT5KcKUbXy0ixJmk5Opz+I+ajL/KfgiS6M2AYe6txZ2a82au9
         D28nKA+wzaWEkDvTqvcIGkPNNU4fKw54m/e6Pl1Uaq3ypfdDLGwXqtf3tfGQL6HcZoql
         6/CJkbSnEZTyr0z9X4yyZX0DSbRHQXfc92KVYCbfebLCTrGXRAYLEtGfKmSUWJdFRXoH
         zrOpHYm72TLlDXOQKzJomcqNs9C4k2gwNSeiNAtCl/C28/zPsuww/YK4QmNSkPfiOgBQ
         APKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244249; x=1747849049;
        h=content-transfer-encoding:mime-version:user-agent:date:message-id
         :subject:from:to:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UCo/OvSUT7ti1wAPamdZk4jc4Qq98lvdmETjO+H8Sc=;
        b=uNr6aGonpeQ5OasNCJMRFwZIeMDTBWZzNrFPccpYrd51nrbTZYdJLJZDEnOgoWtnRi
         69ToHqmz5hxU7yLVkdlgOhcZsS1hIl7Jov0OukPBQwA7fSOn9yPpGFWlx+kuFbWNVd16
         k/zzB6doXH7Md1tF3BL9lU2Nm4t2/Bzi6E2ykP2fQ405LrR61XU7xXWBmFhpyIpJUSq1
         QGLN0h4Ui+vrZm+NwW0eA3F82I5h6QRS9bGWLQBISGGSI1ezuBwTRcYOJkscPgNNzyMC
         XomBUpo0sxv6E8pmxaBAOJnIUSVxcVroeOqd9ZcCYpWHr8BaSj6rha9OMyIi0ueyoahr
         IdXQ==
X-Gm-Message-State: AOJu0Yyi18UXY7o5mTB09HSJJhGVaVKlNSCIxgGrD7q8dHnKfnAj8dGw
	1kORXVKm1OG9Q+mmVJb/LgNhDOX6su/qfiuE/QdsaIHW1OihkDECFP5paQ==
X-Gm-Gg: ASbGncuzZNmDZJ2ffJvfUBCg0+iKDr7ni7Fsl70swC9qjP1zPXEV0li+Q1gzz056PIl
	4WyMJ1cDB3hcg4s7U9SMvba5SNmdUcOHgGJDwUWKzilGoQ+vOY8lUHAdbRkRh8Nw/VBvuPkeVz8
	ElWNWPoR4z+LsXZsjrfbGhm77KgaWHlcHcNQSPsmkHEk0kK0FoiEdaEVvWW8elqncQDtnLkYczJ
	IkkRDzDKtwLZ5B+gcDhnYyzqgjt3ca2m2jlHmRAeKpYW6u1yXgTzjO0lEZ2ICnVHLTcYaNeyKV/
	MicSKVnprciKMac6U4M8oF3PmM0uw4OkCcWtgYKtx7o7hU6Bi4SgEOHoHWoXvKnn5tSbN7TcYbi
	BYACkTySffWwLnc44px3BgIodyZztrMU/
X-Google-Smtp-Source: AGHT+IGKv0nkJy11apqWFFY+nbLGqag0NZKgJRvIEbP9hhsPDbXPQQEatoNxbR028unaq9HHKTbW7w==
X-Received: by 2002:a05:6e02:1a6b:b0:3d8:1d2d:60b0 with SMTP id e9e14a558f8ab-3db6f79b896mr53703765ab.5.1747244248693;
        Wed, 14 May 2025 10:37:28 -0700 (PDT)
Received: from [192.168.1.253] (76-206-246-123.lightspeed.cicril.sbcglobal.net. [76.206.246.123])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3da7e1049casm36012055ab.26.2025.05.14.10.37.27
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 May 2025 10:37:28 -0700 (PDT)
To: git@vger.kernel.org
From: Mr Bill <billc56196@gmail.com>
Subject: [PATCH] Handle rebase fork-point options in pull --rebase
Message-ID: <06beff46-cdaf-91c8-e6a3-6557694af618@gmail.com>
Date: Wed, 14 May 2025 12:37:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


This is a patch to handle --fork-point and --no-fork-point in pull --rebase.

I had a recent bug report about pull --rebase not working correctly...

but it was working correctly, but not doing what I expected due to always

using "merge-base --fork-point"

This patch implements handling the --fork-point and --no-fork-point options,

and also checks the config rebase.forkpoint value...

and it works to resolve my prior bug report issue.

If there are any questions or comments, let me know!

Thanks to all for the help and comments on my prior bug report!

-Bill


diff --git a/builtin/pull.c b/builtin/pull.c
index a1ebc6a..f2d405f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -117,6 +117,10 @@ static int opt_show_forced_updates = -1;
  static const char *set_upstream;
  static struct strvec opt_fetch = STRVEC_INIT;

+/* options to include rebase fork-point preference */
+static int config_fork_point = -1;
+static int opt_fork_point = -1;
+
  static struct option pull_options[] = {
     /* Shared options */
     OPT__VERBOSITY(&opt_verbosity),
@@ -253,6 +257,10 @@ static struct option pull_options[] = {
         N_("set upstream for git pull/fetch"),
         PARSE_OPT_NOARG),

+   /* rebase option to use/not use merge-base --fork-point */
+   OPT_BOOL(0, "fork-point", &opt_fork_point,
+       N_("rebase with 'merge-base --fork-point' to refine upstream")),
+
     OPT_END()
  };

@@ -366,6 +374,9 @@ static int git_pull_config(const char *var, const 
char *value,
     if (!strcmp(var, "rebase.autostash")) {
         config_autostash = git_config_bool(var, value);
         return 0;
+   } else if (!strcmp(var, "rebase.forkpoint")) {
+       config_fork_point = git_config_bool(var, value) ? -1 : 0;
+       return 0;
     } else if (!strcmp(var, "submodule.recurse")) {
         recurse_submodules = git_config_bool(var, value) ?
             RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
@@ -1059,7 +1070,17 @@ int cmd_pull(int argc,
                 N_("pull with rebase"),
                 _("Please commit or stash them."), 1, 0);

-       if (get_rebase_fork_point(&rebase_fork_point, repo, *refspecs))
+       if (opt_fork_point == -1)
+           opt_fork_point = config_fork_point;
+       if (opt_fork_point < 0)
+           opt_fork_point = 1;
+       fprintf_ln(stderr, _("rebasing %s fork-point"), (opt_fork_point 
? "with" : "without"));
+
+       /*
+        * If we're *not* using fork-point, or we don't find one in 
get_rebase_fork_point(),
+        * clear the rebase_fork_point info.
+        */
+       if (!opt_fork_point || get_rebase_fork_point(&rebase_fork_point, 
repo, *refspecs))
             oidclr(&rebase_fork_point, the_repository->hash_algo);
     }


