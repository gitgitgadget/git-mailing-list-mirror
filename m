Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D3361F597
	for <e@80x24.org>; Tue, 17 Jul 2018 08:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeGQIbf (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 04:31:35 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:44051 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbeGQIbf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 04:31:35 -0400
Received: by mail-ed1-f52.google.com with SMTP id f23-v6so415398edr.11
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 01:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IHs6pWNYSw/0EFZGuolcwiIe9+rtWTn8b6KdRt0iJG8=;
        b=Q0TfPREqb1AAztdAcXNPbday1Az+X+JB1PthCdgsyGkMpWjY9NT4ZJNjOKitSjKdfe
         Szj3eMpVjq7wrzANvOl+SDqWeHz+4P8lwcQErUoUR/9ihxQzUOTagshkrPSmonR51+tx
         fpX6zKD7I0O7qGtbh9oexWbmDqC2Q5rwevGSnM88j6wuhS0SlpgDLq6ZTPMgSP/I44S7
         fjzYzk+Ey2d4LdSu4q2yT9HqqM5B1Qit0CbDvMsoT49fALdlZrTY0TLjtpAfgfRXYOwe
         YVGuvbXAIf+mbv7ixZJOSysean1exSvurq+azBL+PVToQgFsgXwmnfIJYd9peeKw7u8k
         Pl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IHs6pWNYSw/0EFZGuolcwiIe9+rtWTn8b6KdRt0iJG8=;
        b=eepWSRg7XFRJW3SLqLEQ9vx+fEOZ2Fy3svriQGgcoYco/6FH/o6VVrQ5luPoIk5U9b
         8XjeYvrTgHOf6IwANu0sH3iIfyWCSo3SoGuwI4bnfTGi2sV+G1klTn9BBhtXRAxpERiX
         e8SN82g7zGK8HJ4z0qp1xH8RpHJ9LXyXMTcVPYlETI9OsGbA9BiX0Fpe5BOXECgZCumM
         QoE2YJeQXuRa2+xopbJVMuzXDtx5U1I256aGGUhT/gcAfuw+jB4jgMfQh5mZDaFdoeYM
         EGj8DXWGaSTJqLGmmmlkC2+oqkysZKRfbPBxTe4xQZJ06RVH6uNTROnz1fzsVOEY0tRX
         HnbQ==
X-Gm-Message-State: AOUpUlHykwoi9UaImInAW8A+oCr9LbpBAbHMPheAEB96ab7gsnNzuHYp
        UuA3KjQKwccTTZDky9j3uGnWuQ==
X-Google-Smtp-Source: AAOMgpcWijIbEYWophj9wGWSCIyxkv5DAa1u3VIx11wJqUAbAIoMMCrIKSEqnNr2hC2qKNZbrssKsQ==
X-Received: by 2002:a50:c313:: with SMTP id a19-v6mr1180115edb.177.1531814414435;
        Tue, 17 Jul 2018 01:00:14 -0700 (PDT)
Received: from localhost.localdomain (x4db1ca52.dyn.telefonica.de. [77.177.202.82])
        by smtp.gmail.com with ESMTPSA id r5-v6sm230008edp.60.2018.07.17.01.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 01:00:13 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 6/6] submodule--helper: introduce new update-module-mode helper
Date:   Tue, 17 Jul 2018 09:59:59 +0200
Message-Id: <20180717075959.30594-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.307.ged6d6bc449
In-Reply-To: <20180717002654.120375-7-sbeller@google.com>
References: <20180717002654.120375-1-sbeller@google.com> <20180717002654.120375-7-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 034ba1bb2e0..d4cb7c72e33 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c


> +static int module_update_module_mode(int argc, const char **argv, const char *prefix)
> +{
> +	const char *path, *update = NULL;
> +	int just_cloned;
> +	struct submodule_update_strategy update_strategy = { .type = SM_UPDATE_CHECKOUT };
> +
> +	if (argc < 3 || argc > 4)
> +		die("submodule--helper update-module-clone expects <just-cloned> <path> [<update>]");
> +
> +	just_cloned = git_config_int("just_cloned", argv[1]);
> +	path = argv[2];
> +
> +	if (argc == 4)
> +		update = argv[3];
> +
> +	determine_submodule_update_strategy(the_repository,
> +					    just_cloned, path, update,
> +					    &update_strategy);
> +	fprintf(stdout, submodule_strategy_to_string(&update_strategy));

Various compilers warn about the potential insecurity of the above
call:

      CC builtin/submodule--helper.o
  builtin/submodule--helper.c: In function ‘module_update_module_mode’:
  builtin/submodule--helper.c:1502:2: error: format not a string literal and no format arguments [-Werror=format-security]
    fprintf(stdout, submodule_strategy_to_string(&update_strategy));
    ^
  cc1: all warnings being treated as errors
  Makefile:2261: recipe for target 'builtin/submodule--helper.o' failed
  make: *** [builtin/submodule--helper.o] Error 1

I think it should either use an explicit format string:

  fprintf(stdout, "%s", submodule_strategy_to_string(&update_strategy));

or, perhaps better yet, simply use fputs().


> +
> +	return 0;
> +}
