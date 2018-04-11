Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EE1D1F424
	for <e@80x24.org>; Wed, 11 Apr 2018 07:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbeDKHOz (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 03:14:55 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:44509 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbeDKHOx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 03:14:53 -0400
Received: by mail-wr0-f179.google.com with SMTP id u46so657916wrc.11
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 00:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ubGYZYmduRc7IpoUan/fNnJerGfz8h5HlG80PVkn8Xs=;
        b=DDUV3Nv8hZKOoUG5t9MbCu06E8lwBhO6pYq3LOgtJx6xSNbDbRXrs1WdlP3SJsTgZi
         N77W1WGGMpcn4t8C5QRB6z/AOYbGcYVTZC5rG10okBbsMRAvWeXO+DQu4aZsRV2edirA
         i4mS9XbbNJcW7bLH84Pz/EhGsbkd4UkYWo89IALBcLR/WaCfApEu2EXSnYSFY9ytB8HL
         sf0PQnU986q7cZA05uPR+sp0PyyBogNnj5YaJSetWktT4rCuCqShLyS4dUPj9L4uVyaJ
         lajmdY6AWOWKuKV9RmMHmfZi6RQhlvPIm0LUYvTY/qATc4aIkRWkHIfyxmIenKk9o5X2
         ZVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ubGYZYmduRc7IpoUan/fNnJerGfz8h5HlG80PVkn8Xs=;
        b=ZgZ+Le16XVLXfBxl3HE6hWHNwo9jsC/NStlJ2KFowpRK0TEhRIChdSWRHGqbgJdNk2
         65jPEVxkb58ksPHhMjBGZzKY9VQeZ3TLL88N0h1b16CXvFx6UnPOJd7qJjBhy4aI5bv9
         YUiLfwu6ZTuE29bFcdJ2L9nTCU6pdLVZ1hmB8Vek2rguQZDftMtV42HDj2FVjxSfENz0
         H09ThEz0REjJwCDeSyw2iWzXncHtD41MSva3d6/qX0xwKDNzRSNHiyYf8Pz16DYHdog1
         wFM6nsy872s5tHrNs/av61Tt9dywT5UvPv6EjdNY9ZsCF0cnfRFaegn6Z+Dxqk663Zo4
         d3EA==
X-Gm-Message-State: ALQs6tB6Elxxk6s5sqQmaftrOCFia9cc/NqgOK8+tUa2AEwB+Mi7A/hW
        71tQGDU3LNG2PaQ/iH8jW/XSabNG
X-Google-Smtp-Source: AIpwx48TFTi+gcSiR0wPp+guPTQ1vZHslHVssu524NbXrT0lJ/KV9cqQJpi8edrwCaYfjE02BxjBmw==
X-Received: by 10.223.132.229 with SMTP id 92mr1448692wrg.46.1523430892539;
        Wed, 11 Apr 2018 00:14:52 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id n8sm475565wrh.51.2018.04.11.00.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 00:14:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dan Jacques <dnj@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v8 0/5] RUNTIME_PREFIX relocatable Git
References: <20180410150546.38062-1-dnj@google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180410150546.38062-1-dnj@google.com>
Date:   Wed, 11 Apr 2018 09:14:50 +0200
Message-ID: <87k1teb4et.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 10 2018, Dan Jacques wrote:

> This is a minor update based on comments from the v6 series.
> I'm hoping this set is good to go!

This looks to me. Thanks!

> - Rebased on top of "master".

Probably useful for others to have the interdiff between this and
v7. Here it is:
    
    $ git tbdiff origin/master b329fde5a6 2b1ed6a79a
    1: 776c7d6083 = 1: 4943ec6581 Makefile: generate Perl header from template file
    2: 0cded81572 ! 2: 29223250da Makefile: add Perl runtime prefix support
        @@ -52,10 +52,9 @@
    
          prefix = $(HOME)
         @@
        - 
          mandir_relative = $(patsubst $(prefix)/%,%,$(mandir))
          infodir_relative = $(patsubst $(prefix)/%,%,$(infodir))
        -+gitexecdir_relative = $(patsubst $(prefix)/%,%,$(gitexecdir))
        + gitexecdir_relative = $(patsubst $(prefix)/%,%,$(gitexecdir))
         +localedir_relative = $(patsubst $(prefix)/%,%,$(localedir))
          htmldir_relative = $(patsubst $(prefix)/%,%,$(htmldir))
         +perllibdir_relative = $(patsubst $(prefix)/%,%,$(perllibdir))
        @@ -68,7 +67,7 @@
          localedir_SQ = $(subst ','\'',$(localedir))
         +localedir_relative_SQ = $(subst ','\'',$(localedir_relative))
          gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
        -+gitexecdir_relative_SQ = $(subst ','\'',$(gitexecdir_relative))
        + gitexecdir_relative_SQ = $(subst ','\'',$(gitexecdir_relative))
          template_dir_SQ = $(subst ','\'',$(template_dir))
          htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
          prefix_SQ = $(subst ','\'',$(prefix))
    3: a0e41f5f41 ! 3: 5220baf80e exec_cmd: RUNTIME_PREFIX on some POSIX systems
        @@ -109,6 +109,8 @@
         +  
            git_setup_gettext();
    
        +   initialize_the_repository();
        + 
            attr_start();
    
         -  git_extract_argv0_path(argv[0]);
    4: b25be6e56d = 4: 57dcc5203e exec_cmd: provide a new-style RUNTIME_PREFIX helper for Windows
    5: b329fde5a6 = 5: 2b1ed6a79a mingw/msvc: use the new-style RUNTIME_PREFIX helper
