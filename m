Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5045C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 07:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbiF1Hmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 03:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiF1Hml (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 03:42:41 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE04F2A736
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 00:42:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eq6so16268646edb.6
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 00:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Q/ntnzjbXWAdvlOLrI0EzLSpHHoArP4VBjWFvf+XvNs=;
        b=nlS6L1P1FzNEooCctDShaIsGtCtsn26TiHQsbSTCkA8gyN+FRNimHvmtgHTq58TYCw
         Vs3daE3zmQebd2CfU0upexpCircHlckhZoaDAkGJisQS6EfwzSqKMmBDRUkyO01Fjlkl
         K3PiD6SjEFbPYr5RrX1lEV5jhwMAMV9VzGNqkVghlEuZYMOMLNDscRvlF6asn9T47kgh
         5xCGLNBpGCo6rjnOU6SfcyexTXZzdLxai6NZ7w7SwpD+wZXjj12ifgSz13qL6HtP1PVr
         GL1HVjm2wcft6gwqzN5Te1zu2ntVK5FX4KBzjqAN/r+iYdcnVAVSKI/mhNBN/m9B17EM
         3e7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Q/ntnzjbXWAdvlOLrI0EzLSpHHoArP4VBjWFvf+XvNs=;
        b=SH2OeK7SByWIF0M5CogIYdfAQYhjZ483/iafqW2vMqrm8E1bKxHAsFyO7A3RCBqx0y
         111eoSC8U1B+kVgbkSV97Yimfoc5PawHfVdJbsvvxXsjv59MgA7aEkDSQTrNMqFVFmdC
         UtfQGDNyEksoVrcsbT/kkCR0ydrQpsFiZHrHrZx3jMl8rMGidtKa78yfX2epBl3YoMuP
         kfYppva/VDkwFAJKmteGVForve2G2+mvkL+z0MwzZ+sc1cT56fDJLybPaBjAX7cJmMJu
         EUYkfczqqwMU74S9D+/2XJ3dFJn6j0AGbkgnbzhsrbhsrZ2FJonJ0Eg0BpK5cG1kCg+I
         +rYg==
X-Gm-Message-State: AJIora8RaJ/qRKPQlkFS/0O+XpWc9Scjflso1qrGKldM4S60g8MvQbgq
        THUY6FpM/KS1U0MnC0hNQAQ=
X-Google-Smtp-Source: AGRyM1v0y+HWQT2sifTa6xIJeMa/9ecLPLLQtHlx5vzd8H7dTNx39jvvqvJ7rWtDQRtijvRMBaignw==
X-Received: by 2002:a05:6402:3323:b0:435:775b:aece with SMTP id e35-20020a056402332300b00435775baecemr21675742eda.210.1656402158367;
        Tue, 28 Jun 2022 00:42:38 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id e5-20020a056402088500b0043566884333sm8987366edy.63.2022.06.28.00.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 00:42:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o65rp-001jJH-3n;
        Tue, 28 Jun 2022 09:42:37 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Manuel Boni <ziosombrero@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Missing completions for the 'config' subcommand
Date:   Tue, 28 Jun 2022 09:39:47 +0200
References: <CAKP36g5G6KBEn8C+H8rxj5atfm2RKTfLAPtVveqg-8r4nqbxRg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAKP36g5G6KBEn8C+H8rxj5atfm2RKTfLAPtVveqg-8r4nqbxRg@mail.gmail.com>
Message-ID: <220628.86a69xgro2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 28 2022, Manuel Boni wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> 1) Start Git Bash, and optionally use 'set -x';
> 2) type 'git config incl';
> 3) attempt to tab-complete the last word.
>
> What did you expect to happen? (Expected behavior)
> The list of available completions should include the 'include' and
> 'includeIf' expressions.
>
> What happened instead? (Actual behavior)
> The expressions mentioned previously are not present.
>
> What's different between what you expected and what actually happened?
> The list of completions for the 'config' subcommand does not contain
> all the available sections.
>
> [System Info]
> git version:
> git version 2.36.1.windows.1
> cpu: x86_64
> built from commit: e2ff68a2d1426758c78d023f863bfa1e03cbc768
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 19044
> compiler info: gnuc: 11.3
> libc info: no libc information available
> $SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe
>
>
> [Enabled Hooks]
> not run from a git repository - no hooks to show

Something like this patch would fix this, since we just generate this
completion list by scraping Documentation/config/*.txt. See
generate-configlist.sh at the top-level:
	
	diff --git a/Documentation/config/includeif.txt b/Documentation/config/includeif.txt
	new file mode 100644
	index 00000000000..7f7513e9197
	--- /dev/null
	+++ b/Documentation/config/includeif.txt
	@@ -0,0 +1,5 @@
	+include.path::
	+includeIf.<condition>.path::
	+	Special variables to include other configuration files. See
	+	the "CONFIGURATION FILE" section in the main
	+	linkgit:git-config[1] documentation.

If you're willing to make this your first patch to git.git that would be
great:) I think this with something to give it basic test coverage would
be nice, you could use these tests as a template:
	
	$ git grep 'git config' -- t/t9902-completion.sh
	t/t9902-completion.sh:test_expect_success 'git config - section' '
	t/t9902-completion.sh:  test_completion "git config br" <<-\EOF
	t/t9902-completion.sh:test_expect_success 'git config - variable name' '
	t/t9902-completion.sh:  test_completion "git config log.d" <<-\EOF
	t/t9902-completion.sh:test_expect_success 'git config - value' '
	t/t9902-completion.sh:  test_completion "git config color.pager " <<-\EOF

