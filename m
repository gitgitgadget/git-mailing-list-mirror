Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB43A1F42D
	for <e@80x24.org>; Thu, 26 Apr 2018 17:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756879AbeDZRyI (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 13:54:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54147 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756433AbeDZRyH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 13:54:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id 66so14365935wmd.3
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 10:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MJqnBWTNuizux4LBk7MabSKYQ7pbG/0jmuSasEY/kJ8=;
        b=gFx5YTYu0hjDjdZrQYzAU325CT5rueHzCmkOPdmm5umIvJ+KlATiknkzyw5s/+QANS
         oo4jmER6jOPRYrq5HwonnyP+xjrfQD9dH4UWxasZGAtjR519CjIz/bb7MZwqczYPuMj+
         J4ir12EFRAVnuaMCC3Ec2yiFkHfYIxA1ufd+y++FxQZL5UrN1J24Ai/aRngBPb/Zbe+M
         NiLVnsujsbuboHIKN0EEPHlLzZgehIjUKgmzSJX1rqbm8LV7LF5cuCLWarjsNet0dnq+
         dLAt86oX386EILk1bnTGGpxOA5k1XADEoA9PtqUM3vYccqrWz/jDo4r+F0wY4zku92tA
         TnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MJqnBWTNuizux4LBk7MabSKYQ7pbG/0jmuSasEY/kJ8=;
        b=qh2SFOEnfGA2ggiWzIIvAt8j+uh+6YACVBLjpyo4h6ifj9GxvAG9w/d8WKCXGrCEpi
         nb2mCk/pk2fr4Rqq2WS0qWZPiNFiOfW73Gvd5Yy4L8UH9KveOR0Jmx36eK2NP8a8vKiU
         xQahBst8H8L2EkQCNwisFc55qQXoclmnJS80OFuYGSopxYhI5jdgeuzU7BmHSlItU3Gk
         tZtfKc/7hPyFajezeg7gdvEgqvCAKUXYwGZFeIWby8vc8iDSMasq3qr8Ka0fapzqIUhU
         M8HekLlzsuJIqr9FoN4+CpmwCeikYoxhOszi3HhGKE4VK5dF3W+lDeSZGEYLz8Gtrok0
         Qthg==
X-Gm-Message-State: ALQs6tBM4dqaduwhsA3zSRRvRLaHz1EcGXyoH9+H22jWSaKt9bkRku2A
        B02LAWaEP3s0ThwbJpg0BsA=
X-Google-Smtp-Source: AIpwx48hI7NLdcWOhrhtml01ksWm68hFr19tgrbZSU43IeCUjNSLfjrXvJ+TMzXe++AKfeFe2tIG5Q==
X-Received: by 10.28.153.213 with SMTP id b204mr20527212wme.79.1524765246641;
        Thu, 26 Apr 2018 10:54:06 -0700 (PDT)
Received: from localhost.localdomain (x4db25ab2.dyn.telefonica.de. [77.178.90.178])
        by smtp.gmail.com with ESMTPSA id w40-v6sm28958595wrc.69.2018.04.26.10.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Apr 2018 10:54:06 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
Date:   Thu, 26 Apr 2018 19:53:58 +0200
Message-Id: <20180426175358.15495-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.551.g86756ed296
In-Reply-To: <20180426171540.GA2037@duynguyen.home>
References: <20180413170129.15310-1-mgorny@gentoo.org> <robbat2-20180423T200557-844830385Z@orbis-terrarum.net> <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com> <871sf3el01.fsf@evledraar.gmail.com> <20180426171540.GA2037@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, Apr 25, 2018 at 10:41:18AM +0200, Ævar Arnfjörð Bjarmason wrote:
> >  2. Add some config so we can have hook search paths, and ship with a
> >     default search path for hooks shipped with git.
> 
> I would go for something like this instead of search paths. This
> allows you to specify a path to any specific hook in hooks.* config
> group. This is basically "$GIT_DIR/hooks directory in config file" but
> with lower priority than those in $GIT_DIR/hooks.
> 
> Now we can do something like
> 
> 
>     git -c hooks.post-checkout=/path/to/some/script clone ...
> 
> but of course I would need to fix the FIXME or this hook config is
> only effective just this one time. (And of course you could put it in
> ~/.gitconfig)
> 
> -- 8< --
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 7df5932b85..143413ed2d 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1063,6 +1063,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
>  	}
>  
> +	/*
> +	 * FIXME: we should keep all custom config settings via
> +	 * "git  -c ..." in $GIT_DIR/config.
> +	 */
> +

We definitely should not, see the difference between 'git -c ... clone
url' and 'git clone -c ... url'

BTW, wouldn't running

  git clone --template=/path/to/template/dir/with/hooks/

invoke the post-checkout hook in there?

