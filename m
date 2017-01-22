Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A0892092F
	for <e@80x24.org>; Sun, 22 Jan 2017 22:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750736AbdAVW5r (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 17:57:47 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34376 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbdAVW5r (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 17:57:47 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so22062139wmi.1
        for <git@vger.kernel.org>; Sun, 22 Jan 2017 14:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BypK0mApzxSk4HS8HVsc/Dpm7YMxc4gA2tnaSLfQy1Q=;
        b=C/F8umu+BSEF7sAyaUEEPEWmCO7XrmWWxe6QadRNO6BmMf4aSX9Ljs1dkaUgxTRfd4
         3UY+/LR0P4M8SAQAXXlbY7cKRHCdfNE0hMPf7q8qHjDgIRByogR1ym1qXPcHLpJp0jxq
         9e7mGnkf0xSZM45LbJ+GIJySFD33S6ewaCj2YLM6GboJ4Z3Qd7O5ynw/MGOhyaUWNQHX
         in+mWrqUWbFgOuzEDOEhYqDojF1737mRA6p6whhvr7S+trcSNSp7ot+xQU2y5GtVoOFM
         EEgTd3nzOEpo2FgUrpMBSK1vf2CIPvmSTg8cfvy9l980zzA7PJwlnNGGJzGucyGvxyhu
         Wcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BypK0mApzxSk4HS8HVsc/Dpm7YMxc4gA2tnaSLfQy1Q=;
        b=nKrtTMG12k5iEkBJL/MDshVuyTe6WUoE1noSvv9+AtCzA/QMgh4sPB6Km72nA41V9b
         1xe19PsVlUbiPpoqbwfllZ0Vi4wyjdJpqYd5yfpz/WUQw0uxFK7bL7OsE4opBfz9ms+A
         iK4GGBv43jUABTWKbhY/jwz1Py31wUl+n/J9veY31hMO/YvCPYLc+bdPG/pSzdL9CJsH
         sbqEGstyrZyg13+k9d+rXliSG1THJY3bztQfhSu4eaVvrjRSu+FYfF7dMjUmPa8nKAsp
         xkx5aKwgAobc6Eo7uhWGR3S0h9Er16KPWrp8TQGnKo8LGI6R/F9wPoNXf3q9FvLK5nZE
         OUTg==
X-Gm-Message-State: AIkVDXIOQPRUPOaOwSVMykZxcDSFTN/wwP9efAMPKU89XrwSTAWkpXELz8cO+T6/z72TzQ==
X-Received: by 10.28.150.202 with SMTP id y193mr11979909wmd.106.1485125865798;
        Sun, 22 Jan 2017 14:57:45 -0800 (PST)
Received: from localhost.localdomain ([2001:a62:fb:5c01:efe0:5d69:845c:6e94])
        by smtp.gmail.com with ESMTPSA id v201sm6468545wmv.4.2017.01.22.14.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jan 2017 14:57:44 -0800 (PST)
From:   bitte.keine.werbung.einwerfen@googlemail.com
X-Google-Original-From: cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     thomas.braun@virtuell-zuhause.de, szeder@ira.uka.de,
        john@keeping.me.uk, Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH 0/7] completion bash: add more options and commands
Date:   Sun, 22 Jan 2017 23:57:17 +0100
Message-Id: <20170122225724.19360-1-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

The cli interface for git has the greatest versatility of all git tools.
Its productivity depends on how easy it is to type commands and to remember
options. The command line completion helps two-fold by easing input and
displaying possible options.

Bash completion lacks support for several options and some useful commands.
Although the selection of recognized options is always opinionated (e.g. the
documentation for git-completion.bash says that 'common' long options are
recognized), I think that extending the cli completion will always increase the
productivity.

To that end, the following commits add completion support for several existing
options and subcommands. For every command all options that are mentioned in
the introduction of its man page should now be available for completion.

Cornelius Weig (7):
  completion: teach options to submodule subcommands
  completion: add subcommand completion for rerere
  completion: improve bash completion for git-add
  completion: teach ls-remote to complete options
  completion: teach replace to complete options
  completion: teach remote subcommands option completion
  completion: recognize more long-options

 contrib/completion/git-completion.bash | 132 +++++++++++++++++++++++++++------
 1 file changed, 110 insertions(+), 22 deletions(-)

-- 
2.10.2

