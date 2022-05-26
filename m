Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC810C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 18:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344343AbiEZS5w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 14:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239737AbiEZS5v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 14:57:51 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6443712D09
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:57:50 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id rs12so4597837ejb.13
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=X9CEl+JxgKG3/v7YfhWD+OZ1s3sufqFJ73bp6LTH5Oo=;
        b=LN1/LqdiBm+RT97QUg7QYi+Uzs4sJwhZHnvnSPyK+zaZPIHUPhlZOJylNnjhcrUTHX
         VnTEyjTqhJJ2wocecxKE/IJxl3S/oMt1SPHlP7404NcVkk2s/IRk6bi2DAOQPuz4ASVU
         L+LSSCKrNwnvqZHudrMK7Fef4Jh2zfi8fdX4G5p1RC6MnabMJJzyOWUowiZw3Y/iMGqi
         Ru5oXc0KpuPGmxl0LsCyP4IY+LWjeIfgSHRs8cdQp2RFi2eNqkX1I7gkHhg7Gv4zGbM+
         NENerUkQ5dMcqXwKdrMpsFBJVtWPgLlf7tnoY8m88tlDEOXreAqy425gad2FSjp4qFNT
         7zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=X9CEl+JxgKG3/v7YfhWD+OZ1s3sufqFJ73bp6LTH5Oo=;
        b=E9YnBo7K4Yrqlgicf2gGwrHiydqZeGD4Gje1lRmEBX8jgTrRxV20EE7UM37MACPDzN
         lphdYFFnHPpXioXY9e7sv+bMQf3qJBeAPAiJHcKD3v4U2ROhhTaciDFt/HrVc6wpmHZk
         tkSdeWHRDQkf51+OBNa+TtmULf+MZRvix4mbKsByTsKy2MHOXjtzidoQOJn6YvGJe5Sr
         k8BgRp0UgQ/xKLoVemfmwzeJ0pffHZLihtXGhmpHc5AKan4za6JUl/j9qd3oJxck3Oiy
         yW45FQz6/4Qm8skPb9Ntb4Lbpcm9+bUUh8jlZpgipMmBzzMriYq9kor9V23Ahvrl4R16
         TEDg==
X-Gm-Message-State: AOAM530i6abnK77fhp6fyv7zNiWtTGezvD/Uluhh2mvq5yoKj6Ft95yj
        ZzMJnCDakx7daUhVpUbavKg=
X-Google-Smtp-Source: ABdhPJzL2JaiQ4suWslWu1FRrD3wRVPbzLuURlgBum9lzFdlhnQti+JeVFJ1QGpNLyhp9gfyhGcS9w==
X-Received: by 2002:a17:907:72ca:b0:6fe:fec2:935 with SMTP id du10-20020a17090772ca00b006fefec20935mr15202013ejc.515.1653591468904;
        Thu, 26 May 2022 11:57:48 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id v27-20020a50d59b000000b0042aae307407sm1086866edi.21.2022.05.26.11.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:57:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuIg7-000Fyw-Ns;
        Thu, 26 May 2022 20:57:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
Subject: jx/l10n-workflow-change (was: What's cooking in git.git (May 2022,
 #07; Wed, 25))
Date:   Thu, 26 May 2022 20:57:07 +0200
References: <xmqqzgj41ya2.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqzgj41ya2.fsf@gitster.g>
Message-ID: <220526.86mtf43yvo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, Junio C Hamano wrote:

> * jx/l10n-workflow-change (2022-05-23) 8 commits
>  - l10n: Document the new l10n workflow
>  - Makefile: add "po-init" rule to initialize po/XX.po
>  - Makefile: add "po-update" rule to update po/XX.po
>  - po/git.pot: don't check in result of "make pot"
>  - i18n CI: stop allowing non-ASCII source messages in po/git.pot
>  - Makefile: have "make pot" not "reset --hard"
>  - Makefile: generate "po/git.pot" from stable LOCALIZED_C
>  - Makefile: sort "po/git.pot" by file location
>
>  A workflow change for translators are being proposed.
>
>  Will merge to 'next'?
>  source: <20220523012531.4505-1-worldhello.net@gmail.com>

I'm happy with the current (posted today) version of it, and think it
should advance.
